module 0xee92229d19ce3bbd0e1087b970925c39812a270ba6de06f5ec959869d1100b66::tickerovic {
    struct TICKEROVIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: TICKEROVIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TICKEROVIC>(arg0, 9, b"TICKEROVIC", b"Testov", b"Descriptor", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1be406a6-29f1-4890-bbd8-9ed122a07368.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TICKEROVIC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TICKEROVIC>>(v1);
    }

    // decompiled from Move bytecode v6
}

