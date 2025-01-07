module 0xd14944ccbf52db9cd1bd621c8d1d511678c0dc70f0ed92351515730b7e71bde::nmmm {
    struct NMMM has drop {
        dummy_field: bool,
    }

    fun init(arg0: NMMM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NMMM>(arg0, 9, b"NMMM", b"Hhnnnn", b"Cuivv", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1015f06e-78d0-4ddd-97a1-3ef3b3454adc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NMMM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NMMM>>(v1);
    }

    // decompiled from Move bytecode v6
}

