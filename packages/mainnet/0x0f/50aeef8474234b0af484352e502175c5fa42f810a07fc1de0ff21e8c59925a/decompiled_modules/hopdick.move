module 0xf50aeef8474234b0af484352e502175c5fa42f810a07fc1de0ff21e8c59925a::hopdick {
    struct HOPDICK has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPDICK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPDICK>(arg0, 6, b"HOPDICK", b"HOP DICK", b"a community-driven cryptocurrency inspired by the fast, energetic and playful spirit of dick. Hopper combines the power of meme culture with the accessibility of SUI blockchain, creating a vibrant, fast-growing ecosystem where anyone can join the ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731011455890.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOPDICK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPDICK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

