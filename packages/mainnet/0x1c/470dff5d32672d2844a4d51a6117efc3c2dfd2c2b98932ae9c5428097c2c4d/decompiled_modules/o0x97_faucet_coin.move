module 0x1c470dff5d32672d2844a4d51a6117efc3c2dfd2c2b98932ae9c5428097c2c4d::o0x97_faucet_coin {
    struct O0X97_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<O0X97_FAUCET_COIN>, arg1: 0x2::coin::Coin<O0X97_FAUCET_COIN>) {
        0x2::coin::burn<O0X97_FAUCET_COIN>(arg0, arg1);
    }

    fun init(arg0: O0X97_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<O0X97_FAUCET_COIN>(arg0, 9, b"O0X97_FAUCET", b"O0X97_FAUCET", b"faucet coin defined by o0x97, everyone can access and mutate", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/169955655")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<O0X97_FAUCET_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<O0X97_FAUCET_COIN>>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<O0X97_FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<O0X97_FAUCET_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

