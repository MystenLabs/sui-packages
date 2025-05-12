module 0x1cfc08594794def716526d9796b374a375ea00131588590e68f8042b847937dc::pig {
    struct PIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIG, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x3a6ff208760c313bf7e72319dd216319d131aaddd0c8a539f831761ef94e53d6::bonding_curve::BondingCurveStartCap<PIG>>(0x3a6ff208760c313bf7e72319dd216319d131aaddd0c8a539f831761ef94e53d6::bonding_curve::create_bonding_curve<PIG>(arg0, b"PIG", b"Token", b"desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmXDPZaQ9kiLncSfiarJthyzeQXpVf83X24VZHBrdPzDEu")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"008cf328a2afa01caa77197904d9c499d2c576b579537c3a76dd5008a90da77394d48b4f1adf2c88ca79300418a426ef13bf29c8714f716978adac110e97fc9c0ced4877f4aa041dd7e483be109b3b253b6804cf63717f0c9f7ea244f99ce13efc1747073847"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

