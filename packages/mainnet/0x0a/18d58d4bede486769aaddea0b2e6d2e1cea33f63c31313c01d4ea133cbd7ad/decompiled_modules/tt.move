module 0xa18d58d4bede486769aaddea0b2e6d2e1cea33f63c31313c01d4ea133cbd7ad::tt {
    struct TT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x3a6ff208760c313bf7e72319dd216319d131aaddd0c8a539f831761ef94e53d6::bonding_curve::BondingCurveStartCap<TT>>(0x3a6ff208760c313bf7e72319dd216319d131aaddd0c8a539f831761ef94e53d6::bonding_curve::create_bonding_curve<TT>(arg0, b"TT", b"TTTK", b"F", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmdDCJuuggvp1fhiMzN1tp6Upv4btNgiWtBzTKRUgCbAmn")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"000c6a8a3ad30893e4798df7561467197a25fc7023307ff2b997e2688c0d04c1962c532b75a89f762c98d87fa294dfd8282f167edacd79849e3e70283cf3605a0eed4877f4aa041dd7e483be109b3b253b6804cf63717f0c9f7ea244f99ce13efc1747071905"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

