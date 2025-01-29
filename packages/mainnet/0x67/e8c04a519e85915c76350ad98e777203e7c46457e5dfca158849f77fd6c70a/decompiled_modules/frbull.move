module 0x67e8c04a519e85915c76350ad98e777203e7c46457e5dfca158849f77fd6c70a::frbull {
    struct FRBULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRBULL, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::BondingCurveStartCap<FRBULL>>(0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::create_bonding_curve<FRBULL>(arg0, b"FRBULL", b"Frenchie", b"Frencie is a meme token inspired by the charm and playfulness of French Bulldogs, built for fun, community engagement, and viral potential", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pumpfun-indexer.s3.eu-west-1.amazonaws.com/icon/81cbb65b-9c1f-424a-a47a-593a242c0296")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0054b3a8dbfdcdeb4d4b5faefcbc3b97e48e619e0f3893560020301e7028f0e4aa30a3a4de5b3d751ad9d4eefa264d1c4606377e9ca502101d7fcc39bceaaf7f07f5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631738170176"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

