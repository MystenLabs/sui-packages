module 0x95bccb96b5454edb62c034ca783a9ea71a1475397af2ed2f2002594a9d25970a::shah {
    struct SHAH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHAH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHAH>(arg0, 9, b"SHAH", b"Shiushan", b"Just for fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a07a0103-b236-4943-9f6a-bec33e623da9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHAH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHAH>>(v1);
    }

    // decompiled from Move bytecode v6
}

