module 0x11db45c9cb04ee496185b38cc5c8cf8fae0726cdc8196c6be5ed2cb7c546b727::liquidity_pool {
    struct LiquidityPool<phantom T0> has key {
        id: 0x2::object::UID,
        token_balance: 0x2::balance::Balance<T0>,
        sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct LPToken<phantom T0> has store, key {
        id: 0x2::object::UID,
    }

    struct FeeConfig has key {
        id: 0x2::object::UID,
        fee_amount: u64,
        fee_collector: address,
    }

    struct PoolCreatedEvent has copy, drop {
        pool_id: 0x2::object::ID,
        creator: address,
    }

    public fun create_pool<T0>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, 0x2::coin::Coin<LPToken<T0>>) {
        let v0 = LiquidityPool<T0>{
            id            : 0x2::object::new(arg2),
            token_balance : 0x2::coin::into_balance<T0>(arg0),
            sui_balance   : 0x2::coin::into_balance<0x2::sui::SUI>(arg1),
        };
        let v1 = 0x2::object::id<LiquidityPool<T0>>(&v0);
        let v2 = PoolCreatedEvent{
            pool_id : v1,
            creator : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<PoolCreatedEvent>(v2);
        0x2::transfer::share_object<LiquidityPool<T0>>(v0);
        (v1, 0x2::coin::zero<LPToken<T0>>(arg2))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = FeeConfig{
            id            : 0x2::object::new(arg0),
            fee_amount    : 100000000,
            fee_collector : @0x576dd55fd0976f0042f6f78e48e5063f6fca8988fb6f976a9abc1bef571873fd,
        };
        0x2::transfer::share_object<FeeConfig>(v0);
    }

    // decompiled from Move bytecode v6
}

