module 0x177dac5794c3a095c919e49004e647c393b0b5434f44a2ad3fa57bd9f4bfa96e::pump420x {
    struct PUMP420X has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUMP420X, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUMP420X>(arg0, 6, b"PUMP420X", b"SkibidiSigmaRizzGyattOhio", b"I asked Grok to make me the first 1 billion dollar meme coin on Sui using the biggest brainrot memes of 2024 with a hype ticker this was the outcome #PUMP420X", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3559_7e4baa96c4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUMP420X>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUMP420X>>(v1);
    }

    // decompiled from Move bytecode v6
}

