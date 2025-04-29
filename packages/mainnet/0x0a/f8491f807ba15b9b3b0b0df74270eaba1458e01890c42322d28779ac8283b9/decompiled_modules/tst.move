module 0xaf8491f807ba15b9b3b0b0df74270eaba1458e01890c42322d28779ac8283b9::tst {
    struct TST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TST, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x3a6ff208760c313bf7e72319dd216319d131aaddd0c8a539f831761ef94e53d6::bonding_curve::BondingCurveStartCap<TST>>(0x3a6ff208760c313bf7e72319dd216319d131aaddd0c8a539f831761ef94e53d6::bonding_curve::create_bonding_curve<TST>(arg0, b"TST", b"TEST", b"desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmXDPZaQ9kiLncSfiarJthyzeQXpVf83X24VZHBrdPzDEu")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0069526e45b261bb95c03f05185d0a4eef0a307dfa9b81a78e7d436bdacdf59e0314f20e067f2da9e34753f885d808381a18107cea55990ca5093c0cd37577ed00ed4877f4aa041dd7e483be109b3b253b6804cf63717f0c9f7ea244f99ce13efc1745946971"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

