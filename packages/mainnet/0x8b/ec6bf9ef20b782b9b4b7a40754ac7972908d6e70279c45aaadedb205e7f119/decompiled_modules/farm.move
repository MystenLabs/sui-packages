module 0x8bec6bf9ef20b782b9b4b7a40754ac7972908d6e70279c45aaadedb205e7f119::farm {
    struct Farm<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        position: 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position,
        tick_lower: u32,
        tick_upper: u32,
        total_share: u128,
        locked_share: u128,
        liquidity_cap: u128,
        deposit_paused: bool,
        withdraw_paused: bool,
        compound_paused: bool,
        compounding: 0x2::bag::Bag,
        protocol: 0x2::bag::Bag,
    }

    struct SwapTicket {
        farm_id: 0x2::object::ID,
        coin_in: 0x1::type_name::TypeName,
        coin_out: 0x1::type_name::TypeName,
        amount_in: u64,
        min_out: u64,
    }

    struct CreateFarmEvent has copy, drop {
        farm_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        magma_position_id: 0x2::object::ID,
        tick_lower: u32,
        tick_upper: u32,
        liquidity: u128,
        locked_share: u128,
        liquidity_cap: u128,
    }

    struct DepositEvent has copy, drop {
        farm_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        sender: address,
        amount_a: u64,
        amount_b: u64,
        liquidity: u128,
        share: u128,
        total_share: u128,
        total_liquidity: u128,
    }

    struct WithdrawEvent has copy, drop {
        farm_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        sender: address,
        amount_a: u64,
        amount_b: u64,
        liquidity: u128,
        share: u128,
        total_share: u128,
        total_liquidity: u128,
    }

    struct HarvestEvent has copy, drop {
        farm_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        protocol_amount: u64,
    }

    struct CompoundEvent has copy, drop {
        farm_id: 0x2::object::ID,
        amount_a: u64,
        amount_b: u64,
        liquidity_added: u128,
        total_liquidity: u128,
        idle_a: u64,
        idle_b: u64,
    }

    struct SwapEvent has copy, drop {
        farm_id: 0x2::object::ID,
        coin_in: 0x1::type_name::TypeName,
        coin_out: 0x1::type_name::TypeName,
        amount_in: u64,
        amount_out: u64,
        min_out: u64,
    }

    struct DonateEvent has copy, drop {
        farm_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        sender: address,
    }

    struct ClaimProtocolEvent has copy, drop {
        farm_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        treasury: address,
    }

    struct PauseEvent has copy, drop {
        farm_id: 0x2::object::ID,
        deposit: bool,
        withdraw: bool,
        compound: bool,
        by_operator: bool,
    }

    struct SetCapEvent has copy, drop {
        farm_id: 0x2::object::ID,
        old_cap: u128,
        new_cap: u128,
    }

    public fun collect_reward<T0, T1, T2>(arg0: &0x8bec6bf9ef20b782b9b4b7a40754ac7972908d6e70279c45aaadedb205e7f119::config::GlobalConfig, arg1: &mut Farm<T0, T1>, arg2: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg3: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg4: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::rewarder::RewarderGlobalVault, arg5: &0x2::clock::Clock) {
        0x8bec6bf9ef20b782b9b4b7a40754ac7972908d6e70279c45aaadedb205e7f119::config::assert_version(arg0);
        assert!(!arg1.compound_paused, 305);
        assert_pool<T0, T1>(arg1, arg3);
        let v0 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::collect_reward<T0, T1, T2>(arg2, arg3, &arg1.position, arg4, true, arg5);
        distribute<T0, T1, T2>(arg1, arg0, v0);
    }

    public fun open_position<T0, T1>(arg0: &0x8bec6bf9ef20b782b9b4b7a40754ac7972908d6e70279c45aaadedb205e7f119::config::GlobalConfig, arg1: &Farm<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x8bec6bf9ef20b782b9b4b7a40754ac7972908d6e70279c45aaadedb205e7f119::position::JewelMagmaPosition {
        0x8bec6bf9ef20b782b9b4b7a40754ac7972908d6e70279c45aaadedb205e7f119::config::assert_version(arg0);
        0x8bec6bf9ef20b782b9b4b7a40754ac7972908d6e70279c45aaadedb205e7f119::position::new(0x2::object::id<Farm<T0, T1>>(arg1), arg2)
    }

    public fun migrate(arg0: &0x8bec6bf9ef20b782b9b4b7a40754ac7972908d6e70279c45aaadedb205e7f119::permission::AdminCap, arg1: &mut 0x8bec6bf9ef20b782b9b4b7a40754ac7972908d6e70279c45aaadedb205e7f119::config::GlobalConfig) {
        0x8bec6bf9ef20b782b9b4b7a40754ac7972908d6e70279c45aaadedb205e7f119::config::migrate(arg1);
    }

    public fun set_max_swap_slippage_bps(arg0: &0x8bec6bf9ef20b782b9b4b7a40754ac7972908d6e70279c45aaadedb205e7f119::permission::AdminCap, arg1: &mut 0x8bec6bf9ef20b782b9b4b7a40754ac7972908d6e70279c45aaadedb205e7f119::config::GlobalConfig, arg2: u64) {
        0x8bec6bf9ef20b782b9b4b7a40754ac7972908d6e70279c45aaadedb205e7f119::config::assert_version(arg1);
        0x8bec6bf9ef20b782b9b4b7a40754ac7972908d6e70279c45aaadedb205e7f119::config::set_max_swap_slippage_bps(arg1, arg2);
    }

    public fun set_protocol_fee_bps(arg0: &0x8bec6bf9ef20b782b9b4b7a40754ac7972908d6e70279c45aaadedb205e7f119::permission::AdminCap, arg1: &mut 0x8bec6bf9ef20b782b9b4b7a40754ac7972908d6e70279c45aaadedb205e7f119::config::GlobalConfig, arg2: u64) {
        0x8bec6bf9ef20b782b9b4b7a40754ac7972908d6e70279c45aaadedb205e7f119::config::assert_version(arg1);
        0x8bec6bf9ef20b782b9b4b7a40754ac7972908d6e70279c45aaadedb205e7f119::config::set_protocol_fee_bps(arg1, arg2);
    }

    public fun set_treasury(arg0: &0x8bec6bf9ef20b782b9b4b7a40754ac7972908d6e70279c45aaadedb205e7f119::permission::AdminCap, arg1: &mut 0x8bec6bf9ef20b782b9b4b7a40754ac7972908d6e70279c45aaadedb205e7f119::config::GlobalConfig, arg2: address) {
        0x8bec6bf9ef20b782b9b4b7a40754ac7972908d6e70279c45aaadedb205e7f119::config::assert_version(arg1);
        0x8bec6bf9ef20b782b9b4b7a40754ac7972908d6e70279c45aaadedb205e7f119::config::set_treasury(arg1, arg2);
    }

    fun add_liquidity_internal<T0, T1>(arg0: &mut Farm<T0, T1>, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg2: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg3: &mut 0x2::balance::Balance<T0>, arg4: &mut 0x2::balance::Balance<T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : u128 {
        let v0 = 0x2::balance::value<T0>(arg3);
        let v1 = 0x2::balance::value<T1>(arg4);
        let v2 = 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::from_u32(arg0.tick_lower);
        let v3 = 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::from_u32(arg0.tick_upper);
        let v4 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_tick_index<T0, T1>(arg2);
        let v5 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_sqrt_price<T0, T1>(arg2);
        let v6 = 0;
        let v7 = true;
        if (v0 > 0) {
            let (v8, _, v10) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::get_liquidity_from_amount(v2, v3, v4, v5, v0, true);
            if (v8 > 0 && v10 <= v1) {
                v6 = v0;
            };
        };
        if (v6 == 0 && v1 > 0) {
            let (v11, v12, _) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::get_liquidity_from_amount(v2, v3, v4, v5, v1, false);
            if (v11 > 0 && v12 <= v0) {
                v6 = v1;
                v7 = false;
            };
        };
        if (v6 == 0) {
            return 0
        };
        let v14 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::add_liquidity_fix_coin<T0, T1>(arg1, arg2, &mut arg0.position, v6, v7, arg5, arg6);
        let (v15, v16) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::add_liquidity_pay_amount<T0, T1>(&v14);
        0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::repay_add_liquidity<T0, T1>(arg1, arg2, 0x2::balance::split<T0>(arg3, v15), 0x2::balance::split<T1>(arg4, v16), v14);
        0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::liquidity(&arg0.position) - 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::liquidity(&arg0.position)
    }

    fun apply_slippage(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * ((0x8bec6bf9ef20b782b9b4b7a40754ac7972908d6e70279c45aaadedb205e7f119::config::bps() - arg1) as u128) / (0x8bec6bf9ef20b782b9b4b7a40754ac7972908d6e70279c45aaadedb205e7f119::config::bps() as u128)) as u64)
    }

    fun assert_pool<T0, T1>(arg0: &Farm<T0, T1>, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>) {
        assert!(0x2::object::id<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>>(arg1) == arg0.pool_id, 301);
    }

    fun bag_value<T0>(arg0: &0x2::bag::Bag) : u64 {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(arg0, v0)) {
            0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(arg0, v0))
        } else {
            0
        }
    }

    public fun begin_swap<T0, T1, T2, T3>(arg0: &0x8bec6bf9ef20b782b9b4b7a40754ac7972908d6e70279c45aaadedb205e7f119::permission::OperatorCap, arg1: &0x8bec6bf9ef20b782b9b4b7a40754ac7972908d6e70279c45aaadedb205e7f119::config::GlobalConfig, arg2: &mut Farm<T0, T1>, arg3: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T2>, SwapTicket) {
        0x8bec6bf9ef20b782b9b4b7a40754ac7972908d6e70279c45aaadedb205e7f119::config::assert_version(arg1);
        assert!(!arg2.compound_paused, 305);
        assert!(0x2::object::id<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>>(arg3) == arg2.pool_id, 301);
        let v0 = 0x1::type_name::with_defining_ids<T2>();
        let v1 = 0x1::type_name::with_defining_ids<T3>();
        assert!(is_pair_coin<T0, T1, T3>() && v0 != v1, 312);
        assert!(arg4 > 0, 313);
        assert!(bag_value<T2>(&arg2.compounding) >= arg4, 314);
        let v2 = if (v0 == 0x1::type_name::with_defining_ids<T0>()) {
            apply_slippage(quote_a_to_b(arg4, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_sqrt_price<T0, T1>(arg3)), 0x8bec6bf9ef20b782b9b4b7a40754ac7972908d6e70279c45aaadedb205e7f119::config::max_swap_slippage_bps(arg1))
        } else if (v0 == 0x1::type_name::with_defining_ids<T1>()) {
            apply_slippage(quote_b_to_a(arg4, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_sqrt_price<T0, T1>(arg3)), 0x8bec6bf9ef20b782b9b4b7a40754ac7972908d6e70279c45aaadedb205e7f119::config::max_swap_slippage_bps(arg1))
        } else {
            0
        };
        let v3 = if (arg5 > v2) {
            arg5
        } else {
            v2
        };
        assert!(v3 > 0, 313);
        let v4 = SwapTicket{
            farm_id   : 0x2::object::id<Farm<T0, T1>>(arg2),
            coin_in   : v0,
            coin_out  : v1,
            amount_in : arg4,
            min_out   : v3,
        };
        (0x2::coin::from_balance<T2>(0x2::balance::split<T2>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg2.compounding, v0), arg4), arg6), v4)
    }

    public fun claim_protocol<T0, T1, T2>(arg0: &0x8bec6bf9ef20b782b9b4b7a40754ac7972908d6e70279c45aaadedb205e7f119::config::GlobalConfig, arg1: &mut Farm<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        0x8bec6bf9ef20b782b9b4b7a40754ac7972908d6e70279c45aaadedb205e7f119::config::assert_version(arg0);
        let v0 = 0x1::type_name::with_defining_ids<T2>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg1.protocol, v0)) {
            return
        };
        let v1 = 0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg1.protocol, v0);
        let v2 = 0x8bec6bf9ef20b782b9b4b7a40754ac7972908d6e70279c45aaadedb205e7f119::config::treasury(arg0);
        let v3 = ClaimProtocolEvent{
            farm_id   : 0x2::object::id<Farm<T0, T1>>(arg1),
            coin_type : v0,
            amount    : 0x2::balance::value<T2>(&v1),
            treasury  : v2,
        };
        0x2::event::emit<ClaimProtocolEvent>(v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v1, arg2), v2);
    }

    public fun close_position(arg0: &0x8bec6bf9ef20b782b9b4b7a40754ac7972908d6e70279c45aaadedb205e7f119::config::GlobalConfig, arg1: 0x8bec6bf9ef20b782b9b4b7a40754ac7972908d6e70279c45aaadedb205e7f119::position::JewelMagmaPosition) {
        0x8bec6bf9ef20b782b9b4b7a40754ac7972908d6e70279c45aaadedb205e7f119::config::assert_version(arg0);
        0x8bec6bf9ef20b782b9b4b7a40754ac7972908d6e70279c45aaadedb205e7f119::position::destroy_empty(arg1);
    }

    public fun collect_fees<T0, T1>(arg0: &0x8bec6bf9ef20b782b9b4b7a40754ac7972908d6e70279c45aaadedb205e7f119::config::GlobalConfig, arg1: &mut Farm<T0, T1>, arg2: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg3: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>) {
        0x8bec6bf9ef20b782b9b4b7a40754ac7972908d6e70279c45aaadedb205e7f119::config::assert_version(arg0);
        assert!(!arg1.compound_paused, 305);
        assert_pool<T0, T1>(arg1, arg3);
        let (v0, v1) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::collect_fee<T0, T1>(arg2, arg3, &arg1.position, true);
        distribute<T0, T1, T0>(arg1, arg0, v0);
        distribute<T0, T1, T1>(arg1, arg0, v1);
    }

    public fun compound<T0, T1>(arg0: &0x8bec6bf9ef20b782b9b4b7a40754ac7972908d6e70279c45aaadedb205e7f119::permission::OperatorCap, arg1: &0x8bec6bf9ef20b782b9b4b7a40754ac7972908d6e70279c45aaadedb205e7f119::config::GlobalConfig, arg2: &mut Farm<T0, T1>, arg3: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg4: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg5: u128, arg6: u128, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : u128 {
        0x8bec6bf9ef20b782b9b4b7a40754ac7972908d6e70279c45aaadedb205e7f119::config::assert_version(arg1);
        assert!(!arg2.compound_paused, 305);
        assert_pool<T0, T1>(arg2, arg4);
        let v0 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_sqrt_price<T0, T1>(arg4);
        assert!(v0 >= arg5 && v0 <= arg6, 311);
        let v1 = &mut arg2.compounding;
        let v2 = take_all<T0>(v1);
        let v3 = &mut arg2.compounding;
        let v4 = take_all<T1>(v3);
        let v5 = &mut v2;
        let v6 = &mut v4;
        let v7 = add_liquidity_internal<T0, T1>(arg2, arg3, arg4, v5, v6, arg7, arg8);
        let v8 = 0x2::balance::value<T0>(&v2);
        let v9 = 0x2::balance::value<T1>(&v4);
        let v10 = &mut arg2.compounding;
        join_bag<T0>(v10, v2);
        let v11 = &mut arg2.compounding;
        join_bag<T1>(v11, v4);
        let v12 = CompoundEvent{
            farm_id         : 0x2::object::id<Farm<T0, T1>>(arg2),
            amount_a        : 0x2::balance::value<T0>(&v2) - v8,
            amount_b        : 0x2::balance::value<T1>(&v4) - v9,
            liquidity_added : v7,
            total_liquidity : 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::liquidity(&arg2.position),
            idle_a          : v8,
            idle_b          : v9,
        };
        0x2::event::emit<CompoundEvent>(v12);
        v7
    }

    public fun compounding_balance<T0, T1, T2>(arg0: &Farm<T0, T1>) : u64 {
        bag_value<T2>(&arg0.compounding)
    }

    public fun create_farm<T0, T1>(arg0: &0x8bec6bf9ef20b782b9b4b7a40754ac7972908d6e70279c45aaadedb205e7f119::permission::AdminCap, arg1: &0x8bec6bf9ef20b782b9b4b7a40754ac7972908d6e70279c45aaadedb205e7f119::config::GlobalConfig, arg2: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg3: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: u128, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x8bec6bf9ef20b782b9b4b7a40754ac7972908d6e70279c45aaadedb205e7f119::position::JewelMagmaPosition, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x8bec6bf9ef20b782b9b4b7a40754ac7972908d6e70279c45aaadedb205e7f119::config::assert_version(arg1);
        let (v0, v1) = full_range_ticks(0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::tick_spacing<T0, T1>(arg3));
        let v2 = Farm<T0, T1>{
            id              : 0x2::object::new(arg8),
            pool_id         : 0x2::object::id<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>>(arg3),
            position        : 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::open_position<T0, T1>(arg2, arg3, v0, v1, arg8),
            tick_lower      : v0,
            tick_upper      : v1,
            total_share     : 0,
            locked_share    : 10000,
            liquidity_cap   : arg6,
            deposit_paused  : false,
            withdraw_paused : false,
            compound_paused : false,
            compounding     : 0x2::bag::new(arg8),
            protocol        : 0x2::bag::new(arg8),
        };
        let v3 = 0x2::coin::into_balance<T0>(arg4);
        let v4 = 0x2::coin::into_balance<T1>(arg5);
        let v5 = &mut v2;
        let v6 = &mut v3;
        let v7 = &mut v4;
        let v8 = add_liquidity_internal<T0, T1>(v5, arg2, arg3, v6, v7, arg7, arg8);
        assert!(v8 >= 1000000, 310);
        assert!(v8 <= arg6, 309);
        v2.total_share = v8;
        let v9 = 0x2::object::id<Farm<T0, T1>>(&v2);
        let v10 = 0x8bec6bf9ef20b782b9b4b7a40754ac7972908d6e70279c45aaadedb205e7f119::position::new(v9, arg8);
        0x8bec6bf9ef20b782b9b4b7a40754ac7972908d6e70279c45aaadedb205e7f119::position::increase(&mut v10, v8 - 10000);
        let v11 = CreateFarmEvent{
            farm_id           : v9,
            pool_id           : v2.pool_id,
            magma_position_id : 0x2::object::id<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>(&v2.position),
            tick_lower        : v0,
            tick_upper        : v1,
            liquidity         : v8,
            locked_share      : 10000,
            liquidity_cap     : arg6,
        };
        0x2::event::emit<CreateFarmEvent>(v11);
        0x2::transfer::share_object<Farm<T0, T1>>(v2);
        (v10, 0x2::coin::from_balance<T0>(v3, arg8), 0x2::coin::from_balance<T1>(v4, arg8))
    }

    public fun deposit<T0, T1>(arg0: &0x8bec6bf9ef20b782b9b4b7a40754ac7972908d6e70279c45aaadedb205e7f119::config::GlobalConfig, arg1: &mut Farm<T0, T1>, arg2: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg3: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg4: &mut 0x8bec6bf9ef20b782b9b4b7a40754ac7972908d6e70279c45aaadedb205e7f119::position::JewelMagmaPosition, arg5: 0x2::coin::Coin<T0>, arg6: 0x2::coin::Coin<T1>, arg7: u128, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x8bec6bf9ef20b782b9b4b7a40754ac7972908d6e70279c45aaadedb205e7f119::config::assert_version(arg0);
        assert!(!arg1.deposit_paused, 303);
        assert_pool<T0, T1>(arg1, arg3);
        assert!(0x8bec6bf9ef20b782b9b4b7a40754ac7972908d6e70279c45aaadedb205e7f119::position::farm_id(arg4) == 0x2::object::id<Farm<T0, T1>>(arg1), 302);
        let v0 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::liquidity(&arg1.position);
        let v1 = arg1.total_share;
        let v2 = 0x2::coin::into_balance<T0>(arg5);
        let v3 = 0x2::coin::into_balance<T1>(arg6);
        let v4 = &mut v2;
        let v5 = &mut v3;
        let v6 = add_liquidity_internal<T0, T1>(arg1, arg2, arg3, v4, v5, arg8, arg9);
        assert!(v6 > 0, 306);
        let v7 = v0 + v6;
        assert!(v7 <= arg1.liquidity_cap, 309);
        let v8 = mul_div_floor(v6, v1, v0);
        assert!(v8 > 0, 307);
        assert!(v8 >= arg7, 308);
        0x8bec6bf9ef20b782b9b4b7a40754ac7972908d6e70279c45aaadedb205e7f119::position::increase(arg4, v8);
        arg1.total_share = v1 + v8;
        let v9 = DepositEvent{
            farm_id         : 0x2::object::id<Farm<T0, T1>>(arg1),
            position_id     : 0x2::object::id<0x8bec6bf9ef20b782b9b4b7a40754ac7972908d6e70279c45aaadedb205e7f119::position::JewelMagmaPosition>(arg4),
            sender          : 0x2::tx_context::sender(arg9),
            amount_a        : 0x2::coin::value<T0>(&arg5) - 0x2::balance::value<T0>(&v2),
            amount_b        : 0x2::coin::value<T1>(&arg6) - 0x2::balance::value<T1>(&v3),
            liquidity       : v6,
            share           : v8,
            total_share     : arg1.total_share,
            total_liquidity : v7,
        };
        0x2::event::emit<DepositEvent>(v9);
        (0x2::coin::from_balance<T0>(v2, arg9), 0x2::coin::from_balance<T1>(v3, arg9))
    }

    fun distribute<T0, T1, T2>(arg0: &mut Farm<T0, T1>, arg1: &0x8bec6bf9ef20b782b9b4b7a40754ac7972908d6e70279c45aaadedb205e7f119::config::GlobalConfig, arg2: 0x2::balance::Balance<T2>) {
        let v0 = 0x2::balance::value<T2>(&arg2);
        if (v0 == 0) {
            0x2::balance::destroy_zero<T2>(arg2);
            return
        };
        let v1 = (((v0 as u128) * (0x8bec6bf9ef20b782b9b4b7a40754ac7972908d6e70279c45aaadedb205e7f119::config::protocol_fee_bps(arg1) as u128) / (0x8bec6bf9ef20b782b9b4b7a40754ac7972908d6e70279c45aaadedb205e7f119::config::bps() as u128)) as u64);
        if (v1 > 0) {
            let v2 = &mut arg0.protocol;
            join_bag<T2>(v2, 0x2::balance::split<T2>(&mut arg2, v1));
        };
        let v3 = &mut arg0.compounding;
        join_bag<T2>(v3, arg2);
        let v4 = HarvestEvent{
            farm_id         : 0x2::object::id<Farm<T0, T1>>(arg0),
            coin_type       : 0x1::type_name::with_defining_ids<T2>(),
            amount          : v0,
            protocol_amount : v1,
        };
        0x2::event::emit<HarvestEvent>(v4);
    }

    public fun donate<T0, T1, T2>(arg0: &0x8bec6bf9ef20b782b9b4b7a40754ac7972908d6e70279c45aaadedb205e7f119::config::GlobalConfig, arg1: &mut Farm<T0, T1>, arg2: 0x2::coin::Coin<T2>, arg3: &0x2::tx_context::TxContext) {
        0x8bec6bf9ef20b782b9b4b7a40754ac7972908d6e70279c45aaadedb205e7f119::config::assert_version(arg0);
        assert!(is_pair_coin<T0, T1, T2>(), 317);
        let v0 = 0x2::coin::value<T2>(&arg2);
        assert!(v0 > 0, 313);
        let v1 = &mut arg1.compounding;
        join_bag<T2>(v1, 0x2::coin::into_balance<T2>(arg2));
        let v2 = DonateEvent{
            farm_id   : 0x2::object::id<Farm<T0, T1>>(arg1),
            coin_type : 0x1::type_name::with_defining_ids<T2>(),
            amount    : v0,
            sender    : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<DonateEvent>(v2);
    }

    public fun emergency_pause<T0, T1>(arg0: &0x8bec6bf9ef20b782b9b4b7a40754ac7972908d6e70279c45aaadedb205e7f119::permission::OperatorCap, arg1: &mut Farm<T0, T1>) {
        arg1.deposit_paused = true;
        arg1.compound_paused = true;
        let v0 = PauseEvent{
            farm_id     : 0x2::object::id<Farm<T0, T1>>(arg1),
            deposit     : true,
            withdraw    : arg1.withdraw_paused,
            compound    : true,
            by_operator : true,
        };
        0x2::event::emit<PauseEvent>(v0);
    }

    public fun end_swap<T0, T1, T2>(arg0: &0x8bec6bf9ef20b782b9b4b7a40754ac7972908d6e70279c45aaadedb205e7f119::config::GlobalConfig, arg1: &mut Farm<T0, T1>, arg2: SwapTicket, arg3: 0x2::coin::Coin<T2>) {
        0x8bec6bf9ef20b782b9b4b7a40754ac7972908d6e70279c45aaadedb205e7f119::config::assert_version(arg0);
        let SwapTicket {
            farm_id   : v0,
            coin_in   : v1,
            coin_out  : v2,
            amount_in : v3,
            min_out   : v4,
        } = arg2;
        assert!(v0 == 0x2::object::id<Farm<T0, T1>>(arg1), 315);
        assert!(v2 == 0x1::type_name::with_defining_ids<T2>(), 315);
        let v5 = 0x2::coin::value<T2>(&arg3);
        assert!(v5 >= v4, 316);
        let v6 = &mut arg1.compounding;
        join_bag<T2>(v6, 0x2::coin::into_balance<T2>(arg3));
        let v7 = SwapEvent{
            farm_id    : v0,
            coin_in    : v1,
            coin_out   : v2,
            amount_in  : v3,
            amount_out : v5,
            min_out    : v4,
        };
        0x2::event::emit<SwapEvent>(v7);
    }

    public fun full_range_ticks(arg0: u32) : (u32, u32) {
        let v0 = 443636 - 443636 % arg0;
        (((4294967296 - (v0 as u64)) as u32), v0)
    }

    public fun info<T0, T1>(arg0: &Farm<T0, T1>) : (0x2::object::ID, u128, u128, u128, u128, bool, bool, bool) {
        (arg0.pool_id, arg0.total_share, arg0.locked_share, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::liquidity(&arg0.position), arg0.liquidity_cap, arg0.deposit_paused, arg0.withdraw_paused, arg0.compound_paused)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        0x8bec6bf9ef20b782b9b4b7a40754ac7972908d6e70279c45aaadedb205e7f119::permission::create_admin(0x2::tx_context::sender(arg0), arg0);
        0x8bec6bf9ef20b782b9b4b7a40754ac7972908d6e70279c45aaadedb205e7f119::config::create(@0x86ca1f0a3103d8f7c27336867ad86b94653965b84749d4b99fb8afa5b8c5b03b, arg0);
    }

    fun is_pair_coin<T0, T1, T2>() : bool {
        let v0 = 0x1::type_name::with_defining_ids<T2>();
        v0 == 0x1::type_name::with_defining_ids<T0>() || v0 == 0x1::type_name::with_defining_ids<T1>()
    }

    fun join_bag<T0>(arg0: &mut 0x2::bag::Bag, arg1: 0x2::balance::Balance<T0>) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(arg0, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(arg0, v0), arg1);
        } else if (0x2::balance::value<T0>(&arg1) > 0) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(arg0, v0, arg1);
        } else {
            0x2::balance::destroy_zero<T0>(arg1);
        };
    }

    public fun magma_position_id<T0, T1>(arg0: &Farm<T0, T1>) : 0x2::object::ID {
        0x2::object::id<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>(&arg0.position)
    }

    public fun merge_positions(arg0: &0x8bec6bf9ef20b782b9b4b7a40754ac7972908d6e70279c45aaadedb205e7f119::config::GlobalConfig, arg1: &mut 0x8bec6bf9ef20b782b9b4b7a40754ac7972908d6e70279c45aaadedb205e7f119::position::JewelMagmaPosition, arg2: 0x8bec6bf9ef20b782b9b4b7a40754ac7972908d6e70279c45aaadedb205e7f119::position::JewelMagmaPosition) {
        0x8bec6bf9ef20b782b9b4b7a40754ac7972908d6e70279c45aaadedb205e7f119::config::assert_version(arg0);
        0x8bec6bf9ef20b782b9b4b7a40754ac7972908d6e70279c45aaadedb205e7f119::position::merge(arg1, arg2);
    }

    public fun min_initial_liquidity() : u128 {
        1000000
    }

    public fun min_locked_share() : u128 {
        10000
    }

    fun mul_div_floor(arg0: u128, arg1: u128, arg2: u128) : u128 {
        (((arg0 as u256) * (arg1 as u256) / (arg2 as u256)) as u128)
    }

    public fun protocol_balance<T0, T1, T2>(arg0: &Farm<T0, T1>) : u64 {
        bag_value<T2>(&arg0.protocol)
    }

    fun quote_a_to_b(arg0: u64, arg1: u128) : u64 {
        let v0 = (arg1 as u256);
        let v1 = ((arg0 as u256) * v0 >> 64) * v0 >> 64;
        if (v1 > 18446744073709551615) {
            (18446744073709551615 as u64)
        } else {
            (v1 as u64)
        }
    }

    fun quote_b_to_a(arg0: u64, arg1: u128) : u64 {
        let v0 = (arg1 as u256);
        let v1 = (((arg0 as u256) << 64) / v0 << 64) / v0;
        if (v1 > 18446744073709551615) {
            (18446744073709551615 as u64)
        } else {
            (v1 as u64)
        }
    }

    public fun set_liquidity_cap<T0, T1>(arg0: &0x8bec6bf9ef20b782b9b4b7a40754ac7972908d6e70279c45aaadedb205e7f119::permission::AdminCap, arg1: &0x8bec6bf9ef20b782b9b4b7a40754ac7972908d6e70279c45aaadedb205e7f119::config::GlobalConfig, arg2: &mut Farm<T0, T1>, arg3: u128) {
        0x8bec6bf9ef20b782b9b4b7a40754ac7972908d6e70279c45aaadedb205e7f119::config::assert_version(arg1);
        let v0 = SetCapEvent{
            farm_id : 0x2::object::id<Farm<T0, T1>>(arg2),
            old_cap : arg2.liquidity_cap,
            new_cap : arg3,
        };
        0x2::event::emit<SetCapEvent>(v0);
        arg2.liquidity_cap = arg3;
    }

    public fun set_pause<T0, T1>(arg0: &0x8bec6bf9ef20b782b9b4b7a40754ac7972908d6e70279c45aaadedb205e7f119::permission::AdminCap, arg1: &0x8bec6bf9ef20b782b9b4b7a40754ac7972908d6e70279c45aaadedb205e7f119::config::GlobalConfig, arg2: &mut Farm<T0, T1>, arg3: bool, arg4: bool, arg5: bool) {
        0x8bec6bf9ef20b782b9b4b7a40754ac7972908d6e70279c45aaadedb205e7f119::config::assert_version(arg1);
        arg2.deposit_paused = arg3;
        arg2.withdraw_paused = arg4;
        arg2.compound_paused = arg5;
        let v0 = PauseEvent{
            farm_id     : 0x2::object::id<Farm<T0, T1>>(arg2),
            deposit     : arg3,
            withdraw    : arg4,
            compound    : arg5,
            by_operator : false,
        };
        0x2::event::emit<PauseEvent>(v0);
    }

    public fun share_to_liquidity<T0, T1>(arg0: &Farm<T0, T1>, arg1: u128) : u128 {
        mul_div_floor(arg1, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::liquidity(&arg0.position), arg0.total_share)
    }

    fun take_all<T0>(arg0: &mut 0x2::bag::Bag) : 0x2::balance::Balance<T0> {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(arg0, v0)) {
            0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(arg0, v0)
        } else {
            0x2::balance::zero<T0>()
        }
    }

    public fun ticks<T0, T1>(arg0: &Farm<T0, T1>) : (u32, u32) {
        (arg0.tick_lower, arg0.tick_upper)
    }

    public fun withdraw<T0, T1>(arg0: &0x8bec6bf9ef20b782b9b4b7a40754ac7972908d6e70279c45aaadedb205e7f119::config::GlobalConfig, arg1: &mut Farm<T0, T1>, arg2: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg3: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg4: &mut 0x8bec6bf9ef20b782b9b4b7a40754ac7972908d6e70279c45aaadedb205e7f119::position::JewelMagmaPosition, arg5: u128, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x8bec6bf9ef20b782b9b4b7a40754ac7972908d6e70279c45aaadedb205e7f119::config::assert_version(arg0);
        assert!(!arg1.withdraw_paused, 304);
        assert_pool<T0, T1>(arg1, arg3);
        assert!(0x8bec6bf9ef20b782b9b4b7a40754ac7972908d6e70279c45aaadedb205e7f119::position::farm_id(arg4) == 0x2::object::id<Farm<T0, T1>>(arg1), 302);
        assert!(arg5 > 0, 318);
        let v0 = mul_div_floor(arg5, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::liquidity(&arg1.position), arg1.total_share);
        assert!(v0 > 0, 306);
        0x8bec6bf9ef20b782b9b4b7a40754ac7972908d6e70279c45aaadedb205e7f119::position::decrease(arg4, arg5);
        arg1.total_share = arg1.total_share - arg5;
        let (v1, v2) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::remove_liquidity<T0, T1>(arg2, arg3, &mut arg1.position, v0, arg8);
        let v3 = v2;
        let v4 = v1;
        assert!(0x2::balance::value<T0>(&v4) >= arg6 && 0x2::balance::value<T1>(&v3) >= arg7, 308);
        let v5 = WithdrawEvent{
            farm_id         : 0x2::object::id<Farm<T0, T1>>(arg1),
            position_id     : 0x2::object::id<0x8bec6bf9ef20b782b9b4b7a40754ac7972908d6e70279c45aaadedb205e7f119::position::JewelMagmaPosition>(arg4),
            sender          : 0x2::tx_context::sender(arg9),
            amount_a        : 0x2::balance::value<T0>(&v4),
            amount_b        : 0x2::balance::value<T1>(&v3),
            liquidity       : v0,
            share           : arg5,
            total_share     : arg1.total_share,
            total_liquidity : 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::liquidity(&arg1.position),
        };
        0x2::event::emit<WithdrawEvent>(v5);
        (0x2::coin::from_balance<T0>(v4, arg9), 0x2::coin::from_balance<T1>(v3, arg9))
    }

    // decompiled from Move bytecode v7
}

