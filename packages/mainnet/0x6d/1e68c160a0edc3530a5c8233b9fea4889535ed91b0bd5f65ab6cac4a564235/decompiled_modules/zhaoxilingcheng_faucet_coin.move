module 0x6d1e68c160a0edc3530a5c8233b9fea4889535ed91b0bd5f65ab6cac4a564235::zhaoxilingcheng_faucet_coin {
    struct ZHAOXILINGCHENG_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<ZHAOXILINGCHENG_FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ZHAOXILINGCHENG_FAUCET_COIN>>(0x2::coin::mint<ZHAOXILINGCHENG_FAUCET_COIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: ZHAOXILINGCHENG_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZHAOXILINGCHENG_FAUCET_COIN>(arg0, 9, b"BLACK MYTH WUKONG", b"WUKONG", b"CONFRONT DESTINY AUGUST 20, 2024", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/30566370")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZHAOXILINGCHENG_FAUCET_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<ZHAOXILINGCHENG_FAUCET_COIN>>(v0);
    }

    // decompiled from Move bytecode v6
}

