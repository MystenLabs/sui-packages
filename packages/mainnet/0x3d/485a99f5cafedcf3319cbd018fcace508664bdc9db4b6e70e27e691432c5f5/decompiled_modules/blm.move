module 0x3d485a99f5cafedcf3319cbd018fcace508664bdc9db4b6e70e27e691432c5f5::blm {
    struct BLM has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve_v2<BLM>(arg0, b"BLM", b"Brazilian", b"Brazilian Language Model", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmRtjPS9i5iMwDQrSihvFhtZTpHNFXPH1Lb15CRxi7ndkK")), b"WEBSITE", b"https://x.com/itztwizz_", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"000501bb7ce3df697bc9fb7f97a7b9a93e0da07e47a5a4701cf71c0d1c61a1c2c0dfd99b3b902ce1bbd12f3a0ddd54377bfcf50b2a30e298cf4e42dbfbe5885d08d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1757062082"), arg1);
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCapV2>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLM>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

