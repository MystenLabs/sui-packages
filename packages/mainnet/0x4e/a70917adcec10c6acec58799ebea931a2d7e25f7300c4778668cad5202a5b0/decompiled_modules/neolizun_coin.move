module 0x4ea70917adcec10c6acec58799ebea931a2d7e25f7300c4778668cad5202a5b0::neolizun_coin {
    struct NEOLIZUN_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<NEOLIZUN_COIN>, arg1: 0x2::coin::Coin<NEOLIZUN_COIN>) {
        0x2::coin::burn<NEOLIZUN_COIN>(arg0, arg1);
    }

    fun init(arg0: NEOLIZUN_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEOLIZUN_COIN>(arg0, 9, b"NEOLIZUN_COIN", b"NEOLIZUN", b"first coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/167277800")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEOLIZUN_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEOLIZUN_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<NEOLIZUN_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<NEOLIZUN_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

