module 0x77df5819332cbe02fb9d6fca5f1f1e4f3793f99ebf3594273740a3b23ec8980::pen {
    struct PEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEN, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<PEN>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<PEN>(arg0, b"PEN", b"PENCIL", b"Pencil is a Token uses for The Childrens Need a Pencil to write charity.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmTT4TQAdF6cZRVYGR8VEtjYqAtP3Ax7X62PUpHGbjXTJm")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00140ebfdf5426af3046bb4b0e67cdde02be1c14ea60c8e6f81c4c9670ac2dc0f6c88a2a768ed76c7fc3ff7116a777b94afad5c05f53c074633794d267c777d503d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747830273"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

