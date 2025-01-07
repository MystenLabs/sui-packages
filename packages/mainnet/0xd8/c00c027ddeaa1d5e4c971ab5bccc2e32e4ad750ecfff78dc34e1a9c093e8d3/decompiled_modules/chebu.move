module 0xd8c00c027ddeaa1d5e4c971ab5bccc2e32e4ad750ecfff78dc34e1a9c093e8d3::chebu {
    struct CHEBU has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHEBU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHEBU>(arg0, 6, b"Chebu", b"Cheburashkasui", b"$Chebu launch on @Turbos.fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731000088455.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHEBU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHEBU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

