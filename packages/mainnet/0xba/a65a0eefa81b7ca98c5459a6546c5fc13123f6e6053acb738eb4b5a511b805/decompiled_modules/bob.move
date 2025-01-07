module 0xbaa65a0eefa81b7ca98c5459a6546c5fc13123f6e6053acb738eb4b5a511b805::bob {
    struct BOB has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BOB>, arg1: 0x2::coin::Coin<BOB>) {
        0x2::coin::burn<BOB>(arg0, arg1);
    }

    public entry fun custom_burn(arg0: &mut 0x2::coin::TreasuryCap<BOB>, arg1: &mut 0x2::coin::Coin<BOB>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<BOB>(arg0, 0x2::coin::split<BOB>(arg1, arg2, arg3));
    }

    fun init(arg0: BOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOB>(arg0, 6, b"BOB", b"BOB", b"BOB Meme on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://s2.coinmarketcap.com/static/img/coins/64x64/24594.png"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BOB>(&mut v2, 314000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOB>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

