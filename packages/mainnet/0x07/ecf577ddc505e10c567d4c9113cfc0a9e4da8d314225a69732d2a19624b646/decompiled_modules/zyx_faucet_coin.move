module 0x7ecf577ddc505e10c567d4c9113cfc0a9e4da8d314225a69732d2a19624b646::zyx_faucet_coin {
    struct ZYX_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<ZYX_FAUCET_COIN>, arg1: 0x2::coin::Coin<ZYX_FAUCET_COIN>) {
        0x2::coin::burn<ZYX_FAUCET_COIN>(arg0, arg1);
    }

    fun init(arg0: ZYX_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZYX_FAUCET_COIN>(arg0, 9, b"ZYX_FAUCET", b"ZYX_FAUCET", b"zyx's faucet coin, everyone can access and mutate.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/33485252?s=400&u=65637567260caf13c84d5df70b2b725d375de5eb&v=4")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZYX_FAUCET_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<ZYX_FAUCET_COIN>>(v0);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<ZYX_FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<ZYX_FAUCET_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

