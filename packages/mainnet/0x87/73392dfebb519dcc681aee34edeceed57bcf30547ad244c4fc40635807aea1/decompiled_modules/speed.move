module 0x8773392dfebb519dcc681aee34edeceed57bcf30547ad244c4fc40635807aea1::speed {
    struct SPEED has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPEED, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SPEED>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SPEED>(arg0, b"SPEED", b"I SHOW SPEED", b"Speed is a man of culture", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmSUS6dApY76f2Bov6rW43Yc52UmFtwLFQgE6SKCFp4LdS")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"001bc2b672ee81c6ff07d0c4d9b124745e25062f5855556f81756ce918bfb0f2ae6481ceefa934bab8ed62a36e5bda3dfb6a25e40dcb0898be59254478e4f43106d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748050642"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

