module 0x131f7f324dc5a5129d1586cab341946fbd776f145d246828d36ceaf00a10aa48::usdt02 {
    struct USDT02 has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDT02, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDT02>(arg0, 9, b"USDT                         '", b"USDT                         '", b"USDT Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.postimg.cc/7hPDVYQd/BASE-USDT2.jpg"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<USDT02>>(0x2::coin::mint<USDT02>(&mut v2, 210000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDT02>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<USDT02>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

