module 0xd0f57f8c7dca1f441766acc26c1831a2b2148d5d02ee3a6e9a876b9a98bb3951::ottr {
    struct OTTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: OTTR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OTTR>(arg0, 9, b"OTTR", b"Otter", b"Happy Otter", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/62c41e57-c566-47bd-8e0b-313e369ff9c1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OTTR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OTTR>>(v1);
    }

    // decompiled from Move bytecode v6
}

