module 0xd639970703f5a268c1c1a3c87e939e0771f173c81037a3cf79455c042cc5714a::guizhenyu_faucet_coin {
    struct GUIZHENYU_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<GUIZHENYU_FAUCET_COIN>, arg1: 0x2::coin::Coin<GUIZHENYU_FAUCET_COIN>) {
        0x2::coin::burn<GUIZHENYU_FAUCET_COIN>(arg0, arg1);
    }

    fun init(arg0: GUIZHENYU_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUIZHENYU_FAUCET_COIN>(arg0, 9, b"GUIZHENYU_FAUCET", b"GUIZHENYU_FAUCET", b"GUIZHENYU's faucet coin, everyone can access and mutate.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/51150541")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GUIZHENYU_FAUCET_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<GUIZHENYU_FAUCET_COIN>>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<GUIZHENYU_FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<GUIZHENYU_FAUCET_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

