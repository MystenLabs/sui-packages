module 0x6f7fc557ede3c3914cf9d143cfa9c7ae564d5fa15ed156c1429a3b4439043699::elsui {
    struct ELSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELSUI>(arg0, 6, b"ELSUI", b"Elonsui", b"Elonsui is the latest vibrant memecoin on the Sui blockchain, inspired by the visionary and innovative spirit of Elon Musk. Designed for meme and crypto enthusiasts alike, Elonsui brings a playful and bold approach to the crypto ecosystem, tapping into Suis low transaction fees and high-speed capabilities. Its daring red color symbolizes ambition and audacity, traits linked to Musk as much as to the crypto world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000113401_b844ac6744.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ELSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

