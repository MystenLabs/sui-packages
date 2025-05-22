module 0xb0a927aef0cb08eb826653c40e1c030577215198441a8e301b87d1407778232f::tt2434 {
    struct TT2434 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TT2434, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x5f01358a165203a8e94970aacc3685ff776748f526ee813d91f3065b9a7648ba::bonding_curve::create_bonding_curve_v2<TT2434>(arg0, b"TT2434", b"Token", b"desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmY7wWBu3QAPTQHRMRsFTL2VsWpe3pSr8QuAfjWqM3Kgve")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0044962b1616b959c048c42e7c8f457bdb810b5879310ce28e989db41495a8099723c580c67cabe1534fbf1e0cccc24a7457b2781ea6654940acfbba2d706f150c5df9c702b23f19d3ff1dd6d6641a723115de2cdaf7e63f882dc2db80ee3217771747909328"), arg1);
        0x2::transfer::public_transfer<0x5f01358a165203a8e94970aacc3685ff776748f526ee813d91f3065b9a7648ba::bonding_curve::BondingCurveStartCapV2>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TT2434>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

