module 0x5f651888363356a8550e83117aa9cfc7d5900c2fd0d50e4f099aab505f2ac4e8::ear {
    struct EAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: EAR, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x3a6ff208760c313bf7e72319dd216319d131aaddd0c8a539f831761ef94e53d6::bonding_curve::BondingCurveStartCap<EAR>>(0x3a6ff208760c313bf7e72319dd216319d131aaddd0c8a539f831761ef94e53d6::bonding_curve::create_bonding_curve<EAR>(arg0, b"EAR", b"Planet Earth", b"Earth is the third planet from the Sun and the only astronomical object known to harbor life. This is enabled by Earth being an ocean world, the only one in the Solar System sustaining liquid surface water.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmS4pYpfs3Qz8pURf9wZHKp73vrkGSsJjqQRUqwAUja3Kg")), b"https://en.wikipedia.org/wiki/Earth", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"003fcf6e4357dd08ef87d89861967917d2085e991f816dfd2460465f2478cac4908edbdd74b75e4a0ebee309730745fe8d9314f2c0f4099a4e1c457cab88cb2207ed4877f4aa041dd7e483be109b3b253b6804cf63717f0c9f7ea244f99ce13efc1746023733"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

