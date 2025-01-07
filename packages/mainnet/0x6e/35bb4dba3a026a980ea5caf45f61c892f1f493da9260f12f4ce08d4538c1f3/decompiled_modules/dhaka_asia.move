module 0x6e35bb4dba3a026a980ea5caf45f61c892f1f493da9260f12f4ce08d4538c1f3::dhaka_asia {
    struct DHAKA_ASIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DHAKA_ASIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DHAKA_ASIA>(arg0, 9, b"DHAKA_ASIA", b"DJ", b"Get it ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2fc589fa-0726-42b8-9933-b3efa98a5971.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DHAKA_ASIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DHAKA_ASIA>>(v1);
    }

    // decompiled from Move bytecode v6
}

