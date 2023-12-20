using UnityEngine;

public class GerakObjek : MonoBehaviour
{
    public float movementSpeed = 5f;
    public float rotationSpeed = 90f;


    void Update()
    {
        float movementX = 0f;
        if (Input.GetKey(KeyCode.A))
            movementX = -1f;
        if (Input.GetKey(KeyCode.D))
            movementX = 1f;

        float movementY = 0f;
        if (Input.GetKey(KeyCode.S))
            movementY = -1f;
        if (Input.GetKey(KeyCode.W))
            movementY = 1f;

        float rotation = 0f;
        if (Input.GetKey(KeyCode.Q))
            rotation = -1f;
        if (Input.GetKey(KeyCode.E))
            rotation = 1f;

        Vector3 movement = new Vector3(movementX, 0f, movementY);

        transform.Translate(movement * movementSpeed * Time.deltaTime);
        transform.Rotate(Vector3.up, rotation * rotationSpeed * Time.deltaTime);
    }
}
