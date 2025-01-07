module 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool {
    struct CreatePoolCap<phantom T0> has key {
        id: 0x2::object::UID,
        lp_treasury_cap: 0x2::coin::TreasuryCap<T0>,
        lp_coin_metadata: 0x2::coin::CoinMetadata<T0>,
    }

    struct Pool<phantom T0> has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        creator: address,
        lp_supply: 0x2::balance::Supply<T0>,
        illiquid_lp_supply: 0x2::balance::Balance<T0>,
        type_names: vector<0x1::ascii::String>,
        normalized_balances: vector<u128>,
        weights: vector<u64>,
        flatness: u64,
        fees_swap_in: vector<u64>,
        fees_swap_out: vector<u64>,
        fees_deposit: vector<u64>,
        fees_withdraw: vector<u64>,
        coin_decimals: 0x1::option::Option<vector<u8>>,
        decimal_scalars: vector<u128>,
        lp_decimals: u8,
        lp_decimal_scalar: u128,
    }

    public(friend) fun join<T0, T1>(arg0: &mut Pool<T0>, arg1: 0x2::coin::Coin<T1>) {
        let v0 = borrow_mut_balance<T0, T1>(arg0);
        0x2::coin::put<T1>(v0, arg1);
        let v1 = 0x2::balance::value<T1>(v0);
        let v2 = type_to_index<T0, T1>(arg0);
        *0x1::vector::borrow_mut<u128>(&mut arg0.normalized_balances, v2) = normalize_amount_with_index<T0>(arg0, v2, v1);
    }

    public(friend) fun take<T0, T1>(arg0: &mut Pool<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = borrow_mut_balance<T0, T1>(arg0);
        let v1 = 0x2::coin::take<T1>(v0, arg1, arg2);
        let v2 = 0x2::balance::value<T1>(v0);
        let v3 = type_to_index<T0, T1>(arg0);
        *0x1::vector::borrow_mut<u128>(&mut arg0.normalized_balances, v3) = normalize_amount_with_index<T0>(arg0, v3, v2);
        v1
    }

    public(friend) fun new<T0>(arg0: CreatePoolCap<T0>, arg1: &mut 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<0x1::ascii::String>, arg8: vector<u64>, arg9: u64, arg10: vector<u64>, arg11: vector<u64>, arg12: vector<u64>, arg13: vector<u64>, arg14: 0x1::option::Option<vector<u8>>, arg15: bool, arg16: 0x1::option::Option<u8>, arg17: &mut 0x2::tx_context::TxContext) : Pool<T0> {
        assert!(0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::vector::is_sorted(&arg7), 10);
        let v0 = 0x1::vector::length<0x1::ascii::String>(&arg7);
        assert_pool_creation_parameters_are_valid<T0>(v0, arg9, &arg8, &arg10, &arg11, &arg12, &arg13, &arg14, arg15, &arg16, &arg0);
        let CreatePoolCap {
            id               : v1,
            lp_treasury_cap  : v2,
            lp_coin_metadata : v3,
        } = arg0;
        let v4 = v3;
        let v5 = v2;
        0x2::object::delete(v1);
        assert!(0x2::coin::total_supply<T0>(&v5) == 0, 7);
        let v6 = b"AfLp";
        0x1::vector::append<u8>(&mut v6, arg3);
        0x2::coin::update_name<T0>(&v5, &mut v4, 0x1::string::utf8(v6));
        let v7 = b"AF_LP_";
        0x1::vector::append<u8>(&mut v7, arg4);
        0x2::coin::update_symbol<T0>(&v5, &mut v4, 0x1::ascii::string(v7));
        0x2::coin::update_description<T0>(&v5, &mut v4, 0x1::string::utf8(arg5));
        let v8 = if (0x1::vector::length<u8>(&arg6) > 0) {
            arg6
        } else {
            b"https://i.ibb.co/GV98MHf/Aftermath-Lp-Coin-Default.png"
        };
        0x2::coin::update_icon_url<T0>(&v5, &mut v4, 0x1::ascii::string(v8));
        let v9 = 0x2::coin::get_decimals<T0>(&v4);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(v4);
        let v10 = 0x2::object::new(arg17);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::register_pool<T0>(arg1, &v10, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        let (v11, v12) = if (arg15) {
            let (v13, v14) = 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::decimals::decimal_scalars_from_decimals(0x1::option::borrow<vector<u8>>(&arg14));
            let v11 = v14;
            (v11, 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::decimals::change_decimals_128(1000000000000000000, v9, v13))
        } else {
            let v11 = 0x1::vector::empty<u128>();
            let v15 = 0;
            while (v15 < v0) {
                0x1::vector::push_back<u128>(&mut v11, 1000000000000000000);
                v15 = v15 + 1;
            };
            let v12 = if (0x1::option::is_some<vector<u8>>(&arg14)) {
                (0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::fixed::pow_down(10000000000000000000, (0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::vector::dot_64_8_128(&arg8, 0x1::option::borrow<vector<u8>>(&arg14)) as u256)) as u128) / 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::numerical::int_exp_128(10, (v9 as u64))
            } else {
                1000000000000000000
            };
            (v11, v12)
        };
        Pool<T0>{
            id                  : v10,
            name                : 0x1::string::utf8(arg2),
            creator             : 0x2::tx_context::sender(arg17),
            lp_supply           : 0x2::coin::treasury_into_supply<T0>(v5),
            illiquid_lp_supply  : 0x2::balance::zero<T0>(),
            type_names          : arg7,
            normalized_balances : 0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::vector::empty_vector_128(v0),
            weights             : arg8,
            flatness            : arg9,
            fees_swap_in        : arg10,
            fees_swap_out       : arg11,
            fees_deposit        : arg12,
            fees_withdraw       : arg13,
            coin_decimals       : arg14,
            decimal_scalars     : v11,
            lp_decimals         : v9,
            lp_decimal_scalar   : v12,
        }
    }

    fun assert_pool_creation_parameters_are_valid<T0>(arg0: u64, arg1: u64, arg2: &vector<u64>, arg3: &vector<u64>, arg4: &vector<u64>, arg5: &vector<u64>, arg6: &vector<u64>, arg7: &0x1::option::Option<vector<u8>>, arg8: bool, arg9: &0x1::option::Option<u8>, arg10: &CreatePoolCap<T0>) {
        assert!(0 <= arg1 && arg1 <= 1000000000000000000, 0);
        assert!(arg1 == 0 || arg1 == 1000000000000000000, 1);
        assert!(0x1::vector::length<u64>(arg2) == arg0, 5);
        assert!(0x1::vector::length<u64>(arg3) == arg0, 5);
        assert!(0x1::vector::length<u64>(arg4) == arg0, 5);
        assert!(0x1::vector::length<u64>(arg5) == arg0, 5);
        assert!(0x1::vector::length<u64>(arg6) == arg0, 5);
        if (0x1::option::is_some<vector<u8>>(arg7)) {
            assert!(0x1::vector::length<u8>(0x1::option::borrow<vector<u8>>(arg7)) == arg0, 5);
        };
        assert!(arg1 == 0 || arg8, 9);
        let v0 = arg8 && 0x1::option::is_none<vector<u8>>(arg7);
        assert!(!v0, 9);
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        let v4 = v3;
        let v5 = 255;
        let v6 = v5;
        let v7 = 0x1::option::is_some<vector<u8>>(arg7);
        let v8 = b"";
        let v9 = *0x1::option::borrow_with_default<vector<u8>>(arg7, &v8);
        while (v1 < arg0) {
            let v10 = *0x1::vector::borrow<u64>(arg2, v1);
            v2 = v2 + v10;
            assert!(10000000000000000 <= v10, 3);
            let v11 = *0x1::vector::borrow<u64>(arg3, v1);
            assert!(100000000000000 <= v11 && v11 <= 100000000000000000, 4);
            assert!(*0x1::vector::borrow<u64>(arg4, v1) == 0, 4);
            assert!(*0x1::vector::borrow<u64>(arg5, v1) == 0, 4);
            assert!(*0x1::vector::borrow<u64>(arg6, v1) == 0, 4);
            if (v7) {
                let v12 = *0x1::vector::borrow<u8>(&v9, v1);
                if (v12 > v3) {
                    v4 = v12;
                };
                if (v12 < v5) {
                    v6 = v12;
                };
            };
            v1 = v1 + 1;
        };
        assert!(v4 <= 18, 9);
        let v13 = if (arg8) {
            v6
        } else if (v7) {
            ((0x73baa782c55003b3a359dec04b189312565d18e7309d4a51f5f112f891e3b2ab::vector::dot_64_8_128(arg2, &v9) / 1000000000000000000) as u8)
        } else {
            9
        };
        let v14 = v13;
        let v15 = *0x1::option::borrow_with_default<u8>(arg9, &v14);
        assert!(v15 <= 18, 9);
        assert!(0x2::coin::get_decimals<T0>(&arg10.lp_coin_metadata) == v15, 9);
        assert!(v2 == 1000000000000000000, 2);
    }

    public fun balance_of<T0, T1>(arg0: &Pool<T0>) : u64 {
        0x2::balance::value<T1>(borrow_balance<T0, T1>(arg0))
    }

    public fun balances<T0>(arg0: &Pool<T0>) : vector<u64> {
        unnormalize_amounts<T0>(arg0, &arg0.normalized_balances)
    }

    fun borrow_balance<T0, T1>(arg0: &Pool<T0>) : &0x2::balance::Balance<T1> {
        0x2::dynamic_field::borrow<0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::keys::BalanceKey<T1>, 0x2::balance::Balance<T1>>(&arg0.id, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::keys::type_to_balance_key<T1>())
    }

    fun borrow_mut_balance<T0, T1>(arg0: &mut Pool<T0>) : &mut 0x2::balance::Balance<T1> {
        0x2::dynamic_field::borrow_mut<0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::keys::BalanceKey<T1>, 0x2::balance::Balance<T1>>(&mut arg0.id, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::keys::type_to_balance_key<T1>())
    }

    public(friend) fun burn_lp_coins<T0>(arg0: &mut Pool<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::decrease_supply<T0>(&mut arg0.lp_supply, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun coin_decimals<T0>(arg0: &Pool<T0>) : &0x1::option::Option<vector<u8>> {
        &arg0.coin_decimals
    }

    public fun contains_type<T0, T1>(arg0: &Pool<T0>) : bool {
        let v0 = 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::keys::type_to_string<T1>();
        let (v1, _) = 0x1::vector::index_of<0x1::ascii::String>(&arg0.type_names, &v0);
        v1
    }

    public(friend) fun create_lp_coin<T0: drop>(arg0: T0, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) : CreatePoolCap<T0> {
        let (v0, v1) = 0x2::coin::create_currency<T0>(arg0, arg1, b"", b"", b"", 0x1::option::none<0x2::url::Url>(), arg2);
        CreatePoolCap<T0>{
            id               : 0x2::object::new(arg2),
            lp_treasury_cap  : v0,
            lp_coin_metadata : v1,
        }
    }

    public fun creator<T0>(arg0: &Pool<T0>) : address {
        arg0.creator
    }

    public fun fees_deposit<T0>(arg0: &Pool<T0>) : vector<u64> {
        arg0.fees_deposit
    }

    public fun fees_deposit_for<T0, T1>(arg0: &Pool<T0>) : u64 {
        *0x1::vector::borrow<u64>(&arg0.fees_deposit, type_to_index<T0, T1>(arg0))
    }

    public fun fees_swap_in<T0>(arg0: &Pool<T0>) : vector<u64> {
        arg0.fees_swap_in
    }

    public fun fees_swap_in_for<T0, T1>(arg0: &Pool<T0>) : u64 {
        *0x1::vector::borrow<u64>(&arg0.fees_swap_in, type_to_index<T0, T1>(arg0))
    }

    public fun fees_swap_out<T0>(arg0: &Pool<T0>) : vector<u64> {
        arg0.fees_swap_out
    }

    public fun fees_swap_out_for<T0, T1>(arg0: &Pool<T0>) : u64 {
        *0x1::vector::borrow<u64>(&arg0.fees_swap_out, type_to_index<T0, T1>(arg0))
    }

    public fun fees_withdraw<T0>(arg0: &Pool<T0>) : vector<u64> {
        arg0.fees_withdraw
    }

    public fun fees_withdraw_for<T0, T1>(arg0: &Pool<T0>) : u64 {
        *0x1::vector::borrow<u64>(&arg0.fees_withdraw, type_to_index<T0, T1>(arg0))
    }

    public fun flatness<T0>(arg0: &Pool<T0>) : u64 {
        arg0.flatness
    }

    public(friend) fun initialize_liquidity<T0, T1>(arg0: &mut 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg1: &mut Pool<T0>, arg2: 0x2::coin::Coin<T1>) {
        0x2::dynamic_field::add<0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::keys::BalanceKey<T1>, 0x2::balance::Balance<T1>>(&mut arg1.id, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::keys::type_to_balance_key<T1>(), 0x2::balance::zero<T1>());
        join<T0, T1>(arg1, arg2);
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::add_coin<T1>(arg0);
    }

    public(friend) fun initialize_lp_supply<T0>(arg0: &mut Pool<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1 > 1000, 6);
        0x2::balance::join<T0>(&mut arg0.illiquid_lp_supply, 0x2::balance::increase_supply<T0>(&mut arg0.lp_supply, 1000));
        0x2::coin::from_balance<T0>(0x2::balance::increase_supply<T0>(&mut arg0.lp_supply, arg1 - 1000), arg2)
    }

    public fun lp_decimals<T0>(arg0: &Pool<T0>) : u8 {
        arg0.lp_decimals
    }

    public fun lp_supply_value<T0>(arg0: &Pool<T0>) : u64 {
        0x2::balance::supply_value<T0>(&arg0.lp_supply)
    }

    public fun lp_type<T0>(arg0: &Pool<T0>) : 0x1::ascii::String {
        0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::keys::type_to_string<T0>()
    }

    public(friend) fun mint_lp_coins<T0>(arg0: &mut Pool<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(0x2::balance::increase_supply<T0>(&mut arg0.lp_supply, arg1), arg2)
    }

    public fun name<T0>(arg0: &Pool<T0>) : 0x1::string::String {
        arg0.name
    }

    public(friend) fun normalize_amount<T0, T1>(arg0: &Pool<T0>, arg1: u64) : u128 {
        (arg1 as u128) * *0x1::vector::borrow<u128>(&arg0.decimal_scalars, type_to_index<T0, T1>(arg0))
    }

    public(friend) fun normalize_amount_with_index<T0>(arg0: &Pool<T0>, arg1: u64, arg2: u64) : u128 {
        (arg2 as u128) * *0x1::vector::borrow<u128>(&arg0.decimal_scalars, arg1)
    }

    public(friend) fun normalize_amounts<T0>(arg0: &Pool<T0>, arg1: &vector<u64>) : vector<u128> {
        let v0 = 0x1::vector::empty<u128>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u128>(&arg0.normalized_balances)) {
            0x1::vector::push_back<u128>(&mut v0, (*0x1::vector::borrow<u64>(arg1, v1) as u128) * *0x1::vector::borrow<u128>(&arg0.decimal_scalars, v1));
            v1 = v1 + 1;
        };
        v0
    }

    public(friend) fun normalize_lp_amount<T0>(arg0: &Pool<T0>, arg1: u64) : u128 {
        (arg1 as u128) * arg0.lp_decimal_scalar
    }

    public(friend) fun normalized_balance_by_index<T0>(arg0: &Pool<T0>, arg1: u64) : u128 {
        *0x1::vector::borrow<u128>(&arg0.normalized_balances, arg1)
    }

    public(friend) fun normalized_balance_of<T0, T1>(arg0: &Pool<T0>) : u128 {
        *0x1::vector::borrow<u128>(&arg0.normalized_balances, type_to_index<T0, T1>(arg0))
    }

    public(friend) fun normalized_balances<T0>(arg0: &Pool<T0>) : vector<u128> {
        arg0.normalized_balances
    }

    public fun share<T0>(arg0: Pool<T0>) {
        0x2::transfer::public_share_object<Pool<T0>>(arg0);
    }

    public fun size<T0>(arg0: &Pool<T0>) : u64 {
        0x1::vector::length<u64>(&arg0.weights)
    }

    public fun transfer_create_pool_cap<T0>(arg0: CreatePoolCap<T0>, arg1: address) {
        0x2::transfer::transfer<CreatePoolCap<T0>>(arg0, arg1);
    }

    public(friend) fun type_name_to_balance_value<T0>(arg0: &Pool<T0>, arg1: 0x1::ascii::String) : u64 {
        let v0 = type_name_to_index<T0>(arg0, arg1);
        unnormalize_amount_with_index<T0>(arg0, v0, normalized_balance_by_index<T0>(arg0, v0))
    }

    public(friend) fun type_name_to_index<T0>(arg0: &Pool<T0>, arg1: 0x1::ascii::String) : u64 {
        let (v0, v1) = 0x1::vector::index_of<0x1::ascii::String>(&arg0.type_names, &arg1);
        assert!(v0, 8);
        v1
    }

    public(friend) fun type_name_to_normalized_balance_value<T0>(arg0: &Pool<T0>, arg1: 0x1::ascii::String) : u128 {
        *0x1::vector::borrow<u128>(&arg0.normalized_balances, type_name_to_index<T0>(arg0, arg1))
    }

    public fun type_names<T0>(arg0: &Pool<T0>) : vector<0x1::ascii::String> {
        arg0.type_names
    }

    public(friend) fun type_to_index<T0, T1>(arg0: &Pool<T0>) : u64 {
        type_name_to_index<T0>(arg0, 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::keys::type_to_string<T1>())
    }

    public(friend) fun unnormalize_amount<T0, T1>(arg0: &Pool<T0>, arg1: u128) : u64 {
        ((arg1 / *0x1::vector::borrow<u128>(&arg0.decimal_scalars, type_to_index<T0, T1>(arg0))) as u64)
    }

    public(friend) fun unnormalize_amount_with_index<T0>(arg0: &Pool<T0>, arg1: u64, arg2: u128) : u64 {
        ((arg2 / *0x1::vector::borrow<u128>(&arg0.decimal_scalars, arg1)) as u64)
    }

    public(friend) fun unnormalize_amounts<T0>(arg0: &Pool<T0>, arg1: &vector<u128>) : vector<u64> {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u128>(&arg0.normalized_balances)) {
            0x1::vector::push_back<u64>(&mut v0, ((*0x1::vector::borrow<u128>(arg1, v1) / *0x1::vector::borrow<u128>(&arg0.decimal_scalars, v1)) as u64));
            v1 = v1 + 1;
        };
        v0
    }

    public(friend) fun unnormalize_lp_amount<T0>(arg0: &Pool<T0>, arg1: u128) : u64 {
        ((arg1 / arg0.lp_decimal_scalar) as u64)
    }

    public fun weight_of<T0, T1>(arg0: &Pool<T0>) : u64 {
        *0x1::vector::borrow<u64>(&arg0.weights, type_to_index<T0, T1>(arg0))
    }

    public fun weights<T0>(arg0: &Pool<T0>) : vector<u64> {
        arg0.weights
    }

    // decompiled from Move bytecode v6
}

