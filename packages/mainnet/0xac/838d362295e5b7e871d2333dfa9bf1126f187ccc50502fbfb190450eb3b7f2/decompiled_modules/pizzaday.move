module 0xac838d362295e5b7e871d2333dfa9bf1126f187ccc50502fbfb190450eb3b7f2::pizzaday {
    struct PIZZADAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIZZADAY, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<PIZZADAY>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<PIZZADAY>(arg0, b"PIZZADAY", b"BTC Pizza Day", b"Buy your own pizza now.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmXv4mXwEExsmuvVmhC28vmCYCw56r7FpiwYUWLYaDjrfe")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"008bff2a1c86b1171d6c304621c86cfa5c0be989f22a1f43f4bc2e2acf351d24e3ceaa68b5590e86e09e2f620a3d824375c6c0ba906de1d2aa347f6ba869b66c05d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748133805"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

