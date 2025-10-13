module 0x11dbd51fe53038b3da9046f9fd8d6a1cb5ab7854e221a8bffe8e042f249a36fe::usda_token {
    struct USDA_TOKEN has drop {
        dummy_field: bool,
    }

    public fun get_coin_value(arg0: &0x2::coin::Coin<USDA_TOKEN>) : u64 {
        0x2::coin::value<USDA_TOKEN>(arg0)
    }

    fun init(arg0: USDA_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDA_TOKEN>(arg0, 9, b"USDA", b"MyUSD Token", b"MyUSD Token is for testing", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USDA_TOKEN>>(v1);
        0x2::coin::mint_and_transfer<USDA_TOKEN>(&mut v2, 1000000000000000000, @0xdcae43381276d12e7a291494fd5951f843bb0e6fbced37fac15527b3965f1564, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<USDA_TOKEN>>(v2);
    }

    public entry fun join_coins(arg0: &mut 0x2::coin::Coin<USDA_TOKEN>, arg1: 0x2::coin::Coin<USDA_TOKEN>) {
        0x2::coin::join<USDA_TOKEN>(arg0, arg1);
    }

    public entry fun split_coin(arg0: &mut 0x2::coin::Coin<USDA_TOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<USDA_TOKEN>>(0x2::coin::split<USDA_TOKEN>(arg0, arg1, arg3), arg2);
    }

    public entry fun transfer_coin(arg0: 0x2::coin::Coin<USDA_TOKEN>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<USDA_TOKEN>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

