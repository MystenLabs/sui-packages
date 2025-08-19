module 0xf70c1a4c9098d2d9430da35032ecaeab7e0381e5e0a3bd40d9da595f7093048::hellogaod_faucet_coin {
    struct HELLOGAOD_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<HELLOGAOD_FAUCET_COIN>, arg1: 0x2::coin::Coin<HELLOGAOD_FAUCET_COIN>) {
        0x2::coin::burn<HELLOGAOD_FAUCET_COIN>(arg0, arg1);
    }

    fun init(arg0: HELLOGAOD_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HELLOGAOD_FAUCET_COIN>(arg0, 9, b"HGF", b"HELLOGAOD_FAUCET_COIN", b"HelloGaod Faucet Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://q3.itc.cn/images01/20250220/bd7183642f8a4f6285c9defb7f6bd409.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HELLOGAOD_FAUCET_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<HELLOGAOD_FAUCET_COIN>>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<HELLOGAOD_FAUCET_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<HELLOGAOD_FAUCET_COIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

