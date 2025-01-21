module 0x7ca4ab41ddda8019a70f1e597403b56fd213f1faf0a4940613677772b57767d1::ring {
    struct RING has drop {
        dummy_field: bool,
    }

    fun init(arg0: RING, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::BondingCurveStartCap<RING>>(0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::create_bonding_curve<RING>(arg0, b"RING", b"DRUNK RING", b"DRUNK RING SYSTEM", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pumpfun-indexer.s3.eu-west-1.amazonaws.com/icon/2695567c-4ccf-44c4-ae61-69dc1edec2f2")), b"https://youtu.be/c-dqkLR6JEA?si=HNJKIdN5GWYLmvGw", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"008a9d4f6e0b9417210870812a03a6f7d1869e3b4103e1e4b3378b0f72a55126314c5410937c9852fc3d9431b7becb2fc019cd1a18dc6e149b725c08ea177b240af5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631737477266"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

