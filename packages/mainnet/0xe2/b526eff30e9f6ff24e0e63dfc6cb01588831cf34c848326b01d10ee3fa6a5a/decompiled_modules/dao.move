module 0xe2b526eff30e9f6ff24e0e63dfc6cb01588831cf34c848326b01d10ee3fa6a5a::dao {
    struct DAO<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        start_time: u64,
        end_time: u64,
        lp_lock_duration: u64,
        lp_unlock_time: u64,
        cap: u64,
        cap_per_address: u64,
        whitelist_cap: u64,
        owner: address,
        only_whitelist_time: u64,
        whitelisted_addresses: 0x2::table::Table<address, bool>,
        raised_investors: 0x2::table::Table<address, u64>,
        is_finalized: bool,
        funded_amount: u64,
        payment_amount: u64,
        raise_amount_add_liquidity: u64,
        payment_amount_add_liquidity: u64,
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

    struct DAOCreated<phantom T0, phantom T1> has copy, drop {
        dao_address: address,
        start_time: u64,
        end_time: u64,
        lp_lock_duration: u64,
        cap: u64,
        owner: address,
        only_whitelist_time: u64,
        payment_amount: u64,
    }

    struct Funded<phantom T0, phantom T1> has copy, drop {
        dao_address: address,
        timestamp: u64,
        amount: u64,
        raise_coin_address: address,
        sender: address,
        voucher_address: address,
    }

    struct DAOFinalized<phantom T0, phantom T1> has copy, drop {
        dao_address: address,
        timestamp: u64,
        cetus_pool_address: address,
        initialize_price: u128,
    }

    struct DAOClaimed<phantom T0, phantom T1> has copy, drop {
        dao_address: address,
        voucher_address: address,
        amount_raise: u64,
        amount_payment: u64,
        recipient: address,
    }

    fun swap<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x2::balance::Balance<T0>, arg3: &mut 0x2::balance::Balance<T1>, arg4: bool, arg5: u64, arg6: u128, arg7: &0x2::clock::Clock) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, arg4, true, arg5, arg6, arg7);
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

    fun add<T0, T1>(arg0: &mut DAO<T0, T1>, arg1: vector<address>) {
        while (!0x1::vector::is_empty<address>(&arg1)) {
            0x2::table::add<address, bool>(&mut arg0.whitelisted_addresses, 0x1::vector::pop_back<address>(&mut arg1), true);
        };
    }

    public fun claim_dao<T0, T1>(arg0: &mut DAO<T0, T1>, arg1: DAOVoucher<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_finalized, 5);
        assert!(0x2::object::uid_to_bytes(&arg0.id) == 0x2::object::id_to_bytes(&arg1.dao_id), 9);
        let v0 = (arg1.owned_amount as u128) * (arg0.payment_amount as u128) / (arg0.funded_amount as u128);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut arg0.payment_balance, (v0 as u64), arg2), 0x2::tx_context::sender(arg2));
        let DAOVoucher {
            id           : v1,
            dao_id       : _,
            owned_amount : v3,
        } = arg1;
        let v4 = v1;
        0x2::object::delete(v4);
        let v5 = DAOClaimed<T0, T1>{
            dao_address     : 0x2::object::uid_to_address(&arg0.id),
            voucher_address : 0x2::object::uid_to_address(&v4),
            amount_raise    : v3,
            amount_payment  : (v0 as u64),
            recipient       : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<DAOClaimed<T0, T1>>(v5);
    }

    public entry fun create_dao<T0, T1>(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: vector<address>, arg7: 0x2::coin::Coin<T1>, arg8: u64, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 >= arg3, 1);
        let v0 = 0x2::balance::value<T1>(0x2::coin::balance<T1>(&arg7));
        let v1 = 0x2::tx_context::sender(arg11);
        let v2 = DAO<T0, T1>{
            id                           : 0x2::object::new(arg11),
            start_time                   : arg0,
            end_time                     : arg1,
            lp_lock_duration             : arg8,
            lp_unlock_time               : 0,
            cap                          : arg2,
            cap_per_address              : arg3,
            whitelist_cap                : arg4,
            owner                        : v1,
            only_whitelist_time          : arg5,
            whitelisted_addresses        : 0x2::table::new<address, bool>(arg11),
            raised_investors             : 0x2::table::new<address, u64>(arg11),
            is_finalized                 : false,
            funded_amount                : 0,
            payment_amount               : v0,
            raise_amount_add_liquidity   : arg9,
            payment_amount_add_liquidity : arg10,
            raised_balance               : 0x2::balance::zero<T0>(),
            payment_balance              : 0x2::coin::into_balance<T1>(arg7),
            investment                   : 0x2::bag::new(arg11),
            investment_index             : 1,
        };
        let v3 = &mut v2;
        add<T0, T1>(v3, arg6);
        0x2::transfer::share_object<DAO<T0, T1>>(v2);
        let v4 = DAOCreated<T0, T1>{
            dao_address         : 0x2::object::uid_to_address(&v2.id),
            start_time          : arg0,
            end_time            : arg1,
            lp_lock_duration    : arg8,
            cap                 : arg2,
            owner               : v1,
            only_whitelist_time : arg5,
            payment_amount      : v0,
        };
        0x2::event::emit<DAOCreated<T0, T1>>(v4);
    }

    public fun dao_bag<T0, T1, T2>(arg0: &DAO<T0, T1>, arg1: u64) : u64 {
        0x2::balance::value<T2>(0x2::bag::borrow<u64, 0x2::balance::Balance<T2>>(&arg0.investment, arg1))
    }

    public fun dao_cap<T0, T1>(arg0: &DAO<T0, T1>) : u64 {
        arg0.cap
    }

    public fun dao_end_time<T0, T1>(arg0: &DAO<T0, T1>) : u64 {
        arg0.end_time
    }

    public fun dao_funded_amount<T0, T1>(arg0: &DAO<T0, T1>) : u64 {
        arg0.funded_amount
    }

    public fun dao_is_finalized<T0, T1>(arg0: &DAO<T0, T1>) : bool {
        arg0.is_finalized
    }

    public fun dao_lp_lock_duration<T0, T1>(arg0: &DAO<T0, T1>) : u64 {
        arg0.lp_lock_duration
    }

    public fun dao_lp_unlock_time<T0, T1>(arg0: &DAO<T0, T1>) : u64 {
        arg0.lp_unlock_time
    }

    public fun dao_only_whitelist_time<T0, T1>(arg0: &DAO<T0, T1>) : u64 {
        arg0.only_whitelist_time
    }

    public fun dao_owner<T0, T1>(arg0: &DAO<T0, T1>) : address {
        arg0.owner
    }

    public fun dao_payment_amount<T0, T1>(arg0: &DAO<T0, T1>) : u64 {
        arg0.payment_amount
    }

    public fun dao_payment_balance<T0, T1>(arg0: &DAO<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.payment_balance)
    }

    public fun dao_raised_balance<T0, T1>(arg0: &DAO<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.raised_balance)
    }

    public fun dao_start_time<T0, T1>(arg0: &DAO<T0, T1>) : u64 {
        arg0.start_time
    }

    public fun dao_voucher_dao_id<T0, T1>(arg0: &DAOVoucher<T0, T1>) : 0x2::object::ID {
        arg0.dao_id
    }

    public fun dao_voucher_owned_amount<T0, T1>(arg0: &DAOVoucher<T0, T1>) : u64 {
        arg0.owned_amount
    }

    fun effective_amount<T0, T1>(arg0: &mut DAO<T0, T1>, arg1: address, arg2: u64, arg3: bool) : u64 {
        let v0 = arg2;
        if (arg3 && arg2 + arg0.funded_amount > arg0.whitelist_cap) {
            v0 = arg0.whitelist_cap - arg0.funded_amount;
        };
        if (v0 + arg0.funded_amount > arg0.cap) {
            v0 = arg0.cap - arg0.funded_amount;
        };
        if (arg0.cap_per_address == 0) {
            return v0
        };
        if (!0x2::table::contains<address, u64>(&arg0.raised_investors, arg1)) {
            0x2::table::add<address, u64>(&mut arg0.raised_investors, arg1, 0);
        };
        let v1 = 0x2::table::borrow_mut<address, u64>(&mut arg0.raised_investors, arg1);
        if (v0 + *v1 > arg0.cap_per_address) {
            v0 = arg0.cap_per_address - *v1;
        };
        assert!(v0 != 0, 12);
        *v1 = *v1 + v0;
        v0
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

    public entry fun finalize_dao<T0, T1>(arg0: &mut DAO<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg3: &0x2::coin::CoinMetadata<T0>, arg4: &0x2::coin::CoinMetadata<T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg6), 4);
        assert!(!arg0.is_finalized, 6);
        assert!(0x2::balance::value<T0>(&arg0.raised_balance) == arg0.funded_amount, 5);
        arg0.is_finalized = true;
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v1 = 0x1::ascii::as_bytes(&v0);
        let v2 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        let v3 = 0x1::ascii::as_bytes(&v2);
        let v4 = 0;
        let v5 = false;
        while (v4 < 0x1::vector::length<u8>(v1)) {
            let v6 = *0x1::vector::borrow<u8>(v1, v4);
            let v7 = *0x1::vector::borrow<u8>(v3, v4);
            if (v7 < v6) {
                break
            };
            if (v7 > v6) {
                v5 = true;
                break
            };
            v4 = v4 + 1;
        };
        let (v8, v9) = if (v5) {
            let v10 = sqrt(340282366920938463463374607431768211456 * (arg0.raise_amount_add_liquidity as u256) / (arg0.payment_amount_add_liquidity as u256));
            let (v11, v12, v13) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::create_pool_v2<T1, T0>(arg1, arg2, 60, v10, 0x1::string::utf8(b""), 4294523716, 443580, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.payment_balance, arg0.payment_amount_add_liquidity), arg6), 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.raised_balance, arg0.raise_amount_add_liquidity), arg6), arg4, arg3, true, arg5, arg6);
            let v14 = v11;
            let v15 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(&v14);
            0x2::balance::join<T0>(&mut arg0.raised_balance, 0x2::coin::into_balance<T0>(v13));
            0x2::balance::join<T1>(&mut arg0.payment_balance, 0x2::coin::into_balance<T1>(v12));
            0x2::bag::add<u64, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.investment, 0, v14);
            (v10, 0x2::object::id_to_address(&v15))
        } else {
            let v16 = sqrt(340282366920938463463374607431768211456 * (arg0.payment_amount_add_liquidity as u256) / (arg0.raise_amount_add_liquidity as u256));
            let (v17, v18, v19) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::create_pool_v2<T0, T1>(arg1, arg2, 60, v16, 0x1::string::utf8(b""), 4294523716, 443580, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.raised_balance, arg0.raise_amount_add_liquidity), arg6), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.payment_balance, arg0.payment_amount_add_liquidity), arg6), arg3, arg4, false, arg5, arg6);
            let v20 = v17;
            let v21 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(&v20);
            0x2::balance::join<T0>(&mut arg0.raised_balance, 0x2::coin::into_balance<T0>(v18));
            0x2::balance::join<T1>(&mut arg0.payment_balance, 0x2::coin::into_balance<T1>(v19));
            0x2::bag::add<u64, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.investment, 0, v20);
            (v16, 0x2::object::id_to_address(&v21))
        };
        arg0.lp_unlock_time = 0x2::clock::timestamp_ms(arg5) + arg0.lp_lock_duration;
        arg0.payment_amount = 0x2::balance::value<T1>(&arg0.payment_balance);
        let v22 = DAOFinalized<T0, T1>{
            dao_address        : 0x2::object::id_address<DAO<T0, T1>>(arg0),
            timestamp          : 0x2::clock::timestamp_ms(arg5),
            cetus_pool_address : v9,
            initialize_price   : v8,
        };
        0x2::event::emit<DAOFinalized<T0, T1>>(v22);
    }

    public entry fun fund_dao<T0, T1>(arg0: &mut DAO<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(!arg0.is_finalized, 6);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        assert!(v1 >= arg0.start_time && v1 <= arg0.end_time, 2);
        let v2 = false;
        if (v1 < arg0.only_whitelist_time && arg0.funded_amount < arg0.whitelist_cap) {
            assert!(is_whitelisted<T0, T1>(arg0, v0), 1);
            v2 = true;
        };
        let v3 = effective_amount<T0, T1>(arg0, v0, 0x2::balance::value<T0>(0x2::coin::balance<T0>(&arg1)), v2);
        arg0.funded_amount = arg0.funded_amount + v3;
        0x2::balance::join<T0>(&mut arg0.raised_balance, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg1, v3, arg3)));
        let v4 = DAOVoucher<T0, T1>{
            id           : 0x2::object::new(arg3),
            dao_id       : 0x2::object::id_from_bytes(0x2::object::uid_to_bytes(&arg0.id)),
            owned_amount : v3,
        };
        0x2::transfer::public_transfer<DAOVoucher<T0, T1>>(v4, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, v0);
        let v5 = Funded<T0, T1>{
            dao_address        : 0x2::object::uid_to_address(&arg0.id),
            timestamp          : v1,
            amount             : v3,
            raise_coin_address : 0x2::object::id_address<0x2::coin::Coin<T0>>(&arg1),
            sender             : v0,
            voucher_address    : 0x2::object::id_address<DAOVoucher<T0, T1>>(&v4),
        };
        0x2::event::emit<Funded<T0, T1>>(v5);
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
        swap<T2, T0>(arg1, arg2, v3, v4, false, 0x2::balance::value<T0>(&v1), arg5, arg6);
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
        swap<T0, T2>(arg1, arg2, v3, v4, true, 0x2::balance::value<T0>(&v1), arg5, arg6);
        assert!(0x2::balance::value<T2>(&v2) > arg4, 8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v1, arg7), v0);
        0x2::bag::add<u64, 0x2::balance::Balance<T2>>(&mut arg0.investment, arg0.investment_index, v2);
        arg0.investment_index = arg0.investment_index + 1;
    }

    public fun is_whitelisted<T0, T1>(arg0: &mut DAO<T0, T1>, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.whitelisted_addresses, arg1)
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
        swap<T2, T0>(arg1, arg2, v1, v4, true, v3, arg5, arg6);
        assert!(0x2::balance::value<T0>(&v2) > arg4, 8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::take<T2>(v1, 0x2::balance::value<T2>(v1), arg7), v0);
        0x2::balance::join<T0>(&mut arg0.raised_balance, v2);
    }

    public fun sell_forward<T0, T1, T2>(arg0: &mut DAO<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg3: u64, arg4: u64, arg5: u128, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(arg0.owner == v0, 4);
        assert!(arg0.is_finalized, 5);
        let v1 = 0x2::bag::borrow_mut<u64, 0x2::balance::Balance<T2>>(&mut arg0.investment, arg3);
        let v2 = 0x2::balance::zero<T0>();
        let v3 = 0x2::balance::value<T2>(v1);
        let v4 = &mut v2;
        swap<T0, T2>(arg1, arg2, v4, v1, false, v3, arg5, arg6);
        assert!(0x2::balance::value<T0>(&v2) > arg4, 8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::take<T2>(v1, 0x2::balance::value<T2>(v1), arg7), v0);
        0x2::balance::join<T0>(&mut arg0.raised_balance, v2);
    }

    fun sqrt(arg0: u256) : u128 {
        assert!(arg0 > 0, 1);
        let v0 = (arg0 + 1) / 2;
        while (v0 < arg0) {
            let v1 = v0 + arg0 / v0;
            v0 = v1 / 2;
        };
        (arg0 as u128)
    }

    public fun unlock_position<T0, T1>(arg0: &mut DAO<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 4);
        assert!(0x2::clock::timestamp_ms(arg1) > arg0.lp_unlock_time, 11);
        0x2::transfer::public_transfer<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(0x2::bag::remove<u64, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.investment, 0), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

