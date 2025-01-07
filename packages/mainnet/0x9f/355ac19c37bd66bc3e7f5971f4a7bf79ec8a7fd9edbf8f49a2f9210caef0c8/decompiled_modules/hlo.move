module 0x9f355ac19c37bd66bc3e7f5971f4a7bf79ec8a7fd9edbf8f49a2f9210caef0c8::hlo {
    struct HLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HLO>(arg0, 9, b"HLO", b"HELLO", b"h1 w0rld!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cc87b003-8cf8-4c4f-b4dc-78e24a91cb9b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HLO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HLO>>(v1);
    }

    // decompiled from Move bytecode v6
}

