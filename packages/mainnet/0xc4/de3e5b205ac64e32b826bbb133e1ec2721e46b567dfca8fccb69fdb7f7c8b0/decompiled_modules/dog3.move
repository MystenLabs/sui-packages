module 0xc4de3e5b205ac64e32b826bbb133e1ec2721e46b567dfca8fccb69fdb7f7c8b0::dog3 {
    struct DOG3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOG3, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurveStartCap<DOG3>>(0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::create_bonding_curve<DOG3>(arg0, b"DOG3", b"DOG Token", b"dog token desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pumpfun-indexer.s3.eu-west-1.amazonaws.com/icon/0272256d-2572-4bbc-9966-77f1a5cdedff")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00f9a6b58b39ccc68d8d0f85cf8ad7af5c3b7f3b9959dbfafa3053f18dc3c9a4ab2924b96d916aa2376064b635c691a714b3735fb1cca3bc347895f47c17f1920a45c0686f8ded97752b4cb01e61c128c3ef8887609d91c57b904300ccc450ecb41743586901"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

