module 0x2a636535237a3f9f17ec146b073b3a22d37c336792649e7575426d5a13517297::oyen {
    struct OYEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: OYEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OYEN>(arg0, 9, b"OYEN", b"Oyen", b"Orange Domestic Cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4e603d31-4801-4ab4-b6d9-7eb9016ef634.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OYEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OYEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

