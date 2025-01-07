module 0x9b3a0ce2f965a45f11916b2e89134cd452a3170a7cedbcba9bb8420cd3522c7e::holym {
    struct HOLYM has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOLYM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOLYM>(arg0, 9, b"HOLYM", b"Holymeme", b"A memecoin created solely for the fun of it", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d9d80243-9a48-4762-b11d-26bac1356416.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOLYM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOLYM>>(v1);
    }

    // decompiled from Move bytecode v6
}

