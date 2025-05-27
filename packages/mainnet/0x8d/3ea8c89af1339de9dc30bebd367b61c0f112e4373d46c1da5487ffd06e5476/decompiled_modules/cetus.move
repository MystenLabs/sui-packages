module 0x8d3ea8c89af1339de9dc30bebd367b61c0f112e4373d46c1da5487ffd06e5476::cetus {
    struct CETUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CETUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CETUS>(arg0, 6, b"CETUS", b"Cetus Protocol", b"We all got screwed over by this protocol, let's flip its market cap and make our money back", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihzzqvzg45k7dryqfl7liq5sg2wj4ov6qrajmhk6xycbefhmfvsli")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CETUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CETUS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

