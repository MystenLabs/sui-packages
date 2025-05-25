module 0xaf9f5e7f665af0fddbe5e2d4931cb09abd1994b6a03b13cb649a877f0df1c0ab::nim {
    struct NIM has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIM, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<NIM>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<NIM>(arg0, b"NIM", b"nima", b"THIS MAN IS THE BEST THATS ALL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmeFS78VzsCh1s3pNGXtnzKmte6z7J9aCdKwxcywKpmG9r")), b"nimakouba.shop", b"https://www.x.com/xxnimadzxx", b"https://discord.com/channels/xxnimadzxx", b"https://t.me/nima160", 0x1::string::utf8(b"00b4245c35266077a6dcf1d96129cb569693b508101a16862aca81b000bc1041b83b949857d7a38ac8ad48358b1e4d0c29d1d241992ed8838afe1b690623fa6803d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748199204"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

