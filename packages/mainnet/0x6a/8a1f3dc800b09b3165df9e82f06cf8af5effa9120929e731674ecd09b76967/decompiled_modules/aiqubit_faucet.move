module 0x6a8a1f3dc800b09b3165df9e82f06cf8af5effa9120929e731674ecd09b76967::aiqubit_faucet {
    struct AIQUBIT_FAUCET has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<AIQUBIT_FAUCET>, arg1: 0x2::coin::Coin<AIQUBIT_FAUCET>) {
        0x2::coin::burn<AIQUBIT_FAUCET>(arg0, arg1);
    }

    fun init(arg0: AIQUBIT_FAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIQUBIT_FAUCET>(arg0, 6, b"AIQF", b"AIQUBIT_FAUCET", b"Don't ask why", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/35585232?v=4")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AIQUBIT_FAUCET>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<AIQUBIT_FAUCET>>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<AIQUBIT_FAUCET>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<AIQUBIT_FAUCET>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

