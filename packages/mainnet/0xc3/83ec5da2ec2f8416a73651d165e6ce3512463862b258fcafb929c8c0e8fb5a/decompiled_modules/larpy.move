module 0xc383ec5da2ec2f8416a73651d165e6ce3512463862b258fcafb929c8c0e8fb5a::larpy {
    struct LARPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LARPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LARPY>(arg0, 6, b"LARPY", b"Larpy Arty | Fake Capital", b"Tinder Bio: I'm LARPY a washed up DJ & love to wear lady girl shirts!! I make male AI NFT's & love talking to men on subscriber only spaces!! BUY SOLANA AT $200 & BUY my token its my pump & dump FAKE|CAPITAL!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_20_015127_a57573d5b7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LARPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LARPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

