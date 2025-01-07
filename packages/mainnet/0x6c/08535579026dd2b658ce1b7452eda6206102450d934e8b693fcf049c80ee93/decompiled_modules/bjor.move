module 0x6c08535579026dd2b658ce1b7452eda6206102450d934e8b693fcf049c80ee93::bjor {
    struct BJOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BJOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BJOR>(arg0, 9, b"BJOR", b"Bjorka", b"Let them pass, for constitusional", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6624168a-a207-4083-ba52-0f0cb15dadee.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BJOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BJOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

