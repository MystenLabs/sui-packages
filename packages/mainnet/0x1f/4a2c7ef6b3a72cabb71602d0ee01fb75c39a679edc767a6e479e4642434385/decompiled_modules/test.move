module 0x1f4a2c7ef6b3a72cabb71602d0ee01fb75c39a679edc767a6e479e4642434385::test {
    struct TEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x5f01358a165203a8e94970aacc3685ff776748f526ee813d91f3065b9a7648ba::bonding_curve::create_bonding_curve_v2<TEST>(arg0, b"TEST", b"Token", b"desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmY7wWBu3QAPTQHRMRsFTL2VsWpe3pSr8QuAfjWqM3Kgve")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00e0d5ea15f1ba42497083f06cd2d00b2c5ef93ef59775e99bd6ec5c8179f291194a630fdf52155d1a2a64a5d9521d1f2619f80398097c0aee225f7f75b318a90f5df9c702b23f19d3ff1dd6d6641a723115de2cdaf7e63f882dc2db80ee3217771747910757"), arg1);
        0x2::transfer::public_transfer<0x5f01358a165203a8e94970aacc3685ff776748f526ee813d91f3065b9a7648ba::bonding_curve::BondingCurveStartCapV2>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

