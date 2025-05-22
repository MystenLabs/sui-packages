module 0x56b258d870c06481a004866f9b45629777d5e8fcdff9f60d5c78315dc8a32f7d::new_t {
    struct NEW_T has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEW_T, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x5f01358a165203a8e94970aacc3685ff776748f526ee813d91f3065b9a7648ba::bonding_curve::create_bonding_curve_v2<NEW_T>(arg0, b"NEW_T", b"Token", b"desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmY7wWBu3QAPTQHRMRsFTL2VsWpe3pSr8QuAfjWqM3Kgve")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0089847698c967ce0181df278ff63a069451960c43c9a11e62fae738705364351d776af01a57fa9541a4f863da33ff49ef5c2c4efe0a702d0df99726d361f363005df9c702b23f19d3ff1dd6d6641a723115de2cdaf7e63f882dc2db80ee3217771747909243"), arg1);
        0x2::transfer::public_transfer<0x5f01358a165203a8e94970aacc3685ff776748f526ee813d91f3065b9a7648ba::bonding_curve::BondingCurveStartCapV2>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEW_T>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

