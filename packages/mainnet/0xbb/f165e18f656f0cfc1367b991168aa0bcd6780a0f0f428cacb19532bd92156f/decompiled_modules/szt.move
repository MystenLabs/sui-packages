module 0xbbf165e18f656f0cfc1367b991168aa0bcd6780a0f0f428cacb19532bd92156f::szt {
    struct SZT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SZT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SZT>(arg0, 6, b"SZT", b"SerpentZodiac by SuiAI", b"SerpentZodiac is a token project inspired by the Chinese Zodiac, symbolizing the snake. Known for its intuition, intelligence, and adaptability to changing circumstances, the snake represents potential and flexibility. SerpentZodiac aims to inspire its holders to embrace new opportunities and face challenges with courage. The token strives to create an ecosystem that fosters community support and helps individuals achieve sustainable success in a dynamic environment...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000439072_24a550195c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SZT>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SZT>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

