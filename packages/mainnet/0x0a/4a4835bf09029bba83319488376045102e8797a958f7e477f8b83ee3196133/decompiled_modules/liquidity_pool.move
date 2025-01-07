module 0xa4a4835bf09029bba83319488376045102e8797a958f7e477f8b83ee3196133::liquidity_pool {
    struct LpAdminCap has key {
        id: 0x2::object::UID,
    }

    struct LPCoin<phantom T0, phantom T1> has drop, store {
        dummy_field: bool,
    }

    struct LiquidityPool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        native_reserve: 0x2::coin::Coin<T1>,
        lp_supply: 0x2::balance::Supply<LPCoin<T0, T1>>,
    }

    struct ReleaseCap<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
    }

    struct PoolCreatedEvent<phantom T0, phantom T1> has copy, drop {
        creator: address,
    }

    struct LiquidityProvidedEvent<phantom T0, phantom T1> has copy, drop, store {
        added_val: u64,
        lp_tokens_received: u64,
    }

    struct LiquidityRemovedEvent<phantom T0, phantom T1> has copy, drop, store {
        removed_val: u64,
        lp_tokens_burned: u64,
    }

    public fun burn<T0, T1>(arg0: &mut LiquidityPool<T0, T1>, arg1: 0x2::coin::Coin<LPCoin<T0, T1>>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<LPCoin<T0, T1>>(&arg1);
        0x2::balance::decrease_supply<LPCoin<T0, T1>>(&mut arg0.lp_supply, 0x2::coin::into_balance<LPCoin<T0, T1>>(arg1));
        let v1 = LiquidityRemovedEvent<T0, T1>{
            removed_val      : v0,
            lp_tokens_burned : v0,
        };
        0x2::event::emit<LiquidityRemovedEvent<T0, T1>>(v1);
        0x2::coin::split<T1>(&mut arg0.native_reserve, v0, arg2)
    }

    public entry fun emergency_withdraw<T0, T1>(arg0: &LpAdminCap, arg1: &mut LiquidityPool<T0, T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 500);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut arg1.native_reserve, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = LpAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<LpAdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun lock<T0, T1>(arg0: 0x2::coin::Coin<T1>, arg1: &mut LiquidityPool<T0, T1>) {
        assert!(0x2::coin::value<T1>(&arg0) > 0, 400);
        0x2::coin::join<T1>(&mut arg1.native_reserve, arg0);
    }

    public fun mint_lp_coins<T0, T1>(arg0: &mut LiquidityPool<T0, T1>, arg1: u64) : 0x2::balance::Balance<LPCoin<T0, T1>> {
        let v0 = LiquidityProvidedEvent<T0, T1>{
            added_val          : arg1,
            lp_tokens_received : arg1,
        };
        0x2::event::emit<LiquidityProvidedEvent<T0, T1>>(v0);
        0x2::balance::increase_supply<LPCoin<T0, T1>>(&mut arg0.lp_supply, arg1)
    }

    public entry fun provide_liquidity<T0, T1>(arg0: &mut LiquidityPool<T0, T1>, arg1: &mut 0x2::coin::Coin<T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 500);
        0x2::coin::join<T1>(&mut arg0.native_reserve, 0x2::coin::split<T1>(arg1, arg2, arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<LPCoin<T0, T1>>>(0x2::coin::from_balance<LPCoin<T0, T1>>(mint_lp_coins<T0, T1>(arg0, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    public fun register<T0: drop, T1>(arg0: T0, arg1: &LpAdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = LPCoin<T0, T1>{dummy_field: false};
        let v2 = LiquidityPool<T0, T1>{
            id             : 0x2::object::new(arg2),
            native_reserve : 0x2::coin::zero<T1>(arg2),
            lp_supply      : 0x2::balance::create_supply<LPCoin<T0, T1>>(v1),
        };
        0x2::transfer::share_object<LiquidityPool<T0, T1>>(v2);
        let v3 = ReleaseCap<T0, T1>{id: 0x2::object::new(arg2)};
        0x2::transfer::transfer<ReleaseCap<T0, T1>>(v3, v0);
        let v4 = PoolCreatedEvent<T0, T1>{creator: v0};
        0x2::event::emit<PoolCreatedEvent<T0, T1>>(v4);
    }

    public fun release<T0, T1>(arg0: &mut LiquidityPool<T0, T1>, arg1: &ReleaseCap<T0, T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x2::coin::split<T1>(&mut arg0.native_reserve, arg2, arg3)
    }

    public entry fun reserves<T0, T1>(arg0: &LiquidityPool<T0, T1>) : u64 {
        0x2::coin::value<T1>(&arg0.native_reserve)
    }

    public fun transfer_release_cap<T0, T1>(arg0: &LpAdminCap, arg1: &mut LiquidityPool<T0, T1>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = ReleaseCap<T0, T1>{id: 0x2::object::new(arg3)};
        0x2::transfer::transfer<ReleaseCap<T0, T1>>(v0, arg2);
    }

    public entry fun withdraw_liquidity<T0, T1>(arg0: &mut LiquidityPool<T0, T1>, arg1: &mut 0x2::coin::Coin<LPCoin<T0, T1>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 500);
        let v0 = 0x2::coin::split<LPCoin<T0, T1>>(arg1, arg2, arg3);
        let v1 = burn<T0, T1>(arg0, v0, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

