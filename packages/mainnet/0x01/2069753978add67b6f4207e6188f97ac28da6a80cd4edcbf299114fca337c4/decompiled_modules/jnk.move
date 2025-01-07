module 0x12069753978add67b6f4207e6188f97ac28da6a80cd4edcbf299114fca337c4::jnk {
    struct JNK has drop {
        dummy_field: bool,
    }

    fun init(arg0: JNK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JNK>(arg0, 6, b"Jnk", b"SuiJunkie", b"volatility dependent", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731843121784.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JNK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JNK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

