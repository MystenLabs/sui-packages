module 0xb4ee4b0a83293a0ca1faa956d10a4dc4aa162086efed0f2c2e91539b97155a5::chebu {
    struct CHEBU has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHEBU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHEBU>(arg0, 6, b"CHEBU", b"CheburashkaSui", b"$Chebu launch on @Turbos.fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731000587696.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHEBU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHEBU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

