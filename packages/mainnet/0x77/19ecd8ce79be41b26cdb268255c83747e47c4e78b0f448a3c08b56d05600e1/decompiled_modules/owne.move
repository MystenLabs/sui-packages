module 0x7719ecd8ce79be41b26cdb268255c83747e47c4e78b0f448a3c08b56d05600e1::owne {
    struct OWNE has drop {
        dummy_field: bool,
    }

    fun init(arg0: OWNE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OWNE>(arg0, 9, b"OWNE", b"jdnd", b"brbd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/38ba817e-9534-4012-832f-92976cd297ce.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OWNE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OWNE>>(v1);
    }

    // decompiled from Move bytecode v6
}

