Shader "Unlit/DolphinShader"
{
    Properties
    {
        _MainTexture ("Main Texture", 2D) = "white" {}
        _Color ("Color", Color) = (1, 1, 1, 1)

        _DissolveTexture("Dissolve Texture", 2D) = "white" {}
        _DissolveAmount("Dissolve Amount", Range(0, 1)) = 1

        _ExtrudeAmount("Extrude Amount", Range(0.5, 5)) = 0.3
    }

    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma exclude_renderers gles xbox360 ps3
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
                float3 normal : NORMAL;
            };

            struct v2f
            {
                float4 position : SV_POSITION;
                float2 uv : TEXCOORD0;
            };

            sampler2D _MainTexture;
            float4 _Color;

            sampler2D _DissolveTexture;
            float _DissolveAmount;

            float _ExtrudeAmount;

            v2f vert (appdata IN)
            {
                v2f OUT;
                
                IN.vertex.xyz += IN.normal.xyz * _ExtrudeAmount * sin(_Time.y );

                OUT.position = UnityObjectToClipPos(IN.vertex);
                OUT.uv = IN.uv;

                return OUT;
            }

            fixed4 frag (v2f IN) : SV_Target
            {
                float4 textureColor = tex2D(_MainTexture, IN.uv);
                float4 dissolveColor = tex2D(_DissolveTexture, IN.uv);

                clip(dissolveColor.rgb - _DissolveAmount);

                return textureColor * _Color;
            }
            ENDCG
        }
    }
}
