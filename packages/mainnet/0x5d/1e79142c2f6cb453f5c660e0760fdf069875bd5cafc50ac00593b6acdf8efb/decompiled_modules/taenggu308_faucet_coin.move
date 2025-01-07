module 0x5d1e79142c2f6cb453f5c660e0760fdf069875bd5cafc50ac00593b6acdf8efb::taenggu308_faucet_coin {
    struct TAENGGU308_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<TAENGGU308_FAUCET_COIN>, arg1: 0x2::coin::Coin<TAENGGU308_FAUCET_COIN>) {
        0x2::coin::burn<TAENGGU308_FAUCET_COIN>(arg0, arg1);
    }

    fun init(arg0: TAENGGU308_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAENGGU308_FAUCET_COIN>(arg0, 9, b"TAENGGU308_FAUCET", b"TAENGGU308_FAUCET", b"faucet coin defined by mqh, everyone can access and mutate", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/169317937")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TAENGGU308_FAUCET_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<TAENGGU308_FAUCET_COIN>>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TAENGGU308_FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TAENGGU308_FAUCET_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

