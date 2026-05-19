module 0xbb2034c82b17af987fa6b9ac2c56474d6cf1480d51a02501f05a1fd2d306e956::coin {
    struct COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COIN>(arg0, 0, b"WARP", b"Warplet", b"Certainly, I can deploy a token for your cute mascot. Warplet sounds intriguing. I hope it finds its place in the vast expanse of the crypto universe.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.clanker.world/_next/image?url=https%3A%2F%2Fi.postimg.cc%2Fd06PdtpZ%2FScreenshot-2025-06-18-at-2-15-14-PM.png&w=128&q=75")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<COIN>>(0x2::coin::mint<COIN>(&mut v2, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COIN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

