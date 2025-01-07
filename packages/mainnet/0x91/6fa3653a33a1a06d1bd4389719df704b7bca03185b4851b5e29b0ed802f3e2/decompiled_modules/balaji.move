module 0x916fa3653a33a1a06d1bd4389719df704b7bca03185b4851b5e29b0ed802f3e2::balaji {
    struct BALAJI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BALAJI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BALAJI>(arg0, 9, b"BALAJI", b"Salasar", b"Salasar Balaji Temple Charitable Trust ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/baf98ebc-ec0b-4a2b-9668-386328d531b0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BALAJI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BALAJI>>(v1);
    }

    // decompiled from Move bytecode v6
}

