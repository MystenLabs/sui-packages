module 0xa300db222a417a2fa3fb5d97930a962082268b35305aeb5187fc1dd49c2d2c2e::ear {
    struct EAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: EAR, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x3a6ff208760c313bf7e72319dd216319d131aaddd0c8a539f831761ef94e53d6::bonding_curve::BondingCurveStartCap<EAR>>(0x3a6ff208760c313bf7e72319dd216319d131aaddd0c8a539f831761ef94e53d6::bonding_curve::create_bonding_curve<EAR>(arg0, b"EAR", b"Planet Earth", b"Earth is the third planet from the Sun and the only astronomical object known to harbor life. This is enabled by Earth being an ocean world, the only one in the Solar System sustaining liquid surface water.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmS4pYpfs3Qz8pURf9wZHKp73vrkGSsJjqQRUqwAUja3Kg")), b"https://en.wikipedia.org/wiki/Earth", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"000a8c4d60bf0a1eb5782ad81ccebe8df0724fbb1b43b61690507983e53d12f3b17dd5ca8d341151d3c4de06416e59204ede3fb86e6cf4847940136d6babaf3404ed4877f4aa041dd7e483be109b3b253b6804cf63717f0c9f7ea244f99ce13efc1747057191"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

