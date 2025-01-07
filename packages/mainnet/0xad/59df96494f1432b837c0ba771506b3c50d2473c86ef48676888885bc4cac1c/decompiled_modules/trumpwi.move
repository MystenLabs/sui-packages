module 0xad59df96494f1432b837c0ba771506b3c50d2473c86ef48676888885bc4cac1c::trumpwi {
    struct TRUMPWI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPWI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPWI>(arg0, 9, b"TRUMPWI", b"Trump win", b"Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/18108eab-bdeb-4493-bc8b-cfa5aa20e29a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPWI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMPWI>>(v1);
    }

    // decompiled from Move bytecode v6
}

