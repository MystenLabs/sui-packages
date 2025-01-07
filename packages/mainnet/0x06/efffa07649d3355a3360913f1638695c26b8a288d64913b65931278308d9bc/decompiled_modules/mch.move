module 0x6efffa07649d3355a3360913f1638695c26b8a288d64913b65931278308d9bc::mch {
    struct MCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCH>(arg0, 6, b"MCH", b"MetaChain", b"MetaChain (MCH) is a next-generation blockchain solution built on SUI, designed to revolutionize decentralized applications (dApps) by providing seamless scalability, ultra-fast transaction speeds, and low fees. MetaChain focuses on interoperability, ensuring developers and users can easily interact with multiple blockchain networks. Its robust security architecture offers maximum protection, making it the ideal choice for innovative dApps, DeFi platforms, and NFT ecosystems.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/666_1fcb56c972.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MCH>>(v1);
    }

    // decompiled from Move bytecode v6
}

