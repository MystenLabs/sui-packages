module 0x9a2e82261419ca96c5d75e3b788d74e4e6b022ac6a57bf781a4badfbb4e2b6e7::lona {
    struct LONA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LONA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf4054b4c967ea64173453f593a0ec98cb6aa351635cbc412f4fdf5f804bb98db::token_emitter::create_currency<LONA>(arg0, 6, b"LONA", b"Lona", b"", 0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRoIAAABXRUJQVlA4WAoAAAAQAAAAfwAAfwAAQUxQSBYAAAABDzD/EREahATEdNNFC5SI/k+Ald8DVlA4IEYAAABwBgCdASqAAIAAPm02mUmkIyKhIIgAgA2JaW7hdJAAT22IvEFRz2xF4gqOe2IvEFRz2xF4gqOe2IvEE2AA/v+VgAAAAAAA"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LONA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LONA>>(v1);
    }

    // decompiled from Move bytecode v6
}

