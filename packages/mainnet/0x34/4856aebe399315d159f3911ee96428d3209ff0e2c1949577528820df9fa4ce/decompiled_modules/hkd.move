module 0x344856aebe399315d159f3911ee96428d3209ff0e2c1949577528820df9fa4ce::hkd {
    struct HKD has drop {
        dummy_field: bool,
    }

    fun init(arg0: HKD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HKD>(arg0, 6, b"HKD", b"Hacked", x"426f726e2066726f6d20746865206368616f73206f6620746865204365747573206578706c6f69742c20244841434b45442069732074686520726f677565206d656d6520746f6b656e206f6620746865205375692e0a4469676974616c2067686f737420696e20746865206d616368696e652e20437261636b696e6720636f64652c206578706f73696e6720666c6177732c20616e6420726577726974696e67", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibol5def23unqmv6u5yusw4nsw3dj2jqbxeon3tazr6wkp3cnt27q")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HKD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HKD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

