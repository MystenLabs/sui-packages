module 0x490cb271747f40ad8555220892873b01e48e3a7d9e1a221f83f7742e863206fc::eve {
    struct EVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: EVE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::BondingCurveStartCap<EVE>>(0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::create_bonding_curve<EVE>(arg0, b"EVE", b"Chill", b"Vibe and chill", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pumpfun-indexer.s3.eu-west-1.amazonaws.com/icon/bc60adc8-0fd0-4346-bb32-fa4224d1da1c")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00e492de8820e1f3c73e04635d4331cc7521374116015cc8b8a49436bcf41332264f74cea0b08b3fe5ea493edc065cbebf013154514dfc8e535574a704e37d3a03f5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631737974033"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

