module 0x87c9d5fbcbb2d04db0cb61f26afb2f2924457aefbb63289ee4a7c80fb5859f8c::rad_coin {
    struct RAD_COIN has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<RAD_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::total_supply<RAD_COIN>(arg0) + arg1 <= 1000000000000000000, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<RAD_COIN>>(0x2::coin::mint<RAD_COIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: RAD_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAD_COIN>(arg0, 9, b"RAD", b"RAD TOKEN", b"Radiantarena native token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::string::to_ascii(0x1::string::utf8(b"https://launcher.radiantarena.com/favicon.svg")))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RAD_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAD_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

