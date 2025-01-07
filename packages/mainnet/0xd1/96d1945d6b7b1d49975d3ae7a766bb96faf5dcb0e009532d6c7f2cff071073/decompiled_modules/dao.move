module 0xd196d1945d6b7b1d49975d3ae7a766bb96faf5dcb0e009532d6c7f2cff071073::dao {
    struct DAO<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        start_time: u64,
        end_time: u64,
        cap: u64,
        owner: address,
        whitelisted_addresses: vector<address>,
        is_whitelist: bool,
        is_finalized: bool,
        funded_amount: u64,
        payment_amount: u64,
        raised_balance: 0x2::balance::Balance<T0>,
        payment_balance: 0x2::balance::Balance<T1>,
        investment: 0x2::bag::Bag,
        investment_index: u64,
    }

    struct DAOVoucher<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        dao_id: 0x2::object::ID,
        owned_amount: u64,
    }

    fun swap<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x2::balance::Balance<T0>, arg3: &mut 0x2::balance::Balance<T1>, arg4: bool, arg5: u64, arg6: u64, arg7: u128, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, arg4, true, arg5, arg7, arg8);
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        if (arg4) {
        };
        let (v6, v7) = if (arg4) {
            (0x2::balance::split<T0>(arg2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::split<T1>(arg3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3)))
        };
        0x2::balance::join<T1>(arg3, v4);
        0x2::balance::join<T0>(arg2, v5);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, v6, v7, v3);
    }

    public fun claim_dao<T0, T1>(arg0: &mut DAO<T0, T1>, arg1: DAOVoucher<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_finalized, 5);
        assert!(0x2::object::uid_to_bytes(&arg0.id) == 0x2::object::id_to_bytes(&arg1.dao_id), 9);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut arg0.payment_balance, (((arg1.owned_amount as u128) * (arg0.payment_amount as u128) / (arg0.funded_amount as u128)) as u64), arg2), 0x2::tx_context::sender(arg2));
        let DAOVoucher {
            id           : v0,
            dao_id       : _,
            owned_amount : _,
        } = arg1;
        0x2::object::delete(v0);
    }

    public entry fun create_dao<T0, T1>(arg0: u64, arg1: u64, arg2: u64, arg3: vector<address>, arg4: 0x2::coin::Coin<T1>, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = DAO<T0, T1>{
            id                    : 0x2::object::new(arg6),
            start_time            : arg0,
            end_time              : arg1,
            cap                   : arg2,
            owner                 : 0x2::tx_context::sender(arg6),
            whitelisted_addresses : arg3,
            is_whitelist          : arg5,
            is_finalized          : false,
            funded_amount         : 0,
            payment_amount        : 0x2::balance::value<T1>(0x2::coin::balance<T1>(&arg4)),
            raised_balance        : 0x2::balance::zero<T0>(),
            payment_balance       : 0x2::coin::into_balance<T1>(arg4),
            investment            : 0x2::bag::new(arg6),
            investment_index      : 0,
        };
        0x2::transfer::share_object<DAO<T0, T1>>(v0);
    }

    public entry fun emergency_rescue<T0, T1>(arg0: &mut DAO<T0, T1>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.raised_balance, 0x2::balance::value<T0>(&arg0.raised_balance)), arg2), arg1);
    }

    public entry fun emergency_rescue_bag<T0, T1, T2>(arg0: &mut DAO<T0, T1>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg3), 4);
        let v0 = 0x2::bag::borrow_mut<u64, 0x2::balance::Balance<T2>>(&mut arg0.investment, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(0x2::balance::split<T2>(v0, 0x2::balance::value<T2>(v0)), arg3), arg2);
    }

    public entry fun finalize_dao<T0, T1>(arg0: &mut DAO<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 4);
        assert!(!arg0.is_finalized, 6);
        assert!(0x2::balance::value<T0>(&arg0.raised_balance) == arg0.funded_amount, 5);
        arg0.is_finalized = true;
    }

    public entry fun fund_dao<T0, T1>(arg0: &mut DAO<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        if (arg0.is_whitelist) {
            assert!(is_whitelisted<T0, T1>(arg0, v0), 1);
        };
        assert!(!arg0.is_finalized, 6);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        assert!(v1 >= arg0.start_time && v1 <= arg0.end_time, 2);
        let v2 = 0x2::balance::value<T0>(0x2::coin::balance<T0>(&arg1));
        assert!(arg0.funded_amount + v2 <= arg0.cap, 3);
        arg0.funded_amount = arg0.funded_amount + v2;
        0x2::balance::join<T0>(&mut arg0.raised_balance, 0x2::coin::into_balance<T0>(arg1));
        let v3 = DAOVoucher<T0, T1>{
            id           : 0x2::object::new(arg3),
            dao_id       : 0x2::object::id_from_bytes(0x2::object::uid_to_bytes(&arg0.id)),
            owned_amount : v2,
        };
        0x2::transfer::public_transfer<DAOVoucher<T0, T1>>(v3, v0);
    }

    public fun invest_backward<T0, T1, T2>(arg0: &mut DAO<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg3: u64, arg4: u64, arg5: u128, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(arg0.owner == v0, 4);
        assert!(arg0.is_finalized, 5);
        assert!(arg3 <= 100, 10);
        let v1 = 0x2::balance::split<T0>(&mut arg0.raised_balance, arg0.funded_amount * arg3 / 100);
        let v2 = 0x2::balance::zero<T2>();
        let v3 = &mut v2;
        let v4 = &mut v1;
        swap<T2, T0>(arg1, arg2, v3, v4, false, 0x2::balance::value<T0>(&v1), arg4, arg5, arg6, arg7);
        assert!(0x2::balance::value<T2>(&v2) > arg4, 8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v1, arg7), v0);
        0x2::bag::add<u64, 0x2::balance::Balance<T2>>(&mut arg0.investment, arg0.investment_index, v2);
        arg0.investment_index = arg0.investment_index + 1;
    }

    public fun invest_forward<T0, T1, T2>(arg0: &mut DAO<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg3: u64, arg4: u64, arg5: u128, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(arg0.owner == v0, 4);
        assert!(arg0.is_finalized, 5);
        assert!(arg3 <= 100, 10);
        let v1 = 0x2::balance::split<T0>(&mut arg0.raised_balance, arg0.funded_amount * arg3 / 100);
        let v2 = 0x2::balance::zero<T2>();
        let v3 = &mut v1;
        let v4 = &mut v2;
        swap<T0, T2>(arg1, arg2, v3, v4, true, 0x2::balance::value<T0>(&v1), arg4, arg5, arg6, arg7);
        assert!(0x2::balance::value<T2>(&v2) > arg4, 8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v1, arg7), v0);
        0x2::bag::add<u64, 0x2::coin::Coin<T2>>(&mut arg0.investment, arg0.investment_index, 0x2::coin::from_balance<T2>(v2, arg7));
        arg0.investment_index = arg0.investment_index + 1;
    }

    public fun is_whitelisted<T0, T1>(arg0: &DAO<T0, T1>, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.whitelisted_addresses, &arg1)
    }

    public fun refund_dao<T0, T1>(arg0: &mut DAO<T0, T1>, arg1: DAOVoucher<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_finalized, 6);
        assert!(0x2::clock::timestamp_ms(arg2) > arg0.end_time, 7);
        assert!(arg0.funded_amount < arg0.cap, 3);
        assert!(0x2::object::uid_to_bytes(&arg0.id) == 0x2::object::id_to_bytes(&arg1.dao_id), 9);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.raised_balance, arg1.owned_amount, arg3), 0x2::tx_context::sender(arg3));
        let DAOVoucher {
            id           : v0,
            dao_id       : _,
            owned_amount : _,
        } = arg1;
        0x2::object::delete(v0);
    }

    public fun sell_backward<T0, T1, T2>(arg0: &mut DAO<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg3: u64, arg4: u64, arg5: u128, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(arg0.owner == v0, 4);
        assert!(arg0.is_finalized, 5);
        let v1 = 0x2::bag::borrow_mut<u64, 0x2::balance::Balance<T2>>(&mut arg0.investment, arg3);
        let v2 = 0x2::balance::zero<T0>();
        let v3 = 0x2::balance::value<T2>(v1);
        let v4 = &mut v2;
        swap<T2, T0>(arg1, arg2, v1, v4, true, v3, arg4, arg5, arg6, arg7);
        assert!(0x2::balance::value<T0>(&v2) > arg4, 8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::take<T2>(v1, 0x2::balance::value<T2>(v1), arg7), v0);
        0x2::balance::join<T0>(&mut arg0.raised_balance, v2);
    }

    // decompiled from Move bytecode v6
}

