module 0x1c976c9e9ea695d8054e80eb6f6e07af6beb91dd03374964d53a7eddf357d279::ear2 {
    struct EAR2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: EAR2, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x3a6ff208760c313bf7e72319dd216319d131aaddd0c8a539f831761ef94e53d6::bonding_curve::BondingCurveStartCap<EAR2>>(0x3a6ff208760c313bf7e72319dd216319d131aaddd0c8a539f831761ef94e53d6::bonding_curve::create_bonding_curve<EAR2>(arg0, b"EAR2", b"Planet Earth 2", b"Earth is the third planet from the Sun and the only astronomical object known to harbor life. This is enabled by Earth being an ocean world, the only one in the Solar System sustaining liquid surface water.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmS4pYpfs3Qz8pURf9wZHKp73vrkGSsJjqQRUqwAUja3Kg")), b"https://en.wikipedia.org/wiki/Earth", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0030008d234df996d5d2b58ba041e41fc0989038f26a403453a45314e30362a1dbe8b95fdc95ae36b2f8f165d12d8fa9a1613e05ac47919ba120fd41aaefb61903ed4877f4aa041dd7e483be109b3b253b6804cf63717f0c9f7ea244f99ce13efc1747069106"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

