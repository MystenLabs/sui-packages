module 0x10908ea361f2f448fc6aeb458570e2b20e956f56fc244a474fd89243f1679448::zhaoxilingcheng_faucet_coin {
    struct ZHAOXILINGCHENG_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<ZHAOXILINGCHENG_FAUCET_COIN>, arg1: 0x2::coin::Coin<ZHAOXILINGCHENG_FAUCET_COIN>) {
        0x2::coin::burn<ZHAOXILINGCHENG_FAUCET_COIN>(arg0, arg1);
    }

    fun init(arg0: ZHAOXILINGCHENG_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZHAOXILINGCHENG_FAUCET_COIN>(arg0, 9, b"ZHAOXILINGCHENG_FAUCET", b"ZHAOXILINGCHENG_FAUCET", b"zhaoxilingcheng's faucet coin, everyone can access and mutate.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/30566370")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZHAOXILINGCHENG_FAUCET_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<ZHAOXILINGCHENG_FAUCET_COIN>>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<ZHAOXILINGCHENG_FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<ZHAOXILINGCHENG_FAUCET_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

