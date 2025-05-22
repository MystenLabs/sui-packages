module 0x34abbaf0c92048b1bdf8ef614e54825f02d2e4da06137c291b3de4f1a7a67d37::tt2 {
    struct TT2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TT2, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x5f01358a165203a8e94970aacc3685ff776748f526ee813d91f3065b9a7648ba::bonding_curve::BondingCurveStartCap<TT2>>(0x5f01358a165203a8e94970aacc3685ff776748f526ee813d91f3065b9a7648ba::bonding_curve::create_bonding_curve<TT2>(arg0, b"TT2", b"Token", b"desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmY7wWBu3QAPTQHRMRsFTL2VsWpe3pSr8QuAfjWqM3Kgve")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0088e2cb8556f9754817e1c0a93bb4baa08e840dc90e7df0606fc965157b2227e4b2087130a30178a2409c02c75c7a425f6f6a234ceb1bb616554180921341fa005df9c702b23f19d3ff1dd6d6641a723115de2cdaf7e63f882dc2db80ee3217771747904136"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

