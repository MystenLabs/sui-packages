module 0xd36fcade308799d91c65737c3f54266bb0a2b30dab3487fce78c0a0cbc4eba72::tenten {
    struct TENTEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TENTEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<TENTEN>(arg0, 6, 0x1::string::utf8(b"TENTEN"), 0x1::string::utf8(b"TENTEN"), 0x1::string::utf8(x"41207375727669766f72206f66207468652031302f3130206576656e740a0a4946594b594b0a0a4120636f696e207468617420726570726573656e7473207468652050545344206661636564206279207468652031302f3130206576656e742e204120636f696e207468617420697320666f722074686520636f6d6d756e6974792e204120636f696e20746861742072656d656d626572732074686520747261676963206576656e74207965742c2061207265616c69747920636865636b2074686174206f6620746865207468696e677320746861742063616e2068617070656e20696e2043727970746f2e"), 0x1::string::utf8(b"https://popularsui.xyz/media/5eb7137d68cc48a9534140da16f17f8b3ffe1ac6592d31777edd311a2513eafa.webp"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TENTEN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<TENTEN>>(0x2::coin_registry::finalize<TENTEN>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

