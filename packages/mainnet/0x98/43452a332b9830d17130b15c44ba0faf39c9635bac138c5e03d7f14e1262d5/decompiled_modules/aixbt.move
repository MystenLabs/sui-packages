module 0x9843452a332b9830d17130b15c44ba0faf39c9635bac138c5e03d7f14e1262d5::aixbt {
    struct AIXBT has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIXBT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AIXBT>(arg0, 6, b"AIXBT", b"AIXBT", b"AIXBT tracks CT discussions and leverages its proprietary engine to identify high momentum plays, and play games...AIXBT token holders gain access to its analytics platform.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/aixbt_on_sui_652529cda0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AIXBT>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIXBT>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

