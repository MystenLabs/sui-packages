module 0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::margin_bank {
    struct UserBalance has copy, drop, store {
        available: u64,
        locked: u64,
    }

    struct MarginBank<phantom T0> has key {
        id: 0x2::object::UID,
        balances: 0x2::table::Table<address, UserBalance>,
        fee_pool: 0x2::balance::Balance<T0>,
        insurance_pool: 0x2::balance::Balance<T0>,
        insurance_pool_dust_e8: u64,
        vault: 0x2::balance::Balance<T0>,
        decimals: u8,
        enabled: bool,
        total_deposits: u64,
    }

    struct Deposit has copy, drop {
        user: address,
        amount: u64,
        new_balance: u64,
    }

    struct Withdrawal has copy, drop {
        user: address,
        amount: u64,
        new_balance: u64,
    }

    struct DustSwept has copy, drop {
        user: address,
        dust_e8: u64,
        target_pool: u8,
        timestamp_ms: u64,
    }

    struct CollateralLocked has copy, drop {
        user: address,
        amount: u64,
        new_available: u64,
        new_locked: u64,
    }

    struct CollateralUnlocked has copy, drop {
        user: address,
        amount: u64,
        new_available: u64,
        new_locked: u64,
    }

    struct MarginCreditedRealizedPnl has copy, drop, store {
        user: address,
        amount: u64,
        new_available: u64,
        insurance_pool_balance: u64,
    }

    struct MarginDebitedRealizedPnl has copy, drop, store {
        user: address,
        amount: u64,
        debited_from_available: u64,
        debited_from_locked: u64,
        new_available: u64,
        new_locked: u64,
        insurance_pool_balance: u64,
    }

    struct InsurancePoolSeeded has copy, drop {
        amount: u64,
        new_insurance_pool_balance: u64,
    }

    fun canonical_to_coin_amount_floor(arg0: u64) : (u64, u64, u64) {
        let v0 = arg0 / 100;
        let v1 = v0 * 100;
        (v0, v1, arg0 - v1)
    }

    fun canonical_to_raw_floor(arg0: u64) : (u64, u64) {
        let (v0, _, v2) = canonical_to_coin_amount_floor(arg0);
        (v0, v2)
    }

    public fun canonical_usd_decimals() : u8 {
        8
    }

    fun coin_to_canonical_amount(arg0: u64) : u64 {
        arg0 * 100
    }

    public(friend) fun collect_fee<T0>(arg0: &mut MarginBank<T0>, arg1: address, arg2: u64) : u64 {
        if (arg2 == 0) {
            return 0
        };
        if (!0x2::table::contains<address, UserBalance>(&arg0.balances, arg1)) {
            return 0
        };
        let v0 = 0x2::table::borrow_mut<address, UserBalance>(&mut arg0.balances, arg1);
        let v1 = if (arg2 > v0.available) {
            v0.available
        } else {
            arg2
        };
        v0.available = v0.available - v1;
        arg0.total_deposits = arg0.total_deposits - v1;
        let (v2, v3) = canonical_to_raw_floor(v1);
        if (v2 > 0) {
            0x2::balance::join<T0>(&mut arg0.fee_pool, 0x2::balance::split<T0>(&mut arg0.vault, v2));
        };
        if (v3 > 0) {
            arg0.insurance_pool_dust_e8 = arg0.insurance_pool_dust_e8 + v3;
        };
        v1
    }

    public(friend) fun collect_insurance<T0>(arg0: &mut MarginBank<T0>, arg1: address, arg2: u64) : u64 {
        if (arg2 == 0) {
            return 0
        };
        if (!0x2::table::contains<address, UserBalance>(&arg0.balances, arg1)) {
            return 0
        };
        let v0 = 0x2::table::borrow_mut<address, UserBalance>(&mut arg0.balances, arg1);
        let v1 = if (arg2 > v0.available) {
            v0.available
        } else {
            arg2
        };
        v0.available = v0.available - v1;
        arg0.total_deposits = arg0.total_deposits - v1;
        let (v2, v3) = canonical_to_raw_floor(v1);
        if (v2 > 0) {
            0x2::balance::join<T0>(&mut arg0.insurance_pool, 0x2::balance::split<T0>(&mut arg0.vault, v2));
        };
        if (v3 > 0) {
            arg0.insurance_pool_dust_e8 = arg0.insurance_pool_dust_e8 + v3;
        };
        v1
    }

    public fun create_margin_bank<T0>(arg0: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::admin_config::AdminCap, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = MarginBank<T0>{
            id                     : 0x2::object::new(arg2),
            balances               : 0x2::table::new<address, UserBalance>(arg2),
            fee_pool               : 0x2::balance::zero<T0>(),
            insurance_pool         : 0x2::balance::zero<T0>(),
            insurance_pool_dust_e8 : 0,
            vault                  : 0x2::balance::zero<T0>(),
            decimals               : arg1,
            enabled                : true,
            total_deposits         : 0,
        };
        0x2::transfer::share_object<MarginBank<T0>>(v0);
    }

    public(friend) fun credit_locked_from_insurance<T0>(arg0: &mut MarginBank<T0>, arg1: address, arg2: u64) : u64 {
        if (arg2 == 0) {
            return 0
        };
        let v0 = insurance_pool_balance<T0>(arg0);
        let v1 = if (arg2 < v0) {
            arg2
        } else {
            v0
        };
        if (v1 == 0) {
            return 0
        };
        let (v2, v3) = canonical_to_raw_floor(v1);
        if (!0x2::table::contains<address, UserBalance>(&arg0.balances, arg1)) {
            let v4 = UserBalance{
                available : 0,
                locked    : 0,
            };
            0x2::table::add<address, UserBalance>(&mut arg0.balances, arg1, v4);
        };
        if (v3 == 0) {
            assert!(0x2::balance::value<T0>(&arg0.insurance_pool) >= v2, 5);
            if (v2 > 0) {
                0x2::balance::join<T0>(&mut arg0.vault, 0x2::balance::split<T0>(&mut arg0.insurance_pool, v2));
            };
        } else if (arg0.insurance_pool_dust_e8 >= v3) {
            assert!(0x2::balance::value<T0>(&arg0.insurance_pool) >= v2, 5);
            if (v2 > 0) {
                0x2::balance::join<T0>(&mut arg0.vault, 0x2::balance::split<T0>(&mut arg0.insurance_pool, v2));
            };
            arg0.insurance_pool_dust_e8 = arg0.insurance_pool_dust_e8 - v3;
        } else {
            let v5 = v2 + 1;
            assert!(0x2::balance::value<T0>(&arg0.insurance_pool) >= v5, 5);
            0x2::balance::join<T0>(&mut arg0.vault, 0x2::balance::split<T0>(&mut arg0.insurance_pool, v5));
            arg0.insurance_pool_dust_e8 = arg0.insurance_pool_dust_e8 + 100 - v3;
        };
        let v6 = 0x2::table::borrow_mut<address, UserBalance>(&mut arg0.balances, arg1);
        v6.locked = v6.locked + v1;
        arg0.total_deposits = arg0.total_deposits + v1;
        v1
    }

    public(friend) fun credit_realized_pnl_from_insurance<T0>(arg0: &mut MarginBank<T0>, arg1: address, arg2: u64, arg3: bool) {
        if (arg2 == 0) {
            return
        };
        if (arg3) {
            assert!(0x2::table::contains<address, UserBalance>(&arg0.balances, arg1), 0);
            let v0 = 0x2::table::borrow_mut<address, UserBalance>(&mut arg0.balances, arg1);
            let v1 = if (v0.available >= arg2) {
                arg2
            } else {
                v0.available
            };
            let v2 = arg2 - v1;
            assert!(v0.locked >= v2, 3);
            v0.available = v0.available - v1;
            v0.locked = v0.locked - v2;
            arg0.total_deposits = arg0.total_deposits - arg2;
            let (v3, v4) = canonical_to_raw_floor(arg2);
            if (v3 > 0) {
                0x2::balance::join<T0>(&mut arg0.insurance_pool, 0x2::balance::split<T0>(&mut arg0.vault, v3));
            };
            if (v4 > 0) {
                arg0.insurance_pool_dust_e8 = arg0.insurance_pool_dust_e8 + v4;
            };
            let v5 = MarginDebitedRealizedPnl{
                user                   : arg1,
                amount                 : arg2,
                debited_from_available : v1,
                debited_from_locked    : v2,
                new_available          : v0.available,
                new_locked             : v0.locked,
                insurance_pool_balance : insurance_pool_balance<T0>(arg0),
            };
            0x2::event::emit<MarginDebitedRealizedPnl>(v5);
        } else {
            let (v6, v7) = canonical_to_raw_floor(arg2);
            if (!0x2::table::contains<address, UserBalance>(&arg0.balances, arg1)) {
                let v8 = UserBalance{
                    available : 0,
                    locked    : 0,
                };
                0x2::table::add<address, UserBalance>(&mut arg0.balances, arg1, v8);
            };
            if (v7 == 0) {
                assert!(0x2::balance::value<T0>(&arg0.insurance_pool) >= v6, 5);
                if (v6 > 0) {
                    0x2::balance::join<T0>(&mut arg0.vault, 0x2::balance::split<T0>(&mut arg0.insurance_pool, v6));
                };
            } else if (arg0.insurance_pool_dust_e8 >= v7) {
                assert!(0x2::balance::value<T0>(&arg0.insurance_pool) >= v6, 5);
                if (v6 > 0) {
                    0x2::balance::join<T0>(&mut arg0.vault, 0x2::balance::split<T0>(&mut arg0.insurance_pool, v6));
                };
                arg0.insurance_pool_dust_e8 = arg0.insurance_pool_dust_e8 - v7;
            } else {
                let v9 = v6 + 1;
                assert!(0x2::balance::value<T0>(&arg0.insurance_pool) >= v9, 5);
                0x2::balance::join<T0>(&mut arg0.vault, 0x2::balance::split<T0>(&mut arg0.insurance_pool, v9));
                arg0.insurance_pool_dust_e8 = arg0.insurance_pool_dust_e8 + 100 - v7;
            };
            let v10 = 0x2::table::borrow_mut<address, UserBalance>(&mut arg0.balances, arg1);
            v10.available = v10.available + arg2;
            arg0.total_deposits = arg0.total_deposits + arg2;
            let v11 = MarginCreditedRealizedPnl{
                user                   : arg1,
                amount                 : arg2,
                new_available          : v10.available,
                insurance_pool_balance : insurance_pool_balance<T0>(arg0),
            };
            0x2::event::emit<MarginCreditedRealizedPnl>(v11);
        };
    }

    public fun decimals<T0>(arg0: &MarginBank<T0>) : u8 {
        arg0.decimals
    }

    public fun deposit<T0>(arg0: &mut MarginBank<T0>, arg1: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::admin_config::GlobalParams, arg2: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::market_factory::MarketRegistry, arg3: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::circuit_breaker::BreakerRegistry, arg4: vector<u8>, arg5: 0x2::coin::Coin<T0>, arg6: &mut 0x2::tx_context::TxContext) {
        0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::admin_config::assert_not_paused(arg1);
        0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::trade_validator::assert_trade_allowed(arg1, arg2, arg3, arg4, false);
        assert!(arg0.enabled, 1);
        let v0 = 0x2::coin::value<T0>(&arg5);
        assert!(v0 > 0, 2);
        let v1 = coin_to_canonical_amount(v0);
        let v2 = 0x2::tx_context::sender(arg6);
        0x2::balance::join<T0>(&mut arg0.vault, 0x2::coin::into_balance<T0>(arg5));
        if (!0x2::table::contains<address, UserBalance>(&arg0.balances, v2)) {
            let v3 = UserBalance{
                available : 0,
                locked    : 0,
            };
            0x2::table::add<address, UserBalance>(&mut arg0.balances, v2, v3);
        };
        let v4 = 0x2::table::borrow_mut<address, UserBalance>(&mut arg0.balances, v2);
        v4.available = v4.available + v1;
        arg0.total_deposits = arg0.total_deposits + v1;
        let v5 = Deposit{
            user        : v2,
            amount      : v1,
            new_balance : v4.available + v4.locked,
        };
        0x2::event::emit<Deposit>(v5);
    }

    public(friend) fun ensure_balance_exists<T0>(arg0: &mut MarginBank<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (!0x2::table::contains<address, UserBalance>(&arg0.balances, arg1)) {
            let v0 = UserBalance{
                available : 0,
                locked    : 0,
            };
            0x2::table::add<address, UserBalance>(&mut arg0.balances, arg1, v0);
        };
    }

    public fun fee_pool_balance<T0>(arg0: &MarginBank<T0>) : u64 {
        coin_to_canonical_amount(0x2::balance::value<T0>(&arg0.fee_pool))
    }

    public fun get_available_balance<T0>(arg0: &MarginBank<T0>, arg1: address) : u64 {
        if (!0x2::table::contains<address, UserBalance>(&arg0.balances, arg1)) {
            return 0
        };
        0x2::table::borrow<address, UserBalance>(&arg0.balances, arg1).available
    }

    public fun get_locked_balance<T0>(arg0: &MarginBank<T0>, arg1: address) : u64 {
        if (!0x2::table::contains<address, UserBalance>(&arg0.balances, arg1)) {
            return 0
        };
        0x2::table::borrow<address, UserBalance>(&arg0.balances, arg1).locked
    }

    public fun get_total_balance<T0>(arg0: &MarginBank<T0>, arg1: address) : u64 {
        if (!0x2::table::contains<address, UserBalance>(&arg0.balances, arg1)) {
            return 0
        };
        let v0 = 0x2::table::borrow<address, UserBalance>(&arg0.balances, arg1);
        v0.available + v0.locked
    }

    public fun has_balance<T0>(arg0: &MarginBank<T0>, arg1: address) : bool {
        0x2::table::contains<address, UserBalance>(&arg0.balances, arg1)
    }

    public fun insurance_pool_balance<T0>(arg0: &MarginBank<T0>) : u64 {
        coin_to_canonical_amount(0x2::balance::value<T0>(&arg0.insurance_pool)) + arg0.insurance_pool_dust_e8
    }

    public fun is_enabled<T0>(arg0: &MarginBank<T0>) : bool {
        arg0.enabled
    }

    public fun is_mainnet_usdc_metadata(arg0: address, arg1: u8) : bool {
        arg0 == mainnet_usdc_package_address() && arg1 == mainnet_usdc_decimals()
    }

    public(friend) fun lock_collateral<T0>(arg0: &mut MarginBank<T0>, arg1: address, arg2: u64) {
        assert!(arg2 > 0, 2);
        assert!(0x2::table::contains<address, UserBalance>(&arg0.balances, arg1), 0);
        let v0 = 0x2::table::borrow_mut<address, UserBalance>(&mut arg0.balances, arg1);
        assert!(v0.available >= arg2, 0);
        v0.available = v0.available - arg2;
        v0.locked = v0.locked + arg2;
        let v1 = CollateralLocked{
            user          : arg1,
            amount        : arg2,
            new_available : v0.available,
            new_locked    : v0.locked,
        };
        0x2::event::emit<CollateralLocked>(v1);
    }

    public fun mainnet_usdc_decimals() : u8 {
        6
    }

    public fun mainnet_usdc_package_address() : address {
        @0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7
    }

    public(friend) fun record_realized_pnl_debit<T0>(arg0: &MarginBank<T0>, arg1: address, arg2: u64) {
        if (arg2 == 0) {
            return
        };
        let (v0, v1) = if (0x2::table::contains<address, UserBalance>(&arg0.balances, arg1)) {
            let v2 = 0x2::table::borrow<address, UserBalance>(&arg0.balances, arg1);
            (v2.available, v2.locked)
        } else {
            (0, 0)
        };
        let v3 = MarginDebitedRealizedPnl{
            user                   : arg1,
            amount                 : arg2,
            debited_from_available : 0,
            debited_from_locked    : arg2,
            new_available          : v0,
            new_locked             : v1,
            insurance_pool_balance : insurance_pool_balance<T0>(arg0),
        };
        0x2::event::emit<MarginDebitedRealizedPnl>(v3);
    }

    public fun seed_insurance_pool<T0>(arg0: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::admin_config::AdminCap, arg1: &mut MarginBank<T0>, arg2: 0x2::coin::Coin<T0>) {
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 2);
        0x2::balance::join<T0>(&mut arg1.insurance_pool, 0x2::coin::into_balance<T0>(arg2));
        let v1 = InsurancePoolSeeded{
            amount                     : v0,
            new_insurance_pool_balance : 0x2::balance::value<T0>(&arg1.insurance_pool),
        };
        0x2::event::emit<InsurancePoolSeeded>(v1);
    }

    public fun set_enabled<T0>(arg0: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::admin_config::AdminCap, arg1: &mut MarginBank<T0>, arg2: bool) {
        arg1.enabled = arg2;
    }

    public(friend) fun slash_locked<T0>(arg0: &mut MarginBank<T0>, arg1: address, arg2: u64) {
        assert!(arg2 > 0, 2);
        assert!(0x2::table::contains<address, UserBalance>(&arg0.balances, arg1), 0);
        let v0 = 0x2::table::borrow_mut<address, UserBalance>(&mut arg0.balances, arg1);
        assert!(v0.locked >= arg2, 3);
        v0.locked = v0.locked - arg2;
        arg0.total_deposits = arg0.total_deposits - arg2;
        let (v1, v2) = canonical_to_raw_floor(arg2);
        if (v1 > 0) {
            0x2::balance::join<T0>(&mut arg0.insurance_pool, 0x2::balance::split<T0>(&mut arg0.vault, v1));
        };
        if (v2 > 0) {
            arg0.insurance_pool_dust_e8 = arg0.insurance_pool_dust_e8 + v2;
        };
    }

    public fun total_deposits<T0>(arg0: &MarginBank<T0>) : u64 {
        arg0.total_deposits
    }

    public(friend) fun transfer_locked<T0>(arg0: &mut MarginBank<T0>, arg1: address, arg2: address, arg3: u64) {
        if (arg3 == 0) {
            return
        };
        assert!(0x2::table::contains<address, UserBalance>(&arg0.balances, arg1), 0);
        assert!(0x2::table::contains<address, UserBalance>(&arg0.balances, arg2), 0);
        let v0 = 0x2::table::borrow_mut<address, UserBalance>(&mut arg0.balances, arg1);
        assert!(v0.locked >= arg3, 3);
        v0.locked = v0.locked - arg3;
        let v1 = 0x2::table::borrow_mut<address, UserBalance>(&mut arg0.balances, arg2);
        v1.locked = v1.locked + arg3;
    }

    public(friend) fun transfer_pnl<T0>(arg0: &mut MarginBank<T0>, arg1: address, arg2: address, arg3: u64) : u64 {
        if (arg3 == 0) {
            return 0
        };
        assert!(0x2::table::contains<address, UserBalance>(&arg0.balances, arg1), 0);
        if (!0x2::table::contains<address, UserBalance>(&arg0.balances, arg2)) {
            return 0
        };
        let v0 = 0x2::table::borrow_mut<address, UserBalance>(&mut arg0.balances, arg1);
        let v1 = if (arg3 > v0.locked) {
            v0.locked
        } else {
            arg3
        };
        v0.locked = v0.locked - v1;
        let v2 = 0x2::table::borrow_mut<address, UserBalance>(&mut arg0.balances, arg2);
        v2.available = v2.available + v1;
        v1
    }

    public(friend) fun unlock_collateral<T0>(arg0: &mut MarginBank<T0>, arg1: address, arg2: u64) {
        assert!(arg2 > 0, 2);
        assert!(0x2::table::contains<address, UserBalance>(&arg0.balances, arg1), 0);
        let v0 = 0x2::table::borrow_mut<address, UserBalance>(&mut arg0.balances, arg1);
        assert!(v0.locked >= arg2, 3);
        v0.locked = v0.locked - arg2;
        v0.available = v0.available + arg2;
        let v1 = CollateralUnlocked{
            user          : arg1,
            amount        : arg2,
            new_available : v0.available,
            new_locked    : v0.locked,
        };
        0x2::event::emit<CollateralUnlocked>(v1);
    }

    public fun withdraw<T0>(arg0: &mut MarginBank<T0>, arg1: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::admin_config::GlobalParams, arg2: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::market_factory::MarketRegistry, arg3: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::circuit_breaker::BreakerRegistry, arg4: vector<u8>, arg5: u64, arg6: &0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::depeg_state::DepegStateMachine, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::admin_config::assert_not_paused(arg1);
        0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::trade_validator::assert_trade_allowed(arg1, arg2, arg3, arg4, true);
        assert!(0xec72a10acac91bfd59d4e91529e23114c85a3e92a79505bf4c8c1c1ae6a1dc1b::depeg_state::is_withdrawal_allowed(arg6), 4);
        assert!(arg0.enabled, 1);
        assert!(arg5 > 0, 2);
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(0x2::table::contains<address, UserBalance>(&arg0.balances, v0), 0);
        let v1 = 0x2::table::borrow_mut<address, UserBalance>(&mut arg0.balances, v0);
        assert!(v1.available >= arg5, 0);
        let (v2, v3, v4) = canonical_to_coin_amount_floor(arg5);
        assert!(v2 > 0, 2);
        v1.available = v1.available - arg5;
        arg0.total_deposits = arg0.total_deposits - v3;
        if (v4 > 0) {
            arg0.insurance_pool_dust_e8 = arg0.insurance_pool_dust_e8 + v4;
            let v5 = DustSwept{
                user         : v0,
                dust_e8      : v4,
                target_pool  : 0,
                timestamp_ms : 0x2::tx_context::epoch_timestamp_ms(arg7),
            };
            0x2::event::emit<DustSwept>(v5);
        };
        let v6 = Withdrawal{
            user        : v0,
            amount      : v3,
            new_balance : v1.available + v1.locked,
        };
        0x2::event::emit<Withdrawal>(v6);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.vault, v2), arg7)
    }

    // decompiled from Move bytecode v7
}

