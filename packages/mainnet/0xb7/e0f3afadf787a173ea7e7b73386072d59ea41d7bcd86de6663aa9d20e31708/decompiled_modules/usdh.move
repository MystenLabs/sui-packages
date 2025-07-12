module 0xb7e0f3afadf787a173ea7e7b73386072d59ea41d7bcd86de6663aa9d20e31708::usdh {
    struct USDH has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDH>(arg0, 9, b"USDH", b"USDH Token", b"USDH Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://img.bgstatic.com/multiLang/coinPriceLogo/ae0e28b6052889bc2a46c4acd0ab44f51711213630630.png"))), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDH>>(v0, v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<USDH>>(v1, v2);
    }

    // decompiled from Move bytecode v6
}

