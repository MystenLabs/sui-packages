module 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::interest_stable_pool_inner {
    struct TreasuryCapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct BalanceKey has copy, drop, store {
        pos0: 0x1::type_name::TypeName,
    }

    struct AdminBalanceKey has copy, drop, store {
        pos0: 0x1::type_name::TypeName,
    }

    struct Metadata has copy, drop, store {
        scalar: u256,
        index: u64,
    }

    struct StateV1 has store, key {
        id: 0x2::object::UID,
        pool: address,
        coins: vector<0x1::type_name::TypeName>,
        balances: vector<u256>,
        initial_a: u256,
        future_a: u256,
        initial_a_time: u256,
        future_a_time: u256,
        n_coins: u64,
        fees: 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::fees::StableFees,
        metadata_map: 0x2::vec_map::VecMap<0x1::type_name::TypeName, Metadata>,
        paused: bool,
    }

    public(friend) fun swap<T0, T1>(arg0: &mut StateV1, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::allowed_versions::AllowedVersions, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::allowed_versions::assert_pkg_version(arg4);
        assert_is_live(arg0);
        assert!(0x1::type_name::get<T0>() != 0x1::type_name::get<T1>(), 20);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 != 0, 21);
        let v1 = 0x1::type_name::get<T1>();
        let v2 = 0x1::type_name::get<T0>();
        let v3 = *0x2::vec_map::get<0x1::type_name::TypeName, Metadata>(&arg0.metadata_map, &v2);
        let v4 = *0x2::vec_map::get<0x1::type_name::TypeName, Metadata>(&arg0.metadata_map, &v1);
        let v5 = 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::uint_convert::to_u256(v0) * 1000000000000000000 / v3.scalar;
        let v6 = a(arg0, arg1);
        let v7 = *0x1::vector::borrow<u256>(&arg0.balances, v4.index) - 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::curve_invariant::y(v6, 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::uint_convert::to_u256(v3.index), 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::uint_convert::to_u256(v4.index), *0x1::vector::borrow<u256>(&arg0.balances, v3.index) + v5, arg0.balances);
        let v8 = 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::fees::calculate_fee(&arg0.fees, v7);
        let v9 = 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::fees::calculate_admin_fee(&arg0.fees, v8);
        let v10 = 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::uint_convert::to_u64((v7 - v8) * v4.scalar / 1000000000000000000);
        assert!(0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::uint_convert::to_u64(v7 * v4.scalar / 1000000000000000000) > v10 || v8 == 0, 22);
        assert!(v10 >= arg3, 19);
        let v11 = 0x1::vector::borrow_mut<u256>(&mut arg0.balances, v3.index);
        *v11 = *v11 + v5;
        let v12 = 0x1::vector::borrow_mut<u256>(&mut arg0.balances, v4.index);
        *v12 = *v12 - v7 - v8 + v9;
        assert!(0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::curve_invariant::d(v6, arg0.balances) >= 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::curve_invariant::d(v6, arg0.balances), 17);
        let v13 = &mut arg0.id;
        0x2::balance::join<T0>(coin_state_balance_mut<T0>(v13), 0x2::coin::into_balance<T0>(arg2));
        let v14 = &mut arg0.id;
        let v15 = coin_state_balance_mut<T1>(v14);
        let v16 = &mut arg0.id;
        0x2::balance::join<T1>(admin_balance_mut<T1>(v16), 0x2::balance::split<T1>(v15, 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::uint_convert::to_u64(v9 * v4.scalar / 1000000000000000000)));
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::events::swap(arg0.pool, v2, v1, v0, v10, 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::uint_convert::to_u64(v8 * v4.scalar / 1000000000000000000), arg0.balances);
        0x2::coin::take<T1>(v15, v10, arg5)
    }

    public(friend) fun update_description<T0>(arg0: &mut StateV1, arg1: &mut 0x2::coin::CoinMetadata<T0>, arg2: &0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::acl::AuthWitness, arg3: 0x1::string::String, arg4: &0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::allowed_versions::AllowedVersions, arg5: &mut 0x2::tx_context::TxContext) {
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::allowed_versions::assert_pkg_version(arg4);
        0x2::coin::update_description<T0>(lp_coin_treasury_cap_mut<T0>(arg0), arg1, arg3);
    }

    public(friend) fun update_icon_url<T0>(arg0: &mut StateV1, arg1: &mut 0x2::coin::CoinMetadata<T0>, arg2: &0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::acl::AuthWitness, arg3: 0x1::ascii::String, arg4: &0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::allowed_versions::AllowedVersions, arg5: &mut 0x2::tx_context::TxContext) {
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::allowed_versions::assert_pkg_version(arg4);
        0x2::coin::update_icon_url<T0>(lp_coin_treasury_cap_mut<T0>(arg0), arg1, arg3);
    }

    public(friend) fun update_name<T0>(arg0: &mut StateV1, arg1: &mut 0x2::coin::CoinMetadata<T0>, arg2: &0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::acl::AuthWitness, arg3: 0x1::string::String, arg4: &0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::allowed_versions::AllowedVersions, arg5: &mut 0x2::tx_context::TxContext) {
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::allowed_versions::assert_pkg_version(arg4);
        0x2::coin::update_name<T0>(lp_coin_treasury_cap_mut<T0>(arg0), arg1, arg3);
    }

    public(friend) fun update_symbol<T0>(arg0: &mut StateV1, arg1: &mut 0x2::coin::CoinMetadata<T0>, arg2: &0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::acl::AuthWitness, arg3: 0x1::ascii::String, arg4: &0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::allowed_versions::AllowedVersions, arg5: &mut 0x2::tx_context::TxContext) {
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::allowed_versions::assert_pkg_version(arg4);
        0x2::coin::update_symbol<T0>(lp_coin_treasury_cap_mut<T0>(arg0), arg1, arg3);
    }

    fun a(arg0: &StateV1, arg1: &0x2::clock::Clock) : u256 {
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::curve_invariant::a(arg0.initial_a, arg0.initial_a_time, arg0.future_a, arg0.future_a_time, arg1)
    }

    public(friend) fun pause(arg0: &mut StateV1, arg1: &0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::acl::AuthWitness, arg2: &0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::allowed_versions::AllowedVersions, arg3: &0x2::tx_context::TxContext) {
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::allowed_versions::assert_pkg_version(arg2);
        arg0.paused = true;
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::events::pause(arg0.pool);
    }

    public(friend) fun remove_liquidity_one_coin<T0, T1>(arg0: &mut StateV1, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::allowed_versions::AllowedVersions, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::allowed_versions::assert_pkg_version(arg4);
        assert_is_live(arg0);
        let v0 = 0x2::coin::value<T1>(&arg2);
        assert!(v0 != 0, 23);
        let v1 = a(arg0, arg1);
        let v2 = virtual_price_impl<T1>(arg0, v1);
        let (v3, v4, v5, v6) = calculate_withdraw_one_coin<T0, T1>(arg0, v1, 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::curve_invariant::d(v1, arg0.balances), v0);
        *0x1::vector::borrow_mut<u256>(&mut arg0.balances, v6) = *0x1::vector::borrow<u256>(&arg0.balances, v6) - v5;
        assert!(v3 >= arg3, 19);
        let v7 = lp_coin_treasury_cap_mut<T1>(arg0);
        0x2::coin::burn<T1>(v7, arg2);
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::events::remove_liquidity_one_coin(arg0.pool, 0x1::type_name::get<T0>(), v0, v3, v4, arg0.balances);
        let v8 = &mut arg0.id;
        assert!(virtual_price_impl<T1>(arg0, v1) >= v2 || 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::uint_convert::to_u256(0x2::coin::total_supply<T1>(lp_coin_treasury_cap<T1>(arg0))) == 0, 17);
        0x2::coin::take<T0>(coin_state_balance_mut<T0>(v8), v3, arg5)
    }

    public(friend) fun take_fees<T0>(arg0: &mut StateV1, arg1: &0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::acl::AuthWitness, arg2: &0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::allowed_versions::AllowedVersions, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::allowed_versions::assert_pkg_version(arg2);
        let v0 = &mut arg0.id;
        let v1 = admin_balance_mut<T0>(v0);
        let v2 = 0x2::balance::value<T0>(v1);
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::events::take_fees(arg0.pool, 0x1::type_name::get<T0>(), v2);
        let v3 = 0x2::coin::take<T0>(v1, v2, arg3);
        let v4 = &mut arg0.id;
        0x2::coin::join<T0>(&mut v3, 0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(coin_state_balance_mut<T0>(v4)), arg3));
        v3
    }

    public(friend) fun unpause(arg0: &mut StateV1, arg1: &0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::acl::AuthWitness, arg2: &0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::allowed_versions::AllowedVersions, arg3: &0x2::tx_context::TxContext) {
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::allowed_versions::assert_pkg_version(arg2);
        arg0.paused = false;
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::events::unpause(arg0.pool);
    }

    public(friend) fun commit_fee(arg0: &mut StateV1, arg1: &0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::acl::AuthWitness, arg2: 0x1::option::Option<u256>, arg3: 0x1::option::Option<u256>, arg4: &0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::allowed_versions::AllowedVersions, arg5: &0x2::tx_context::TxContext) {
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::allowed_versions::assert_pkg_version(arg4);
        assert!(0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::fees::deadline(&arg0.fees) == 18446744073709551615, 26);
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::fees::commit_fee(&mut arg0.fees, arg2, arg5);
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::fees::commit_admin_fee(&mut arg0.fees, arg3, arg5);
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::events::commit_stable_fee(arg0.pool, 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::fees::future_fee(&arg0.fees), 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::fees::future_admin_fee(&arg0.fees));
    }

    public(friend) fun update_fee(arg0: &mut StateV1, arg1: &0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::acl::AuthWitness, arg2: &0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::allowed_versions::AllowedVersions, arg3: &0x2::tx_context::TxContext) {
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::allowed_versions::assert_pkg_version(arg2);
        assert!(0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::fees::deadline(&arg0.fees) != 0, 27);
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::fees::update_fee(&mut arg0.fees, arg3);
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::fees::update_admin_fee(&mut arg0.fees, arg3);
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::fees::reset_deadline(&mut arg0.fees);
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::events::update_stable_fee(arg0.pool, 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::fees::fee(&arg0.fees), 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::fees::admin_fee(&arg0.fees));
    }

    fun add_coin<T0>(arg0: &mut StateV1, arg1: &0x2::vec_map::VecMap<0x1::type_name::TypeName, u8>, arg2: u64) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = &mut arg0.id;
        register_balances<T0>(v1, v0);
        let v2 = Metadata{
            scalar : 0x1::u256::pow(10, *0x2::vec_map::get<0x1::type_name::TypeName, u8>(arg1, &v0)),
            index  : arg2,
        };
        0x2::vec_map::insert<0x1::type_name::TypeName, Metadata>(&mut arg0.metadata_map, v0, v2);
    }

    public(friend) fun add_liquidity_2_pool<T0, T1, T2>(arg0: &mut StateV1, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: &0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::allowed_versions::AllowedVersions, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::allowed_versions::assert_pkg_version(arg5);
        add_liquidity_2_pool_impl<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg6)
    }

    fun add_liquidity_2_pool_impl<T0, T1, T2>(arg0: &mut StateV1, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        assert_is_live(arg0);
        let v0 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T0>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T1>());
        assert_are_coins_ordered(arg0, v0);
        let v2 = a(arg0, arg1);
        let v3 = virtual_price_impl<T2>(arg0, v2);
        let v4 = 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::curve_invariant::d(v2, arg0.balances);
        let v5 = arg0.balances;
        let v6 = deposit_coin<T0>(arg0, arg2);
        let v7 = deposit_coin<T1>(arg0, arg3);
        let v8 = 0x1::vector::empty<u64>();
        let v9 = &mut v8;
        0x1::vector::push_back<u64>(v9, v6);
        0x1::vector::push_back<u64>(v9, v7);
        let v10 = calculate_mint_amount<T2>(arg0, v2, v4, v5, arg4);
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::events::add_liquidity(arg0.pool, arg0.coins, v8, v5, arg0.balances, v10);
        let v11 = lp_coin_treasury_cap_mut<T2>(arg0);
        assert!(virtual_price_impl<T2>(arg0, v2) >= v3, 17);
        0x2::coin::mint<T2>(v11, v10, arg5)
    }

    public(friend) fun add_liquidity_3_pool<T0, T1, T2, T3>(arg0: &mut StateV1, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: 0x2::coin::Coin<T2>, arg5: u64, arg6: &0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::allowed_versions::AllowedVersions, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T3> {
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::allowed_versions::assert_pkg_version(arg6);
        add_liquidity_3_pool_impl<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg7)
    }

    fun add_liquidity_3_pool_impl<T0, T1, T2, T3>(arg0: &mut StateV1, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: 0x2::coin::Coin<T2>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T3> {
        assert_is_live(arg0);
        let v0 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T0>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T1>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T2>());
        assert_are_coins_ordered(arg0, v0);
        let v2 = a(arg0, arg1);
        let v3 = virtual_price_impl<T3>(arg0, v2);
        let v4 = 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::curve_invariant::d(v2, arg0.balances);
        let v5 = arg0.balances;
        let v6 = deposit_coin<T0>(arg0, arg2);
        let v7 = deposit_coin<T1>(arg0, arg3);
        let v8 = deposit_coin<T2>(arg0, arg4);
        let v9 = 0x1::vector::empty<u64>();
        let v10 = &mut v9;
        0x1::vector::push_back<u64>(v10, v6);
        0x1::vector::push_back<u64>(v10, v7);
        0x1::vector::push_back<u64>(v10, v8);
        let v11 = calculate_mint_amount<T3>(arg0, v2, v4, v5, arg5);
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::events::add_liquidity(arg0.pool, arg0.coins, v9, v5, arg0.balances, v11);
        let v12 = lp_coin_treasury_cap_mut<T3>(arg0);
        assert!(virtual_price_impl<T3>(arg0, v2) >= v3, 17);
        0x2::coin::mint<T3>(v12, v11, arg6)
    }

    public(friend) fun add_liquidity_4_pool<T0, T1, T2, T3, T4>(arg0: &mut StateV1, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: 0x2::coin::Coin<T2>, arg5: 0x2::coin::Coin<T3>, arg6: u64, arg7: &0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::allowed_versions::AllowedVersions, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T4> {
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::allowed_versions::assert_pkg_version(arg7);
        add_liquidity_4_pool_impl<T0, T1, T2, T3, T4>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg8)
    }

    fun add_liquidity_4_pool_impl<T0, T1, T2, T3, T4>(arg0: &mut StateV1, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: 0x2::coin::Coin<T2>, arg5: 0x2::coin::Coin<T3>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T4> {
        assert_is_live(arg0);
        let v0 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T0>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T1>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T2>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T3>());
        assert_are_coins_ordered(arg0, v0);
        let v2 = a(arg0, arg1);
        let v3 = virtual_price_impl<T4>(arg0, v2);
        let v4 = 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::curve_invariant::d(v2, arg0.balances);
        let v5 = arg0.balances;
        let v6 = deposit_coin<T0>(arg0, arg2);
        let v7 = deposit_coin<T1>(arg0, arg3);
        let v8 = deposit_coin<T2>(arg0, arg4);
        let v9 = deposit_coin<T3>(arg0, arg5);
        let v10 = 0x1::vector::empty<u64>();
        let v11 = &mut v10;
        0x1::vector::push_back<u64>(v11, v6);
        0x1::vector::push_back<u64>(v11, v7);
        0x1::vector::push_back<u64>(v11, v8);
        0x1::vector::push_back<u64>(v11, v9);
        let v12 = calculate_mint_amount<T4>(arg0, v2, v4, v5, arg6);
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::events::add_liquidity(arg0.pool, arg0.coins, v10, v5, arg0.balances, v12);
        let v13 = lp_coin_treasury_cap_mut<T4>(arg0);
        assert!(virtual_price_impl<T4>(arg0, v2) >= v3, 17);
        0x2::coin::mint<T4>(v13, v12, arg7)
    }

    public(friend) fun add_liquidity_5_pool<T0, T1, T2, T3, T4, T5>(arg0: &mut StateV1, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: 0x2::coin::Coin<T2>, arg5: 0x2::coin::Coin<T3>, arg6: 0x2::coin::Coin<T4>, arg7: u64, arg8: &0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::allowed_versions::AllowedVersions, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T5> {
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::allowed_versions::assert_pkg_version(arg8);
        add_liquidity_5_pool_impl<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg9)
    }

    fun add_liquidity_5_pool_impl<T0, T1, T2, T3, T4, T5>(arg0: &mut StateV1, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: 0x2::coin::Coin<T2>, arg5: 0x2::coin::Coin<T3>, arg6: 0x2::coin::Coin<T4>, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T5> {
        assert_is_live(arg0);
        let v0 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T0>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T1>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T2>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T3>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T4>());
        assert_are_coins_ordered(arg0, v0);
        let v2 = a(arg0, arg1);
        let v3 = virtual_price_impl<T5>(arg0, v2);
        let v4 = 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::curve_invariant::d(v2, arg0.balances);
        let v5 = arg0.balances;
        let v6 = deposit_coin<T0>(arg0, arg2);
        let v7 = deposit_coin<T1>(arg0, arg3);
        let v8 = deposit_coin<T2>(arg0, arg4);
        let v9 = deposit_coin<T3>(arg0, arg5);
        let v10 = deposit_coin<T4>(arg0, arg6);
        let v11 = 0x1::vector::empty<u64>();
        let v12 = &mut v11;
        0x1::vector::push_back<u64>(v12, v6);
        0x1::vector::push_back<u64>(v12, v7);
        0x1::vector::push_back<u64>(v12, v8);
        0x1::vector::push_back<u64>(v12, v9);
        0x1::vector::push_back<u64>(v12, v10);
        let v13 = calculate_mint_amount<T5>(arg0, v2, v4, v5, arg7);
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::events::add_liquidity(arg0.pool, arg0.coins, v11, v5, arg0.balances, v13);
        let v14 = lp_coin_treasury_cap_mut<T5>(arg0);
        assert!(virtual_price_impl<T5>(arg0, v2) >= v3, 17);
        0x2::coin::mint<T5>(v14, v13, arg8)
    }

    public(friend) fun admin_balance<T0>(arg0: &StateV1) : u64 {
        let v0 = AdminBalanceKey{pos0: 0x1::type_name::get<T0>()};
        0x2::balance::value<T0>(0x2::dynamic_field::borrow<AdminBalanceKey, 0x2::balance::Balance<T0>>(&arg0.id, v0))
    }

    fun admin_balance_mut<T0>(arg0: &mut 0x2::object::UID) : &mut 0x2::balance::Balance<T0> {
        let v0 = AdminBalanceKey{pos0: 0x1::type_name::get<T0>()};
        0x2::dynamic_field::borrow_mut<AdminBalanceKey, 0x2::balance::Balance<T0>>(arg0, v0)
    }

    fun assert_are_coins_ordered(arg0: &StateV1, arg1: vector<0x1::type_name::TypeName>) {
        let v0 = &arg0.coins;
        let v1 = 0;
        let v2 = 0;
        let v3;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(v0)) {
            let v4 = *0x1::vector::borrow<0x1::type_name::TypeName>(&arg1, v1);
            if (!(0x1::vector::borrow<0x1::type_name::TypeName>(v0, v2) == &v4)) {
                v3 = false;
                /* label 6 */
                assert!(v3, 15);
                return
            };
            v1 = v1 + 1;
            v2 = v2 + 1;
        };
        v3 = true;
        /* goto 6 */
    }

    fun assert_is_live(arg0: &StateV1) {
        assert!(!arg0.paused, 16);
    }

    fun calculate_mint_amount<T0>(arg0: &StateV1, arg1: u256, arg2: u256, arg3: vector<u256>, arg4: u64) : u64 {
        let v0 = 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::curve_invariant::d(arg1, arg0.balances);
        assert!(v0 > arg2, 17);
        let v1 = 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::uint_convert::to_u256(0x2::coin::total_supply<T0>(lp_coin_treasury_cap<T0>(arg0)));
        let v2 = if (v1 == 0) {
            0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::uint_convert::to_u64(v0 / 1000000000)
        } else {
            let v3 = 0;
            let v4 = arg0.balances;
            while (arg0.n_coins > v3) {
                let v5 = 0x1::vector::borrow_mut<u256>(&mut v4, v3);
                *v5 = *v5 - imbalanced_fee(arg0) * 0x1::u256::diff(v0 * *0x1::vector::borrow<u256>(&arg3, v3) / arg2, *0x1::vector::borrow<u256>(&arg0.balances, v3)) / 1000000000000000000;
                v3 = v3 + 1;
            };
            let v6 = 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::curve_invariant::d(arg1, v4);
            assert!(v6 > arg2, 17);
            0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::uint_convert::to_u64(v1 * (v6 - arg2) / arg2)
        };
        assert!(v2 >= arg4, 19);
        v2
    }

    fun calculate_withdraw_one_coin<T0, T1>(arg0: &StateV1, arg1: u256, arg2: u256, arg3: u64) : (u64, u64, u256, u64) {
        let v0 = 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::uint_convert::to_u256(0x2::coin::total_supply<T1>(lp_coin_treasury_cap<T1>(arg0)));
        let v1 = arg2 - 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::uint_convert::to_u256(arg3) * arg2 / v0;
        let v2 = 0x1::type_name::get<T0>();
        let v3 = *0x2::vec_map::get<0x1::type_name::TypeName, Metadata>(&arg0.metadata_map, &v2);
        let v4 = arg0.balances;
        let v5 = *0x1::vector::borrow<u256>(&arg0.balances, v3.index);
        let v6 = 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::curve_invariant::y_lp(arg1, 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::uint_convert::to_u256(v3.index), arg0.balances, 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::uint_convert::to_u256(arg3), v0) + 1;
        let v7 = 0;
        while (arg0.n_coins > v7) {
            let v8 = if (v7 == v3.index) {
                *0x1::vector::borrow<u256>(&arg0.balances, v7) * v1 / arg2 - v6
            } else {
                *0x1::vector::borrow<u256>(&arg0.balances, v7) - *0x1::vector::borrow<u256>(&arg0.balances, v7) * v1 / arg2
            };
            *0x1::vector::borrow_mut<u256>(&mut v4, v7) = *0x1::vector::borrow<u256>(&v4, v7) - 0x7853a6de8198d75894e4376bdd8c6349dda7446345de6454feb6fab6ed26ef91::u256::mul_div_up(imbalanced_fee(arg0), v8, 1000000000000000000);
            v7 = v7 + 1;
        };
        let v9 = *0x1::vector::borrow<u256>(&v4, v3.index) - 0x1::u256::min(*0x1::vector::borrow<u256>(&v4, v3.index), 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::curve_invariant::y_d(arg1, 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::uint_convert::to_u256(v3.index), v4, v1));
        let v10 = v5 - 0x1::u256::min(v5, v6) - v9;
        (0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::uint_convert::to_u64(v9 * v3.scalar / 1000000000000000000), 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::uint_convert::to_u64(v10 * v3.scalar / 1000000000000000000), v9 + v10 * 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::fees::admin_fee(&arg0.fees) / 1000000000000000000, v3.index)
    }

    fun coin_state_balance_mut<T0>(arg0: &mut 0x2::object::UID) : &mut 0x2::balance::Balance<T0> {
        let v0 = BalanceKey{pos0: 0x1::type_name::get<T0>()};
        0x2::dynamic_field::borrow_mut<BalanceKey, 0x2::balance::Balance<T0>>(arg0, v0)
    }

    fun deposit_coin<T0>(arg0: &mut StateV1, arg1: 0x2::coin::Coin<T0>) : u64 {
        let v0 = 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::uint_convert::to_u256(0x2::coin::value<T0>(&arg1));
        if (v0 == 0) {
            0x2::coin::destroy_zero<T0>(arg1);
            return 0
        };
        let v1 = 0x1::type_name::get<T0>();
        let v2 = *0x2::vec_map::get<0x1::type_name::TypeName, Metadata>(&arg0.metadata_map, &v1);
        let v3 = 0x1::vector::borrow_mut<u256>(&mut arg0.balances, v2.index);
        *v3 = *v3 + v0 * 1000000000000000000 / v2.scalar;
        let v4 = &mut arg0.id;
        0x2::balance::join<T0>(coin_state_balance_mut<T0>(v4), 0x2::coin::into_balance<T0>(arg1));
        (v0 as u64)
    }

    public(friend) fun get_a(arg0: &StateV1, arg1: &0x2::clock::Clock) : u256 {
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::curve_invariant::a(arg0.initial_a, arg0.initial_a_time, arg0.future_a, arg0.future_a_time, arg1) / 100
    }

    fun imbalanced_fee(arg0: &StateV1) : u256 {
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::fees::fee(&arg0.fees) * 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::uint_convert::to_u256(arg0.n_coins) / 4 * (0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::uint_convert::to_u256(arg0.n_coins) - 1)
    }

    fun lp_coin_treasury_cap<T0>(arg0: &StateV1) : &0x2::coin::TreasuryCap<T0> {
        let v0 = TreasuryCapKey{dummy_field: false};
        0x2::dynamic_object_field::borrow<TreasuryCapKey, 0x2::coin::TreasuryCap<T0>>(&arg0.id, v0)
    }

    fun lp_coin_treasury_cap_mut<T0>(arg0: &mut StateV1) : &mut 0x2::coin::TreasuryCap<T0> {
        let v0 = TreasuryCapKey{dummy_field: false};
        0x2::dynamic_object_field::borrow_mut<TreasuryCapKey, 0x2::coin::TreasuryCap<T0>>(&mut arg0.id, v0)
    }

    public(friend) fun new_2_pool<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: 0x2::coin::TreasuryCap<T2>, arg4: 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::coin_decimals::CoinDecimals, arg5: u256, arg6: address, arg7: &0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::allowed_versions::AllowedVersions, arg8: &mut 0x2::tx_context::TxContext) : (StateV1, 0x2::coin::Coin<T2>) {
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::allowed_versions::assert_pkg_version(arg7);
        assert!(0x2::coin::value<T0>(&arg1) != 0 && 0x2::coin::value<T1>(&arg2) != 0, 11);
        let v0 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T0>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T1>());
        let v2 = 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::coin_decimals::destroy(arg4);
        let v3 = new_state_v1<T2>(arg3, &v2, 0x2::vec_set::from_keys<0x1::type_name::TypeName>(v0), arg6, arg5, arg8);
        let v4 = &mut v3;
        add_coin<T0>(v4, &v2, 0);
        let v5 = &mut v3;
        add_coin<T1>(v5, &v2, 1);
        let v6 = &mut v3;
        (v3, add_liquidity_2_pool_impl<T0, T1, T2>(v6, arg0, arg1, arg2, 0, arg8))
    }

    public(friend) fun new_3_pool<T0, T1, T2, T3>(arg0: &0x2::clock::Clock, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: 0x2::coin::Coin<T2>, arg4: 0x2::coin::TreasuryCap<T3>, arg5: 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::coin_decimals::CoinDecimals, arg6: u256, arg7: address, arg8: &0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::allowed_versions::AllowedVersions, arg9: &mut 0x2::tx_context::TxContext) : (StateV1, 0x2::coin::Coin<T3>) {
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::allowed_versions::assert_pkg_version(arg8);
        let v0 = if (0x2::coin::value<T0>(&arg1) != 0) {
            if (0x2::coin::value<T1>(&arg2) != 0) {
                0x2::coin::value<T2>(&arg3) != 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 11);
        let v1 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::type_name::TypeName>(v2, 0x1::type_name::get<T0>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v2, 0x1::type_name::get<T1>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v2, 0x1::type_name::get<T2>());
        let v3 = 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::coin_decimals::destroy(arg5);
        let v4 = new_state_v1<T3>(arg4, &v3, 0x2::vec_set::from_keys<0x1::type_name::TypeName>(v1), arg7, arg6, arg9);
        let v5 = &mut v4;
        add_coin<T0>(v5, &v3, 0);
        let v6 = &mut v4;
        add_coin<T1>(v6, &v3, 1);
        let v7 = &mut v4;
        add_coin<T2>(v7, &v3, 2);
        let v8 = &mut v4;
        (v4, add_liquidity_3_pool_impl<T0, T1, T2, T3>(v8, arg0, arg1, arg2, arg3, 0, arg9))
    }

    public(friend) fun new_4_pool<T0, T1, T2, T3, T4>(arg0: &0x2::clock::Clock, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: 0x2::coin::Coin<T2>, arg4: 0x2::coin::Coin<T3>, arg5: 0x2::coin::TreasuryCap<T4>, arg6: 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::coin_decimals::CoinDecimals, arg7: u256, arg8: address, arg9: &0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::allowed_versions::AllowedVersions, arg10: &mut 0x2::tx_context::TxContext) : (StateV1, 0x2::coin::Coin<T4>) {
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::allowed_versions::assert_pkg_version(arg9);
        let v0 = if (0x2::coin::value<T0>(&arg1) != 0) {
            if (0x2::coin::value<T1>(&arg2) != 0) {
                if (0x2::coin::value<T2>(&arg3) != 0) {
                    0x2::coin::value<T3>(&arg4) != 0
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 11);
        let v1 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::type_name::TypeName>(v2, 0x1::type_name::get<T0>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v2, 0x1::type_name::get<T1>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v2, 0x1::type_name::get<T2>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v2, 0x1::type_name::get<T3>());
        let v3 = 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::coin_decimals::destroy(arg6);
        let v4 = new_state_v1<T4>(arg5, &v3, 0x2::vec_set::from_keys<0x1::type_name::TypeName>(v1), arg8, arg7, arg10);
        let v5 = &mut v4;
        add_coin<T0>(v5, &v3, 0);
        let v6 = &mut v4;
        add_coin<T1>(v6, &v3, 1);
        let v7 = &mut v4;
        add_coin<T2>(v7, &v3, 2);
        let v8 = &mut v4;
        add_coin<T3>(v8, &v3, 3);
        let v9 = &mut v4;
        (v4, add_liquidity_4_pool_impl<T0, T1, T2, T3, T4>(v9, arg0, arg1, arg2, arg3, arg4, 0, arg10))
    }

    public(friend) fun new_5_pool<T0, T1, T2, T3, T4, T5>(arg0: &0x2::clock::Clock, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: 0x2::coin::Coin<T2>, arg4: 0x2::coin::Coin<T3>, arg5: 0x2::coin::Coin<T4>, arg6: 0x2::coin::TreasuryCap<T5>, arg7: 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::coin_decimals::CoinDecimals, arg8: u256, arg9: address, arg10: &0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::allowed_versions::AllowedVersions, arg11: &mut 0x2::tx_context::TxContext) : (StateV1, 0x2::coin::Coin<T5>) {
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::allowed_versions::assert_pkg_version(arg10);
        let v0 = if (0x2::coin::value<T0>(&arg1) != 0) {
            if (0x2::coin::value<T1>(&arg2) != 0) {
                if (0x2::coin::value<T2>(&arg3) != 0) {
                    if (0x2::coin::value<T3>(&arg4) != 0) {
                        0x2::coin::value<T4>(&arg5) != 0
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 11);
        let v1 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::type_name::TypeName>(v2, 0x1::type_name::get<T0>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v2, 0x1::type_name::get<T1>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v2, 0x1::type_name::get<T2>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v2, 0x1::type_name::get<T3>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v2, 0x1::type_name::get<T4>());
        let v3 = 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::coin_decimals::destroy(arg7);
        let v4 = new_state_v1<T5>(arg6, &v3, 0x2::vec_set::from_keys<0x1::type_name::TypeName>(v1), arg9, arg8, arg11);
        let v5 = &mut v4;
        add_coin<T0>(v5, &v3, 0);
        let v6 = &mut v4;
        add_coin<T1>(v6, &v3, 1);
        let v7 = &mut v4;
        add_coin<T2>(v7, &v3, 2);
        let v8 = &mut v4;
        add_coin<T3>(v8, &v3, 3);
        let v9 = &mut v4;
        add_coin<T4>(v9, &v3, 4);
        let v10 = &mut v4;
        (v4, add_liquidity_5_pool_impl<T0, T1, T2, T3, T4, T5>(v10, arg0, arg1, arg2, arg3, arg4, arg5, 0, arg11))
    }

    fun new_state_v1<T0>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: &0x2::vec_map::VecMap<0x1::type_name::TypeName, u8>, arg2: 0x2::vec_set::VecSet<0x1::type_name::TypeName>, arg3: address, arg4: u256, arg5: &mut 0x2::tx_context::TxContext) : StateV1 {
        assert!(0x2::coin::total_supply<T0>(&arg0) == 0, 13);
        let v0 = 0x1::type_name::get<T0>();
        assert!(*0x2::vec_map::get<0x1::type_name::TypeName, u8>(arg1, &v0) == 9, 12);
        assert!(arg4 != 0 && arg4 <= 1000000, 14);
        let v1 = 0x2::vec_set::into_keys<0x1::type_name::TypeName>(arg2);
        let v2 = 0x1::vector::length<0x1::type_name::TypeName>(&v1);
        let v3 = arg4 * 100;
        let v4 = StateV1{
            id             : 0x2::object::new(arg5),
            pool           : arg3,
            coins          : v1,
            balances       : 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::vectors::zero_fill(0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::uint_convert::to_u256(v2)),
            initial_a      : v3,
            future_a       : v3,
            initial_a_time : 0,
            future_a_time  : 0,
            n_coins        : v2,
            fees           : 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::fees::new(),
            metadata_map   : 0x2::vec_map::empty<0x1::type_name::TypeName, Metadata>(),
            paused         : false,
        };
        let v5 = TreasuryCapKey{dummy_field: false};
        0x2::dynamic_object_field::add<TreasuryCapKey, 0x2::coin::TreasuryCap<T0>>(&mut v4.id, v5, arg0);
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::events::new_pool(arg3, 0x2::object::uid_to_address(&v4.id), v1, 0x1::type_name::get<T0>(), v3);
        v4
    }

    public(friend) fun quote_add_liquidity<T0>(arg0: &StateV1, arg1: &0x2::clock::Clock, arg2: vector<u64>) : u64 {
        let v0 = a(arg0, arg1);
        let v1 = 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::curve_invariant::d(v0, arg0.balances);
        let v2 = 0;
        let v3 = arg0.balances;
        while (arg0.n_coins > v2) {
            let v4 = *0x2::vec_map::get<0x1::type_name::TypeName, Metadata>(&arg0.metadata_map, 0x1::vector::borrow<0x1::type_name::TypeName>(&arg0.coins, v2));
            let v5 = 0x1::vector::borrow_mut<u256>(&mut v3, v2);
            *v5 = *v5 + 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::uint_convert::to_u256(*0x1::vector::borrow<u64>(&arg2, v2)) * 1000000000000000000 / v4.scalar;
            v2 = v2 + 1;
        };
        let v6 = 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::uint_convert::to_u256(0x2::coin::total_supply<T0>(lp_coin_treasury_cap<T0>(arg0)));
        if (v6 == 0) {
            0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::uint_convert::to_u64(0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::curve_invariant::d(v0, v3) / 1000000000)
        } else {
            let v8 = 0;
            while (arg0.n_coins > v8) {
                let v9 = 0x1::vector::borrow_mut<u256>(&mut v3, v8);
                *v9 = *v9 - imbalanced_fee(arg0) * 0x1::u256::diff(0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::curve_invariant::d(v0, v3) * *0x1::vector::borrow<u256>(&arg0.balances, v8) / v1, *0x1::vector::borrow<u256>(&v3, v8)) / 1000000000000000000;
                v8 = v8 + 1;
            };
            0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::uint_convert::to_u64(v6 * (0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::curve_invariant::d(v0, v3) - v1) / v1)
        }
    }

    public(friend) fun quote_remove_liquidity<T0>(arg0: &StateV1, arg1: u64) : vector<u64> {
        let v0 = 0;
        let v1 = vector[];
        while (arg0.n_coins > v0) {
            let v2 = *0x2::vec_map::get<0x1::type_name::TypeName, Metadata>(&arg0.metadata_map, 0x1::vector::borrow<0x1::type_name::TypeName>(&arg0.coins, v0));
            0x1::vector::push_back<u64>(&mut v1, 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::uint_convert::to_u64(*0x1::vector::borrow<u256>(&arg0.balances, v0) * v2.scalar / 1000000000000000000 * 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::uint_convert::to_u256(arg1) / 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::uint_convert::to_u256(0x2::coin::total_supply<T0>(lp_coin_treasury_cap<T0>(arg0)))));
            v0 = v0 + 1;
        };
        v1
    }

    public(friend) fun quote_remove_liquidity_one_coin<T0, T1>(arg0: &StateV1, arg1: &0x2::clock::Clock, arg2: u64) : (u64, u64) {
        let v0 = a(arg0, arg1);
        let (v1, v2, _, _) = calculate_withdraw_one_coin<T0, T1>(arg0, v0, 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::curve_invariant::d(v0, arg0.balances), arg2);
        (v1, v2)
    }

    public(friend) fun quote_swap<T0, T1>(arg0: &StateV1, arg1: &0x2::clock::Clock, arg2: u64) : (u64, u64) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get<T1>();
        let v2 = *0x2::vec_map::get<0x1::type_name::TypeName, Metadata>(&arg0.metadata_map, &v0);
        let v3 = *0x2::vec_map::get<0x1::type_name::TypeName, Metadata>(&arg0.metadata_map, &v1);
        let v4 = *0x1::vector::borrow<u256>(&arg0.balances, v3.index) - 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::curve_invariant::y(a(arg0, arg1), 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::uint_convert::to_u256(v2.index), 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::uint_convert::to_u256(v3.index), *0x1::vector::borrow<u256>(&arg0.balances, v2.index) + 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::uint_convert::to_u256(arg2) * 1000000000000000000 / v2.scalar, arg0.balances);
        let v5 = 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::fees::calculate_fee(&arg0.fees, v4);
        (0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::uint_convert::to_u64((v4 - v5) * v3.scalar / 1000000000000000000), 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::uint_convert::to_u64(v5 * v3.scalar / 1000000000000000000))
    }

    public(friend) fun ramp(arg0: &mut StateV1, arg1: &0x2::clock::Clock, arg2: &0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::acl::AuthWitness, arg3: u256, arg4: u256, arg5: &0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::allowed_versions::AllowedVersions, arg6: &mut 0x2::tx_context::TxContext) {
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::allowed_versions::assert_pkg_version(arg5);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 > 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::uint_convert::to_u64(arg0.initial_a_time) + 86400000, 24);
        assert!(arg4 >= 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::uint_convert::to_u256(v0 + 86400000), 25);
        let v1 = a(arg0, arg1);
        let v2 = arg3 * 100;
        assert!(v2 != 0 && v2 < 1000000, 14);
        assert!(v2 > v1 && v1 * 10 >= v2 || v1 > v2 && v2 * 10 >= v1, 14);
        arg0.initial_a = v1;
        arg0.initial_a_time = 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::uint_convert::to_u256(v0);
        arg0.future_a = v2;
        arg0.future_a_time = arg4;
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::events::ramp_a(arg0.pool, v1, 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::uint_convert::to_u256(v0), v2, arg4);
    }

    fun register_balances<T0>(arg0: &mut 0x2::object::UID, arg1: 0x1::type_name::TypeName) {
        let v0 = BalanceKey{pos0: arg1};
        0x2::dynamic_field::add<BalanceKey, 0x2::balance::Balance<T0>>(arg0, v0, 0x2::balance::zero<T0>());
        let v1 = AdminBalanceKey{pos0: arg1};
        0x2::dynamic_field::add<AdminBalanceKey, 0x2::balance::Balance<T0>>(arg0, v1, 0x2::balance::zero<T0>());
    }

    public(friend) fun remove_liquidity_2_pool<T0, T1, T2>(arg0: &mut StateV1, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T2>, arg3: vector<u64>, arg4: &0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::allowed_versions::AllowedVersions, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::allowed_versions::assert_pkg_version(arg4);
        let v0 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T0>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T1>());
        assert_are_coins_ordered(arg0, v0);
        let v2 = 0x2::coin::value<T2>(&arg2);
        assert!(v2 != 0, 23);
        let v3 = a(arg0, arg1);
        let v4 = virtual_price_impl<T2>(arg0, v3);
        let v5 = 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::uint_convert::to_u256(0x2::coin::total_supply<T2>(lp_coin_treasury_cap<T2>(arg0)));
        let v6 = take_coin<T0>(arg0, v2, v5, arg3, arg5);
        let v7 = take_coin<T1>(arg0, v2, v5, arg3, arg5);
        let v8 = lp_coin_treasury_cap_mut<T2>(arg0);
        0x2::coin::burn<T2>(v8, arg2);
        let v9 = 0x1::vector::empty<u64>();
        let v10 = &mut v9;
        0x1::vector::push_back<u64>(v10, 0x2::coin::value<T0>(&v6));
        0x1::vector::push_back<u64>(v10, 0x2::coin::value<T1>(&v7));
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::events::remove_liquidity(arg0.pool, arg0.coins, v2, v9, arg0.balances);
        assert!(virtual_price_impl<T2>(arg0, v3) >= v4 || 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::uint_convert::to_u256(0x2::coin::total_supply<T2>(lp_coin_treasury_cap<T2>(arg0))) == 0, 17);
        (v6, v7)
    }

    public(friend) fun remove_liquidity_3_pool<T0, T1, T2, T3>(arg0: &mut StateV1, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T3>, arg3: vector<u64>, arg4: &0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::allowed_versions::AllowedVersions, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>) {
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::allowed_versions::assert_pkg_version(arg4);
        let v0 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T0>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T1>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T2>());
        assert_are_coins_ordered(arg0, v0);
        let v2 = 0x2::coin::value<T3>(&arg2);
        assert!(v2 != 0, 23);
        let v3 = a(arg0, arg1);
        let v4 = virtual_price_impl<T3>(arg0, v3);
        let v5 = 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::uint_convert::to_u256(0x2::coin::total_supply<T3>(lp_coin_treasury_cap<T3>(arg0)));
        let v6 = take_coin<T0>(arg0, v2, v5, arg3, arg5);
        let v7 = take_coin<T1>(arg0, v2, v5, arg3, arg5);
        let v8 = take_coin<T2>(arg0, v2, v5, arg3, arg5);
        let v9 = lp_coin_treasury_cap_mut<T3>(arg0);
        0x2::coin::burn<T3>(v9, arg2);
        let v10 = 0x1::vector::empty<u64>();
        let v11 = &mut v10;
        0x1::vector::push_back<u64>(v11, 0x2::coin::value<T0>(&v6));
        0x1::vector::push_back<u64>(v11, 0x2::coin::value<T1>(&v7));
        0x1::vector::push_back<u64>(v11, 0x2::coin::value<T2>(&v8));
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::events::remove_liquidity(arg0.pool, arg0.coins, v2, v10, arg0.balances);
        assert!(virtual_price_impl<T3>(arg0, v3) >= v4 || 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::uint_convert::to_u256(0x2::coin::total_supply<T3>(lp_coin_treasury_cap<T3>(arg0))) == 0, 17);
        (v6, v7, v8)
    }

    public(friend) fun remove_liquidity_4_pool<T0, T1, T2, T3, T4>(arg0: &mut StateV1, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T4>, arg3: vector<u64>, arg4: &0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::allowed_versions::AllowedVersions, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>, 0x2::coin::Coin<T3>) {
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::allowed_versions::assert_pkg_version(arg4);
        let v0 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T0>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T1>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T2>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T3>());
        assert_are_coins_ordered(arg0, v0);
        let v2 = 0x2::coin::value<T4>(&arg2);
        assert!(v2 != 0, 23);
        let v3 = a(arg0, arg1);
        let v4 = virtual_price_impl<T4>(arg0, v3);
        let v5 = 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::uint_convert::to_u256(0x2::coin::total_supply<T4>(lp_coin_treasury_cap<T4>(arg0)));
        let v6 = take_coin<T0>(arg0, v2, v5, arg3, arg5);
        let v7 = take_coin<T1>(arg0, v2, v5, arg3, arg5);
        let v8 = take_coin<T2>(arg0, v2, v5, arg3, arg5);
        let v9 = take_coin<T3>(arg0, v2, v5, arg3, arg5);
        let v10 = lp_coin_treasury_cap_mut<T4>(arg0);
        0x2::coin::burn<T4>(v10, arg2);
        let v11 = 0x1::vector::empty<u64>();
        let v12 = &mut v11;
        0x1::vector::push_back<u64>(v12, 0x2::coin::value<T0>(&v6));
        0x1::vector::push_back<u64>(v12, 0x2::coin::value<T1>(&v7));
        0x1::vector::push_back<u64>(v12, 0x2::coin::value<T2>(&v8));
        0x1::vector::push_back<u64>(v12, 0x2::coin::value<T3>(&v9));
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::events::remove_liquidity(arg0.pool, arg0.coins, v2, v11, arg0.balances);
        assert!(virtual_price_impl<T4>(arg0, v3) >= v4 || 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::uint_convert::to_u256(0x2::coin::total_supply<T4>(lp_coin_treasury_cap<T4>(arg0))) == 0, 17);
        (v6, v7, v8, v9)
    }

    public(friend) fun remove_liquidity_5_pool<T0, T1, T2, T3, T4, T5>(arg0: &mut StateV1, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T5>, arg3: vector<u64>, arg4: &0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::allowed_versions::AllowedVersions, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>, 0x2::coin::Coin<T3>, 0x2::coin::Coin<T4>) {
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::allowed_versions::assert_pkg_version(arg4);
        let v0 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T0>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T1>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T2>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T3>());
        0x1::vector::push_back<0x1::type_name::TypeName>(v1, 0x1::type_name::get<T4>());
        assert_are_coins_ordered(arg0, v0);
        let v2 = 0x2::coin::value<T5>(&arg2);
        assert!(v2 != 0, 23);
        let v3 = a(arg0, arg1);
        let v4 = virtual_price_impl<T5>(arg0, v3);
        let v5 = 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::uint_convert::to_u256(0x2::coin::total_supply<T5>(lp_coin_treasury_cap<T5>(arg0)));
        let v6 = take_coin<T0>(arg0, v2, v5, arg3, arg5);
        let v7 = take_coin<T1>(arg0, v2, v5, arg3, arg5);
        let v8 = take_coin<T2>(arg0, v2, v5, arg3, arg5);
        let v9 = take_coin<T3>(arg0, v2, v5, arg3, arg5);
        let v10 = take_coin<T4>(arg0, v2, v5, arg3, arg5);
        let v11 = lp_coin_treasury_cap_mut<T5>(arg0);
        0x2::coin::burn<T5>(v11, arg2);
        let v12 = 0x1::vector::empty<u64>();
        let v13 = &mut v12;
        0x1::vector::push_back<u64>(v13, 0x2::coin::value<T0>(&v6));
        0x1::vector::push_back<u64>(v13, 0x2::coin::value<T1>(&v7));
        0x1::vector::push_back<u64>(v13, 0x2::coin::value<T2>(&v8));
        0x1::vector::push_back<u64>(v13, 0x2::coin::value<T3>(&v9));
        0x1::vector::push_back<u64>(v13, 0x2::coin::value<T4>(&v10));
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::events::remove_liquidity(arg0.pool, arg0.coins, v2, v12, arg0.balances);
        assert!(virtual_price_impl<T5>(arg0, v3) >= v4 || 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::uint_convert::to_u256(0x2::coin::total_supply<T5>(lp_coin_treasury_cap<T5>(arg0))) == 0, 17);
        (v6, v7, v8, v9, v10)
    }

    public(friend) fun stop_ramp(arg0: &mut StateV1, arg1: &0x2::clock::Clock, arg2: &0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::acl::AuthWitness, arg3: &0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::allowed_versions::AllowedVersions, arg4: &0x2::tx_context::TxContext) {
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::allowed_versions::assert_pkg_version(arg3);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = a(arg0, arg1);
        arg0.initial_a = v1;
        arg0.initial_a_time = 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::uint_convert::to_u256(v0);
        arg0.future_a = v1;
        arg0.future_a_time = 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::uint_convert::to_u256(v0);
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::events::stop_ramp_a(arg0.pool, v1, v0);
    }

    fun take_coin<T0>(arg0: &mut StateV1, arg1: u64, arg2: u256, arg3: vector<u64>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = *0x2::vec_map::get<0x1::type_name::TypeName, Metadata>(&arg0.metadata_map, &v0);
        let v2 = 0x1::vector::borrow_mut<u256>(&mut arg0.balances, v1.index);
        let v3 = *v2 * v1.scalar / 1000000000000000000 * 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::uint_convert::to_u256(arg1) / arg2;
        assert!(0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::uint_convert::to_u64(v3) >= *0x1::vector::borrow<u64>(&arg3, v1.index), 19);
        *v2 = *v2 - v3 * 1000000000000000000 / v1.scalar;
        let v4 = &mut arg0.id;
        0x2::coin::take<T0>(coin_state_balance_mut<T0>(v4), 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::uint_convert::to_u64(v3), arg4)
    }

    public(friend) fun virtual_price<T0>(arg0: &StateV1, arg1: &0x2::clock::Clock) : u256 {
        virtual_price_impl<T0>(arg0, a(arg0, arg1))
    }

    fun virtual_price_impl<T0>(arg0: &StateV1, arg1: u256) : u256 {
        let v0 = 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::uint_convert::to_u256(0x2::coin::total_supply<T0>(lp_coin_treasury_cap<T0>(arg0)));
        if (v0 == 0) {
            return 0
        };
        0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::curve_invariant::d(arg1, arg0.balances) * 1000000000 / v0
    }

    // decompiled from Move bytecode v6
}

