module 0x316d2d2344c3b0b47b63ddfcaf96d969862c0c7e4a8d90f020d8450e831b4f07::usdegen {
    struct USDEGEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDEGEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDEGEN>(arg0, 9, b"USDEGEN", b"DXY", b"On a mission to onboard the next 1.000.000 degens", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f2efdc4e-9fcb-4cc3-bbf7-d2ba592c6065.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDEGEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USDEGEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

