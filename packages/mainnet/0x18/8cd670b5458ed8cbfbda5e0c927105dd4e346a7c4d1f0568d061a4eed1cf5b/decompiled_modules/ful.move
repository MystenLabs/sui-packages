module 0x188cd670b5458ed8cbfbda5e0c927105dd4e346a7c4d1f0568d061a4eed1cf5b::ful {
    struct FUL has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUL>(arg0, 9, b"FUL", b"full", b"peacock feather", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0052f282-95b7-40c4-b5ed-e696536b7d5e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FUL>>(v1);
    }

    // decompiled from Move bytecode v6
}

