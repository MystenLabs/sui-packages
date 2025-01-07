module 0x5b11d7f4bb6091700c62e8e02d27dc25f8ba391f983b2a26ad9b7c6588ac3d48::vingtehan_faucet_coin {
    struct VINGTEHAN_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<VINGTEHAN_FAUCET_COIN>, arg1: 0x2::coin::Coin<VINGTEHAN_FAUCET_COIN>) {
        0x2::coin::burn<VINGTEHAN_FAUCET_COIN>(arg0, arg1);
    }

    fun init(arg0: VINGTEHAN_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VINGTEHAN_FAUCET_COIN>(arg0, 9, b"VINGTEHAN_FAUCET", b"VINGTEHAN_FAUCET", b"faucet coin defined by mqh, everyone can access and mutate", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/169867954")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VINGTEHAN_FAUCET_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<VINGTEHAN_FAUCET_COIN>>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<VINGTEHAN_FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<VINGTEHAN_FAUCET_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

