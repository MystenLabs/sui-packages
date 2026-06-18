module 0x6749aa11b75e44ff06dc05222390fdc45cf4c3222066c84e4bb11d8990394eb6::lending_pool {
    struct LendingPool<phantom T0> has key {
        id: 0x2::object::UID,
        total_supplied: u64,
        total_lend_shares: u64,
        available_liquidity: 0x2::balance::Balance<T0>,
        deployed_amount: u64,
        cumulative_paye_yield: u64,
        pending_yield: 0x2::balance::Balance<T0>,
        yield_per_share_cumulative: u128,
        paused: bool,
        lender_count: u64,
    }

    struct LenderPosition<phantom T0> has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        owner: address,
        lend_shares: u64,
        deposited_amount: u64,
        deposited_at: u64,
        yield_per_share_snapshot: u128,
        cumulative_yield_claimed: u64,
        last_withdraw_at: u64,
    }

    struct PoolCreated has copy, drop {
        pool_id: 0x2::object::ID,
    }

    struct LiquiditySupplied has copy, drop {
        pool_id: 0x2::object::ID,
        lender: address,
        amount: u64,
        lend_shares: u64,
    }

    struct LiquidityWithdrawn has copy, drop {
        pool_id: 0x2::object::ID,
        lender: address,
        amount: u64,
        shares_burned: u64,
    }

    struct YieldDistributed has copy, drop {
        pool_id: 0x2::object::ID,
        amount: u64,
        yield_per_share_delta: u128,
    }

    struct YieldClaimed has copy, drop {
        position_id: 0x2::object::ID,
        lender: address,
        amount: u64,
    }

    public fun borrow<T0>(arg0: &mut LendingPool<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        assert!(arg1 <= 0x2::balance::value<T0>(&arg0.available_liquidity), 302);
        let v0 = arg0.deployed_amount + arg1;
        assert!((((v0 as u128) * 10000 / (arg0.total_supplied as u128)) as u64) <= 9000, 303);
        arg0.deployed_amount = v0;
        0x2::balance::split<T0>(&mut arg0.available_liquidity, arg1)
    }

    fun calculate_pending_yield<T0>(arg0: &LendingPool<T0>, arg1: &LenderPosition<T0>) : u64 {
        (((arg1.lend_shares as u128) * (arg0.yield_per_share_cumulative - arg1.yield_per_share_snapshot) / 1000000000000000000) as u64)
    }

    public entry fun claim_yield<T0>(arg0: &mut LendingPool<T0>, arg1: &mut LenderPosition<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = calculate_pending_yield<T0>(arg0, arg1);
        assert!(v0 > 0, 304);
        assert!(0x2::balance::value<T0>(&arg0.pending_yield) >= v0, 302);
        arg1.yield_per_share_snapshot = arg0.yield_per_share_cumulative;
        arg1.cumulative_yield_claimed = arg1.cumulative_yield_claimed + v0;
        let v1 = YieldClaimed{
            position_id : 0x2::object::id<LenderPosition<T0>>(arg1),
            lender      : arg1.owner,
            amount      : v0,
        };
        0x2::event::emit<YieldClaimed>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.pending_yield, v0), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun create_pool<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = LendingPool<T0>{
            id                         : 0x2::object::new(arg0),
            total_supplied             : 0,
            total_lend_shares          : 0,
            available_liquidity        : 0x2::balance::zero<T0>(),
            deployed_amount            : 0,
            cumulative_paye_yield      : 0,
            pending_yield              : 0x2::balance::zero<T0>(),
            yield_per_share_cumulative : 0,
            paused                     : false,
            lender_count               : 0,
        };
        let v1 = PoolCreated{pool_id: 0x2::object::id<LendingPool<T0>>(&v0)};
        0x2::event::emit<PoolCreated>(v1);
        0x2::transfer::share_object<LendingPool<T0>>(v0);
    }

    public fun distribute_paye_yield<T0>(arg0: &mut LendingPool<T0>, arg1: 0x2::balance::Balance<T0>) {
        let v0 = 0x2::balance::value<T0>(&arg1);
        if (v0 == 0 || arg0.total_lend_shares == 0) {
            0x2::balance::join<T0>(&mut arg0.available_liquidity, arg1);
            return
        };
        let v1 = (v0 as u128) * 1000000000000000000 / (arg0.total_lend_shares as u128);
        arg0.yield_per_share_cumulative = arg0.yield_per_share_cumulative + v1;
        arg0.cumulative_paye_yield = arg0.cumulative_paye_yield + v0;
        0x2::balance::join<T0>(&mut arg0.pending_yield, arg1);
        let v2 = YieldDistributed{
            pool_id               : 0x2::object::id<LendingPool<T0>>(arg0),
            amount                : v0,
            yield_per_share_delta : v1,
        };
        0x2::event::emit<YieldDistributed>(v2);
    }

    public fun pool_available<T0>(arg0: &LendingPool<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.available_liquidity)
    }

    public fun pool_cumulative_yield<T0>(arg0: &LendingPool<T0>) : u64 {
        arg0.cumulative_paye_yield
    }

    public fun pool_deployed<T0>(arg0: &LendingPool<T0>) : u64 {
        arg0.deployed_amount
    }

    public fun pool_lender_count<T0>(arg0: &LendingPool<T0>) : u64 {
        arg0.lender_count
    }

    public fun pool_total_supplied<T0>(arg0: &LendingPool<T0>) : u64 {
        arg0.total_supplied
    }

    public fun pool_utilization_bps<T0>(arg0: &LendingPool<T0>) : u64 {
        if (arg0.total_supplied == 0) {
            return 0
        };
        (((arg0.deployed_amount as u128) * 10000 / (arg0.total_supplied as u128)) as u64)
    }

    public fun position_deposited<T0>(arg0: &LenderPosition<T0>) : u64 {
        arg0.deposited_amount
    }

    public fun position_pending_yield<T0>(arg0: &LendingPool<T0>, arg1: &LenderPosition<T0>) : u64 {
        calculate_pending_yield<T0>(arg0, arg1)
    }

    public fun position_shares<T0>(arg0: &LenderPosition<T0>) : u64 {
        arg0.lend_shares
    }

    public fun position_yield_claimed<T0>(arg0: &LenderPosition<T0>) : u64 {
        arg0.cumulative_yield_claimed
    }

    public fun repay<T0>(arg0: &mut LendingPool<T0>, arg1: 0x2::balance::Balance<T0>) {
        arg0.deployed_amount = arg0.deployed_amount - 0x6749aa11b75e44ff06dc05222390fdc45cf4c3222066c84e4bb11d8990394eb6::math::min(0x2::balance::value<T0>(&arg1), arg0.deployed_amount);
        0x2::balance::join<T0>(&mut arg0.available_liquidity, arg1);
    }

    public entry fun supply<T0>(arg0: &mut LendingPool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 300);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 301);
        let v1 = 0x6749aa11b75e44ff06dc05222390fdc45cf4c3222066c84e4bb11d8990394eb6::math::amount_to_shares(v0, arg0.total_supplied, arg0.total_lend_shares);
        0x2::balance::join<T0>(&mut arg0.available_liquidity, 0x2::coin::into_balance<T0>(arg1));
        arg0.total_supplied = arg0.total_supplied + v0;
        arg0.total_lend_shares = arg0.total_lend_shares + v1;
        arg0.lender_count = arg0.lender_count + 1;
        let v2 = LenderPosition<T0>{
            id                       : 0x2::object::new(arg3),
            pool_id                  : 0x2::object::id<LendingPool<T0>>(arg0),
            owner                    : 0x2::tx_context::sender(arg3),
            lend_shares              : v1,
            deposited_amount         : v0,
            deposited_at             : 0x2::clock::timestamp_ms(arg2),
            yield_per_share_snapshot : arg0.yield_per_share_cumulative,
            cumulative_yield_claimed : 0,
            last_withdraw_at         : 0,
        };
        let v3 = LiquiditySupplied{
            pool_id     : 0x2::object::id<LendingPool<T0>>(arg0),
            lender      : 0x2::tx_context::sender(arg3),
            amount      : v0,
            lend_shares : v1,
        };
        0x2::event::emit<LiquiditySupplied>(v3);
        0x2::transfer::transfer<LenderPosition<T0>>(v2, 0x2::tx_context::sender(arg3));
    }

    public entry fun withdraw<T0>(arg0: &mut LendingPool<T0>, arg1: LenderPosition<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = calculate_pending_yield<T0>(arg0, &arg1);
        let v1 = 0x6749aa11b75e44ff06dc05222390fdc45cf4c3222066c84e4bb11d8990394eb6::math::min(0x6749aa11b75e44ff06dc05222390fdc45cf4c3222066c84e4bb11d8990394eb6::math::shares_to_amount(arg1.lend_shares, arg0.total_supplied, arg0.total_lend_shares), 0x2::balance::value<T0>(&arg0.available_liquidity));
        assert!(v1 > 0, 302);
        arg0.total_supplied = arg0.total_supplied - v1;
        arg0.total_lend_shares = arg0.total_lend_shares - arg1.lend_shares;
        arg0.lender_count = arg0.lender_count - 1;
        let v2 = 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.available_liquidity, v1), arg3);
        if (v0 > 0 && 0x2::balance::value<T0>(&arg0.pending_yield) >= v0) {
            0x2::coin::join<T0>(&mut v2, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.pending_yield, v0), arg3));
        };
        let v3 = LiquidityWithdrawn{
            pool_id       : 0x2::object::id<LendingPool<T0>>(arg0),
            lender        : arg1.owner,
            amount        : v1 + v0,
            shares_burned : arg1.lend_shares,
        };
        0x2::event::emit<LiquidityWithdrawn>(v3);
        let LenderPosition {
            id                       : v4,
            pool_id                  : _,
            owner                    : _,
            lend_shares              : _,
            deposited_amount         : _,
            deposited_at             : _,
            yield_per_share_snapshot : _,
            cumulative_yield_claimed : _,
            last_withdraw_at         : _,
        } = arg1;
        0x2::object::delete(v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v7
}

