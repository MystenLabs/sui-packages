module 0xb729163b66a6ed4ae5d7352e7bbf16573548827c22464554caf0f5a8b8c89a4::my_coin {
    struct MY_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MY_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MY_COIN>(arg0, 6, b"windynanzi", b"Windy", b"test2", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://cdn.icon-icons.com/icons2/1865/PNG/96/dogbaby_119594.png"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MY_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MY_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint_in_my_module(arg0: &mut 0x2::coin::TreasuryCap<MY_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MY_COIN>>(0x2::coin::mint<MY_COIN>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

