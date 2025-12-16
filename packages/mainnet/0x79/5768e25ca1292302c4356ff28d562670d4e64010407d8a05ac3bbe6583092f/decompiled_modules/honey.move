module 0x795768e25ca1292302c4356ff28d562670d4e64010407d8a05ac3bbe6583092f::honey {
    struct HONEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HONEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<HONEY>(arg0, 6, 0x1::string::utf8(b"HONEY"), 0x1::string::utf8(b"HONEY"), 0x1::string::utf8(x"54686520636f6f7264696e6174696f6e20617373657420666f7220486f6e6579506c6179e28094747265617375726965732c2074617865732c206275796261636b732c20616e642075736572207265776172647320696e206f6e65206465666c6174696f6e61727920746f6b656e2e20f09f8fb4e2808de298a0efb88f"), 0x1::string::utf8(b"https://assets.honeyplay.ai/coins/honey.gif"), arg1);
        0x2::transfer::public_freeze_object<0x2::coin_registry::MetadataCap<HONEY>>(0x2::coin_registry::finalize<HONEY>(v0, arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HONEY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

