module 0xa78583c8febc8f417962b7410986b73afab9bf758296fdcb88b4bdcb1e56b987::grg {
    struct GRG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRG, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::BondingCurveStartCap<GRG>>(0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::create_bonding_curve<GRG>(arg0, b"GRG", b"Growth Group", b"MEME Growth Group", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pumpfun-indexer.s3.eu-west-1.amazonaws.com/icon/f1b1e52e-eaa5-427a-ae64-6414c267eb4d")), b"https://www.spacex.com/", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0074247a2bd420ca15b1257f0d1c4d9da5de6684d531ab34dbf1219d045a81a359e39bb5185523c45181740bb0130cc31730a685f0f7604e0d5275fbf40d764e08f5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631736967536"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

