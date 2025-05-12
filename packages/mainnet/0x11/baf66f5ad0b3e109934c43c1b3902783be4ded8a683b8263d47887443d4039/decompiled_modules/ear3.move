module 0x11baf66f5ad0b3e109934c43c1b3902783be4ded8a683b8263d47887443d4039::ear3 {
    struct EAR3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: EAR3, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x3a6ff208760c313bf7e72319dd216319d131aaddd0c8a539f831761ef94e53d6::bonding_curve::BondingCurveStartCap<EAR3>>(0x3a6ff208760c313bf7e72319dd216319d131aaddd0c8a539f831761ef94e53d6::bonding_curve::create_bonding_curve<EAR3>(arg0, b"EAR3", b"Planet Earth 3", b"Earth is the third planet from the Sun and the only astronomical object known to harbor life. This is enabled by Earth being an ocean world, the only one in the Solar System sustaining liquid surface water.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmS4pYpfs3Qz8pURf9wZHKp73vrkGSsJjqQRUqwAUja3Kg")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"006b108d7aa545284f1998d2b0d6f1781abed863fc31feafbeda7c6b3b4f0e6480d4486b599ffe6e492904f0875fae5bb0e29ff607d023bc67e19bc0ce4393ce0eed4877f4aa041dd7e483be109b3b253b6804cf63717f0c9f7ea244f99ce13efc1747071780"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

