module 0x631facd552add352b821c6f7a18ff1033080c51ec9b170834749126649c0c160::aumeta {
    struct AUMETA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AUMETA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AUMETA>(arg0, 9, b"AUMETA", b"AuraMeta", b"New meme coin for aurora network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0f6d5371-e6cb-4f0c-916b-0db978c2461a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AUMETA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AUMETA>>(v1);
    }

    // decompiled from Move bytecode v6
}

