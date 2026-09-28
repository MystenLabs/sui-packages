module 0x12a991038244a0d6d6dc059c00234e4d8dcbb47aeccf5e2d0333075446c9cef1::munk {
    struct MUNK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUNK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<MUNK>(arg0, 6, 0x1::string::utf8(b"MUNK"), 0x1::string::utf8(b"SuiMunk"), 0x1::string::utf8(x"5375694d756e6b2028244d554e4b29206973206120636f6d6d756e6974792d64726976656e206d656d6520636f696e206275696c74206f6e207468652053756920626c6f636b636861696e2e0a426f726e20666f722074686520646567656e732c20647265616d6572732c20616e64206d656d65206c6f7665727320e28094205375694d756e6b20697320616c6c2061626f75742066756e2c20636f6d6d756e6974792c206d656d65732c20616e6420746865206a6f75726e657920746f20746865206d6f6f6e2e20f09f9a80f09f9092"), 0x1::string::utf8(b"https://popularsui.xyz/media/28c7f9889b6156890a74029c23c28f86dec205437829ad72ff2a2ff3b1a051af.webp"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUNK>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<MUNK>>(0x2::coin_registry::finalize<MUNK>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

