module 0xda40436940017e0b84c7ca3c7fe26cff21d0f42f574bee6f9181b4393318020b::otto {
    struct OTTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: OTTO, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<OTTO>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<OTTO>(arg0, b"OTTO", b"SUITO", b"Sui otto", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmWixrHKTE31ZoMnVEDo9pVCA2fewiP1UPE4Ew6mXmpY4w")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"005976df31838c29b16141546b2fc1b986d1ee7a5a3fc0cdfcf3b87296508e511ccb3733a4d9ac135632335d19d762410963bd520c517f98769294d3bf8e55370fd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747767374"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

