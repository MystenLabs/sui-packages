module 0xbed186bdb9bb00d855ce32990546821c134c550838fe421e25541e218b2a8a2a::tt {
    struct TT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x3a6ff208760c313bf7e72319dd216319d131aaddd0c8a539f831761ef94e53d6::bonding_curve::BondingCurveStartCap<TT>>(0x3a6ff208760c313bf7e72319dd216319d131aaddd0c8a539f831761ef94e53d6::bonding_curve::create_bonding_curve<TT>(arg0, b"TT", b"LedgerX", b"desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmY7wWBu3QAPTQHRMRsFTL2VsWpe3pSr8QuAfjWqM3Kgve")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"003b64441caf5e8c7bf08decf5b57ed485671bcf7ca81a580dc6f6d7d50b397e72360e3319b4a720cba22c44686ea246d07c0849d7d901e17272bf919606747a06ed4877f4aa041dd7e483be109b3b253b6804cf63717f0c9f7ea244f99ce13efc1746624708"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

