module 0xf70e803192fb0430b5b53591a3848343c207dfe252c0c7e2a10c1d789ad8892f::pengu {
    struct PENGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENGU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENGU>(arg0, 6, b"PENGU", b"SuiPenguin", x"5375692050656e6775696e7320207c2054686520436f6f6c65737420576164646c65206f6e205375690a0a4275696c64696e6720636f6d6d756e6974792c20696e6e6f766174696f6e2c20616e64207669626573206f6e205375692e200a5374617920636f6f6c2c207374617920636f6e6e65637465642e202353756950656e6775696e732023576164646c654f6e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4287_a30ef810e4.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENGU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PENGU>>(v1);
    }

    // decompiled from Move bytecode v6
}

