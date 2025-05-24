module 0xd8919576d5624f54b524af43488f703bda1a1617cc609fa793cffb58bf1f0c2b::hlth {
    struct HLTH has drop {
        dummy_field: bool,
    }

    fun init(arg0: HLTH, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<HLTH>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<HLTH>(arg0, b"HLTH", b"Health", b"Just a meme token for health", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/Qme3TbESVE4m5mQknynCpDw3m1xYnbtwViXqnCajfrheWC")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0027cd2796cabaab698c84f4fb769b46e65c92f37f094585201c10ad737cae61381721fe68c16acbec9661bb9780a8ff120cfe57a28e630ec6b7898a9c55d02d03d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748088945"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

