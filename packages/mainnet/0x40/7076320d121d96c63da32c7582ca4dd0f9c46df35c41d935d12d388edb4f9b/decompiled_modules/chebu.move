module 0x407076320d121d96c63da32c7582ca4dd0f9c46df35c41d935d12d388edb4f9b::chebu {
    struct CHEBU has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHEBU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHEBU>(arg0, 6, b"Chebu", b"Cheburashka ", b"$Chebu launch on Turbos", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730961932396.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHEBU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHEBU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

