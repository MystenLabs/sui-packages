module 0xb796d07fff819b75d1085514399130f0a94d039f76ceadb7a09153beee7f94a9::corona {
    struct CORONA has drop {
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
        expires_at: u64,
        asks_root: vector<u8>,
        bids_root: vector<u8>,
    }

    struct RootsUpdatedEvent has copy, drop, store {
        pool_id: 0x2::object::ID,
        expires_at: u64,
        asks_root: vector<u8>,
        bids_root: vector<u8>,
    }

    struct SwapWithProofEvent has copy, drop, store {
        pool_id: 0x2::object::ID,
        x2y: bool,
        in_amount: u64,
        out_amount: u64,
        fee_amount: u64,
        asks_root: vector<u8>,
        bids_root: vector<u8>,
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
        price_feeders: 0x2::vec_map::VecMap<address, vector<u8>>,
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
        used_asks: vector<u64>,
        used_bids: vector<u64>,
    }

    public fun add_price_feeder<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x2::package::Publisher, arg2: address, arg3: vector<u8>) {
        assert!(0x2::package::from_module<CORONA>(arg1), 13906835243790237695);
        0x2::vec_map::insert<address, vector<u8>>(&mut arg0.price_feeders, arg2, arg3);
    }

    public fun create_pool<T0, T1>(arg0: &0x2::package::Publisher, arg1: &mut PoolRegistry, arg2: u8, arg3: u8, arg4: u8, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : Pool<T0, T1> {
        assert!(0x2::package::from_module<CORONA>(arg0), 13906834668264620031);
        assert!(arg5 < 1000000, 13906834672559587327);
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
            expires_at : 0,
            asks_root  : 0x1::vector::empty<u8>(),
            bids_root  : 0x1::vector::empty<u8>(),
        };
        Pool<T0, T1>{
            id             : v0,
            stopped        : false,
            price_feeders  : 0x2::vec_map::empty<address, vector<u8>>(),
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
            used_asks      : 0x1::vector::empty<u64>(),
            used_bids      : 0x1::vector::empty<u64>(),
        }
    }

    public fun create_pool_shared<T0, T1>(arg0: &0x2::package::Publisher, arg1: &mut PoolRegistry, arg2: u8, arg3: u8, arg4: u8, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<Pool<T0, T1>>(create_pool<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6));
    }

    public fun deposit<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &LiquidityProviderCap, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>) {
        assert!(0x2::object::id<Pool<T0, T1>>(arg0) == arg1.pool, 13906835054811676671);
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
        assert!(0x2::package::from_module<CORONA>(arg0), 13906834943142526975);
        let v0 = LiquidityProviderCap{
            id   : 0x2::object::new(arg3),
            pool : 0x2::object::id<Pool<T0, T1>>(arg1),
        };
        0x2::transfer::transfer<LiquidityProviderCap>(v0, arg2);
    }

    fun init(arg0: CORONA, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<CORONA>(arg0, arg1);
        let v0 = PoolRegistry{
            id    : 0x2::object::new(arg1),
            pools : 0x1::vector::empty<address>(),
        };
        0x2::transfer::share_object<PoolRegistry>(v0);
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
                0xb796d07fff819b75d1085514399130f0a94d039f76ceadb7a09153beee7f94a9::utils::join_bytes(&v0, 0x1::vector::borrow<vector<u8>>(arg1, v1))
            } else {
                0xb796d07fff819b75d1085514399130f0a94d039f76ceadb7a09153beee7f94a9::utils::join_bytes(0x1::vector::borrow<vector<u8>>(arg1, v1), &v0)
            };
            let v3 = v2;
            v0 = 0x2::hash::blake2b256(&v3);
            v1 = v1 + 1;
        };
        v0
    }

    public fun remove_price_feeder<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x2::package::Publisher, arg2: address) {
        assert!(0x2::package::from_module<CORONA>(arg1), 13906835265265074175);
        let (_, _) = 0x2::vec_map::remove<address, vector<u8>>(&mut arg0.price_feeders, &arg2);
    }

    public fun stop<T0, T1>(arg0: &0x2::package::Publisher, arg1: &mut Pool<T0, T1>) {
        assert!(0x2::package::from_module<CORONA>(arg0), 13906835286739910655);
        arg1.stopped = true;
    }

    public fun swap_x_to_y_with_proof<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: u64, arg3: vector<u64>, arg4: vector<u64>, arg5: vector<vector<vector<u8>>>, arg6: vector<vector<u8>>, arg7: u64, arg8: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        assert!(!arg0.stopped, 1);
        let v0 = 0x2::clock::timestamp_ms(arg8);
        assert!(v0 < arg7 && v0 < arg0.commit.expires_at, 3);
        let v1 = 0x1::vector::length<u64>(&arg3);
        assert!(v1 == 0x1::vector::length<vector<vector<u8>>>(&arg5) && v1 == 0x1::vector::length<vector<u8>>(&arg6), 13906836339006898175);
        let v2 = arg2;
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        while (v5 < v1) {
            let v6 = *0x1::vector::borrow<u64>(&arg3, v5);
            let v7 = v6 - *0x1::vector::borrow<u64>(&arg0.used_bids, v5);
            let v8 = 0x1::u64::min(v2, v7);
            let v9 = *0x1::vector::borrow<u64>(&arg4, v5);
            assert!(rebuild_root_from_proof(leaf_hash(1, v9, v6), 0x1::vector::borrow<vector<vector<u8>>>(&arg5, v5), 0x1::vector::borrow<vector<u8>>(&arg6, v5)) == arg0.commit.bids_root, 13906836412021342207);
            v3 = v3 + v8;
            v4 = v4 + from_x_to_y_at_price<T0, T1>(arg0, v8, v9);
            v2 = v2 - v8;
            if (v2 == 0) {
                break
            };
            if (v5 + 1 < v1) {
                assert!(v8 == v7, 8);
            };
            v5 = v5 + 1;
            let v10 = 0x1::vector::borrow_mut<u64>(&mut arg0.used_bids, v5);
            *v10 = *v10 + v8;
        };
        let v11 = if (arg0.fee_millionth > 0) {
            let v12 = v4 * arg0.fee_millionth / 1000000;
            if (v12 == 0) {
                1
            } else {
                v12
            }
        } else {
            0
        };
        let v13 = v4 - v11;
        assert!(0x2::balance::value<T0>(&arg1) >= v3, 6);
        0x2::balance::join<T0>(&mut arg0.reserve_x, 0x2::balance::split<T0>(&mut arg1, v3));
        arg0.fee_y = arg0.fee_y + v11;
        let v14 = SwapWithProofEvent{
            pool_id    : 0x2::object::id<Pool<T0, T1>>(arg0),
            x2y        : true,
            in_amount  : v3,
            out_amount : v13,
            fee_amount : v11,
            asks_root  : arg0.commit.asks_root,
            bids_root  : arg0.commit.bids_root,
        };
        0x2::event::emit<SwapWithProofEvent>(v14);
        (arg1, 0x2::balance::split<T1>(&mut arg0.reserve_y, v13))
    }

    public fun swap_x_to_y_with_proof_external<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: vector<u64>, arg4: vector<u64>, arg5: vector<vector<vector<u8>>>, arg6: vector<vector<u8>>, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = swap_x_to_y_with_proof<T0, T1>(arg0, 0x2::coin::into_balance<T0>(arg1), arg2, arg3, arg4, arg5, arg6, arg8, arg9);
        let v2 = v1;
        let v3 = v0;
        assert!(arg7 <= 0x2::balance::value<T1>(&v2), 5);
        if (0x2::balance::value<T0>(&v3) == 0) {
            0x2::balance::destroy_zero<T0>(v3);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v3, arg10), 0x2::tx_context::sender(arg10));
        };
        if (0x2::balance::value<T1>(&v2) == 0) {
            0x2::balance::destroy_zero<T1>(v2);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v2, arg10), 0x2::tx_context::sender(arg10));
        };
    }

    public fun swap_x_to_y_with_proof_for_aggregator<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: vector<u64>, arg4: vector<u64>, arg5: vector<vector<vector<u8>>>, arg6: vector<vector<u8>>, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1) = swap_x_to_y_with_proof<T0, T1>(arg0, 0x2::coin::into_balance<T0>(arg1), arg2, arg3, arg4, arg5, arg6, arg8, arg9);
        let v2 = v1;
        let v3 = v0;
        assert!(arg7 <= 0x2::balance::value<T1>(&v2), 5);
        if (0x2::balance::value<T0>(&v3) == 0) {
            0x2::balance::destroy_zero<T0>(v3);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v3, arg10), 0x2::tx_context::sender(arg10));
        };
        0x2::coin::from_balance<T1>(v2, arg10)
    }

    public fun swap_y_to_x_with_proof<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: u64, arg3: vector<u64>, arg4: vector<u64>, arg5: vector<vector<vector<u8>>>, arg6: vector<vector<u8>>, arg7: u64, arg8: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        assert!(!arg0.stopped, 1);
        let v0 = 0x2::clock::timestamp_ms(arg8);
        assert!(v0 < arg7 && v0 < arg0.commit.expires_at, 3);
        let v1 = 0x1::vector::length<u64>(&arg3);
        assert!(v1 == 0x1::vector::length<vector<vector<u8>>>(&arg5) && v1 == 0x1::vector::length<vector<u8>>(&arg6), 13906836712669052927);
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        while (v4 < v1) {
            let v5 = *0x1::vector::borrow<u64>(&arg3, v4);
            let v6 = *0x1::vector::borrow<u64>(&arg4, v4);
            assert!(rebuild_root_from_proof(leaf_hash(0, v6, v5), 0x1::vector::borrow<vector<vector<u8>>>(&arg5, v4), 0x1::vector::borrow<vector<u8>>(&arg6, v4)) == arg0.commit.asks_root, 13906836777093562367);
            let v7 = 0x1::u64::min(from_x_to_y_at_price<T0, T1>(arg0, v5 - *0x1::vector::borrow<u64>(&arg0.used_asks, v4), v6), arg2);
            let v8 = from_y_to_x_at_price<T0, T1>(arg0, v7, v6);
            v2 = v2 + v7;
            v3 = v3 + v8;
            let v9 = 0x1::vector::borrow_mut<u64>(&mut arg0.used_asks, v4);
            *v9 = *v9 + v8;
            arg2 = arg2 - v7;
            v4 = v4 + 1;
        };
        let v10 = v2 + 1;
        if (v10 - 1 == 0x2::balance::value<T1>(&arg1)) {
        };
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
        0x2::balance::join<T1>(&mut arg0.reserve_y, 0x2::balance::split<T1>(&mut arg1, v10));
        arg0.fee_x = arg0.fee_x + v11;
        let v14 = SwapWithProofEvent{
            pool_id    : 0x2::object::id<Pool<T0, T1>>(arg0),
            x2y        : false,
            in_amount  : v10,
            out_amount : v13,
            fee_amount : v11,
            asks_root  : arg0.commit.asks_root,
            bids_root  : arg0.commit.bids_root,
        };
        0x2::event::emit<SwapWithProofEvent>(v14);
        (0x2::balance::split<T0>(&mut arg0.reserve_x, v13), arg1)
    }

    public fun swap_y_to_x_with_proof_external<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: vector<u64>, arg4: vector<u64>, arg5: vector<vector<vector<u8>>>, arg6: vector<vector<u8>>, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = swap_y_to_x_with_proof<T0, T1>(arg0, 0x2::coin::into_balance<T1>(arg1), arg2, arg3, arg4, arg5, arg6, arg8, arg9);
        let v2 = v1;
        let v3 = v0;
        assert!(arg7 <= 0x2::balance::value<T0>(&v3), 5);
        if (0x2::balance::value<T1>(&v2) == 0) {
            0x2::balance::destroy_zero<T1>(v2);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v2, arg10), 0x2::tx_context::sender(arg10));
        };
        if (0x2::balance::value<T0>(&v3) == 0) {
            0x2::balance::destroy_zero<T0>(v3);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v3, arg10), 0x2::tx_context::sender(arg10));
        };
    }

    public fun swap_y_to_x_with_proof_for_aggregator<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: vector<u64>, arg4: vector<u64>, arg5: vector<vector<vector<u8>>>, arg6: vector<vector<u8>>, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1) = swap_y_to_x_with_proof<T0, T1>(arg0, 0x2::coin::into_balance<T1>(arg1), arg2, arg3, arg4, arg5, arg6, arg8, arg9);
        let v2 = v1;
        let v3 = v0;
        assert!(arg7 <= 0x2::balance::value<T0>(&v3), 5);
        if (0x2::balance::value<T1>(&v2) == 0) {
            0x2::balance::destroy_zero<T1>(v2);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v2, arg10), 0x2::tx_context::sender(arg10));
        };
        0x2::coin::from_balance<T0>(v3, arg10)
    }

    public fun unstop<T0, T1>(arg0: &0x2::package::Publisher, arg1: &mut Pool<T0, T1>) {
        assert!(0x2::package::from_module<CORONA>(arg0), 13906835308214747135);
        arg1.stopped = false;
    }

    public fun update_fee_millionth<T0, T1>(arg0: &0x2::package::Publisher, arg1: &mut Pool<T0, T1>, arg2: u64) {
        assert!(0x2::package::from_module<CORONA>(arg0), 13906835007567036415);
        assert!(arg1.fee_millionth != arg2, 13906835011862003711);
        arg1.fee_millionth = arg2;
    }

    fun update_root_internal<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: vector<u8>, arg2: vector<u8>, arg3: u64) {
        let v0 = CommitHeader{
            expires_at : arg3,
            asks_root  : arg1,
            bids_root  : arg2,
        };
        arg0.commit = v0;
        let v1 = RootsUpdatedEvent{
            pool_id    : 0x2::object::id<Pool<T0, T1>>(arg0),
            expires_at : arg3,
            asks_root  : arg1,
            bids_root  : arg2,
        };
        0x2::event::emit<RootsUpdatedEvent>(v1);
    }

    public fun update_roots<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::vec_map::contains<address, vector<u8>>(&arg0.price_feeders, &v0), 2);
        update_root_internal<T0, T1>(arg0, arg1, arg2, arg3);
    }

    fun validate_commit_by_signature(arg0: &vector<u8>, arg1: &vector<u8>, arg2: &vector<u8>, arg3: u64, arg4: &vector<u8>, arg5: u64) : bool {
        assert!(arg5 < arg3, 13906836622474739711);
        let v0 = 0xb796d07fff819b75d1085514399130f0a94d039f76ceadb7a09153beee7f94a9::utils::join_bytes(arg1, arg2);
        let v1 = 0x1::bcs::to_bytes<u64>(&arg3);
        let v2 = 0xb796d07fff819b75d1085514399130f0a94d039f76ceadb7a09153beee7f94a9::utils::join_bytes(&v0, &v1);
        0x2::ed25519::ed25519_verify(arg4, arg0, &v2)
    }

    public fun withdraw<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &LiquidityProviderCap, arg2: u64, arg3: u64) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        assert!(0x2::object::id<Pool<T0, T1>>(arg0) == arg1.pool, 13906835136416055295);
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

    public fun withdraw_external<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &LiquidityProviderCap, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = withdraw<T0, T1>(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v0, arg4), 0x2::tx_context::sender(arg4));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v1, arg4), 0x2::tx_context::sender(arg4));
    }

    // decompiled from Move bytecode v6
}

