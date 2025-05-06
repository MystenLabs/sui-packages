module 0x3a8d1cac3fe0e90cf656df6e61250f1d2be7caef6fe152eb06cee70258e11c25::star {
    struct STAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: STAR, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x3a6ff208760c313bf7e72319dd216319d131aaddd0c8a539f831761ef94e53d6::bonding_curve::BondingCurveStartCap<STAR>>(0x3a6ff208760c313bf7e72319dd216319d131aaddd0c8a539f831761ef94e53d6::bonding_curve::create_bonding_curve<STAR>(arg0, b"Star", b"StarVN", b"Star VN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmYUZ4BBc1VkFak1tjjUAx7kMCboJmsfJrCJRvUr4jYsAx")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"000c5b1c4106a3e66f895cdbd4538ac52e5d1a40d867628b44c9fc0f210dfe3c463c91de842aa936d078ec5f42c342fd919faecee4c4228ef304a5a39ae2c49d09ed4877f4aa041dd7e483be109b3b253b6804cf63717f0c9f7ea244f99ce13efc1746529877"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

