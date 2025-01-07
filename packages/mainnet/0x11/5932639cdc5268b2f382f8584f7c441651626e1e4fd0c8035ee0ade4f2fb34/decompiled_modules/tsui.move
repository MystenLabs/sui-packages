module 0x115932639cdc5268b2f382f8584f7c441651626e1e4fd0c8035ee0ade4f2fb34::tsui {
    struct TSUI has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<TSUI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TSUI>>(0x2::coin::mint<TSUI>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: TSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSUI>(arg0, 6, b"TSUI", b"test_coin", b"test coin on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://drive.google.com/file/d/1loGxIqfEdR073wcHoeeVk74mPi-ZbfF8/view"))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<TSUI>>(0x2::coin::mint<TSUI>(&mut v2, 10000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSUI>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

