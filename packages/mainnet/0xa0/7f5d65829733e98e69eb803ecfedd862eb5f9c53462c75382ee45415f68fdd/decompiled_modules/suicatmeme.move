module 0xa07f5d65829733e98e69eb803ecfedd862eb5f9c53462c75382ee45415f68fdd::suicatmeme {
    struct SUICATMEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICATMEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICATMEME>(arg0, 9, b"SUICATMEME", b"Suicat", b"Suicatmeme to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9c29562d-d5b6-4323-bcfd-f811794eed1c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICATMEME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUICATMEME>>(v1);
    }

    // decompiled from Move bytecode v6
}

