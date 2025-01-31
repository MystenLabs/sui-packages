module 0xd0b1f6263b0ef0f044e2f8a9a2e4fca226114a662abd8811a96be4e2003607d0::frbull {
    struct FRBULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRBULL, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::BondingCurveStartCap<FRBULL>>(0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::create_bonding_curve<FRBULL>(arg0, b"FRBULL", b"Frenchie", b"Frencie is a meme token inspired by the charm and playfulness of French Bulldogs, built for fun, community engagement, and viral potential.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pumpfun-indexer.s3.eu-west-1.amazonaws.com/icon/0b02f94e-82fc-4b1c-ade5-14894f496b95")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0082e2117c66607e25996e4a9e513e139437113c8b0749aaeb38650c52326e0abbaf19d1410bbcff6ee713bfbeb849ad252d5fe3eb0c035e49d5bd979870e06500f5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631738316005"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

