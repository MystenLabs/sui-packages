module 0x4261a694c9a2601d5aefa1631d7ef98f92ac6c0088c4898f4f04546909d37ee4::usdt3 {
    struct USDT3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDT3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDT3>(arg0, 9, b"USDT                                       .", b"USDT                                       .", b"USDC Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.postimg.cc/7hPDVYQd/BASE-USDT2.jpg"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<USDT3>>(0x2::coin::mint<USDT3>(&mut v2, 210000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDT3>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<USDT3>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

