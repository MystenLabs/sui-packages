module 0x3804f7d6f7f39e97390c3c540cc38a9c9abd06cd79ced337265a79357a178e1d::trenchfi {
    struct TRENCHFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRENCHFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf4054b4c967ea64173453f593a0ec98cb6aa351635cbc412f4fdf5f804bb98db::token_emitter::create_currency<TRENCHFI>(arg0, 6, b"TRENCHFI", b"TRENCHFISUI", b"", 0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRlIAAABXRUJQVlA4IEYAAABwBgCdASqAAIAAPm02mUmkIyKhIIgAgA2JaW7hdJAAT22IvEFRz2xF4gqOe2IvEFRz2xF4gqOe2IvEE2AA/v+VgAAAAAAA"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRENCHFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRENCHFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

