module 0x9336ac7c74e07e6f1734d4d265c4308a6a039573469874ba3635523d6bb350c2::cena {
    struct CENA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CENA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CENA>(arg0, 9, b"CENA", b"JCena", b"John Cena", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/395d4e83-2c84-48be-b57c-6e5de266f732.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CENA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CENA>>(v1);
    }

    // decompiled from Move bytecode v6
}

