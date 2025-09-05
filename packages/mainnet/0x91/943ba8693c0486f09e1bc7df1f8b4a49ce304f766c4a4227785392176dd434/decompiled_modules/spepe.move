module 0x91943ba8693c0486f09e1bc7df1f8b4a49ce304f766c4a4227785392176dd434::spepe {
    struct SPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve_v2<SPEPE>(arg0, b"SPEPE", b"SPEPES", b"SPEPE MEME", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmepxRQYhwRrWUxn5Cg24LFtRFdS39HACeCtknp7cZp3hg")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00c9eaac3bf1953d145aaff7541cf059f06498b89ca1a23ac7881b21f52f50c00cdb3f58000d890ea3f8cbc2cac6db82095ebac58ecaedad4283ce9c412a2ba70fd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1757067493"), arg1);
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCapV2>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPEPE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

