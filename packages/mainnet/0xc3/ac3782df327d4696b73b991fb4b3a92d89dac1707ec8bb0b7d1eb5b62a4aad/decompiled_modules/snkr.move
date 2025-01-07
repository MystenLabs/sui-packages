module 0xc3ac3782df327d4696b73b991fb4b3a92d89dac1707ec8bb0b7d1eb5b62a4aad::snkr {
    struct SNKR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNKR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNKR>(arg0, 9, b"SNKR", b"Snaker", b"Its been a hot cake in fute", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f502d75f-1a7a-440f-ba0c-996ef4612851.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNKR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SNKR>>(v1);
    }

    // decompiled from Move bytecode v6
}

