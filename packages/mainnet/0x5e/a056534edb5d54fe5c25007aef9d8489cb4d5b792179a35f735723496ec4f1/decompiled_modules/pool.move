module 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::pool {
    struct POOL has drop {
        dummy_field: bool,
    }

    struct Pool<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        coin_a: 0x2::balance::Balance<T0>,
        coin_b: 0x2::balance::Balance<T1>,
        liquidity: u128,
        current_sqrt_price: u128,
        current_tick_index: 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i32::I32,
        fee_growth_global_a: u256,
        fee_growth_global_b: u256,
        fee_protocol_coin_a: u64,
        fee_protocol_coin_b: u64,
        tick_manager: 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::tick::TickManager,
        reward_manager: 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::reward::RewardManager,
        position_manager: 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::position::PositionManager,
        fee_manager: 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::fee::FeeManager,
        permissions: 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::permission::Permission,
        index: u64,
        url: 0x1::string::String,
        creator: address,
    }

    struct SwapResult has copy, drop {
        amount_in: u64,
        amount_out: u64,
        protocol_fee_amount: u64,
        fee_amount: u64,
        ref_fee_amount: u64,
        steps: vector<StepResult>,
    }

    struct StepResult has copy, drop {
        current_sqrt_price: u128,
        target_sqrt_price: u128,
        current_liquidity: u128,
        amount_in: u64,
        amount_out: u64,
        fee_amount: u64,
        base_fee_rate: u64,
        total_fee_rate: u64,
    }

    struct FlashSwapReceipt<phantom T0, phantom T1> {
        pool_id: 0x2::object::ID,
        fee_on_coin_a: bool,
        a2b: bool,
        partner_id: 0x2::object::ID,
        pay_amount: u64,
        ref_fee_amount: u64,
    }

    struct FlashLoanReceipt<phantom T0, phantom T1> {
        pool_id: 0x2::object::ID,
        loan_a: bool,
        partner_id: 0x2::object::ID,
        amount: u64,
        fee_amount: u64,
        ref_fee_amount: u64,
    }

    struct OpenPositionEvent has copy, drop {
        pool: 0x2::object::ID,
        tick_lower: 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i32::I32,
        tick_upper: 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i32::I32,
        position: 0x2::object::ID,
    }

    struct ClosePositionEvent has copy, drop {
        pool: 0x2::object::ID,
        position: 0x2::object::ID,
    }

    struct AddLiquidityEvent has copy, drop {
        pool: 0x2::object::ID,
        position: 0x2::object::ID,
        tick_lower: 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i32::I32,
        tick_upper: 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i32::I32,
        liquidity: u128,
        after_liquidity: u128,
        current_sqrt_price: u128,
        amount_a: u64,
        amount_b: u64,
    }

    struct RemoveLiquidityEvent has copy, drop {
        pool: 0x2::object::ID,
        position: 0x2::object::ID,
        tick_lower: 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i32::I32,
        tick_upper: 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i32::I32,
        liquidity: u128,
        after_liquidity: u128,
        current_sqrt_price: u128,
        amount_a: u64,
        amount_b: u64,
    }

    struct SwapEvent has copy, drop {
        pool: 0x2::object::ID,
        from: 0x1::type_name::TypeName,
        target: 0x1::type_name::TypeName,
        partner: 0x2::object::ID,
        amount_in: u64,
        amount_out: u64,
        ref_amount: u64,
        protocol_fee_amount: u64,
        fee_amount: u64,
        vault_a_amount: u64,
        vault_b_amount: u64,
        before_sqrt_price: u128,
        after_sqrt_price: u128,
        steps: vector<StepResult>,
        fee_coin: 0x1::type_name::TypeName,
    }

    struct CollectProtocolFeeEvent has copy, drop {
        pool: 0x2::object::ID,
        amount_a: u64,
        amount_b: u64,
    }

    struct CollectFeeEvent has copy, drop {
        position: 0x2::object::ID,
        pool: 0x2::object::ID,
        amount_a: u64,
        amount_b: u64,
    }

    struct InitializeRewardEvent has copy, drop {
        pool: 0x2::object::ID,
        reward_type: 0x1::type_name::TypeName,
    }

    struct AddRewardEvent has copy, drop {
        pool: 0x2::object::ID,
        reward_type: 0x1::type_name::TypeName,
        amount: u64,
        start_time: u64,
        end_time: u64,
    }

    struct CollectRewardEvent has copy, drop {
        position: 0x2::object::ID,
        pool: 0x2::object::ID,
        reward_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct FlashLoanEvent has copy, drop {
        pool: 0x2::object::ID,
        loan_a: bool,
        partner: 0x2::object::ID,
        amount: u64,
        fee_amount: u64,
        ref_amount: u64,
        vault_a_amount: u64,
        vault_b_amount: u64,
    }

    struct RewardSettleEvent has copy, drop {
        pool: 0x2::object::ID,
        current_sqrt_price: u128,
        accumulated_rewards: vector<u128>,
        duration: u64,
    }

    struct UpdatePermissionEvent has copy, drop {
        pool: 0x2::object::ID,
        old_permissions: 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::permission::FeaturePermission,
        new_permissions: 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::permission::FeaturePermission,
    }

    struct EmergencyPauseRewardEvent has copy, drop {
        pool: 0x2::object::ID,
    }

    struct EmergencyUnpauseRewardEvent has copy, drop {
        pool: 0x2::object::ID,
    }

    struct EmergencyWithdrawRefundRewardEvent has copy, drop {
        pool: 0x2::object::ID,
        reward: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct MakeRewardPublicEvent has copy, drop {
        pool: 0x2::object::ID,
    }

    struct MakeRewardPrivateEvent has copy, drop {
        pool: 0x2::object::ID,
    }

    public(friend) fun new<T0, T1>(arg0: u128, arg1: 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::config::FeeTier, arg2: 0x1::option::Option<0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::dynamic_fee::DynamicFeeConfig>, arg3: 0x1::option::Option<0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::fee_scheduler::FeeScheduler>, arg4: 0x1::option::Option<0x1::type_name::TypeName>, arg5: u64, arg6: u64, arg7: u32, arg8: 0x1::string::String, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : Pool<T0, T1> {
        let v0 = 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::config::tick_spacing(&arg1);
        Pool<T0, T1>{
            id                  : 0x2::object::new(arg11),
            coin_a              : 0x2::balance::zero<T0>(),
            coin_b              : 0x2::balance::zero<T1>(),
            liquidity           : 0,
            current_sqrt_price  : arg0,
            current_tick_index  : 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::tick_math::get_tick_at_sqrt_price(arg0),
            fee_growth_global_a : 0,
            fee_growth_global_b : 0,
            fee_protocol_coin_a : 0,
            fee_protocol_coin_b : 0,
            tick_manager        : 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::tick::new(v0, 0x2::clock::timestamp_ms(arg10), arg11),
            reward_manager      : 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::reward::new(arg11),
            position_manager    : 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::position::new(v0, arg7, arg11),
            fee_manager         : 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::fee::new(arg1, arg0, arg2, arg3, arg4, arg6),
            permissions         : 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::permission::new(arg5, arg6),
            index               : arg9,
            url                 : arg8,
            creator             : 0x2::tx_context::sender(arg11),
        }
    }

    public fun tick_spacing<T0, T1>(arg0: &Pool<T0, T1>) : u32 {
        0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::fee::tick_spacing(&arg0.fee_manager)
    }

    public fun add_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::position::Position, arg2: &mut 0x2::coin::Coin<T0>, arg3: &mut 0x2::coin::Coin<T1>, arg4: u128, arg5: &0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::config::GlobalConfig, arg6: &0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::versioned::Versioned, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::versioned::check_version(arg6);
        0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::config::validate_restriction(arg5, 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::restriction::add_kind(), 0x2::tx_context::sender(arg8), 0x1::option::none<0x2::object::ID>());
        assert!(arg4 != 0, 13835905409380253701);
        let (v0, v1) = add_liquidity_internal<T0, T1>(arg0, arg1, false, arg4, 0, false, arg7);
        let v2 = v1;
        let v3 = v0;
        0x1::debug::print<u64>(&v3);
        0x1::debug::print<u64>(&v2);
        assert!(0x2::coin::value<T0>(arg2) >= v3, 13838438735711174675);
        assert!(0x2::coin::value<T1>(arg3) >= v2, 13838438740006141971);
        0x2::balance::join<T0>(&mut arg0.coin_a, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg2, v3, arg8)));
        0x2::balance::join<T1>(&mut arg0.coin_b, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(arg3, v2, arg8)));
    }

    public fun add_liquidity_fix_coin<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::position::Position, arg2: u64, arg3: bool, arg4: &mut 0x2::coin::Coin<T0>, arg5: &mut 0x2::coin::Coin<T1>, arg6: &0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::config::GlobalConfig, arg7: &0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::versioned::Versioned, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::versioned::check_version(arg7);
        0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::config::validate_restriction(arg6, 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::restriction::add_kind(), 0x2::tx_context::sender(arg9), 0x1::option::none<0x2::object::ID>());
        assert!(arg2 > 0, 13835061246442864641);
        let (v0, v1) = add_liquidity_internal<T0, T1>(arg0, arg1, true, 0, arg2, arg3, arg8);
        assert!(0x2::coin::value<T0>(arg4) >= v0, 13838438989114245139);
        assert!(0x2::coin::value<T1>(arg5) >= v1, 13838438993409212435);
        0x2::balance::join<T0>(&mut arg0.coin_a, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg4, v0, arg9)));
        0x2::balance::join<T1>(&mut arg0.coin_b, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(arg5, v1, arg9)));
    }

    fun add_liquidity_internal<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::position::Position, arg2: bool, arg3: u128, arg4: u64, arg5: bool, arg6: &0x2::clock::Clock) : (u64, u64) {
        0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::permission::validate_add(&arg0.permissions, arg6);
        assert!(0x2::object::id<Pool<T0, T1>>(arg0) == 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::position::pool_id(arg1), 13840415756402819101);
        reward_settle<T0, T1>(arg0, arg6);
        let (v0, v1) = 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::position::tick_range(arg1);
        let (v2, v3, v4) = if (arg2) {
            0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::clmm_math::get_liquidity_by_amount(v0, v1, arg0.current_sqrt_price, arg4, arg5)
        } else {
            let (v5, v6) = 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::clmm_math::get_amount_by_liquidity(v0, v1, arg0.current_tick_index, arg0.current_sqrt_price, arg3, true);
            (arg3, v5, v6)
        };
        assert!(v2 > 0, 13835912264148058117);
        let (v7, v8, v9) = get_fee_rewards_in_tick_range<T0, T1>(arg0, v0, v1);
        0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::tick::increase_liquidity(&mut arg0.tick_manager, arg0.current_tick_index, v0, v1, v2, arg0.fee_growth_global_a, arg0.fee_growth_global_b, 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::reward::rewards_growth_global(&arg0.reward_manager));
        if (0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i32::gte(arg0.current_tick_index, v0) && 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i32::lt(arg0.current_tick_index, v1)) {
            assert!(0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::math_u128::add_check(arg0.liquidity, v2), 13835349451633459203);
            arg0.liquidity = arg0.liquidity + v2;
        };
        let v10 = AddLiquidityEvent{
            pool               : 0x2::object::id<Pool<T0, T1>>(arg0),
            position           : 0x2::object::id<0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::position::Position>(arg1),
            tick_lower         : v0,
            tick_upper         : v1,
            liquidity          : v2,
            after_liquidity    : 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::position::increase_liquidity(&mut arg0.position_manager, arg1, v2, v7, v8, v9),
            current_sqrt_price : arg0.current_sqrt_price,
            amount_a           : v3,
            amount_b           : v4,
        };
        0x2::event::emit<AddLiquidityEvent>(v10);
        (v3, v4)
    }

    public fun add_reward<T0, T1, T2>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T2>, arg2: 0x1::option::Option<u64>, arg3: u64, arg4: &0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::config::GlobalConfig, arg5: &0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::versioned::Versioned, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::versioned::check_version(arg5);
        0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::config::validate_restriction(arg4, 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::restriction::add_reward_kind(), 0x2::tx_context::sender(arg7), 0x1::option::none<0x2::object::ID>());
        if (!0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::reward::is_public(&arg0.reward_manager) || !0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::config::is_reward_public(arg4)) {
            0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::config::check_reward_manager(arg4, 0x2::tx_context::sender(arg7));
        };
        let v0 = if (0x1::option::is_none<u64>(&arg2)) {
            0x2::clock::timestamp_ms(arg6) / 1000
        } else {
            *0x1::option::borrow<u64>(&arg2)
        };
        assert!(v0 < arg3, 13845761036477005865);
        assert!(v0 >= 1757332800, 13846042515748814891);
        let v1 = 0x2::coin::value<T2>(&arg1);
        assert!(v1 > 0, 13846323999315591213);
        let v2 = arg3 - v0;
        assert!(v2 <= 63072000, 13846605487177334831);
        assert!(v2 >= 3600, 13846605491472302127);
        if (!0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::config::is_reward_manager(arg4, 0x2::tx_context::sender(arg7))) {
            if (0x1::option::is_some<u64>(&arg2)) {
                assert!((*0x1::option::borrow<u64>(&arg2) - 1757332800) % 604800 == 0, 13846042562993455147);
            };
            assert!(v2 >= 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::config::min_reward_duration(arg4), 13847449959352500277);
            assert!((arg3 - 1757332800) % 604800 == 0, 13845761126671319081);
        };
        reward_settle<T0, T1>(arg0, arg6);
        0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::reward::add_reward<T2>(&mut arg0.reward_manager, arg2, arg3, 0x2::coin::into_balance<T2>(arg1), arg6);
        let v3 = AddRewardEvent{
            pool        : 0x2::object::id<Pool<T0, T1>>(arg0),
            reward_type : 0x1::type_name::with_defining_ids<T2>(),
            amount      : v1,
            start_time  : v0,
            end_time    : arg3,
        };
        0x2::event::emit<AddRewardEvent>(v3);
    }

    public fun balances<T0, T1>(arg0: &Pool<T0, T1>) : (&0x2::balance::Balance<T0>, &0x2::balance::Balance<T1>) {
        (&arg0.coin_a, &arg0.coin_b)
    }

    public fun borrow_position_info<T0, T1>(arg0: &Pool<T0, T1>, arg1: 0x2::object::ID) : &0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::position::PositionInfo {
        0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::position::borrow_position_info(&arg0.position_manager, arg1)
    }

    public fun borrow_tick<T0, T1>(arg0: &Pool<T0, T1>, arg1: 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i32::I32) : &0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::tick::Tick {
        0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::tick::borrow_tick(&arg0.tick_manager, arg1)
    }

    public fun calculate_and_update_fee<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::object::ID, arg2: &0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::versioned::Versioned) : (u64, u64) {
        0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::versioned::check_version(arg2);
        let v0 = 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::position::borrow_position_info(&arg0.position_manager, arg1);
        if (0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::position::info_liquidity(v0) != 0) {
            let (v3, v4) = 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::position::info_tick_range(v0);
            let (v5, v6) = get_fee_in_tick_range<T0, T1>(arg0, v3, v4);
            0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::position::update_fee(&mut arg0.position_manager, arg1, v5, v6)
        } else {
            0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::position::info_fee_owned(v0)
        }
    }

    public fun calculate_and_update_rewards<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::object::ID, arg2: &0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::versioned::Versioned, arg3: &0x2::clock::Clock) : vector<u64> {
        0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::versioned::check_version(arg2);
        reward_settle<T0, T1>(arg0, arg3);
        let v0 = 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::position::borrow_position_info(&arg0.position_manager, arg1);
        if (0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::position::info_liquidity(v0) != 0) {
            let (v2, v3) = 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::position::info_tick_range(v0);
            0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::position::update_rewards(&mut arg0.position_manager, arg1, get_rewards_in_tick_range<T0, T1>(arg0, v2, v3))
        } else {
            0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::position::rewards_amount_owned(&arg0.position_manager, arg1)
        }
    }

    public fun close_position<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::position::Position, arg2: &0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::config::GlobalConfig, arg3: &0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::versioned::Versioned, arg4: &0x2::tx_context::TxContext) {
        0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::versioned::check_version(arg3);
        0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::config::validate_restriction(arg2, 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::restriction::remove_kind(), 0x2::tx_context::sender(arg4), 0x1::option::none<0x2::object::ID>());
        0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::permission::validate_remove(&arg0.permissions);
        assert!(0x2::object::id<Pool<T0, T1>>(arg0) == 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::position::pool_id(&arg1), 13840409971081871389);
        0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::position::close_position(&mut arg0.position_manager, arg1);
        let v0 = ClosePositionEvent{
            pool     : 0x2::object::id<Pool<T0, T1>>(arg0),
            position : 0x2::object::id<0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::position::Position>(&arg1),
        };
        0x2::event::emit<ClosePositionEvent>(v0);
    }

    public fun collect_fee<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::position::Position, arg2: bool, arg3: &0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::config::GlobalConfig, arg4: &0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::versioned::Versioned, arg5: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::versioned::check_version(arg4);
        0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::config::validate_restriction(arg3, 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::restriction::collect_fee_kind(), 0x2::tx_context::sender(arg5), 0x1::option::none<0x2::object::ID>());
        0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::permission::validate_collect_fee(&arg0.permissions);
        assert!(0x2::object::id<Pool<T0, T1>>(arg0) == 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::position::pool_id(arg1), 13840410190125203485);
        let v0 = 0x2::object::id<0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::position::Position>(arg1);
        let (v1, v2) = 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::position::tick_range(arg1);
        let (v3, v4) = if (arg2 && 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::position::liquidity(arg1) != 0) {
            let (v5, v6) = get_fee_in_tick_range<T0, T1>(arg0, v1, v2);
            0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::position::update_and_reset_fee(&mut arg0.position_manager, v0, v5, v6)
        } else {
            0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::position::reset_fee(&mut arg0.position_manager, v0)
        };
        let v7 = CollectFeeEvent{
            position : v0,
            pool     : 0x2::object::id<Pool<T0, T1>>(arg0),
            amount_a : v3,
            amount_b : v4,
        };
        0x2::event::emit<CollectFeeEvent>(v7);
        (0x2::balance::split<T0>(&mut arg0.coin_a, v3), 0x2::balance::split<T1>(&mut arg0.coin_b, v4))
    }

    public fun collect_protocol_fee<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::config::GlobalConfig, arg2: &0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::versioned::Versioned, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::versioned::check_version(arg2);
        0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::config::check_protocol_fee_manager(arg1, 0x2::tx_context::sender(arg3));
        collect_protocol_fee_internal<T0, T1>(arg0, arg3)
    }

    fun collect_protocol_fee_internal<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = arg0.fee_protocol_coin_a;
        let v1 = arg0.fee_protocol_coin_b;
        assert!(v0 > 0 || v1 > 0, 13844358922927996963);
        assert!(0x2::balance::value<T0>(&arg0.coin_a) >= v0 && 0x2::balance::value<T1>(&arg0.coin_b) >= v1, 13844640410789740581);
        arg0.fee_protocol_coin_a = 0;
        arg0.fee_protocol_coin_b = 0;
        let v2 = CollectProtocolFeeEvent{
            pool     : 0x2::object::id<Pool<T0, T1>>(arg0),
            amount_a : v0,
            amount_b : v1,
        };
        0x2::event::emit<CollectProtocolFeeEvent>(v2);
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.coin_a, v0), arg1), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.coin_b, v1), arg1))
    }

    public fun collect_protocol_fee_with_cap<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::config::GlobalConfig, arg2: &0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::admin_cap::OperationCap, arg3: &0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::versioned::Versioned, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::versioned::check_version(arg3);
        0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::config::check_protocol_fee_manager(arg1, 0x2::object::id_address<0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::admin_cap::OperationCap>(arg2));
        collect_protocol_fee_internal<T0, T1>(arg0, arg4)
    }

    public fun collect_reward<T0, T1, T2>(arg0: &mut Pool<T0, T1>, arg1: &0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::position::Position, arg2: bool, arg3: &0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::config::GlobalConfig, arg4: &0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::versioned::Versioned, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T2> {
        0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::versioned::check_version(arg4);
        0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::config::validate_restriction(arg3, 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::restriction::collect_reward_kind(), 0x2::tx_context::sender(arg6), 0x1::option::none<0x2::object::ID>());
        0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::permission::validate_collect_reward(&arg0.permissions);
        assert!(0x2::object::id<Pool<T0, T1>>(arg0) == 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::position::pool_id(arg1), 13840410512247750685);
        reward_settle<T0, T1>(arg0, arg5);
        let v0 = 0x2::object::id<0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::position::Position>(arg1);
        let v1 = 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::reward::reward_index<T2>(&arg0.reward_manager);
        assert!(0x1::option::is_some<u64>(&v1), 13839847592358838297);
        let v2 = 0x1::option::extract<u64>(&mut v1);
        let v3 = if (arg2 && 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::position::liquidity(arg1) != 0 || 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::position::inited_rewards_count(&arg0.position_manager, v0) <= v2) {
            let (v4, v5) = 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::position::tick_range(arg1);
            0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::position::update_and_reset_rewards(&mut arg0.position_manager, v0, get_rewards_in_tick_range<T0, T1>(arg0, v4, v5), v2)
        } else {
            0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::position::reset_reward(&mut arg0.position_manager, v0, v2)
        };
        let v6 = CollectRewardEvent{
            position    : v0,
            pool        : 0x2::object::id<Pool<T0, T1>>(arg0),
            reward_type : 0x1::type_name::with_defining_ids<T2>(),
            amount      : v3,
        };
        0x2::event::emit<CollectRewardEvent>(v6);
        0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::reward::withdraw<T2>(&mut arg0.reward_manager, v3)
    }

    public fun current_sqrt_price<T0, T1>(arg0: &Pool<T0, T1>) : u128 {
        arg0.current_sqrt_price
    }

    public fun current_tick_index<T0, T1>(arg0: &Pool<T0, T1>) : 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i32::I32 {
        arg0.current_tick_index
    }

    fun default_swap_result() : SwapResult {
        SwapResult{
            amount_in           : 0,
            amount_out          : 0,
            protocol_fee_amount : 0,
            fee_amount          : 0,
            ref_fee_amount      : 0,
            steps               : 0x1::vector::empty<StepResult>(),
        }
    }

    public fun emergency_pause_reward<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::config::GlobalConfig, arg2: &0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::versioned::Versioned, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::versioned::check_version(arg2);
        0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::config::check_pool_manager(arg1, 0x2::tx_context::sender(arg4));
        reward_settle<T0, T1>(arg0, arg3);
        0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::reward::emergency_pause(&mut arg0.reward_manager);
        let v0 = EmergencyPauseRewardEvent{pool: 0x2::object::id<Pool<T0, T1>>(arg0)};
        0x2::event::emit<EmergencyPauseRewardEvent>(v0);
    }

    public fun emergency_unpause_reward<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::config::GlobalConfig, arg2: &0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::versioned::Versioned, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::versioned::check_version(arg2);
        0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::config::check_pool_manager(arg1, 0x2::tx_context::sender(arg4));
        reward_settle<T0, T1>(arg0, arg3);
        0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::reward::emergency_unpause(&mut arg0.reward_manager);
        let v0 = EmergencyUnpauseRewardEvent{pool: 0x2::object::id<Pool<T0, T1>>(arg0)};
        0x2::event::emit<EmergencyUnpauseRewardEvent>(v0);
    }

    public fun emergency_withdraw_refund_reward<T0, T1, T2>(arg0: &mut Pool<T0, T1>, arg1: &0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::config::GlobalConfig, arg2: &0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::versioned::Versioned, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::versioned::check_version(arg2);
        0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::config::check_reward_manager(arg1, 0x2::tx_context::sender(arg3));
        let v0 = 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::reward::emergency_withdraw_refund_reward<T2>(&mut arg0.reward_manager);
        let v1 = EmergencyWithdrawRefundRewardEvent{
            pool   : 0x2::object::id<Pool<T0, T1>>(arg0),
            reward : 0x1::type_name::with_defining_ids<T2>(),
            amount : 0x2::balance::value<T2>(&v0),
        };
        0x2::event::emit<EmergencyWithdrawRefundRewardEvent>(v1);
        0x2::coin::from_balance<T2>(v0, arg3)
    }

    public fun fee_manager<T0, T1>(arg0: &Pool<T0, T1>) : &0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::fee::FeeManager {
        &arg0.fee_manager
    }

    public fun fees_growth_global<T0, T1>(arg0: &Pool<T0, T1>) : (u256, u256) {
        (arg0.fee_growth_global_a, arg0.fee_growth_global_b)
    }

    public fun fetch_ticks<T0, T1>(arg0: &Pool<T0, T1>, arg1: 0x1::option::Option<u32>, arg2: u64) : vector<0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::tick::Tick> {
        0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::tick::fetch_ticks(&arg0.tick_manager, arg1, arg2)
    }

    public fun flash_loan<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::config::GlobalConfig, arg2: bool, arg3: u64, arg4: &0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::versioned::Versioned, arg5: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, FlashLoanReceipt<T0, T1>) {
        0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::versioned::check_version(arg4);
        0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::config::validate_restriction(arg1, 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::restriction::flash_loan_kind(), 0x2::tx_context::sender(arg5), 0x1::option::none<0x2::object::ID>());
        0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::permission::validate_flash_loan(&arg0.permissions);
        flash_loan_internal<T0, T1>(arg0, 0x2::object::id_from_address(@0x0), 0, arg2, arg3)
    }

    public fun flash_loan_fee_amount<T0, T1>(arg0: &FlashLoanReceipt<T0, T1>) : u64 {
        arg0.fee_amount
    }

    fun flash_loan_internal<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::object::ID, arg2: u64, arg3: bool, arg4: u64) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, FlashLoanReceipt<T0, T1>) {
        assert!(arg4 > 0, 13835068706801057793);
        let v0 = 0x2::balance::value<T0>(&arg0.coin_a);
        let v1 = 0x2::balance::value<T1>(&arg0.coin_b);
        if (arg3) {
            assert!(v0 >= arg4, 13835068719685959681);
        } else {
            assert!(v1 >= arg4, 13835068728275894273);
        };
        let v2 = 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::full_math_u64::mul_div_ceil(arg4, 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::fee::base_fee_rate(&arg0.fee_manager), 1000000000);
        let v3 = if (arg2 != 0) {
            0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::full_math_u64::mul_div_floor(v2, arg2, 1000000000)
        } else {
            0
        };
        let v4 = FlashLoanReceipt<T0, T1>{
            pool_id        : 0x2::object::id<Pool<T0, T1>>(arg0),
            loan_a         : arg3,
            partner_id     : arg1,
            amount         : arg4,
            fee_amount     : v2,
            ref_fee_amount : v3,
        };
        let v5 = FlashLoanEvent{
            pool           : 0x2::object::id<Pool<T0, T1>>(arg0),
            loan_a         : arg3,
            partner        : arg1,
            amount         : arg4,
            fee_amount     : v2,
            ref_amount     : v3,
            vault_a_amount : v0,
            vault_b_amount : v1,
        };
        0x2::event::emit<FlashLoanEvent>(v5);
        let (v6, v7) = if (arg3) {
            arg0.fee_protocol_coin_a = arg0.fee_protocol_coin_a + v2 - v3;
            (0x2::balance::split<T0>(&mut arg0.coin_a, arg4), 0x2::balance::zero<T1>())
        } else {
            arg0.fee_protocol_coin_b = arg0.fee_protocol_coin_b + v2 - v3;
            (0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg0.coin_b, arg4))
        };
        (v6, v7, v4)
    }

    public fun flash_loan_pay_amount<T0, T1>(arg0: &FlashLoanReceipt<T0, T1>) : u64 {
        arg0.amount + arg0.fee_amount
    }

    public fun flash_loan_with_partner<T0, T1>(arg0: &0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::config::GlobalConfig, arg1: &mut Pool<T0, T1>, arg2: &0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::partner::Partner, arg3: bool, arg4: u64, arg5: &0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::versioned::Versioned, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, FlashLoanReceipt<T0, T1>) {
        0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::versioned::check_version(arg5);
        0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::config::validate_restriction(arg0, 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::restriction::flash_loan_kind(), 0x2::tx_context::sender(arg7), 0x1::option::none<0x2::object::ID>());
        0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::permission::validate_flash_loan(&arg1.permissions);
        flash_loan_internal<T0, T1>(arg1, 0x2::object::id<0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::partner::Partner>(arg2), 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::partner::current_ref_fee_rate(arg2, 0x2::clock::timestamp_ms(arg6) / 1000), arg3, arg4)
    }

    public fun flash_swap<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: bool, arg2: bool, arg3: u64, arg4: u128, arg5: &0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::config::GlobalConfig, arg6: &0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::versioned::Versioned, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, FlashSwapReceipt<T0, T1>) {
        0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::versioned::check_version(arg6);
        0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::config::validate_restriction(arg5, 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::restriction::swap_kind(), 0x2::tx_context::sender(arg8), 0x1::option::none<0x2::object::ID>());
        0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::permission::validate_swap(&arg0.permissions, arg7);
        flash_swap_internal<T0, T1>(arg0, 0x2::object::id_from_address(@0x0), 0, arg1, arg2, arg3, arg4, arg7)
    }

    fun flash_swap_internal<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::object::ID, arg2: u64, arg3: bool, arg4: bool, arg5: u64, arg6: u128, arg7: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, FlashSwapReceipt<T0, T1>) {
        assert!(arg5 > 0, 13835068230059687937);
        reward_settle<T0, T1>(arg0, arg7);
        if (arg3) {
            assert!(arg0.current_sqrt_price > arg6 && arg6 >= 4295048016, 13838164484869324817);
        } else {
            assert!(arg0.current_sqrt_price < arg6 && arg6 <= 79226673515401279992447579055, 13838164506344161297);
        };
        let v0 = arg0.current_sqrt_price;
        let v1 = 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::fee::protocol_fee_rate(&arg0.fee_manager);
        let v2 = 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::fee::fee_on_coin_a<T0>(&arg0.fee_manager, arg3);
        let v3 = swap_in_pool<T0, T1>(arg0, arg3, v2, arg4, arg6, arg5, v1, arg2, arg7);
        let (v4, v5) = if (arg3) {
            (0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg0.coin_b, v3.amount_out))
        } else {
            (0x2::balance::split<T0>(&mut arg0.coin_a, v3.amount_out), 0x2::balance::zero<T1>())
        };
        assert!(v3.amount_out > 0, 13840134938555973659);
        let (v6, v7) = if (arg3) {
            (0x1::type_name::with_defining_ids<T1>(), 0x1::type_name::with_defining_ids<T0>())
        } else {
            (0x1::type_name::with_defining_ids<T0>(), 0x1::type_name::with_defining_ids<T1>())
        };
        let v8 = if (v2 == arg3) {
            v3.amount_in + v3.fee_amount
        } else {
            v3.amount_in
        };
        let v9 = SwapEvent{
            pool                : 0x2::object::id<Pool<T0, T1>>(arg0),
            from                : v7,
            target              : v6,
            partner             : arg1,
            amount_in           : v8,
            amount_out          : v3.amount_out,
            ref_amount          : v3.ref_fee_amount,
            protocol_fee_amount : v3.protocol_fee_amount,
            fee_amount          : v3.fee_amount,
            vault_a_amount      : 0x2::balance::value<T0>(&arg0.coin_a),
            vault_b_amount      : 0x2::balance::value<T1>(&arg0.coin_b),
            before_sqrt_price   : v0,
            after_sqrt_price    : arg0.current_sqrt_price,
            steps               : v3.steps,
            fee_coin            : 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::fee::fee_coin<T0, T1>(&arg0.fee_manager, arg3),
        };
        0x2::event::emit<SwapEvent>(v9);
        let v10 = FlashSwapReceipt<T0, T1>{
            pool_id        : 0x2::object::id<Pool<T0, T1>>(arg0),
            fee_on_coin_a  : v2,
            a2b            : arg3,
            partner_id     : arg1,
            pay_amount     : v8,
            ref_fee_amount : v3.ref_fee_amount,
        };
        (v4, v5, v10)
    }

    public fun flash_swap_with_partner<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::partner::Partner, arg2: bool, arg3: bool, arg4: u64, arg5: u128, arg6: &0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::config::GlobalConfig, arg7: &0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::versioned::Versioned, arg8: &0x2::clock::Clock, arg9: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, FlashSwapReceipt<T0, T1>) {
        0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::versioned::check_version(arg7);
        0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::config::validate_restriction(arg6, 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::restriction::swap_kind(), 0x2::tx_context::sender(arg9), 0x1::option::none<0x2::object::ID>());
        0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::permission::validate_swap(&arg0.permissions, arg8);
        flash_swap_internal<T0, T1>(arg0, 0x2::object::id<0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::partner::Partner>(arg1), 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::partner::current_ref_fee_rate(arg1, 0x2::clock::timestamp_ms(arg8) / 1000), arg2, arg3, arg4, arg5, arg8)
    }

    public fun get_fee_in_tick_range<T0, T1>(arg0: &Pool<T0, T1>, arg1: 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i32::I32, arg2: 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i32::I32) : (u256, u256) {
        0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::tick::get_fee_in_range(arg0.current_tick_index, arg0.fee_growth_global_a, arg0.fee_growth_global_b, 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::tick::try_borrow_tick(&arg0.tick_manager, arg1), 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::tick::try_borrow_tick(&arg0.tick_manager, arg2))
    }

    public fun get_fee_rewards_in_tick_range<T0, T1>(arg0: &Pool<T0, T1>, arg1: 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i32::I32, arg2: 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i32::I32) : (u256, u256, vector<u256>) {
        let v0 = 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::tick::try_borrow_tick(&arg0.tick_manager, arg1);
        let v1 = 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::tick::try_borrow_tick(&arg0.tick_manager, arg2);
        let (v2, v3) = 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::tick::get_fee_in_range(arg0.current_tick_index, arg0.fee_growth_global_a, arg0.fee_growth_global_b, v0, v1);
        (v2, v3, 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::tick::get_rewards_in_range(arg0.current_tick_index, 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::reward::rewards_growth_global(&arg0.reward_manager), v0, v1))
    }

    public fun get_position_amounts<T0, T1>(arg0: &Pool<T0, T1>, arg1: 0x2::object::ID) : (u64, u64) {
        let v0 = 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::position::borrow_position_info(&arg0.position_manager, arg1);
        let (v1, v2) = 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::position::info_tick_range(v0);
        0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::clmm_math::get_amount_by_liquidity(v1, v2, arg0.current_tick_index, arg0.current_sqrt_price, 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::position::info_liquidity(v0), false)
    }

    public fun get_position_rewards<T0, T1>(arg0: &Pool<T0, T1>, arg1: 0x2::object::ID) : vector<u64> {
        0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::position::rewards_amount_owned(&arg0.position_manager, arg1)
    }

    public fun get_rewards_in_tick_range<T0, T1>(arg0: &Pool<T0, T1>, arg1: 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i32::I32, arg2: 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i32::I32) : vector<u256> {
        0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::tick::get_rewards_in_range(arg0.current_tick_index, 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::reward::rewards_growth_global(&arg0.reward_manager), 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::tick::try_borrow_tick(&arg0.tick_manager, arg1), 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::tick::try_borrow_tick(&arg0.tick_manager, arg2))
    }

    public fun index<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.index
    }

    public fun initialize_reward<T0, T1, T2>(arg0: &mut Pool<T0, T1>, arg1: &0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::config::GlobalConfig, arg2: &0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::versioned::Versioned, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::versioned::check_version(arg2);
        0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::config::validate_restriction(arg1, 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::restriction::add_reward_kind(), 0x2::tx_context::sender(arg4), 0x1::option::none<0x2::object::ID>());
        if (!0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::reward::is_public(&arg0.reward_manager) || !0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::config::is_reward_public(arg1)) {
            0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::config::check_reward_manager(arg1, 0x2::tx_context::sender(arg4));
        };
        if (!0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::config::is_reward_manager(arg1, 0x2::tx_context::sender(arg4))) {
            let v0 = if (0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::config::is_in_whitelist<T2>(arg1)) {
                true
            } else if (0x1::type_name::with_defining_ids<T0>() == 0x1::type_name::with_defining_ids<T2>()) {
                true
            } else {
                0x1::type_name::with_defining_ids<T1>() == 0x1::type_name::with_defining_ids<T2>()
            };
            assert!(v0, 13847168166548078643);
            assert!(5 - 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::reward::reward_num(&arg0.reward_manager) > (0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::config::manager_reserved_reward_init_slots(arg1) as u64), 13846886708751106097);
        };
        0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::reward::initialize_reward<T2>(&mut arg0.reward_manager, arg3, arg4);
        let v1 = InitializeRewardEvent{
            pool        : 0x2::object::id<Pool<T0, T1>>(arg0),
            reward_type : 0x1::type_name::with_defining_ids<T2>(),
        };
        0x2::event::emit<InitializeRewardEvent>(v1);
    }

    public fun is_position_exist<T0, T1>(arg0: &Pool<T0, T1>, arg1: 0x2::object::ID) : bool {
        0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::position::contains(&arg0.position_manager, arg1)
    }

    public fun liquidity<T0, T1>(arg0: &Pool<T0, T1>) : u128 {
        arg0.liquidity
    }

    public fun make_reward_private<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::config::GlobalConfig, arg2: &0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::versioned::Versioned, arg3: &0x2::tx_context::TxContext) {
        0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::versioned::check_version(arg2);
        0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::config::check_reward_manager(arg1, 0x2::tx_context::sender(arg3));
        0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::reward::make_private(&mut arg0.reward_manager);
        let v0 = MakeRewardPrivateEvent{pool: 0x2::object::id<Pool<T0, T1>>(arg0)};
        0x2::event::emit<MakeRewardPrivateEvent>(v0);
    }

    public fun make_reward_public<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::config::GlobalConfig, arg2: &0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::versioned::Versioned, arg3: &0x2::tx_context::TxContext) {
        0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::versioned::check_version(arg2);
        0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::config::check_reward_manager(arg1, 0x2::tx_context::sender(arg3));
        0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::reward::make_public(&mut arg0.reward_manager);
        let v0 = MakeRewardPublicEvent{pool: 0x2::object::id<Pool<T0, T1>>(arg0)};
        0x2::event::emit<MakeRewardPublicEvent>(v0);
    }

    public fun open_position<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u32, arg2: u32, arg3: &0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::config::GlobalConfig, arg4: &0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::versioned::Versioned, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::position::Position {
        0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::versioned::check_version(arg4);
        0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::config::validate_restriction(arg3, 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::restriction::add_kind(), 0x2::tx_context::sender(arg6), 0x1::option::none<0x2::object::ID>());
        0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::permission::validate_add(&arg0.permissions, arg5);
        let v0 = 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i32::from_u32(arg1);
        let v1 = 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i32::from_u32(arg2);
        let v2 = 0x2::object::id<Pool<T0, T1>>(arg0);
        let v3 = 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::position::open_position<T0, T1>(&mut arg0.position_manager, v2, arg0.index, arg0.url, v0, v1, arg6);
        let v4 = OpenPositionEvent{
            pool       : v2,
            tick_lower : v0,
            tick_upper : v1,
            position   : 0x2::object::id<0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::position::Position>(&v3),
        };
        0x2::event::emit<OpenPositionEvent>(v4);
        v3
    }

    public fun position_manager<T0, T1>(arg0: &Pool<T0, T1>) : &0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::position::PositionManager {
        &arg0.position_manager
    }

    public fun protocol_fee<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64) {
        (arg0.fee_protocol_coin_a, arg0.fee_protocol_coin_b)
    }

    public fun ref_fee_amount<T0, T1>(arg0: &FlashSwapReceipt<T0, T1>) : u64 {
        arg0.ref_fee_amount
    }

    public fun remove_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::position::Position, arg2: u128, arg3: u64, arg4: u64, arg5: &0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::config::GlobalConfig, arg6: &0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::versioned::Versioned, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::versioned::check_version(arg6);
        0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::config::validate_restriction(arg5, 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::restriction::remove_kind(), 0x2::tx_context::sender(arg8), 0x1::option::none<0x2::object::ID>());
        0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::permission::validate_remove(&arg0.permissions);
        assert!(arg2 > 0, 13835905937661231109);
        assert!(0x2::object::id<Pool<T0, T1>>(arg0) == 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::position::pool_id(arg1), 13840409541585141789);
        reward_settle<T0, T1>(arg0, arg7);
        let (v0, v1) = 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::position::tick_range(arg1);
        let (v2, v3, v4) = get_fee_rewards_in_tick_range<T0, T1>(arg0, v0, v1);
        0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::tick::decrease_liquidity(&mut arg0.tick_manager, arg0.current_tick_index, v0, v1, arg2, arg0.fee_growth_global_a, arg0.fee_growth_global_b, 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::reward::rewards_growth_global(&arg0.reward_manager));
        if (0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i32::lte(v0, arg0.current_tick_index) && 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i32::lt(arg0.current_tick_index, v1)) {
            arg0.liquidity = arg0.liquidity - arg2;
        };
        let (v5, v6) = 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::clmm_math::get_amount_by_liquidity(v0, v1, arg0.current_tick_index, arg0.current_sqrt_price, arg2, false);
        assert!(v5 >= arg3, 13845194822348308519);
        assert!(v6 >= arg4, 13845194826643275815);
        let v7 = RemoveLiquidityEvent{
            pool               : 0x2::object::id<Pool<T0, T1>>(arg0),
            position           : 0x2::object::id<0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::position::Position>(arg1),
            tick_lower         : v0,
            tick_upper         : v1,
            liquidity          : arg2,
            after_liquidity    : 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::position::decrease_liquidity(&mut arg0.position_manager, arg1, arg2, v2, v3, v4),
            current_sqrt_price : arg0.current_sqrt_price,
            amount_a           : v5,
            amount_b           : v6,
        };
        0x2::event::emit<RemoveLiquidityEvent>(v7);
        (0x2::balance::split<T0>(&mut arg0.coin_a, v5), 0x2::balance::split<T1>(&mut arg0.coin_b, v6))
    }

    public fun repay_flash_loan<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T1>, arg3: FlashLoanReceipt<T0, T1>, arg4: &0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::versioned::Versioned) {
        0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::versioned::check_version(arg4);
        let FlashLoanReceipt {
            pool_id        : v0,
            loan_a         : v1,
            partner_id     : _,
            amount         : v3,
            fee_amount     : v4,
            ref_fee_amount : v5,
        } = arg3;
        assert!(v0 == 0x2::object::id<Pool<T0, T1>>(arg0), 13840695290054443039);
        assert!(v5 == 0, 13840695294349410335);
        if (v1) {
            assert!(0x2::balance::value<T0>(&arg1) == v3 + v4, 13835065803403165697);
            0x2::balance::join<T0>(&mut arg0.coin_a, arg1);
            0x2::balance::destroy_zero<T1>(arg2);
        } else {
            assert!(0x2::balance::value<T1>(&arg2) == v3 + v4, 13835065820583034881);
            0x2::balance::join<T1>(&mut arg0.coin_b, arg2);
            0x2::balance::destroy_zero<T0>(arg1);
        };
    }

    public fun repay_flash_loan_with_partner<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::partner::Partner, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: FlashLoanReceipt<T0, T1>, arg5: &0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::versioned::Versioned) {
        0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::versioned::check_version(arg5);
        let FlashLoanReceipt {
            pool_id        : v0,
            loan_a         : v1,
            partner_id     : v2,
            amount         : v3,
            fee_amount     : v4,
            ref_fee_amount : v5,
        } = arg4;
        assert!(v0 == 0x2::object::id<Pool<T0, T1>>(arg0), 13840695509097775135);
        assert!(v2 == 0x2::object::id<0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::partner::Partner>(arg1), 13840695513392742431);
        if (v1) {
            assert!(0x2::balance::value<T0>(&arg2) == v3 + v4, 13835066022446497793);
            if (v5 > 0) {
                0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::partner::receive_ref_fee<T0>(arg1, 0x2::balance::split<T0>(&mut arg2, v5));
            };
            0x2::balance::join<T0>(&mut arg0.coin_a, arg2);
            0x2::balance::destroy_zero<T1>(arg3);
        } else {
            assert!(0x2::balance::value<T1>(&arg3) == v3 + v4, 13835066056806236161);
            if (v5 > 0) {
                0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::partner::receive_ref_fee<T1>(arg1, 0x2::balance::split<T1>(&mut arg3, v5));
            };
            0x2::balance::join<T1>(&mut arg0.coin_b, arg3);
            0x2::balance::destroy_zero<T0>(arg2);
        };
    }

    public fun repay_flash_swap<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T1>, arg3: FlashSwapReceipt<T0, T1>, arg4: &0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::versioned::Versioned) {
        0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::versioned::check_version(arg4);
        let FlashSwapReceipt {
            pool_id        : v0,
            fee_on_coin_a  : _,
            a2b            : v2,
            partner_id     : _,
            pay_amount     : v4,
            ref_fee_amount : v5,
        } = arg3;
        assert!(0x2::object::id<Pool<T0, T1>>(arg0) == v0, 13839004215400464405);
        assert!(v5 == 0, 13839004219695431701);
        if (v2) {
            assert!(0x2::balance::value<T0>(&arg1) == v4, 13835063578610106369);
            0x2::balance::join<T0>(&mut arg0.coin_a, arg1);
            0x2::balance::destroy_zero<T1>(arg2);
        } else {
            assert!(0x2::balance::value<T1>(&arg2) == v4, 13835063595789975553);
            0x2::balance::join<T1>(&mut arg0.coin_b, arg2);
            0x2::balance::destroy_zero<T0>(arg1);
        };
    }

    public fun repay_flash_swap_with_partner<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::partner::Partner, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: FlashSwapReceipt<T0, T1>, arg5: &0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::versioned::Versioned) {
        0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::versioned::check_version(arg5);
        let FlashSwapReceipt {
            pool_id        : v0,
            fee_on_coin_a  : v1,
            a2b            : _,
            partner_id     : v3,
            pay_amount     : v4,
            ref_fee_amount : v5,
        } = arg4;
        assert!(0x2::object::id<Pool<T0, T1>>(arg0) == v0, 13839004692141834261);
        assert!(0x2::object::id<0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::partner::Partner>(arg1) == v3, 13839004696436801557);
        if (v1) {
            assert!(0x2::balance::value<T0>(&arg2) == v4, 13835064055351476225);
            if (v5 > 0) {
                0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::partner::receive_ref_fee<T0>(arg1, 0x2::balance::split<T0>(&mut arg2, v5));
            };
            0x2::balance::join<T0>(&mut arg0.coin_a, arg2);
            0x2::balance::destroy_zero<T1>(arg3);
        } else {
            assert!(0x2::balance::value<T1>(&arg3) == v4, 13835064094006181889);
            if (v5 > 0) {
                0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::partner::receive_ref_fee<T1>(arg1, 0x2::balance::split<T1>(&mut arg3, v5));
            };
            0x2::balance::join<T1>(&mut arg0.coin_b, arg3);
            0x2::balance::destroy_zero<T0>(arg2);
        };
    }

    public fun reward_manager<T0, T1>(arg0: &Pool<T0, T1>) : &0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::reward::RewardManager {
        &arg0.reward_manager
    }

    fun reward_settle<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x2::clock::Clock) {
        let v0 = 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::reward::reward_settle(&mut arg0.reward_manager, arg0.liquidity, arg1);
        let v1 = &v0;
        let v2 = 0;
        let v3;
        while (v2 < 0x1::vector::length<u128>(v1)) {
            if (*0x1::vector::borrow<u128>(v1, v2) > 0) {
                v3 = true;
                /* label 6 */
                if (v3) {
                    let v4 = RewardSettleEvent{
                        pool                : 0x2::object::id<Pool<T0, T1>>(arg0),
                        current_sqrt_price  : arg0.current_sqrt_price,
                        accumulated_rewards : v0,
                        duration            : 0x2::clock::timestamp_ms(arg1) / 1000 - 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::reward::last_update_time(&arg0.reward_manager),
                    };
                    0x2::event::emit<RewardSettleEvent>(v4);
                };
                return
            };
            v2 = v2 + 1;
        };
        v3 = false;
        /* goto 6 */
    }

    fun sub_check(arg0: u64, arg1: u64) : u64 {
        assert!(arg0 >= arg1, 13836477761017348105);
        arg0 - arg1
    }

    fun swap_in_pool<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: bool, arg2: bool, arg3: bool, arg4: u128, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock) : SwapResult {
        assert!(arg7 <= 1000000000, 13839572680092024855);
        let v0 = default_swap_result();
        let v1 = 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::tick::first_score_for_swap(&arg0.tick_manager, arg0.current_tick_index, arg1);
        let v2 = 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::reward::rewards_growth_global(&arg0.reward_manager);
        0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::fee::update_references(&mut arg0.fee_manager, arg0.current_sqrt_price, arg8);
        let v3 = 0;
        while (arg5 > 0 && arg0.current_sqrt_price != arg4) {
            if (0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::is_none(&v1)) {
                abort 13836195040499990535
            };
            let (v4, v5) = 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::tick::borrow_tick_for_swap(&arg0.tick_manager, 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u64::borrow(&v1), arg1);
            v1 = v5;
            let v6 = 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::tick::index(v4);
            let v7 = 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::tick::sqrt_price(v4);
            let v8 = if (arg1) {
                0x1::u128::max(arg4, v7)
            } else {
                0x1::u128::min(arg4, v7)
            };
            let (v9, v10) = 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::fee::get_total_fee(&mut arg0.fee_manager, arg8);
            let (v11, v12, v13, v14) = 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::clmm_math::compute_swap_step(arg0.current_sqrt_price, v8, arg0.liquidity, arg5, v9, arg1, arg2, arg3);
            if (v11 != 0 || v14 != 0) {
                if (arg3) {
                    let v15 = sub_check(arg5, v11);
                    arg5 = v15;
                    if (arg2 == arg1) {
                        arg5 = sub_check(v15, v14);
                    };
                } else {
                    arg5 = sub_check(arg5, v12);
                };
                let v16 = &mut v0;
                update_swap_result(v16, arg0.current_sqrt_price, v8, arg0.liquidity, v11, v12, v14, v10, v9);
                let v17 = update_pool_fee<T0, T1>(arg0, v14, arg6, arg2);
                v3 = v3 + v17;
            };
            if (v13 == v7) {
                arg0.current_sqrt_price = v8;
                let v18 = if (arg1) {
                    0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i32::sub(v6, 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i32::from(1))
                } else {
                    v6
                };
                arg0.current_tick_index = v18;
                arg0.liquidity = 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::tick::cross_by_swap(&mut arg0.tick_manager, v6, arg1, arg0.liquidity, arg0.fee_growth_global_a, arg0.fee_growth_global_b, v2);
            } else if (arg0.current_sqrt_price != v13) {
                arg0.current_sqrt_price = v13;
                arg0.current_tick_index = 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::tick_math::get_tick_at_sqrt_price(v13);
            };
            0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::fee::update_volatility_accumulator(&mut arg0.fee_manager, arg0.current_sqrt_price, arg8);
        };
        if (0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i32::lt(arg0.current_tick_index, 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::tick_math::min_tick()) || 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::i32::gte(arg0.current_tick_index, 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::tick_math::max_tick())) {
            abort 13843513754968391713
        };
        v0.protocol_fee_amount = v3;
        v0.ref_fee_amount = 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::full_math_u64::mul_div_floor(v3, arg7, 1000000000);
        if (arg2) {
            assert!(0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::math_u64::add_check(arg0.fee_protocol_coin_a, v3 - v0.ref_fee_amount), 13837321352724217871);
            arg0.fee_protocol_coin_a = arg0.fee_protocol_coin_a + v3 - v0.ref_fee_amount;
        } else {
            assert!(0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::math_u64::add_check(arg0.fee_protocol_coin_b, v3 - v0.ref_fee_amount), 13837321395673890831);
            arg0.fee_protocol_coin_b = arg0.fee_protocol_coin_b + v3 - v0.ref_fee_amount;
        };
        v0
    }

    public fun swap_pay_amount<T0, T1>(arg0: &FlashSwapReceipt<T0, T1>) : u64 {
        arg0.pay_amount
    }

    public fun tick_manager<T0, T1>(arg0: &Pool<T0, T1>) : &0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::tick::TickManager {
        &arg0.tick_manager
    }

    fun update_fee_growth<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: u64, arg3: bool) : u64 {
        let v0 = 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::full_math_u64::mul_div_ceil(arg1, arg2, 1000000000);
        let v1 = arg1 - v0;
        if (v1 == 0 || arg0.liquidity == 0) {
            return v0
        };
        if (arg3) {
            arg0.fee_growth_global_a = 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::math_u256::wrapping_add(arg0.fee_growth_global_a, ((v1 as u256) << 128) / (arg0.liquidity as u256));
        } else {
            arg0.fee_growth_global_b = 0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::math_u256::wrapping_add(arg0.fee_growth_global_b, ((v1 as u256) << 128) / (arg0.liquidity as u256));
        };
        v0
    }

    public fun update_permissions<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: bool, arg2: bool, arg3: bool, arg4: bool, arg5: bool, arg6: bool, arg7: bool, arg8: &0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::config::GlobalConfig, arg9: &0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::versioned::Versioned, arg10: &0x2::tx_context::TxContext) {
        0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::versioned::check_version(arg9);
        0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::config::check_pool_manager(arg8, 0x2::tx_context::sender(arg10));
        0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::permission::update(&mut arg0.permissions, arg1, arg2, arg3, arg4, arg5, arg7, arg6);
        let v0 = UpdatePermissionEvent{
            pool            : 0x2::object::id<Pool<T0, T1>>(arg0),
            old_permissions : 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::permission::feature_permission(&arg0.permissions),
            new_permissions : 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::permission::feature_permission(&arg0.permissions),
        };
        0x2::event::emit<UpdatePermissionEvent>(v0);
    }

    fun update_pool_fee<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: u64, arg3: bool) : u64 {
        update_fee_growth<T0, T1>(arg0, arg1, arg2, arg3)
    }

    public fun update_position_url<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::config::GlobalConfig, arg2: 0x1::string::String, arg3: &0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::versioned::Versioned, arg4: &0x2::tx_context::TxContext) {
        0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::versioned::check_version(arg3);
        0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::config::check_pool_manager(arg1, 0x2::tx_context::sender(arg4));
        arg0.url = arg2;
    }

    fun update_swap_result(arg0: &mut SwapResult, arg1: u128, arg2: u128, arg3: u128, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64) {
        assert!(0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::math_u64::add_check(arg0.amount_in, arg4), 13836758608928964619);
        assert!(0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::math_u64::add_check(arg0.amount_out, arg5), 13837040088200773645);
        assert!(0x36a0efc1ce65f5b140f2c5f7199e3c97eb9a70fb8bcd231c359e9846b10c039f::math_u64::add_check(arg0.fee_amount, arg6), 13837321567472582671);
        arg0.amount_in = arg0.amount_in + arg4;
        arg0.amount_out = arg0.amount_out + arg5;
        arg0.fee_amount = arg0.fee_amount + arg6;
        let v0 = StepResult{
            current_sqrt_price : arg1,
            target_sqrt_price  : arg2,
            current_liquidity  : arg3,
            amount_in          : arg4,
            amount_out         : arg5,
            fee_amount         : arg6,
            base_fee_rate      : arg7,
            total_fee_rate     : arg8,
        };
        0x1::vector::push_back<StepResult>(&mut arg0.steps, v0);
    }

    public fun url<T0, T1>(arg0: &Pool<T0, T1>) : 0x1::string::String {
        arg0.url
    }

    // decompiled from Move bytecode v6
}

