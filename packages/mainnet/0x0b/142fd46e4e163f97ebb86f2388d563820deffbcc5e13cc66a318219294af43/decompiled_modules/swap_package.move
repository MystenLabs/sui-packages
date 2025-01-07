module 0xb142fd46e4e163f97ebb86f2388d563820deffbcc5e13cc66a318219294af43::swap_package {
    struct CoinWallet<phantom T0> has key {
        id: 0x2::object::UID,
        token: 0x2::balance::Balance<T0>,
    }

    struct WalletEvent has copy, drop {
        tag: u8,
        balance: u64,
    }

    struct SwapEvent has copy, drop {
        a2b: bool,
        by_amount_in: bool,
        amount: u64,
        sqrt_price_limit: u128,
        recipient: address,
        a_amount: u64,
        b_amount: u64,
    }

    struct FlashSwapRespEvent has copy, drop {
        a2b: bool,
        by_amount_in: bool,
        amount: u64,
        min_out_amount: u64,
        sqrt_price_limit: u128,
        recipient: address,
        a_amount: u64,
        b_amount: u64,
        in_amount: u64,
        out_amount: u64,
    }

    struct PoolSimpleInfoEvent has copy, drop {
        pool_id: 0x2::object::ID,
        pool_key: 0x2::object::ID,
        coin_type_a: 0x1::type_name::TypeName,
        coin_type_b: 0x1::type_name::TypeName,
        tick_spacing: u32,
        tag: u32,
    }

    struct MsgEvent has copy, drop {
        msg: 0x1::string::String,
        address: address,
    }

    struct WhiteList has key {
        id: 0x2::object::UID,
        address_list: vector<address>,
    }

    struct PoolSimpleInfo has copy, drop, store {
        pool_id: 0x2::object::ID,
        pool_key: 0x2::object::ID,
        coin_type_a: 0x1::type_name::TypeName,
        coin_type_b: 0x1::type_name::TypeName,
        tick_spacing: u32,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun swap<T0, T1>(arg0: &WhiteList, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut CoinWallet<T0>, arg4: &mut CoinWallet<T1>, arg5: bool, arg6: bool, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: address, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 4295048016;
        if (!arg5) {
            v0 = 79226673515401279992447579055;
        };
        let v1 = 0x2::tx_context::sender(arg11);
        assert!(white_list_check(arg0, &v1), 503);
        let v2 = if (arg5) {
            arg7
        } else {
            0
        };
        let v3 = if (!arg5) {
            arg7
        } else {
            0
        };
        let v4 = 0x2::coin::take<T0>(&mut arg3.token, v2, arg11);
        let v5 = 0x2::coin::take<T1>(&mut arg4.token, v3, arg11);
        let (v6, v7, v8) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, arg5, arg6, arg7, v0, arg9);
        let v9 = v8;
        let v10 = v7;
        let v11 = v6;
        if (arg5) {
        };
        assert!(white_list_check(arg0, &v1), 503);
        let (v12, v13) = if (arg5) {
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v9), arg11)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v5, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v9), arg11)))
        };
        0x2::coin::join<T1>(&mut v5, 0x2::coin::from_balance<T1>(v10, arg11));
        0x2::coin::join<T0>(&mut v4, 0x2::coin::from_balance<T0>(v11, arg11));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, v12, v13, v9);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v5, arg10);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, arg10);
    }

    public fun add_white_list(arg0: &AdminCap, arg1: &mut WhiteList, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x1::vector::push_back<address>(&mut arg1.address_list, arg2);
    }

    public fun create_coin_wallet<T0>(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = CoinWallet<T0>{
            id    : 0x2::object::new(arg1),
            token : 0x2::coin::into_balance<T0>(0x2::coin::zero<T0>(arg1)),
        };
        0x2::transfer::share_object<CoinWallet<T0>>(v0);
    }

    public entry fun deposit<T0>(arg0: &mut CoinWallet<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::value<T0>(&arg0.token);
        0x2::balance::join<T0>(&mut arg0.token, 0x2::coin::into_balance<T0>(arg1));
        0x2::balance::value<T0>(&arg0.token);
    }

    public fun fetch_pools<T0, T1>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg1: u64) {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::fetch_pools(arg0, 0x1::vector::empty<0x2::object::ID>(), arg1);
        let v1 = 0;
        loop {
            v1 = v1 + 1;
            if (v1 > 0x1::vector::length<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolSimpleInfo>(&v0)) {
                break
            };
            let v2 = 0x1::vector::pop_back<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolSimpleInfo>(&mut v0);
            let (v3, v4) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::coin_types(&v2);
            if (v3 == 0x1::type_name::get<T0>() && v4 == 0x1::type_name::get<T1>()) {
                let v5 = PoolSimpleInfoEvent{
                    pool_id      : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::pool_id(&v2),
                    pool_key     : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::pool_key(&v2),
                    coin_type_a  : v3,
                    coin_type_b  : v4,
                    tick_spacing : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::tick_spacing(&v2),
                    tag          : 200001,
                };
                0x2::event::emit<PoolSimpleInfoEvent>(v5);
            };
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CoinWallet<0x2::sui::SUI>{
            id    : 0x2::object::new(arg0),
            token : 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::zero<0x2::sui::SUI>(arg0)),
        };
        0x2::transfer::share_object<CoinWallet<0x2::sui::SUI>>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
        let v2 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v2, 0x2::tx_context::sender(arg0));
        let v3 = WhiteList{
            id           : 0x2::object::new(arg0),
            address_list : v2,
        };
        0x2::transfer::share_object<WhiteList>(v3);
    }

    public fun swap_a2b<T0, T1>(arg0: &WhiteList, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut CoinWallet<T0>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: address, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = true;
        let v1 = 0x2::tx_context::sender(arg8);
        assert!(white_list_check(arg0, &v1), 503);
        let v2 = if (v0) {
            arg4
        } else {
            0
        };
        let v3 = 0x2::coin::take<T0>(&mut arg3.token, v2, arg8);
        let v4 = 0x2::coin::zero<T1>(arg8);
        let (v5, v6, v7) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, v0, true, arg4, 4295048016, arg6);
        let v8 = v7;
        let v9 = v6;
        assert!(0x2::balance::value<T1>(&v9) > arg5, 502);
        0x2::coin::join<T1>(&mut v4, 0x2::coin::from_balance<T1>(v9, arg8));
        0x2::coin::join<T0>(&mut v3, 0x2::coin::from_balance<T0>(v5, arg8));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v8), arg8)), 0x2::balance::zero<T1>(), v8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v4, arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, arg7);
    }

    public fun swap_b2a<T0, T1>(arg0: &WhiteList, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut CoinWallet<T1>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: address, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = false;
        let v1 = 0x2::tx_context::sender(arg8);
        assert!(white_list_check(arg0, &v1), 503);
        let v2 = if (!v0) {
            arg4
        } else {
            0
        };
        let v3 = 0x2::coin::zero<T0>(arg8);
        let v4 = 0x2::coin::take<T1>(&mut arg3.token, v2, arg8);
        let (v5, v6, v7) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, v0, true, arg4, 79226673515401279992447579055, arg6);
        let v8 = v7;
        let v9 = v5;
        assert!(0x2::balance::value<T0>(&v9) > arg5, 502);
        0x2::coin::join<T1>(&mut v4, 0x2::coin::from_balance<T1>(v6, arg8));
        0x2::coin::join<T0>(&mut v3, 0x2::coin::from_balance<T0>(v9, arg8));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v4, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v8), arg8)), v8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v4, arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, arg7);
    }

    public fun swap_bac_by_ab_ac<T0, T1, T2>(arg0: &WhiteList, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg4: &mut CoinWallet<T1>, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: address, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = true;
        let v1 = 0x2::tx_context::sender(arg9);
        assert!(white_list_check(arg0, &v1), 503);
        let v2 = 0x2::coin::take<T1>(&mut arg4.token, arg5, arg9);
        let v3 = 0x2::coin::zero<T0>(arg9);
        let v4 = 0x2::coin::zero<T2>(arg9);
        let (v5, v6, v7) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, false, v0, arg5, 79226673515401279992447579055, arg7);
        let v8 = v7;
        let v9 = v5;
        0x2::coin::join<T1>(&mut v2, 0x2::coin::from_balance<T1>(v6, arg9));
        0x2::coin::join<T0>(&mut v3, 0x2::coin::from_balance<T0>(v9, arg9));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v8), arg9)), v8);
        let (v10, v11, v12) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T2>(arg1, arg3, true, v0, 0x2::balance::value<T0>(&v9), 4295048016, arg7);
        let v13 = v12;
        let v14 = v11;
        assert!(0x2::balance::value<T2>(&v14) > arg6, 502);
        0x2::coin::join<T0>(&mut v3, 0x2::coin::from_balance<T0>(v10, arg9));
        0x2::coin::join<T2>(&mut v4, 0x2::coin::from_balance<T2>(v14, arg9));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T2>(arg1, arg3, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T2>(&v13), arg9)), 0x2::balance::zero<T2>(), v13);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v2, arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v4, arg8);
    }

    public fun swap_bac_by_ab_ca<T0, T1, T2>(arg0: &WhiteList, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg4: &mut CoinWallet<T1>, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: address, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = true;
        let v1 = 0x2::tx_context::sender(arg9);
        let v2 = 79226673515401279992447579055;
        assert!(white_list_check(arg0, &v1), 503);
        let v3 = 0x2::coin::take<T1>(&mut arg4.token, arg5, arg9);
        let v4 = 0x2::coin::zero<T0>(arg9);
        let v5 = 0x2::coin::zero<T2>(arg9);
        let (v6, v7, v8) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, false, v0, arg5, v2, arg7);
        let v9 = v8;
        let v10 = v6;
        0x2::coin::join<T1>(&mut v3, 0x2::coin::from_balance<T1>(v7, arg9));
        0x2::coin::join<T0>(&mut v4, 0x2::coin::from_balance<T0>(v10, arg9));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v9), arg9)), v9);
        let (v11, v12, v13) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T2, T0>(arg1, arg3, false, v0, 0x2::balance::value<T0>(&v10), v2, arg7);
        let v14 = v13;
        let v15 = v11;
        assert!(0x2::balance::value<T2>(&v15) > arg6, 502);
        0x2::coin::join<T2>(&mut v5, 0x2::coin::from_balance<T2>(v15, arg9));
        0x2::coin::join<T0>(&mut v4, 0x2::coin::from_balance<T0>(v12, arg9));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T2, T0>(arg1, arg3, 0x2::balance::zero<T2>(), 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v4, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T2, T0>(&v14), arg9)), v14);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v3, arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v5, arg8);
    }

    fun white_list_check(arg0: &WhiteList, arg1: &address) : bool {
        0x1::vector::contains<address>(&arg0.address_list, arg1)
    }

    public entry fun withdraw<T0>(arg0: &AdminCap, arg1: &mut CoinWallet<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = WalletEvent{
            tag     : 0,
            balance : 0x2::balance::value<T0>(&arg1.token),
        };
        0x2::event::emit<WalletEvent>(v0);
        assert!(0x2::balance::value<T0>(&arg1.token) >= arg2, 501);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.token, arg2, arg3), 0x2::tx_context::sender(arg3));
        let v1 = WalletEvent{
            tag     : 1,
            balance : 0x2::balance::value<T0>(&arg1.token),
        };
        0x2::event::emit<WalletEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

