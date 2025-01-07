module 0x427490ff57d09684764dca22661d4370d4585d18f8aa495febaff77df9408861::weav {
    struct WEAV has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEAV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEAV>(arg0, 9, b"WEAV", b"Weavy", b"Here to stay involve and grow and no going back ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0ce2e805-88e7-4b44-b7b0-2c4222192f95.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEAV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEAV>>(v1);
    }

    // decompiled from Move bytecode v6
}

