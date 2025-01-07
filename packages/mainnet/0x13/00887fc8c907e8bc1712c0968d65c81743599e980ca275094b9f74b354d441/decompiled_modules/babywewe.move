module 0x1300887fc8c907e8bc1712c0968d65c81743599e980ca275094b9f74b354d441::babywewe {
    struct BABYWEWE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYWEWE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYWEWE>(arg0, 9, b"BABYWEWE", b"Babywewe", b"Baby Wewe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2c192424-7ed1-48b8-9dfa-e8fc59b02e25.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYWEWE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BABYWEWE>>(v1);
    }

    // decompiled from Move bytecode v6
}

