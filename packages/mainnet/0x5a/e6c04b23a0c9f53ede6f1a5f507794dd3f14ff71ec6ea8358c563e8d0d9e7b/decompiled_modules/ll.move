module 0x5ae6c04b23a0c9f53ede6f1a5f507794dd3f14ff71ec6ea8358c563e8d0d9e7b::ll {
    struct LL has drop {
        dummy_field: bool,
    }

    fun init(arg0: LL, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x3a6ff208760c313bf7e72319dd216319d131aaddd0c8a539f831761ef94e53d6::bonding_curve::BondingCurveStartCap<LL>>(0x3a6ff208760c313bf7e72319dd216319d131aaddd0c8a539f831761ef94e53d6::bonding_curve::create_bonding_curve<LL>(arg0, b"LL", b"LLLK", b"test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmdDCJuuggvp1fhiMzN1tp6Upv4btNgiWtBzTKRUgCbAmn")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00b138434996cb2a670a3a52562c2c17055cc1011229cbe7984c87de4e79516d1c8f6208de6309cba6b79bca99487afc52cc51044816316b10b638a0b2b85a0f07ed4877f4aa041dd7e483be109b3b253b6804cf63717f0c9f7ea244f99ce13efc1747073349"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

