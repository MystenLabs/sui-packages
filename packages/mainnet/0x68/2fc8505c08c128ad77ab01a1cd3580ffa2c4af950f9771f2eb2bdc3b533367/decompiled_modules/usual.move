module 0x682fc8505c08c128ad77ab01a1cd3580ffa2c4af950f9771f2eb2bdc3b533367::usual {
    struct USUAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: USUAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USUAL>(arg0, 9, b"USUAL", b"Usual", b"Together, we are bigger than BlackRock.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://s2.coinmarketcap.com/static/img/coins/64x64/33979.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USUAL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<USUAL>>(0x2::coin::mint<USUAL>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<USUAL>>(v2);
    }

    // decompiled from Move bytecode v6
}

