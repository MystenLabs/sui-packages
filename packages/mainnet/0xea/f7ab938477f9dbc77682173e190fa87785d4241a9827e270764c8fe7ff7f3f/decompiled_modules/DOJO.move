module 0xeaf7ab938477f9dbc77682173e190fa87785d4241a9827e270764c8fe7ff7f3f::DOJO {
    struct DOJO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOJO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOJO>(arg0, 9, b"FLUB", b"Flub Coin", b"Flub Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1747274420392173568/BaGsz4TA_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOJO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOJO>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DOJO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DOJO>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

