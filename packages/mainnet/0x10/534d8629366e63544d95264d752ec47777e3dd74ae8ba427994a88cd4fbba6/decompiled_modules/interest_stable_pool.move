module 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::interest_stable_pool {
    struct State has copy, drop, store {
        pos0: u64,
    }

    struct InterestStablePool<phantom T0> has key {
        id: 0x2::object::UID,
        state: address,
    }

    public fun swap<T0, T1, T2>(arg0: &mut InterestStablePool<T2>, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::allowed_versions::AllowedVersions, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::interest_stable_pool_inner::swap<T0, T1>(state_mut<T2>(arg0), arg1, arg2, arg3, arg4, arg5)
    }

    fun a<T0>(arg0: &mut InterestStablePool<T0>, arg1: &0x2::clock::Clock) : u256 {
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::interest_stable_pool_inner::get_a(state<T0>(arg0), arg1)
    }

    public fun add_liquidity_2_pool<T0, T1, T2>(arg0: &mut InterestStablePool<T2>, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: &0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::allowed_versions::AllowedVersions, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::interest_stable_pool_inner::add_liquidity_2_pool<T0, T1, T2>(state_mut<T2>(arg0), arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public fun add_liquidity_3_pool<T0, T1, T2, T3>(arg0: &mut InterestStablePool<T3>, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: 0x2::coin::Coin<T2>, arg5: u64, arg6: &0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::allowed_versions::AllowedVersions, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T3> {
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::interest_stable_pool_inner::add_liquidity_3_pool<T0, T1, T2, T3>(state_mut<T3>(arg0), arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    public fun add_liquidity_4_pool<T0, T1, T2, T3, T4>(arg0: &mut InterestStablePool<T4>, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: 0x2::coin::Coin<T2>, arg5: 0x2::coin::Coin<T3>, arg6: u64, arg7: &0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::allowed_versions::AllowedVersions, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T4> {
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::interest_stable_pool_inner::add_liquidity_4_pool<T0, T1, T2, T3, T4>(state_mut<T4>(arg0), arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    public fun add_liquidity_5_pool<T0, T1, T2, T3, T4, T5>(arg0: &mut InterestStablePool<T5>, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: 0x2::coin::Coin<T2>, arg5: 0x2::coin::Coin<T3>, arg6: 0x2::coin::Coin<T4>, arg7: u64, arg8: &0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::allowed_versions::AllowedVersions, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T5> {
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::interest_stable_pool_inner::add_liquidity_5_pool<T0, T1, T2, T3, T4, T5>(state_mut<T5>(arg0), arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    }

    fun admin_balance<T0, T1>(arg0: &mut InterestStablePool<T1>) : u64 {
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::interest_stable_pool_inner::admin_balance<T0>(state<T1>(arg0))
    }

    public fun commit_fee<T0>(arg0: &mut InterestStablePool<T0>, arg1: &0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::acl::AuthWitness, arg2: 0x1::option::Option<u256>, arg3: 0x1::option::Option<u256>, arg4: &0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::allowed_versions::AllowedVersions, arg5: &mut 0x2::tx_context::TxContext) {
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::interest_stable_pool_inner::commit_fee(state_mut<T0>(arg0), arg1, arg2, arg3, arg4, arg5);
    }

    public fun new_2_pool<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::acl::AuthWitness, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: 0x2::coin::TreasuryCap<T2>, arg5: 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::coin_decimals::CoinDecimals, arg6: u256, arg7: &0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::allowed_versions::AllowedVersions, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        let v0 = 0x2::object::new(arg8);
        let (v1, v2) = 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::interest_stable_pool_inner::new_2_pool<T0, T1, T2>(arg0, arg2, arg3, arg4, arg5, arg6, 0x2::object::uid_to_address(&v0), arg7, arg8);
        let v3 = v1;
        let v4 = InterestStablePool<T2>{
            id    : v0,
            state : 0x2::object::id_address<0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::interest_stable_pool_inner::StateV1>(&v3),
        };
        let v5 = State{pos0: 1};
        0x2::dynamic_object_field::add<State, 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::interest_stable_pool_inner::StateV1>(&mut v4.id, v5, v3);
        0x2::transfer::share_object<InterestStablePool<T2>>(v4);
        v2
    }

    public fun new_3_pool<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: &0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::acl::AuthWitness, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: 0x2::coin::Coin<T2>, arg5: 0x2::coin::TreasuryCap<T3>, arg6: 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::coin_decimals::CoinDecimals, arg7: u256, arg8: &0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::allowed_versions::AllowedVersions, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T3> {
        let v0 = 0x2::object::new(arg9);
        let (v1, v2) = 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::interest_stable_pool_inner::new_3_pool<T0, T1, T2, T3>(arg0, arg2, arg3, arg4, arg5, arg6, arg7, 0x2::object::uid_to_address(&v0), arg8, arg9);
        let v3 = v1;
        let v4 = InterestStablePool<T3>{
            id    : v0,
            state : 0x2::object::id_address<0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::interest_stable_pool_inner::StateV1>(&v3),
        };
        let v5 = State{pos0: 1};
        0x2::dynamic_object_field::add<State, 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::interest_stable_pool_inner::StateV1>(&mut v4.id, v5, v3);
        0x2::transfer::share_object<InterestStablePool<T3>>(v4);
        v2
    }

    public fun new_4_pool<T0, T1, T2, T3, T4>(arg0: &0x2::clock::Clock, arg1: &0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::acl::AuthWitness, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: 0x2::coin::Coin<T2>, arg5: 0x2::coin::Coin<T3>, arg6: 0x2::coin::TreasuryCap<T4>, arg7: 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::coin_decimals::CoinDecimals, arg8: u256, arg9: &0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::allowed_versions::AllowedVersions, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T4> {
        let v0 = 0x2::object::new(arg10);
        let (v1, v2) = 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::interest_stable_pool_inner::new_4_pool<T0, T1, T2, T3, T4>(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, 0x2::object::uid_to_address(&v0), arg9, arg10);
        let v3 = v1;
        let v4 = InterestStablePool<T4>{
            id    : v0,
            state : 0x2::object::id_address<0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::interest_stable_pool_inner::StateV1>(&v3),
        };
        let v5 = State{pos0: 1};
        0x2::dynamic_object_field::add<State, 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::interest_stable_pool_inner::StateV1>(&mut v4.id, v5, v3);
        0x2::transfer::share_object<InterestStablePool<T4>>(v4);
        v2
    }

    public fun new_5_pool<T0, T1, T2, T3, T4, T5>(arg0: &0x2::clock::Clock, arg1: &0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::acl::AuthWitness, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: 0x2::coin::Coin<T2>, arg5: 0x2::coin::Coin<T3>, arg6: 0x2::coin::Coin<T4>, arg7: 0x2::coin::TreasuryCap<T5>, arg8: 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::coin_decimals::CoinDecimals, arg9: u256, arg10: &0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::allowed_versions::AllowedVersions, arg11: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T5> {
        let v0 = 0x2::object::new(arg11);
        let (v1, v2) = 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::interest_stable_pool_inner::new_5_pool<T0, T1, T2, T3, T4, T5>(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, 0x2::object::uid_to_address(&v0), arg10, arg11);
        let v3 = v1;
        let v4 = InterestStablePool<T5>{
            id    : v0,
            state : 0x2::object::id_address<0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::interest_stable_pool_inner::StateV1>(&v3),
        };
        let v5 = State{pos0: 1};
        0x2::dynamic_object_field::add<State, 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::interest_stable_pool_inner::StateV1>(&mut v4.id, v5, v3);
        0x2::transfer::share_object<InterestStablePool<T5>>(v4);
        v2
    }

    public fun pause<T0>(arg0: &mut InterestStablePool<T0>, arg1: &0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::acl::AuthWitness, arg2: &0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::allowed_versions::AllowedVersions, arg3: &mut 0x2::tx_context::TxContext) {
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::interest_stable_pool_inner::pause(state_mut<T0>(arg0), arg1, arg2, arg3);
    }

    public fun quote_add_liquidity<T0>(arg0: &mut InterestStablePool<T0>, arg1: &0x2::clock::Clock, arg2: vector<u64>) : u64 {
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::interest_stable_pool_inner::quote_add_liquidity<T0>(state<T0>(arg0), arg1, arg2)
    }

    public fun quote_remove_liquidity<T0>(arg0: &mut InterestStablePool<T0>, arg1: u64) : vector<u64> {
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::interest_stable_pool_inner::quote_remove_liquidity<T0>(state<T0>(arg0), arg1)
    }

    public fun quote_remove_liquidity_one_coin<T0, T1>(arg0: &mut InterestStablePool<T1>, arg1: &0x2::clock::Clock, arg2: u64) : (u64, u64) {
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::interest_stable_pool_inner::quote_remove_liquidity_one_coin<T0, T1>(state<T1>(arg0), arg1, arg2)
    }

    public fun quote_swap<T0, T1, T2>(arg0: &mut InterestStablePool<T2>, arg1: &0x2::clock::Clock, arg2: u64) : (u64, u64) {
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::interest_stable_pool_inner::quote_swap<T0, T1>(state<T2>(arg0), arg1, arg2)
    }

    public fun ramp<T0>(arg0: &mut InterestStablePool<T0>, arg1: &0x2::clock::Clock, arg2: &0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::acl::AuthWitness, arg3: u256, arg4: u256, arg5: &0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::allowed_versions::AllowedVersions, arg6: &mut 0x2::tx_context::TxContext) {
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::interest_stable_pool_inner::ramp(state_mut<T0>(arg0), arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public fun remove_liquidity_2_pool<T0, T1, T2>(arg0: &mut InterestStablePool<T2>, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T2>, arg3: vector<u64>, arg4: &0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::allowed_versions::AllowedVersions, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::interest_stable_pool_inner::remove_liquidity_2_pool<T0, T1, T2>(state_mut<T2>(arg0), arg1, arg2, arg3, arg4, arg5)
    }

    public fun remove_liquidity_3_pool<T0, T1, T2, T3>(arg0: &mut InterestStablePool<T3>, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T3>, arg3: vector<u64>, arg4: &0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::allowed_versions::AllowedVersions, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>) {
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::interest_stable_pool_inner::remove_liquidity_3_pool<T0, T1, T2, T3>(state_mut<T3>(arg0), arg1, arg2, arg3, arg4, arg5)
    }

    public fun remove_liquidity_4_pool<T0, T1, T2, T3, T4>(arg0: &mut InterestStablePool<T4>, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T4>, arg3: vector<u64>, arg4: &0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::allowed_versions::AllowedVersions, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>, 0x2::coin::Coin<T3>) {
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::interest_stable_pool_inner::remove_liquidity_4_pool<T0, T1, T2, T3, T4>(state_mut<T4>(arg0), arg1, arg2, arg3, arg4, arg5)
    }

    public fun remove_liquidity_5_pool<T0, T1, T2, T3, T4, T5>(arg0: &mut InterestStablePool<T5>, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T5>, arg3: vector<u64>, arg4: &0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::allowed_versions::AllowedVersions, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>, 0x2::coin::Coin<T3>, 0x2::coin::Coin<T4>) {
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::interest_stable_pool_inner::remove_liquidity_5_pool<T0, T1, T2, T3, T4, T5>(state_mut<T5>(arg0), arg1, arg2, arg3, arg4, arg5)
    }

    public fun remove_liquidity_one_coin<T0, T1>(arg0: &mut InterestStablePool<T1>, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::allowed_versions::AllowedVersions, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::interest_stable_pool_inner::remove_liquidity_one_coin<T0, T1>(state_mut<T1>(arg0), arg1, arg2, arg3, arg4, arg5)
    }

    fun state<T0>(arg0: &mut InterestStablePool<T0>) : &0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::interest_stable_pool_inner::StateV1 {
        let v0 = State{pos0: 1};
        0x2::dynamic_object_field::borrow<State, 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::interest_stable_pool_inner::StateV1>(&arg0.id, v0)
    }

    fun state_mut<T0>(arg0: &mut InterestStablePool<T0>) : &mut 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::interest_stable_pool_inner::StateV1 {
        let v0 = State{pos0: 1};
        0x2::dynamic_object_field::borrow_mut<State, 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::interest_stable_pool_inner::StateV1>(&mut arg0.id, v0)
    }

    public fun stop_ramp<T0>(arg0: &mut InterestStablePool<T0>, arg1: &0x2::clock::Clock, arg2: &0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::acl::AuthWitness, arg3: &0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::allowed_versions::AllowedVersions, arg4: &mut 0x2::tx_context::TxContext) {
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::interest_stable_pool_inner::stop_ramp(state_mut<T0>(arg0), arg1, arg2, arg3, arg4);
    }

    public fun take_fees<T0, T1>(arg0: &mut InterestStablePool<T1>, arg1: &0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::acl::AuthWitness, arg2: &0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::allowed_versions::AllowedVersions, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::interest_stable_pool_inner::take_fees<T0>(state_mut<T1>(arg0), arg1, arg2, arg3)
    }

    public fun unpause<T0>(arg0: &mut InterestStablePool<T0>, arg1: &0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::acl::AuthWitness, arg2: &0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::allowed_versions::AllowedVersions, arg3: &mut 0x2::tx_context::TxContext) {
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::interest_stable_pool_inner::unpause(state_mut<T0>(arg0), arg1, arg2, arg3);
    }

    public fun update_description<T0>(arg0: &mut InterestStablePool<T0>, arg1: &0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::acl::AuthWitness, arg2: &mut 0x2::coin::CoinMetadata<T0>, arg3: 0x1::string::String, arg4: &0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::allowed_versions::AllowedVersions, arg5: &mut 0x2::tx_context::TxContext) {
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::interest_stable_pool_inner::update_description<T0>(state_mut<T0>(arg0), arg2, arg1, arg3, arg4, arg5);
    }

    public fun update_fee<T0>(arg0: &mut InterestStablePool<T0>, arg1: &0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::acl::AuthWitness, arg2: &0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::allowed_versions::AllowedVersions, arg3: &mut 0x2::tx_context::TxContext) {
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::interest_stable_pool_inner::update_fee(state_mut<T0>(arg0), arg1, arg2, arg3);
    }

    public fun update_icon_url<T0>(arg0: &mut InterestStablePool<T0>, arg1: &0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::acl::AuthWitness, arg2: &mut 0x2::coin::CoinMetadata<T0>, arg3: 0x1::ascii::String, arg4: &0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::allowed_versions::AllowedVersions, arg5: &mut 0x2::tx_context::TxContext) {
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::interest_stable_pool_inner::update_icon_url<T0>(state_mut<T0>(arg0), arg2, arg1, arg3, arg4, arg5);
    }

    public fun update_name<T0>(arg0: &mut InterestStablePool<T0>, arg1: &0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::acl::AuthWitness, arg2: &mut 0x2::coin::CoinMetadata<T0>, arg3: 0x1::string::String, arg4: &0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::allowed_versions::AllowedVersions, arg5: &mut 0x2::tx_context::TxContext) {
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::interest_stable_pool_inner::update_name<T0>(state_mut<T0>(arg0), arg2, arg1, arg3, arg4, arg5);
    }

    public fun update_symbol<T0>(arg0: &mut InterestStablePool<T0>, arg1: &0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::acl::AuthWitness, arg2: &mut 0x2::coin::CoinMetadata<T0>, arg3: 0x1::ascii::String, arg4: &0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::allowed_versions::AllowedVersions, arg5: &mut 0x2::tx_context::TxContext) {
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::interest_stable_pool_inner::update_symbol<T0>(state_mut<T0>(arg0), arg2, arg1, arg3, arg4, arg5);
    }

    public fun virtual_price<T0>(arg0: &mut InterestStablePool<T0>, arg1: &0x2::clock::Clock) : u256 {
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::interest_stable_pool_inner::virtual_price<T0>(state<T0>(arg0), arg1)
    }

    // decompiled from Move bytecode v6
}

