module 0xa8385516f66e045fe3c69179453c5b76855a141017ca622ae2516153e6622735::jojoben_faucet_coin {
    struct JOJOBEN_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<JOJOBEN_FAUCET_COIN>, arg1: 0x2::coin::Coin<JOJOBEN_FAUCET_COIN>) {
        0x2::coin::burn<JOJOBEN_FAUCET_COIN>(arg0, arg1);
    }

    fun init(arg0: JOJOBEN_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOJOBEN_FAUCET_COIN>(arg0, 9, b"JOJOBEN_FAUCET", b"JOJOBEN_FAUCET", b"jojoben's faucet coin, everyone can access and mutate.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/173065194?v=4")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JOJOBEN_FAUCET_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<JOJOBEN_FAUCET_COIN>>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<JOJOBEN_FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<JOJOBEN_FAUCET_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

