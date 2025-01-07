module 0xabf11a647323ed29407ffa9c6174320c4994f94c1e587d298548677c9b771c02::nakawewe {
    struct NAKAWEWE has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAKAWEWE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAKAWEWE>(arg0, 9, b"NAKAWEWE", b"WEWE", b"Suitoshi nakawewe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f1091f64-a165-48df-bd3a-5217bc9affe3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAKAWEWE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NAKAWEWE>>(v1);
    }

    // decompiled from Move bytecode v6
}

