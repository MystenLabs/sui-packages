module 0x29c94afc1a966872de33cfa526d4f23d2eec6f7dbc788d816d7ef24642cfb5d::sex_islife {
    struct SEX_ISLIFE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEX_ISLIFE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEX_ISLIFE>(arg0, 9, b"SEX_ISLIFE", b"Sexy Coin", b"No Sexy No Life, Sex is Real Life, $Sex Coin Is Now Opened. buying Now Fu..ck & Sex Everything Now", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/39af4b28-a99f-4200-b2d8-e2284b93c5f0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEX_ISLIFE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SEX_ISLIFE>>(v1);
    }

    // decompiled from Move bytecode v6
}

