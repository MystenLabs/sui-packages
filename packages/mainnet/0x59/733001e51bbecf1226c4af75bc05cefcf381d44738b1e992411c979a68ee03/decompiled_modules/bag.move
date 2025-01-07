module 0x59733001e51bbecf1226c4af75bc05cefcf381d44738b1e992411c979a68ee03::bag {
    struct BalanceBag has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        whitelisted_addresses: vector<address>,
    }

    struct BagOwnerCap has key {
        id: 0x2::object::UID,
    }

    public entry fun swap<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: bool, arg5: bool, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg4) {
            4295048016
        } else {
            79226673515401279992447579055
        };
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, arg4, arg5, arg6, v0, arg8);
        let v4 = v3;
        let v5 = v2;
        let v6 = v1;
        if (arg4) {
        };
        let (v7, v8) = if (arg4) {
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v4), arg9)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v4), arg9)))
        };
        0x2::coin::join<T1>(&mut arg3, 0x2::coin::from_balance<T1>(v5, arg9));
        0x2::coin::join<T0>(&mut arg2, 0x2::coin::from_balance<T0>(v6, arg9));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, v7, v8, v4);
        if (arg4) {
            assert!(check_min_amount_out(arg7, 0x2::coin::value<T1>(&arg3)), 2);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg3, 0x2::tx_context::sender(arg9));
            0x2::coin::destroy_zero<T0>(arg2);
        } else {
            assert!(check_min_amount_out(arg7, 0x2::coin::value<T0>(&arg2)), 2);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, 0x2::tx_context::sender(arg9));
            0x2::coin::destroy_zero<T1>(arg3);
        };
    }

    public fun add_fund(arg0: &mut BalanceBag, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.balance, arg1);
    }

    public entry fun add_whitelist(arg0: &BagOwnerCap, arg1: &mut BalanceBag, arg2: vector<address>) {
        0x1::vector::append<address>(&mut arg1.whitelisted_addresses, arg2);
    }

    fun check_min_amount_out(arg0: u64, arg1: u64) : bool {
        arg1 > arg0
    }

    public entry fun collect_all(arg0: &BagOwnerCap, arg1: &mut BalanceBag, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.balance, 0x2::balance::value<0x2::sui::SUI>(&arg1.balance), arg2), 0x2::tx_context::sender(arg2));
    }

    public fun get_fund(arg0: &mut BalanceBag, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(is_whitelisted(arg0, 0x2::tx_context::sender(arg2)), 1);
        0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, arg1, arg2)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = BalanceBag{
            id                    : 0x2::object::new(arg0),
            balance               : 0x2::balance::zero<0x2::sui::SUI>(),
            whitelisted_addresses : 0x1::vector::empty<address>(),
        };
        0x2::transfer::share_object<BalanceBag>(v0);
        let v1 = BagOwnerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<BagOwnerCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_whitelisted(arg0: &BalanceBag, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.whitelisted_addresses, &arg1)
    }

    // decompiled from Move bytecode v6
}

