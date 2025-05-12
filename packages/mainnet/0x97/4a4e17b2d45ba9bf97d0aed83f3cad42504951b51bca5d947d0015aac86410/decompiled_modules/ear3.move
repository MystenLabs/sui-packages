module 0x974a4e17b2d45ba9bf97d0aed83f3cad42504951b51bca5d947d0015aac86410::ear3 {
    struct EAR3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: EAR3, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x3a6ff208760c313bf7e72319dd216319d131aaddd0c8a539f831761ef94e53d6::bonding_curve::BondingCurveStartCap<EAR3>>(0x3a6ff208760c313bf7e72319dd216319d131aaddd0c8a539f831761ef94e53d6::bonding_curve::create_bonding_curve<EAR3>(arg0, b"EAR3", b"Planet Earth 3", b"Earth is the third planet from the Sun and the only astronomical object known to harbor life. This is enabled by Earth being an ocean world, the only one in the Solar System sustaining liquid surface water.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmS4pYpfs3Qz8pURf9wZHKp73vrkGSsJjqQRUqwAUja3Kg")), b"https://en.wikipedia.org/wiki/Earth", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00006e56ebdb576e45863998c5a2eaccb08374a8a006e8e328d01192a4b9f896bc6928f7d94bb344090bd4a605b684d60a70e6b59a91cc36cdecfa1630999a910ced4877f4aa041dd7e483be109b3b253b6804cf63717f0c9f7ea244f99ce13efc1747070466"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

