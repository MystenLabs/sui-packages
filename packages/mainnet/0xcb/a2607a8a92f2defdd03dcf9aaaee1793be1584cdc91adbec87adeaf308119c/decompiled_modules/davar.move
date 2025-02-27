module 0xcba2607a8a92f2defdd03dcf9aaaee1793be1584cdc91adbec87adeaf308119c::davar {
    struct DAVAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAVAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAVAR>(arg0, 9, b"DAVAR", b"Hasan ", b"Smil", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1ca3777e-f9ef-48be-8b0e-2f5240ab09f4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAVAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DAVAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

