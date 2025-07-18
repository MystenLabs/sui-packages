module 0x5f5e87964616e01e2f606bf24415863914fcfb4985256c203d1c07407fb3977::dao {
    struct DAO<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        start_time: u64,
        end_time: u64,
        lp_lock_duration: u64,
        lp_unlock_time: u64,
        cap: u64,
        cap_per_address: u64,
        total_whitelist_cap: u64,
        owner: address,
        only_whitelist_time: u64,
        whitelisted_addresses: 0x2::table::Table<address, u64>,
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
        admin_public_key: vector<u8>,
        signatures: 0x2::table::Table<vector<u8>, bool>,
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
        raise_amount_add_liquidity: u64,
        payment_amount_add_liquidity: u64,
    }

    struct AdminPublicKeyAdded<phantom T0, phantom T1> has copy, drop {
        admim_public_key: vector<u8>,
    }

    struct Funded<phantom T0, phantom T1> has copy, drop {
        dao_address: address,
        timestamp: u64,
        amount: u64,
        raise_coin_address: address,
        sender: address,
        voucher_address: address,
        reached_whitelist_cap: bool,
    }

    struct DAOFinalized<phantom T0, phantom T1> has copy, drop {
        dao_address: address,
        finalize_time: u64,
        lp_unlock_time: u64,
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

    struct DAORefunded<phantom T0, phantom T1> has copy, drop {
        dao_address: address,
        voucher_address: address,
        amount_raise: u64,
        recipient: address,
    }

    struct InvestedForward<phantom T0, phantom T1, phantom T2> has copy, drop {
        dao_address: address,
        amount_in: u64,
        amount_out: u64,
        investment_index: u64,
    }

    struct InvestedBackward<phantom T0, phantom T1, phantom T2> has copy, drop {
        dao_address: address,
        amount_in: u64,
        amount_out: u64,
        investment_index: u64,
    }

    struct SoldForward<phantom T0, phantom T1, phantom T2> has copy, drop {
        dao_address: address,
        amount_in: u64,
        amount_out: u64,
        investment_index: u64,
    }

    struct SoldBackward<phantom T0, phantom T1, phantom T2> has copy, drop {
        dao_address: address,
        amount_in: u64,
        amount_out: u64,
        investment_index: u64,
    }

    struct WhitelistUpdated<phantom T0, phantom T1> has copy, drop {
        dao_address: address,
    }

    struct SwappedExactInSingle<phantom T0, phantom T1, phantom T2, phantom T3> has copy, drop {
        dao_address: address,
        a2b: bool,
        amount_in: u64,
        amount_out: u64,
        sender: address,
    }

    struct SwappedExactOutSingle<phantom T0, phantom T1, phantom T2, phantom T3> has copy, drop {
        dao_address: address,
        a2b: bool,
        amount_in: u64,
        amount_out: u64,
        sender: address,
    }

    fun swap<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &mut 0x2::balance::Balance<T0>, arg3: &mut 0x2::balance::Balance<T1>, arg4: bool, arg5: u64, arg6: u128, arg7: &0x2::clock::Clock) {
        abort 0
    }

    fun add<T0, T1>(arg0: &mut DAO<T0, T1>, arg1: vector<address>, arg2: vector<u64>) {
        while (!0x1::vector::is_empty<address>(&arg1)) {
            0x2::table::add<address, u64>(&mut arg0.whitelisted_addresses, 0x1::vector::pop_back<address>(&mut arg1), 0x1::vector::pop_back<u64>(&mut arg2));
        };
        let v0 = WhitelistUpdated<T0, T1>{dao_address: 0x2::object::uid_to_address(&arg0.id)};
        0x2::event::emit<WhitelistUpdated<T0, T1>>(v0);
    }

    fun add_balance_to_dao<T0, T1, T2>(arg0: &mut DAO<T0, T1>, arg1: 0x2::balance::Balance<T2>) {
        check_exist_coin<T0, T1, T2>(arg0);
        0x2::balance::join<T2>(0x2::bag::borrow_mut<u64, 0x2::balance::Balance<T2>>(&mut arg0.investment, hash_type_to_u64<T2>()), arg1);
    }

    public fun add_whitelist<T0, T1>(arg0: &mut DAO<T0, T1>, arg1: vector<address>, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg3), 4);
        add<T0, T1>(arg0, arg1, arg2);
    }

    public fun check_exist_coin<T0, T1, T2>(arg0: &mut DAO<T0, T1>) {
        if (0x2::bag::contains_with_type<u64, 0x2::balance::Balance<T2>>(&arg0.investment, hash_type_to_u64<T2>())) {
            return
        };
        0x2::bag::add<u64, 0x2::balance::Balance<T2>>(&mut arg0.investment, hash_type_to_u64<T2>(), 0x2::balance::zero<T2>());
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

    public entry fun create_dao<T0, T1>(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: vector<address>, arg7: vector<u64>, arg8: 0x2::coin::Coin<T1>, arg9: u64, arg10: u64, arg11: u64, arg12: vector<u8>, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 >= arg10, 13);
        let v0 = 0x2::balance::value<T1>(0x2::coin::balance<T1>(&arg8));
        assert!(v0 >= arg11, 13);
        let v1 = 0x2::tx_context::sender(arg13);
        let v2 = DAO<T0, T1>{
            id                           : 0x2::object::new(arg13),
            start_time                   : arg0,
            end_time                     : arg1,
            lp_lock_duration             : arg9,
            lp_unlock_time               : 0,
            cap                          : arg2,
            cap_per_address              : arg3,
            total_whitelist_cap          : arg4,
            owner                        : v1,
            only_whitelist_time          : arg5,
            whitelisted_addresses        : 0x2::table::new<address, u64>(arg13),
            raised_investors             : 0x2::table::new<address, u64>(arg13),
            is_finalized                 : false,
            funded_amount                : 0,
            payment_amount               : v0,
            raise_amount_add_liquidity   : arg10,
            payment_amount_add_liquidity : arg11,
            raised_balance               : 0x2::balance::zero<T0>(),
            payment_balance              : 0x2::coin::into_balance<T1>(arg8),
            investment                   : 0x2::bag::new(arg13),
            investment_index             : 1,
            admin_public_key             : arg12,
            signatures                   : 0x2::table::new<vector<u8>, bool>(arg13),
        };
        let v3 = &mut v2;
        add<T0, T1>(v3, arg6, arg7);
        0x2::transfer::share_object<DAO<T0, T1>>(v2);
        let v4 = DAOCreated<T0, T1>{
            dao_address                  : 0x2::object::uid_to_address(&v2.id),
            start_time                   : arg0,
            end_time                     : arg1,
            lp_lock_duration             : arg9,
            cap                          : arg2,
            owner                        : v1,
            only_whitelist_time          : arg5,
            payment_amount               : v0,
            raise_amount_add_liquidity   : arg10,
            payment_amount_add_liquidity : arg11,
        };
        0x2::event::emit<DAOCreated<T0, T1>>(v4);
        let v5 = AdminPublicKeyAdded<T0, T1>{admim_public_key: arg12};
        0x2::event::emit<AdminPublicKeyAdded<T0, T1>>(v5);
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

    public fun deposit_to_dao<T0, T1, T2>(arg0: &mut DAO<T0, T1>, arg1: 0x2::coin::Coin<T2>) {
        check_exist_coin<T0, T1, T2>(arg0);
        0x2::balance::join<T2>(0x2::bag::borrow_mut<u64, 0x2::balance::Balance<T2>>(&mut arg0.investment, hash_type_to_u64<T2>()), 0x2::coin::into_balance<T2>(arg1));
    }

    fun effective_amount<T0, T1>(arg0: &mut DAO<T0, T1>, arg1: address, arg2: u64, arg3: bool) : u64 {
        let v0 = arg2;
        if (arg3 && arg2 + arg0.funded_amount > arg0.total_whitelist_cap) {
            v0 = arg0.total_whitelist_cap - arg0.funded_amount;
        };
        if (v0 + arg0.funded_amount > arg0.cap) {
            v0 = arg0.cap - arg0.funded_amount;
        };
        if (!0x2::table::contains<address, u64>(&arg0.raised_investors, arg1)) {
            0x2::table::add<address, u64>(&mut arg0.raised_investors, arg1, 0);
        };
        let v1 = 0x2::table::borrow_mut<address, u64>(&mut arg0.raised_investors, arg1);
        if (arg3 && v0 + *v1 > *0x2::table::borrow<address, u64>(&arg0.whitelisted_addresses, arg1)) {
            v0 = *0x2::table::borrow<address, u64>(&arg0.whitelisted_addresses, arg1) - *v1;
        };
        if (arg0.cap_per_address == 0) {
            return v0
        };
        if (!arg3 && v0 + *v1 > arg0.cap_per_address) {
            v0 = arg0.cap_per_address - *v1;
        };
        assert!(v0 != 0, 12);
        *v1 = *v1 + v0;
        v0
    }

    public entry fun emergency_rescue<T0, T1>(arg0: &mut DAO<T0, T1>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun emergency_rescue_bag<T0, T1, T2>(arg0: &mut DAO<T0, T1>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun exact_in_single<T0, T1, T2, T3>(arg0: &mut DAO<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg3: bool, arg4: u64, arg5: u64, arg6: u128, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        check_exist_coin<T0, T1, T2>(arg0);
        check_exist_coin<T0, T1, T3>(arg0);
        let (v0, v1) = if (arg3) {
            (0x2::balance::split<T2>(0x2::bag::borrow_mut<u64, 0x2::balance::Balance<T2>>(&mut arg0.investment, hash_type_to_u64<T2>()), arg4), 0x2::balance::zero<T3>())
        } else {
            (0x2::balance::zero<T2>(), 0x2::balance::split<T3>(0x2::bag::borrow_mut<u64, 0x2::balance::Balance<T3>>(&mut arg0.investment, hash_type_to_u64<T3>()), arg4))
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
        swap_cetus<T2, T3>(arg1, arg2, v4, v5, arg3, true, arg4, arg6, arg7);
        let v6 = if (arg3) {
            0x2::balance::value<T3>(&v2)
        } else {
            0x2::balance::value<T2>(&v3)
        };
        if (arg5 != 0) {
            assert!(v6 > arg5, 16);
        };
        add_balance_to_dao<T0, T1, T2>(arg0, v3);
        add_balance_to_dao<T0, T1, T3>(arg0, v2);
        let v7 = SwappedExactInSingle<T0, T1, T2, T3>{
            dao_address : 0x2::object::uid_to_address(&arg0.id),
            a2b         : arg3,
            amount_in   : arg4,
            amount_out  : v6,
            sender      : 0x2::tx_context::sender(arg8),
        };
        0x2::event::emit<SwappedExactInSingle<T0, T1, T2, T3>>(v7);
    }

    public fun exact_out_single<T0, T1, T2, T3>(arg0: &mut DAO<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg3: bool, arg4: u64, arg5: u64, arg6: u128, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        check_exist_coin<T0, T1, T2>(arg0);
        check_exist_coin<T0, T1, T3>(arg0);
        let (v0, v1) = if (arg3) {
            (0x2::balance::split<T2>(0x2::bag::borrow_mut<u64, 0x2::balance::Balance<T2>>(&mut arg0.investment, hash_type_to_u64<T2>()), arg4), 0x2::balance::zero<T3>())
        } else {
            (0x2::balance::zero<T2>(), 0x2::balance::split<T3>(0x2::bag::borrow_mut<u64, 0x2::balance::Balance<T3>>(&mut arg0.investment, hash_type_to_u64<T3>()), arg4))
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
        swap_cetus<T2, T3>(arg1, arg2, v4, v5, arg3, false, arg5, arg6, arg7);
        let v6 = if (arg3) {
            arg4 - 0x2::balance::value<T2>(&v3)
        } else {
            arg4 - 0x2::balance::value<T3>(&v2)
        };
        add_balance_to_dao<T0, T1, T2>(arg0, v3);
        add_balance_to_dao<T0, T1, T3>(arg0, v2);
        let v7 = SwappedExactOutSingle<T0, T1, T2, T3>{
            dao_address : 0x2::object::uid_to_address(&arg0.id),
            a2b         : arg3,
            amount_in   : v6,
            amount_out  : arg5,
            sender      : 0x2::tx_context::sender(arg8),
        };
        0x2::event::emit<SwappedExactOutSingle<T0, T1, T2, T3>>(v7);
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
        rasie_coin_to_bag<T0, T1>(arg0);
        let v22 = DAOFinalized<T0, T1>{
            dao_address        : 0x2::object::id_address<DAO<T0, T1>>(arg0),
            finalize_time      : 0x2::clock::timestamp_ms(arg5),
            lp_unlock_time     : arg0.lp_unlock_time,
            cetus_pool_address : v9,
            initialize_price   : v8,
        };
        0x2::event::emit<DAOFinalized<T0, T1>>(v22);
    }

    public entry fun fund_dao<T0, T1>(arg0: &mut DAO<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(!arg0.is_finalized, 6);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        assert!(v1 >= arg0.start_time && v1 <= arg0.end_time, 2);
        let v2 = false;
        let v3 = false;
        if (v1 < arg0.only_whitelist_time && arg0.funded_amount < arg0.total_whitelist_cap) {
            assert!(is_whitelisted<T0, T1>(arg0, v0), 1);
            v2 = true;
        } else {
            assert!(!0x2::table::contains<vector<u8>, bool>(&arg0.signatures, arg3), 14);
            assert!(0x2::bls12381::bls12381_min_pk_verify(&arg3, &arg0.admin_public_key, &arg2) == true, 15);
            0x2::table::add<vector<u8>, bool>(&mut arg0.signatures, arg3, true);
        };
        let v4 = effective_amount<T0, T1>(arg0, v0, 0x2::balance::value<T0>(0x2::coin::balance<T0>(&arg1)), v2);
        arg0.funded_amount = arg0.funded_amount + v4;
        if (v2 && arg0.funded_amount == arg0.total_whitelist_cap) {
            v3 = true;
        };
        0x2::balance::join<T0>(&mut arg0.raised_balance, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg1, v4, arg5)));
        let v5 = DAOVoucher<T0, T1>{
            id           : 0x2::object::new(arg5),
            dao_id       : 0x2::object::id_from_bytes(0x2::object::uid_to_bytes(&arg0.id)),
            owned_amount : v4,
        };
        0x2::transfer::public_transfer<DAOVoucher<T0, T1>>(v5, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, v0);
        let v6 = Funded<T0, T1>{
            dao_address           : 0x2::object::uid_to_address(&arg0.id),
            timestamp             : v1,
            amount                : v4,
            raise_coin_address    : 0x2::object::id_address<0x2::coin::Coin<T0>>(&arg1),
            sender                : v0,
            voucher_address       : 0x2::object::id_address<DAOVoucher<T0, T1>>(&v5),
            reached_whitelist_cap : v3,
        };
        0x2::event::emit<Funded<T0, T1>>(v6);
    }

    public fun hash_type_to_u64<T0>() : u64 {
        let v0 = 0x2::bcs::new(0x1::hash::sha3_256(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>()))));
        0x2::bcs::peel_u64(&mut v0)
    }

    public fun invest_backward<T0, T1, T2>(arg0: &mut DAO<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg3: u64, arg4: u64, arg5: u128, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun invest_forward<T0, T1, T2>(arg0: &mut DAO<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg3: u64, arg4: u64, arg5: u128, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun is_whitelisted<T0, T1>(arg0: &mut DAO<T0, T1>, arg1: address) : bool {
        0x2::table::contains<address, u64>(&arg0.whitelisted_addresses, arg1)
    }

    public fun migrate_to_v2<T0, T1>(arg0: &mut DAO<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 4);
        assert!(arg0.is_finalized, 5);
        rasie_coin_to_bag<T0, T1>(arg0);
    }

    fun rasie_coin_to_bag<T0, T1>(arg0: &mut DAO<T0, T1>) {
        let v0 = 0x2::balance::withdraw_all<T0>(&mut arg0.raised_balance);
        add_balance_to_dao<T0, T1, T0>(arg0, v0);
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
            owned_amount : v2,
        } = arg1;
        let v3 = v0;
        0x2::object::delete(v3);
        let v4 = DAORefunded<T0, T1>{
            dao_address     : 0x2::object::uid_to_address(&arg0.id),
            voucher_address : 0x2::object::uid_to_address(&v3),
            amount_raise    : v2,
            recipient       : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<DAORefunded<T0, T1>>(v4);
    }

    public fun sell_backward<T0, T1, T2>(arg0: &mut DAO<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T0>, arg3: u64, arg4: u64, arg5: u128, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun sell_forward<T0, T1, T2>(arg0: &mut DAO<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T2>, arg3: u64, arg4: u64, arg5: u128, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        abort 0
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

    public fun unlock_position<T0, T1>(arg0: &mut DAO<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 4);
        0x2::transfer::public_transfer<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(0x2::bag::remove<u64, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.investment, 0), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

