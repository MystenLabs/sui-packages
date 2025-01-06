module 0xb5d024d8b9d21d17fc08a771a76c5f5e37106fbe3fddb52d8408be690ba31298::naay {
    struct NAAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAAY>(arg0, 9, b"NAAY", b"naayr", b"naayrdezhkam", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f09423ab-fa2b-4f8b-86ba-3234b3718a61.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NAAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

