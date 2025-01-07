module 0x3ca36bf8012f83f6768752229a912bdff1304c5eef36688d88d41f17b2f18dd5::elontrump {
    struct ELONTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELONTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELONTRUMP>(arg0, 9, b"ELONTRUMP", b"ELON", b"Elon is a meme that symbolizes the strong financial power of Elon Musk, symbolizing the public's love for his idol Elon Mush", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6f246769-98ee-4c64-9d8b-8a1f3f141434.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELONTRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ELONTRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

