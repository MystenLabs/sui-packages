module 0x6902aa21db4397820d095b1d80b87be1f14bb25c8cf0a14f9fff254b02f5aaa::suilama {
    struct SUILAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILAMA>(arg0, 6, b"Suilama", b"Suilama Turbos", x"536f6c616d6120746865204f6666696369616c20556e6f6666696369616c20537569204d6173636f740a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731012823289.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUILAMA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILAMA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

