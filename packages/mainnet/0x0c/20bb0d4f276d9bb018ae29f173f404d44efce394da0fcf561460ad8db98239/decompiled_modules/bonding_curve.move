module 0xece458a0f04fae880ac3a4238171bc091368cdedcc57bc48d63fa0f9eae2009f::bonding_curve {
    struct PositionConfig<phantom T0> has store {
        tick_lower: u32,
        tick_upper: u32,
        percent_bps: u16,
        coin: 0x2::balance::Balance<T0>,
        position: 0x1::option::Option<0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::position::Position>,
    }

    struct FeeReceiverConfig<phantom T0, phantom T1> has store {
        recipient: address,
        admin: address,
        percent_bps: u64,
        unclaimed_fee_x: 0x2::balance::Balance<T0>,
        unclaimed_fee_y: 0x2::balance::Balance<T1>,
        total_collected_fee_x: u64,
        total_collected_fee_y: u64,
        unclaimed_rewards: 0x2::bag::Bag,
    }

    struct BondingCurve<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        token: 0x1::type_name::TypeName,
        treasury_cap: 0x2::coin::TreasuryCap<T0>,
        owner: address,
        deployer: address,
        init_price: u128,
        tick_spacing: u32,
        positions: vector<PositionConfig<T0>>,
        fee_receivers: vector<FeeReceiverConfig<T0, T1>>,
        protocol_fee_x: 0x2::balance::Balance<T0>,
        protocol_fee_y: 0x2::balance::Balance<T1>,
        vault: 0xece458a0f04fae880ac3a4238171bc091368cdedcc57bc48d63fa0f9eae2009f::vault::Vault<T0>,
        vault_bps: u64,
    }

    struct BondingCurveCreated has copy, drop {
        bonding_curve_id: 0x2::object::ID,
        token: 0x1::type_name::TypeName,
        owner: address,
        deployer: address,
        init_price: u128,
        tick_spacing: u32,
        positions_count: u64,
        fee_receivers_count: u64,
        vault_bps: u64,
    }

    public(friend) fun new<T0, T1>(arg0: &0xece458a0f04fae880ac3a4238171bc091368cdedcc57bc48d63fa0f9eae2009f::config::Config, arg1: 0x2::coin::TreasuryCap<T0>, arg2: address, arg3: u128, arg4: u32, arg5: vector<u32>, arg6: vector<u32>, arg7: vector<u16>, arg8: vector<address>, arg9: vector<u64>, arg10: vector<address>, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : BondingCurve<T0, T1> {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x2::tx_context::sender(arg13);
        assert!(arg11 <= (0xece458a0f04fae880ac3a4238171bc091368cdedcc57bc48d63fa0f9eae2009f::config::max_vault_bps() as u64), 205);
        let v2 = &mut arg1;
        let (v3, v4) = mint_and_split<T0>(v2, arg0, arg11, &arg7, arg13);
        let (v5, v6) = 0xece458a0f04fae880ac3a4238171bc091368cdedcc57bc48d63fa0f9eae2009f::config::get_vault_config(arg0);
        let v7 = 0xece458a0f04fae880ac3a4238171bc091368cdedcc57bc48d63fa0f9eae2009f::vault::new<T0>(v4, arg2, v5, v6, arg12, arg13);
        let v8 = build_positions<T0>(arg5, arg6, arg7, v3);
        let v9 = 0x1::vector::length<PositionConfig<T0>>(&v8);
        0xece458a0f04fae880ac3a4238171bc091368cdedcc57bc48d63fa0f9eae2009f::config::assert_positions_count(v9);
        validate_positions<T0>(&v8);
        let v10 = build_fee_receivers<T0, T1>(arg8, arg9, arg10, arg13);
        let v11 = 0x1::vector::length<FeeReceiverConfig<T0, T1>>(&v10);
        0xece458a0f04fae880ac3a4238171bc091368cdedcc57bc48d63fa0f9eae2009f::config::assert_fee_receivers_count(v11);
        validate_fee_receivers<T0, T1>(&v10);
        let v12 = BondingCurve<T0, T1>{
            id             : 0x2::object::new(arg13),
            pool_id        : 0x2::object::id_from_address(@0x0),
            token          : v0,
            treasury_cap   : arg1,
            owner          : arg2,
            deployer       : v1,
            init_price     : arg3,
            tick_spacing   : arg4,
            positions      : v8,
            fee_receivers  : v10,
            protocol_fee_x : 0x2::balance::zero<T0>(),
            protocol_fee_y : 0x2::balance::zero<T1>(),
            vault          : v7,
            vault_bps      : arg11,
        };
        let v13 = BondingCurveCreated{
            bonding_curve_id    : 0x2::object::id<BondingCurve<T0, T1>>(&v12),
            token               : v0,
            owner               : arg2,
            deployer            : v1,
            init_price          : arg3,
            tick_spacing        : arg4,
            positions_count     : v9,
            fee_receivers_count : v11,
            vault_bps           : arg11,
        };
        0x2::event::emit<BondingCurveCreated>(v13);
        v12
    }

    public fun id<T0, T1>(arg0: &BondingCurve<T0, T1>) : 0x2::object::ID {
        0x2::object::id<BondingCurve<T0, T1>>(arg0)
    }

    public fun collect_fee<T0, T1>(arg0: &0xece458a0f04fae880ac3a4238171bc091368cdedcc57bc48d63fa0f9eae2009f::config::Config, arg1: &mut BondingCurve<T0, T1>, arg2: &mut 0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::pool::Pool<T0, T1>, arg3: &0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::config::GlobalConfig, arg4: &mut 0x2::tx_context::TxContext) {
        0xece458a0f04fae880ac3a4238171bc091368cdedcc57bc48d63fa0f9eae2009f::config::assert_not_paused(arg0);
        0xece458a0f04fae880ac3a4238171bc091368cdedcc57bc48d63fa0f9eae2009f::config::assert_current_version(arg0);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(is_authorized_fee_collector<T0, T1>(arg1, v0), 206);
        let v1 = 0x2::balance::zero<T0>();
        let v2 = 0x2::balance::zero<T1>();
        let v3 = 0;
        while (v3 < 0x1::vector::length<PositionConfig<T0>>(&arg1.positions)) {
            let v4 = 0x1::vector::borrow<PositionConfig<T0>>(&arg1.positions, v3);
            if (0x1::option::is_some<0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::position::Position>(&v4.position)) {
                let (v5, v6) = 0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::pool::collect_fee<T0, T1>(arg3, arg2, 0x1::option::borrow<0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::position::Position>(&v4.position), true);
                0x2::balance::join<T0>(&mut v1, v5);
                0x2::balance::join<T1>(&mut v2, v6);
            };
            v3 = v3 + 1;
        };
        let v7 = 0xece458a0f04fae880ac3a4238171bc091368cdedcc57bc48d63fa0f9eae2009f::config::calculate_protocol_fee(arg0, 0x2::balance::value<T0>(&v1));
        let v8 = 0xece458a0f04fae880ac3a4238171bc091368cdedcc57bc48d63fa0f9eae2009f::config::calculate_protocol_fee(arg0, 0x2::balance::value<T1>(&v2));
        if (v7 > 0) {
            0x2::balance::join<T0>(&mut arg1.protocol_fee_x, 0x2::balance::split<T0>(&mut v1, v7));
        };
        if (v8 > 0) {
            0x2::balance::join<T1>(&mut arg1.protocol_fee_y, 0x2::balance::split<T1>(&mut v2, v8));
        };
        let v9 = 0;
        let v10 = 0x1::vector::length<FeeReceiverConfig<T0, T1>>(&arg1.fee_receivers);
        while (v9 < v10) {
            let v11 = 0x1::vector::borrow_mut<FeeReceiverConfig<T0, T1>>(&mut arg1.fee_receivers, v9);
            let v12 = if (v9 == v10 - 1) {
                0x2::balance::value<T0>(&v1)
            } else {
                0x2::balance::value<T0>(&v1) * v11.percent_bps / 10000
            };
            let v13 = if (v9 == v10 - 1) {
                0x2::balance::value<T1>(&v2)
            } else {
                0x2::balance::value<T1>(&v2) * v11.percent_bps / 10000
            };
            if (v11.recipient == v0) {
                if (v12 > 0) {
                    v11.total_collected_fee_x = v11.total_collected_fee_x + v12;
                    0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v1, v12), arg4), v0);
                };
                if (v13 > 0) {
                    v11.total_collected_fee_y = v11.total_collected_fee_y + v13;
                    0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v2, v13), arg4), v0);
                };
            } else {
                if (v12 > 0) {
                    0x2::balance::join<T0>(&mut v11.unclaimed_fee_x, 0x2::balance::split<T0>(&mut v1, v12));
                };
                if (v13 > 0) {
                    0x2::balance::join<T1>(&mut v11.unclaimed_fee_y, 0x2::balance::split<T1>(&mut v2, v13));
                };
            };
            v9 = v9 + 1;
        };
        0x2::balance::destroy_zero<T0>(v1);
        0x2::balance::destroy_zero<T1>(v2);
    }

    public fun collect_reward<T0, T1, T2>(arg0: &0xece458a0f04fae880ac3a4238171bc091368cdedcc57bc48d63fa0f9eae2009f::config::Config, arg1: &mut BondingCurve<T0, T1>, arg2: &mut 0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::pool::Pool<T0, T1>, arg3: &0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::config::GlobalConfig, arg4: &mut 0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::rewarder::RewarderGlobalVault, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xece458a0f04fae880ac3a4238171bc091368cdedcc57bc48d63fa0f9eae2009f::config::assert_not_paused(arg0);
        0xece458a0f04fae880ac3a4238171bc091368cdedcc57bc48d63fa0f9eae2009f::config::assert_current_version(arg0);
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(is_authorized_fee_collector<T0, T1>(arg1, v0), 206);
        let v1 = 0x2::balance::zero<T2>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<PositionConfig<T0>>(&arg1.positions)) {
            let v3 = 0x1::vector::borrow<PositionConfig<T0>>(&arg1.positions, v2);
            if (0x1::option::is_some<0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::position::Position>(&v3.position)) {
                0x2::balance::join<T2>(&mut v1, 0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::pool::collect_reward<T0, T1, T2>(arg3, arg2, 0x1::option::borrow<0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::position::Position>(&v3.position), arg4, true, arg5));
            };
            v2 = v2 + 1;
        };
        let v4 = 0x1::type_name::get<T2>();
        let v5 = 0;
        let v6 = 0x1::vector::length<FeeReceiverConfig<T0, T1>>(&arg1.fee_receivers);
        while (v5 < v6) {
            let v7 = 0x1::vector::borrow_mut<FeeReceiverConfig<T0, T1>>(&mut arg1.fee_receivers, v5);
            let v8 = if (v5 == v6 - 1) {
                0x2::balance::value<T2>(&v1)
            } else {
                0x2::balance::value<T2>(&v1) * v7.percent_bps / 10000
            };
            if (v8 > 0) {
                let v9 = 0x2::balance::split<T2>(&mut v1, v8);
                if (v7.recipient == v0) {
                    if (0x2::bag::contains<0x1::type_name::TypeName>(&v7.unclaimed_rewards, v4)) {
                        0x2::balance::join<T2>(&mut v9, 0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut v7.unclaimed_rewards, v4));
                    };
                    0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v9, arg6), v0);
                } else if (0x2::bag::contains<0x1::type_name::TypeName>(&v7.unclaimed_rewards, v4)) {
                    0x2::balance::join<T2>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut v7.unclaimed_rewards, v4), v9);
                } else {
                    0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut v7.unclaimed_rewards, v4, v9);
                };
            };
            v5 = v5 + 1;
        };
        0x2::balance::destroy_zero<T2>(v1);
    }

    fun add_liquidity_position<T0, T1>(arg0: &0xece458a0f04fae880ac3a4238171bc091368cdedcc57bc48d63fa0f9eae2009f::config::Config, arg1: &0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::config::GlobalConfig, arg2: &mut BondingCurve<T0, T1>, arg3: &mut 0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::pool::Pool<T0, T1>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::pool::Pool<T0, T1>>(arg3) == arg2.pool_id, 208);
        let v0 = borrow_position_config_mut<T0, T1>(arg2, arg4);
        assert!(!0x1::option::is_some<0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::position::Position>(&v0.position) && 0x2::balance::value<T0>(&v0.coin) != 0, 207);
        let v1 = 0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::pool::open_position<T0, T1>(arg1, arg3, v0.tick_lower, v0.tick_upper, arg6);
        0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::pool::repay_add_liquidity<T0, T1>(arg1, arg3, 0x2::balance::withdraw_all<T0>(&mut v0.coin), 0x2::balance::zero<T1>(), 0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::pool::add_liquidity_fix_coin<T0, T1>(arg1, arg3, &mut v1, 0x2::balance::value<T0>(&v0.coin), 0xece458a0f04fae880ac3a4238171bc091368cdedcc57bc48d63fa0f9eae2009f::config::is_fixed_x(arg0), arg5));
        add_position_to_config<T0>(v0, v1);
    }

    public(friend) fun add_liquidity_positions<T0, T1>(arg0: &0xece458a0f04fae880ac3a4238171bc091368cdedcc57bc48d63fa0f9eae2009f::config::Config, arg1: &0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::config::GlobalConfig, arg2: &mut BondingCurve<T0, T1>, arg3: &mut 0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<PositionConfig<T0>>(&arg2.positions);
        assert!(v0 > 1, 209);
        let v1 = 1;
        while (v1 < v0) {
            add_liquidity_position<T0, T1>(arg0, arg1, arg2, arg3, v1, arg4, arg5);
            v1 = v1 + 1;
        };
    }

    public(friend) fun add_position_to_config<T0>(arg0: &mut PositionConfig<T0>, arg1: 0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::position::Position) {
        0x1::option::fill<0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::position::Position>(&mut arg0.position, arg1);
    }

    public(friend) fun borrow_position_config_mut<T0, T1>(arg0: &mut BondingCurve<T0, T1>, arg1: u64) : &mut PositionConfig<T0> {
        0x1::vector::borrow_mut<PositionConfig<T0>>(&mut arg0.positions, arg1)
    }

    fun build_fee_receivers<T0, T1>(arg0: vector<address>, arg1: vector<u64>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) : vector<FeeReceiverConfig<T0, T1>> {
        let v0 = 0;
        let v1 = 0x1::vector::empty<FeeReceiverConfig<T0, T1>>();
        while (v0 < 0x1::vector::length<address>(&arg0)) {
            let v2 = *0x1::vector::borrow<u64>(&arg1, v0);
            assert!(v2 <= 10000, 200);
            let v3 = FeeReceiverConfig<T0, T1>{
                recipient             : *0x1::vector::borrow<address>(&arg0, v0),
                admin                 : *0x1::vector::borrow<address>(&arg2, v0),
                percent_bps           : v2,
                unclaimed_fee_x       : 0x2::balance::zero<T0>(),
                unclaimed_fee_y       : 0x2::balance::zero<T1>(),
                total_collected_fee_x : 0,
                total_collected_fee_y : 0,
                unclaimed_rewards     : 0x2::bag::new(arg3),
            };
            0x1::vector::push_back<FeeReceiverConfig<T0, T1>>(&mut v1, v3);
            v0 = v0 + 1;
        };
        v1
    }

    fun build_positions<T0>(arg0: vector<u32>, arg1: vector<u32>, arg2: vector<u16>, arg3: vector<0x2::coin::Coin<T0>>) : vector<PositionConfig<T0>> {
        let v0 = 0x1::vector::empty<PositionConfig<T0>>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u32>(&arg0)) {
            let v2 = *0x1::vector::borrow<u16>(&arg2, v1);
            assert!(v2 <= (10000 as u16), 201);
            let v3 = PositionConfig<T0>{
                tick_lower  : *0x1::vector::borrow<u32>(&arg0, v1),
                tick_upper  : *0x1::vector::borrow<u32>(&arg1, v1),
                percent_bps : v2,
                coin        : 0x2::coin::into_balance<T0>(0x1::vector::remove<0x2::coin::Coin<T0>>(&mut arg3, 0)),
                position    : 0x1::option::none<0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::position::Position>(),
            };
            0x1::vector::push_back<PositionConfig<T0>>(&mut v0, v3);
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg3);
        v0
    }

    public fun collect_protocol_fee<T0, T1>(arg0: &0xece458a0f04fae880ac3a4238171bc091368cdedcc57bc48d63fa0f9eae2009f::config::Config, arg1: &mut BondingCurve<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        0xece458a0f04fae880ac3a4238171bc091368cdedcc57bc48d63fa0f9eae2009f::config::assert_not_paused(arg0);
        0xece458a0f04fae880ac3a4238171bc091368cdedcc57bc48d63fa0f9eae2009f::config::assert_current_version(arg0);
        let v0 = 0xece458a0f04fae880ac3a4238171bc091368cdedcc57bc48d63fa0f9eae2009f::config::fee_receiver(arg0);
        if (0x2::balance::value<T0>(&arg1.protocol_fee_x) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg1.protocol_fee_x), arg2), v0);
        };
        if (0x2::balance::value<T1>(&arg1.protocol_fee_y) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::withdraw_all<T1>(&mut arg1.protocol_fee_y), arg2), v0);
        };
    }

    public(friend) fun deposit_leftover<T0, T1>(arg0: &mut BondingCurve<T0, T1>, arg1: 0x2::coin::Coin<T0>) {
        0xece458a0f04fae880ac3a4238171bc091368cdedcc57bc48d63fa0f9eae2009f::vault::deposit<T0>(&mut arg0.vault, arg1);
    }

    public fun fee_receivers<T0, T1>(arg0: &BondingCurve<T0, T1>) : &vector<FeeReceiverConfig<T0, T1>> {
        &arg0.fee_receivers
    }

    public fun get_pending_fee<T0, T1>(arg0: &BondingCurve<T0, T1>, arg1: &0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::pool::Pool<T0, T1>) : (u64, u64) {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<PositionConfig<T0>>(&arg0.positions)) {
            let v3 = 0x1::vector::borrow<PositionConfig<T0>>(&arg0.positions, v2);
            if (0x1::option::is_some<0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::position::Position>(&v3.position)) {
                let (v4, v5) = 0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::pool::get_position_fee<T0, T1>(arg1, 0x2::object::id<0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::position::Position>(0x1::option::borrow<0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::position::Position>(&v3.position)));
                v0 = v0 + v4;
                v1 = v1 + v5;
            };
            v2 = v2 + 1;
        };
        (v0, v1)
    }

    public fun get_pending_reward<T0, T1, T2>(arg0: &BondingCurve<T0, T1>, arg1: &0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::pool::Pool<T0, T1>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<PositionConfig<T0>>(&arg0.positions)) {
            let v2 = 0x1::vector::borrow<PositionConfig<T0>>(&arg0.positions, v1);
            if (0x1::option::is_some<0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::position::Position>(&v2.position)) {
                v0 = v0 + 0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::pool::get_position_reward<T0, T1, T2>(arg1, 0x2::object::id<0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::position::Position>(0x1::option::borrow<0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::position::Position>(&v2.position)));
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun init_price<T0, T1>(arg0: &BondingCurve<T0, T1>) : u128 {
        arg0.init_price
    }

    fun is_authorized_fee_collector<T0, T1>(arg0: &BondingCurve<T0, T1>, arg1: address) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<FeeReceiverConfig<T0, T1>>(&arg0.fee_receivers)) {
            if (0x1::vector::borrow<FeeReceiverConfig<T0, T1>>(&arg0.fee_receivers, v0).recipient == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    fun mint_and_split<T0>(arg0: &mut 0x2::coin::TreasuryCap<T0>, arg1: &0xece458a0f04fae880ac3a4238171bc091368cdedcc57bc48d63fa0f9eae2009f::config::Config, arg2: u64, arg3: &vector<u16>, arg4: &mut 0x2::tx_context::TxContext) : (vector<0x2::coin::Coin<T0>>, 0x2::coin::Coin<T0>) {
        assert!(0x2::coin::total_supply<T0>(arg0) == 0, 204);
        let v0 = 0xece458a0f04fae880ac3a4238171bc091368cdedcc57bc48d63fa0f9eae2009f::config::total_token_supply(arg1);
        let v1 = 0x2::coin::into_balance<T0>(0x2::coin::mint<T0>(arg0, v0, arg4));
        let v2 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        let v3 = 0;
        let v4 = 0x1::vector::length<u16>(arg3);
        while (v3 < v4) {
            let v5 = if (v3 == v4 - 1) {
                0x2::balance::value<T0>(&v1)
            } else {
                0x2::balance::value<T0>(&v1) * (*0x1::vector::borrow<u16>(arg3, v3) as u64) / 10000
            };
            0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v2, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v1, v5), arg4));
            v3 = v3 + 1;
        };
        0x2::balance::destroy_zero<T0>(v1);
        (v2, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v1, v0 * arg2 / 10000), arg4))
    }

    public fun owner<T0, T1>(arg0: &BondingCurve<T0, T1>) : address {
        arg0.owner
    }

    public fun position_tick_lower<T0>(arg0: &PositionConfig<T0>) : u32 {
        arg0.tick_lower
    }

    public fun position_tick_upper<T0>(arg0: &PositionConfig<T0>) : u32 {
        arg0.tick_upper
    }

    public fun positions<T0, T1>(arg0: &BondingCurve<T0, T1>) : &vector<PositionConfig<T0>> {
        &arg0.positions
    }

    public(friend) fun set_curve_pool_id<T0, T1>(arg0: &mut BondingCurve<T0, T1>, arg1: 0x2::object::ID) {
        arg0.pool_id = arg1;
    }

    public(friend) fun take_position_coin<T0>(arg0: &mut PositionConfig<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.coin), arg1)
    }

    public fun tick_spacing<T0, T1>(arg0: &BondingCurve<T0, T1>) : u32 {
        arg0.tick_spacing
    }

    public fun token<T0, T1>(arg0: &BondingCurve<T0, T1>) : 0x1::type_name::TypeName {
        arg0.token
    }

    public fun update_fee_receiver<T0, T1>(arg0: &0xece458a0f04fae880ac3a4238171bc091368cdedcc57bc48d63fa0f9eae2009f::config::Config, arg1: &mut BondingCurve<T0, T1>, arg2: address, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0xece458a0f04fae880ac3a4238171bc091368cdedcc57bc48d63fa0f9eae2009f::config::assert_not_paused(arg0);
        0xece458a0f04fae880ac3a4238171bc091368cdedcc57bc48d63fa0f9eae2009f::config::assert_current_version(arg0);
        let v0 = 0;
        while (v0 < 0x1::vector::length<FeeReceiverConfig<T0, T1>>(&arg1.fee_receivers)) {
            let v1 = 0x1::vector::borrow_mut<FeeReceiverConfig<T0, T1>>(&mut arg1.fee_receivers, v0);
            if (v1.recipient == arg2 && v1.admin == 0x2::tx_context::sender(arg4)) {
                v1.recipient = arg3;
            };
            v0 = v0 + 1;
        };
    }

    fun validate_fee_receivers<T0, T1>(arg0: &vector<FeeReceiverConfig<T0, T1>>) {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<FeeReceiverConfig<T0, T1>>(arg0)) {
            v0 = v0 + 0x1::vector::borrow<FeeReceiverConfig<T0, T1>>(arg0, v1).percent_bps;
            v1 = v1 + 1;
        };
        assert!(v0 <= 10000, 203);
    }

    fun validate_positions<T0>(arg0: &vector<PositionConfig<T0>>) {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<PositionConfig<T0>>(arg0)) {
            v0 = v0 + (0x1::vector::borrow<PositionConfig<T0>>(arg0, v1).percent_bps as u64);
            v1 = v1 + 1;
        };
        assert!(v0 <= 10000, 202);
    }

    // decompiled from Move bytecode v6
}

