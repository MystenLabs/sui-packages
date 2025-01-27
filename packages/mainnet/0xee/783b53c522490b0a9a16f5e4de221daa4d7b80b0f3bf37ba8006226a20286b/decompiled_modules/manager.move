module 0xee783b53c522490b0a9a16f5e4de221daa4d7b80b0f3bf37ba8006226a20286b::manager {
    struct ManagerCreatedEvent has copy, drop {
        manager_id: 0x2::object::ID,
        creation_fee: u64,
        fee_percentage: u64,
        liquidity_fee: u64,
    }

    struct BondingCurveCreatedEvent has copy, drop {
        token_type: 0x1::string::String,
        pool_id: 0x2::object::ID,
        initial_amount: u64,
        fee_percentage: u64,
        creator: address,
    }

    struct FeesCollectedEvent has copy, drop {
        amount: u64,
        collector: address,
    }

    struct PoolMigratedEvent has copy, drop {
        token_type: 0x1::string::String,
        liquidity_fee_amount: u64,
        position_id: 0x2::object::ID,
    }

    struct PositionBurnedEvent has copy, drop {
        token_type: 0x1::string::String,
        position_id: 0x2::object::ID,
        burn_proof_id: 0x2::object::ID,
    }

    struct FeesCollectedFromBurnEvent has copy, drop {
        token_type: 0x1::string::String,
        coin_a_amount: u64,
        coin_b_amount: u64,
    }

    struct FeeConfigUpdatedEvent has copy, drop {
        creation_fee: u64,
        fee_percentage: u64,
        liquidity_fee: u64,
    }

    struct TokenBalanceWithdrawnEvent has copy, drop {
        token_type: 0x1::string::String,
        amount: u64,
        recipient: address,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Manager<phantom T0> has store, key {
        id: 0x2::object::UID,
        tokens: vector<0x1::string::String>,
        user_tokens: 0x2::table::Table<address, vector<0x1::string::String>>,
        pools: 0x2::table::Table<0x1::string::String, 0x2::object::ID>,
        fee_balance: 0x2::balance::Balance<T0>,
        positions: 0x2::table::Table<0x1::string::String, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>,
        burn_proofs: 0x2::table::Table<0x1::string::String, 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof>,
        token_balances: 0x2::bag::Bag,
        creation_fee: u64,
        fee_percentage: u64,
        liquidity_fee: u64,
    }

    public fun buy_tokens<T0, T1>(arg0: &Manager<T1>, arg1: &mut 0xee783b53c522490b0a9a16f5e4de221daa4d7b80b0f3bf37ba8006226a20286b::bonding_curve::BondingCurvePool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        assert!(0x2::table::contains<0x1::string::String, 0x2::object::ID>(&arg0.pools, v0), 2);
        assert!(0x2::object::id<0xee783b53c522490b0a9a16f5e4de221daa4d7b80b0f3bf37ba8006226a20286b::bonding_curve::BondingCurvePool<T0, T1>>(arg1) == *0x2::table::borrow<0x1::string::String, 0x2::object::ID>(&arg0.pools, v0), 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0xee783b53c522490b0a9a16f5e4de221daa4d7b80b0f3bf37ba8006226a20286b::bonding_curve::buy_tokens<T0, T1>(arg1, arg2, arg3, arg4), 0x2::tx_context::sender(arg4));
    }

    public fun claim_pool_fees<T0, T1>(arg0: &AdminCap, arg1: &mut 0xee783b53c522490b0a9a16f5e4de221daa4d7b80b0f3bf37ba8006226a20286b::bonding_curve::BondingCurvePool<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0xee783b53c522490b0a9a16f5e4de221daa4d7b80b0f3bf37ba8006226a20286b::bonding_curve::claim_pool_fees<T0, T1>(arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public fun create_bonding_curve<T0, T1>(arg0: &mut Manager<T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: 0x2::coin::Coin<T1>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        assert!(!0x2::table::contains<0x1::string::String, 0x2::object::ID>(&arg0.pools, v0), 3);
        assert!(0x2::coin::value<T1>(&arg2) >= arg0.creation_fee, 4);
        assert!(0x2::coin::value<T0>(&arg1) >= 1000000000000000000, 5);
        0x2::balance::join<T1>(&mut arg0.fee_balance, 0x2::coin::into_balance<T1>(arg2));
        let v1 = 0xee783b53c522490b0a9a16f5e4de221daa4d7b80b0f3bf37ba8006226a20286b::bonding_curve::create_bonding_curve<T0, T1>(arg1, arg0.fee_percentage, arg3, arg4);
        0x2::table::add<0x1::string::String, 0x2::object::ID>(&mut arg0.pools, v0, v1);
        0x1::vector::push_back<0x1::string::String>(&mut arg0.tokens, v0);
        if (!0x2::table::contains<address, vector<0x1::string::String>>(&arg0.user_tokens, 0x2::tx_context::sender(arg4))) {
            0x2::table::add<address, vector<0x1::string::String>>(&mut arg0.user_tokens, 0x2::tx_context::sender(arg4), 0x1::vector::empty<0x1::string::String>());
        };
        0x1::vector::push_back<0x1::string::String>(0x2::table::borrow_mut<address, vector<0x1::string::String>>(&mut arg0.user_tokens, 0x2::tx_context::sender(arg4)), v0);
        let v2 = BondingCurveCreatedEvent{
            token_type     : v0,
            pool_id        : v1,
            initial_amount : 0x2::coin::value<T0>(&arg1),
            fee_percentage : arg0.fee_percentage,
            creator        : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<BondingCurveCreatedEvent>(v2);
        v1
    }

    public fun current_price<T0, T1>(arg0: &0xee783b53c522490b0a9a16f5e4de221daa4d7b80b0f3bf37ba8006226a20286b::bonding_curve::BondingCurvePool<T0, T1>) : u128 {
        0xee783b53c522490b0a9a16f5e4de221daa4d7b80b0f3bf37ba8006226a20286b::bonding_curve::current_price<T0, T1>(arg0)
    }

    public fun migrate_pool<T0, T1>(arg0: &AdminCap, arg1: &mut Manager<T1>, arg2: &mut 0xee783b53c522490b0a9a16f5e4de221daa4d7b80b0f3bf37ba8006226a20286b::bonding_curve::BondingCurvePool<T0, T1>, arg3: &0x2::coin::CoinMetadata<T0>, arg4: &0x2::coin::CoinMetadata<T1>, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xee783b53c522490b0a9a16f5e4de221daa4d7b80b0f3bf37ba8006226a20286b::bonding_curve::migrate_pool<T0, T1>(arg2, arg8);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0x2::coin::value<T1>(&v2) * arg1.liquidity_fee / 10000;
        0x2::balance::join<T1>(&mut arg1.fee_balance, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v2, v4, arg8)));
        let (v5, v6) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::full_range_tick_range(60);
        let (v7, v8, v9) = if (compare_coin_types(0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())), 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T1>())))) {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::create_pool_v2<T0, T1>(arg5, arg6, 60, sqrt(340282366920938463463374607431768211456 * (0x2::coin::value<T1>(&v2) as u256) / (0x2::coin::value<T0>(&v3) as u256)), 0x1::string::utf8(b""), v5, v6, v3, v2, arg3, arg4, true, arg7, arg8)
        } else {
            let (v10, v11, v12) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::create_pool_v2<T1, T0>(arg5, arg6, 60, sqrt(340282366920938463463374607431768211456 * (0x2::coin::value<T0>(&v3) as u256) / (0x2::coin::value<T1>(&v2) as u256)), 0x1::string::utf8(b""), v5, v6, v2, v3, arg4, arg3, false, arg7, arg8);
            (v10, v12, v11)
        };
        let v13 = v9;
        let v14 = v8;
        let v15 = v7;
        let v16 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        0x2::table::add<0x1::string::String, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg1.positions, v16, v15);
        let v17 = PoolMigratedEvent{
            token_type           : v16,
            liquidity_fee_amount : v4,
            position_id          : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v15),
        };
        0x2::event::emit<PoolMigratedEvent>(v17);
        if (0x2::coin::value<T0>(&v14) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v14, 0x2::tx_context::sender(arg8));
        } else {
            0x2::coin::destroy_zero<T0>(v14);
        };
        if (0x2::coin::value<T1>(&v13) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v13, 0x2::tx_context::sender(arg8));
        } else {
            0x2::coin::destroy_zero<T1>(v13);
        };
    }

    public fun sell_tokens<T0, T1>(arg0: &Manager<T1>, arg1: &mut 0xee783b53c522490b0a9a16f5e4de221daa4d7b80b0f3bf37ba8006226a20286b::bonding_curve::BondingCurvePool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        assert!(0x2::table::contains<0x1::string::String, 0x2::object::ID>(&arg0.pools, v0), 2);
        assert!(0x2::object::id<0xee783b53c522490b0a9a16f5e4de221daa4d7b80b0f3bf37ba8006226a20286b::bonding_curve::BondingCurvePool<T0, T1>>(arg1) == *0x2::table::borrow<0x1::string::String, 0x2::object::ID>(&arg0.pools, v0), 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0xee783b53c522490b0a9a16f5e4de221daa4d7b80b0f3bf37ba8006226a20286b::bonding_curve::sell_tokens<T0, T1>(arg1, arg2, arg3, arg4), 0x2::tx_context::sender(arg4));
    }

    public fun burn_position<T0, T1>(arg0: &AdminCap, arg1: &mut Manager<T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        assert!(0x2::table::contains<0x1::string::String, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg1.positions, v0), 2);
        let v1 = 0x2::table::remove<0x1::string::String, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg1.positions, v0);
        let v2 = 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::burn_lp<T0, T1>(arg3, arg2, v1, arg4);
        0x2::table::add<0x1::string::String, 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof>(&mut arg1.burn_proofs, v0, v2);
        let v3 = PositionBurnedEvent{
            token_type    : v0,
            position_id   : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v1),
            burn_proof_id : 0x2::object::id<0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof>(&v2),
        };
        0x2::event::emit<PositionBurnedEvent>(v3);
    }

    public fun burn_position_swapped<T0, T1>(arg0: &AdminCap, arg1: &mut Manager<T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        assert!(0x2::table::contains<0x1::string::String, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg1.positions, v0), 2);
        let v1 = 0x2::table::remove<0x1::string::String, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg1.positions, v0);
        let v2 = 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::burn_lp<T1, T0>(arg3, arg2, v1, arg4);
        0x2::table::add<0x1::string::String, 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof>(&mut arg1.burn_proofs, v0, v2);
        let v3 = PositionBurnedEvent{
            token_type    : v0,
            position_id   : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v1),
            burn_proof_id : 0x2::object::id<0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof>(&v2),
        };
        0x2::event::emit<PositionBurnedEvent>(v3);
    }

    public fun collect_fees<T0>(arg0: &AdminCap, arg1: &mut Manager<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T0>(&arg1.fee_balance);
        assert!(v0 > 0, 1);
        let v1 = FeesCollectedEvent{
            amount    : v0,
            collector : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<FeesCollectedEvent>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.fee_balance, v0), arg2), 0x2::tx_context::sender(arg2));
    }

    public fun collect_fees_from_burn_proof<T0, T1>(arg0: &AdminCap, arg1: &mut Manager<T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::collect_fee<T0, T1>(arg4, arg3, arg2, 0x2::table::borrow_mut<0x1::string::String, 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof>(&mut arg1.burn_proofs, arg5), arg6);
        let v2 = v1;
        let v3 = v0;
        if (!0x2::bag::contains<0x1::string::String>(&arg1.token_balances, arg5)) {
            0x2::bag::add<0x1::string::String, 0x2::balance::Balance<T0>>(&mut arg1.token_balances, arg5, 0x2::balance::zero<T0>());
        };
        0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::string::String, 0x2::balance::Balance<T0>>(&mut arg1.token_balances, arg5), 0x2::coin::into_balance<T0>(v3));
        0x2::balance::join<T1>(&mut arg1.fee_balance, 0x2::coin::into_balance<T1>(v2));
        let v4 = FeesCollectedFromBurnEvent{
            token_type    : arg5,
            coin_a_amount : 0x2::coin::value<T0>(&v3),
            coin_b_amount : 0x2::coin::value<T1>(&v2),
        };
        0x2::event::emit<FeesCollectedFromBurnEvent>(v4);
    }

    public fun collect_fees_from_burn_proof_swapped<T0, T1>(arg0: &AdminCap, arg1: &mut Manager<T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::collect_fee<T1, T0>(arg4, arg3, arg2, 0x2::table::borrow_mut<0x1::string::String, 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof>(&mut arg1.burn_proofs, arg5), arg6);
        let v2 = v1;
        let v3 = v0;
        if (!0x2::bag::contains<0x1::string::String>(&arg1.token_balances, arg5)) {
            0x2::bag::add<0x1::string::String, 0x2::balance::Balance<T0>>(&mut arg1.token_balances, arg5, 0x2::balance::zero<T0>());
        };
        0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::string::String, 0x2::balance::Balance<T0>>(&mut arg1.token_balances, arg5), 0x2::coin::into_balance<T0>(v2));
        0x2::balance::join<T1>(&mut arg1.fee_balance, 0x2::coin::into_balance<T1>(v3));
        let v4 = FeesCollectedFromBurnEvent{
            token_type    : arg5,
            coin_a_amount : 0x2::coin::value<T0>(&v2),
            coin_b_amount : 0x2::coin::value<T1>(&v3),
        };
        0x2::event::emit<FeesCollectedFromBurnEvent>(v4);
    }

    fun compare_coin_types(arg0: 0x1::string::String, arg1: 0x1::string::String) : bool {
        let v0 = 0x1::string::as_bytes(&arg0);
        let v1 = 0x1::string::as_bytes(&arg1);
        let v2 = 0x1::vector::length<u8>(v0);
        let v3 = 0x1::vector::length<u8>(v1);
        let v4 = if (v2 < v3) {
            v2
        } else {
            v3
        };
        let v5 = 0;
        while (v5 < v4) {
            let v6 = *0x1::vector::borrow<u8>(v0, v5);
            let v7 = *0x1::vector::borrow<u8>(v1, v5);
            if (v6 != v7) {
                return v6 > v7
            };
            v5 = v5 + 1;
        };
        v2 > v3
    }

    public fun create_manager<T0>(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Manager<T0>{
            id             : 0x2::object::new(arg1),
            tokens         : 0x1::vector::empty<0x1::string::String>(),
            user_tokens    : 0x2::table::new<address, vector<0x1::string::String>>(arg1),
            pools          : 0x2::table::new<0x1::string::String, 0x2::object::ID>(arg1),
            fee_balance    : 0x2::balance::zero<T0>(),
            positions      : 0x2::table::new<0x1::string::String, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg1),
            burn_proofs    : 0x2::table::new<0x1::string::String, 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::CetusLPBurnProof>(arg1),
            token_balances : 0x2::bag::new(arg1),
            creation_fee   : 0,
            fee_percentage : 0,
            liquidity_fee  : 0,
        };
        let v1 = ManagerCreatedEvent{
            manager_id     : 0x2::object::uid_to_inner(&v0.id),
            creation_fee   : 0,
            fee_percentage : 0,
            liquidity_fee  : 0,
        };
        0x2::event::emit<ManagerCreatedEvent>(v1);
        0x2::transfer::share_object<Manager<T0>>(v0);
    }

    public fun get_pool_id<T0>(arg0: &Manager<T0>, arg1: 0x1::string::String) : 0x2::object::ID {
        assert!(0x2::table::contains<0x1::string::String, 0x2::object::ID>(&arg0.pools, arg1), 2);
        *0x2::table::borrow<0x1::string::String, 0x2::object::ID>(&arg0.pools, arg1)
    }

    public fun get_token_balance<T0, T1>(arg0: &Manager<T1>, arg1: 0x1::string::String) : u64 {
        if (!0x2::bag::contains<0x1::string::String>(&arg0.token_balances, arg1)) {
            return 0
        };
        0x2::balance::value<T0>(0x2::bag::borrow<0x1::string::String, 0x2::balance::Balance<T0>>(&arg0.token_balances, arg1))
    }

    public fun get_total_fees<T0>(arg0: &Manager<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.fee_balance)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun set_creation_fee<T0>(arg0: &AdminCap, arg1: &mut Manager<T0>, arg2: u64) {
        arg1.creation_fee = arg2;
        let v0 = FeeConfigUpdatedEvent{
            creation_fee   : arg1.creation_fee,
            fee_percentage : arg1.fee_percentage,
            liquidity_fee  : arg1.liquidity_fee,
        };
        0x2::event::emit<FeeConfigUpdatedEvent>(v0);
    }

    public fun set_fee_percentage<T0>(arg0: &AdminCap, arg1: &mut Manager<T0>, arg2: u64) {
        arg1.fee_percentage = arg2;
        let v0 = FeeConfigUpdatedEvent{
            creation_fee   : arg1.creation_fee,
            fee_percentage : arg1.fee_percentage,
            liquidity_fee  : arg1.liquidity_fee,
        };
        0x2::event::emit<FeeConfigUpdatedEvent>(v0);
    }

    public fun set_liquidity_fee<T0>(arg0: &AdminCap, arg1: &mut Manager<T0>, arg2: u64) {
        arg1.liquidity_fee = arg2;
        let v0 = FeeConfigUpdatedEvent{
            creation_fee   : arg1.creation_fee,
            fee_percentage : arg1.fee_percentage,
            liquidity_fee  : arg1.liquidity_fee,
        };
        0x2::event::emit<FeeConfigUpdatedEvent>(v0);
    }

    fun sqrt(arg0: u256) : u128 {
        assert!(arg0 > 0, 1);
        let v0 = (arg0 + 1) / 2;
        while (v0 < arg0) {
            let v1 = v0 + arg0 / v0;
            v0 = v1 / 2;
        };
        (arg0 as u128)
    }

    public fun withdraw_token_balance<T0, T1>(arg0: &AdminCap, arg1: &mut Manager<T1>, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::bag::contains<0x1::string::String>(&arg1.token_balances, arg2), 6);
        let v0 = 0x2::bag::borrow_mut<0x1::string::String, 0x2::balance::Balance<T0>>(&mut arg1.token_balances, arg2);
        let v1 = 0x2::balance::value<T0>(v0);
        let v2 = TokenBalanceWithdrawnEvent{
            token_type : arg2,
            amount     : v1,
            recipient  : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<TokenBalanceWithdrawnEvent>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v0, v1), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

