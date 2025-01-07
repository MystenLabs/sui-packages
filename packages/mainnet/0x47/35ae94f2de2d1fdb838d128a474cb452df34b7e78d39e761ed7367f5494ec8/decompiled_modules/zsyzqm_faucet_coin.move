module 0x4735ae94f2de2d1fdb838d128a474cb452df34b7e78d39e761ed7367f5494ec8::zsyzqm_faucet_coin {
    struct ZSYZQM_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<ZSYZQM_FAUCET_COIN>, arg1: 0x2::coin::Coin<ZSYZQM_FAUCET_COIN>) {
        0x2::coin::burn<ZSYZQM_FAUCET_COIN>(arg0, arg1);
    }

    fun init(arg0: ZSYZQM_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZSYZQM_FAUCET_COIN>(arg0, 9, b"ZSYZQM_FAUCET", b"ZSYZQM_FAUCET", b"zsyzqm's faucet coin, everyone can access and mutate.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/61451182")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZSYZQM_FAUCET_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<ZSYZQM_FAUCET_COIN>>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<ZSYZQM_FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<ZSYZQM_FAUCET_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

