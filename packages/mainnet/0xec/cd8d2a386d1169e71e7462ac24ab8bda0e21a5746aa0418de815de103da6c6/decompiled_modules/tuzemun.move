module 0xeccd8d2a386d1169e71e7462ac24ab8bda0e21a5746aa0418de815de103da6c6::tuzemun {
    struct TUZEMUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUZEMUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUZEMUN>(arg0, 9, b"TUZEMUN", b"ToTheMoon", b"To the MOON", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b7b4dd10-a720-432b-bc24-a21b956166cc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUZEMUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TUZEMUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

