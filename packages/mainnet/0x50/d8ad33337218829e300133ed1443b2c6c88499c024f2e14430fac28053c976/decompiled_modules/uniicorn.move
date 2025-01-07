module 0x50d8ad33337218829e300133ed1443b2c6c88499c024f2e14430fac28053c976::uniicorn {
    struct UNIICORN has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNIICORN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UNIICORN>(arg0, 6, b"UNIICORN", b"Uniicorn", b"UNIICORN is a meme token built on the Solana blockchain, representing the magic and allure of the mythical creature, the unicorn. Like the legendary unicorn's spiral horn, UNICORN symbolizes an endless cycle of fun, community, and limitless potential. Born from the power of Solana, our token is designed for those who love memes, crypto, and fast transactions. Whether youre a meme enthusiast, a Solana fan, or someone who just loves unique and fun tokens, UNICORN is here to make your crypto journey more magical.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/45345_15364ff6f1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNIICORN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UNIICORN>>(v1);
    }

    // decompiled from Move bytecode v6
}

