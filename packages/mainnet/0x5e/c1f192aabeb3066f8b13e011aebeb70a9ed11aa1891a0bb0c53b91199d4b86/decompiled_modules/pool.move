module 0x5ec1f192aabeb3066f8b13e011aebeb70a9ed11aa1891a0bb0c53b91199d4b86::pool {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct LSP<phantom T0, phantom T1, phantom T2> has drop {
        dummy_field: bool,
    }

    struct POOL_V2 has drop {
        dummy_field: bool,
    }

    struct PoolCreated has copy, drop, store {
        pool_id: 0x2::object::ID,
        token1_type: 0x1::type_name::TypeName,
        token2_type: 0x1::type_name::TypeName,
    }

    struct FeePercentReset has copy, drop, store {
        pool_id: 0x2::object::ID,
        original_fee_percent: u64,
        modified_fee_percent: u64,
    }

    struct ProtocolFeePercentReset has copy, drop, store {
        pool_id: 0x2::object::ID,
        original_protocol_fee_percent: u64,
        modified_protocol_fee_percent: u64,
    }

    struct Pool_Records has key {
        id: 0x2::object::UID,
        records: 0x2::vec_map::VecMap<0x1::string::String, 0x2::object::ID>,
    }

    struct Pool<phantom T0, phantom T1, phantom T2> has key {
        id: 0x2::object::UID,
        token1: 0x2::balance::Balance<T1>,
        token2: 0x2::balance::Balance<T2>,
        lsp_supply: 0x2::balance::Supply<LSP<T0, T1, T2>>,
        fee_percent: u64,
        protocol_fee_percent: u64,
        total_fee1: u64,
        total_fee2: u64,
        protocol_fee1: 0x2::balance::Balance<T1>,
        protocol_fee2: 0x2::balance::Balance<T2>,
    }

    public fun add_liquidity<T0, T1, T2>(arg0: &mut Pool<T0, T1, T2>, arg1: 0x2::coin::Coin<T1>, arg2: 0x2::coin::Coin<T2>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<LSP<T0, T1, T2>>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>) {
        assert!(0x2::coin::value<T2>(&arg2) > 0, 0);
        assert!(0x2::coin::value<T1>(&arg1) > 0, 0);
        let v0 = 0x2::coin::into_balance<T2>(arg2);
        let v1 = 0x2::coin::into_balance<T1>(arg1);
        let (v2, v3, v4) = get_amounts<T0, T1, T2>(arg0);
        let v5 = 0x2::balance::value<T2>(&v0);
        let v6 = 0x2::balance::value<T1>(&v1);
        let v7 = if ((v4 as u128) * (v5 as u128) / (v2 as u128) < (v4 as u128) * (v6 as u128) / (v3 as u128)) {
            (((v4 as u128) * (v5 as u128) / (v2 as u128)) as u64)
        } else {
            (((v4 as u128) * (v6 as u128) / (v3 as u128)) as u64)
        };
        assert!(v7 > 0, 3);
        let v8 = (((v7 as u128) * (v2 as u128) / (v4 as u128)) as u64);
        let v9 = (((v7 as u128) * (v3 as u128) / (v4 as u128)) as u64);
        assert!(v8 <= v5, 11);
        assert!(v9 <= v6, 10);
        assert!(0x2::balance::join<T2>(&mut arg0.token2, 0x2::balance::split<T2>(&mut v0, v8)) < 1844674407370955, 4);
        assert!(0x2::balance::join<T1>(&mut arg0.token1, 0x2::balance::split<T1>(&mut v1, v9)) < 1844674407370955, 4);
        (0x2::coin::from_balance<LSP<T0, T1, T2>>(0x2::balance::increase_supply<LSP<T0, T1, T2>>(&mut arg0.lsp_supply, v7), arg3), 0x2::coin::from_balance<T1>(v1, arg3), 0x2::coin::from_balance<T2>(v0, arg3))
    }

    entry fun add_liquidity_<T0, T1, T2>(arg0: &mut Pool<T0, T1, T2>, arg1: 0x2::coin::Coin<T1>, arg2: 0x2::coin::Coin<T2>, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = add_liquidity<T0, T1, T2>(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<LSP<T0, T1, T2>>>(v0, 0x2::tx_context::sender(arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, 0x2::tx_context::sender(arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v2, 0x2::tx_context::sender(arg3));
    }

    public fun change_order<T0, T1>() : (bool, 0x1::string::String) {
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        let v1 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T1>()));
        assert!(v0 != v1, 11);
        let v2 = 999999999;
        0x1::debug::print<u64>(&v2);
        0x1::debug::print<0x1::string::String>(&v0);
        0x1::debug::print<0x1::string::String>(&v1);
        let v3 = 0x1::hash::sha3_256(*0x1::string::bytes(&v0));
        let v4 = &mut v3;
        let v5 = 0x1::hash::sha3_256(*0x1::string::bytes(&v1));
        let v6 = &mut v5;
        let v7 = 88888888;
        0x1::debug::print<u64>(&v7);
        0x1::debug::print<vector<u8>>(v4);
        0x1::debug::print<vector<u8>>(v6);
        let v8;
        let v9;
        loop {
            v9 = 0x1::vector::pop_back<u8>(v4);
            v8 = 0x1::vector::pop_back<u8>(v6);
            if (v9 != v8) {
                break
            };
        };
        if (v9 > v8) {
            0x1::string::append(&mut v0, 0x1::string::utf8(b"-"));
            0x1::string::append(&mut v0, v1);
            return (true, v0)
        };
        0x1::string::append(&mut v1, 0x1::string::utf8(b"-"));
        0x1::string::append(&mut v1, v0);
        (false, v1)
    }

    public fun create_pool<T0: drop, T1, T2>(arg0: T0, arg1: 0x2::coin::Coin<T1>, arg2: 0x2::coin::Coin<T2>, arg3: 0x1::string::String, arg4: u64, arg5: &mut Pool_Records, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<LSP<T0, T1, T2>> {
        let v0 = 0x2::coin::value<T2>(&arg2);
        let v1 = 0x2::coin::value<T1>(&arg1);
        assert!(v0 > 0 && v1 > 0, 0);
        assert!(v0 < 1844674407370955 && v1 < 1844674407370955, 4);
        assert!(arg4 < 10000, 1);
        let v2 = 0x2::math::sqrt(v0) * 0x2::math::sqrt(v1);
        assert!(v2 > 1000, 7);
        let v3 = LSP<T0, T1, T2>{dummy_field: false};
        let v4 = 0x2::balance::create_supply<LSP<T0, T1, T2>>(v3);
        let v5 = 0x2::balance::increase_supply<LSP<T0, T1, T2>>(&mut v4, v2);
        let v6 = 0x2::object::new(arg6);
        assert!(!0x2::vec_map::contains<0x1::string::String, 0x2::object::ID>(&mut arg5.records, &arg3), 9);
        0x2::vec_map::insert<0x1::string::String, 0x2::object::ID>(&mut arg5.records, arg3, 0x2::object::uid_to_inner(&v6));
        let v7 = Pool<T0, T1, T2>{
            id                   : v6,
            token1               : 0x2::coin::into_balance<T1>(arg1),
            token2               : 0x2::coin::into_balance<T2>(arg2),
            lsp_supply           : v4,
            fee_percent          : arg4,
            protocol_fee_percent : 50,
            total_fee1           : 0,
            total_fee2           : 0,
            protocol_fee1        : 0x2::balance::zero<T1>(),
            protocol_fee2        : 0x2::balance::zero<T2>(),
        };
        0x2::transfer::share_object<Pool<T0, T1, T2>>(v7);
        let v8 = PoolCreated{
            pool_id     : *0x2::object::uid_as_inner(&v6),
            token1_type : 0x1::type_name::get<T1>(),
            token2_type : 0x1::type_name::get<T2>(),
        };
        0x2::event::emit<PoolCreated>(v8);
        0x2::transfer::public_transfer<0x2::coin::Coin<LSP<T0, T1, T2>>>(0x2::coin::from_balance<LSP<T0, T1, T2>>(v5, arg6), @0x0);
        0x2::coin::from_balance<LSP<T0, T1, T2>>(0x2::balance::split<LSP<T0, T1, T2>>(&mut v5, v2 - 1000), arg6)
    }

    entry fun create_pool_<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &mut Pool_Records, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = change_order<T0, T1>();
        if (v0) {
            let v2 = POOL_V2{dummy_field: false};
            let v3 = create_pool<POOL_V2, T0, T1>(v2, arg0, arg1, v1, arg2, arg3, arg4);
            0x2::transfer::public_transfer<0x2::coin::Coin<LSP<POOL_V2, T0, T1>>>(v3, 0x2::tx_context::sender(arg4));
        } else {
            let v4 = POOL_V2{dummy_field: false};
            let v5 = create_pool<POOL_V2, T1, T0>(v4, arg1, arg0, v1, arg2, arg3, arg4);
            0x2::transfer::public_transfer<0x2::coin::Coin<LSP<POOL_V2, T1, T0>>>(v5, 0x2::tx_context::sender(arg4));
        };
    }

    public fun get_amounts<T0, T1, T2>(arg0: &Pool<T0, T1, T2>) : (u64, u64, u64) {
        (0x2::balance::value<T2>(&arg0.token2), 0x2::balance::value<T1>(&arg0.token1), 0x2::balance::supply_value<LSP<T0, T1, T2>>(&arg0.lsp_supply))
    }

    public fun get_input_price(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : (u64, u64) {
        let v0 = (arg0 as u128);
        let v1 = v0 * (10000 - (arg3 as u128));
        (((v1 * (arg2 as u128) / ((arg1 as u128) * 10000 + v1)) as u64), ((v0 - v1 / 10000) as u64))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool_Records{
            id      : 0x2::object::new(arg0),
            records : 0x2::vec_map::empty<0x1::string::String, 0x2::object::ID>(),
        };
        0x2::transfer::share_object<Pool_Records>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun remove_liquidity<T0, T1, T2>(arg0: &mut Pool<T0, T1, T2>, arg1: 0x2::coin::Coin<LSP<T0, T1, T2>>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T2>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::coin::value<LSP<T0, T1, T2>>(&arg1);
        assert!(v0 > 0, 0);
        let (v1, v2, v3) = get_amounts<T0, T1, T2>(arg0);
        0x2::balance::decrease_supply<LSP<T0, T1, T2>>(&mut arg0.lsp_supply, 0x2::coin::into_balance<LSP<T0, T1, T2>>(arg1));
        (0x2::coin::take<T2>(&mut arg0.token2, (((v1 as u128) * (v0 as u128) / (v3 as u128)) as u64), arg2), 0x2::coin::take<T1>(&mut arg0.token1, (((v2 as u128) * (v0 as u128) / (v3 as u128)) as u64), arg2))
    }

    entry fun remove_liquidity_<T0, T1, T2>(arg0: &mut Pool<T0, T1, T2>, arg1: 0x2::coin::Coin<LSP<T0, T1, T2>>, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = remove_liquidity<T0, T1, T2>(arg0, arg1, arg2);
        let v2 = 0x2::tx_context::sender(arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v0, v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, v2);
    }

    entry fun reset_fee_percent<T0, T1, T2>(arg0: &AdminCap, arg1: &mut Pool<T0, T1, T2>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 >= 0 && arg2 < 10000, 1);
        assert!(arg3 >= 0 && arg3 < 100, 1);
        if (arg1.fee_percent != arg2) {
            let v0 = FeePercentReset{
                pool_id              : *0x2::object::uid_as_inner(&arg1.id),
                original_fee_percent : arg1.fee_percent,
                modified_fee_percent : arg2,
            };
            0x2::event::emit<FeePercentReset>(v0);
            arg1.fee_percent = arg2;
        };
        if (arg1.protocol_fee_percent != arg3) {
            let v1 = ProtocolFeePercentReset{
                pool_id                       : *0x2::object::uid_as_inner(&arg1.id),
                original_protocol_fee_percent : arg1.protocol_fee_percent,
                modified_protocol_fee_percent : arg3,
            };
            0x2::event::emit<ProtocolFeePercentReset>(v1);
            arg1.protocol_fee_percent = arg3;
        };
    }

    public fun swap_token1<T0, T1, T2>(arg0: &mut Pool<T0, T1, T2>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        assert!(0x2::coin::value<T1>(&arg1) > 0, 0);
        let v0 = 0x2::coin::into_balance<T1>(arg1);
        let (v1, v2, _) = get_amounts<T0, T1, T2>(arg0);
        assert!(v1 > 0 && v2 > 0, 2);
        let (v4, v5) = get_input_price(0x2::balance::value<T1>(&v0), v2, v1, arg0.fee_percent);
        assert!(v4 >= arg2, 8);
        0x2::balance::join<T1>(&mut arg0.token1, v0);
        arg0.total_fee1 = arg0.total_fee1 + v5;
        0x2::balance::join<T1>(&mut arg0.protocol_fee1, 0x2::balance::split<T1>(&mut arg0.token1, v5 * arg0.protocol_fee_percent / 100));
        let (v6, v7, _) = get_amounts<T0, T1, T2>(arg0);
        assert!((v1 as u128) * (v2 as u128) < (v6 as u128) * (v7 as u128), 6);
        0x2::coin::take<T2>(&mut arg0.token2, v4, arg3)
    }

    entry fun swap_token1_<T0, T1, T2>(arg0: &mut Pool<T0, T1, T2>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = swap_token1<T0, T1, T2>(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun swap_token2<T0, T1, T2>(arg0: &mut Pool<T0, T1, T2>, arg1: 0x2::coin::Coin<T2>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(0x2::coin::value<T2>(&arg1) > 0, 0);
        let v0 = 0x2::coin::into_balance<T2>(arg1);
        let (v1, v2, _) = get_amounts<T0, T1, T2>(arg0);
        assert!(v1 > 0 && v2 > 0, 2);
        let (v4, v5) = get_input_price(0x2::balance::value<T2>(&v0), v1, v2, arg0.fee_percent);
        assert!(v4 >= arg2, 8);
        0x2::balance::join<T2>(&mut arg0.token2, v0);
        arg0.total_fee2 = arg0.total_fee2 + v5;
        0x2::balance::join<T2>(&mut arg0.protocol_fee2, 0x2::balance::split<T2>(&mut arg0.token2, v5 * arg0.protocol_fee_percent / 100));
        let (v6, v7, _) = get_amounts<T0, T1, T2>(arg0);
        assert!((v1 as u128) * (v2 as u128) <= (v6 as u128) * (v7 as u128), 6);
        0x2::coin::take<T1>(&mut arg0.token1, v4, arg3)
    }

    entry fun swap_token2_<T0, T1, T2>(arg0: &mut Pool<T0, T1, T2>, arg1: 0x2::coin::Coin<T2>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = swap_token2<T0, T1, T2>(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun token1_price<T0, T1, T2>(arg0: &Pool<T0, T1, T2>, arg1: u64) : u64 {
        let (v0, v1, _) = get_amounts<T0, T1, T2>(arg0);
        let (v3, _) = get_input_price(arg1, v0, v1, arg0.fee_percent);
        v3
    }

    public fun token2_price<T0, T1, T2>(arg0: &Pool<T0, T1, T2>, arg1: u64) : u64 {
        let (v0, v1, _) = get_amounts<T0, T1, T2>(arg0);
        let (v3, _) = get_input_price(arg1, v1, v0, arg0.fee_percent);
        v3
    }

    entry fun withdraw_protocol_fee<T0, T1, T2>(arg0: &AdminCap, arg1: &mut Pool<T0, T1, T2>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::withdraw_all<T1>(&mut arg1.protocol_fee1), arg2), 0x2::tx_context::sender(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(0x2::balance::withdraw_all<T2>(&mut arg1.protocol_fee2), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

