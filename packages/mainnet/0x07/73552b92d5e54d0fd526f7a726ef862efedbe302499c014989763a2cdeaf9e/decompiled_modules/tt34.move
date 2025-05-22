module 0x773552b92d5e54d0fd526f7a726ef862efedbe302499c014989763a2cdeaf9e::tt34 {
    struct TT34 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TT34, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x5f01358a165203a8e94970aacc3685ff776748f526ee813d91f3065b9a7648ba::bonding_curve::BondingCurveStartCap<TT34>>(0x5f01358a165203a8e94970aacc3685ff776748f526ee813d91f3065b9a7648ba::bonding_curve::create_bonding_curve<TT34>(arg0, b"TT34", b"Token", b"desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmY7wWBu3QAPTQHRMRsFTL2VsWpe3pSr8QuAfjWqM3Kgve")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00f87e87478a7f1de01cfbcddd97272794311652ae2fb956cd675035c781c46e46d0e91e3cdb511d0acfe8cdcf2c2ed57a6a8d50c00ba274c9d0dec9221599fb035df9c702b23f19d3ff1dd6d6641a723115de2cdaf7e63f882dc2db80ee3217771747905568"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

