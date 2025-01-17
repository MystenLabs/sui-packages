module 0x3c46025f6ead11ff4a91a70c3daae5de15ee0b1d87866d40f1aba64022644b5d::cat {
    struct CAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::BondingCurveStartCap<CAT>>(0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::create_bonding_curve<CAT>(arg0, b"CAT", b"CAT Token", b"cat token description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pumpfun-indexer.s3.eu-west-1.amazonaws.com/icon/0272256d-2572-4bbc-9966-77f1a5cdedff")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"007fa64c8c83be786fe48d3a1867f794f666d4bb2ae64d4af2f3069e4128e23284136b470293f532f2f1a7df2006f2492c855b2480a855597be982e2540925b90bf5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631737114920"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

