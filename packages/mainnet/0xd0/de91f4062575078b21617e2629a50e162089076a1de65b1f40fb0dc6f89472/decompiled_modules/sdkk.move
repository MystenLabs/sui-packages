module 0xd0de91f4062575078b21617e2629a50e162089076a1de65b1f40fb0dc6f89472::sdkk {
    struct SDKK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDKK, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x3a6ff208760c313bf7e72319dd216319d131aaddd0c8a539f831761ef94e53d6::bonding_curve::BondingCurveStartCap<SDKK>>(0x3a6ff208760c313bf7e72319dd216319d131aaddd0c8a539f831761ef94e53d6::bonding_curve::create_bonding_curve<SDKK>(arg0, b"SDKK", b"SKK", b"asd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmdDCJuuggvp1fhiMzN1tp6Upv4btNgiWtBzTKRUgCbAmn")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00b7244aff0c6340014912a6b3eaa97546beaacda0c70347dcc7efc4285dc74a2a4b595ffd109b2e2bdfa7e6c51f53445a1de05126fee4c0caab72d8454fdb6202ed4877f4aa041dd7e483be109b3b253b6804cf63717f0c9f7ea244f99ce13efc1747071956"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

