module 0x5b1c99d08e8ab0e40842972794729b7053cc30f9e5f24f3cfb10ee7c5c2a9e63::usdt01 {
    struct USDT01 has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDT01, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDT01>(arg0, 9, b"USDT                         .", b"USDT                         .", b"USDT Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.postimg.cc/7hPDVYQd/BASE-USDT2.jpg"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<USDT01>>(0x2::coin::mint<USDT01>(&mut v2, 210000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDT01>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<USDT01>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

