module 0x8a636cebf2cac3a1d269b3b38d970a4dd0d7b20c0d47f2e4c64773a915efcd48::cata {
    struct CATA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATA>(arg0, 9, b"CATA", b"dayo akina", b"I love cats ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dd863e15-9ee9-4763-b05b-da99c9053777.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATA>>(v1);
    }

    // decompiled from Move bytecode v6
}

