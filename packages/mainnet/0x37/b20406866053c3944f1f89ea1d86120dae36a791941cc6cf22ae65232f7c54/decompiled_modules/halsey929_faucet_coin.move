module 0x37b20406866053c3944f1f89ea1d86120dae36a791941cc6cf22ae65232f7c54::halsey929_faucet_coin {
    struct HALSEY929_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<HALSEY929_FAUCET_COIN>, arg1: 0x2::coin::Coin<HALSEY929_FAUCET_COIN>) {
        0x2::coin::burn<HALSEY929_FAUCET_COIN>(arg0, arg1);
    }

    fun init(arg0: HALSEY929_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HALSEY929_FAUCET_COIN>(arg0, 9, b"HALSEY929_FAUCET", b"HALSEY929_FAUCET", b"HALSEY929's faucet coin, everyone can access and mutate.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/77434939")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HALSEY929_FAUCET_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<HALSEY929_FAUCET_COIN>>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<HALSEY929_FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<HALSEY929_FAUCET_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

