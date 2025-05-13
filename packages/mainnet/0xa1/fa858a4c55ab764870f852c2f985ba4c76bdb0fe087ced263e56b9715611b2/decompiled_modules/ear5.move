module 0xa1fa858a4c55ab764870f852c2f985ba4c76bdb0fe087ced263e56b9715611b2::ear5 {
    struct EAR5 has drop {
        dummy_field: bool,
    }

    fun init(arg0: EAR5, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x3a6ff208760c313bf7e72319dd216319d131aaddd0c8a539f831761ef94e53d6::bonding_curve::BondingCurveStartCap<EAR5>>(0x3a6ff208760c313bf7e72319dd216319d131aaddd0c8a539f831761ef94e53d6::bonding_curve::create_bonding_curve<EAR5>(arg0, b"EAR5", b"Planet Earth 5", b"Earth is the third planet from the Sun and the only astronomical object known to harbor life. This is enabled by Earth being an ocean world, the only one in the Solar System sustaining liquid surface water.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmS4pYpfs3Qz8pURf9wZHKp73vrkGSsJjqQRUqwAUja3Kg")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00777d455a4ddcdc251ce300d5e6a0e999ef55f9f68f41cc2f5f12d1749bfda432167c0ef55d9fd77656f2d9951108598446eb2833482eb5ac13b4ddd95bee4b01ed4877f4aa041dd7e483be109b3b253b6804cf63717f0c9f7ea244f99ce13efc1747121782"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

