module 0x4fb9f33f0b28603872a78fc2bdf31506789bde7c6872bc488bd61c7760bbfd3e::robot {
    struct ROBOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROBOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROBOT>(arg0, 6, b"ROBOT", b"ROBOT Musk", x"5465736c612070726f6475637420756e7665696c20696e206c657373207468616e20616e20686f75720a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202d2d456c6f6e204d75736b0a68747470733a2f2f782e636f6d2f656c6f6e6d75736b2f7374617475732f31383434353438323930363831313932383936", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Yeb_OREXEAARVN_7_b28128758c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROBOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROBOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

