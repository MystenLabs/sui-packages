module 0xae0e73e8edade1c6a7d239ac5dfee830f21c1f045e0ce1493fdcab286c89349c::nova {
    struct NOVA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOVA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOVA>(arg0, 6, b"NOVA", b"Sui Nova Ai", b"Sui Nova AI - The sentient guardian of the Sui blockchain. Futuristic. Intelligent. Unstoppable", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeihnwlmbnbwfxtccrm3m2s2gwzvipcox7t4bzczgbdnzfdfn67yrou")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOVA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NOVA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

