module 0x559849b4c5c87ce7c1c28c55d305be7b707981f687e3b9ca2ec8a05f5d6f1ce4::sjj {
    struct SJJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SJJ, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x3a6ff208760c313bf7e72319dd216319d131aaddd0c8a539f831761ef94e53d6::bonding_curve::BondingCurveStartCap<SJJ>>(0x3a6ff208760c313bf7e72319dd216319d131aaddd0c8a539f831761ef94e53d6::bonding_curve::create_bonding_curve<SJJ>(arg0, b"SJJ", b"SJJS", b"SK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmdDCJuuggvp1fhiMzN1tp6Upv4btNgiWtBzTKRUgCbAmn")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00d8dac1d425c91c83a361ec7b46f5cb15edf8149987c6c446da068c5e1091e6014082c71b2cf528afd9aeda41151db477faf7ecc253f918b745944c0525386a08ed4877f4aa041dd7e483be109b3b253b6804cf63717f0c9f7ea244f99ce13efc1747074410"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

