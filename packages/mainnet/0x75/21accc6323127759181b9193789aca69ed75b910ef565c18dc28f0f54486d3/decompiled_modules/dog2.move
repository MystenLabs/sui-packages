module 0x7521accc6323127759181b9193789aca69ed75b910ef565c18dc28f0f54486d3::dog2 {
    struct DOG2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOG2, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::BondingCurveStartCap<DOG2>>(0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::create_bonding_curve<DOG2>(arg0, b"DOG2", b"DOG Token", b"dog token desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pumpfun-indexer.s3.eu-west-1.amazonaws.com/icon/0272256d-2572-4bbc-9966-77f1a5cdedff")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00f9a6b58b39ccc68d8d0f85cf8ad7af5c3b7f3b9959dbfafa3053f18dc3c9a4ab2924b96d916aa2376064b635c691a714b3735fb1cca3bc347895f47c17f1920a45c0686f8ded97752b4cb01e61c128c3ef8887609d91c57b904300ccc450ecb41742188088"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

