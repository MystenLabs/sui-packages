module 0x64a774aafeabd3489f5adcd2d3c387059bacc17c4014a9302933ee658cc98aaf::flopdian_faucet_coin {
    struct FLOPDIAN_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<FLOPDIAN_FAUCET_COIN>, arg1: 0x2::coin::Coin<FLOPDIAN_FAUCET_COIN>) {
        0x2::coin::burn<FLOPDIAN_FAUCET_COIN>(arg0, arg1);
    }

    fun init(arg0: FLOPDIAN_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLOPDIAN_FAUCET_COIN>(arg0, 9, b"FLOPDIAN_FAUCET", b"FLOPDIAN_FAUCET", b"FLOPDIAN's faucet coin, everyone can access and mutate.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/167522723")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FLOPDIAN_FAUCET_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<FLOPDIAN_FAUCET_COIN>>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<FLOPDIAN_FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<FLOPDIAN_FAUCET_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

