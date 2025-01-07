module 0xe1419468b5290bb33ec0397c543db62f3f8970a71b669ed37e85674fff40b78e::swap {
    struct OwnerCap has key {
        id: 0x2::object::UID,
    }

    struct Whitelists has store, key {
        id: 0x2::object::UID,
        executors: 0x2::table::Table<address, bool>,
        recipients: 0x2::table::Table<address, bool>,
        validated_pools: 0x2::table::Table<0x2::object::ID, bool>,
    }

    struct Assets has store, key {
        id: 0x2::object::UID,
        balances: 0x2::bag::Bag,
    }

    public fun swap<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: bool, arg3: bool, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut Whitelists, arg9: &mut Assets, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<address, bool>(&arg8.executors, 0x2::tx_context::sender(arg10)), 4);
        assert!(0x2::table::contains<0x2::object::ID, bool>(&arg8.validated_pools, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1)), 5);
        assert!(0x2::clock::timestamp_ms(arg7) <= arg6, 2);
        let (v0, v1, v2) = if (arg2) {
            let v3 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
            assert!(0x2::bag::contains<0x1::ascii::String>(&arg9.balances, v3), 7);
            let v4 = 0x2::bag::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg9.balances, v3);
            let v0 = 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v4, 0x2::balance::value<T0>(v4)), arg10);
            let v1 = 0x2::coin::zero<T1>(arg10);
            (v0, v1, 4295048016)
        } else {
            let v5 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
            assert!(0x2::bag::contains<0x1::ascii::String>(&arg9.balances, v5), 7);
            let v6 = 0x2::bag::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T1>>(&mut arg9.balances, v5);
            let v1 = 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(v6, 0x2::balance::value<T1>(v6)), arg10);
            let v0 = 0x2::coin::zero<T0>(arg10);
            (v0, v1, 79226673515401279992447579055)
        };
        let (v7, v8, v9) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, arg2, arg3, arg4, v2, arg7);
        let v10 = v9;
        let v11 = v8;
        let v12 = v7;
        let v13 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v10);
        let v14 = if (arg2) {
            0x2::balance::value<T1>(&v11)
        } else {
            0x2::balance::value<T0>(&v12)
        };
        if (arg3) {
            assert!(v14 >= arg5, 3);
        } else {
            assert!(v13 <= arg5, 8);
        };
        let (v15, v16) = if (arg2) {
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v0, v13, arg10)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v1, v13, arg10)))
        };
        0x2::coin::join<T1>(&mut v1, 0x2::coin::from_balance<T1>(v11, arg10));
        0x2::coin::join<T0>(&mut v0, 0x2::coin::from_balance<T0>(v12, arg10));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, v15, v16, v10);
        let v17 = 0x2::coin::value<T0>(&v0);
        let v18 = 0x2::coin::value<T1>(&v1);
        if (v17 > 0) {
            deposit<T0>(arg9, 0x1::vector::singleton<0x2::coin::Coin<T0>>(v0), v17, arg10);
        } else {
            0x2::coin::destroy_zero<T0>(v0);
        };
        if (v18 > 0) {
            deposit<T1>(arg9, 0x1::vector::singleton<0x2::coin::Coin<T1>>(v1), v18, arg10);
        } else {
            0x2::coin::destroy_zero<T1>(v1);
        };
    }

    public fun add_executor(arg0: &mut OwnerCap, arg1: address, arg2: &mut Whitelists) {
        0x2::table::add<address, bool>(&mut arg2.executors, arg1, true);
    }

    public fun add_recipient(arg0: &mut OwnerCap, arg1: address, arg2: &mut Whitelists) {
        0x2::table::add<address, bool>(&mut arg2.recipients, arg1, true);
    }

    public fun add_validated_pool<T0, T1>(arg0: &mut OwnerCap, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut Whitelists) {
        0x2::table::add<0x2::object::ID, bool>(&mut arg2.validated_pools, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1), true);
    }

    public fun change_owner(arg0: OwnerCap, arg1: address) {
        0x2::transfer::transfer<OwnerCap>(arg0, arg1);
    }

    public fun deposit<T0>(arg0: &mut Assets, arg1: vector<0x2::coin::Coin<T0>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v1 = merge_coins<T0>(arg1, arg3);
        let v2 = 0x2::coin::into_balance<T0>(v1);
        assert!(0x2::balance::value<T0>(&v2) >= arg2, 6);
        if (!0x2::bag::contains<0x1::ascii::String>(&arg0.balances, v0)) {
            0x2::bag::add<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0, 0x2::balance::split<T0>(&mut v2, arg2));
        } else {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0), 0x2::balance::split<T0>(&mut v2, arg2));
        };
        let v3 = 0x2::tx_context::sender(arg3);
        return_back_or_delete<T0>(v2, v3, arg3);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OwnerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<OwnerCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Whitelists{
            id              : 0x2::object::new(arg0),
            executors       : 0x2::table::new<address, bool>(arg0),
            recipients      : 0x2::table::new<address, bool>(arg0),
            validated_pools : 0x2::table::new<0x2::object::ID, bool>(arg0),
        };
        0x2::transfer::public_share_object<Whitelists>(v1);
        let v2 = Assets{
            id       : 0x2::object::new(arg0),
            balances : 0x2::bag::new(arg0),
        };
        0x2::transfer::public_share_object<Assets>(v2);
    }

    public fun is_executor(arg0: &Whitelists, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.executors, arg1)
    }

    public fun is_recipient(arg0: &Whitelists, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.recipients, arg1)
    }

    public fun merge<T0>(arg0: vector<0x2::coin::Coin<T0>>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = merge_coins<T0>(arg0, arg1);
        let v1 = 0x2::tx_context::sender(arg1);
        return_back_or_delete<T0>(0x2::coin::into_balance<T0>(v0), v1, arg1);
    }

    public fun merge_coins<T0>(arg0: vector<0x2::coin::Coin<T0>>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        if (0x1::vector::length<0x2::coin::Coin<T0>>(&arg0) == 0) {
            0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg0);
            0x2::coin::zero<T0>(arg1)
        } else {
            let v1 = 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg0);
            0x2::pay::join_vec<T0>(&mut v1, arg0);
            v1
        }
    }

    public fun remove_executor(arg0: &mut OwnerCap, arg1: address, arg2: &mut Whitelists) {
        0x2::table::remove<address, bool>(&mut arg2.executors, arg1);
    }

    public fun remove_recipient(arg0: &mut OwnerCap, arg1: address, arg2: &mut Whitelists) {
        0x2::table::remove<address, bool>(&mut arg2.recipients, arg1);
    }

    public fun remove_validated_pool<T0, T1>(arg0: &mut OwnerCap, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut Whitelists) {
        0x2::table::remove<0x2::object::ID, bool>(&mut arg2.validated_pools, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1));
    }

    fun return_back_or_delete<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg2), arg1);
        } else {
            0x2::balance::destroy_zero<T0>(arg0);
        };
    }

    public fun withdraw<T0>(arg0: u64, arg1: &mut Assets, arg2: &mut Whitelists, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<address, bool>(&arg2.recipients, 0x2::tx_context::sender(arg3)), 4);
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        assert!(0x2::bag::contains<0x1::ascii::String>(&arg1.balances, v0), 7);
        let v1 = 0x2::bag::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut arg1.balances, v0);
        let v2 = 0x2::balance::value<T0>(v1);
        assert!(v2 >= arg0, 8);
        if (arg0 == 0) {
            arg0 = v2;
        };
        let v3 = 0x2::tx_context::sender(arg3);
        return_back_or_delete<T0>(0x2::balance::split<T0>(v1, arg0), v3, arg3);
    }

    // decompiled from Move bytecode v6
}

