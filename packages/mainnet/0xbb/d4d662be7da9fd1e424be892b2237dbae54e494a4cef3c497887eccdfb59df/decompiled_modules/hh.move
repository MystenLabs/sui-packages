module 0xbbd4d662be7da9fd1e424be892b2237dbae54e494a4cef3c497887eccdfb59df::hh {
    struct HH has drop {
        dummy_field: bool,
    }

    fun init(arg0: HH, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x3a6ff208760c313bf7e72319dd216319d131aaddd0c8a539f831761ef94e53d6::bonding_curve::BondingCurveStartCap<HH>>(0x3a6ff208760c313bf7e72319dd216319d131aaddd0c8a539f831761ef94e53d6::bonding_curve::create_bonding_curve<HH>(arg0, b"HH", b"HSH", b"AJ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmdDCJuuggvp1fhiMzN1tp6Upv4btNgiWtBzTKRUgCbAmn")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"003e1fed6e18803b6b182df7e74e2a1feb875b1e1e5439055c15e4c35d0bc1e2a2ee50f0e6945d0e93224cc13ca79d933b62c880bf577b6336f5396361d4fe770bed4877f4aa041dd7e483be109b3b253b6804cf63717f0c9f7ea244f99ce13efc1747075656"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

