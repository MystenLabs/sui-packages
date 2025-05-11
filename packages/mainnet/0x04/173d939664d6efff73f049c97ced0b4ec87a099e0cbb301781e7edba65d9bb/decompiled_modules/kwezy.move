module 0x4173d939664d6efff73f049c97ced0b4ec87a099e0cbb301781e7edba65d9bb::kwezy {
    struct KWEZY has drop {
        dummy_field: bool,
    }

    fun init(arg0: KWEZY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KWEZY>(arg0, 6, b"KWEZY", b"KWEZY DOG", x"244b57455a59206973207468652066756e6e696573742079657420636861726d696e6720646f6720696e2074686520636861696e2e0a4865206c6f76657320746f20706c617920776974682068697320746f6e677565206f7574206c6f6f6b696e6720666f722061206c69636b2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifumtxtaj7cajcquozisf4cw4jdutezjbijolurdtniauarclmyse")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KWEZY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KWEZY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

