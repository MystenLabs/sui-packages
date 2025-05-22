module 0x18114fb98176a73501498d22406c6d81c3672de2186a097863e546f649637c8d::tt {
    struct TT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x5f01358a165203a8e94970aacc3685ff776748f526ee813d91f3065b9a7648ba::bonding_curve::BondingCurveStartCap<TT>>(0x5f01358a165203a8e94970aacc3685ff776748f526ee813d91f3065b9a7648ba::bonding_curve::create_bonding_curve<TT>(arg0, b"TT", b"LedgerX", b"desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmY7wWBu3QAPTQHRMRsFTL2VsWpe3pSr8QuAfjWqM3Kgve")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00e7e225461ec0b99ad25d75338e3d52e1ae5ac73be89176d0a1102e2671bd43f7cb63f839676fed295be05b354180db49730be47b26a0bae58bc45357349c88085df9c702b23f19d3ff1dd6d6641a723115de2cdaf7e63f882dc2db80ee3217771747905450"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

