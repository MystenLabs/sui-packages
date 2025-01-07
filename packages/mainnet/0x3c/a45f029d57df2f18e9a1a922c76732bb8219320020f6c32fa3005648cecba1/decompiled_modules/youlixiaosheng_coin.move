module 0x3ca45f029d57df2f18e9a1a922c76732bb8219320020f6c32fa3005648cecba1::youlixiaosheng_coin {
    struct YOULIXIAOSHENG_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<YOULIXIAOSHENG_COIN>, arg1: 0x2::coin::Coin<YOULIXIAOSHENG_COIN>) {
        0x2::coin::burn<YOULIXIAOSHENG_COIN>(arg0, arg1);
    }

    fun init(arg0: YOULIXIAOSHENG_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YOULIXIAOSHENG_COIN>(arg0, 9, b"YOULIXIAOSHENG_COIN", b"youlixiaosheng", b"youlixiaosheng", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/147264753?v=4")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YOULIXIAOSHENG_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YOULIXIAOSHENG_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<YOULIXIAOSHENG_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<YOULIXIAOSHENG_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

