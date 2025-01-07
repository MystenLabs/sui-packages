module 0x5996836476ee21d5364bbfb2e8dd446fc7e9644a019f9f8cac6909bf052c20bc::mulaa {
    struct MULAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MULAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MULAA>(arg0, 9, b"MULAA", b"MULA", b"MULAAA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6779732a-5854-43af-a913-5e300d9fa096.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MULAA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MULAA>>(v1);
    }

    // decompiled from Move bytecode v6
}

