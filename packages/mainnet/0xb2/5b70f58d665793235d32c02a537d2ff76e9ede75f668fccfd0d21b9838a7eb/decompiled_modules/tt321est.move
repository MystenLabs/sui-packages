module 0xb25b70f58d665793235d32c02a537d2ff76e9ede75f668fccfd0d21b9838a7eb::tt321est {
    struct TT321EST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TT321EST, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x3a6ff208760c313bf7e72319dd216319d131aaddd0c8a539f831761ef94e53d6::bonding_curve::BondingCurveStartCap<TT321EST>>(0x3a6ff208760c313bf7e72319dd216319d131aaddd0c8a539f831761ef94e53d6::bonding_curve::create_bonding_curve<TT321EST>(arg0, b"TT321EST", b"Token", b"desc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmY7wWBu3QAPTQHRMRsFTL2VsWpe3pSr8QuAfjWqM3Kgve")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00265a67fcde65927247b4666e0dcebca9fe68acb393db438a2d6082f62384925b99ecb3e3a74263685c93a922d87a6b0e67937bf33c649a445391ece8a2155407ed4877f4aa041dd7e483be109b3b253b6804cf63717f0c9f7ea244f99ce13efc1747061029"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

