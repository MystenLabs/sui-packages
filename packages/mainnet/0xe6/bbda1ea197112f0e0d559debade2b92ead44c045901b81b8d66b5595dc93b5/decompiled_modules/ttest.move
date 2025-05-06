module 0xe6bbda1ea197112f0e0d559debade2b92ead44c045901b81b8d66b5595dc93b5::ttest {
    struct TTEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TTEST, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x3a6ff208760c313bf7e72319dd216319d131aaddd0c8a539f831761ef94e53d6::bonding_curve::BondingCurveStartCap<TTEST>>(0x3a6ff208760c313bf7e72319dd216319d131aaddd0c8a539f831761ef94e53d6::bonding_curve::create_bonding_curve<TTEST>(arg0, b"TTEST", b"Token", b"desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmY7wWBu3QAPTQHRMRsFTL2VsWpe3pSr8QuAfjWqM3Kgve")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"007bd53f9a1a03f89f9ec36dd4f6931b10f5a4bc8b00fbe8d09ea01c07ecde5be868183df142890a3b4bf7ac422d991abc6d61f717539856e37c5bc99d90887e0aed4877f4aa041dd7e483be109b3b253b6804cf63717f0c9f7ea244f99ce13efc1746535491"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

