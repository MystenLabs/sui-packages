module 0x62cf6ce0b8c1173b561295d6d0ae459be5a7a22bac4660a327365a2433201cc8::bag {
    struct BalanceBag has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        whitelisted_addresses: vector<address>,
    }

    struct BagOwnerCap has key {
        id: 0x2::object::UID,
    }

    public entry fun swap<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: vector<0x2::coin::Coin<T0>>, arg3: vector<0x2::coin::Coin<T1>>, arg4: bool, arg5: bool, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg4) {
            4295048016
        } else {
            79226673515401279992447579055
        };
        let v1 = merge_coins<T0>(arg2, arg9);
        let v2 = merge_coins<T1>(arg3, arg9);
        let (v3, v4, v5) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, arg4, arg5, arg6, v0, arg8);
        let v6 = v5;
        let v7 = v4;
        let v8 = v3;
        if (arg4) {
        };
        let (v9, v10) = if (arg4) {
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v1, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v6), arg9)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v6), arg9)))
        };
        0x2::coin::join<T1>(&mut v2, 0x2::coin::from_balance<T1>(v7, arg9));
        0x2::coin::join<T0>(&mut v1, 0x2::coin::from_balance<T0>(v8, arg9));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, v9, v10, v6);
        if (arg4) {
            assert!(check_min_amount_out(arg7, 0x2::coin::value<T1>(&v2)), 2);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v2, 0x2::tx_context::sender(arg9));
            0x2::coin::destroy_zero<T0>(v1);
        } else {
            assert!(check_min_amount_out(arg7, 0x2::coin::value<T0>(&v1)), 2);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg9));
            0x2::coin::destroy_zero<T1>(v2);
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

    fun merge_coins<T0>(arg0: vector<0x2::coin::Coin<T0>>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        if (0x1::vector::length<0x2::coin::Coin<T0>>(&arg0) == 0) {
            0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg0);
            0x2::coin::zero<T0>(arg1)
        } else {
            let v1 = 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg0);
            0x2::pay::join_vec<T0>(&mut v1, arg0);
            v1
        }
    }

    // decompiled from Move bytecode v6
}

