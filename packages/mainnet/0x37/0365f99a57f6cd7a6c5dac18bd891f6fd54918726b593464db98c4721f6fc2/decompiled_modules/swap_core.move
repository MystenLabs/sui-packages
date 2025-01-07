module 0x370365f99a57f6cd7a6c5dac18bd891f6fd54918726b593464db98c4721f6fc2::swap_core {
    struct GlobalConfig has store, key {
        id: 0x2::object::UID,
        counter: u64,
        swap_fee_rate_A: u64,
        swap_fee_rate_B: u64,
        swap_fee_rate_C: u64,
        default_protocol_fee_rate: u64,
        min_liquidity: u64,
        is_create_pool_enabled: bool,
        is_swap_enabled: bool,
        is_deposit_enabled: bool,
        is_withdraw_enabled: bool,
        version: u64,
    }

    struct PoolManager has store, key {
        id: 0x2::object::UID,
        pools: 0x2::table::Table<0x1::string::String, address>,
    }

    struct Pool<phantom T0, phantom T1, phantom T2> has store, key {
        id: 0x2::object::UID,
        pool_id: u64,
        pool_name: 0x1::string::String,
        reserve_a: 0x2::balance::Balance<T0>,
        reserve_b: 0x2::balance::Balance<T1>,
        lp_fee_rate: u64,
        protocol_fee_rate: u64,
        nlp_supply: 0x2::balance::Supply<NLP<T0, T1, T2>>,
        nlp_locked: 0x2::balance::Balance<NLP<T0, T1, T2>>,
        protocol_fee_a: 0x2::balance::Balance<T0>,
        protocol_fee_b: 0x2::balance::Balance<T1>,
        decimal_a: u8,
        decimal_b: u8,
        is_swap_enabled: bool,
        is_deposit_enabled: bool,
        is_withdraw_enabled: bool,
    }

    struct SwapAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct NLP<phantom T0, phantom T1, phantom T2> has drop {
        dummy_field: bool,
    }

    struct TierA has drop {
        dummy_field: bool,
    }

    struct TierB has drop {
        dummy_field: bool,
    }

    struct TierC has drop {
        dummy_field: bool,
    }

    struct PoolCreatedEvent has copy, drop {
        pool_address: address,
        pool_id: u64,
        decimal_a: u8,
        decimal_b: u8,
        tier_type_name: 0x1::ascii::String,
        protocol_fee_rate: u64,
        sender: address,
    }

    struct SwapEvent has copy, drop {
        pool_id: u64,
        amount_in: u64,
        amount_out: u64,
        aTob: bool,
        reserve_a_after: u64,
        reserve_b_after: u64,
        new_liquidity: u64,
        treausry_fee: u64,
        sender: address,
    }

    struct LiquidityAddedEvent has copy, drop {
        pool_id: u64,
        amount_in_a: u64,
        amount_in_b: u64,
        new_liquidity_to_sender: u64,
        sender: address,
    }

    struct LiquidityRemovedEvent has copy, drop {
        pool_id: u64,
        amount_out_a: u64,
        amount_out_b: u64,
        removed_liquidity: u64,
        sender: address,
    }

    struct ProtocolFeeWithdrewEvent has copy, drop {
        pool_id: u64,
        amount_out_a: u64,
        amount_out_b: u64,
        recipient: address,
    }

    struct PoolConfigUpdatedEvent has copy, drop {
        pool_id: u64,
        update_type: u8,
        status: bool,
    }

    struct PoolProtocolFeeRateUpdatedEvent has copy, drop {
        pool_id: u64,
        fee_rate: u64,
    }

    struct ConfigFeeRateUpdatedEvent has copy, drop {
        fee_rate: u64,
    }

    public entry fun swap<T0, T1, T2>(arg0: &GlobalConfig, arg1: &mut Pool<T0, T1, T2>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) {
        if (arg6) {
            assert!(0x2::coin::value<T1>(&arg3) == 0, 0x370365f99a57f6cd7a6c5dac18bd891f6fd54918726b593464db98c4721f6fc2::validation::NotZeroBalance());
            let v0 = 0x370365f99a57f6cd7a6c5dac18bd891f6fd54918726b593464db98c4721f6fc2::utils::split_coin_to_balance<T0>(arg2, arg4, arg7);
            let v1 = base_swap_ab<T0, T1, T2>(arg0, arg1, v0, arg5, arg7);
            let v2 = 0x2::coin::from_balance<T1>(v1, arg7);
            0x2::coin::join<T1>(&mut v2, arg3);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v2, 0x2::tx_context::sender(arg7));
        } else {
            assert!(0x2::coin::value<T0>(&arg2) == 0, 0x370365f99a57f6cd7a6c5dac18bd891f6fd54918726b593464db98c4721f6fc2::validation::NotZeroBalance());
            let v3 = 0x370365f99a57f6cd7a6c5dac18bd891f6fd54918726b593464db98c4721f6fc2::utils::split_coin_to_balance<T1>(arg3, arg4, arg7);
            let v4 = base_swap_ba<T0, T1, T2>(arg0, arg1, v3, arg5, arg7);
            let v5 = 0x2::coin::from_balance<T0>(v4, arg7);
            0x2::coin::join<T0>(&mut v5, arg2);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v5, 0x2::tx_context::sender(arg7));
        };
    }

    public entry fun add_liquidity<T0, T1, T2>(arg0: &GlobalConfig, arg1: &mut Pool<T0, T1, T2>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x370365f99a57f6cd7a6c5dac18bd891f6fd54918726b593464db98c4721f6fc2::utils::split_coin_to_balance<T0>(arg2, arg4, arg6);
        let v1 = 0x370365f99a57f6cd7a6c5dac18bd891f6fd54918726b593464db98c4721f6fc2::utils::split_coin_to_balance<T1>(arg3, arg5, arg6);
        let (v2, v3, v4) = base_add_liquidity<T0, T1, T2>(arg0, arg1, v0, v1, arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<NLP<T0, T1, T2>>>(v2, 0x2::tx_context::sender(arg6));
        0x370365f99a57f6cd7a6c5dac18bd891f6fd54918726b593464db98c4721f6fc2::utils::send_balance<T0>(v3, 0x2::tx_context::sender(arg6), arg6);
        0x370365f99a57f6cd7a6c5dac18bd891f6fd54918726b593464db98c4721f6fc2::utils::send_balance<T1>(v4, 0x2::tx_context::sender(arg6), arg6);
    }

    public fun base_add_liquidity<T0, T1, T2>(arg0: &GlobalConfig, arg1: &mut Pool<T0, T1, T2>, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<NLP<T0, T1, T2>>, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        assert!(arg1.is_deposit_enabled && arg0.is_deposit_enabled, 0x370365f99a57f6cd7a6c5dac18bd891f6fd54918726b593464db98c4721f6fc2::validation::DepositDisabled());
        verify_version(arg0);
        let v0 = 0x2::balance::value<T0>(&arg2);
        let v1 = 0x2::balance::value<T1>(&arg3);
        assert!(v0 > 0 || v1 > 0, 0x370365f99a57f6cd7a6c5dac18bd891f6fd54918726b593464db98c4721f6fc2::validation::ZeroBalance());
        let (v2, v3) = calculate_add_liquidity(v0, v1, 0x2::balance::value<T0>(&arg1.reserve_a), 0x2::balance::value<T1>(&arg1.reserve_b));
        let v4 = mint<T0, T1, T2>(arg0, arg1, 0x2::balance::split<T0>(&mut arg2, v2), 0x2::balance::split<T1>(&mut arg3, v3));
        let v5 = LiquidityAddedEvent{
            pool_id                 : arg1.pool_id,
            amount_in_a             : v2,
            amount_in_b             : v3,
            new_liquidity_to_sender : 0x2::balance::value<NLP<T0, T1, T2>>(&v4),
            sender                  : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<LiquidityAddedEvent>(v5);
        (0x2::coin::from_balance<NLP<T0, T1, T2>>(v4, arg4), arg2, arg3)
    }

    public fun base_remove_liquidity<T0, T1, T2>(arg0: &GlobalConfig, arg1: &mut Pool<T0, T1, T2>, arg2: 0x2::balance::Balance<NLP<T0, T1, T2>>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        verify_version(arg0);
        assert!(arg1.is_withdraw_enabled && arg0.is_withdraw_enabled, 0x370365f99a57f6cd7a6c5dac18bd891f6fd54918726b593464db98c4721f6fc2::validation::WithdrawDisabled());
        let v0 = 0x2::balance::value<NLP<T0, T1, T2>>(&arg2);
        assert!(v0 > 0, 0x370365f99a57f6cd7a6c5dac18bd891f6fd54918726b593464db98c4721f6fc2::validation::ZeroBalance());
        let (v1, v2) = calculate_withdrawable_amount_by_lp<T0, T1, T2>(arg1, v0);
        0x2::balance::decrease_supply<NLP<T0, T1, T2>>(&mut arg1.nlp_supply, arg2);
        let v3 = LiquidityRemovedEvent{
            pool_id           : arg1.pool_id,
            amount_out_a      : v1,
            amount_out_b      : v2,
            removed_liquidity : v0,
            sender            : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<LiquidityRemovedEvent>(v3);
        (0x2::balance::split<T0>(&mut arg1.reserve_a, v1), 0x2::balance::split<T1>(&mut arg1.reserve_b, v2))
    }

    public fun base_swap_ab<T0, T1, T2>(arg0: &GlobalConfig, arg1: &mut Pool<T0, T1, T2>, arg2: 0x2::balance::Balance<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        verify_version(arg0);
        assert!(arg1.is_swap_enabled && arg0.is_swap_enabled, 0x370365f99a57f6cd7a6c5dac18bd891f6fd54918726b593464db98c4721f6fc2::validation::SwapDisabled());
        let v0 = &mut arg2;
        let v1 = take_protocol_fee_ab<T0, T1, T2>(arg1, v0);
        let v2 = 0x2::balance::value<T0>(&arg2);
        let v3 = calculate_amount_out_by_pool<T0, T1, T2>(arg1, v2, true);
        assert!(v3 >= arg3, 0x370365f99a57f6cd7a6c5dac18bd891f6fd54918726b593464db98c4721f6fc2::validation::Slippage());
        0x2::balance::join<T0>(&mut arg1.reserve_a, arg2);
        let v4 = calcualte_liquidity(0x2::balance::value<T0>(&arg1.reserve_a), 0x2::balance::value<T1>(&arg1.reserve_b));
        assert!(v4 >= calcualte_liquidity(0x2::balance::value<T0>(&arg1.reserve_a), 0x2::balance::value<T1>(&arg1.reserve_b)), 0x370365f99a57f6cd7a6c5dac18bd891f6fd54918726b593464db98c4721f6fc2::validation::LiquidityLogicError());
        let v5 = SwapEvent{
            pool_id         : arg1.pool_id,
            amount_in       : v2,
            amount_out      : v3,
            aTob            : true,
            reserve_a_after : 0x2::balance::value<T0>(&arg1.reserve_a),
            reserve_b_after : 0x2::balance::value<T1>(&arg1.reserve_b),
            new_liquidity   : v4,
            treausry_fee    : v1,
            sender          : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<SwapEvent>(v5);
        0x2::balance::split<T1>(&mut arg1.reserve_b, v3)
    }

    public fun base_swap_ba<T0, T1, T2>(arg0: &GlobalConfig, arg1: &mut Pool<T0, T1, T2>, arg2: 0x2::balance::Balance<T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        verify_version(arg0);
        assert!(arg1.is_swap_enabled && arg0.is_swap_enabled, 0x370365f99a57f6cd7a6c5dac18bd891f6fd54918726b593464db98c4721f6fc2::validation::SwapDisabled());
        let v0 = &mut arg2;
        let v1 = take_protocol_fee_ba<T0, T1, T2>(arg1, v0);
        let v2 = 0x2::balance::value<T1>(&arg2);
        let v3 = calculate_amount_out_by_pool<T0, T1, T2>(arg1, v2, true);
        assert!(v3 >= arg3, 0x370365f99a57f6cd7a6c5dac18bd891f6fd54918726b593464db98c4721f6fc2::validation::Slippage());
        0x2::balance::join<T1>(&mut arg1.reserve_b, arg2);
        let v4 = calcualte_liquidity(0x2::balance::value<T0>(&arg1.reserve_a), 0x2::balance::value<T1>(&arg1.reserve_b));
        assert!(v4 >= calcualte_liquidity(0x2::balance::value<T0>(&arg1.reserve_a), 0x2::balance::value<T1>(&arg1.reserve_b)), 0x370365f99a57f6cd7a6c5dac18bd891f6fd54918726b593464db98c4721f6fc2::validation::LiquidityLogicError());
        let v5 = SwapEvent{
            pool_id         : arg1.pool_id,
            amount_in       : v2,
            amount_out      : v3,
            aTob            : false,
            reserve_a_after : 0x2::balance::value<T0>(&arg1.reserve_a),
            reserve_b_after : 0x2::balance::value<T1>(&arg1.reserve_b),
            new_liquidity   : v4,
            treausry_fee    : v1,
            sender          : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<SwapEvent>(v5);
        0x2::balance::split<T0>(&mut arg1.reserve_a, v3)
    }

    public fun calcualte_liquidity(arg0: u64, arg1: u64) : u64 {
        (0x2::math::sqrt_u128((arg0 as u128) * (arg1 as u128)) as u64)
    }

    public fun calculate_add_liquidity(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : (u64, u64) {
        if (arg2 == 0 && arg3 == 0) {
            return (arg0, arg1)
        };
        let v0 = arg0;
        let v1 = 0x370365f99a57f6cd7a6c5dac18bd891f6fd54918726b593464db98c4721f6fc2::utils::safe_mul_div(arg0, arg3, arg2);
        let v2 = v1;
        if (v1 > arg1) {
            v0 = 0x370365f99a57f6cd7a6c5dac18bd891f6fd54918726b593464db98c4721f6fc2::utils::safe_mul_div(arg1, arg2, arg3);
            v2 = arg1;
        };
        (v0, v2)
    }

    public fun calculate_amount_out(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        let v0 = (arg0 as u256) * ((arg4 - arg3) as u256);
        ((v0 * (arg2 as u256) / ((arg1 as u256) * (arg4 as u256) + v0)) as u64)
    }

    public fun calculate_amount_out_by_pool<T0, T1, T2>(arg0: &Pool<T0, T1, T2>, arg1: u64, arg2: bool) : u64 {
        let v0 = if (arg2) {
            0x2::balance::value<T0>(&arg0.reserve_a)
        } else {
            0x2::balance::value<T1>(&arg0.reserve_b)
        };
        let v1 = if (arg2) {
            0x2::balance::value<T1>(&arg0.reserve_b)
        } else {
            0x2::balance::value<T0>(&arg0.reserve_a)
        };
        assert!(arg1 > 0 && v0 > 0 && v1 > 0, 0x370365f99a57f6cd7a6c5dac18bd891f6fd54918726b593464db98c4721f6fc2::validation::ZeroBalance());
        calculate_amount_out(arg1, v0, v1, arg0.lp_fee_rate, 1000)
    }

    public fun calculate_withdrawable_amount_by_lp<T0, T1, T2>(arg0: &Pool<T0, T1, T2>, arg1: u64) : (u64, u64) {
        let v0 = 0x2::balance::supply_value<NLP<T0, T1, T2>>(&arg0.nlp_supply);
        (0x370365f99a57f6cd7a6c5dac18bd891f6fd54918726b593464db98c4721f6fc2::utils::safe_mul_div(0x2::balance::value<T0>(&arg0.reserve_a), arg1, v0), 0x370365f99a57f6cd7a6c5dac18bd891f6fd54918726b593464db98c4721f6fc2::utils::safe_mul_div(0x2::balance::value<T1>(&arg0.reserve_b), arg1, v0))
    }

    public fun create_pool<T0, T1, T2>(arg0: &mut GlobalConfig, arg1: &mut PoolManager, arg2: &0x2::coin::CoinMetadata<T0>, arg3: &0x2::coin::CoinMetadata<T1>, arg4: &mut 0x2::tx_context::TxContext) {
        verify_version(arg0);
        assert!(arg0.is_create_pool_enabled, 0x370365f99a57f6cd7a6c5dac18bd891f6fd54918726b593464db98c4721f6fc2::validation::CreatePoolDisabled());
        let (v0, v1, v2) = get_pool_name<T0, T1, T2>();
        assert!(!0x2::table::contains<0x1::string::String, address>(&arg1.pools, v0), 0x370365f99a57f6cd7a6c5dac18bd891f6fd54918726b593464db98c4721f6fc2::validation::PoolExists());
        assert!(!v2, 0x370365f99a57f6cd7a6c5dac18bd891f6fd54918726b593464db98c4721f6fc2::validation::SameTokenPair());
        assert!(!v1, 0x370365f99a57f6cd7a6c5dac18bd891f6fd54918726b593464db98c4721f6fc2::validation::IncorrectTokenOrder());
        let v3 = 0x2::object::new(arg4);
        let v4 = 0x2::object::uid_to_address(&v3);
        let v5 = NLP<T0, T1, T2>{dummy_field: false};
        let v6 = Pool<T0, T1, T2>{
            id                  : v3,
            pool_id             : arg0.counter,
            pool_name           : v0,
            reserve_a           : 0x2::balance::zero<T0>(),
            reserve_b           : 0x2::balance::zero<T1>(),
            lp_fee_rate         : get_tier_fee<T2>(arg0),
            protocol_fee_rate   : arg0.default_protocol_fee_rate,
            nlp_supply          : 0x2::balance::create_supply<NLP<T0, T1, T2>>(v5),
            nlp_locked          : 0x2::balance::zero<NLP<T0, T1, T2>>(),
            protocol_fee_a      : 0x2::balance::zero<T0>(),
            protocol_fee_b      : 0x2::balance::zero<T1>(),
            decimal_a           : 0x2::coin::get_decimals<T0>(arg2),
            decimal_b           : 0x2::coin::get_decimals<T1>(arg3),
            is_swap_enabled     : true,
            is_deposit_enabled  : true,
            is_withdraw_enabled : true,
        };
        0x2::table::add<0x1::string::String, address>(&mut arg1.pools, v0, v4);
        let v7 = PoolCreatedEvent{
            pool_address      : v4,
            pool_id           : arg0.counter,
            decimal_a         : v6.decimal_a,
            decimal_b         : v6.decimal_b,
            tier_type_name    : 0x1::type_name::into_string(0x1::type_name::get<T2>()),
            protocol_fee_rate : arg0.default_protocol_fee_rate,
            sender            : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<PoolCreatedEvent>(v7);
        0x2::transfer::share_object<Pool<T0, T1, T2>>(v6);
        arg0.counter = arg0.counter + 1;
    }

    public fun get_pool_balance<T0, T1, T2>(arg0: &Pool<T0, T1, T2>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.reserve_a), 0x2::balance::value<T1>(&arg0.reserve_b))
    }

    public fun get_pool_info<T0, T1, T2>(arg0: &Pool<T0, T1, T2>) : (u64, 0x1::string::String, u64, u64, u64, u64, u64, u8, u8) {
        (arg0.pool_id, arg0.pool_name, 0x2::balance::value<T0>(&arg0.reserve_a), 0x2::balance::value<T1>(&arg0.reserve_b), arg0.lp_fee_rate, arg0.protocol_fee_rate, 0x2::balance::supply_value<NLP<T0, T1, T2>>(&arg0.nlp_supply), arg0.decimal_a, arg0.decimal_b)
    }

    public fun get_pool_name<T0, T1, T2>() : (0x1::string::String, bool, bool) {
        let v0 = false;
        let v1 = false;
        let v2 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v3 = 0x1::ascii::as_bytes(&v2);
        let v4 = v3;
        let v5 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        let v6 = 0x1::ascii::as_bytes(&v5);
        let v7 = v6;
        let v8 = 0x370365f99a57f6cd7a6c5dac18bd891f6fd54918726b593464db98c4721f6fc2::utils::cmp_bytes(v3, v6);
        if (v8 == 1) {
            v1 = true;
        };
        if (v8 == 2) {
            v4 = v6;
            v7 = v3;
            v0 = true;
        };
        let v9 = 0x1::string::from_ascii(0x1::ascii::string(*v4));
        let v10 = 0x1::string::from_ascii(0x1::ascii::string(*v7));
        let v11 = 0x1::string::utf8(b" - ");
        assert!(0x1::string::index_of(&v9, &v11) == 0x1::string::length(&v9), 0x370365f99a57f6cd7a6c5dac18bd891f6fd54918726b593464db98c4721f6fc2::validation::InvalidType());
        assert!(0x1::string::index_of(&v10, &v11) == 0x1::string::length(&v10), 0x370365f99a57f6cd7a6c5dac18bd891f6fd54918726b593464db98c4721f6fc2::validation::InvalidType());
        0x1::string::append_utf8(&mut v9, b" - ");
        0x1::string::append(&mut v9, v10);
        0x1::string::append_utf8(&mut v9, b" - ");
        0x1::string::append(&mut v9, 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T2>())));
        (v9, v0, v1)
    }

    public fun get_pool_status<T0, T1, T2>(arg0: &Pool<T0, T1, T2>) : (bool, bool, bool) {
        (arg0.is_swap_enabled, arg0.is_deposit_enabled, arg0.is_withdraw_enabled)
    }

    public fun get_protocol_fee<T0, T1, T2>(arg0: &Pool<T0, T1, T2>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.protocol_fee_a), 0x2::balance::value<T1>(&arg0.protocol_fee_b))
    }

    public fun get_tier_fee<T0>(arg0: &GlobalConfig) : u64 {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        if (v0 == 0x1::type_name::into_string(0x1::type_name::get<TierA>())) {
            return arg0.swap_fee_rate_A
        };
        if (v0 == 0x1::type_name::into_string(0x1::type_name::get<TierB>())) {
            return arg0.swap_fee_rate_B
        };
        assert!(v0 == 0x1::type_name::into_string(0x1::type_name::get<TierC>()), 0);
        arg0.swap_fee_rate_C
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SwapAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<SwapAdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = PoolManager{
            id    : 0x2::object::new(arg0),
            pools : 0x2::table::new<0x1::string::String, address>(arg0),
        };
        0x2::transfer::share_object<PoolManager>(v1);
        init_config(1, 2, 3, 100, arg0);
    }

    public entry fun init_config(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 <= 1000, 0x370365f99a57f6cd7a6c5dac18bd891f6fd54918726b593464db98c4721f6fc2::validation::MaxValueExceeded());
        assert!(arg1 <= 1000, 0x370365f99a57f6cd7a6c5dac18bd891f6fd54918726b593464db98c4721f6fc2::validation::MaxValueExceeded());
        assert!(arg2 <= 1000, 0x370365f99a57f6cd7a6c5dac18bd891f6fd54918726b593464db98c4721f6fc2::validation::MaxValueExceeded());
        assert!(arg3 <= 1000, 0x370365f99a57f6cd7a6c5dac18bd891f6fd54918726b593464db98c4721f6fc2::validation::MaxValueExceeded());
        let v0 = GlobalConfig{
            id                        : 0x2::object::new(arg4),
            counter                   : 0,
            swap_fee_rate_A           : arg0,
            swap_fee_rate_B           : arg1,
            swap_fee_rate_C           : arg2,
            default_protocol_fee_rate : arg3,
            min_liquidity             : 1000,
            is_create_pool_enabled    : true,
            is_swap_enabled           : true,
            is_deposit_enabled        : true,
            is_withdraw_enabled       : true,
            version                   : 0,
        };
        0x2::transfer::share_object<GlobalConfig>(v0);
    }

    fun mint<T0, T1, T2>(arg0: &GlobalConfig, arg1: &mut Pool<T0, T1, T2>, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>) : 0x2::balance::Balance<NLP<T0, T1, T2>> {
        0x2::balance::join<T0>(&mut arg1.reserve_a, arg2);
        0x2::balance::join<T1>(&mut arg1.reserve_b, arg3);
        let v0 = 0x2::balance::increase_supply<NLP<T0, T1, T2>>(&mut arg1.nlp_supply, calcualte_liquidity(0x2::balance::value<T0>(&arg2), 0x2::balance::value<T1>(&arg3)));
        if (0x2::balance::value<NLP<T0, T1, T2>>(&arg1.nlp_locked) == 0) {
            assert!(0x2::balance::value<NLP<T0, T1, T2>>(&v0) > arg0.min_liquidity, 0x370365f99a57f6cd7a6c5dac18bd891f6fd54918726b593464db98c4721f6fc2::validation::LiquidityNotEnough());
            0x2::balance::join<NLP<T0, T1, T2>>(&mut arg1.nlp_locked, 0x2::balance::split<NLP<T0, T1, T2>>(&mut v0, arg0.min_liquidity));
        };
        v0
    }

    public entry fun remove_liquidity<T0, T1, T2>(arg0: &GlobalConfig, arg1: &mut Pool<T0, T1, T2>, arg2: 0x2::coin::Coin<NLP<T0, T1, T2>>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x370365f99a57f6cd7a6c5dac18bd891f6fd54918726b593464db98c4721f6fc2::utils::split_coin_to_balance<NLP<T0, T1, T2>>(arg2, arg3, arg4);
        let (v1, v2) = base_remove_liquidity<T0, T1, T2>(arg0, arg1, v0, arg4);
        0x370365f99a57f6cd7a6c5dac18bd891f6fd54918726b593464db98c4721f6fc2::utils::send_balance<T0>(v1, 0x2::tx_context::sender(arg4), arg4);
        0x370365f99a57f6cd7a6c5dac18bd891f6fd54918726b593464db98c4721f6fc2::utils::send_balance<T1>(v2, 0x2::tx_context::sender(arg4), arg4);
    }

    public entry fun set_config_protocol_fee_rate(arg0: &SwapAdminCap, arg1: &mut GlobalConfig, arg2: u64) {
        assert!(arg2 <= 1000, 0x370365f99a57f6cd7a6c5dac18bd891f6fd54918726b593464db98c4721f6fc2::validation::MaxValueExceeded());
        arg1.default_protocol_fee_rate = arg2;
        let v0 = ConfigFeeRateUpdatedEvent{fee_rate: arg2};
        0x2::event::emit<ConfigFeeRateUpdatedEvent>(v0);
    }

    public entry fun set_is_deposit_enabled_for_pool<T0, T1, T2>(arg0: &SwapAdminCap, arg1: &mut Pool<T0, T1, T2>, arg2: bool) {
        arg1.is_deposit_enabled = arg2;
        let v0 = PoolConfigUpdatedEvent{
            pool_id     : arg1.pool_id,
            update_type : 1,
            status      : arg2,
        };
        0x2::event::emit<PoolConfigUpdatedEvent>(v0);
    }

    public entry fun set_is_swap_enabled_for_pool<T0, T1, T2>(arg0: &SwapAdminCap, arg1: &mut Pool<T0, T1, T2>, arg2: bool) {
        arg1.is_swap_enabled = arg2;
        let v0 = PoolConfigUpdatedEvent{
            pool_id     : arg1.pool_id,
            update_type : 0,
            status      : arg2,
        };
        0x2::event::emit<PoolConfigUpdatedEvent>(v0);
    }

    public entry fun set_is_withdraw_enabled_for_pool<T0, T1, T2>(arg0: &SwapAdminCap, arg1: &mut Pool<T0, T1, T2>, arg2: bool) {
        arg1.is_withdraw_enabled = arg2;
        let v0 = PoolConfigUpdatedEvent{
            pool_id     : arg1.pool_id,
            update_type : 2,
            status      : arg2,
        };
        0x2::event::emit<PoolConfigUpdatedEvent>(v0);
    }

    public entry fun set_pool_protocol_fee_rate<T0, T1, T2>(arg0: &SwapAdminCap, arg1: &mut Pool<T0, T1, T2>, arg2: u64) {
        assert!(arg2 <= 1000, 0x370365f99a57f6cd7a6c5dac18bd891f6fd54918726b593464db98c4721f6fc2::validation::MaxValueExceeded());
        arg1.protocol_fee_rate = arg2;
        let v0 = PoolProtocolFeeRateUpdatedEvent{
            pool_id  : arg1.pool_id,
            fee_rate : arg2,
        };
        0x2::event::emit<PoolProtocolFeeRateUpdatedEvent>(v0);
    }

    fun take_protocol_fee_ab<T0, T1, T2>(arg0: &mut Pool<T0, T1, T2>, arg1: &mut 0x2::balance::Balance<T0>) : u64 {
        let v0 = 0x370365f99a57f6cd7a6c5dac18bd891f6fd54918726b593464db98c4721f6fc2::utils::safe_mul_div(0x370365f99a57f6cd7a6c5dac18bd891f6fd54918726b593464db98c4721f6fc2::utils::safe_mul_div(0x2::balance::value<T0>(arg1), arg0.lp_fee_rate, 1000), arg0.protocol_fee_rate, 1000);
        0x2::balance::join<T0>(&mut arg0.protocol_fee_a, 0x2::balance::split<T0>(arg1, v0));
        v0
    }

    fun take_protocol_fee_ba<T0, T1, T2>(arg0: &mut Pool<T0, T1, T2>, arg1: &mut 0x2::balance::Balance<T1>) : u64 {
        let v0 = 0x370365f99a57f6cd7a6c5dac18bd891f6fd54918726b593464db98c4721f6fc2::utils::safe_mul_div(0x370365f99a57f6cd7a6c5dac18bd891f6fd54918726b593464db98c4721f6fc2::utils::safe_mul_div(0x2::balance::value<T1>(arg1), arg0.lp_fee_rate, 1000), arg0.protocol_fee_rate, 1000);
        0x2::balance::join<T1>(&mut arg0.protocol_fee_b, 0x2::balance::split<T1>(arg1, v0));
        v0
    }

    public fun verify_version(arg0: &GlobalConfig) {
        0x370365f99a57f6cd7a6c5dac18bd891f6fd54918726b593464db98c4721f6fc2::validation::pre_check_version(arg0.version);
    }

    public fun version_migrate(arg0: &SwapAdminCap, arg1: &mut GlobalConfig) {
        assert!(arg1.version < 0x370365f99a57f6cd7a6c5dac18bd891f6fd54918726b593464db98c4721f6fc2::validation::version(), 0x370365f99a57f6cd7a6c5dac18bd891f6fd54918726b593464db98c4721f6fc2::validation::IncorrectVersion());
        arg1.version = 0x370365f99a57f6cd7a6c5dac18bd891f6fd54918726b593464db98c4721f6fc2::validation::version();
    }

    public entry fun withdraw_protocol_fee<T0, T1, T2>(arg0: &SwapAdminCap, arg1: &mut Pool<T0, T1, T2>, arg2: u64, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        0x370365f99a57f6cd7a6c5dac18bd891f6fd54918726b593464db98c4721f6fc2::utils::send_balance<T0>(0x2::balance::split<T0>(&mut arg1.protocol_fee_a, arg3), arg4, arg5);
        0x370365f99a57f6cd7a6c5dac18bd891f6fd54918726b593464db98c4721f6fc2::utils::send_balance<T1>(0x2::balance::split<T1>(&mut arg1.protocol_fee_b, arg2), arg4, arg5);
        let v0 = ProtocolFeeWithdrewEvent{
            pool_id      : arg1.pool_id,
            amount_out_a : arg3,
            amount_out_b : arg2,
            recipient    : arg4,
        };
        0x2::event::emit<ProtocolFeeWithdrewEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

