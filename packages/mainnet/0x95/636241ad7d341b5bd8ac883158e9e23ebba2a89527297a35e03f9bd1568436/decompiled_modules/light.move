module 0x95636241ad7d341b5bd8ac883158e9e23ebba2a89527297a35e03f9bd1568436::light {
    struct LIGHT has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIGHT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf4054b4c967ea64173453f593a0ec98cb6aa351635cbc412f4fdf5f804bb98db::token_emitter::create_currency<LIGHT>(arg0, 6, b"LIGHT", b"White light", b"", 0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRioDAABXRUJQVlA4WAoAAAAQAAAAfwAAfwAAQUxQSBcAAAABDzD/ERGCTNom/k33m4NBRP8ngGb+HgBWUDgg7AIAAHATAJ0BKoAAgAA+bTSXSKQioiEjErnIgA2JaQDUFm1xVANF8kR7Oywvt4wdG06suD9RgXltVuYGvS2GfLES/vM+4oE9j8gLTnhxkuk51ou5N9UkJZVFZyZ8eJKJ7AH1UYrFxAfk9YE8X9BptxwHNa9YZkx2dFw2oBMLsLujNENpEQhN5Rxlyh//7nfDBsTjMnE2Q4S3aM6s3GYgV4MuszvigYQAAP78ra+mxn/ZIbkMC7H9K3YZ7ybMn81dwNjr4ZWqn/mf6n7+5SkJ9UqwgaBmDAtjZ1keKoiz/taHg/95N5ZwsgmbUocH+ol2HxYfDPFni2o5ypTsgmjoHX54VeSjY14yBxin2QCx03/LlQGbNgb02/bWSJA6PkJPjAMTrwJ5B176EkIYj+/xwyX1fh/X2tj7vG0QIIe9n783CCExOkybiUqOhwzVQoZGDki1+RuOVuNhzldN1yOtWS7Y3xzug8gDdpPK5jjrqAasaSkX/uSBmyRaY+PSvht+9O7OcVl37Kv0Ine7Sri1QNADpZfWTPfUbC/oAL1p5moLyDixiuhi7orRkNJsSK2XxwgQE57Wur+K2vGzew3t+ibx+H9pTKW+e0oW5qfXIycw+rcCsHbQ6lmqeNhaZxnElBF4bIsjlmVRT9frvpPUEMC2YBafiPBYlNqTtFJPg35X9jD6hzlq/xwEfTxRRmd6bFv1fK6kgBa8Yqa4nt3Ts0aJkhpwI9vI3u4G4ulRhs2tCWZfXLYDxOrx3GzHAMEg0sdDU8tVUTNAmVrKiFQVfhYuKaFzmNcv1uTMKome5Q34z0+ghS2dT+JnbnnkWMGqFKZJ8/9WkEJS4PRNe2vRt/chJGLVrstKZdq55+qxfVi9905E7EAb3LUt1Rus0zdupqUxF2PG4FliwKU84SIFpJRn48DMYsLQVCwLSXZSvJueQZ2dPwtz3XJ4P7VKtYEIuNQqRWiVPU8RHJ0Vs7WkQzdvWoRZnQKZy5AYkQ4gAAA="), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIGHT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LIGHT>>(v1);
    }

    // decompiled from Move bytecode v6
}

