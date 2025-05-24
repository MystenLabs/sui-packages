module 0x821dffddf7b36b5b1501f1218e5eea1d28db885f34f7b1de6058ed935fcb9cbf::caven {
    struct CAVEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAVEN, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<CAVEN>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<CAVEN>(arg0, b"CAVEN", b"Cavenger", b"Crypto avengers meme token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmRP4FHkPQTVy5rKuF99fb5Kqf1BhXjvnmyc1iGepiyTLp")), b"https://linktr.ee/airdropavengers", b"https://x.com/Cryptoaveng", b"DISCORD", b"https://t.me/jsstudios360", 0x1::string::utf8(b"00adb20bed257afa1e86b091b95184c40d5aead782285f1e2dbb6b8d094af08ce48d226e2e6e4e6d036cfe167fe003377b83e96d65b90f6e6348c6548ed48fe903d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748067627"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

