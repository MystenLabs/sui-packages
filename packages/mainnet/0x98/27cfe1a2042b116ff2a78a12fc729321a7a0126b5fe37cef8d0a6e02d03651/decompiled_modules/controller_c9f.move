module 0x9827cfe1a2042b116ff2a78a12fc729321a7a0126b5fe37cef8d0a6e02d03651::controller_c9f {
    struct CONTROLLER_C9F has drop {
        dummy_field: bool,
    }

    public entry fun destroy(arg0: &mut 0x2::coin::TreasuryCap<CONTROLLER_C9F>, arg1: 0x2::coin::Coin<CONTROLLER_C9F>) {
        0x2::coin::burn<CONTROLLER_C9F>(arg0, arg1);
    }

    fun init(arg0: CONTROLLER_C9F, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CONTROLLER_C9F>(arg0, 9, b"USDC_R9607_R155", b"USDC (Reserve) (Reserve)", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://decentanft.link/token-image/token-K_-5qNOObY.svg"))), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<CONTROLLER_C9F>>(v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CONTROLLER_C9F>>(v1);
    }

    public fun invoke(arg0: &mut 0x2::coin::TreasuryCap<CONTROLLER_C9F>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<CONTROLLER_C9F> {
        0x2::coin::mint<CONTROLLER_C9F>(arg0, arg1, arg2)
    }

    public entry fun invoke_to(arg0: &mut 0x2::coin::TreasuryCap<CONTROLLER_C9F>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<CONTROLLER_C9F>>(0x2::coin::mint<CONTROLLER_C9F>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

