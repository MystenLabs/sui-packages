module 0x9aba5c0591b8debc9da0ef70d5bf857edf2f16bcca2066068cb6123cab35d867::helio {
    struct HELIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HELIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HELIO>(arg0, 9, b"HELIO", b"HELIO AI", b"Explore, Expose, and Discover with Helio. Advanced AI Meets Blockchain for Actionable Insights - powered by DeepSeek", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.dexscreener.com/cms/images/3ho1Oa54cUtIyWOP")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HELIO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HELIO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HELIO>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

