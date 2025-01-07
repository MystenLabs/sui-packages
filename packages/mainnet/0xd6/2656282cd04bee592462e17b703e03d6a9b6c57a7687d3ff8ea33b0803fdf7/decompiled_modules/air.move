module 0xd62656282cd04bee592462e17b703e03d6a9b6c57a7687d3ff8ea33b0803fdf7::air {
    struct AIR has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIR>(arg0, 9, b"AIR", b"Rakibur ", b"This meme is so existing. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0416fd96-fffb-435f-bf21-99f1a925f4b4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AIR>>(v1);
    }

    // decompiled from Move bytecode v6
}

