module 0x6f9cea51079d7b164770d0dda6ee258dd80bda65774ea48ff52c2367c7e176dd::rock {
    struct ROCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROCK, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<ROCK>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<ROCK>(arg0, b"Rock", b"The Rock", b"Just meme token for rock, lfg!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmbMz2JM8SXZz1UWnn5JvFzbRkKAWsL7fhu6XEtvQnyLcQ")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"001683bae14a76c88aef08be822bf0dc28e8caaaa96680db5ac8ea134de5c4c54a19f358b7e44a5dac3ec51b7073a46244ff22fa7776e64a8b4eb942e17e8dc206d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748089203"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

