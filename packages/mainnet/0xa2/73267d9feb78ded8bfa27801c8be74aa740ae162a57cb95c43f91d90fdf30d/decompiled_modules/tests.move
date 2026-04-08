module 0xa273267d9feb78ded8bfa27801c8be74aa740ae162a57cb95c43f91d90fdf30d::tests {
    struct TESTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf4054b4c967ea64173453f593a0ec98cb6aa351635cbc412f4fdf5f804bb98db::token_emitter::create_currency<TESTS>(arg0, 6, b"TESTS", b"Tests", b"", 0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRoIAAABXRUJQVlA4WAoAAAAQAAAAfwAAfwAAQUxQSBYAAAABDzD/EREahATEdNNFC5SI/k+Ald8DVlA4IEYAAABwBgCdASqAAIAAPm02mUmkIyKhIIgAgA2JaW7hdJAAT22IvEFRz2xF4gqOe2IvEFRz2xF4gqOe2IvEE2AA/v+VgAAAAAAA"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TESTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

