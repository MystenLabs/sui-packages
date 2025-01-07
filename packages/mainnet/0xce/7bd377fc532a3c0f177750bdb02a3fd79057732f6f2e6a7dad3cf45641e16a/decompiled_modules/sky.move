module 0xce7bd377fc532a3c0f177750bdb02a3fd79057732f6f2e6a7dad3cf45641e16a::sky {
    struct SKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKY>(arg0, 6, b"SKY", b"SKYY", x"6d656d6520756e64657220636f6e737472756374696f6e2e0a43616e20796f7520747275737420616e64207075736820697420746f2074686520736b793f210a4c6574277320646f20697420746f676574686572210a54484520534b59204953204e4f54204c494d49540a0a7765622020746720205820202d20776f726b20696e2070726f67726573732021", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SKY_88f6785f28.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

