module 0xc453a939d5de962dc8d9c94263751c43c50c684309c65837ff139937d632b416::somcoin {
    struct SOMCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOMCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOMCOIN>(arg0, 9, b"SOMCOIN", b"SomSom", b"Trading is future", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/869c3c45-22b4-42a6-967a-a1397c6d5c96.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOMCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SOMCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

