module 0xb049d036ca7e31ef09da80125c0fc0526c7c6dbf76691cd62bc160572ed2c09f::rrq {
    struct RRQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: RRQ, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x3a6ff208760c313bf7e72319dd216319d131aaddd0c8a539f831761ef94e53d6::bonding_curve::BondingCurveStartCap<RRQ>>(0x3a6ff208760c313bf7e72319dd216319d131aaddd0c8a539f831761ef94e53d6::bonding_curve::create_bonding_curve<RRQ>(arg0, b"RRQ", b"Token", b"desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmW2yn8Gvwa2updz5KcTzQJ9uXKaPikKiZnnKMLDX2miC5")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"008c173270e722d116c6408bacabb003568193b50691bd5c095503c08f60d237ab57a8d415bc07923ecb2fb804b09afd68ee32183567ef53700aff5740eb4a4902ed4877f4aa041dd7e483be109b3b253b6804cf63717f0c9f7ea244f99ce13efc1747070878"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

