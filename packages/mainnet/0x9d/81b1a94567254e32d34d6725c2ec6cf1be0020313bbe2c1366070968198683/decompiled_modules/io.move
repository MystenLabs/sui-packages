module 0x9d81b1a94567254e32d34d6725c2ec6cf1be0020313bbe2c1366070968198683::io {
    struct IO has drop {
        dummy_field: bool,
    }

    fun init(arg0: IO, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::BondingCurveStartCap<IO>>(0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::create_bonding_curve<IO>(arg0, b"IO", b"TOKIO", b"Electric city system", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pumpfun-indexer.s3.eu-west-1.amazonaws.com/icon/d33b7e74-1ec8-4b8b-8b84-670d96a39504")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"007ddddc48f12239c950510949904ccc8c9310d52af52c69a05714916367e3bf59a847a62f83e70364f8ca13344c505d183261de8506cf2ede1db2b6b103079b0bf5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631737630872"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

