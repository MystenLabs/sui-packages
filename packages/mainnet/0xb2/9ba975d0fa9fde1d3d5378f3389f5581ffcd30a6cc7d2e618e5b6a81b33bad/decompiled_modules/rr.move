module 0xb29ba975d0fa9fde1d3d5378f3389f5581ffcd30a6cc7d2e618e5b6a81b33bad::rr {
    struct RR has drop {
        dummy_field: bool,
    }

    fun init(arg0: RR, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::BondingCurveStartCap<RR>>(0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::create_bonding_curve<RR>(arg0, b"RR", b"Rocket", b"desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pumpfun-indexer.s3.eu-west-1.amazonaws.com/icon/c37be7f1-788c-409a-aab4-54c2115c7d9e")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00cbd20d735618449e24e85fa63e41ec53a426e58b6fc822e04fa4acb42cb56faf36eb2a15264172da9d805988a8a2a122361416ab81424b09f4c8d6217768b402f5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631738228103"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

