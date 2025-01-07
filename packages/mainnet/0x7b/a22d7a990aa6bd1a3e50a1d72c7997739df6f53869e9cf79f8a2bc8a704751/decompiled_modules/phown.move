module 0x7ba22d7a990aa6bd1a3e50a1d72c7997739df6f53869e9cf79f8a2bc8a704751::phown {
    struct PHOWN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PHOWN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PHOWN>(arg0, 6, b"Phown", b"Phown ", b"Phown Connect isn't just another meme coin - it's a movement. Born on the Sui blockchain, Phown Connect (a clever play on \"phone connect\") is set to revolutionize the crypto landscape and bring a wave of new adopters to the Sui ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731614261306.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PHOWN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PHOWN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

