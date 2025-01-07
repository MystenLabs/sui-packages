module 0x87ea34d4960271e62241b1c83bc0f679dcaffae515018ed056d65527f48a45c3::r41d4n_faucet_coin {
    struct R41D4N_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<R41D4N_FAUCET_COIN>, arg1: 0x2::coin::Coin<R41D4N_FAUCET_COIN>) {
        0x2::coin::burn<R41D4N_FAUCET_COIN>(arg0, arg1);
    }

    fun init(arg0: R41D4N_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<R41D4N_FAUCET_COIN>(arg0, 9, b"R41D4N_FAUCET", b"R41D4N_FAUCET", b"faucet coin defined by mqh, everyone can access and mutate", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/169955532")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<R41D4N_FAUCET_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<R41D4N_FAUCET_COIN>>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<R41D4N_FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<R41D4N_FAUCET_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

