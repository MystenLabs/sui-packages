module 0x3a7dc8adbd424ed11331a690b840ddeb14a7feaa6e0fde419d2fc6b9cf943131::chad {
    struct CHAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf4054b4c967ea64173453f593a0ec98cb6aa351635cbc412f4fdf5f804bb98db::token_emitter::create_currency<CHAD>(arg0, 6, b"CHAD", b"Chad", b"", 0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRlYBAABXRUJQVlA4WAoAAAAQAAAAfwAAfwAAQUxQSBgAAAABDzD/ERFCTdsGTPmTLoR9RPQ/IZ/3D/lWUDggGAEAALAKAJ0BKoAAgAA+bTSWSKQioiEkG/gogA2JaW7dJxHBss1+WJASAkBH6s2AxqAf7637LH63jb4Omtve1vpuz0TuMU1BkRb8SMi4se7Fvt42tRr8PUfll0A2zIRWBcAA/vv9UAwDpmgKZW5l88tZQ2SjIQ1GmQKl61g428SfCsN8sSLTn4RKoWuTaI6tV6FfbDrK3j5RFhKQrR4b4HYlo/sJYGzQ+Jex5zzeeeQRFG4FKnjRh6/ij8inXlvSoQ467ZAoTtp48uRqHHG2dk09K3KrqUxFRy43ofUTgipcFMmBxtt+CfZ6LP/WcAmmQkCUKs5sOvgyzF7B81oN7soBHiXBM0769jEGWOyqbZjFG3qkQvDYAAAAAAA="), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

