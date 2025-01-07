module 0xe3b70e78754060a17b552c840c20a94f2e234736a9c0bcd7ef618e563f77795a::skmn {
    struct SKMN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKMN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKMN>(arg0, 9, b"SKMN", b"Skamina", b"In scum we trust", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c353ca64-e13c-49d1-b218-50fe51adcda0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKMN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SKMN>>(v1);
    }

    // decompiled from Move bytecode v6
}

