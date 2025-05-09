module 0x9baecae0ac0641df167127b6029dd16125bed59063a04fb7e5b66aa8d6f841c5::move_pump {
    struct Configuration has store, key {
        id: 0x2::object::UID,
        version: u64,
        admin: address,
        id_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        create_pool_fee: u64,
        platform_fee: u64,
        graduated_fee: u64,
        graduated_create_fee: u64,
        graduated_sui: u64,
        initial_virtual_sui_reserves: u64,
        initial_virtual_token_reserves: u64,
        remain_token_reserves: u64,
        token_decimals: u8,
    }

    struct Pool<phantom T0> has store, key {
        id: 0x2::object::UID,
        created_by: address,
        real_sui_reserves: 0x2::coin::Coin<0x2::sui::SUI>,
        real_token_reserves: 0x2::coin::Coin<T0>,
        virtual_token_reserves: u64,
        virtual_sui_reserves: u64,
        remain_token_reserves: 0x2::coin::Coin<T0>,
        is_completed: bool,
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
        timestamp: u64,
    }

    fun swap<T0>(arg0: &mut Pool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<0x2::sui::SUI>) {
        assert!(0x2::coin::value<T0>(&arg1) > 0 || 0x2::coin::value<0x2::sui::SUI>(&arg2) > 0, 2);
        if (0x2::coin::value<T0>(&arg1) > 0) {
            arg0.virtual_token_reserves = arg0.virtual_token_reserves - arg3;
        };
        if (0x2::coin::value<0x2::sui::SUI>(&arg2) > 0) {
            arg0.virtual_sui_reserves = arg0.virtual_sui_reserves - arg4;
        };
        arg0.virtual_token_reserves = arg0.virtual_token_reserves + 0x2::coin::value<T0>(&arg1);
        arg0.virtual_sui_reserves = arg0.virtual_sui_reserves + 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert_lp_value_is_increased_or_not_changed(arg0.virtual_token_reserves, arg0.virtual_sui_reserves, arg0.virtual_token_reserves, arg0.virtual_sui_reserves);
        0x2::coin::join<T0>(&mut arg0.real_token_reserves, arg1);
        0x2::coin::join<0x2::sui::SUI>(&mut arg0.real_sui_reserves, arg2);
        (0x2::coin::split<T0>(&mut arg0.real_token_reserves, arg3, arg5), 0x2::coin::split<0x2::sui::SUI>(&mut arg0.real_sui_reserves, arg4, arg5))
    }

    fun assert_lp_value_is_increased_or_not_changed(arg0: u64, arg1: u64, arg2: u64, arg3: u64) {
        assert!((arg0 as u128) * (arg1 as u128) <= (arg2 as u128) * (arg3 as u128), 2);
    }

    fun assert_version(arg0: u64) {
        assert!(arg0 == 0, 4444);
    }

    public entry fun buy<T0>(arg0: &mut Configuration, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert_version(arg0.version);
        let v1 = 0x1::type_name::get<T0>();
        let v2 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, Pool<T0>>(&mut arg0.id, 0x1::type_name::get_address(&v1));
        assert!(!v2.is_completed, 9);
        assert!(arg2 > 0, 2);
        let v3 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        let v4 = v2.virtual_token_reserves - 0x2::coin::value<T0>(&v2.remain_token_reserves);
        let v5 = 0x2::math::min(arg2, v4);
        let v6 = 0x9baecae0ac0641df167127b6029dd16125bed59063a04fb7e5b66aa8d6f841c5::curves::calculate_add_liquidity_cost(v2.virtual_sui_reserves, v2.virtual_token_reserves, v5) + 1;
        let v7 = 0x9baecae0ac0641df167127b6029dd16125bed59063a04fb7e5b66aa8d6f841c5::utils::as_u64(0x9baecae0ac0641df167127b6029dd16125bed59063a04fb7e5b66aa8d6f841c5::utils::div(0x9baecae0ac0641df167127b6029dd16125bed59063a04fb7e5b66aa8d6f841c5::utils::mul(0x9baecae0ac0641df167127b6029dd16125bed59063a04fb7e5b66aa8d6f841c5::utils::from_u64(v6), 0x9baecae0ac0641df167127b6029dd16125bed59063a04fb7e5b66aa8d6f841c5::utils::from_u64(arg0.platform_fee)), 0x9baecae0ac0641df167127b6029dd16125bed59063a04fb7e5b66aa8d6f841c5::utils::from_u64(10000)));
        assert!(v3 >= v6 + v7, 6);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.id_balance, 0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(&mut arg1), v7));
        let v8 = 0x2::coin::zero<T0>(arg4);
        let (v9, v10) = swap<T0>(v2, v8, arg1, v5, v3 - v6, arg4);
        let v11 = v9;
        v2.virtual_token_reserves = v2.virtual_token_reserves - 0x2::coin::value<T0>(&v11);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v10, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v11, v0);
        if (v4 == v5) {
        };
    }

    fun buy_direct<T0>(arg0: &mut Configuration, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut Pool<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(!arg2.is_completed, 9);
        assert!(arg3 > 0, 2);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        let v2 = 0x2::math::min(arg3, arg2.virtual_token_reserves - 0x2::coin::value<T0>(&arg2.remain_token_reserves));
        let v3 = 0x9baecae0ac0641df167127b6029dd16125bed59063a04fb7e5b66aa8d6f841c5::curves::calculate_add_liquidity_cost(arg2.virtual_sui_reserves, arg2.virtual_token_reserves, v2) + 1;
        let v4 = 0x9baecae0ac0641df167127b6029dd16125bed59063a04fb7e5b66aa8d6f841c5::utils::as_u64(0x9baecae0ac0641df167127b6029dd16125bed59063a04fb7e5b66aa8d6f841c5::utils::div(0x9baecae0ac0641df167127b6029dd16125bed59063a04fb7e5b66aa8d6f841c5::utils::mul(0x9baecae0ac0641df167127b6029dd16125bed59063a04fb7e5b66aa8d6f841c5::utils::from_u64(v3), 0x9baecae0ac0641df167127b6029dd16125bed59063a04fb7e5b66aa8d6f841c5::utils::from_u64(arg0.platform_fee)), 0x9baecae0ac0641df167127b6029dd16125bed59063a04fb7e5b66aa8d6f841c5::utils::from_u64(10000)));
        assert!(v1 >= v3 + v4, 6);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.id_balance, 0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(&mut arg1), v4));
        let v5 = 0x2::coin::zero<T0>(arg5);
        let (v6, v7) = swap<T0>(arg2, v5, arg1, v2, v1 - v3, arg5);
        let v8 = v6;
        arg2.virtual_token_reserves = arg2.virtual_token_reserves - 0x2::coin::value<T0>(&v8);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v7, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v8, v0);
    }

    public entry fun create<T0>(arg0: &mut Configuration, arg1: 0x2::coin::TreasuryCap<T0>, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: 0x1::ascii::String, arg5: 0x1::ascii::String, arg6: 0x1::ascii::String, arg7: 0x1::ascii::String, arg8: 0x1::ascii::String, arg9: 0x1::ascii::String, arg10: 0x1::ascii::String, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::ascii::length(&arg6) <= 300, 2);
        assert!(0x1::ascii::length(&arg7) <= 1000, 2);
        assert!(0x1::ascii::length(&arg8) <= 500, 2);
        assert!(0x1::ascii::length(&arg9) <= 500, 2);
        assert!(0x1::ascii::length(&arg10) <= 500, 2);
        assert!(0x2::coin::total_supply<T0>(&arg1) == 0, 7);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= arg0.create_pool_fee, 6);
        let v0 = Pool<T0>{
            id                     : 0x2::object::new(arg11),
            created_by             : 0x2::tx_context::sender(arg11),
            real_sui_reserves      : 0x2::coin::zero<0x2::sui::SUI>(arg11),
            real_token_reserves    : 0x2::coin::mint<T0>(&mut arg1, arg0.initial_virtual_token_reserves - arg0.remain_token_reserves, arg11),
            virtual_token_reserves : arg0.initial_virtual_token_reserves,
            virtual_sui_reserves   : arg0.initial_virtual_sui_reserves,
            remain_token_reserves  : 0x2::coin::mint<T0>(&mut arg1, arg0.remain_token_reserves, arg11),
            is_completed           : false,
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T0>>(arg1, @0x2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.id_balance, 0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(&mut arg3), arg0.create_pool_fee));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, 0x2::tx_context::sender(arg11));
        let v1 = 0x1::type_name::get<T0>();
        let v2 = 0x1::type_name::get<Pool<T0>>();
        0x2::dynamic_object_field::add<0x1::ascii::String, Pool<T0>>(&mut arg0.id, 0x1::type_name::get_address(&v1), v0);
        let v3 = CreatedEvent{
            name          : arg4,
            symbol        : arg5,
            uri           : arg6,
            description   : arg7,
            twitter       : arg8,
            telegram      : arg9,
            website       : arg10,
            token_address : 0x1::type_name::into_string(v1),
            bonding_curve : 0x1::type_name::get_module(&v2),
            pool_id       : 0x2::object::id<Pool<T0>>(&v0),
            created_by    : 0x2::tx_context::sender(arg11),
            timestamp     : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<CreatedEvent>(v3);
    }

    public entry fun create_and_first_buy<T0>(arg0: &mut Configuration, arg1: 0x2::coin::TreasuryCap<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &0x2::clock::Clock, arg5: 0x1::ascii::String, arg6: 0x1::ascii::String, arg7: 0x1::ascii::String, arg8: 0x1::ascii::String, arg9: 0x1::ascii::String, arg10: 0x1::ascii::String, arg11: 0x1::ascii::String, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::ascii::length(&arg7) <= 300, 2);
        assert!(0x1::ascii::length(&arg8) <= 1000, 2);
        assert!(0x1::ascii::length(&arg9) <= 500, 2);
        assert!(0x1::ascii::length(&arg10) <= 500, 2);
        assert!(0x1::ascii::length(&arg11) <= 500, 2);
        assert!(0x2::coin::total_supply<T0>(&arg1) == 0, 7);
        let v0 = Pool<T0>{
            id                     : 0x2::object::new(arg12),
            created_by             : 0x2::tx_context::sender(arg12),
            real_sui_reserves      : 0x2::coin::zero<0x2::sui::SUI>(arg12),
            real_token_reserves    : 0x2::coin::mint<T0>(&mut arg1, arg0.initial_virtual_token_reserves - arg0.remain_token_reserves, arg12),
            virtual_token_reserves : arg0.initial_virtual_token_reserves,
            virtual_sui_reserves   : arg0.initial_virtual_sui_reserves,
            remain_token_reserves  : 0x2::coin::mint<T0>(&mut arg1, arg0.remain_token_reserves, arg12),
            is_completed           : false,
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T0>>(arg1, @0x2);
        let v1 = 0x1::type_name::get<T0>();
        if (0x2::coin::value<0x2::sui::SUI>(&arg2) > 0) {
            let v2 = &mut v0;
            buy_direct<T0>(arg0, arg2, v2, arg3, arg4, arg12);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg2);
        };
        0x2::dynamic_object_field::add<0x1::ascii::String, Pool<T0>>(&mut arg0.id, 0x1::type_name::get_address(&v1), v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Configuration{
            id                             : 0x2::object::new(arg0),
            version                        : 0,
            admin                          : @0x0,
            id_balance                     : 0x2::balance::zero<0x2::sui::SUI>(),
            create_pool_fee                : 0,
            platform_fee                   : 50,
            graduated_fee                  : 150000000000,
            graduated_create_fee           : 50000000000,
            graduated_sui                  : 3000000000000,
            initial_virtual_sui_reserves   : 3000000000000,
            initial_virtual_token_reserves : 1000000000000000000,
            remain_token_reserves          : 200000000000000000,
            token_decimals                 : 9,
        };
        0x2::transfer::public_share_object<Configuration>(v0);
    }

    public entry fun sell<T0>(arg0: &mut Configuration, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x1::type_name::get<T0>();
        let v2 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, Pool<T0>>(&mut arg0.id, 0x1::type_name::get_address(&v1));
        assert!(!v2.is_completed, 9);
        let v3 = 0x2::coin::value<T0>(&arg1);
        assert!(v3 > 0, 2);
        let v4 = 0x9baecae0ac0641df167127b6029dd16125bed59063a04fb7e5b66aa8d6f841c5::curves::calculate_remove_liquidity_return(v2.virtual_token_reserves, v2.virtual_sui_reserves, v3);
        let v5 = 0x9baecae0ac0641df167127b6029dd16125bed59063a04fb7e5b66aa8d6f841c5::utils::as_u64(0x9baecae0ac0641df167127b6029dd16125bed59063a04fb7e5b66aa8d6f841c5::utils::div(0x9baecae0ac0641df167127b6029dd16125bed59063a04fb7e5b66aa8d6f841c5::utils::mul(0x9baecae0ac0641df167127b6029dd16125bed59063a04fb7e5b66aa8d6f841c5::utils::from_u64(v4), 0x9baecae0ac0641df167127b6029dd16125bed59063a04fb7e5b66aa8d6f841c5::utils::from_u64(arg0.platform_fee)), 0x9baecae0ac0641df167127b6029dd16125bed59063a04fb7e5b66aa8d6f841c5::utils::from_u64(10000)));
        assert!(v4 - v5 >= arg2, 2);
        let v6 = 0x2::coin::zero<0x2::sui::SUI>(arg4);
        let (v7, v8) = swap<T0>(v2, arg1, v6, 0, v4, arg4);
        let v9 = v8;
        v2.virtual_sui_reserves = v2.virtual_sui_reserves - 0x2::coin::value<0x2::sui::SUI>(&v9);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.id_balance, 0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(&mut v9), v5));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v9, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v7, v0);
    }

    // decompiled from Move bytecode v6
}

