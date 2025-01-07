module 0x8b21750563e8a115627b6e5fc8fb08b4740de75a7f37b438ab4705a378702e78::lazio {
    struct LAZIO has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<LAZIO>, arg1: 0x2::coin::Coin<LAZIO>) {
        0x2::coin::burn<LAZIO>(arg0, arg1);
    }

    public entry fun custom_burn(arg0: &mut 0x2::coin::TreasuryCap<LAZIO>, arg1: &mut 0x2::coin::Coin<LAZIO>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<LAZIO>(arg0, 0x2::coin::split<LAZIO>(arg1, arg2, arg3));
    }

    fun init(arg0: LAZIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAZIO>(arg0, 6, b"LAZIO", b"LAZIO", b"S.S. Lazio Fan Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://assets.coingecko.com/coins/images/19263/large/B4Lla6V6_400x400.png"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LAZIO>(&mut v2, 500000000000000000, @0xffed1e3a3b44c55d8a1300bf9ad7abb11825d45e66ab4bcadb5f7b5f4bce7d3a, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LAZIO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAZIO>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

