module 0x4258003fb1d0e228902e56ddbcb6b35a8b5f6654950ba948b6628a15ddb364cc::grok {
    struct GROK has drop {
        dummy_field: bool,
    }

    fun init(arg0: GROK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GROK>(arg0, 9, b"GROK", b"Grok Sui", b"nothing but just a grok meme based off elon musk's first product on xAI, grok chatgpt like system", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/34a5279a-aa0e-4be3-b06a-e8c985accd5d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GROK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GROK>>(v1);
    }

    // decompiled from Move bytecode v6
}

