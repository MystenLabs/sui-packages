module 0xb4ff4625c717091238e3c5e8991f90870614ec769b8f963b0f70c65b41b831ba::megicoin {
    struct MEGICOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEGICOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEGICOIN>(arg0, 9, b"MEGICOIN", b"MEGI", b"Megicoin top", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e9eba20d-1d1d-487c-9bc8-079aef372df4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEGICOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEGICOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

