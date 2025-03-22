module 0xd62e8294c8157f2d209afb87ed30c2dffd5e77f88040cd698593af52a8ed4f5a::sui_swap {
    struct SUI_SWAP has drop {
        dummy_field: bool,
    }

    public entry fun create_pool<T0, T1>(arg0: &mut 0xd62e8294c8157f2d209afb87ed30c2dffd5e77f88040cd698593af52a8ed4f5a::factory::Factory, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0xd62e8294c8157f2d209afb87ed30c2dffd5e77f88040cd698593af52a8ed4f5a::factory::create_pool<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun create_pool_with_default_fee<T0, T1>(arg0: &mut 0xd62e8294c8157f2d209afb87ed30c2dffd5e77f88040cd698593af52a8ed4f5a::factory::Factory, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        0xd62e8294c8157f2d209afb87ed30c2dffd5e77f88040cd698593af52a8ed4f5a::factory::create_pool_with_default_fee<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public entry fun update_default_fee_percent(arg0: &mut 0xd62e8294c8157f2d209afb87ed30c2dffd5e77f88040cd698593af52a8ed4f5a::factory::Factory, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0xd62e8294c8157f2d209afb87ed30c2dffd5e77f88040cd698593af52a8ed4f5a::factory::update_default_fee_percent(arg0, arg1, arg2);
    }

    public entry fun add_liquidity<T0, T1>(arg0: &mut 0xd62e8294c8157f2d209afb87ed30c2dffd5e77f88040cd698593af52a8ed4f5a::liquidity_pool::LiquidityPool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let (v1, v2, v3) = 0xd62e8294c8157f2d209afb87ed30c2dffd5e77f88040cd698593af52a8ed4f5a::liquidity_pool::add_liquidity<T0, T1>(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<0xd62e8294c8157f2d209afb87ed30c2dffd5e77f88040cd698593af52a8ed4f5a::liquidity_pool::LPCoin<T0, T1>>(v1, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v3, v0);
    }

    public entry fun remove_liquidity<T0, T1>(arg0: &mut 0xd62e8294c8157f2d209afb87ed30c2dffd5e77f88040cd698593af52a8ed4f5a::liquidity_pool::LiquidityPool<T0, T1>, arg1: 0xd62e8294c8157f2d209afb87ed30c2dffd5e77f88040cd698593af52a8ed4f5a::liquidity_pool::LPCoin<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xd62e8294c8157f2d209afb87ed30c2dffd5e77f88040cd698593af52a8ed4f5a::liquidity_pool::remove_liquidity<T0, T1>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: SUI_SWAP, arg1: &mut 0x2::tx_context::TxContext) {
        0xd62e8294c8157f2d209afb87ed30c2dffd5e77f88040cd698593af52a8ed4f5a::factory::create_factory(30, arg1);
    }

    public entry fun swap_x_to_y<T0, T1>(arg0: &mut 0xd62e8294c8157f2d209afb87ed30c2dffd5e77f88040cd698593af52a8ed4f5a::liquidity_pool::LiquidityPool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0xd62e8294c8157f2d209afb87ed30c2dffd5e77f88040cd698593af52a8ed4f5a::swap::swap_x_to_y<T0, T1>(arg0, arg1, arg2, arg3, arg4), 0x2::tx_context::sender(arg4));
    }

    public entry fun swap_y_to_x<T0, T1>(arg0: &mut 0xd62e8294c8157f2d209afb87ed30c2dffd5e77f88040cd698593af52a8ed4f5a::liquidity_pool::LiquidityPool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0xd62e8294c8157f2d209afb87ed30c2dffd5e77f88040cd698593af52a8ed4f5a::swap::swap_y_to_x<T0, T1>(arg0, arg1, arg2, arg3, arg4), 0x2::tx_context::sender(arg4));
    }

    public entry fun transfer_factory_ownership(arg0: &mut 0xd62e8294c8157f2d209afb87ed30c2dffd5e77f88040cd698593af52a8ed4f5a::factory::Factory, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0xd62e8294c8157f2d209afb87ed30c2dffd5e77f88040cd698593af52a8ed4f5a::factory::transfer_ownership(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

