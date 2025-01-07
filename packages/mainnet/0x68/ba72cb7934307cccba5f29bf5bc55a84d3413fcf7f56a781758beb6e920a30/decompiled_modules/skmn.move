module 0x68ba72cb7934307cccba5f29bf5bc55a84d3413fcf7f56a781758beb6e920a30::skmn {
    struct SKMN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKMN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKMN>(arg0, 9, b"SKMN", b"Skamina", b"In scum we trust", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5ea68ca1-4a33-4e44-a000-e0b6026dd533.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKMN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SKMN>>(v1);
    }

    // decompiled from Move bytecode v6
}

