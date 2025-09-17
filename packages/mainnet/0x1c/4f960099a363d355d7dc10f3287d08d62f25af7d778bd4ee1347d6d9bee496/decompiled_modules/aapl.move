module 0x1c4f960099a363d355d7dc10f3287d08d62f25af7d778bd4ee1347d6d9bee496::aapl {
    struct AAPL has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAPL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAPL>(arg0, 9, b"sAAPL", b"Apple Inc. Stock - Stablestock", b"Apple Inc. stock token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://resource-s3.stablestock.finance/icon/tokens/sAAPL.jpg"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAPL>>(v0, @0x1edc108fff0653430f322528e21046ddd1e4ee52638d4f0ebc7f1251bd5e14eb);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AAPL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

