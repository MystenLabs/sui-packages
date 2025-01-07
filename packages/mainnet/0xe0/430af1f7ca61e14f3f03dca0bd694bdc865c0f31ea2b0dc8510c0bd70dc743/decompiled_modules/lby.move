module 0xe0430af1f7ca61e14f3f03dca0bd694bdc865c0f31ea2b0dc8510c0bd70dc743::lby {
    struct LBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LBY>(arg0, 9, b"LBY", b"Liberty ", b"Liberty token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/43aedd76-1ef6-419d-9374-2ac976f5bd0e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

