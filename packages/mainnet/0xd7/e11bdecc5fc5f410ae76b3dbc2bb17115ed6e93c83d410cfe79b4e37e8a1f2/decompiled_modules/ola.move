module 0xd7e11bdecc5fc5f410ae76b3dbc2bb17115ed6e93c83d410cfe79b4e37e8a1f2::ola {
    struct OLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: OLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OLA>(arg0, 9, b"OLA", b"Mim", b"Great token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ded3134d-0e46-44a1-9130-324249bf6f6c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

