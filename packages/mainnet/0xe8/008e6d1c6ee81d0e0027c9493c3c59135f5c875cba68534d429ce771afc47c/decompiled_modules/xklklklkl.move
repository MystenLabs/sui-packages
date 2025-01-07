module 0xe8008e6d1c6ee81d0e0027c9493c3c59135f5c875cba68534d429ce771afc47c::xklklklkl {
    struct XKLKLKLKL has drop {
        dummy_field: bool,
    }

    fun init(arg0: XKLKLKLKL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XKLKLKLKL>(arg0, 9, b"XKLKLKLKL", b"jhjhjhhk", b"hgjhgjhg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/07dc7e7d-15ac-4d3f-91f6-f25fa0daacc6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XKLKLKLKL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XKLKLKLKL>>(v1);
    }

    // decompiled from Move bytecode v6
}

