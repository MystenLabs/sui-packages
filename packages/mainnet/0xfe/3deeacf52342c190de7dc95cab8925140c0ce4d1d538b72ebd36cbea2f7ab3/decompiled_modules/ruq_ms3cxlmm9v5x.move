module 0xfe3deeacf52342c190de7dc95cab8925140c0ce4d1d538b72ebd36cbea2f7ab3::ruq_ms3cxlmm9v5x {
    struct RUQ_MS3CXLMM9V5X has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUQ_MS3CXLMM9V5X, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUQ_MS3CXLMM9V5X>(arg0, 9, b"RUQ", b"Ruq koin", b"RUQ Coin (RUQ) honors victims of crypto rug pulls by promoting transparency, blockchain education, security, and responsible participation for a safer decentralized ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/QmYVmV79Bsu5FL3UhU5V3Ui9bqe1s8T3t8BqM5zAXZutF3")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RUQ_MS3CXLMM9V5X>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUQ_MS3CXLMM9V5X>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

