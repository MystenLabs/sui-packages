module 0x8641f287b8b0f9a1cf9d79aa0450698e1ee24b4349ae8730072bc1490c0671ac::tt1 {
    struct TT1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TT1, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::BondingCurveStartCap<TT1>>(0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::create_bonding_curve<TT1>(arg0, b"TT1", b"Token", b"desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pumpfun-indexer.s3.eu-west-1.amazonaws.com/icon/1c5cf07f-07f1-4f36-a51e-c4a0d671baa4")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00b24224c3b955588de7d0d7d48ed516a74dd8a42ea8901bfa3898c7481e3455ca54a34059819a73c2902042504c5484da6fa7589d4fe8c906b21746a6f979540c4f82611d9e866a8067413980263454f7cf15e31fe03369ae5429340e5580457c1736846095"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

