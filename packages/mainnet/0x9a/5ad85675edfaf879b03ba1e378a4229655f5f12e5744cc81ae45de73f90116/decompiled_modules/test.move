module 0x9a5ad85675edfaf879b03ba1e378a4229655f5f12e5744cc81ae45de73f90116::test {
    struct Dao has store, key {
        id: 0x2::object::UID,
        investment: 0x2::bag::Bag,
    }

    fun swap<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x2::balance::Balance<T0>, arg3: &mut 0x2::balance::Balance<T1>, arg4: bool, arg5: bool, arg6: u64, arg7: u128, arg8: &0x2::clock::Clock) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, arg4, arg5, arg6, arg7, arg8);
        let v3 = v2;
        let (v4, v5) = if (arg4) {
            (0x2::balance::split<T0>(arg2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::split<T1>(arg3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3)))
        };
        0x2::balance::join<T1>(arg3, v1);
        0x2::balance::join<T0>(arg2, v0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, v4, v5, v3);
    }

    public fun check_exist_coin<T0>(arg0: &mut Dao) {
        if (0x2::bag::contains_with_type<u64, 0x2::balance::Balance<T0>>(&arg0.investment, hash_type_to_u64<T0>())) {
            return
        };
        0x2::bag::add<u64, 0x2::balance::Balance<T0>>(&mut arg0.investment, hash_type_to_u64<T0>(), 0x2::balance::zero<T0>());
    }

    public fun create(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Dao{
            id         : 0x2::object::new(arg0),
            investment : 0x2::bag::new(arg0),
        };
        0x2::transfer::share_object<Dao>(v0);
    }

    public fun deposit_to_dao<T0>(arg0: &mut Dao, arg1: 0x2::balance::Balance<T0>) {
        check_exist_coin<T0>(arg0);
        0x2::balance::join<T0>(0x2::bag::borrow_mut<u64, 0x2::balance::Balance<T0>>(&mut arg0.investment, hash_type_to_u64<T0>()), arg1);
    }

    public fun exact_in_single<T0, T1>(arg0: &mut Dao, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: bool, arg4: u64, arg5: u64, arg6: u128, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        check_exist_coin<T0>(arg0);
        check_exist_coin<T1>(arg0);
        let (v0, v1) = if (arg3) {
            (0x2::balance::split<T0>(0x2::bag::borrow_mut<u64, 0x2::balance::Balance<T0>>(&mut arg0.investment, hash_type_to_u64<T0>()), arg4), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::split<T1>(0x2::bag::borrow_mut<u64, 0x2::balance::Balance<T1>>(&mut arg0.investment, hash_type_to_u64<T1>()), arg4))
        };
        let v2 = v1;
        let v3 = v0;
        if (arg6 == 0 && arg3 == true) {
            arg6 = 4295048016;
        };
        if (arg6 == 0 && arg3 == false) {
            arg6 = 79226673515401279992447579055;
        };
        let v4 = &mut v3;
        let v5 = &mut v2;
        swap<T0, T1>(arg1, arg2, v4, v5, arg3, true, arg4, arg6, arg7);
        if (arg5 != 0) {
            let v6 = if (arg3) {
                0x2::balance::value<T1>(&v2)
            } else {
                0x2::balance::value<T0>(&v3)
            };
            assert!(v6 > arg5, 1);
        };
        deposit_to_dao<T0>(arg0, v3);
        deposit_to_dao<T1>(arg0, v2);
    }

    public fun exact_out_single<T0, T1>(arg0: &mut Dao, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: bool, arg4: u64, arg5: u64, arg6: u128, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        check_exist_coin<T0>(arg0);
        check_exist_coin<T1>(arg0);
        let (v0, v1) = if (arg3) {
            (0x2::balance::split<T0>(0x2::bag::borrow_mut<u64, 0x2::balance::Balance<T0>>(&mut arg0.investment, hash_type_to_u64<T0>()), arg4), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::split<T1>(0x2::bag::borrow_mut<u64, 0x2::balance::Balance<T1>>(&mut arg0.investment, hash_type_to_u64<T1>()), arg4))
        };
        let v2 = v1;
        let v3 = v0;
        if (arg6 == 0 && arg3 == true) {
            arg6 = 4295048016;
        };
        if (arg6 == 0 && arg3 == false) {
            arg6 = 79226673515401279992447579055;
        };
        let v4 = &mut v3;
        let v5 = &mut v2;
        swap<T0, T1>(arg1, arg2, v4, v5, arg3, false, arg5, arg6, arg7);
        deposit_to_dao<T0>(arg0, v3);
        deposit_to_dao<T1>(arg0, v2);
    }

    public fun hash_type_to_u64<T0>() : u64 {
        let v0 = 0x2::bcs::new(0x1::hash::sha3_256(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>()))));
        0x2::bcs::peel_u64(&mut v0)
    }

    // decompiled from Move bytecode v6
}

