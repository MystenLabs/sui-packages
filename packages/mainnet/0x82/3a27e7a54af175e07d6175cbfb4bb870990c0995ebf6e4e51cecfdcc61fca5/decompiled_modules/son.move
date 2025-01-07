module 0x823a27e7a54af175e07d6175cbfb4bb870990c0995ebf6e4e51cecfdcc61fca5::son {
    struct SON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SON>(arg0, 6, b"Son", b"Are ya winning, son?", b"Are ya winning, son? Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731025557597.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SON>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

