module 0x7ed6664f89216b5a9ce76fb0ab96ff1e184f030545637911613c02c9101512fd::memecoin {
    struct MEMECOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMECOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMECOIN>(arg0, 9, b"MEMECOIN", b"Kassidi", b"I have no idea what I'm doing I just want to get lucky sometimes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4edb347b-c196-4f0b-b2a1-281cbbd6b35c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMECOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMECOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

