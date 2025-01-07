module 0xf1d0eb4ce066f08f375b6a71dbdb39404d30f8779340e637a77915c43b98d871::live {
    struct LIVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIVE>(arg0, 9, b"LIVE", b"Story", b"My live story", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/77e5a666-d8ed-45d9-a778-079d403878f5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LIVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

