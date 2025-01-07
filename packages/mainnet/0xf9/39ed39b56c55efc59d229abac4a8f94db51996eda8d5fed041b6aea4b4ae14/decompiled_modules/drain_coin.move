module 0xf939ed39b56c55efc59d229abac4a8f94db51996eda8d5fed041b6aea4b4ae14::drain_coin {
    struct DRAIN_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRAIN_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRAIN_COIN>(arg0, 6, b"USDS", b"Sui USD", b"Sui USD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cryptologos.cc/logos/usdd-usdd-logo.png?v=035")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DRAIN_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRAIN_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<DRAIN_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DRAIN_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

