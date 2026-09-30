module 0x1924097723112f605686cfa4822763f34ec42313cf5adf058a4337d3cafbf5cf::mj {
    struct MJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: MJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<MJ>(arg0, 6, 0x1::string::utf8(b"MJ"), 0x1::string::utf8(b"Marijuana"), 0x1::string::utf8(x"4d6172696a75616e61202054686520477265656e657374204d656d65206f6e2053756920f09f8cbf0a426f726e20746f206368696c6c2c206275696c7420666f722074686520636f6d6d756e6974792e204d6172696a75616e61206272696e677320676f6f642076696265732c206d656d6520656e657267792c20616e64206120667265736820677265656e207761766520746f20746865205375692065636f73797374656d2e20f09f929af09f8cbf"), 0x1::string::utf8(b"https://popularsui.xyz/media/044d71a800c09a70b1b61914a16cd18d13d65e2a4ec0bc00f86b85d1da228dff.webp"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MJ>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<MJ>>(0x2::coin_registry::finalize<MJ>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

