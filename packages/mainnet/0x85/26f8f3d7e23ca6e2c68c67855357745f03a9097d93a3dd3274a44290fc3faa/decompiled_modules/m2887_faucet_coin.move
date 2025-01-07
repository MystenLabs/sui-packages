module 0x8526f8f3d7e23ca6e2c68c67855357745f03a9097d93a3dd3274a44290fc3faa::m2887_faucet_coin {
    struct M2887_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<M2887_FAUCET_COIN>, arg1: 0x2::coin::Coin<M2887_FAUCET_COIN>) {
        0x2::coin::burn<M2887_FAUCET_COIN>(arg0, arg1);
    }

    fun init(arg0: M2887_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<M2887_FAUCET_COIN>(arg0, 9, b"CRF", b"M2887_FAUCET_COIN", b"M2887 Faucet Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/49989931")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<M2887_FAUCET_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<M2887_FAUCET_COIN>>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<M2887_FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<M2887_FAUCET_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

