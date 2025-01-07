module 0xa6c8b934d705ade8cff5b193ba0cc7ae6fd675b0b7a990c6c9ebae95debe3989::nakawewe {
    struct NAKAWEWE has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAKAWEWE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAKAWEWE>(arg0, 9, b"NAKAWEWE", b"WEWE", b"Suitoshi nakawewe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/361312c2-82e3-48a0-9de1-5a84d42b25e0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAKAWEWE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NAKAWEWE>>(v1);
    }

    // decompiled from Move bytecode v6
}

