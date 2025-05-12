module 0x9d72e374f5954b255a9954b75d121dd9802b143679cc98afc7ff38387e10f695::lkk {
    struct LKK has drop {
        dummy_field: bool,
    }

    fun init(arg0: LKK, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x3a6ff208760c313bf7e72319dd216319d131aaddd0c8a539f831761ef94e53d6::bonding_curve::BondingCurveStartCap<LKK>>(0x3a6ff208760c313bf7e72319dd216319d131aaddd0c8a539f831761ef94e53d6::bonding_curve::create_bonding_curve<LKK>(arg0, b"LKK", b"LKKL", b"123", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmdDCJuuggvp1fhiMzN1tp6Upv4btNgiWtBzTKRUgCbAmn")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0018be182e5a2e3e444972fe2cfdcd33903bf8185c90ae7a3362d7891603942c920a09ba85e24db52d75a5963d9c303827491bbddbab50e6faca8034fe7b2a030fed4877f4aa041dd7e483be109b3b253b6804cf63717f0c9f7ea244f99ce13efc1747072008"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

