module 0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::core {
    struct NavRefreshed has copy, drop {
        nav_per_suix5_usdc: u64,
        portfolio_usdc: u64,
        suix5_supply: u64,
        refreshed_by: address,
        timestamp_ms: u64,
    }

    struct DepositStarted has copy, drop {
        user: address,
        denom: 0x1::type_name::TypeName,
        amount_in: u64,
        gross_value_usdc: u64,
        fee_usdc: u64,
        net_value_usdc: u64,
        suix5_to_mint: u64,
        nav_used: u64,
    }

    struct DepositLegBegun has copy, drop {
        user: address,
        token: 0x1::type_name::TypeName,
        weight_bps: u64,
        denom_spent: u64,
        amount_out_min: u64,
    }

    struct DepositLegSettled has copy, drop {
        user: address,
        token: 0x1::type_name::TypeName,
        token_received: u64,
    }

    struct DepositCompleted has copy, drop {
        user: address,
        suix5_minted: u64,
        leftover_denom: u64,
        timestamp_ms: u64,
    }

    struct WithdrawStarted has copy, drop {
        user: address,
        suix5_burned: u64,
        supply_at_burn: u64,
    }

    struct WithdrawLegBegun has copy, drop {
        user: address,
        token: 0x1::type_name::TypeName,
        token_sold: u64,
        amount_out_min: u64,
    }

    struct WithdrawLegSettled has copy, drop {
        user: address,
        token: 0x1::type_name::TypeName,
        denom_received: u64,
    }

    struct WithdrawCompleted has copy, drop {
        user: address,
        suix5_burned: u64,
        gross_denom: u64,
        fee_denom: u64,
        net_denom: u64,
        timestamp_ms: u64,
    }

    struct DepositTicket<phantom T0> {
        id: 0x2::object::ID,
        user: address,
        remaining: 0x2::balance::Balance<T0>,
        net_amount_denom: u64,
        net_value_usdc: u64,
        suix5_to_mint: u64,
        nav_used: u64,
        bought: vector<0x1::type_name::TypeName>,
    }

    struct WithdrawTicket<phantom T0> {
        id: 0x2::object::ID,
        user: address,
        suix5_burned: u64,
        supply_at_burn: u64,
        proceeds: 0x2::balance::Balance<T0>,
        sold: vector<0x1::type_name::TypeName>,
    }

    struct NavTicket {
        total_usdc: u64,
        priced: vector<0x1::type_name::TypeName>,
        started_ms: u64,
    }

    struct SwapReceipt {
        ticket_id: 0x2::object::ID,
        token: 0x1::type_name::TypeName,
        amount_out_min: u64,
    }

    fun apply_slippage(arg0: u64) : u64 {
        arg0 * (10000 - 100) / 10000
    }

    fun assert_constituent(arg0: &0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::SuiX5Vault, arg1: 0x1::type_name::TypeName) {
        assert!(0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::composition::contains(0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::composition_ref(arg0), arg1), 504);
    }

    public fun deposit_begin<T0>(arg0: &mut 0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::SuiX5Vault, arg1: 0x2::coin::Coin<T0>, arg2: &0x5d822921e69a841952ae20490bca998984f430aed4af604d048d2e32f304c92a::adapter::PriceCache, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : DepositTicket<T0> {
        0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::assert_not_paused(arg0);
        0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::assert_nav_fresh(arg0, arg3);
        0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::assert_adapter(arg0, 0x2::object::id<0x5d822921e69a841952ae20490bca998984f430aed4af604d048d2e32f304c92a::adapter::PriceCache>(arg2));
        let v0 = 0x1::type_name::get<T0>();
        assert!(!0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::composition::contains(0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::composition_ref(arg0), v0), 512);
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = 0x2::coin::value<T0>(&arg1);
        assert!(v2 > 0, 502);
        let v3 = 0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::oracle::value_of<T0>(0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::oracle_mut(arg0), v2, arg2, arg3);
        let v4 = 0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::calc_deposit_fee(arg0, v3);
        let v5 = v3 - v4;
        assert!(v5 > 0, 502);
        let v6 = 0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::cached_nav(arg0);
        assert!(v6 > 0, 502);
        let v7 = (((v5 as u128) * (1000000 as u128) / (v6 as u128)) as u64);
        assert!(v7 > 0, 502);
        let v8 = 0x2::coin::into_balance<T0>(arg1);
        let v9 = (((v2 as u128) * (v4 as u128) / (v3 as u128)) as u64);
        if (v9 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v8, v9), arg4), 0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::fee_collector(arg0));
            0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::record_fee(arg0, v4);
        };
        let v10 = DepositStarted{
            user             : v1,
            denom            : v0,
            amount_in        : v2,
            gross_value_usdc : v3,
            fee_usdc         : v4,
            net_value_usdc   : v5,
            suix5_to_mint    : v7,
            nav_used         : v6,
        };
        0x2::event::emit<DepositStarted>(v10);
        DepositTicket<T0>{
            id               : fresh_id(arg4),
            user             : v1,
            remaining        : v8,
            net_amount_denom : 0x2::balance::value<T0>(&v8),
            net_value_usdc   : v5,
            suix5_to_mint    : v7,
            nav_used         : v6,
            bought           : 0x1::vector::empty<0x1::type_name::TypeName>(),
        }
    }

    public fun deposit_finish<T0, T1, T2, T3, T4, T5>(arg0: &mut 0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::SuiX5Vault, arg1: DepositTicket<T5>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::suix5::SUIX5> {
        let DepositTicket {
            id               : _,
            user             : v1,
            remaining        : v2,
            net_amount_denom : _,
            net_value_usdc   : _,
            suix5_to_mint    : v5,
            nav_used         : _,
            bought           : v7,
        } = arg1;
        let v8 = v7;
        let v9 = v2;
        assert!(0x1::vector::length<0x1::type_name::TypeName>(&v8) == 5, 510);
        let v10 = 0x1::type_name::get<T0>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&v8, &v10), 510);
        let v11 = 0x1::type_name::get<T1>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&v8, &v11), 510);
        let v12 = 0x1::type_name::get<T2>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&v8, &v12), 510);
        let v13 = 0x1::type_name::get<T3>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&v8, &v13), 510);
        let v14 = 0x1::type_name::get<T4>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&v8, &v14), 510);
        let v15 = 0x2::balance::value<T5>(&v9);
        assert!(v15 <= 1000, 511);
        if (v15 > 0) {
            0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::join_balance<T5>(arg0, v9);
        } else {
            0x2::balance::destroy_zero<T5>(v9);
        };
        let v16 = DepositCompleted{
            user           : v1,
            suix5_minted   : v5,
            leftover_denom : v15,
            timestamp_ms   : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<DepositCompleted>(v16);
        0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::mint_suix5(arg0, v5, arg3)
    }

    public fun deposit_leg_begin<T0, T1>(arg0: &mut 0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::SuiX5Vault, arg1: &mut DepositTicket<T1>, arg2: &0x5d822921e69a841952ae20490bca998984f430aed4af604d048d2e32f304c92a::adapter::PriceCache, arg3: &0x2::clock::Clock) : (0x2::balance::Balance<T1>, SwapReceipt) {
        let (v0, v1, v2) = leg_plan<T0, T1>(arg0, arg1, arg2, arg3);
        let v3 = apply_slippage(v1);
        let v4 = DepositLegBegun{
            user           : arg1.user,
            token          : 0x1::type_name::get<T0>(),
            weight_bps     : v2,
            denom_spent    : v0,
            amount_out_min : v3,
        };
        0x2::event::emit<DepositLegBegun>(v4);
        let v5 = SwapReceipt{
            ticket_id      : arg1.id,
            token          : 0x1::type_name::get<T0>(),
            amount_out_min : v3,
        };
        (0x2::balance::split<T1>(&mut arg1.remaining, v0), v5)
    }

    public fun deposit_leg_settle<T0, T1>(arg0: &mut 0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::SuiX5Vault, arg1: &mut DepositTicket<T1>, arg2: 0x2::balance::Balance<T0>, arg3: SwapReceipt) {
        let SwapReceipt {
            ticket_id      : v0,
            token          : v1,
            amount_out_min : v2,
        } = arg3;
        assert!(v0 == arg1.id, 516);
        assert!(v1 == 0x1::type_name::get<T0>(), 516);
        assert_constituent(arg0, v1);
        let v3 = 0x2::balance::value<T0>(&arg2);
        assert!(v3 >= v2, 515);
        0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::join_balance<T0>(arg0, arg2);
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg1.bought, v1);
        let v4 = DepositLegSettled{
            user           : arg1.user,
            token          : v1,
            token_received : v3,
        };
        0x2::event::emit<DepositLegSettled>(v4);
    }

    fun fresh_id(arg0: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::object::new(arg0);
        0x2::object::delete(v0);
        0x2::object::uid_to_inner(&v0)
    }

    public fun index_size() : u64 {
        5
    }

    fun leg_plan<T0, T1>(arg0: &mut 0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::SuiX5Vault, arg1: &DepositTicket<T1>, arg2: &0x5d822921e69a841952ae20490bca998984f430aed4af604d048d2e32f304c92a::adapter::PriceCache, arg3: &0x2::clock::Clock) : (u64, u64, u64) {
        let v0 = 0x1::type_name::get<T0>();
        assert_constituent(arg0, v0);
        assert!(!0x1::vector::contains<0x1::type_name::TypeName>(&arg1.bought, &v0), 509);
        let v1 = 0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::composition::weight_of(0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::composition_ref(arg0), v0);
        let v2 = (((arg1.net_amount_denom as u128) * (v1 as u128) / (10000 as u128)) as u64);
        assert!(v2 > 0, 502);
        (v2, units_for_value<T0>(arg0, (((arg1.net_value_usdc as u128) * (v1 as u128) / (10000 as u128)) as u64), arg2, arg3), v1)
    }

    public fun max_leftover() : u64 {
        1000
    }

    public fun nav_add<T0>(arg0: &mut 0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::SuiX5Vault, arg1: &mut NavTicket, arg2: &0x5d822921e69a841952ae20490bca998984f430aed4af604d048d2e32f304c92a::adapter::PriceCache, arg3: &0x2::clock::Clock) {
        0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::assert_adapter(arg0, 0x2::object::id<0x5d822921e69a841952ae20490bca998984f430aed4af604d048d2e32f304c92a::adapter::PriceCache>(arg2));
        let v0 = 0x1::type_name::get<T0>();
        assert!(!0x1::vector::contains<0x1::type_name::TypeName>(&arg1.priced, &v0), 513);
        let v1 = 0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::balance_of<T0>(arg0);
        if (v1 > 0) {
            arg1.total_usdc = arg1.total_usdc + 0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::oracle::value_of<T0>(0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::oracle_mut(arg0), v1, arg2, arg3);
        };
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg1.priced, v0);
    }

    public fun nav_begin(arg0: &0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::SuiX5Vault, arg1: &0x2::clock::Clock) : NavTicket {
        0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::assert_not_paused(arg0);
        assert!(0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::composition::token_count(0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::composition_ref(arg0)) > 0, 505);
        NavTicket{
            total_usdc : 0,
            priced     : 0x1::vector::empty<0x1::type_name::TypeName>(),
            started_ms : 0x2::clock::timestamp_ms(arg1),
        }
    }

    public fun nav_finish(arg0: &mut 0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::SuiX5Vault, arg1: NavTicket, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let NavTicket {
            total_usdc : v0,
            priced     : v1,
            started_ms : _,
        } = arg1;
        let v3 = v1;
        let v4 = 0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::discovered(arg0);
        let v5 = 0;
        while (v5 < 0x1::vector::length<0x1::type_name::TypeName>(&v4)) {
            let v6 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v4, v5);
            if (0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::tracked_balance(arg0, v6) > 0) {
                assert!(0x1::vector::contains<0x1::type_name::TypeName>(&v3, &v6), 514);
            };
            v5 = v5 + 1;
        };
        let v7 = 0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::supply_internal(arg0);
        let v8 = 0x2::clock::timestamp_ms(arg2);
        let v9 = if (v7 == 0) {
            assert!(v0 == 0, 506);
            1000000
        } else {
            (((v0 as u128) * (1000000 as u128) / (v7 as u128)) as u64)
        };
        0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::write_nav_cache(arg0, v9, v0, v8);
        let v10 = NavRefreshed{
            nav_per_suix5_usdc : v9,
            portfolio_usdc     : v0,
            suix5_supply       : v7,
            refreshed_by       : 0x2::tx_context::sender(arg3),
            timestamp_ms       : v8,
        };
        0x2::event::emit<NavRefreshed>(v10);
    }

    fun pow10(arg0: u64) : u64 {
        let v0 = 1;
        let v1 = 0;
        while (v1 < arg0) {
            v0 = v0 * 10;
            v1 = v1 + 1;
        };
        v0
    }

    public fun preview_deposit(arg0: &0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::SuiX5Vault, arg1: u64) : (u64, u64, u64) {
        let v0 = 0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::calc_deposit_fee(arg0, arg1);
        let v1 = arg1 - v0;
        let v2 = 0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::cached_nav(arg0);
        let v3 = if (v2 == 0) {
            0
        } else {
            (((v1 as u128) * (1000000 as u128) / (v2 as u128)) as u64)
        };
        (v0, v1, v3)
    }

    public fun preview_withdraw_leg<T0>(arg0: &0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::SuiX5Vault, arg1: u64) : u64 {
        let v0 = 0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::supply_internal(arg0);
        if (v0 == 0) {
            return 0
        };
        (((0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::balance_of<T0>(arg0) as u128) * (arg1 as u128) / (v0 as u128)) as u64)
    }

    fun units_for_value<T0>(arg0: &mut 0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::SuiX5Vault, arg1: u64, arg2: &0x5d822921e69a841952ae20490bca998984f430aed4af604d048d2e32f304c92a::adapter::PriceCache, arg3: &0x2::clock::Clock) : u64 {
        0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::assert_adapter(arg0, 0x2::object::id<0x5d822921e69a841952ae20490bca998984f430aed4af604d048d2e32f304c92a::adapter::PriceCache>(arg2));
        let v0 = 0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::oracle_mut(arg0);
        (((arg1 as u128) * (pow10((0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::oracle::decimals_of(v0, 0x1::type_name::get<T0>()) as u64)) as u128) / (0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::oracle::get_price_usdc<T0>(v0, arg2, arg3) as u128)) as u64)
    }

    public fun withdraw_begin<T0>(arg0: &mut 0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::SuiX5Vault, arg1: 0x2::coin::Coin<0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::suix5::SUIX5>, arg2: &mut 0x2::tx_context::TxContext) : WithdrawTicket<T0> {
        0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::assert_not_paused(arg0);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::coin::value<0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::suix5::SUIX5>(&arg1);
        assert!(v1 > 0, 502);
        let v2 = 0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::supply_internal(arg0);
        0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::burn_suix5(arg0, arg1);
        let v3 = WithdrawStarted{
            user           : v0,
            suix5_burned   : v1,
            supply_at_burn : v2,
        };
        0x2::event::emit<WithdrawStarted>(v3);
        WithdrawTicket<T0>{
            id             : fresh_id(arg2),
            user           : v0,
            suix5_burned   : v1,
            supply_at_burn : v2,
            proceeds       : 0x2::balance::zero<T0>(),
            sold           : 0x1::vector::empty<0x1::type_name::TypeName>(),
        }
    }

    public fun withdraw_finish<T0, T1, T2, T3, T4, T5>(arg0: &mut 0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::SuiX5Vault, arg1: WithdrawTicket<T5>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T5> {
        let WithdrawTicket {
            id             : _,
            user           : v1,
            suix5_burned   : v2,
            supply_at_burn : _,
            proceeds       : v4,
            sold           : v5,
        } = arg1;
        let v6 = v5;
        let v7 = v4;
        assert!(0x1::vector::length<0x1::type_name::TypeName>(&v6) == 5, 510);
        let v8 = 0x1::type_name::get<T0>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&v6, &v8), 510);
        let v9 = 0x1::type_name::get<T1>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&v6, &v9), 510);
        let v10 = 0x1::type_name::get<T2>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&v6, &v10), 510);
        let v11 = 0x1::type_name::get<T3>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&v6, &v11), 510);
        let v12 = 0x1::type_name::get<T4>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&v6, &v12), 510);
        let v13 = 0x2::balance::value<T5>(&v7);
        assert!(v13 > 0, 502);
        let v14 = 0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::calc_withdrawal_fee(arg0, v13);
        if (v14 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T5>>(0x2::coin::from_balance<T5>(0x2::balance::split<T5>(&mut v7, v14), arg3), 0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::fee_collector(arg0));
            0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::record_fee(arg0, v14);
        };
        let v15 = WithdrawCompleted{
            user         : v1,
            suix5_burned : v2,
            gross_denom  : v13,
            fee_denom    : v14,
            net_denom    : 0x2::balance::value<T5>(&v7),
            timestamp_ms : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<WithdrawCompleted>(v15);
        0x2::coin::from_balance<T5>(v7, arg3)
    }

    public fun withdraw_leg_begin<T0, T1>(arg0: &mut 0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::SuiX5Vault, arg1: &mut WithdrawTicket<T1>, arg2: &0x5d822921e69a841952ae20490bca998984f430aed4af604d048d2e32f304c92a::adapter::PriceCache, arg3: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, SwapReceipt) {
        let (v0, v1) = withdraw_leg_plan<T0, T1>(arg0, arg1, arg2, arg3);
        let v2 = apply_slippage(v1);
        let v3 = WithdrawLegBegun{
            user           : arg1.user,
            token          : 0x1::type_name::get<T0>(),
            token_sold     : v0,
            amount_out_min : v2,
        };
        0x2::event::emit<WithdrawLegBegun>(v3);
        let v4 = SwapReceipt{
            ticket_id      : arg1.id,
            token          : 0x1::type_name::get<T0>(),
            amount_out_min : v2,
        };
        (0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::split_balance<T0>(arg0, v0), v4)
    }

    fun withdraw_leg_plan<T0, T1>(arg0: &mut 0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::SuiX5Vault, arg1: &WithdrawTicket<T1>, arg2: &0x5d822921e69a841952ae20490bca998984f430aed4af604d048d2e32f304c92a::adapter::PriceCache, arg3: &0x2::clock::Clock) : (u64, u64) {
        let v0 = 0x1::type_name::get<T0>();
        assert_constituent(arg0, v0);
        assert!(!0x1::vector::contains<0x1::type_name::TypeName>(&arg1.sold, &v0), 509);
        let v1 = (((0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::balance_of<T0>(arg0) as u128) * (arg1.suix5_burned as u128) / (arg1.supply_at_burn as u128)) as u64);
        assert!(v1 > 0, 502);
        0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::assert_adapter(arg0, 0x2::object::id<0x5d822921e69a841952ae20490bca998984f430aed4af604d048d2e32f304c92a::adapter::PriceCache>(arg2));
        let v2 = 0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::oracle_mut(arg0);
        (v1, units_for_value<T1>(arg0, (((v1 as u128) * (0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::oracle::get_price_usdc<T0>(v2, arg2, arg3) as u128) / (pow10((0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::oracle::decimals_of(v2, v0) as u64)) as u128)) as u64), arg2, arg3))
    }

    public fun withdraw_leg_settle<T0, T1>(arg0: &0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::SuiX5Vault, arg1: &mut WithdrawTicket<T1>, arg2: 0x2::balance::Balance<T1>, arg3: SwapReceipt) {
        let SwapReceipt {
            ticket_id      : v0,
            token          : v1,
            amount_out_min : v2,
        } = arg3;
        assert!(v0 == arg1.id, 516);
        assert!(v1 == 0x1::type_name::get<T0>(), 516);
        assert_constituent(arg0, v1);
        let v3 = 0x2::balance::value<T1>(&arg2);
        assert!(v3 >= v2, 515);
        0x2::balance::join<T1>(&mut arg1.proceeds, arg2);
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg1.sold, v1);
        let v4 = WithdrawLegSettled{
            user           : arg1.user,
            token          : v1,
            denom_received : v3,
        };
        0x2::event::emit<WithdrawLegSettled>(v4);
    }

    // decompiled from Move bytecode v7
}

