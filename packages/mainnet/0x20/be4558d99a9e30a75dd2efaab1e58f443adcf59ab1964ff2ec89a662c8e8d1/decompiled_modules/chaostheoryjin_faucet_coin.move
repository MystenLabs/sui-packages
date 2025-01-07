module 0x20be4558d99a9e30a75dd2efaab1e58f443adcf59ab1964ff2ec89a662c8e8d1::chaostheoryjin_faucet_coin {
    struct CHAOSTHEORYJIN_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<CHAOSTHEORYJIN_FAUCET_COIN>, arg1: 0x2::coin::Coin<CHAOSTHEORYJIN_FAUCET_COIN>) {
        0x2::coin::burn<CHAOSTHEORYJIN_FAUCET_COIN>(arg0, arg1);
    }

    fun init(arg0: CHAOSTHEORYJIN_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHAOSTHEORYJIN_FAUCET_COIN>(arg0, 9, b"CHAOSTHEORYJIN_FAUCET", b"CHAOSTHEORYJIN_FAUCET", b"CHAOSTHEORYJIN's faucet coin, everyone can access and mutate.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/161667862")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHAOSTHEORYJIN_FAUCET_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<CHAOSTHEORYJIN_FAUCET_COIN>>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<CHAOSTHEORYJIN_FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<CHAOSTHEORYJIN_FAUCET_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

