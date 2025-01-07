module 0x14a8e4d2a9db5e8d33ebcf7ad73dd84d2499ba5d844e19f0816cf3266c00fe14::bloop {
    struct BLOOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLOOP>(arg0, 6, b"BLOOP", b"Bloop", x"426c6f6f702069732061207265766f6c7574696f6e61727920746f6b656e206275696c74206f6e2074686520535549206e6574776f726b2c20696e73706972656420627920746865206d7973746572696f757320736f756e642064657069637465642061732061206d6173736976652063726561747572652072756c696e6720746865206f6365616e730a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4074_0236def88b_7f7d12bba1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLOOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLOOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

