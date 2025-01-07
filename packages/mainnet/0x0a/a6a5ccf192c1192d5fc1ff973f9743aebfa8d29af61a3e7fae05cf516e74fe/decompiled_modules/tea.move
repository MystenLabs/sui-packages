module 0xaa6a5ccf192c1192d5fc1ff973f9743aebfa8d29af61a3e7fae05cf516e74fe::tea {
    struct TEA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEA>(arg0, 9, b"TEA", b"Tea", x"4c657473206472696e6b2074656120e29895efb88f20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3c8612e7-ad7c-4887-951d-5fbb1753091b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEA>>(v1);
    }

    // decompiled from Move bytecode v6
}

