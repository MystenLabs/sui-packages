module 0x7384866bb863bd46b8e5b93426874611b74768fdd6296f57d7edb42e75bfce3::tt {
    struct TT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x5f01358a165203a8e94970aacc3685ff776748f526ee813d91f3065b9a7648ba::bonding_curve::BondingCurveStartCap<TT>>(0x5f01358a165203a8e94970aacc3685ff776748f526ee813d91f3065b9a7648ba::bonding_curve::create_bonding_curve<TT>(arg0, b"TT", b"Token", b"desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmY7wWBu3QAPTQHRMRsFTL2VsWpe3pSr8QuAfjWqM3Kgve")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00d0144fad38e2187bb5cda4f4376cbe46bf29849bd3b315ca98d48e6ed62bb60e40f3cbd16f5b5f2770068d19f6b01539177474f609cfff73e3f9bbab1ea6850e5df9c702b23f19d3ff1dd6d6641a723115de2cdaf7e63f882dc2db80ee3217771747903689"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

