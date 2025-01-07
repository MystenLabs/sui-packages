module 0xb49fe3dd847a7981c3bf5fa521d8a2c0e94b4aca74a847074d04d7ed7c471b8::csui {
    struct CSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CSUI>(arg0, 9, b"CSUI", b"Catssui", b"Buy and hold for long term", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d335a86a-9d46-4769-b818-796d15e5de7a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

