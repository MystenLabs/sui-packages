module 0x406de6b171affee02e927de1af230fd4f22ffe5ab65b72c20a51309cc56513da::xunfragrant_faucet_coin {
    struct XUNFRAGRANT_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<XUNFRAGRANT_FAUCET_COIN>, arg1: 0x2::coin::Coin<XUNFRAGRANT_FAUCET_COIN>) {
        0x2::coin::burn<XUNFRAGRANT_FAUCET_COIN>(arg0, arg1);
    }

    fun init(arg0: XUNFRAGRANT_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XUNFRAGRANT_FAUCET_COIN>(arg0, 9, b"XUNFRAGRANT_FAUCET", b"XUNFRAGRANT_FAUCET", b"XUNFRAGRANT faucet coin, everyone can access and mutate.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/100562605")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XUNFRAGRANT_FAUCET_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<XUNFRAGRANT_FAUCET_COIN>>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<XUNFRAGRANT_FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<XUNFRAGRANT_FAUCET_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

