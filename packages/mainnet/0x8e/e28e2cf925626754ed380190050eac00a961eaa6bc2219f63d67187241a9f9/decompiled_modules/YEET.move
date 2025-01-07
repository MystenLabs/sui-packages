module 0x8ee28e2cf925626754ed380190050eac00a961eaa6bc2219f63d67187241a9f9::YEET {
    struct YEET has drop {
        dummy_field: bool,
    }

    entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<YEET>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<YEET>>(0x2::coin::mint<YEET>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: YEET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YEET>(arg0, 9, b"YEET.", b"YEETSUI COIN", b"The second most memeorable coin in existence. #YEET Join here: http://t.me/yayeetyayeet", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://pbs.twimg.com/profile_images/1654041081884073984/CHsotDTG_400x400.jpg"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<YEET>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::coin::mint_and_transfer<YEET>(&mut v2, 100000000000000000, @0xbdedba87cb17d32f782b7c07a56c85fbd4223c0bac6500a7e6ece0cf0cbe4548, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YEET>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<YEET>>(v1, 0x2::tx_context::sender(arg1));
    }

    entry fun renounce(arg0: &mut 0x2::coin::TreasuryCap<YEET>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<YEET>>(0x2::coin::mint<YEET>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

