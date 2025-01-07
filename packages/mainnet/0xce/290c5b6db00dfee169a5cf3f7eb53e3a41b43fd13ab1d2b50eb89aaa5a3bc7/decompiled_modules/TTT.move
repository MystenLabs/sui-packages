module 0xce290c5b6db00dfee169a5cf3f7eb53e3a41b43fd13ab1d2b50eb89aaa5a3bc7::TTT {
    struct TTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TTT>(arg0, 9, b"TTT", b"TTT", b"TTT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://s2.coinmarketcap.com/static/img/coins/64x64/1.png"))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TTT>>(v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TTT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<TTT>>(0x2::coin::mint<TTT>(&mut v2, 100000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

