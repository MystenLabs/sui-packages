module 0x3ed2ed13d5fec9fe7075c09a0e30154d37ac1c7f595dd7f1dfc2da00b8e5d859::bookcoins {
    struct BOOKCOINS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOKCOINS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOKCOINS>(arg0, 9, b"BOOKCOINS", b"Acada", b"Crypto for accessing free academic books and research ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ffbf7cd7-cd56-4130-bedb-910011beae3a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOKCOINS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOOKCOINS>>(v1);
    }

    // decompiled from Move bytecode v6
}

