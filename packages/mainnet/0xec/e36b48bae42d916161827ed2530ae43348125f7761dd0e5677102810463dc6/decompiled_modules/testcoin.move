module 0xece36b48bae42d916161827ed2530ae43348125f7761dd0e5677102810463dc6::testcoin {
    struct TESTCOIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TESTCOIN>, arg1: 0x2::coin::Coin<TESTCOIN>) {
        0x2::coin::burn<TESTCOIN>(arg0, arg1);
    }

    public fun get_total_supply(arg0: &0x2::coin::TreasuryCap<TESTCOIN>) : u64 {
        get_total_supply(arg0)
    }

    fun init(arg0: TESTCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTCOIN>(arg0, 9, b"TABLE", b"TESTCOIN", b"testcoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://img.freepik.com/vektoren-premium/larve-im-pixel-art-stil_475147-1547.jpg?w=1380"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TESTCOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTCOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TESTCOIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg1 + get_total_supply(arg0) > 1000000) {
            abort 0
        };
        0x2::coin::mint_and_transfer<TESTCOIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

