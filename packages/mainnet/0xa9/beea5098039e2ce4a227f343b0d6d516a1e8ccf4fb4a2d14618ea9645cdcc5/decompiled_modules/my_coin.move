module 0xa9beea5098039e2ce4a227f343b0d6d516a1e8ccf4fb4a2d14618ea9645cdcc5::my_coin {
    struct MY_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<MY_COIN>, arg1: 0x2::coin::Coin<MY_COIN>) {
        let v0 = 0x1::ascii::string(b"burn");
        0x1::debug::print<0x1::ascii::String>(&v0);
        0x2::coin::burn<MY_COIN>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MY_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::ascii::string(b"mint");
        0x1::debug::print<0x1::ascii::String>(&v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<MY_COIN>>(0x2::coin::mint<MY_COIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: MY_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::ascii::string(b"init MY_COIN");
        0x1::debug::print<0x1::ascii::String>(&v0);
        let (v1, v2) = 0x2::coin::create_currency<MY_COIN>(arg0, 8, b"MyCoin", b"My Coin", b"My coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://avatars.githubusercontent.com/u/36093027?v=4"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MY_COIN>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MY_COIN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

