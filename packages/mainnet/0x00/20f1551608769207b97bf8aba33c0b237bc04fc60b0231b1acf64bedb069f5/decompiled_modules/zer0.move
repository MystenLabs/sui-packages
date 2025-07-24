module 0x20f1551608769207b97bf8aba33c0b237bc04fc60b0231b1acf64bedb069f5::zer0 {
    struct ZER0 has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZER0, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf4054b4c967ea64173453f593a0ec98cb6aa351635cbc412f4fdf5f804bb98db::token_emitter::create_currency<ZER0>(arg0, 6, b"ZER0", b"ZERO COIN", b"", 0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRiAFAABXRUJQVlA4IBQFAACQIACdASqAAIAAPm0ukkWkIqGYuoUYQAbEoA1MXvXn5+ZxeQ905++Oht4Oeg86/fgG0iGWp5o5cGQZbPlYvEtAPPHvq4Z/+C3wE+bY5Tdiz5Kc3I4Imu+p5D1ZiZK6QSM6Vi5cnWyaH6PuaDiFl+nEk2mYscu8I6pnLNWHhjNoZ9sm6Kz8zVQuLsCF6T8FxryCgz869LHNG2sOZ/aMuEf2E7UMAkRFkVHR4hRRGOWdFdYbLAzDiE1HU9eka1VlElxpahhC4idwBKB/ZXfnyLJ2qYUfzDW4kYQwPXeJGoWUTt7AASpCAyn8i4cpGwHbRAf6l/YJyf6h1+UNHVbODNlhV0fY5gH4Tef/xRG4AAD+/PQAQz969GbogD50WF6nc61OMiEvl+2LnrHTc7aEGQqcXLvg7cOiXjVow2FPGAo1CMZK+twnWEfVAd8vYTQye5/CoG4F5A3bkyM4oiltUdPcmKruj5l1CK5jNIXshuHP2nLlwCEwU5r5O7lX4U+DDfTpVoQAASxlBjRAGwllIcTkLgDj4e89DnttgGl3YDj5qGfLeOzKZzu1uDOymi27ImMsDRdXq0CEK9ufyiHVnrG05/bL2EGrmR4l22GQU20RhKqYQcUVP2tX78DPsD8p4IRUJ/u2PQ7l6SsSB03hhdZ7SWXUT9uuoNDRx+2aWgsPqwOJFs9wJ5E7ii0EmKCtd6RDm6zvaRMNmtYlMUH5IT9yauywL0RePCeFZnxjwJOOiFZU+K+HX9YRjPNiSI42tcKoPLCoYS1qIU3yyJ/gLKDfwIhWJ1J6TADtya3PZMpIR5gyp1AiKzgq+00rEgQU7cOi+zyVytYVjTKYZwbtKtyTw0YSewRoKWzalKbqXXrCpXLJ1XnWVnu/dLYqYjKNZGZMdGHEa/luUvCIljKVNzwo9Qk46XFw3eTww+b6yaArCOGHlQCiqWmc4Ih7SqBTUjpdm8FnUqzNA+XdE3iIDIc43ZAPXJfz7EU7FooU3Oek/c/2HjCMfQJl7J1QbieTe7/2JaZBt5gc5H6V6XWqfyuZxmsHgX754UTJbRu8u1L05rsJ0ICD/lEX9wb2aCYM9LFo/qQ07rOY4c4iAURGuikbbZWjejO4V08yYDnbyWRewIWQM9vhHrumsvc+t/KMY7YzhZasijHzj/WP2YKAP1OJva85MKjp0bx+FhDQEmF1+z74Cy7lsMnpvt32j1KZe+LhfnCCUHCD2BObxQ2TE1rFlO+DMbRXpz7NJjskL72orQ+3CvHhPuh/ahTyzJ9otKFJfWIXHwNdXMThKzQ/4rMoiNFKcTSUE1s+DM6iOZXOuueH5Dcn79F9EOoPs1tznSIrrDH/azzU4TVFc3+94RT/N3HMiikULeIaZBwyB9j+qdBxmNQxbZFr7ui+xBExgUdlEkKNjijLKgM056lnnqTvNFDrvNmXFMGhEywPQmk3hMmIu5Zi2qf86d3Zbl31vE3+7jjk8/4cej0Q8dtg/21GyfH/6b4L0a/i5oANZPmwvrkKrew/x7+oIQ18DYEBZfkge1Tvse+mC4IVJXTUF8IbY7WcoRXlXFKQWZK5w4hyGW4dkuRe0cJNCEZ/Qq4beTZN39O9gyILR/uT1/mJMItnKAamn+DBT9IYLk2z0JkInZyixxUa0XNZjuzBDnpy192rneKY6icshBop8ULnLtsd92JKHMxRSCKEe/Dl8wAAkBjIIaivFuoMQZevJvcwHkgAAAAA"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZER0>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZER0>>(v1);
    }

    // decompiled from Move bytecode v6
}

