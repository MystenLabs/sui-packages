module 0x5b3536cbc24ce49a99c4283cdf6ca4c620060192e969616eb5bec6592b5c7720::hnz {
    struct HNZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: HNZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HNZ>(arg0, 9, b"HNZ", b"HUNZA", b"This token is made for promote tourism in Gilgitbaltistan, the land of Glaciers and beautiful mountains, natural lakes and unique Landscaping.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ffe104d9-a206-4318-8bf6-b21d959b24b6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HNZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HNZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

