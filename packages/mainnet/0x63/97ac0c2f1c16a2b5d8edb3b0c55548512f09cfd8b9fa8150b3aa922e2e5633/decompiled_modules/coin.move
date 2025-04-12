module 0x6397ac0c2f1c16a2b5d8edb3b0c55548512f09cfd8b9fa8150b3aa922e2e5633::coin {
    struct COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = init_internal(arg0, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun init_internal(arg0: COIN, arg1: &mut 0x2::tx_context::TxContext) : (0x2::coin::TreasuryCap<COIN>, 0x2::coin::CoinMetadata<COIN>) {
        0x2::coin::create_currency<COIN>(arg0, 9, b"RM7", b"Reactive Index: Top 7 Market Cap Weighted Index", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://index.reactive.finance/logo.png")), arg1)
    }

    // decompiled from Move bytecode v6
}

