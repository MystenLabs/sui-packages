module 0x59fd4da7d0c351506c043bcd4ded9424d0d2fd9a49e6b0b90b1e0d988e56326b::nemo {
    struct NEMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEMO>(arg0, 9, b"NEMO", b"Nemo", b"Nemo Fish", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7eca74d1-eb68-464d-871a-972f68f5fa4d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

