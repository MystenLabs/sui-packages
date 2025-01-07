module 0x4d3b1734e025d3568d529f8f50a6aac383665fcda03d8c18a53c50bf876348fa::somcoin {
    struct SOMCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOMCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOMCOIN>(arg0, 9, b"SOMCOIN", b"SomSom", b"Trading is future", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b7ddca95-cc25-4b24-8b78-d9ec145d2ccc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOMCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SOMCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

