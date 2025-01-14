module 0x385590844d3b230ea4a6e3cd8b008e2cf0249ccecceae61e73bedd47e111c7c6::nn {
    struct NN has drop {
        dummy_field: bool,
    }

    fun init(arg0: NN, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::BondingCurveStartCap<NN>>(0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::create_bonding_curve<NN>(arg0, b"NN", b"NToken", b"desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pumpfun-indexer.s3.eu-west-1.amazonaws.com/icon/860d3b89-52d1-45ef-bbba-afe9190ae507")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"007c9069668fbeafbfe881ef936b8bab6a0c55a06927b51eb7796f7b5b189250da0c96f10d2e49be6d389cacaead5057d8ac260ea208293bb6a9608ab8875e3d0c4f82611d9e866a8067413980263454f7cf15e31fe03369ae5429340e5580457c1736845212"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

