module 0xf141610a2976b9583f251f972f4bf03f7543f05ce524249f0e04138cd425b4a1::suitradingbot {
    struct SUITRADINGBOT has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUITRADINGBOT>, arg1: 0x2::coin::Coin<SUITRADINGBOT>) {
        0x2::coin::burn<SUITRADINGBOT>(arg0, arg1);
    }

    fun init(arg0: SUITRADINGBOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITRADINGBOT>(arg0, 9, b"sbot", b"sui trading bot", b"Discover Sui Trading Bot, the top Telegram trading bot, revolutionizing DeFi on Sui Network. Our advanced technology offers unmatched trading and sniping tools, redefining digital asset trading", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/rI8HXGl.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUITRADINGBOT>>(v1);
        0x2::coin::mint_and_transfer<SUITRADINGBOT>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITRADINGBOT>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUITRADINGBOT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUITRADINGBOT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

