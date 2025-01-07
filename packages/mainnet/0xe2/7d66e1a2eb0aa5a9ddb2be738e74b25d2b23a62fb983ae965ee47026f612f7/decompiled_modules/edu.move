module 0xe27d66e1a2eb0aa5a9ddb2be738e74b25d2b23a62fb983ae965ee47026f612f7::edu {
    struct EDU has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<EDU>, arg1: 0x2::coin::Coin<EDU>) {
        0x2::coin::burn<EDU>(arg0, arg1);
    }

    public entry fun custom_burn(arg0: &mut 0x2::coin::TreasuryCap<EDU>, arg1: &mut 0x2::coin::Coin<EDU>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<EDU>(arg0, 0x2::coin::split<EDU>(arg1, arg2, arg3));
    }

    fun init(arg0: EDU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EDU>(arg0, 6, b"EDU", b"EDU", b"EDU Meme on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://s2.coinmarketcap.com/static/img/coins/64x64/2951.png"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<EDU>(&mut v2, 314000000000000000, @0xffed1e3a3b44c55d8a1300bf9ad7abb11825d45e66ab4bcadb5f7b5f4bce7d3a, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EDU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EDU>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

