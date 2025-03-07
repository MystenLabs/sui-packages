module 0xa9adbc199f55b1f6df3cba649874ec63e551919e2b984b44f22772dadb31a6f6::easy_swap {
    struct EASY_SWAP has drop {
        dummy_field: bool,
    }

    struct EasySwapConfig has store, key {
        id: 0x2::object::UID,
        owner: address,
        fee_recipient: address,
        fee: u64,
        admin_public_key: vector<u8>,
        signatures: 0x2::table::Table<vector<u8>, bool>,
    }

    public fun adjust_config(arg0: &mut EasySwapConfig, arg1: address, arg2: u64, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg4), 1);
        arg0.fee_recipient = arg1;
        arg0.fee = arg2;
        arg0.admin_public_key = arg3;
    }

    public fun easy_swap_A<T0, T1>(arg0: &mut EasySwapConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: vector<u8>, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg0.signatures, arg6), 3);
        assert!(0x2::bls12381::bls12381_min_pk_verify(&arg6, &arg0.admin_public_key, &arg5) == true, 2);
        0x2::table::add<vector<u8>, bool>(&mut arg0.signatures, arg6, true);
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = 0x2::balance::zero<T1>();
        let v2 = 0x2::coin::into_balance<T0>(arg3);
        let v3 = &mut v2;
        let v4 = &mut v1;
        swap_cetus<T0, T1>(arg1, arg2, v3, v4, true, true, 0x2::balance::value<T0>(&v2), 4295048016, arg7);
        if (arg4 != 0) {
            assert!(0x2::balance::value<T1>(&v1) > arg4, 0);
        };
        let v5 = 0x2::balance::zero<T0>();
        let v6 = &mut v5;
        let v7 = &mut v1;
        swap_cetus<T0, T1>(arg1, arg2, v6, v7, false, true, 0x2::balance::value<T1>(&v1), 79226673515401279992447579055, arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v2, arg8), v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v5, arg8), v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v1, arg8), v0);
    }

    public fun easy_swap_B<T0, T1>(arg0: &mut EasySwapConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: vector<u8>, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg0.signatures, arg6), 3);
        assert!(0x2::bls12381::bls12381_min_pk_verify(&arg6, &arg0.admin_public_key, &arg5) == true, 2);
        0x2::table::add<vector<u8>, bool>(&mut arg0.signatures, arg6, true);
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = 0x2::coin::into_balance<T1>(arg3);
        let v2 = 0x2::balance::zero<T0>();
        let v3 = &mut v2;
        let v4 = &mut v1;
        swap_cetus<T0, T1>(arg1, arg2, v3, v4, false, true, 0x2::balance::value<T1>(&v1), 79226673515401279992447579055, arg7);
        if (arg4 != 0) {
            assert!(0x2::balance::value<T0>(&v2) > arg4, 0);
        };
        let v5 = 0x2::balance::zero<T1>();
        let v6 = &mut v2;
        let v7 = &mut v5;
        swap_cetus<T0, T1>(arg1, arg2, v6, v7, true, true, 0x2::balance::value<T0>(&v2), 4295048016, arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v1, arg8), v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v2, arg8), v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v5, arg8), v0);
    }

    fun init(arg0: EASY_SWAP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = EasySwapConfig{
            id               : 0x2::object::new(arg1),
            owner            : v0,
            fee_recipient    : v0,
            fee              : 100,
            admin_public_key : 0x1::vector::empty<u8>(),
            signatures       : 0x2::table::new<vector<u8>, bool>(arg1),
        };
        0x2::transfer::share_object<EasySwapConfig>(v1);
    }

    fun swap_cetus<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x2::balance::Balance<T0>, arg3: &mut 0x2::balance::Balance<T1>, arg4: bool, arg5: bool, arg6: u64, arg7: u128, arg8: &0x2::clock::Clock) {
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

    // decompiled from Move bytecode v6
}

