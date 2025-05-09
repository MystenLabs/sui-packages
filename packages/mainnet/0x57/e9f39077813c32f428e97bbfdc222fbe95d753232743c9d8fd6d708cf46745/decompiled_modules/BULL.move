module 0x57e9f39077813c32f428e97bbfdc222fbe95d753232743c9d8fd6d708cf46745::BULL {
    struct BULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BULL>(arg0, 6, b"BULL", b"BULLISH", b"$BULL UP!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://uptos-pump.myfilebase.com/ipfs/QmccChq17UMzZRQWanZqStgVprHXvU5UkSGi7jcGwFK7qz")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BULL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

