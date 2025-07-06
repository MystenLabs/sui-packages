module 0x81632dffa56d7bb108a9d9525d6279bafdf72e101b705cdec942a19342903805::coin {
    struct COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = init_internal(arg0, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun init_internal(arg0: COIN, arg1: &mut 0x2::tx_context::TxContext) : (0x2::coin::TreasuryCap<COIN>, 0x2::coin::CoinMetadata<COIN>) {
        0x2::coin::create_currency<COIN>(arg0, 9, b"RMA", b"RMA", b"This index features popular SUI currencies, weighted by their market capitalizations.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://app.index.reactive.finance/indexes/RMA.png")), arg1)
    }

    // decompiled from Move bytecode v6
}

