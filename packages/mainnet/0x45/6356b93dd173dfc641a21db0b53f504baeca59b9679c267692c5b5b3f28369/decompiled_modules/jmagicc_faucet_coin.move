module 0x456356b93dd173dfc641a21db0b53f504baeca59b9679c267692c5b5b3f28369::jmagicc_faucet_coin {
    struct JMAGICC_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<JMAGICC_FAUCET_COIN>, arg1: 0x2::coin::Coin<JMAGICC_FAUCET_COIN>) {
        0x2::coin::burn<JMAGICC_FAUCET_COIN>(arg0, arg1);
    }

    fun init(arg0: JMAGICC_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JMAGICC_FAUCET_COIN>(arg0, 9, b"JMAGICC FAUCET", b"Jmagicc Faucet Coin", b"Jmagicc Faucet Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/58356228")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JMAGICC_FAUCET_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<JMAGICC_FAUCET_COIN>>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<JMAGICC_FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<JMAGICC_FAUCET_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

