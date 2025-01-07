module 0xb88a0f6d193d41a53e6dae4e7b81127f78639e15c9559145cc30725a1c53c1f3::shm {
    struct SHM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHM>(arg0, 9, b"SHM", b"Shoma", b"Shoma Elon support ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f957369d-47a7-4602-8ab9-75108a73f924.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHM>>(v1);
    }

    // decompiled from Move bytecode v6
}

