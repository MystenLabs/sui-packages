module 0xc3f6cdb75e0f79b344c1efdd6d7c3a577379f76b32ffc2aa54ce2c8fddb6d260::booster {
    struct BOOSTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOSTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOSTER>(arg0, 9, b"BOOSTER", b"Aimbosster", b"Boost everything' ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bccf3926-a2aa-4901-b855-f466d16e6d2b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOSTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOOSTER>>(v1);
    }

    // decompiled from Move bytecode v6
}

