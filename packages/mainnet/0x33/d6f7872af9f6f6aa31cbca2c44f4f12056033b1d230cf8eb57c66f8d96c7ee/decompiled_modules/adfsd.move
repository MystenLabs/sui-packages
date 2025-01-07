module 0x33d6f7872af9f6f6aa31cbca2c44f4f12056033b1d230cf8eb57c66f8d96c7ee::adfsd {
    struct ADFSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADFSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADFSD>(arg0, 9, b"ADFSD", b"WJB", b"sdsddsd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/85f36418-8c18-4421-b44c-62c33ca36f57.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADFSD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ADFSD>>(v1);
    }

    // decompiled from Move bytecode v6
}

