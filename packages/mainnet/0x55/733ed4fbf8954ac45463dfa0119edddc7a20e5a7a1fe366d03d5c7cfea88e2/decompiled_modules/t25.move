module 0x55733ed4fbf8954ac45463dfa0119edddc7a20e5a7a1fe366d03d5c7cfea88e2::t25 {
    struct T25 has drop {
        dummy_field: bool,
    }

    fun init(arg0: T25, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T25>(arg0, 9, b"T25", b"Trumpmeme2", b"T25 may rock in 2025", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a95e2ca1-fc7b-49d0-9f3a-2c1469114087.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T25>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T25>>(v1);
    }

    // decompiled from Move bytecode v6
}

