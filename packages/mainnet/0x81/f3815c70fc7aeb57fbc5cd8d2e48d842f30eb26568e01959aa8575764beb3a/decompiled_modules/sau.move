module 0x81f3815c70fc7aeb57fbc5cd8d2e48d842f30eb26568e01959aa8575764beb3a::sau {
    struct SAU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAU, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::BondingCurveStartCap<SAU>>(0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::create_bonding_curve<SAU>(arg0, b"SAU", b"Sausage", b"The Sausage eat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pumpfun-indexer.s3.eu-west-1.amazonaws.com/icon/a53f3c97-be54-44fa-8f1b-7d655b44abbb")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"008d595ba34c2626fd567ed7eb8cc8a905254e827d55f019abc17858e35f8b2913c0187edbd57560b844a400bb7ad8bdd572a1e34190c6f833cb80b845813bae0df5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631737637222"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

