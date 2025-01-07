module 0x371938ce3f96b99720eaf1083e1d36a62d052fa5d315e5b3f066e526e1961551::geekzlk_faucet_coin {
    struct GEEKZLK_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<GEEKZLK_FAUCET_COIN>, arg1: 0x2::coin::Coin<GEEKZLK_FAUCET_COIN>) {
        0x2::coin::burn<GEEKZLK_FAUCET_COIN>(arg0, arg1);
    }

    fun init(arg0: GEEKZLK_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GEEKZLK_FAUCET_COIN>(arg0, 9, b"GEEKZLK_FAUCET", b"GEEKZLK_FAUCET", b"faucet coin defined by mqh, everyone can access and mutate", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/169317524")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GEEKZLK_FAUCET_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<GEEKZLK_FAUCET_COIN>>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<GEEKZLK_FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<GEEKZLK_FAUCET_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

