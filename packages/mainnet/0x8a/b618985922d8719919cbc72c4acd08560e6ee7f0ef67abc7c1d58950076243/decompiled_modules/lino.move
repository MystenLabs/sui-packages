module 0x8ab618985922d8719919cbc72c4acd08560e6ee7f0ef67abc7c1d58950076243::lino {
    struct LINO has drop {
        dummy_field: bool,
    }

    fun init(arg0: LINO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf4054b4c967ea64173453f593a0ec98cb6aa351635cbc412f4fdf5f804bb98db::token_emitter::create_currency<LINO>(arg0, 6, b"LINO", b"Lion", b"", 0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRoIAAABXRUJQVlA4WAoAAAAQAAAAfwAAfwAAQUxQSBYAAAABDzD/EREahATEdNNFC5SI/k+Ald8DVlA4IEYAAABwBgCdASqAAIAAPm02mUmkIyKhIIgAgA2JaW7hdJAAT22IvEFRz2xF4gqOe2IvEFRz2xF4gqOe2IvEE2AA/v+VgAAAAAAA"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LINO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LINO>>(v1);
    }

    // decompiled from Move bytecode v6
}

