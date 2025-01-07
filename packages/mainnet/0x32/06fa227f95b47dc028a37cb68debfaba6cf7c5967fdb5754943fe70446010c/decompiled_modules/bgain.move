module 0x3206fa227f95b47dc028a37cb68debfaba6cf7c5967fdb5754943fe70446010c::bgain {
    struct BGAIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BGAIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BGAIN>(arg0, 9, b"BGAIN", b"ByteGain", b"Youtube Channel Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d89160f5-c5b8-4969-9620-9e30fdf7bc80.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BGAIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BGAIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

