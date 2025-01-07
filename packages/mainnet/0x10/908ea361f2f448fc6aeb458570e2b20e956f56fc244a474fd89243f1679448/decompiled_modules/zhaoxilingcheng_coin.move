module 0x10908ea361f2f448fc6aeb458570e2b20e956f56fc244a474fd89243f1679448::zhaoxilingcheng_coin {
    struct ZHAOXILINGCHENG_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<ZHAOXILINGCHENG_COIN>, arg1: 0x2::coin::Coin<ZHAOXILINGCHENG_COIN>) {
        0x2::coin::burn<ZHAOXILINGCHENG_COIN>(arg0, arg1);
    }

    fun init(arg0: ZHAOXILINGCHENG_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZHAOXILINGCHENG_COIN>(arg0, 9, b"ZHAOXILINGCHENG_COIN", b"zhaoxilingcheng", b"this is my first virtual coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/30566370")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZHAOXILINGCHENG_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZHAOXILINGCHENG_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<ZHAOXILINGCHENG_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<ZHAOXILINGCHENG_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

