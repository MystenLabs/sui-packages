module 0x5f4838b40a17b70236f1d962c2c90c9c1d788fd49fb2d27673c2ef6997837c54::sun {
    struct SUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUN, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::BondingCurveStartCap<SUN>>(0x1508a7e1e1ba1092f71a285a8f058751e4809139627cf421f2f10a7f86086748::bonding_curve::create_bonding_curve<SUN>(arg0, b"SUN", b"White Sun", b"New White Sun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pumpfun-indexer.s3.eu-west-1.amazonaws.com/icon/2cb5d0a4-b1e5-4382-ab13-ae236ac3ee20")), b"https://science.nasa.gov/", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"006cb1735f0931ad0be3e6e9d7819ed0aeea29713ed275d6fc4bfe73af6eb1b6413e7efa8b5b49e0b10d79ca1f9b6945822343c98cf82140102906e722f61bc201f5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631736941103"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

