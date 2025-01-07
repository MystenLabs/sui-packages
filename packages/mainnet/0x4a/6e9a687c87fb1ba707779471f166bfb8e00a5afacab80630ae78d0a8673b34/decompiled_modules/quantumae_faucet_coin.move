module 0x4a6e9a687c87fb1ba707779471f166bfb8e00a5afacab80630ae78d0a8673b34::quantumae_faucet_coin {
    struct QUANTUMAE_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<QUANTUMAE_FAUCET_COIN>, arg1: 0x2::coin::Coin<QUANTUMAE_FAUCET_COIN>) {
        0x2::coin::burn<QUANTUMAE_FAUCET_COIN>(arg0, arg1);
    }

    fun init(arg0: QUANTUMAE_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QUANTUMAE_FAUCET_COIN>(arg0, 9, b"CRF", b"QUANTUMAE_FAUCET_COIN", b"Quantumae Faucet Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://github.com/Quantumae/all/blob/main/my_coin.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QUANTUMAE_FAUCET_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<QUANTUMAE_FAUCET_COIN>>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<QUANTUMAE_FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<QUANTUMAE_FAUCET_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

