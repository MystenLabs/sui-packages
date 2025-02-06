module 0x2aabdfa6255b090d43de344878a7f3067e8d5bb6e9d464df7b962fdef6155437::sun {
    struct SUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUN, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::BondingCurveStartCap<SUN>>(0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::create_bonding_curve<SUN>(arg0, b"Sun", b"White Sun", b"White Sun nova", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pumpfun-indexer.s3.eu-west-1.amazonaws.com/icon/d7979575-07a4-47ab-afa7-6d804748be78")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00285ee47695951808ea43010d2ccb70ca566082a336f17cd3bdaf4cda73c62907d92dde7faf5416a11cabe06b43ab497b358e6e8737d6ed882c97614532e81501f5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631738836079"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

