module 0xbc9c8523830538b619ecfc9f544a676112a4fdb1da2bc31e44fb153e9dfbbd5c::sui_contract {
    struct Bank<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        owner: address,
    }

    struct AccessList has store, key {
        id: 0x2::object::UID,
        admin: address,
        trader: address,
    }

    public fun c_a<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut AccessList, arg4: &mut Bank<T0>, arg5: &mut Bank<T1>, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(is_trader(arg3, arg8), 1);
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, true, true, arg6, 4295048016, arg2);
        0x2::balance::destroy_zero<T0>(v0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::take<T0>(&mut arg4.balance, arg6, arg8)), 0x2::balance::zero<T1>(), v2);
        deposit<T1>(arg5, 0x2::coin::from_balance<T1>(v1, arg8), arg7);
    }

    public fun c_b<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::partner::Partner, arg3: &0x2::clock::Clock, arg4: &mut AccessList, arg5: &mut Bank<T0>, arg6: &mut Bank<T1>, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(is_trader(arg4, arg9), 1);
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, false, true, arg7, 79226673515401279992447579055, arg3);
        0x2::balance::destroy_zero<T1>(v1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::take<T1>(&mut arg6.balance, arg7, arg9)), v2);
        deposit<T0>(arg5, 0x2::coin::from_balance<T0>(v0, arg9), arg8);
    }

    public fun deposit<T0>(arg0: &mut Bank<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64) {
        assert!(0x2::coin::value<T0>(&arg1) >= arg2, 2);
        0x2::coin::put<T0>(&mut arg0.balance, arg1);
    }

    fun is_admin(arg0: &AccessList, arg1: &0x2::tx_context::TxContext) : bool {
        arg0.admin == 0x2::tx_context::sender(arg1)
    }

    fun is_trader(arg0: &AccessList, arg1: &0x2::tx_context::TxContext) : bool {
        arg0.admin == 0x2::tx_context::sender(arg1)
    }

    public fun new_access_list(arg0: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0x58e50d7f8f4cb0411d3ceb34f0251cf409dd213820c160beded983e9a0b60fd3, 1);
        let v0 = AccessList{
            id     : 0x2::object::new(arg0),
            admin  : @0x58e50d7f8f4cb0411d3ceb34f0251cf409dd213820c160beded983e9a0b60fd3,
            trader : @0xfff4a35047b22272caa16f524a1d0a48702b4a330f67e67a79f8f61ac648b74e,
        };
        0x2::transfer::share_object<AccessList>(v0);
    }

    public fun new_b<T0>(arg0: &mut AccessList, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(is_admin(arg0, arg2), 1);
        let v0 = Bank<T0>{
            id      : 0x2::object::new(arg2),
            balance : 0x2::coin::into_balance<T0>(arg1),
            owner   : 0x2::tx_context::sender(arg2),
        };
        0x2::transfer::share_object<Bank<T0>>(v0);
    }

    public fun withdraw_admin<T0>(arg0: &mut AccessList, arg1: &mut Bank<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(is_admin(arg0, arg3), 1);
        0x2::coin::take<T0>(&mut arg1.balance, arg2, arg3)
    }

    // decompiled from Move bytecode v6
}

