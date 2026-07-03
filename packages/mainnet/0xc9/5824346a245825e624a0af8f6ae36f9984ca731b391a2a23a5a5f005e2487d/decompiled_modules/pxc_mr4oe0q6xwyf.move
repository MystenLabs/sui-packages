module 0xc95824346a245825e624a0af8f6ae36f9984ca731b391a2a23a5a5f005e2487d::pxc_mr4oe0q6xwyf {
    struct PXC_MR4OE0Q6XWYF has drop {
        dummy_field: bool,
    }

    fun init(arg0: PXC_MR4OE0Q6XWYF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PXC_MR4OE0Q6XWYF>(arg0, 9, b"PXC", b"PhoenixChain ", b"A next-generation utility token built for decentralized ecosystems. Designed to empower users with fast and secure transactions, low fees, and seamless scalability. Join our community as we build the future of decentralized finance.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/QmNgmSL25T7aMazfoZD3fKWiJxTvDQGMKD1MptX4NErkQF")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PXC_MR4OE0Q6XWYF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PXC_MR4OE0Q6XWYF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

