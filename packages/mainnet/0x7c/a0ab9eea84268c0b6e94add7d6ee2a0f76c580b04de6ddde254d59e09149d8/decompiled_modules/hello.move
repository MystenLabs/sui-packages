module 0x7ca0ab9eea84268c0b6e94add7d6ee2a0f76c580b04de6ddde254d59e09149d8::hello {
    struct HELLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HELLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HELLO>(arg0, 6, b"HELLO", b"HELLO", b"HELLO Coin for bet gaming protocol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://s2.coinmarketcap.com/static/img/coins/64x64/20947.png"))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HELLO>>(v1);
        0x2::coin::mint_and_transfer<HELLO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HELLO>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

