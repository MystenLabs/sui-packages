module 0xc4a538a0f477051636e06e2cea07a179f5a62e8125ed1eef92fa84993eb729ac::hwen_faucet_coin {
    struct HWEN_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<HWEN_FAUCET_COIN>, arg1: 0x2::coin::Coin<HWEN_FAUCET_COIN>) {
        0x2::coin::burn<HWEN_FAUCET_COIN>(arg0, arg1);
    }

    fun init(arg0: HWEN_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HWEN_FAUCET_COIN>(arg0, 9, b"HFC", b"HWEN_FAUCET_COIN", b"Hwen Faucet Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://postimg.cc/ZWLQPcWp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HWEN_FAUCET_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<HWEN_FAUCET_COIN>>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<HWEN_FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<HWEN_FAUCET_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

