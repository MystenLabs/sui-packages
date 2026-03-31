module 0xdfe909cea004a0bd3ee00e2f9809335877b5a867718228890bf7fb45e539ee98::dark {
    struct DARK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DARK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf4054b4c967ea64173453f593a0ec98cb6aa351635cbc412f4fdf5f804bb98db::token_emitter::create_currency<DARK>(arg0, 6, b"DARK", b"Dark", b"", 0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRoIAAABXRUJQVlA4WAoAAAAQAAAAfwAAfwAAQUxQSBYAAAABDzD/EREahATEdNNFC5SI/k+Ald8DVlA4IEYAAABwBgCdASqAAIAAPm02mUmkIyKhIIgAgA2JaW7hdJAAT22IvEFRz2xF4gqOe2IvEFRz2xF4gqOe2IvEE2AA/v+VgAAAAAAA"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DARK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DARK>>(v1);
    }

    // decompiled from Move bytecode v6
}

