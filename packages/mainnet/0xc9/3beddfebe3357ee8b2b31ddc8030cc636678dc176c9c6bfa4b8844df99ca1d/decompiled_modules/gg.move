module 0xc93beddfebe3357ee8b2b31ddc8030cc636678dc176c9c6bfa4b8844df99ca1d::gg {
    struct GG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GG>(arg0, 6, b"GG", b"God and Guns", x"496e74726f647563696e6720476f6420616e642047756e7320284726472920436f696e2c206120756e697175652063727970746f63757272656e63792064657369676e656420746f206d65726765207468652076616c756573206f662066616974682c2066726565646f6d2c20616e642066696e616e6369616c20696e646570656e64656e63652e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/jesus_5_cc10453e29.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GG>>(v1);
    }

    // decompiled from Move bytecode v6
}

