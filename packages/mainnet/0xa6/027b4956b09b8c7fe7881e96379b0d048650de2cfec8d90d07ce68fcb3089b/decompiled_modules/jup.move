module 0xa6027b4956b09b8c7fe7881e96379b0d048650de2cfec8d90d07ce68fcb3089b::jup {
    struct JUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUP, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::BondingCurveStartCap<JUP>>(0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::create_bonding_curve<JUP>(arg0, b"Jup", b"Jupiter", b"Jupiter MEME", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pumpfun-indexer.s3.eu-west-1.amazonaws.com/icon/c2343610-ca37-4ad4-97d3-42be454963ba")), b"https://science.nasa.gov/Jupiter/", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"002b5401d87d927f970be892fb373c7a8b4daf850e819ecfed351bee903e4c41ff403a5d50250f9eebaf8154fca5d354dbcca9dd1892d21623aa29a8204f92fc01f5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631736973040"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

