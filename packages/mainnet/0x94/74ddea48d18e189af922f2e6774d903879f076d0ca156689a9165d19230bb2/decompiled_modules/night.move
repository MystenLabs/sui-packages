module 0x9474ddea48d18e189af922f2e6774d903879f076d0ca156689a9165d19230bb2::night {
    struct Board has key {
        id: 0x2::object::UID,
        ends_at_ms: u64,
        open_sui: 0x2::balance::Balance<0x2::sui::SUI>,
        votes: 0x2::vec_map::VecMap<address, 0x1::type_name::TypeName>,
        buckets: 0x2::vec_map::VecMap<0x1::type_name::TypeName, vector<address>>,
        leader: 0x1::option::Option<0x1::type_name::TypeName>,
        leader_score: u64,
        weights: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
        drip_active: bool,
        drip_sui: 0x2::balance::Balance<0x2::sui::SUI>,
        drip_winner: 0x1::option::Option<0x1::type_name::TypeName>,
        drip_voters: vector<address>,
        drip_opens_ms: u64,
        next_slice: u64,
        rate: u128,
        pool: 0x1::option::Option<0x2::object::ID>,
    }

    struct SlicePaid has copy, drop {
        slice: u64,
        sui_in: u64,
        coin_out: u64,
        payees: u64,
        refunded: bool,
    }

    fun assert_winner<T0>(arg0: &Board) {
        assert!(0x1::option::is_some<0x1::type_name::TypeName>(&arg0.drip_winner), 3);
        assert!(*0x1::option::borrow<0x1::type_name::TypeName>(&arg0.drip_winner) == 0x1::type_name::get<T0>(), 3);
    }

    public fun burn_upgrade(arg0: 0x2::package::UpgradeCap) {
        0x2::package::make_immutable(arg0);
    }

    public fun cast_vote<T0>(arg0: &mut Board, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.ends_at_ms > 0, 7);
        assert!(0x2::clock::timestamp_ms(arg3) < arg0.ends_at_ms, 0);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) == 1000000000, 5);
        assert!(arg2 >= 1 && arg2 <= 4, 11);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(!0x2::vec_map::contains<address, 0x1::type_name::TypeName>(&arg0.votes, &v0), 4);
        let v1 = 0x1::type_name::get<T0>();
        0x2::vec_map::insert<address, 0x1::type_name::TypeName>(&mut arg0.votes, v0, v1);
        if (!0x2::vec_map::contains<0x1::type_name::TypeName, vector<address>>(&arg0.buckets, &v1)) {
            let v2 = 0x1::vector::empty<address>();
            0x1::vector::push_back<address>(&mut v2, v0);
            0x2::vec_map::insert<0x1::type_name::TypeName, vector<address>>(&mut arg0.buckets, v1, v2);
            0x2::vec_map::insert<0x1::type_name::TypeName, u64>(&mut arg0.weights, v1, arg2);
        } else {
            0x1::vector::push_back<address>(0x2::vec_map::get_mut<0x1::type_name::TypeName, vector<address>>(&mut arg0.buckets, &v1), v0);
        };
        let v3 = 0x1::vector::length<address>(0x2::vec_map::get<0x1::type_name::TypeName, vector<address>>(&arg0.buckets, &v1)) * *0x2::vec_map::get<0x1::type_name::TypeName, u64>(&arg0.weights, &v1);
        if (v3 > arg0.leader_score) {
            arg0.leader_score = v3;
            arg0.leader = 0x1::option::some<0x1::type_name::TypeName>(v1);
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.open_sui, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    fun check_fill(arg0: &mut Board, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        assert!(arg2 > 0 && arg2 <= arg3, 2);
        assert!(arg4 > 0, 2);
        assert!((arg4 as u128) >= (arg1 as u128) * (10000 - 100) / 10000, 2);
        if (arg0.rate == 0) {
            arg0.rate = (arg4 as u128) * 10000 / (arg2 as u128);
        } else {
            assert!((arg4 as u128) * 10000 / (arg2 as u128) >= arg0.rate * (10000 - 100) / 10000, 2);
        };
    }

    public fun close(arg0: &mut Board, arg1: &0x2::clock::Clock) {
        assert!(arg0.ends_at_ms > 0, 7);
        assert!(!arg0.drip_active, 6);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 >= arg0.ends_at_ms, 1);
        let v1 = arg0.ends_at_ms;
        if (arg0.leader_score > 0) {
            let v2 = *0x1::option::borrow<0x1::type_name::TypeName>(&arg0.leader);
            arg0.drip_voters = *0x2::vec_map::get<0x1::type_name::TypeName, vector<address>>(&arg0.buckets, &v2);
            arg0.drip_winner = 0x1::option::some<0x1::type_name::TypeName>(v2);
            arg0.drip_opens_ms = v1;
            arg0.drip_active = true;
            arg0.next_slice = 0;
            arg0.rate = 0;
            arg0.pool = 0x1::option::none<0x2::object::ID>();
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.drip_sui, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.open_sui, 0x2::balance::value<0x2::sui::SUI>(&arg0.open_sui)));
        };
        arg0.votes = 0x2::vec_map::empty<address, 0x1::type_name::TypeName>();
        arg0.buckets = 0x2::vec_map::empty<0x1::type_name::TypeName, vector<address>>();
        arg0.leader = 0x1::option::none<0x1::type_name::TypeName>();
        arg0.leader_score = 0;
        arg0.weights = 0x2::vec_map::empty<0x1::type_name::TypeName, u64>();
        let v3 = v0 / 86400000 * 86400000;
        let v4 = if (v3 + 86400000 > v1) {
            v3 + 86400000
        } else {
            v1 + 86400000
        };
        arg0.ends_at_ms = v4;
    }

    public fun crank_coin_for_sui<T0>(arg0: &mut Board, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_winner<T0>(arg0);
        lock_pool(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>>(arg2));
        assert!(!0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::is_pause<T0, 0x2::sui::SUI>(arg2), 10);
        if (release_if_dust(arg0)) {
            return
        };
        let (v0, v1) = pull_slice(arg0, arg3);
        let v2 = v1;
        let v3 = 0x2::balance::value<0x2::sui::SUI>(&v2);
        let (v4, _) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::balances<T0, 0x2::sui::SUI>(arg2);
        assert!(0x2::balance::value<T0>(v4) > 0, 10);
        let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, 0x2::sui::SUI>(arg2, false, true, v3);
        assert!(!0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_is_exceed(&v6), 2);
        let (v7, v8, v9) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, 0x2::sui::SUI>(arg1, arg2, false, true, v3, 79226673515401279992447579055, arg3);
        let v10 = v9;
        let v11 = v7;
        let v12 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, 0x2::sui::SUI>(&v10);
        let v13 = 0x2::balance::value<T0>(&v11);
        check_fill(arg0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v6), v12, v3, v13);
        0x2::balance::join<0x2::sui::SUI>(&mut v2, v8);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, 0x2::sui::SUI>(arg1, arg2, 0x2::balance::zero<T0>(), 0x2::balance::split<0x2::sui::SUI>(&mut v2, v12), v10);
        return_sui(arg0, v2);
        let v14 = 0x2::coin::from_balance<T0>(v11, arg4);
        pay_holders<T0>(arg0, v14, arg4);
        let v15 = SlicePaid{
            slice    : v0,
            sui_in   : v12,
            coin_out : v13,
            payees   : 0x1::vector::length<address>(&arg0.drip_voters),
            refunded : false,
        };
        0x2::event::emit<SlicePaid>(v15);
        if (arg0.next_slice == 12) {
            finish(arg0);
        };
    }

    public fun crank_sui_for_coin<T0>(arg0: &mut Board, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2::sui::SUI, T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_winner<T0>(arg0);
        lock_pool(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2::sui::SUI, T0>>(arg2));
        assert!(!0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::is_pause<0x2::sui::SUI, T0>(arg2), 10);
        if (release_if_dust(arg0)) {
            return
        };
        let (v0, v1) = pull_slice(arg0, arg3);
        let v2 = v1;
        let v3 = 0x2::balance::value<0x2::sui::SUI>(&v2);
        let (_, v5) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::balances<0x2::sui::SUI, T0>(arg2);
        assert!(0x2::balance::value<T0>(v5) > 0, 10);
        let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<0x2::sui::SUI, T0>(arg2, true, true, v3);
        assert!(!0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_is_exceed(&v6), 2);
        let (v7, v8, v9) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<0x2::sui::SUI, T0>(arg1, arg2, true, true, v3, 4295048016, arg3);
        let v10 = v9;
        let v11 = v8;
        let v12 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<0x2::sui::SUI, T0>(&v10);
        let v13 = 0x2::balance::value<T0>(&v11);
        check_fill(arg0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v6), v12, v3, v13);
        0x2::balance::join<0x2::sui::SUI>(&mut v2, v7);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<0x2::sui::SUI, T0>(arg1, arg2, 0x2::balance::split<0x2::sui::SUI>(&mut v2, v12), 0x2::balance::zero<T0>(), v10);
        return_sui(arg0, v2);
        let v14 = 0x2::coin::from_balance<T0>(v11, arg4);
        pay_holders<T0>(arg0, v14, arg4);
        let v15 = SlicePaid{
            slice    : v0,
            sui_in   : v12,
            coin_out : v13,
            payees   : 0x1::vector::length<address>(&arg0.drip_voters),
            refunded : false,
        };
        0x2::event::emit<SlicePaid>(v15);
        if (arg0.next_slice == 12) {
            finish(arg0);
        };
    }

    fun finish(arg0: &mut Board) {
        arg0.drip_active = false;
        arg0.rate = 0;
        arg0.pool = 0x1::option::none<0x2::object::ID>();
        arg0.drip_voters = vector[];
        arg0.drip_winner = 0x1::option::none<0x1::type_name::TypeName>();
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.drip_sui);
        if (v0 > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.open_sui, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.drip_sui, v0));
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Board{
            id            : 0x2::object::new(arg0),
            ends_at_ms    : 0,
            open_sui      : 0x2::balance::zero<0x2::sui::SUI>(),
            votes         : 0x2::vec_map::empty<address, 0x1::type_name::TypeName>(),
            buckets       : 0x2::vec_map::empty<0x1::type_name::TypeName, vector<address>>(),
            leader        : 0x1::option::none<0x1::type_name::TypeName>(),
            leader_score  : 0,
            weights       : 0x2::vec_map::empty<0x1::type_name::TypeName, u64>(),
            drip_active   : false,
            drip_sui      : 0x2::balance::zero<0x2::sui::SUI>(),
            drip_winner   : 0x1::option::none<0x1::type_name::TypeName>(),
            drip_voters   : vector[],
            drip_opens_ms : 0,
            next_slice    : 0,
            rate          : 0,
            pool          : 0x1::option::none<0x2::object::ID>(),
        };
        0x2::transfer::share_object<Board>(v0);
    }

    fun lock_pool(arg0: &mut Board, arg1: 0x2::object::ID) {
        if (0x1::option::is_none<0x2::object::ID>(&arg0.pool)) {
            arg0.pool = 0x1::option::some<0x2::object::ID>(arg1);
        } else {
            assert!(*0x1::option::borrow<0x2::object::ID>(&arg0.pool) == arg1, 10);
        };
    }

    fun opened_at(arg0: &Board, arg1: u64) : u64 {
        arg0.drip_opens_ms + arg1 * 300000
    }

    fun pay_holders<T0>(arg0: &Board, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg0.drip_voters);
        assert!(v0 > 0, 3);
        let v1 = 0x2::coin::value<T0>(&arg1) / v0;
        assert!(v1 > 0, 2);
        let v2 = 0;
        while (v2 < v0) {
            let v3 = if (v2 + 1 == v0) {
                0x2::coin::value<T0>(&arg1)
            } else {
                v1
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1, v3, arg2), *0x1::vector::borrow<address>(&arg0.drip_voters, v2));
            v2 = v2 + 1;
        };
        0x2::coin::destroy_zero<T0>(arg1);
    }

    fun pull_slice(arg0: &mut Board, arg1: &0x2::clock::Clock) : (u64, 0x2::balance::Balance<0x2::sui::SUI>) {
        assert!(arg0.drip_active, 8);
        assert!(arg0.next_slice < 12, 8);
        assert!(0x2::clock::timestamp_ms(arg1) >= opened_at(arg0, arg0.next_slice), 1);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.drip_sui) / (12 - arg0.next_slice);
        assert!(v0 > 0, 8);
        let v1 = arg0.next_slice;
        arg0.next_slice = v1 + 1;
        (v1, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.drip_sui, v0))
    }

    public fun refund_slice(arg0: &mut Board, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.drip_active, 8);
        if (release_if_dust(arg0)) {
            return
        };
        assert!(arg0.next_slice < 12, 8);
        assert!(0x2::clock::timestamp_ms(arg1) >= opened_at(arg0, arg0.next_slice) + 3600000, 1);
        let (v0, v1) = pull_slice(arg0, arg1);
        let v2 = v1;
        let v3 = 0x2::coin::from_balance<0x2::sui::SUI>(v2, arg2);
        pay_holders<0x2::sui::SUI>(arg0, v3, arg2);
        let v4 = SlicePaid{
            slice    : v0,
            sui_in   : 0x2::balance::value<0x2::sui::SUI>(&v2),
            coin_out : 0,
            payees   : 0x1::vector::length<address>(&arg0.drip_voters),
            refunded : true,
        };
        0x2::event::emit<SlicePaid>(v4);
        if (arg0.next_slice == 12) {
            finish(arg0);
        };
    }

    fun release_if_dust(arg0: &mut Board) : bool {
        if (!arg0.drip_active || arg0.next_slice >= 12) {
            return false
        };
        if (0x2::balance::value<0x2::sui::SUI>(&arg0.drip_sui) / (12 - arg0.next_slice) == 0) {
            finish(arg0);
            return true
        };
        false
    }

    fun return_sui(arg0: &mut Board, arg1: 0x2::balance::Balance<0x2::sui::SUI>) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1);
        if (v0 > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.drip_sui, 0x2::balance::split<0x2::sui::SUI>(&mut arg1, v0));
        };
        0x2::balance::destroy_zero<0x2::sui::SUI>(arg1);
    }

    public fun start(arg0: &mut Board, arg1: &0x2::clock::Clock) {
        assert!(arg0.ends_at_ms == 0, 9);
        arg0.ends_at_ms = 0x2::clock::timestamp_ms(arg1) / 86400000 * 86400000 + 86400000;
    }

    // decompiled from Move bytecode v7
}

