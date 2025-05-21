module 0x36b61e92b6e48697785cf1be9a0b47a016f7d3b0519119522b6ff8b0cd8ddf9b::spla {
    struct SPLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPLA, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SPLA>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SPLA>(arg0, b"SPLA", b"SplushAngel", b"Meme token for Slush addicts", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmUgxhZMood5fgH1paBL5at1AQj8v1LTtwFnUu6aCTccCQ")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00ebe5f06968a37076f596a9b038c76879ea5590fa0ddf81575642a7041ef6f8a29442cbe413717d5c2ea15190e11be4c5a8908582947c07c84863e21b3e2fe60dd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747794042"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

