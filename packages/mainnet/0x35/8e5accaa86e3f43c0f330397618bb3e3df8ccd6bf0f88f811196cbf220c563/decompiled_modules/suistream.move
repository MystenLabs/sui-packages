module 0x358e5accaa86e3f43c0f330397618bb3e3df8ccd6bf0f88f811196cbf220c563::suistream {
    struct SUISTREAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISTREAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISTREAM>(arg0, 6, b"SUISTREAM", b"SUISTREAM - SUI streaming platform.", x"2453554953545245414d2069732061206c656164696e672073747265616d696e6720706c6174666f726d2064657369676e656420616e6420696e746567726174656420696e20746865202453554920626c6f636b636861696e2e0a436f6e74656e742063726561746f727320616e64207573657273206561726e202453554953545245414d20746f6b656e7320776974682074686569722076616c7561626c6520636f6e747269627574696f6e20696e2074686520706c6174666f726d2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihdyoonoq3jlgyomv3ckhkx5u4z2j3qwkjaxfdvw63bgiwwsfjsd4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISTREAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUISTREAM>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

