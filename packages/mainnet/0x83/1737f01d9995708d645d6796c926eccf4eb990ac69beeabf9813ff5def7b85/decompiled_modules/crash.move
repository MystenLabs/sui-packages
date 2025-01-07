module 0x831737f01d9995708d645d6796c926eccf4eb990ac69beeabf9813ff5def7b85::crash {
    struct CRASH has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRASH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRASH>(arg0, 6, b"CRASH", b"CRASH  SUI", b"$CRASH is a tribute coin in honor to the best coin caller of all times @CrashSui the Warren Buffet of meme coins. Crashs trading career is a testament to his adaptability and success. He initially made a name for himself in the stock market, publicly sharing his strategies on Crash Trading on Telegram since August 28, 2020. However, he didnt stop there. He transitioned to the crypto space, earning the nickname Crash after successfully shorting the top of Bitcoin at $69k and placing his longs at the bottom, at $16K. His journey didnt end with trading, as he ventured into the meme space, where he famously called Brett and turned $15k into over $10 million and counting.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_15_03_36_49_2ddbb7f10b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRASH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRASH>>(v1);
    }

    // decompiled from Move bytecode v6
}

