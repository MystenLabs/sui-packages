module 0x98be7daedabbbf1f9a1db215aff938c66b25f1c3c93902a3881573dd1b5e30c5::skmn {
    struct SKMN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKMN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKMN>(arg0, 9, b"SKMN", b"Skamina", b"In scum we trust", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3f83d139-c017-471a-941d-832d85199813.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKMN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SKMN>>(v1);
    }

    // decompiled from Move bytecode v6
}

