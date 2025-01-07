module 0x59e3c4e0a2237115c1ee24d020af00d9b21b44ec598584278ab038538c622707::zuki {
    struct ZUKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZUKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZUKI>(arg0, 6, b"ZUKI", b"Suizuki", b"Fast chain need fast car $ZUKI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241003_080828_b004e6ec9e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZUKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZUKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

