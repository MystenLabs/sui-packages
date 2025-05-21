module 0x812c7b38c9a5e89980d5a1d690b2299e9c060fb3b2e89ccea74b68ecfbd5257b::snk {
    struct SNK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNK, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SNK>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SNK>(arg0, b"SNK", b"SNAKE", b"the year of the snake", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmTepeyL7gpmhpcZkGy9LAaFs3ePFdxbVC2s5fAybpJmAS")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00516add7afb73b3c15f2a15d4b4a0c309419693ca52339dcbe3b6ec8fdfe47a63fee91fd7994f70c784d358f36ae12ac9815798b03213d36e3a0ed1fe0dd7d70dd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747831944"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

