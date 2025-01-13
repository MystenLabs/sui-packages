module 0xc7a9f63e3ea94dffa6e24d1b9aaf7b0b56837bfd99799cc255c7b423225b03a0::akasui {
    struct Configuration has store, key {
        id: 0x2::object::UID,
        version: u64,
        upgrade_admin_cap: 0x2::object::ID,
        admin: address,
        fee_recepient: address,
        platform_fee: u64,
        graduated_fee: u64,
        creator_fee: u64,
        initial_virtual_raise_coin_reserves: u64,
        initial_virtual_token_reserves: u64,
        remain_token_reserves: u64,
        token_decimals: u8,
        hardcap_per_raise_coin: 0x2::bag::Bag,
        initial_virtual_reserves_per_raise_coin: 0x2::bag::Bag,
        operators: vector<address>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Pool<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        real_raise_coin_reserves: 0x2::coin::Coin<T1>,
        real_token_reserves: 0x2::coin::Coin<T0>,
        virtual_token_reserves: u64,
        virtual_raise_coin_reserves: u64,
        remain_token_reserves: 0x2::coin::Coin<T0>,
        is_completed: bool,
        creator_address: address,
    }

    struct ConfigChangedEvent has copy, drop, store {
        old_platform_fee: u64,
        new_platform_fee: u64,
        old_graduated_fee: u64,
        new_graduated_fee: u64,
        old_initial_virtual_raise_coin_reserves: u64,
        new_initial_virtual_raise_coin_reserves: u64,
        old_initial_virtual_token_reserves: u64,
        new_initial_virtual_token_reserves: u64,
        old_remain_token_reserves: u64,
        new_remain_token_reserves: u64,
        old_token_decimals: u8,
        new_token_decimals: u8,
        ts: u64,
    }

    struct CreatedEvent has copy, drop, store {
        name: 0x1::ascii::String,
        symbol: 0x1::ascii::String,
        uri: 0x1::ascii::String,
        description: 0x1::ascii::String,
        twitter: 0x1::ascii::String,
        telegram: 0x1::ascii::String,
        website: 0x1::ascii::String,
        token_address: 0x1::ascii::String,
        bonding_curve: 0x1::ascii::String,
        pool_id: 0x2::object::ID,
        created_by: address,
        virtual_raise_coin_reserves: u64,
        virtual_token_reserves: u64,
        ts: u64,
        raise_coin_address: 0x1::ascii::String,
        raise_coin_target: u64,
    }

    struct OwnershipTransferredEvent has copy, drop, store {
        old_admin: address,
        new_admin: address,
        ts: u64,
    }

    struct PoolCompletedEvent has copy, drop, store {
        token_address: 0x1::ascii::String,
        lp: 0x1::ascii::String,
        ts: u64,
        raise_coin_address: 0x1::ascii::String,
    }

    struct TradedEvent has copy, drop, store {
        is_buy: bool,
        user: address,
        token_address: 0x1::ascii::String,
        raise_coin_amount: u64,
        token_amount: u64,
        virtual_raise_coin_reserves: u64,
        virtual_token_reserves: u64,
        real_raise_coin_reserves: u64,
        real_token_reserves: u64,
        pool_id: 0x2::object::ID,
        ts: u64,
        raise_coin_address: 0x1::ascii::String,
    }

    struct AddedLiquidityToDexEvent has copy, drop, store {
        pool_id: 0x2::object::ID,
        ts: u64,
        token_address: 0x1::ascii::String,
        raise_coin_address: 0x1::ascii::String,
    }

    struct BluemoveSwap has copy, drop, store {
        token_in: 0x1::ascii::String,
        token_out: 0x1::ascii::String,
        in_amount: u64,
        out_amount: u64,
        token_in_reserve: u64,
        token_out_reserve: u64,
    }

    fun swap<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(0x2::coin::value<T0>(&arg1) > 0 || 0x2::coin::value<T1>(&arg2) > 0, 102);
        arg0.virtual_token_reserves = arg0.virtual_token_reserves + 0x2::coin::value<T0>(&arg1);
        arg0.virtual_raise_coin_reserves = arg0.virtual_raise_coin_reserves + 0x2::coin::value<T1>(&arg2);
        if (0x2::coin::value<T0>(&arg1) > 0) {
            arg0.virtual_token_reserves = arg0.virtual_token_reserves - arg3;
        };
        if (0x2::coin::value<T1>(&arg2) > 0) {
            arg0.virtual_raise_coin_reserves = arg0.virtual_raise_coin_reserves - arg4;
        };
        assert_lp_value_is_increased_or_not_changed(arg0.virtual_token_reserves, arg0.virtual_raise_coin_reserves, arg0.virtual_token_reserves, arg0.virtual_raise_coin_reserves);
        0x2::coin::join<T0>(&mut arg0.real_token_reserves, arg1);
        0x2::coin::join<T1>(&mut arg0.real_raise_coin_reserves, arg2);
        (0x2::coin::split<T0>(&mut arg0.real_token_reserves, arg3, arg5), 0x2::coin::split<T1>(&mut arg0.real_raise_coin_reserves, arg4, arg5))
    }

    public entry fun add_liquidity<T0, T1>(arg0: &mut Configuration, arg1: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, Pool<T0, T1>>(&mut arg0.id, generate_pool_name<T0, T1>());
        assert!(v0.is_completed, 110);
        let v1 = 0x2::tx_context::sender(arg3);
        assert!(0x1::vector::contains<address>(&arg0.operators, &v1), 111);
        let v2 = 0x2::coin::split<T0>(&mut v0.real_token_reserves, 0x2::coin::value<T0>(&v0.real_token_reserves), arg3);
        0x2::coin::join<T0>(&mut v2, 0x2::coin::split<T0>(&mut v0.remain_token_reserves, 0x2::coin::value<T0>(&v0.remain_token_reserves), arg3));
        let v3 = 0x2::coin::value<T1>(&v0.real_raise_coin_reserves);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut v0.real_raise_coin_reserves, v3 * arg0.graduated_fee / 10000, arg3), arg0.admin);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut v0.real_raise_coin_reserves, v3 * arg0.creator_fee / 10000, arg3), v0.creator_address);
        let v4 = 0x2::coin::value<T1>(&v0.real_raise_coin_reserves);
        0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::router::add_liquidity<T0, T1>(0x2::coin::value<T0>(&v2), v2, v4, 0x2::coin::split<T1>(&mut v0.real_raise_coin_reserves, v4, arg3), 0, 0, arg1, arg3);
        let v5 = AddedLiquidityToDexEvent{
            pool_id            : 0x2::object::id<Pool<T0, T1>>(v0),
            ts                 : 0x2::clock::timestamp_ms(arg2),
            token_address      : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            raise_coin_address : 0x1::type_name::into_string(0x1::type_name::get<T1>()),
        };
        0x2::event::emit<AddedLiquidityToDexEvent>(v5);
    }

    public fun get_pool<T0, T1>(arg0: &Configuration) : &Pool<T0, T1> {
        0x2::dynamic_object_field::borrow<0x1::ascii::String, Pool<T0, T1>>(&arg0.id, generate_pool_name<T0, T1>())
    }

    public entry fun add_new_operator(arg0: &mut Configuration, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 101);
        0x1::vector::push_back<address>(&mut arg0.operators, arg1);
    }

    fun assert_lp_value_is_increased_or_not_changed(arg0: u64, arg1: u64, arg2: u64, arg3: u64) {
        assert!((arg0 as u128) * (arg1 as u128) <= (arg2 as u128) * (arg3 as u128), 104);
    }

    public fun assert_pool_not_completed<T0, T1>(arg0: &Configuration, arg1: &mut 0x2::tx_context::TxContext) {
        0x1::type_name::get<T0>();
        assert!(!0x2::dynamic_object_field::borrow<0x1::ascii::String, Pool<T0, T1>>(&arg0.id, generate_pool_name<T0, T1>()).is_completed, 103);
    }

    fun assert_version(arg0: u64) {
        assert!(arg0 == 1, 105);
    }

    public entry fun buy<T0, T1>(arg0: &mut Configuration, arg1: 0x2::coin::Coin<T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert_version(arg0.version);
        let v1 = 0x2::coin::value<T1>(&arg1);
        let (_, v3) = estimate_amount_out_without_fee<T0, T1>(arg0, v1, 0);
        assert!(v3 > 0, 102);
        let v4 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, Pool<T0, T1>>(&mut arg0.id, generate_pool_name<T0, T1>());
        assert!(!v4.is_completed, 103);
        let v5 = v4.virtual_token_reserves - 0x2::coin::value<T0>(&v4.remain_token_reserves);
        let v6 = 0x2::math::min(v3, v5);
        let v7 = 0x2::coin::zero<T0>(arg3);
        let (v8, v9) = swap<T0, T1>(v4, v7, arg1, v6, 0, arg3);
        let v10 = v8;
        v4.virtual_token_reserves = v4.virtual_token_reserves - 0x2::coin::value<T0>(&v10);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v9, arg0.admin);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v10, 0xc7a9f63e3ea94dffa6e24d1b9aaf7b0b56837bfd99799cc255c7b423225b03a0::utils::as_u64(0xc7a9f63e3ea94dffa6e24d1b9aaf7b0b56837bfd99799cc255c7b423225b03a0::utils::div(0xc7a9f63e3ea94dffa6e24d1b9aaf7b0b56837bfd99799cc255c7b423225b03a0::utils::mul(0xc7a9f63e3ea94dffa6e24d1b9aaf7b0b56837bfd99799cc255c7b423225b03a0::utils::from_u64(0x2::coin::value<T0>(&v10)), 0xc7a9f63e3ea94dffa6e24d1b9aaf7b0b56837bfd99799cc255c7b423225b03a0::utils::from_u64(arg0.platform_fee)), 0xc7a9f63e3ea94dffa6e24d1b9aaf7b0b56837bfd99799cc255c7b423225b03a0::utils::from_u64(10000))), arg3), arg0.fee_recepient);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v10, v0);
        let v11 = 0x2::bag::borrow<0x1::ascii::String, u64>(&arg0.hardcap_per_raise_coin, 0x1::type_name::into_string(0x1::type_name::get<T1>()));
        if (v5 == v6 || 0x2::coin::value<T1>(&v4.real_raise_coin_reserves) >= *v11) {
            v4.is_completed = true;
            let v12 = PoolCompletedEvent{
                token_address      : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
                lp                 : 0x1::ascii::string(b"0x0"),
                ts                 : 0x2::clock::timestamp_ms(arg2),
                raise_coin_address : 0x1::type_name::into_string(0x1::type_name::get<T1>()),
            };
            0x2::event::emit<PoolCompletedEvent>(v12);
        };
        let v13 = TradedEvent{
            is_buy                      : true,
            user                        : v0,
            token_address               : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            raise_coin_amount           : v1,
            token_amount                : 0x2::coin::value<T0>(&v10),
            virtual_raise_coin_reserves : v4.virtual_raise_coin_reserves,
            virtual_token_reserves      : v4.virtual_token_reserves,
            real_raise_coin_reserves    : 0x2::coin::value<T1>(&v4.real_raise_coin_reserves),
            real_token_reserves         : 0x2::coin::value<T0>(&v4.real_token_reserves),
            pool_id                     : 0x2::object::id<Pool<T0, T1>>(v4),
            ts                          : 0x2::clock::timestamp_ms(arg2),
            raise_coin_address          : 0x1::type_name::into_string(0x1::type_name::get<T1>()),
        };
        0x2::event::emit<TradedEvent>(v13);
    }

    fun buy_direct<T0, T1>(arg0: &mut Configuration, arg1: 0x2::coin::Coin<T1>, arg2: &mut Pool<T0, T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(!arg2.is_completed, 103);
        let (_, v2) = estimate_amount_out_for_buy_direct(arg0, 0x2::coin::value<T1>(&arg1), arg2.virtual_raise_coin_reserves, arg2.virtual_token_reserves);
        assert!(v2 > 0, 102);
        let v3 = arg2.virtual_token_reserves - 0x2::coin::value<T0>(&arg2.remain_token_reserves);
        let v4 = 0x2::math::min(v2, v3);
        let v5 = 0x2::coin::zero<T0>(arg5);
        let (v6, v7) = swap<T0, T1>(arg2, v5, arg1, v4, 0, arg5);
        let v8 = v6;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v8, 0xc7a9f63e3ea94dffa6e24d1b9aaf7b0b56837bfd99799cc255c7b423225b03a0::utils::as_u64(0xc7a9f63e3ea94dffa6e24d1b9aaf7b0b56837bfd99799cc255c7b423225b03a0::utils::div(0xc7a9f63e3ea94dffa6e24d1b9aaf7b0b56837bfd99799cc255c7b423225b03a0::utils::mul(0xc7a9f63e3ea94dffa6e24d1b9aaf7b0b56837bfd99799cc255c7b423225b03a0::utils::from_u64(0x2::coin::value<T0>(&v8)), 0xc7a9f63e3ea94dffa6e24d1b9aaf7b0b56837bfd99799cc255c7b423225b03a0::utils::from_u64(arg3)), 0xc7a9f63e3ea94dffa6e24d1b9aaf7b0b56837bfd99799cc255c7b423225b03a0::utils::from_u64(10000))), arg5), arg0.fee_recepient);
        arg2.virtual_token_reserves = arg2.virtual_token_reserves - 0x2::coin::value<T0>(&v8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v7, arg0.fee_recepient);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v8, v0);
        let v9 = 0x2::bag::borrow<0x1::ascii::String, u64>(&arg0.hardcap_per_raise_coin, 0x1::type_name::into_string(0x1::type_name::get<T1>()));
        if (v3 == v4 || 0x2::coin::value<T1>(&arg2.real_raise_coin_reserves) >= *v9) {
            arg2.is_completed = true;
            let v10 = PoolCompletedEvent{
                token_address      : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
                lp                 : 0x1::ascii::string(b"0x0"),
                ts                 : 0x2::clock::timestamp_ms(arg4),
                raise_coin_address : 0x1::type_name::into_string(0x1::type_name::get<T1>()),
            };
            0x2::event::emit<PoolCompletedEvent>(v10);
        };
        let v11 = TradedEvent{
            is_buy                      : true,
            user                        : v0,
            token_address               : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            raise_coin_amount           : 0x2::coin::value<T1>(&arg1),
            token_amount                : 0x2::coin::value<T0>(&v8),
            virtual_raise_coin_reserves : arg2.virtual_raise_coin_reserves,
            virtual_token_reserves      : arg2.virtual_token_reserves,
            real_raise_coin_reserves    : 0x2::coin::value<T1>(&arg2.real_raise_coin_reserves),
            real_token_reserves         : 0x2::coin::value<T0>(&arg2.real_token_reserves),
            pool_id                     : 0x2::object::id<Pool<T0, T1>>(arg2),
            ts                          : 0x2::clock::timestamp_ms(arg4),
            raise_coin_address          : 0x1::type_name::into_string(0x1::type_name::get<T1>()),
        };
        0x2::event::emit<TradedEvent>(v11);
    }

    public entry fun change_fee_recepient(arg0: &mut Configuration, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg3), 101);
        arg0.fee_recepient = arg1;
    }

    public fun check_pool_exist<T0, T1>(arg0: &Configuration) : bool {
        0x2::dynamic_object_field::exists_<0x1::ascii::String>(&arg0.id, generate_pool_name<T0, T1>())
    }

    public entry fun create<T0, T1>(arg0: &mut Configuration, arg1: 0x2::coin::TreasuryCap<T0>, arg2: &0x2::clock::Clock, arg3: 0x1::ascii::String, arg4: 0x1::ascii::String, arg5: 0x1::ascii::String, arg6: 0x1::ascii::String, arg7: 0x1::ascii::String, arg8: 0x1::ascii::String, arg9: 0x1::ascii::String, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::ascii::length(&arg5) <= 300, 107);
        assert!(0x1::ascii::length(&arg6) <= 1000, 107);
        assert!(0x1::ascii::length(&arg7) <= 500, 107);
        assert!(0x1::ascii::length(&arg8) <= 500, 107);
        assert!(0x1::ascii::length(&arg9) <= 500, 107);
        assert_version(arg0.version);
        assert!(0x2::coin::total_supply<T0>(&arg1) == 0, 108);
        let v0 = 0x2::bag::borrow<0x1::ascii::String, u64>(&arg0.initial_virtual_reserves_per_raise_coin, 0x1::type_name::into_string(0x1::type_name::get<T1>()));
        let v1 = Pool<T0, T1>{
            id                          : 0x2::object::new(arg10),
            real_raise_coin_reserves    : 0x2::coin::zero<T1>(arg10),
            real_token_reserves         : 0x2::coin::mint<T0>(&mut arg1, arg0.initial_virtual_token_reserves, arg10),
            virtual_token_reserves      : arg0.initial_virtual_token_reserves,
            virtual_raise_coin_reserves : *v0,
            remain_token_reserves       : 0x2::coin::zero<T0>(arg10),
            is_completed                : false,
            creator_address             : 0x2::tx_context::sender(arg10),
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T0>>(arg1, @0x0);
        0x2::dynamic_object_field::add<0x1::ascii::String, Pool<T0, T1>>(&mut arg0.id, generate_pool_name<T0, T1>(), v1);
        let v2 = 0x1::type_name::get<Pool<T0, T1>>();
        let v3 = CreatedEvent{
            name                        : arg3,
            symbol                      : arg4,
            uri                         : arg5,
            description                 : arg6,
            twitter                     : arg7,
            telegram                    : arg8,
            website                     : arg9,
            token_address               : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            bonding_curve               : 0x1::type_name::get_module(&v2),
            pool_id                     : 0x2::object::id<Pool<T0, T1>>(&v1),
            created_by                  : 0x2::tx_context::sender(arg10),
            virtual_raise_coin_reserves : *v0,
            virtual_token_reserves      : arg0.initial_virtual_token_reserves,
            ts                          : 0x2::clock::timestamp_ms(arg2),
            raise_coin_address          : 0x1::type_name::into_string(0x1::type_name::get<T1>()),
            raise_coin_target           : *0x2::bag::borrow<0x1::ascii::String, u64>(&arg0.hardcap_per_raise_coin, 0x1::type_name::into_string(0x1::type_name::get<T1>())),
        };
        0x2::event::emit<CreatedEvent>(v3);
    }

    public entry fun create_and_first_buy<T0, T1>(arg0: &mut Configuration, arg1: 0x2::coin::TreasuryCap<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: 0x1::ascii::String, arg5: 0x1::ascii::String, arg6: 0x1::ascii::String, arg7: 0x1::ascii::String, arg8: 0x1::ascii::String, arg9: 0x1::ascii::String, arg10: 0x1::ascii::String, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::ascii::length(&arg6) <= 300, 107);
        assert!(0x1::ascii::length(&arg7) <= 1000, 107);
        assert!(0x1::ascii::length(&arg8) <= 500, 107);
        assert!(0x1::ascii::length(&arg9) <= 500, 107);
        assert!(0x1::ascii::length(&arg10) <= 500, 107);
        assert_version(arg0.version);
        assert!(0x2::coin::total_supply<T0>(&arg1) == 0, 108);
        let v0 = 0x2::bag::borrow<0x1::ascii::String, u64>(&arg0.initial_virtual_reserves_per_raise_coin, 0x1::type_name::into_string(0x1::type_name::get<T1>()));
        let v1 = Pool<T0, T1>{
            id                          : 0x2::object::new(arg11),
            real_raise_coin_reserves    : 0x2::coin::zero<T1>(arg11),
            real_token_reserves         : 0x2::coin::mint<T0>(&mut arg1, arg0.initial_virtual_token_reserves, arg11),
            virtual_token_reserves      : arg0.initial_virtual_token_reserves,
            virtual_raise_coin_reserves : *v0,
            remain_token_reserves       : 0x2::coin::zero<T0>(arg11),
            is_completed                : false,
            creator_address             : 0x2::tx_context::sender(arg11),
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T0>>(arg1, @0x0);
        let v2 = 0x1::type_name::get<Pool<T0, T1>>();
        let v3 = CreatedEvent{
            name                        : arg4,
            symbol                      : arg5,
            uri                         : arg6,
            description                 : arg7,
            twitter                     : arg8,
            telegram                    : arg9,
            website                     : arg10,
            token_address               : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            bonding_curve               : 0x1::type_name::get_module(&v2),
            pool_id                     : 0x2::object::id<Pool<T0, T1>>(&v1),
            created_by                  : 0x2::tx_context::sender(arg11),
            virtual_raise_coin_reserves : *v0,
            virtual_token_reserves      : arg0.initial_virtual_token_reserves,
            ts                          : 0x2::clock::timestamp_ms(arg3),
            raise_coin_address          : 0x1::type_name::into_string(0x1::type_name::get<T1>()),
            raise_coin_target           : *0x2::bag::borrow<0x1::ascii::String, u64>(&arg0.hardcap_per_raise_coin, 0x1::type_name::into_string(0x1::type_name::get<T1>())),
        };
        0x2::event::emit<CreatedEvent>(v3);
        if (0x2::coin::value<T1>(&arg2) > 0) {
            let v4 = arg0.platform_fee;
            let v5 = &mut v1;
            buy_direct<T0, T1>(arg0, arg2, v5, v4, arg3, arg11);
        } else {
            0x2::coin::destroy_zero<T1>(arg2);
        };
        0x2::dynamic_object_field::add<0x1::ascii::String, Pool<T0, T1>>(&mut arg0.id, generate_pool_name<T0, T1>(), v1);
    }

    public fun estimate_amount_out<T0, T1>(arg0: &mut Configuration, arg1: u64, arg2: u64) : (u64, u64) {
        0x1::type_name::get<T0>();
        let v0 = 0x2::dynamic_object_field::borrow<0x1::ascii::String, Pool<T0, T1>>(&arg0.id, generate_pool_name<T0, T1>());
        if (arg1 > 0 && arg2 == 0) {
            let v3 = 0xc7a9f63e3ea94dffa6e24d1b9aaf7b0b56837bfd99799cc255c7b423225b03a0::curves::calculate_token_amount_received(v0.virtual_raise_coin_reserves, v0.virtual_token_reserves, arg1);
            (0, v3 - 0xc7a9f63e3ea94dffa6e24d1b9aaf7b0b56837bfd99799cc255c7b423225b03a0::utils::as_u64(0xc7a9f63e3ea94dffa6e24d1b9aaf7b0b56837bfd99799cc255c7b423225b03a0::utils::div(0xc7a9f63e3ea94dffa6e24d1b9aaf7b0b56837bfd99799cc255c7b423225b03a0::utils::mul(0xc7a9f63e3ea94dffa6e24d1b9aaf7b0b56837bfd99799cc255c7b423225b03a0::utils::from_u64(v3), 0xc7a9f63e3ea94dffa6e24d1b9aaf7b0b56837bfd99799cc255c7b423225b03a0::utils::from_u64(arg0.platform_fee)), 0xc7a9f63e3ea94dffa6e24d1b9aaf7b0b56837bfd99799cc255c7b423225b03a0::utils::from_u64(10000))))
        } else if (arg1 == 0 && arg2 > 0) {
            let v4 = 0xc7a9f63e3ea94dffa6e24d1b9aaf7b0b56837bfd99799cc255c7b423225b03a0::curves::calculate_remove_liquidity_return(v0.virtual_token_reserves, v0.virtual_raise_coin_reserves, arg2);
            (v4 - 0xc7a9f63e3ea94dffa6e24d1b9aaf7b0b56837bfd99799cc255c7b423225b03a0::utils::as_u64(0xc7a9f63e3ea94dffa6e24d1b9aaf7b0b56837bfd99799cc255c7b423225b03a0::utils::div(0xc7a9f63e3ea94dffa6e24d1b9aaf7b0b56837bfd99799cc255c7b423225b03a0::utils::mul(0xc7a9f63e3ea94dffa6e24d1b9aaf7b0b56837bfd99799cc255c7b423225b03a0::utils::from_u64(v4), 0xc7a9f63e3ea94dffa6e24d1b9aaf7b0b56837bfd99799cc255c7b423225b03a0::utils::from_u64(arg0.platform_fee)), 0xc7a9f63e3ea94dffa6e24d1b9aaf7b0b56837bfd99799cc255c7b423225b03a0::utils::from_u64(10000))), 0)
        } else {
            (0, 0)
        }
    }

    public fun estimate_amount_out_for_buy_direct(arg0: &mut Configuration, arg1: u64, arg2: u64, arg3: u64) : (u64, u64) {
        (0, 0xc7a9f63e3ea94dffa6e24d1b9aaf7b0b56837bfd99799cc255c7b423225b03a0::curves::calculate_token_amount_received(arg2, arg3, arg1))
    }

    public fun estimate_amount_out_without_fee<T0, T1>(arg0: &mut Configuration, arg1: u64, arg2: u64) : (u64, u64) {
        0x1::type_name::get<T0>();
        let v0 = 0x2::dynamic_object_field::borrow<0x1::ascii::String, Pool<T0, T1>>(&arg0.id, generate_pool_name<T0, T1>());
        if (arg1 > 0 && arg2 == 0) {
            (0, 0xc7a9f63e3ea94dffa6e24d1b9aaf7b0b56837bfd99799cc255c7b423225b03a0::curves::calculate_token_amount_received(v0.virtual_raise_coin_reserves, v0.virtual_token_reserves, arg1))
        } else if (arg1 == 0 && arg2 > 0) {
            (0xc7a9f63e3ea94dffa6e24d1b9aaf7b0b56837bfd99799cc255c7b423225b03a0::curves::calculate_remove_liquidity_return(v0.virtual_token_reserves, v0.virtual_raise_coin_reserves, arg2), 0)
        } else {
            (0, 0)
        }
    }

    public fun generate_pool_name<T0, T1>() : 0x1::ascii::String {
        let v0 = 0x1::string::utf8(b"");
        0x1::string::append_utf8(&mut v0, b"AKASUI-");
        0x1::string::append_utf8(&mut v0, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())));
        0x1::string::append_utf8(&mut v0, b"-");
        0x1::string::append_utf8(&mut v0, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T1>())));
        0x1::string::to_ascii(v0)
    }

    public fun get_admin(arg0: &Configuration) : address {
        arg0.admin
    }

    public fun get_creator_fee(arg0: &Configuration) : u64 {
        arg0.creator_fee
    }

    public fun get_fee_recepient(arg0: &Configuration) : address {
        arg0.fee_recepient
    }

    public fun get_graduated_fee(arg0: &Configuration) : u64 {
        arg0.graduated_fee
    }

    public fun get_hardcap_per_raise_coin<T0>(arg0: &Configuration) : u64 {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        if (0x2::bag::contains<0x1::ascii::String>(&arg0.hardcap_per_raise_coin, v0)) {
            *0x2::bag::borrow<0x1::ascii::String, u64>(&arg0.hardcap_per_raise_coin, v0)
        } else {
            0
        }
    }

    public fun get_initial_virtual_raise_coin_reserves(arg0: &Configuration) : u64 {
        arg0.initial_virtual_raise_coin_reserves
    }

    public fun get_initial_virtual_reserves_per_raise_coin<T0>(arg0: &Configuration) : u64 {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        if (0x2::bag::contains<0x1::ascii::String>(&arg0.initial_virtual_reserves_per_raise_coin, v0)) {
            *0x2::bag::borrow<0x1::ascii::String, u64>(&arg0.initial_virtual_reserves_per_raise_coin, v0)
        } else {
            0
        }
    }

    public fun get_initial_virtual_token_reserves(arg0: &Configuration) : u64 {
        arg0.initial_virtual_token_reserves
    }

    public fun get_operators(arg0: &Configuration) : vector<address> {
        arg0.operators
    }

    public fun get_platform_fee(arg0: &Configuration) : u64 {
        arg0.platform_fee
    }

    public fun get_remain_token_reserves(arg0: &Configuration) : u64 {
        arg0.remain_token_reserves
    }

    public fun get_token_decimals(arg0: &Configuration) : u8 {
        arg0.token_decimals
    }

    public fun get_version(arg0: &Configuration) : u64 {
        arg0.version
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = Configuration{
            id                                      : 0x2::object::new(arg0),
            version                                 : 1,
            upgrade_admin_cap                       : 0x2::object::id<AdminCap>(&v0),
            admin                                   : @0x238b2cf963e66b95a7b6d1ffb93c4f7b71f07b4f79793c87c266de654489c9e1,
            fee_recepient                           : @0x238b2cf963e66b95a7b6d1ffb93c4f7b71f07b4f79793c87c266de654489c9e1,
            platform_fee                            : 100,
            graduated_fee                           : 100,
            creator_fee                             : 100,
            initial_virtual_raise_coin_reserves     : 500000000000,
            initial_virtual_token_reserves          : 1000000000000000,
            remain_token_reserves                   : 200000000000000,
            token_decimals                          : 6,
            hardcap_per_raise_coin                  : 0x2::bag::new(arg0),
            initial_virtual_reserves_per_raise_coin : 0x2::bag::new(arg0),
            operators                               : 0x1::vector::empty<address>(),
        };
        0x2::bag::add<0x1::ascii::String, u64>(&mut v1.hardcap_per_raise_coin, 0x1::type_name::into_string(0x1::type_name::get<0x2::sui::SUI>()), 2500000000000);
        0x2::bag::add<0x1::ascii::String, u64>(&mut v1.initial_virtual_reserves_per_raise_coin, 0x1::type_name::into_string(0x1::type_name::get<0x2::sui::SUI>()), 625000000000);
        0x2::transfer::public_share_object<Configuration>(v1);
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun migrate_version(arg0: &mut Configuration, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 101);
        arg0.version = arg1;
    }

    public entry fun remove_operator(arg0: &mut Configuration, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 101);
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.operators, &arg1);
        if (v0) {
            0x1::vector::remove<address>(&mut arg0.operators, v1);
        };
    }

    public entry fun sell<T0, T1>(arg0: &mut Configuration, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, Pool<T0, T1>>(&mut arg0.id, generate_pool_name<T0, T1>());
        assert_version(arg0.version);
        assert!(!v1.is_completed, 103);
        let v2 = 0x2::coin::value<T0>(&arg1);
        assert!(v2 > 0, 102);
        let v3 = 0xc7a9f63e3ea94dffa6e24d1b9aaf7b0b56837bfd99799cc255c7b423225b03a0::curves::calculate_remove_liquidity_return(v1.virtual_token_reserves, v1.virtual_raise_coin_reserves, v2);
        let v4 = 0xc7a9f63e3ea94dffa6e24d1b9aaf7b0b56837bfd99799cc255c7b423225b03a0::utils::as_u64(0xc7a9f63e3ea94dffa6e24d1b9aaf7b0b56837bfd99799cc255c7b423225b03a0::utils::div(0xc7a9f63e3ea94dffa6e24d1b9aaf7b0b56837bfd99799cc255c7b423225b03a0::utils::mul(0xc7a9f63e3ea94dffa6e24d1b9aaf7b0b56837bfd99799cc255c7b423225b03a0::utils::from_u64(v3), 0xc7a9f63e3ea94dffa6e24d1b9aaf7b0b56837bfd99799cc255c7b423225b03a0::utils::from_u64(arg0.platform_fee)), 0xc7a9f63e3ea94dffa6e24d1b9aaf7b0b56837bfd99799cc255c7b423225b03a0::utils::from_u64(10000)));
        assert!(v3 - v4 >= arg2, 2);
        let v5 = 0x2::coin::zero<T1>(arg4);
        let (v6, v7) = swap<T0, T1>(v1, arg1, v5, 0, v3, arg4);
        let v8 = v7;
        v1.virtual_raise_coin_reserves = v1.virtual_raise_coin_reserves - 0x2::coin::value<T1>(&v8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut v8, v4, arg4), arg0.fee_recepient);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v8, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v6, v0);
        let v9 = TradedEvent{
            is_buy                      : false,
            user                        : v0,
            token_address               : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            raise_coin_amount           : 0x2::coin::value<T1>(&v8),
            token_amount                : v2,
            virtual_raise_coin_reserves : v1.virtual_raise_coin_reserves,
            virtual_token_reserves      : v1.virtual_token_reserves,
            real_raise_coin_reserves    : 0x2::coin::value<T1>(&v1.real_raise_coin_reserves),
            real_token_reserves         : 0x2::coin::value<T0>(&v1.real_token_reserves),
            pool_id                     : 0x2::object::id<Pool<T0, T1>>(v1),
            ts                          : 0x2::clock::timestamp_ms(arg3),
            raise_coin_address          : 0x1::type_name::into_string(0x1::type_name::get<T1>()),
        };
        0x2::event::emit<TradedEvent>(v9);
    }

    public fun skim<T0, T1>(arg0: &mut Configuration, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.admin, 101);
        0x1::type_name::get<T0>();
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, Pool<T0, T1>>(&mut arg0.id, generate_pool_name<T0, T1>());
        assert!(v1.is_completed, 110);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut v1.real_raise_coin_reserves, 0x2::coin::value<T1>(&v1.real_raise_coin_reserves), arg1), v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v1.real_token_reserves, 0x2::coin::value<T0>(&v1.real_token_reserves), arg1), v0);
    }

    public entry fun swap_on_bluemove<T0, T1>(arg0: &Configuration, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::router::swap_exact_input_<T0, T1>(arg1, arg2, arg3, arg4, arg6);
        let v1 = 0x2::coin::value<T1>(&v0);
        if (arg5 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut v0, v1 * arg5 / 10000, arg6), arg0.fee_recepient);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, 0x2::tx_context::sender(arg6));
        let (v2, v3) = if (0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::utils::sort_token_type<T0, T1>()) {
            let (v4, v5, _) = 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::get_amounts<T0, T1>(0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::get_pool<T0, T1>(arg4));
            (v4, v5)
        } else {
            let (v7, v8, _) = 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::get_amounts<T1, T0>(0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::get_pool<T1, T0>(arg4));
            (v8, v7)
        };
        let v10 = BluemoveSwap{
            token_in          : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            token_out         : 0x1::type_name::into_string(0x1::type_name::get<T1>()),
            in_amount         : arg1,
            out_amount        : v1,
            token_in_reserve  : v2,
            token_out_reserve : v3,
        };
        0x2::event::emit<BluemoveSwap>(v10);
    }

    public entry fun transfer_admin(arg0: &mut Configuration, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg0.admin == v0, 101);
        arg0.admin = arg1;
        let v1 = OwnershipTransferredEvent{
            old_admin : v0,
            new_admin : arg1,
            ts        : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<OwnershipTransferredEvent>(v1);
    }

    public entry fun update_config(arg0: &mut Configuration, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u8, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg9), 101);
        arg0.platform_fee = arg1;
        arg0.graduated_fee = arg2;
        arg0.creator_fee = arg3;
        arg0.initial_virtual_raise_coin_reserves = arg4;
        arg0.initial_virtual_token_reserves = arg5;
        arg0.remain_token_reserves = arg6;
        arg0.token_decimals = arg7;
        let v0 = ConfigChangedEvent{
            old_platform_fee                        : arg0.platform_fee,
            new_platform_fee                        : arg1,
            old_graduated_fee                       : arg0.graduated_fee,
            new_graduated_fee                       : arg2,
            old_initial_virtual_raise_coin_reserves : arg0.initial_virtual_raise_coin_reserves,
            new_initial_virtual_raise_coin_reserves : arg4,
            old_initial_virtual_token_reserves      : arg0.initial_virtual_token_reserves,
            new_initial_virtual_token_reserves      : arg5,
            old_remain_token_reserves               : arg0.remain_token_reserves,
            new_remain_token_reserves               : arg6,
            old_token_decimals                      : arg0.token_decimals,
            new_token_decimals                      : arg7,
            ts                                      : 0x2::clock::timestamp_ms(arg8),
        };
        0x2::event::emit<ConfigChangedEvent>(v0);
    }

    public entry fun update_hardcap_per_raise_coin<T0>(arg0: &mut Configuration, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 101);
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        if (0x2::bag::contains<0x1::ascii::String>(&arg0.hardcap_per_raise_coin, v0)) {
            0x2::bag::remove<0x1::ascii::String, u64>(&mut arg0.hardcap_per_raise_coin, v0);
            0x2::bag::add<0x1::ascii::String, u64>(&mut arg0.hardcap_per_raise_coin, v0, arg1);
        } else {
            0x2::bag::add<0x1::ascii::String, u64>(&mut arg0.hardcap_per_raise_coin, v0, arg1);
        };
    }

    public entry fun update_initial_virtual_reserves_per_raise_coin<T0>(arg0: &mut Configuration, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 101);
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        if (0x2::bag::contains<0x1::ascii::String>(&arg0.initial_virtual_reserves_per_raise_coin, v0)) {
            0x2::bag::remove<0x1::ascii::String, u64>(&mut arg0.initial_virtual_reserves_per_raise_coin, v0);
            0x2::bag::add<0x1::ascii::String, u64>(&mut arg0.initial_virtual_reserves_per_raise_coin, v0, arg1);
        } else {
            0x2::bag::add<0x1::ascii::String, u64>(&mut arg0.initial_virtual_reserves_per_raise_coin, v0, arg1);
        };
    }

    // decompiled from Move bytecode v6
}

