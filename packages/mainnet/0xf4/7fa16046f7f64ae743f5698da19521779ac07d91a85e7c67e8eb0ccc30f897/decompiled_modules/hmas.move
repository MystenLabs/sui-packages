module 0xf47fa16046f7f64ae743f5698da19521779ac07d91a85e7c67e8eb0ccc30f897::hmas {
    struct HMAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: HMAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HMAS>(arg0, 9, b"HMAS", b"Hamster", b"Hamster luck", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fa311cc1-15e4-4a5d-b8d6-23980619ce35.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HMAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HMAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

