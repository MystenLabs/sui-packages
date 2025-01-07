module 0x1df6f134e5e924d2d0fdc45ab8e6a05db9b659a5aa3ac1a6ab2c646e279cb163::dogskas {
    struct DOGSKAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGSKAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGSKAS>(arg0, 9, b"DOGSKAS", b"Wewe", b"Gi you my tu day not ting ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/55ee54f1-e92d-4b10-9033-368eaa9f2767.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGSKAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGSKAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

