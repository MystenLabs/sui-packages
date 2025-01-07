module 0x9c19b7fcd507af53d1374cf1242ab7e5742091c92a901cb84952e5d9ca42ac16::elonsui {
    struct ELONSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELONSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELONSUI>(arg0, 9, b"ELONSUI", b"Suimusl", b"Elon musk are bullish on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f18a69aa-17e3-42d3-bb74-3a3ba4418177-2F89A61F-4374-426F-A251-92F128080A17.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELONSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ELONSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

