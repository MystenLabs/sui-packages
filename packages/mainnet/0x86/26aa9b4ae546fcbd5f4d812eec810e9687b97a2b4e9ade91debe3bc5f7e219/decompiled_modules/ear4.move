module 0x8626aa9b4ae546fcbd5f4d812eec810e9687b97a2b4e9ade91debe3bc5f7e219::ear4 {
    struct EAR4 has drop {
        dummy_field: bool,
    }

    fun init(arg0: EAR4, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x3a6ff208760c313bf7e72319dd216319d131aaddd0c8a539f831761ef94e53d6::bonding_curve::BondingCurveStartCap<EAR4>>(0x3a6ff208760c313bf7e72319dd216319d131aaddd0c8a539f831761ef94e53d6::bonding_curve::create_bonding_curve<EAR4>(arg0, b"EAR4", b"Planet Earth 4", b"Earth is the third planet from the Sun and the only astronomical object known to harbor life. This is enabled by Earth being an ocean world, the only one in the Solar System sustaining liquid surface water.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmS4pYpfs3Qz8pURf9wZHKp73vrkGSsJjqQRUqwAUja3Kg")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00f732bfb3ae6da30858269101044439f914505d51f084fe1eafac0fba512179efd3a9fff53382e1bf1b93a2f551f6bb7bfdcf1012c5e2859ecbb535cf550cc400ed4877f4aa041dd7e483be109b3b253b6804cf63717f0c9f7ea244f99ce13efc1747072296"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

