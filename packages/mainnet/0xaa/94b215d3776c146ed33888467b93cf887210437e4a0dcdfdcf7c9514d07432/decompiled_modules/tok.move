module 0xaa94b215d3776c146ed33888467b93cf887210437e4a0dcdfdcf7c9514d07432::tok {
    struct TOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOK, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x3a6ff208760c313bf7e72319dd216319d131aaddd0c8a539f831761ef94e53d6::bonding_curve::BondingCurveStartCap<TOK>>(0x3a6ff208760c313bf7e72319dd216319d131aaddd0c8a539f831761ef94e53d6::bonding_curve::create_bonding_curve<TOK>(arg0, b"TOK", b"TOKS", b"sdas", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmdDCJuuggvp1fhiMzN1tp6Upv4btNgiWtBzTKRUgCbAmn")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00a535a1fcae9dfa29cfc50e7430ce76092e1fff36178359917d1677018a0a34b122353114dd856a4e46c4083e07bdf4c5002657999a670decbb0c5b3929d9b607ed4877f4aa041dd7e483be109b3b253b6804cf63717f0c9f7ea244f99ce13efc1745943105"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

