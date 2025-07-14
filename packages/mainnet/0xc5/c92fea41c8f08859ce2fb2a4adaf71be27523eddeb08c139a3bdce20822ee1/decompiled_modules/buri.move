module 0xc5c92fea41c8f08859ce2fb2a4adaf71be27523eddeb08c139a3bdce20822ee1::buri {
    struct BURI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BURI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BURI>(arg0, 6, b"BURI", b"BURI BURIZAEMON", x"4275726920427572695a61656d6f6e20546865205361726361736d204865726f0a0a436f6d6d756e697479203a2068747470733a2f2f782e636f6d2f746865627572697a61656d6f6e2f7374617475732f31393434373834323538343934383038323835", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiadzw7i77mi2usf6vjgjlm4a3ezzdrstlqtofue5ddf5dxkokhray")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BURI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BURI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

