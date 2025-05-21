module 0x98a73d05f804a6c19a523183347b89accaa8ad47199254ab56baf2ac693e6fab::cetos {
    struct CETOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CETOS, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<CETOS>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<CETOS>(arg0, b"CETOS", b"CetoSui", x"4365746f5375690a0a20436f6d6d756e69747920697320686f6d652c0a77686572652077652062656c6f6e67", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmWwgTxNdbbrMGxUJnmoK9i6sUk8txuDVUEBzdZcU54ZJD")), b"https://cetoddle.fun/", b"https://x.com/Ceto_sui", b"DISCORD", b"https://t.me/Ceto_OnSui", 0x1::string::utf8(b"00a9f7c3c62afc6961d3117de239a7f16dfcf98e43e889d61242f4496e157cc381643be14e09ac55b9acd1dc21777ee18a88a585dde90ac397d73a37e8bc06e40ed598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747839730"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

