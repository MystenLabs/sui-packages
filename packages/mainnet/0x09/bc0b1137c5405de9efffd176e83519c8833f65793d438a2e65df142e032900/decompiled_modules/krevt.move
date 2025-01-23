module 0x9bc0b1137c5405de9efffd176e83519c8833f65793d438a2e65df142e032900::krevt {
    struct KREVT has drop {
        dummy_field: bool,
    }

    fun init(arg0: KREVT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::BondingCurveStartCap<KREVT>>(0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::create_bonding_curve<KREVT>(arg0, b"KREVT", b"Krevetes", b"Krevetes English school", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pumpfun-indexer.s3.eu-west-1.amazonaws.com/icon/2da02021-9d3a-4d20-9718-929549a88d6c")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0043d859b1f8280a8bcfa7ea9490ccd9da189c63101a481145769582cb9f7aade6d326475f2af9ec2cf1e58b548bd5d9e25f3c32ad76dfaecc00c4b299f14b2c00f5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631737637797"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

