module 0x5bbaa9574b2ded7ab0cd5ef270198f042545bb7b8da31b3bc755eff1f3ba2c2a::app {
    struct APP has drop {
        dummy_field: bool,
    }

    fun init(arg0: APP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = init_internal(arg0, arg1);
        0x2::transfer::public_transfer<0x5bbaa9574b2ded7ab0cd5ef270198f042545bb7b8da31b3bc755eff1f3ba2c2a::admin::AdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    fun init_internal(arg0: APP, arg1: &mut 0x2::tx_context::TxContext) : 0x5bbaa9574b2ded7ab0cd5ef270198f042545bb7b8da31b3bc755eff1f3ba2c2a::admin::AdminCap {
        0x2::package::claim_and_keep<APP>(arg0, arg1);
        0x5bbaa9574b2ded7ab0cd5ef270198f042545bb7b8da31b3bc755eff1f3ba2c2a::asset_registry::new(arg1);
        0x5bbaa9574b2ded7ab0cd5ef270198f042545bb7b8da31b3bc755eff1f3ba2c2a::balances_registry::new(arg1);
        0x5bbaa9574b2ded7ab0cd5ef270198f042545bb7b8da31b3bc755eff1f3ba2c2a::liquidity_book::new(arg1);
        0x5bbaa9574b2ded7ab0cd5ef270198f042545bb7b8da31b3bc755eff1f3ba2c2a::dispatcher::new(arg1);
        0x5bbaa9574b2ded7ab0cd5ef270198f042545bb7b8da31b3bc755eff1f3ba2c2a::price_registry::new(arg1);
        0x5bbaa9574b2ded7ab0cd5ef270198f042545bb7b8da31b3bc755eff1f3ba2c2a::admin::new(arg1)
    }

    // decompiled from Move bytecode v6
}

