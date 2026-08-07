module 0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::core {
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

    struct DepositLeg has copy, drop {
        user: address,
        token: 0x1::type_name::TypeName,
        weight_bps: u64,
        denom_spent: u64,
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

    struct WithdrawLeg has copy, drop {
        user: address,
        token: 0x1::type_name::TypeName,
        token_sold: u64,
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
        user: address,
        remaining: 0x2::balance::Balance<T0>,
        net_amount_denom: u64,
        net_value_usdc: u64,
        suix5_to_mint: u64,
        nav_used: u64,
        bought: vector<0x1::type_name::TypeName>,
    }

    struct WithdrawTicket<phantom T0> {
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

    fun assert_constituent(arg0: &0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::SuiX5Vault, arg1: 0x1::type_name::TypeName) {
        assert!(0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::composition::contains(0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::composition_ref(arg0), arg1), 504);
    }

    public fun deposit_begin<T0>(arg0: &mut 0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::SuiX5Vault, arg1: 0x2::coin::Coin<T0>, arg2: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : DepositTicket<T0> {
        0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::assert_not_paused(arg0);
        0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::assert_nav_fresh(arg0, arg3);
        let v0 = 0x1::type_name::get<T0>();
        assert!(!0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::composition::contains(0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::composition_ref(arg0), v0), 512);
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = 0x2::coin::value<T0>(&arg1);
        assert!(v2 > 0, 502);
        let v3 = 0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::oracle::value_of<T0>(0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::oracle_mut(arg0), v2, arg2, arg3);
        let v4 = 0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::calc_deposit_fee(arg0, v3);
        let v5 = v3 - v4;
        assert!(v5 > 0, 502);
        let v6 = 0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::cached_nav(arg0);
        assert!(v6 > 0, 502);
        let v7 = (((v5 as u128) * (1000000 as u128) / (v6 as u128)) as u64);
        assert!(v7 > 0, 502);
        let v8 = 0x2::coin::into_balance<T0>(arg1);
        let v9 = (((v2 as u128) * (v4 as u128) / (v3 as u128)) as u64);
        if (v9 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v8, v9), arg4), 0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::fee_collector(arg0));
            0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::record_fee(arg0, v4);
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
            user             : v1,
            remaining        : v8,
            net_amount_denom : 0x2::balance::value<T0>(&v8),
            net_value_usdc   : v5,
            suix5_to_mint    : v7,
            nav_used         : v6,
            bought           : 0x1::vector::empty<0x1::type_name::TypeName>(),
        }
    }

    public fun deposit_finish<T0, T1, T2, T3, T4, T5>(arg0: &mut 0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::SuiX5Vault, arg1: DepositTicket<T5>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::suix5::SUIX5> {
        let DepositTicket {
            user             : v0,
            remaining        : v1,
            net_amount_denom : _,
            net_value_usdc   : _,
            suix5_to_mint    : v4,
            nav_used         : _,
            bought           : v6,
        } = arg1;
        let v7 = v6;
        let v8 = v1;
        assert!(0x1::vector::length<0x1::type_name::TypeName>(&v7) == 5, 510);
        let v9 = 0x1::type_name::get<T0>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&v7, &v9), 510);
        let v10 = 0x1::type_name::get<T1>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&v7, &v10), 510);
        let v11 = 0x1::type_name::get<T2>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&v7, &v11), 510);
        let v12 = 0x1::type_name::get<T3>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&v7, &v12), 510);
        let v13 = 0x1::type_name::get<T4>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&v7, &v13), 510);
        let v14 = 0x2::balance::value<T5>(&v8);
        assert!(v14 <= 1000, 511);
        if (v14 > 0) {
            0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::join_balance<T5>(arg0, v8);
        } else {
            0x2::balance::destroy_zero<T5>(v8);
        };
        let v15 = DepositCompleted{
            user           : v0,
            suix5_minted   : v4,
            leftover_denom : v14,
            timestamp_ms   : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<DepositCompleted>(v15);
        0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::mint_suix5(arg0, v4, arg3)
    }

    public fun deposit_leg_token_is_a<T0, T1>(arg0: &mut 0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::SuiX5Vault, arg1: &mut DepositTicket<T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock) {
        let (v0, v1, v2) = leg_plan<T0, T1>(arg0, arg1);
        let v3 = 0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::trading::sell_b_for_a<T0, T1>(0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::trading_ref(arg0), arg2, arg3, 0x2::balance::split<T1>(&mut arg1.remaining, v0), v1, arg4);
        0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::join_balance<T0>(arg0, v3);
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg1.bought, 0x1::type_name::get<T0>());
        let v4 = DepositLeg{
            user           : arg1.user,
            token          : 0x1::type_name::get<T0>(),
            weight_bps     : v2,
            denom_spent    : v0,
            token_received : 0x2::balance::value<T0>(&v3),
        };
        0x2::event::emit<DepositLeg>(v4);
    }

    public fun deposit_leg_token_is_b<T0, T1>(arg0: &mut 0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::SuiX5Vault, arg1: &mut DepositTicket<T0>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock) {
        let (v0, v1, v2) = leg_plan<T1, T0>(arg0, arg1);
        let v3 = 0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::trading::sell_a_for_b<T0, T1>(0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::trading_ref(arg0), arg2, arg3, 0x2::balance::split<T0>(&mut arg1.remaining, v0), v1, arg4);
        0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::join_balance<T1>(arg0, v3);
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg1.bought, 0x1::type_name::get<T1>());
        let v4 = DepositLeg{
            user           : arg1.user,
            token          : 0x1::type_name::get<T1>(),
            weight_bps     : v2,
            denom_spent    : v0,
            token_received : 0x2::balance::value<T1>(&v3),
        };
        0x2::event::emit<DepositLeg>(v4);
    }

    public fun index_size() : u64 {
        5
    }

    fun leg_plan<T0, T1>(arg0: &0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::SuiX5Vault, arg1: &DepositTicket<T1>) : (u64, u64, u64) {
        let v0 = 0x1::type_name::get<T0>();
        assert_constituent(arg0, v0);
        assert!(!0x1::vector::contains<0x1::type_name::TypeName>(&arg1.bought, &v0), 509);
        let v1 = 0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::composition::weight_of(0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::composition_ref(arg0), v0);
        let v2 = (((arg1.net_amount_denom as u128) * (v1 as u128) / (10000 as u128)) as u64);
        assert!(v2 > 0, 502);
        (v2, units_for_value<T0>(arg0, (((arg1.net_value_usdc as u128) * (v1 as u128) / (10000 as u128)) as u64)), v1)
    }

    public fun max_leftover() : u64 {
        1000
    }

    public fun nav_add<T0>(arg0: &mut 0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::SuiX5Vault, arg1: &mut NavTicket, arg2: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg3: &0x2::clock::Clock) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(!0x1::vector::contains<0x1::type_name::TypeName>(&arg1.priced, &v0), 513);
        let v1 = 0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::balance_of<T0>(arg0);
        if (v1 > 0) {
            arg1.total_usdc = arg1.total_usdc + 0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::oracle::value_of<T0>(0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::oracle_mut(arg0), v1, arg2, arg3);
        };
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg1.priced, v0);
    }

    public fun nav_begin(arg0: &0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::SuiX5Vault, arg1: &0x2::clock::Clock) : NavTicket {
        0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::assert_not_paused(arg0);
        assert!(0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::composition::token_count(0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::composition_ref(arg0)) > 0, 505);
        NavTicket{
            total_usdc : 0,
            priced     : 0x1::vector::empty<0x1::type_name::TypeName>(),
            started_ms : 0x2::clock::timestamp_ms(arg1),
        }
    }

    public fun nav_finish(arg0: &mut 0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::SuiX5Vault, arg1: NavTicket, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let NavTicket {
            total_usdc : v0,
            priced     : v1,
            started_ms : _,
        } = arg1;
        let v3 = v1;
        let v4 = 0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::discovered(arg0);
        let v5 = 0;
        while (v5 < 0x1::vector::length<0x1::type_name::TypeName>(&v4)) {
            let v6 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v4, v5);
            if (0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::tracked_balance(arg0, v6) > 0) {
                assert!(0x1::vector::contains<0x1::type_name::TypeName>(&v3, &v6), 514);
            };
            v5 = v5 + 1;
        };
        let v7 = 0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::supply_internal(arg0);
        let v8 = 0x2::clock::timestamp_ms(arg2);
        let v9 = if (v7 == 0) {
            assert!(v0 == 0, 506);
            1000000
        } else {
            (((v0 as u128) * (1000000 as u128) / (v7 as u128)) as u64)
        };
        0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::write_nav_cache(arg0, v9, v0, v8);
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

    public fun preview_deposit(arg0: &0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::SuiX5Vault, arg1: u64) : (u64, u64, u64) {
        let v0 = 0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::calc_deposit_fee(arg0, arg1);
        let v1 = arg1 - v0;
        let v2 = 0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::cached_nav(arg0);
        let v3 = if (v2 == 0) {
            0
        } else {
            (((v1 as u128) * (1000000 as u128) / (v2 as u128)) as u64)
        };
        (v0, v1, v3)
    }

    public fun preview_withdraw_leg<T0>(arg0: &0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::SuiX5Vault, arg1: u64) : u64 {
        let v0 = 0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::supply_internal(arg0);
        if (v0 == 0) {
            return 0
        };
        (((0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::balance_of<T0>(arg0) as u128) * (arg1 as u128) / (v0 as u128)) as u64)
    }

    fun units_for_value<T0>(arg0: &0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::SuiX5Vault, arg1: u64) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::oracle_ref(arg0);
        let v2 = 0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::oracle::get_last_price(v1, v0);
        assert!(v2 > 0, 502);
        (((arg1 as u128) * (pow10((0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::oracle::decimals_of(v1, v0) as u64)) as u128) / (v2 as u128)) as u64)
    }

    public fun withdraw_begin<T0>(arg0: &mut 0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::SuiX5Vault, arg1: 0x2::coin::Coin<0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::suix5::SUIX5>, arg2: &mut 0x2::tx_context::TxContext) : WithdrawTicket<T0> {
        0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::assert_not_paused(arg0);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::coin::value<0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::suix5::SUIX5>(&arg1);
        assert!(v1 > 0, 502);
        let v2 = 0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::supply_internal(arg0);
        0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::burn_suix5(arg0, arg1);
        let v3 = WithdrawStarted{
            user           : v0,
            suix5_burned   : v1,
            supply_at_burn : v2,
        };
        0x2::event::emit<WithdrawStarted>(v3);
        WithdrawTicket<T0>{
            user           : v0,
            suix5_burned   : v1,
            supply_at_burn : v2,
            proceeds       : 0x2::balance::zero<T0>(),
            sold           : 0x1::vector::empty<0x1::type_name::TypeName>(),
        }
    }

    public fun withdraw_finish<T0, T1, T2, T3, T4, T5>(arg0: &mut 0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::SuiX5Vault, arg1: WithdrawTicket<T5>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T5> {
        let WithdrawTicket {
            user           : v0,
            suix5_burned   : v1,
            supply_at_burn : _,
            proceeds       : v3,
            sold           : v4,
        } = arg1;
        let v5 = v4;
        let v6 = v3;
        assert!(0x1::vector::length<0x1::type_name::TypeName>(&v5) == 5, 510);
        let v7 = 0x1::type_name::get<T0>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&v5, &v7), 510);
        let v8 = 0x1::type_name::get<T1>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&v5, &v8), 510);
        let v9 = 0x1::type_name::get<T2>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&v5, &v9), 510);
        let v10 = 0x1::type_name::get<T3>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&v5, &v10), 510);
        let v11 = 0x1::type_name::get<T4>();
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&v5, &v11), 510);
        let v12 = 0x2::balance::value<T5>(&v6);
        assert!(v12 > 0, 502);
        let v13 = 0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::calc_withdrawal_fee(arg0, v12);
        if (v13 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T5>>(0x2::coin::from_balance<T5>(0x2::balance::split<T5>(&mut v6, v13), arg3), 0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::fee_collector(arg0));
            0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::record_fee(arg0, v13);
        };
        let v14 = WithdrawCompleted{
            user         : v0,
            suix5_burned : v1,
            gross_denom  : v12,
            fee_denom    : v13,
            net_denom    : 0x2::balance::value<T5>(&v6),
            timestamp_ms : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<WithdrawCompleted>(v14);
        0x2::coin::from_balance<T5>(v6, arg3)
    }

    fun withdraw_leg_plan<T0, T1>(arg0: &0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::SuiX5Vault, arg1: &WithdrawTicket<T1>) : (u64, u64) {
        let v0 = 0x1::type_name::get<T0>();
        assert_constituent(arg0, v0);
        assert!(!0x1::vector::contains<0x1::type_name::TypeName>(&arg1.sold, &v0), 509);
        let v1 = (((0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::balance_of<T0>(arg0) as u128) * (arg1.suix5_burned as u128) / (arg1.supply_at_burn as u128)) as u64);
        assert!(v1 > 0, 502);
        let v2 = 0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::oracle_ref(arg0);
        let v3 = 0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::oracle::get_last_price(v2, v0);
        assert!(v3 > 0, 502);
        (v1, units_for_value<T1>(arg0, (((v1 as u128) * (v3 as u128) / (pow10((0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::oracle::decimals_of(v2, v0) as u64)) as u128)) as u64)))
    }

    public fun withdraw_leg_token_is_a<T0, T1>(arg0: &mut 0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::SuiX5Vault, arg1: &mut WithdrawTicket<T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock) {
        let (v0, v1) = withdraw_leg_plan<T0, T1>(arg0, arg1);
        let v2 = 0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::trading::sell_a_for_b<T0, T1>(0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::trading_ref(arg0), arg2, arg3, 0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::split_balance<T0>(arg0, v0), v1, arg4);
        0x2::balance::join<T1>(&mut arg1.proceeds, v2);
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg1.sold, 0x1::type_name::get<T0>());
        let v3 = WithdrawLeg{
            user           : arg1.user,
            token          : 0x1::type_name::get<T0>(),
            token_sold     : v0,
            denom_received : 0x2::balance::value<T1>(&v2),
        };
        0x2::event::emit<WithdrawLeg>(v3);
    }

    public fun withdraw_leg_token_is_b<T0, T1>(arg0: &mut 0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::SuiX5Vault, arg1: &mut WithdrawTicket<T0>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock) {
        let (v0, v1) = withdraw_leg_plan<T1, T0>(arg0, arg1);
        let v2 = 0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::trading::sell_b_for_a<T0, T1>(0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::trading_ref(arg0), arg2, arg3, 0x7462018d9266714d1f9f00533942232526d7a304125cf38228b74d51bf452df0::vault::split_balance<T1>(arg0, v0), v1, arg4);
        0x2::balance::join<T0>(&mut arg1.proceeds, v2);
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg1.sold, 0x1::type_name::get<T1>());
        let v3 = WithdrawLeg{
            user           : arg1.user,
            token          : 0x1::type_name::get<T1>(),
            token_sold     : v0,
            denom_received : 0x2::balance::value<T0>(&v2),
        };
        0x2::event::emit<WithdrawLeg>(v3);
    }

    // decompiled from Move bytecode v7
}

