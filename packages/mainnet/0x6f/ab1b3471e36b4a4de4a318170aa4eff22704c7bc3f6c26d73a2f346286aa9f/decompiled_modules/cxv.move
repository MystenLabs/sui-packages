module 0x6fab1b3471e36b4a4de4a318170aa4eff22704c7bc3f6c26d73a2f346286aa9f::cxv {
    struct CXV has drop {
        dummy_field: bool,
    }

    fun init(arg0: CXV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CXV>(arg0, 9, b"CXV", b"BHF", b"VXC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/83cd9fec-f9f7-454c-a8e1-24f0f47180fe.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CXV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CXV>>(v1);
    }

    // decompiled from Move bytecode v6
}

