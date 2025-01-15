module 0xacf1a31b28977671d5af31e592da5ec4b29a35caff749bedbac05e8f5a3e4f6b::spc {
    struct SPC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPC, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::BondingCurveStartCap<SPC>>(0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::create_bonding_curve<SPC>(arg0, b"SPC", b"Space", b"The space", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pumpfun-indexer.s3.eu-west-1.amazonaws.com/icon/43e77982-73b3-46bb-8395-e0d1d6623b16")), b"https://science.nasa.gov/", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00390d29b01b8cabfa2465aa737c6066feb4be74314c323cf03c739eddc4e770a70d0a5389499a6682a1b7f6f0022629bf7968162725273643fd0e04c4ea10f10df5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631736966775"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

