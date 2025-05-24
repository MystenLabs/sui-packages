module 0x254e48e78743656054aef8689c0f810e5fa167c647d100c6d36ddf7d79827442::udin {
    struct UDIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: UDIN, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<UDIN>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<UDIN>(arg0, b"UDIN", b"Udin Chan", b"Udin is the name of a famous person", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmaX4TpPZRHjY75rseiovt7eubm5N5ACfX13v9gwMhxswS")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0089b697a212e1b46764fffd5f49a02397654796d64d193cdaab1389aa77df75c46ddff828880ce40254c9f980467c1da05328dc03b19e978d5f654bd3b5cdac05d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748102128"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

