module 0xde831ff48af27ec5ccff14fcdc6ec83c635637e830aa9012ea374d4016867131::squidgirl {
    struct SQUIDGIRL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUIDGIRL, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SQUIDGIRL>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SQUIDGIRL>(arg0, b"Squidgirl", b"Ikachan", b"Ikachan listening to metal music and looking at neon night city", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmfRzCh6ApZd3nQD6f6T8Zgcjgi4QocsoAmgFVPXf3QfRG")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"004d30c877ed8d83cf5350b520a7fa8042ca9b39ec6416f3103dca19ac0189f28019dca296935bcf24f965a71e4dd0f945aceacaccaf741eaa591bc5dfa6cc7f03d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748101420"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

