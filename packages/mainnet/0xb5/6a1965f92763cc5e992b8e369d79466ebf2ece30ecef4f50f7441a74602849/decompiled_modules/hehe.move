module 0xb56a1965f92763cc5e992b8e369d79466ebf2ece30ecef4f50f7441a74602849::hehe {
    struct HEHE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEHE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::BondingCurveStartCap<HEHE>>(0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::create_bonding_curve<HEHE>(arg0, b"HEHE", b"HeheCoin", b"sdasdasdasdas", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pumpfun-indexer.s3.eu-west-1.amazonaws.com/icon/6fd7cd55-bbb9-4efb-9106-bccb8d7b9b87")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0038858f79a233e3e5b42b5fbac1e7a5fdfcf20cc6fb66b339fbbec483a3456b9b6d8af20e1ae6f8e7255e24290fa50f2f32b77e10ad0f1390e388c778b271b803f5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631737920983"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

