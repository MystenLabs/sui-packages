module 0xa06ea7429428e2fdebd34fde87ad08563f1b55c43b89a8784934a92818a1bb36::kkk {
    struct KKK has drop {
        dummy_field: bool,
    }

    fun init(arg0: KKK, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x3a6ff208760c313bf7e72319dd216319d131aaddd0c8a539f831761ef94e53d6::bonding_curve::BondingCurveStartCap<KKK>>(0x3a6ff208760c313bf7e72319dd216319d131aaddd0c8a539f831761ef94e53d6::bonding_curve::create_bonding_curve<KKK>(arg0, b"KKK", b"IOI", b"1", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmdDCJuuggvp1fhiMzN1tp6Upv4btNgiWtBzTKRUgCbAmn")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00f3381013f97030b6b1d3dbf08bf03f3dceb1c413a5133b2630e26075a0257ee7c98f91b4833a48ee5a063af93d9b8b59a9921299374f0b1cfa2694e7ac72850fed4877f4aa041dd7e483be109b3b253b6804cf63717f0c9f7ea244f99ce13efc1747073546"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

