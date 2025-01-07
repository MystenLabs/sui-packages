module 0xf78f5a19f1bfceae1d850002c3676ca470af13858c4afed6e49419d1472ee7a0::futuwxq_faucet_coin {
    struct FUTUWXQ_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<FUTUWXQ_FAUCET_COIN>, arg1: 0x2::coin::Coin<FUTUWXQ_FAUCET_COIN>) {
        0x2::coin::burn<FUTUWXQ_FAUCET_COIN>(arg0, arg1);
    }

    fun init(arg0: FUTUWXQ_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUTUWXQ_FAUCET_COIN>(arg0, 9, b"FUTUWXQ_FAUCET", b"FUTUWXQ_FAUCET", b"futuwxq faucet coin, everyone can access and mutate.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/49089070")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FUTUWXQ_FAUCET_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<FUTUWXQ_FAUCET_COIN>>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<FUTUWXQ_FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<FUTUWXQ_FAUCET_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

