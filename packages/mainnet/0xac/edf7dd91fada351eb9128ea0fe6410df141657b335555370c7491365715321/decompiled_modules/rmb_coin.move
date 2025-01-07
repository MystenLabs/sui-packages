module 0xacedf7dd91fada351eb9128ea0fe6410df141657b335555370c7491365715321::rmb_coin {
    struct RMB_COIN has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<RMB_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::ascii::string(b"mint");
        0x1::debug::print<0x1::ascii::String>(&v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<RMB_COIN>>(0x2::coin::mint<RMB_COIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: RMB_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RMB_COIN>(arg0, 8, b"SuiRMB", b"Sui RMB", b"My first coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://avatars.githubusercontent.com/u/36093027?v=4"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RMB_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RMB_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun test_for_init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::ascii::string(b"init");
        0x1::debug::print<0x1::ascii::String>(&v0);
    }

    // decompiled from Move bytecode v6
}

