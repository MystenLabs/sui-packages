module 0xb8595f1d8a6ea0b67079f2a473380c4fe845dc6796b1ff366e4b1581040f7ee::yakuza {
    struct YAKUZA has drop {
        dummy_field: bool,
    }

    fun init(arg0: YAKUZA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YAKUZA>(arg0, 9, b"YAKUZA", b"Yakuza", b"Criminal romance", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bf24745a-1b5d-4b17-8771-0baaf17ee20c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YAKUZA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YAKUZA>>(v1);
    }

    // decompiled from Move bytecode v6
}

