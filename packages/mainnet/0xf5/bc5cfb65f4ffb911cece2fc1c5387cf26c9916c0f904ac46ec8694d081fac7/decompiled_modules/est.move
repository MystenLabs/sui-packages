module 0xf5bc5cfb65f4ffb911cece2fc1c5387cf26c9916c0f904ac46ec8694d081fac7::est {
    struct EST has drop {
        dummy_field: bool,
    }

    fun init(arg0: EST, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x3a6ff208760c313bf7e72319dd216319d131aaddd0c8a539f831761ef94e53d6::bonding_curve::BondingCurveStartCap<EST>>(0x3a6ff208760c313bf7e72319dd216319d131aaddd0c8a539f831761ef94e53d6::bonding_curve::create_bonding_curve<EST>(arg0, b"EST", b"Token", b"desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmY7wWBu3QAPTQHRMRsFTL2VsWpe3pSr8QuAfjWqM3Kgve")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00afafa53278a7e2dc7e0b6401330e9dc48344de99727b6bc162150826a474f82ab2199fdcea9fd9aa25f6f04b64754271367ca1de9654f8e4a6800e6421879701ed4877f4aa041dd7e483be109b3b253b6804cf63717f0c9f7ea244f99ce13efc1747069562"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

