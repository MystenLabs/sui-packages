module 0xe861c10abfa46f34864aa6cf17585dfa7b0b99d207cd4c6b8d6c67f2227e5f6f::octaflow {
    struct OCTAFLOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCTAFLOW, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<OCTAFLOW>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<OCTAFLOW>(arg0, b"OCTAFLOW", b"OctaFlow", b"OctaFlow, is the octopus that has 8 different flows!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmQY68JYQAyuDvp33ME8nuU8B11dPgMuMtFQKNScA3y6oL")), b"WEBSITE", b"https://x.com/OctaFlowSui", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00536ebb917c70b7283b22606158566040e3654a74c21d0e0a2e86b4f1c969f45e1afdab17eaf5f8dcb253a7c37b3be08b9ff1a69db6c56e5d994ee9bfc2aa950cd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747757450"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

