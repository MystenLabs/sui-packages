module 0xd6aba71691368b15aafdf0721516289df825c5629795bd22dcb118712abac3f4::satkhira {
    struct SATKHIRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SATKHIRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SATKHIRA>(arg0, 9, b"SATKHIRA", b"HASAN", b"Inspired from wave wallet", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/825ef617-c689-4481-bba1-f45bb22c2f26.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SATKHIRA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SATKHIRA>>(v1);
    }

    // decompiled from Move bytecode v6
}

