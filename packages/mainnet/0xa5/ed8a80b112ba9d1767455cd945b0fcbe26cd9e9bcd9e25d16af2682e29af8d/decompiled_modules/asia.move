module 0xa5ed8a80b112ba9d1767455cd945b0fcbe26cd9e9bcd9e25d16af2682e29af8d::asia {
    struct ASIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASIA>(arg0, 9, b"ASIA", b"DRAGON", b"Fly high", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6b6ac55b-562d-4e6a-97fc-e1abd95f0bc1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ASIA>>(v1);
    }

    // decompiled from Move bytecode v6
}

