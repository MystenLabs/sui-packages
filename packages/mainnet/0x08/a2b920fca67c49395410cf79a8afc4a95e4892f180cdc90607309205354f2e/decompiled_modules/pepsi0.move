module 0x8a2b920fca67c49395410cf79a8afc4a95e4892f180cdc90607309205354f2e::pepsi0 {
    struct PEPSI0 has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPSI0, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<PEPSI0>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<PEPSI0>(arg0, b"PEPSI0", b"PEPSI", b"Pepsi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmaLYoCy5b8PvWeBifsaMEpRwCo9ziTpQ6icmjWvErouP7")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0048551a6831bc58119695e299fb7c2221d7d360f40beb5341209c213660f6ea01142cf115c7c714b4cc0a710a08be6c20d1a651ee4ae8a6dd519d48b92e6ea40ad598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748065945"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

