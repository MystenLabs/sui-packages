module 0x385a98463c0ec72939a25ebb5baa140465bfffd27135977f2cee7349a998d03c::ebola {
    struct EBOLA has drop {
        dummy_field: bool,
    }

    struct PoolRegistry has store, key {
        id: 0x2::object::UID,
        pools: vector<address>,
    }

    struct LiquidityProviderCap has store, key {
        id: 0x2::object::UID,
        pool: 0x2::object::ID,
    }

    struct CommitHeader has copy, drop, store {
        version: u64,
        expires_at: u64,
        asks_root: vector<u8>,
        bids_root: vector<u8>,
        ask_ref_price: u64,
        bid_ref_price: u64,
        ref_price_step: u64,
        levels_len: u64,
    }

    struct RootsUpdatedEvent has copy, drop, store {
        pool_id: 0x2::object::ID,
        version: u64,
        expires_at: u64,
        asks_root: vector<u8>,
        bids_root: vector<u8>,
    }

    struct SwapWithProofEvent has copy, drop, store {
        pool_id: 0x2::object::ID,
        version: u64,
        x2y: bool,
        indices: vector<u64>,
        use_amounts: vector<u64>,
        in_amount: u64,
        out_amount: u64,
        fee_amount: u64,
    }

    struct CreatePoolEvent has copy, drop, store {
        pool_id: 0x2::object::ID,
        x: 0x1::type_name::TypeName,
        y: 0x1::type_name::TypeName,
        x_decimals: u8,
        y_decimals: u8,
        fee_millionth: u64,
    }

    struct Pool<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        stopped: bool,
        price_feeder: 0x2::vec_set::VecSet<address>,
        price_decimals: u8,
        x_decimals: u8,
        y_decimals: u8,
        fee_millionth: u64,
        reserve_x: 0x2::balance::Balance<T0>,
        reserve_y: 0x2::balance::Balance<T1>,
        fee_x: u64,
        fee_y: u64,
        fee_collector: address,
        commit: CommitHeader,
        consumed_asks: vector<u64>,
        consumed_bids: vector<u64>,
    }

    public fun add_price_feeders<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x2::package::Publisher, arg2: vector<address>) {
        assert!(0x2::package::from_module<EBOLA>(arg1), 13906835213725466623);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            0x2::vec_set::insert<address>(&mut arg0.price_feeder, *0x1::vector::borrow<address>(&arg2, v0));
            v0 = v0 + 1;
        };
    }

    public fun create_pool<T0, T1>(arg0: &0x2::package::Publisher, arg1: &mut PoolRegistry, arg2: u8, arg3: u8, arg4: u8, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : Pool<T0, T1> {
        assert!(0x2::package::from_module<EBOLA>(arg0), 13906834655379718143);
        assert!(arg5 < 1000000, 13906834659674685439);
        let v0 = 0x2::object::new(arg6);
        0x1::vector::push_back<address>(&mut arg1.pools, 0x2::object::uid_to_address(&v0));
        let v1 = CreatePoolEvent{
            pool_id       : *0x2::object::uid_as_inner(&v0),
            x             : 0x1::type_name::with_defining_ids<T0>(),
            y             : 0x1::type_name::with_defining_ids<T1>(),
            x_decimals    : arg3,
            y_decimals    : arg4,
            fee_millionth : arg5,
        };
        0x2::event::emit<CreatePoolEvent>(v1);
        let v2 = CommitHeader{
            version        : 0,
            expires_at     : 0,
            asks_root      : 0x1::vector::empty<u8>(),
            bids_root      : 0x1::vector::empty<u8>(),
            ask_ref_price  : 0,
            bid_ref_price  : 0,
            ref_price_step : 1,
            levels_len     : 0,
        };
        Pool<T0, T1>{
            id             : v0,
            stopped        : false,
            price_feeder   : 0x2::vec_set::empty<address>(),
            price_decimals : arg2,
            x_decimals     : arg3,
            y_decimals     : arg4,
            fee_millionth  : arg5,
            reserve_x      : 0x2::balance::zero<T0>(),
            reserve_y      : 0x2::balance::zero<T1>(),
            fee_x          : 0,
            fee_y          : 0,
            fee_collector  : 0x2::tx_context::sender(arg6),
            commit         : v2,
            consumed_asks  : 0x1::vector::empty<u64>(),
            consumed_bids  : 0x1::vector::empty<u64>(),
        }
    }

    public fun create_pool_shared<T0, T1>(arg0: &0x2::package::Publisher, arg1: &mut PoolRegistry, arg2: u8, arg3: u8, arg4: u8, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<Pool<T0, T1>>(create_pool<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6));
    }

    public fun deposit<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &LiquidityProviderCap, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>) {
        assert!(0x2::object::id<Pool<T0, T1>>(arg0) == arg1.pool, 13906835076286513151);
        if (0x2::balance::value<T0>(&arg2) == 0) {
            0x2::balance::destroy_zero<T0>(arg2);
        } else {
            0x2::balance::join<T0>(&mut arg0.reserve_x, arg2);
        };
        if (0x2::balance::value<T1>(&arg3) == 0) {
            0x2::balance::destroy_zero<T1>(arg3);
        } else {
            0x2::balance::join<T1>(&mut arg0.reserve_y, arg3);
        };
    }

    public fun deposit_external<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &LiquidityProviderCap, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>) {
        deposit<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(arg2), 0x2::coin::into_balance<T1>(arg3));
    }

    fun from_x_to_y_at_price<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64, arg2: u64) : u64 {
        (((arg1 as u128) * (arg2 as u128) * 0x1::u128::pow(10, arg0.y_decimals) / 0x1::u128::pow(10, arg0.x_decimals) / 0x1::u128::pow(10, arg0.price_decimals)) as u64)
    }

    fun from_y_to_x_at_price<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64, arg2: u64) : u64 {
        (((arg1 as u128) * 0x1::u128::pow(10, arg0.price_decimals) * 0x1::u128::pow(10, arg0.x_decimals) / 0x1::u128::pow(10, arg0.y_decimals) / (arg2 as u128)) as u64)
    }

    public fun grant_lp_cap<T0, T1>(arg0: &0x2::package::Publisher, arg1: &Pool<T0, T1>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_module<EBOLA>(arg0), 13906834960322396159);
        let v0 = LiquidityProviderCap{
            id   : 0x2::object::new(arg3),
            pool : 0x2::object::id<Pool<T0, T1>>(arg1),
        };
        0x2::transfer::transfer<LiquidityProviderCap>(v0, arg2);
    }

    fun init(arg0: EBOLA, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<EBOLA>(arg0, arg1);
        let v0 = PoolRegistry{
            id    : 0x2::object::new(arg1),
            pools : 0x1::vector::empty<address>(),
        };
        0x2::transfer::share_object<PoolRegistry>(v0);
    }

    fun join_bytes(arg0: &vector<u8>, arg1: &vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(arg0)) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, v1));
            v1 = v1 + 1;
        };
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(arg1)) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg1, v2));
            v2 = v2 + 1;
        };
        v0
    }

    public fun leaf_hash(arg0: u8, arg1: u64, arg2: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u8>(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg2));
        0x2::hash::blake2b256(&v0)
    }

    public fun rebuild_root_from_proof(arg0: vector<u8>, arg1: &vector<vector<u8>>, arg2: &vector<u8>) : vector<u8> {
        let v0 = arg0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(arg1)) {
            let v2 = if (*0x1::vector::borrow<u8>(arg2, v1) == 0) {
                join_bytes(&v0, 0x1::vector::borrow<vector<u8>>(arg1, v1))
            } else {
                join_bytes(0x1::vector::borrow<vector<u8>>(arg1, v1), &v0)
            };
            let v3 = v2;
            v0 = 0x2::hash::blake2b256(&v3);
            v1 = v1 + 1;
        };
        v0
    }

    public fun remove_price_feeders<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x2::package::Publisher, arg2: vector<address>) {
        assert!(0x2::package::from_module<EBOLA>(arg1), 13906835260970106879);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            let v1 = *0x1::vector::borrow<address>(&arg2, v0);
            0x2::vec_set::remove<address>(&mut arg0.price_feeder, &v1);
            v0 = v0 + 1;
        };
    }

    public fun stop<T0, T1>(arg0: &0x2::package::Publisher, arg1: &mut Pool<T0, T1>) {
        assert!(0x2::package::from_module<EBOLA>(arg0), 13906835295329845247);
        arg1.stopped = true;
    }

    public fun swap_x_to_y_with_proof<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: u64, arg3: vector<u64>, arg4: vector<u64>, arg5: vector<u64>, arg6: vector<vector<vector<u8>>>, arg7: vector<vector<u8>>, arg8: u64, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        assert!(!arg0.stopped, 1);
        assert!(arg9 == arg0.commit.version, 4);
        let v0 = 0x2::clock::timestamp_ms(arg11);
        assert!(v0 < arg10 && v0 < arg0.commit.expires_at, 3);
        let v1 = 0x1::vector::length<u64>(&arg3);
        assert!(v1 == 0x1::vector::length<u64>(&arg4) && v1 == 0x1::vector::length<u64>(&arg5), 13906836373366636543);
        assert!(v1 == 0x1::vector::length<vector<vector<u8>>>(&arg6) && v1 == 0x1::vector::length<vector<u8>>(&arg7), 13906836377661603839);
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        while (v4 < v1) {
            let v5 = *0x1::vector::borrow<u64>(&arg3, v4);
            assert!(v5 < arg0.commit.levels_len, 13906836403431407615);
            let v6 = *0x1::vector::borrow<u64>(&arg5, v4);
            let v7 = *0x1::vector::borrow<u64>(&arg4, v4);
            assert!(rebuild_root_from_proof(leaf_hash(1, v5, v6), 0x1::vector::borrow<vector<vector<u8>>>(&arg6, v4), 0x1::vector::borrow<vector<u8>>(&arg7, v4)) == arg0.commit.bids_root, 13906836433496178687);
            let v8 = v6 - *0x1::vector::borrow<u64>(&arg0.consumed_bids, v5);
            let v9 = if (v7 <= v8) {
                v7
            } else {
                v8
            };
            v2 = v2 + v9;
            v3 = v3 + from_x_to_y_at_price<T0, T1>(arg0, v9, arg0.commit.bid_ref_price - arg0.commit.ref_price_step * v5);
            let v10 = 0x1::vector::borrow_mut<u64>(&mut arg0.consumed_bids, v5);
            *v10 = *v10 + v9;
            v4 = v4 + 1;
        };
        assert!(arg2 >= v2, 13906836480740818943);
        let v11 = if (arg0.fee_millionth > 0) {
            let v12 = v3 * arg0.fee_millionth / 1000000;
            if (v12 == 0) {
                1
            } else {
                v12
            }
        } else {
            0
        };
        let v13 = v3 - v11;
        assert!(v13 >= arg8, 5);
        0x2::balance::join<T0>(&mut arg0.reserve_x, 0x2::balance::split<T0>(&mut arg1, v2));
        arg0.fee_y = arg0.fee_y + v11;
        let v14 = SwapWithProofEvent{
            pool_id     : 0x2::object::id<Pool<T0, T1>>(arg0),
            version     : arg9,
            x2y         : true,
            indices     : arg3,
            use_amounts : arg4,
            in_amount   : v2,
            out_amount  : v13,
            fee_amount  : v11,
        };
        0x2::event::emit<SwapWithProofEvent>(v14);
        (arg1, 0x2::balance::split<T1>(&mut arg0.reserve_y, v13))
    }

    public fun swap_x_to_y_with_proof_external<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: vector<u64>, arg4: vector<u64>, arg5: vector<u64>, arg6: vector<vector<vector<u8>>>, arg7: vector<vector<u8>>, arg8: u64, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = swap_x_to_y_with_proof<T0, T1>(arg0, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg1, arg2, arg12)), arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
        let v2 = v1;
        let v3 = v0;
        if (0x2::balance::value<T0>(&v3) == 0) {
            0x2::balance::destroy_zero<T0>(v3);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg12));
        } else {
            0x2::coin::join<T0>(&mut arg1, 0x2::coin::from_balance<T0>(v3, arg12));
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg12));
        };
        if (0x2::balance::value<T1>(&v2) == 0) {
            0x2::balance::destroy_zero<T1>(v2);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v2, arg12), 0x2::tx_context::sender(arg12));
        };
    }

    public fun swap_x_to_y_with_proof_for_aggregator<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: vector<u64>, arg4: vector<u64>, arg5: vector<u64>, arg6: vector<vector<vector<u8>>>, arg7: vector<vector<u8>>, arg8: u64, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1) = swap_x_to_y_with_proof<T0, T1>(arg0, 0x2::coin::into_balance<T0>(arg1), arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
        let v2 = v0;
        if (0x2::balance::value<T0>(&v2) == 0) {
            0x2::balance::destroy_zero<T0>(v2);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v2, arg12), 0x2::tx_context::sender(arg12));
        };
        0x2::coin::from_balance<T1>(v1, arg12)
    }

    public fun swap_y_to_x_with_proof<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: u64, arg3: vector<u64>, arg4: vector<u64>, arg5: vector<u64>, arg6: vector<vector<vector<u8>>>, arg7: vector<vector<u8>>, arg8: u64, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        assert!(!arg0.stopped, 1);
        assert!(arg9 == arg0.commit.version, 4);
        let v0 = 0x2::clock::timestamp_ms(arg11);
        assert!(v0 < arg10 && v0 < arg0.commit.expires_at, 3);
        let v1 = 0x1::vector::length<u64>(&arg3);
        assert!(v1 == 0x1::vector::length<u64>(&arg4) && v1 == 0x1::vector::length<u64>(&arg5), 13906836871582842879);
        assert!(v1 == 0x1::vector::length<vector<vector<u8>>>(&arg6) && v1 == 0x1::vector::length<vector<u8>>(&arg7), 13906836875877810175);
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        while (v4 < v1) {
            let v5 = *0x1::vector::borrow<u64>(&arg3, v4);
            assert!(v5 < arg0.commit.levels_len, 13906836901647613951);
            let v6 = *0x1::vector::borrow<u64>(&arg5, v4);
            let v7 = *0x1::vector::borrow<u64>(&arg4, v4);
            assert!(rebuild_root_from_proof(leaf_hash(0, v5, v6), 0x1::vector::borrow<vector<vector<u8>>>(&arg6, v4), 0x1::vector::borrow<vector<u8>>(&arg7, v4)) == arg0.commit.asks_root, 13906836931712385023);
            let v8 = v6 - *0x1::vector::borrow<u64>(&arg0.consumed_asks, v5);
            let v9 = if (v7 <= v8) {
                v7
            } else {
                v8
            };
            v2 = v2 + from_x_to_y_at_price<T0, T1>(arg0, v9, arg0.commit.ask_ref_price + arg0.commit.ref_price_step * v5);
            v3 = v3 + v9;
            let v10 = 0x1::vector::borrow_mut<u64>(&mut arg0.consumed_asks, v5);
            *v10 = *v10 + v9;
            v4 = v4 + 1;
        };
        let v11 = v2 + 1;
        assert!(arg2 >= v11, 13906836996136894463);
        let v12 = if (arg0.fee_millionth > 0) {
            let v13 = v3 * arg0.fee_millionth / 1000000;
            if (v13 == 0) {
                1
            } else {
                v13
            }
        } else {
            0
        };
        let v14 = v3 - v12;
        assert!(v14 >= arg8, 5);
        0x2::balance::join<T1>(&mut arg0.reserve_y, 0x2::balance::split<T1>(&mut arg1, v11));
        arg0.fee_x = arg0.fee_x + v12;
        let v15 = SwapWithProofEvent{
            pool_id     : 0x2::object::id<Pool<T0, T1>>(arg0),
            version     : arg9,
            x2y         : false,
            indices     : arg3,
            use_amounts : arg4,
            in_amount   : v11,
            out_amount  : v14,
            fee_amount  : v12,
        };
        0x2::event::emit<SwapWithProofEvent>(v15);
        (0x2::balance::split<T0>(&mut arg0.reserve_x, v14), arg1)
    }

    public fun swap_y_to_x_with_proof_external<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: vector<u64>, arg4: vector<u64>, arg5: vector<u64>, arg6: vector<vector<vector<u8>>>, arg7: vector<vector<u8>>, arg8: u64, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = swap_y_to_x_with_proof<T0, T1>(arg0, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg1, arg2, arg12)), arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
        let v2 = v1;
        let v3 = v0;
        if (0x2::balance::value<T1>(&v2) == 0) {
            0x2::balance::destroy_zero<T1>(v2);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg1, 0x2::tx_context::sender(arg12));
        } else {
            0x2::coin::join<T1>(&mut arg1, 0x2::coin::from_balance<T1>(v2, arg12));
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg1, 0x2::tx_context::sender(arg12));
        };
        if (0x2::balance::value<T0>(&v3) == 0) {
            0x2::balance::destroy_zero<T0>(v3);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v3, arg12), 0x2::tx_context::sender(arg12));
        };
    }

    public fun swap_y_to_x_with_proof_for_aggregator<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: vector<u64>, arg4: vector<u64>, arg5: vector<u64>, arg6: vector<vector<vector<u8>>>, arg7: vector<vector<u8>>, arg8: u64, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1) = swap_y_to_x_with_proof<T0, T1>(arg0, 0x2::coin::into_balance<T1>(arg1), arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
        let v2 = v1;
        if (0x2::balance::value<T1>(&v2) == 0) {
            0x2::balance::destroy_zero<T1>(v2);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v2, arg12), 0x2::tx_context::sender(arg12));
        };
        0x2::coin::from_balance<T0>(v0, arg12)
    }

    public fun unstop<T0, T1>(arg0: &0x2::package::Publisher, arg1: &mut Pool<T0, T1>) {
        assert!(0x2::package::from_module<EBOLA>(arg0), 13906835316804681727);
        arg1.stopped = false;
    }

    public fun update_fee_millionth<T0, T1>(arg0: &0x2::package::Publisher, arg1: &mut Pool<T0, T1>, arg2: u64) {
        assert!(0x2::package::from_module<EBOLA>(arg0), 13906835024746905599);
        assert!(arg1.fee_millionth != arg2, 13906835029041872895);
        arg1.fee_millionth = arg2;
    }

    public fun update_roots<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg9);
        assert!(0x2::vec_set::contains<address>(&arg0.price_feeder, &v0), 2);
        assert!(arg3 > arg0.commit.version, 13906835394114093055);
        let v1 = CommitHeader{
            version        : arg3,
            expires_at     : arg4,
            asks_root      : arg1,
            bids_root      : arg2,
            ask_ref_price  : arg5,
            bid_ref_price  : arg6,
            ref_price_step : arg7,
            levels_len     : arg8,
        };
        arg0.commit = v1;
        while (0x1::vector::length<u64>(&arg0.consumed_asks) > 0) {
            0x1::vector::pop_back<u64>(&mut arg0.consumed_asks);
        };
        while (0x1::vector::length<u64>(&arg0.consumed_bids) > 0) {
            0x1::vector::pop_back<u64>(&mut arg0.consumed_bids);
        };
        let v2 = 0;
        while (v2 < arg8) {
            0x1::vector::push_back<u64>(&mut arg0.consumed_asks, 0);
            v2 = v2 + 1;
        };
        let v3 = 0;
        while (v3 < arg8) {
            0x1::vector::push_back<u64>(&mut arg0.consumed_bids, 0);
            v3 = v3 + 1;
        };
        let v4 = RootsUpdatedEvent{
            pool_id    : 0x2::object::id<Pool<T0, T1>>(arg0),
            version    : arg3,
            expires_at : arg4,
            asks_root  : arg1,
            bids_root  : arg2,
        };
        0x2::event::emit<RootsUpdatedEvent>(v4);
    }

    public fun withdraw<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &LiquidityProviderCap, arg2: u64, arg3: u64) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        assert!(0x2::object::id<Pool<T0, T1>>(arg0) == arg1.pool, 13906835162185859071);
        let v0 = if (arg2 == 0) {
            0x2::balance::zero<T0>()
        } else {
            0x2::balance::split<T0>(&mut arg0.reserve_x, arg2)
        };
        let v1 = if (arg3 == 0) {
            0x2::balance::zero<T1>()
        } else {
            0x2::balance::split<T1>(&mut arg0.reserve_y, arg3)
        };
        (v0, v1)
    }

    // decompiled from Move bytecode v6
}

