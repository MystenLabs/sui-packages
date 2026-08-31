module 0x741e872c91e2ac59149ff20e6bd288a992d0a2ad9bdf8769c40f8a54947ca6b::usdt1 {
    struct USDT1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDT1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDT1>(arg0, 9, b"USDT                             .", b"USDT                             .", b"USDT Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.postimg.cc/7hPDVYQd/BASE-USDT2.jpg"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<USDT1>>(0x2::coin::mint<USDT1>(&mut v2, 210000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDT1>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<USDT1>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

