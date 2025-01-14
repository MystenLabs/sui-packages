module 0x73e7eba0af7a577e7027a980a077ca358481b8b49b63d7bea69610d1ad78309e::mars {
    struct MARS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARS, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::BondingCurveStartCap<MARS>>(0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::create_bonding_curve<MARS>(arg0, b"MARS", b"THE MARS", b"Join an epic meme token journey! The top 100 holders will earn tickets to Mars. To qualify, appear in at least 30 of 100 blockchain snapshots capturing token holder rankings. Stay active, support innovation, and become part of a community crypto enthusiast", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pumpfun-indexer.s3.eu-west-1.amazonaws.com/icon/7c4b328a-6b9f-49fd-abc5-0d597876a63b")), b"https://science.nasa.gov/mars/", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00c4650262a3d1848de686620e0c0a87d634ead5b0e0468e8267a5ec8524151232906b4d9becae6a3e48e9ce3a96cd7ed776da9dfb52353b152b1e37c2c0930f06f5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631736857202"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

