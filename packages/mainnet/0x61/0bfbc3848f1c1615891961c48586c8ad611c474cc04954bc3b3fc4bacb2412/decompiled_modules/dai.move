module 0x610bfbc3848f1c1615891961c48586c8ad611c474cc04954bc3b3fc4bacb2412::dai {
    struct DAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<DAI>(arg0, 6, 0x1::string::utf8(b"DAI"), 0x1::string::utf8(b"DeepBook AI"), 0x1::string::utf8(x"f09f9a80204e6578742d47656e2043727970746f2042726f777365720a42726f77736520746865204675747572650a6f662043727970746f20457870657269656e6365207365616d6c65737320446546692062726f7773696e6720776974682044656570626f6f6b202d2074686520666173746573742c206d6f7374207365637572652063727970746f2062726f77736572206275696c74"), 0x1::string::utf8(b"https://popularsui.xyz/media/54adbf9715afc2b0ec22a28f5bbe2ee810b99f054db3de112a9ae1eb3c72e7ad.webp"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAI>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<DAI>>(0x2::coin_registry::finalize<DAI>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

