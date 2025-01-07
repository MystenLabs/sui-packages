module 0x2377757545957b17f23ecb253d61eb24dc240e5c2dda5b0b7d91f5f3d0f7292c::humancoin {
    struct HUMANCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUMANCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HUMANCOIN>(arg0, 9, b"HUMANCOIN", b"Human", x"746f2062652072696368f09f91be", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/12399f9f-2f6d-40ef-923e-1933716b9ccc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUMANCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HUMANCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

