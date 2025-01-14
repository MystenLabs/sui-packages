module 0xc955e4909d20850eecbaaa917a66d0d0af7aed7715d43aa1fb5a7cfc24426d3::tt {
    struct TT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::BondingCurveStartCap<TT>>(0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::create_bonding_curve<TT>(arg0, b"TT", b"Token", b"test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pumpfun-indexer.s3.eu-west-1.amazonaws.com/icon/21abfec1-c735-47b4-9335-e35cd7f3a536")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00880d4601e8983cba843283fefc414d85f37f37c121bd8a8bf362daff0fa31d8682e91e0d7bd3ec87762b3068ef62b2a56e1ae4c4fb0241237689f727408e64044f82611d9e866a8067413980263454f7cf15e31fe03369ae5429340e5580457c1736844981"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

