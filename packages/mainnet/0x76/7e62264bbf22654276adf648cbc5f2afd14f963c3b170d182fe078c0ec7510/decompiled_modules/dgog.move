module 0x767e62264bbf22654276adf648cbc5f2afd14f963c3b170d182fe078c0ec7510::dgog {
    struct DGOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DGOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DGOG>(arg0, 6, b"DGOG", b"Dogcoin", b"Army dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifwwwlml67tx5zadhfxommv4trl4phca472rdxx7rpbaf2ohlkfbu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DGOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DGOG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

