module 0xe7fa4dae529d137d79ad1160950408451dc4c28e76610a999d463a4ef64c5f55::typus_hedge {
    struct TYPUS_HEDGE has drop {
        dummy_field: bool,
    }

    struct VERSION has drop {
        dummy_field: bool,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        num_of_vault: u64,
        transaction_suspended: bool,
    }

    struct Vault has store, key {
        id: 0x2::object::UID,
        main_token: 0x1::type_name::TypeName,
        hedge_token: 0x1::type_name::TypeName,
        reward_tokens: vector<0x1::type_name::TypeName>,
        info: 0x2::vec_map::VecMap<0x1::string::String, u64>,
        config: 0x2::vec_map::VecMap<0x1::string::String, u64>,
        user_share: 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::KeyedBigVector,
        user_share_supply: vector<u64>,
        reward_token_share: 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::KeyedBigVector,
        reward_token_share_supply: vector<u64>,
        u64_padding: 0x2::vec_map::VecMap<0x1::string::String, u64>,
        bcs_padding: 0x2::vec_map::VecMap<0x1::string::String, vector<u8>>,
    }

    fun calculate_hedge_token_balance(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg2 as u128) / (arg1 as u128)) as u64)
    }

    fun calculate_main_token_balance(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public fun capabilities_mut<T0: drop>(arg0: T0, arg1: &0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::Version, arg2: &mut Registry, arg3: u64, arg4: &0x2::tx_context::TxContext) : &mut 0x2::bag::Bag {
        verify(arg1, arg4);
        let v0 = 0x1::vector::empty<vector<u8>>();
        let v1 = &mut v0;
        0x1::vector::push_back<vector<u8>>(v1, b"");
        0x1::vector::push_back<vector<u8>>(v1, b"");
        let v2 = 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        assert!(0x1::vector::contains<vector<u8>>(&v0, &v2), 0xe7fa4dae529d137d79ad1160950408451dc4c28e76610a999d463a4ef64c5f55::error::invalid_witness(arg3));
        0x2::dynamic_object_field::borrow_mut<0x1::string::String, 0x2::bag::Bag>(&mut 0x2::dynamic_object_field::borrow_mut<u64, Vault>(&mut arg2.id, arg3).id, 0x1::string::utf8(b"capability"))
    }

    public fun config(arg0: &0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::Version, arg1: &Registry, arg2: u64) : 0x2::vec_map::VecMap<0x1::string::String, u64> {
        version_check(arg0);
        0x2::dynamic_object_field::borrow<u64, Vault>(&arg1.id, arg2).config
    }

    public fun deposit_hedge_token<T0: drop, T1>(arg0: T0, arg1: &0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::Version, arg2: &mut Registry, arg3: u64, arg4: 0x2::balance::Balance<T1>, arg5: &0x2::tx_context::TxContext) : vector<u64> {
        verify(arg1, arg5);
        let v0 = if (0x1::type_name::get<T0>() == 0x1::type_name::get<VERSION>()) {
            true
        } else {
            let v1 = 0x1::vector::empty<vector<u8>>();
            let v2 = &mut v1;
            0x1::vector::push_back<vector<u8>>(v2, b"");
            0x1::vector::push_back<vector<u8>>(v2, b"");
            let v3 = 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>()));
            0x1::vector::contains<vector<u8>>(&v1, &v3)
        };
        assert!(v0, 0xe7fa4dae529d137d79ad1160950408451dc4c28e76610a999d463a4ef64c5f55::error::invalid_witness(arg3));
        let v4 = 0x2::dynamic_object_field::borrow_mut<u64, Vault>(&mut arg2.id, arg3);
        0x2::balance::join<T1>(0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::balance::Balance<T1>>(&mut v4.id, 0x1::string::utf8(b"hedge_balance")), arg4);
        let v5 = 0x1::vector::empty<0x1::string::String>();
        let v6 = &mut v5;
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"index"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"round"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"amount"));
        let v7 = 0x1::string::utf8(b"round");
        let v8 = 0x1::vector::empty<u64>();
        let v9 = &mut v8;
        0x1::vector::push_back<u64>(v9, arg3);
        0x1::vector::push_back<u64>(v9, *0x2::vec_map::get<0x1::string::String, u64>(&v4.info, &v7));
        0x1::vector::push_back<u64>(v9, 0x2::balance::value<T1>(&arg4));
        let v10 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v10, 0x1::string::utf8(b"token"));
        let v11 = 0x1::type_name::get<T1>();
        let v12 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v12, 0x1::bcs::to_bytes<0x1::type_name::TypeName>(&v11));
        0xe7fa4dae529d137d79ad1160950408451dc4c28e76610a999d463a4ef64c5f55::event::emit_manager_event(0x1::string::utf8(b"deposit_hedge_token"), 0x2::vec_map::from_keys_values<0x1::string::String, u64>(v5, v8), 0x2::vec_map::from_keys_values<0x1::string::String, vector<u8>>(v10, v12));
        let v13 = 0x1::string::utf8(b"round");
        let v14 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v14, *0x2::vec_map::get<0x1::string::String, u64>(&v4.info, &v13));
        v14
    }

    public fun deposit_hedge_token_<T0>(arg0: &0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::Version, arg1: &mut Registry, arg2: u64, arg3: 0x2::balance::Balance<T0>, arg4: &0x2::tx_context::TxContext) : vector<u64> {
        let v0 = VERSION{dummy_field: false};
        deposit_hedge_token<VERSION, T0>(v0, arg0, arg1, arg2, arg3, arg4)
    }

    public fun deposit_main_token<T0: drop, T1>(arg0: T0, arg1: &0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::Version, arg2: &mut Registry, arg3: u64, arg4: 0x2::balance::Balance<T1>, arg5: &0x2::tx_context::TxContext) : vector<u64> {
        verify(arg1, arg5);
        let v0 = if (0x1::type_name::get<T0>() == 0x1::type_name::get<VERSION>()) {
            true
        } else {
            let v1 = 0x1::vector::empty<vector<u8>>();
            let v2 = &mut v1;
            0x1::vector::push_back<vector<u8>>(v2, b"");
            0x1::vector::push_back<vector<u8>>(v2, b"");
            let v3 = 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>()));
            0x1::vector::contains<vector<u8>>(&v1, &v3)
        };
        assert!(v0, 0xe7fa4dae529d137d79ad1160950408451dc4c28e76610a999d463a4ef64c5f55::error::invalid_witness(arg3));
        let v4 = 0x2::dynamic_object_field::borrow_mut<u64, Vault>(&mut arg2.id, arg3);
        0x2::balance::join<T1>(0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::balance::Balance<T1>>(&mut v4.id, 0x1::string::utf8(b"main_balance")), arg4);
        let v5 = 0x1::vector::empty<0x1::string::String>();
        let v6 = &mut v5;
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"index"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"round"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"amount"));
        let v7 = 0x1::string::utf8(b"round");
        let v8 = 0x1::vector::empty<u64>();
        let v9 = &mut v8;
        0x1::vector::push_back<u64>(v9, arg3);
        0x1::vector::push_back<u64>(v9, *0x2::vec_map::get<0x1::string::String, u64>(&v4.info, &v7));
        0x1::vector::push_back<u64>(v9, 0x2::balance::value<T1>(&arg4));
        let v10 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v10, 0x1::string::utf8(b"token"));
        let v11 = 0x1::type_name::get<T1>();
        let v12 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v12, 0x1::bcs::to_bytes<0x1::type_name::TypeName>(&v11));
        0xe7fa4dae529d137d79ad1160950408451dc4c28e76610a999d463a4ef64c5f55::event::emit_manager_event(0x1::string::utf8(b"deposit_main_token"), 0x2::vec_map::from_keys_values<0x1::string::String, u64>(v5, v8), 0x2::vec_map::from_keys_values<0x1::string::String, vector<u8>>(v10, v12));
        let v13 = 0x1::string::utf8(b"round");
        let v14 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v14, *0x2::vec_map::get<0x1::string::String, u64>(&v4.info, &v13));
        v14
    }

    public fun deposit_main_token_<T0>(arg0: &0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::Version, arg1: &mut Registry, arg2: u64, arg3: 0x2::balance::Balance<T0>, arg4: &0x2::tx_context::TxContext) : vector<u64> {
        let v0 = VERSION{dummy_field: false};
        deposit_main_token<VERSION, T0>(v0, arg0, arg1, arg2, arg3, arg4)
    }

    public fun deposit_other_token<T0: drop, T1>(arg0: T0, arg1: &0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::Version, arg2: &mut Registry, arg3: u64, arg4: 0x2::balance::Balance<T1>, arg5: &0x2::tx_context::TxContext) : vector<u64> {
        verify(arg1, arg5);
        let v0 = if (0x1::type_name::get<T0>() == 0x1::type_name::get<VERSION>()) {
            true
        } else {
            let v1 = 0x1::vector::empty<vector<u8>>();
            let v2 = &mut v1;
            0x1::vector::push_back<vector<u8>>(v2, b"");
            0x1::vector::push_back<vector<u8>>(v2, b"");
            let v3 = 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>()));
            0x1::vector::contains<vector<u8>>(&v1, &v3)
        };
        assert!(v0, 0xe7fa4dae529d137d79ad1160950408451dc4c28e76610a999d463a4ef64c5f55::error::invalid_witness(arg3));
        let v4 = 0x2::dynamic_object_field::borrow_mut<u64, Vault>(&mut arg2.id, arg3);
        if (0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&v4.id, 0x1::type_name::get<T1>())) {
            0x2::balance::join<T1>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut v4.id, 0x1::type_name::get<T1>()), arg4);
        } else {
            0x2::dynamic_field::add<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut v4.id, 0x1::type_name::get<T1>(), arg4);
        };
        let v5 = 0x1::vector::empty<0x1::string::String>();
        let v6 = &mut v5;
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"index"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"round"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"amount"));
        let v7 = 0x1::string::utf8(b"round");
        let v8 = 0x1::vector::empty<u64>();
        let v9 = &mut v8;
        0x1::vector::push_back<u64>(v9, arg3);
        0x1::vector::push_back<u64>(v9, *0x2::vec_map::get<0x1::string::String, u64>(&v4.info, &v7));
        0x1::vector::push_back<u64>(v9, 0x2::balance::value<T1>(&arg4));
        let v10 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v10, 0x1::string::utf8(b"token"));
        let v11 = 0x1::type_name::get<T1>();
        let v12 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v12, 0x1::bcs::to_bytes<0x1::type_name::TypeName>(&v11));
        0xe7fa4dae529d137d79ad1160950408451dc4c28e76610a999d463a4ef64c5f55::event::emit_manager_event(0x1::string::utf8(b"deposit_other_token"), 0x2::vec_map::from_keys_values<0x1::string::String, u64>(v5, v8), 0x2::vec_map::from_keys_values<0x1::string::String, vector<u8>>(v10, v12));
        let v13 = 0x1::string::utf8(b"round");
        let v14 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v14, *0x2::vec_map::get<0x1::string::String, u64>(&v4.info, &v13));
        v14
    }

    public fun deposit_other_token_<T0>(arg0: &0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::Version, arg1: &mut Registry, arg2: u64, arg3: 0x2::balance::Balance<T0>, arg4: &0x2::tx_context::TxContext) : vector<u64> {
        let v0 = VERSION{dummy_field: false};
        deposit_other_token<VERSION, T0>(v0, arg0, arg1, arg2, arg3, arg4)
    }

    public(friend) fun get_vault_shares(arg0: &Registry, arg1: u64) : (&0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::KeyedBigVector, &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::KeyedBigVector, u64) {
        let v0 = 0x2::dynamic_object_field::borrow<u64, Vault>(&arg0.id, arg1);
        (&v0.user_share, &v0.reward_token_share, 0x1::vector::length<0x1::type_name::TypeName>(&v0.reward_tokens))
    }

    public fun info(arg0: &0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::Version, arg1: &Registry, arg2: u64) : 0x2::vec_map::VecMap<0x1::string::String, u64> {
        version_check(arg0);
        0x2::dynamic_object_field::borrow<u64, Vault>(&arg1.id, arg2).info
    }

    fun init(arg0: TYPUS_HEDGE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = VERSION{dummy_field: false};
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::issue_version<TYPUS_HEDGE, VERSION>(&arg0, v0, arg1);
        let v1 = Registry{
            id                    : 0x2::object::new(arg1),
            num_of_vault          : 0,
            transaction_suspended : false,
        };
        0x2::transfer::share_object<Registry>(v1);
    }

    entry fun issue_typus_manager_cap(arg0: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg1: &mut Registry, arg2: &0x2::tx_context::TxContext) {
        0x2::dynamic_field::add<0x1::string::String, 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::ManagerCap>(&mut arg1.id, 0x1::string::utf8(b"typus_manager_cap"), 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::issue_manager_cap(arg0, arg2));
    }

    entry fun new_vault<T0, T1>(arg0: &0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::Version, arg1: &mut Registry, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: u64, arg20: u64, arg21: u64, arg22: &0x2::clock::Clock, arg23: &mut 0x2::tx_context::TxContext) {
        verify(arg0, arg23);
        let v0 = 0x2::vec_map::empty<0x1::string::String, u64>();
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v0, 0x1::string::utf8(b"creation_ts_ms"), 0x2::clock::timestamp_ms(arg22));
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v0, 0x1::string::utf8(b"index"), arg1.num_of_vault);
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v0, 0x1::string::utf8(b"round"), 0);
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v0, 0x1::string::utf8(b"refresh_ts_ms"), arg2);
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v0, 0x1::string::utf8(b"status"), 0);
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v0, 0x1::string::utf8(b"main_token_decimal"), arg3);
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v0, 0x1::string::utf8(b"hedge_token_decimal"), arg4);
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v0, 0x1::string::utf8(b"main_token_price_mbp"), arg5);
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v0, 0x1::string::utf8(b"hedge_token_price_mbp"), arg6);
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v0, 0x1::string::utf8(b"capacity"), arg7);
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v0, 0x1::string::utf8(b"main_token_ratio"), arg8);
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v0, 0x1::string::utf8(b"hedge_token_ratio"), arg9);
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v0, 0x1::string::utf8(b"main_token_lot_size"), arg10);
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v0, 0x1::string::utf8(b"hedge_token_lot_size"), arg11);
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v0, 0x1::string::utf8(b"main_token_min_size"), arg12);
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v0, 0x1::string::utf8(b"hedge_token_min_size"), arg13);
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v0, 0x1::string::utf8(b"exp_per_hour_bp"), arg14);
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v0, 0x1::string::utf8(b"point_per_hour_bp"), arg15);
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v0, 0x1::string::utf8(b"incentive_mbp"), arg16);
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v0, 0x1::string::utf8(b"incentive_fixed"), arg17);
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v0, 0x1::string::utf8(b"exit_fee_bp"), arg18);
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v0, 0x1::string::utf8(b"exit_fee_amount"), arg19);
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v0, 0x1::string::utf8(b"main_token_dov_tvl_mapping_index"), arg20);
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v0, 0x1::string::utf8(b"hedge_token_dov_tvl_mapping_index"), arg21);
        let v1 = 0x2::vec_map::empty<0x1::string::String, u64>();
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v1, 0x1::string::utf8(b"creation_ts_ms"), 0x2::clock::timestamp_ms(arg22));
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v1, 0x1::string::utf8(b"index"), arg1.num_of_vault);
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v1, 0x1::string::utf8(b"round"), 0);
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v1, 0x1::string::utf8(b"refresh_ts_ms"), arg2);
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v1, 0x1::string::utf8(b"status"), 0);
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v1, 0x1::string::utf8(b"main_token_decimal"), arg3);
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v1, 0x1::string::utf8(b"hedge_token_decimal"), arg4);
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v1, 0x1::string::utf8(b"main_token_price_mbp"), arg5);
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v1, 0x1::string::utf8(b"hedge_token_price_mbp"), arg6);
        let v2 = 0x2::vec_map::empty<0x1::string::String, u64>();
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v2, 0x1::string::utf8(b"capacity"), arg7);
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v2, 0x1::string::utf8(b"main_token_ratio"), arg8);
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v2, 0x1::string::utf8(b"hedge_token_ratio"), arg9);
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v2, 0x1::string::utf8(b"main_token_lot_size"), arg10);
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v2, 0x1::string::utf8(b"hedge_token_lot_size"), arg11);
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v2, 0x1::string::utf8(b"main_token_min_size"), arg12);
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v2, 0x1::string::utf8(b"hedge_token_min_size"), arg13);
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v2, 0x1::string::utf8(b"exp_per_hour_bp"), arg14);
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v2, 0x1::string::utf8(b"point_per_hour_bp"), arg15);
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v2, 0x1::string::utf8(b"incentive_mbp"), arg16);
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v2, 0x1::string::utf8(b"incentive_fixed"), arg17);
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v2, 0x1::string::utf8(b"exit_fee_bp"), arg18);
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v2, 0x1::string::utf8(b"exit_fee_amount"), arg19);
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v2, 0x1::string::utf8(b"main_token_dov_tvl_mapping_index"), arg20);
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v2, 0x1::string::utf8(b"hedge_token_dov_tvl_mapping_index"), arg21);
        let v3 = vector[];
        let v4 = 0;
        while (v4 < 10) {
            0x1::vector::push_back<u64>(&mut v3, 0);
            v4 = v4 + 1;
        };
        let v5 = vector[];
        let v6 = 0;
        while (v6 < 0) {
            0x1::vector::push_back<u64>(&mut v5, 0);
            v6 = v6 + 1;
        };
        let v7 = Vault{
            id                        : 0x2::object::new(arg23),
            main_token                : 0x1::type_name::get<T0>(),
            hedge_token               : 0x1::type_name::get<T1>(),
            reward_tokens             : 0x1::vector::empty<0x1::type_name::TypeName>(),
            info                      : v1,
            config                    : v2,
            user_share                : 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::new<address, vector<u64>>(1000, arg23),
            user_share_supply         : v3,
            reward_token_share        : 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::new<address, vector<u64>>(1000, arg23),
            reward_token_share_supply : v5,
            u64_padding               : 0x2::vec_map::empty<0x1::string::String, u64>(),
            bcs_padding               : 0x2::vec_map::empty<0x1::string::String, vector<u8>>(),
        };
        0x2::dynamic_field::add<0x1::string::String, 0x2::balance::Balance<T0>>(&mut v7.id, 0x1::string::utf8(b"main_balance"), 0x2::balance::zero<T0>());
        0x2::dynamic_field::add<0x1::string::String, 0x2::balance::Balance<T1>>(&mut v7.id, 0x1::string::utf8(b"hedge_balance"), 0x2::balance::zero<T1>());
        0x2::dynamic_object_field::add<0x1::string::String, 0x2::bag::Bag>(&mut v7.id, 0x1::string::utf8(b"capability"), 0x2::bag::new(arg23));
        0x2::dynamic_object_field::add<u64, Vault>(&mut arg1.id, arg1.num_of_vault, v7);
        arg1.num_of_vault = arg1.num_of_vault + 1;
        0xe7fa4dae529d137d79ad1160950408451dc4c28e76610a999d463a4ef64c5f55::event::emit_manager_event(0x1::string::utf8(b"new_vault"), v0, 0x2::vec_map::empty<0x1::string::String, vector<u8>>());
    }

    public fun raise_fund<T0, T1>(arg0: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg1: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::leaderboard::TypusLeaderboardRegistry, arg2: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::user::TypusUserRegistry, arg3: &0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::Version, arg4: &mut Registry, arg5: u64, arg6: 0x2::balance::Balance<T0>, arg7: 0x2::balance::Balance<T1>, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        version_check(arg3);
        assert!(!arg4.transaction_suspended, 0xe7fa4dae529d137d79ad1160950408451dc4c28e76610a999d463a4ef64c5f55::error::transaction_suspended(arg5));
        let v0 = 0x2::dynamic_field::remove<0x1::string::String, 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::ManagerCap>(&mut arg4.id, 0x1::string::utf8(b"typus_manager_cap"));
        let v1 = 0x2::dynamic_object_field::borrow_mut<u64, Vault>(&mut arg4.id, arg5);
        token_type_check<T0, T1>(v1);
        let v2 = 0x1::string::utf8(b"status");
        let v3 = 999;
        assert!(0x2::vec_map::get<0x1::string::String, u64>(&v1.info, &v2) != &v3, 0xe7fa4dae529d137d79ad1160950408451dc4c28e76610a999d463a4ef64c5f55::error::already_closed(arg5));
        0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::account::create_account(arg0, arg13);
        let v4 = 0x2::object::id_address<0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::account::Account>(0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::account::borrow_user_account(arg0, arg13));
        if (!0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::contains<address>(&v1.user_share, v4)) {
            let v5 = vector[];
            let v6 = 0;
            while (v6 < 10) {
                0x1::vector::push_back<u64>(&mut v5, 0);
                v6 = v6 + 1;
            };
            0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::push_back<address, vector<u64>>(&mut v1.user_share, v4, v5);
        };
        if (!0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::contains<address>(&v1.reward_token_share, v4)) {
            let v7 = vector[];
            let v8 = 0;
            while (v8 < 0x1::vector::length<0x1::type_name::TypeName>(&v1.reward_tokens)) {
                0x1::vector::push_back<u64>(&mut v7, 0);
                v8 = v8 + 1;
            };
            0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::push_back<address, vector<u64>>(&mut v1.reward_token_share, v4, v7);
        };
        let (v9, v10) = update_typus_point(arg0, arg1, arg2, &v0, v1, v4, arg12, arg13);
        let v11 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::borrow_by_key_mut<address, vector<u64>>(&mut v1.user_share, v4);
        let v12 = 0x2::balance::value<T0>(&arg6);
        let v13 = 0x2::balance::value<T1>(&arg7);
        *0x1::vector::borrow_mut<u64>(v11, 6) = *0x1::vector::borrow<u64>(v11, 6) + v12;
        *0x1::vector::borrow_mut<u64>(&mut v1.user_share_supply, 6) = *0x1::vector::borrow<u64>(&v1.user_share_supply, 6) + v12;
        0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::balance::Balance<T0>>(&mut v1.id, 0x1::string::utf8(b"main_balance")), arg6);
        *0x1::vector::borrow_mut<u64>(v11, 7) = *0x1::vector::borrow<u64>(v11, 7) + v13;
        *0x1::vector::borrow_mut<u64>(&mut v1.user_share_supply, 7) = *0x1::vector::borrow<u64>(&v1.user_share_supply, 7) + v13;
        0x2::balance::join<T1>(0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::balance::Balance<T1>>(&mut v1.id, 0x1::string::utf8(b"hedge_balance")), arg7);
        let v14 = if (*0x1::vector::borrow<u64>(v11, 2) < arg8) {
            *0x1::vector::borrow<u64>(v11, 2)
        } else {
            arg8
        };
        *0x1::vector::borrow_mut<u64>(v11, 0) = *0x1::vector::borrow<u64>(v11, 0) + v14;
        *0x1::vector::borrow_mut<u64>(&mut v1.user_share_supply, 0) = *0x1::vector::borrow<u64>(&v1.user_share_supply, 0) + v14;
        *0x1::vector::borrow_mut<u64>(v11, 2) = *0x1::vector::borrow<u64>(v11, 2) - v14;
        *0x1::vector::borrow_mut<u64>(&mut v1.user_share_supply, 2) = *0x1::vector::borrow<u64>(&v1.user_share_supply, 2) - v14;
        let v15 = if (*0x1::vector::borrow<u64>(v11, 3) < arg9) {
            *0x1::vector::borrow<u64>(v11, 3)
        } else {
            arg9
        };
        *0x1::vector::borrow_mut<u64>(v11, 1) = *0x1::vector::borrow<u64>(v11, 1) + v15;
        *0x1::vector::borrow_mut<u64>(&mut v1.user_share_supply, 1) = *0x1::vector::borrow<u64>(&v1.user_share_supply, 1) + v15;
        *0x1::vector::borrow_mut<u64>(v11, 3) = *0x1::vector::borrow<u64>(v11, 3) - v15;
        *0x1::vector::borrow_mut<u64>(&mut v1.user_share_supply, 3) = *0x1::vector::borrow<u64>(&v1.user_share_supply, 3) - v15;
        let v16 = if (*0x1::vector::borrow<u64>(v11, 4) < arg10) {
            *0x1::vector::borrow<u64>(v11, 4)
        } else {
            arg10
        };
        *0x1::vector::borrow_mut<u64>(v11, 6) = *0x1::vector::borrow<u64>(v11, 6) + v16;
        *0x1::vector::borrow_mut<u64>(&mut v1.user_share_supply, 6) = *0x1::vector::borrow<u64>(&v1.user_share_supply, 6) + v16;
        *0x1::vector::borrow_mut<u64>(v11, 4) = *0x1::vector::borrow<u64>(v11, 4) - v16;
        *0x1::vector::borrow_mut<u64>(&mut v1.user_share_supply, 4) = *0x1::vector::borrow<u64>(&v1.user_share_supply, 4) - v16;
        let v17 = if (*0x1::vector::borrow<u64>(v11, 5) < arg11) {
            *0x1::vector::borrow<u64>(v11, 5)
        } else {
            arg11
        };
        *0x1::vector::borrow_mut<u64>(v11, 7) = *0x1::vector::borrow<u64>(v11, 7) + v17;
        *0x1::vector::borrow_mut<u64>(&mut v1.user_share_supply, 7) = *0x1::vector::borrow<u64>(&v1.user_share_supply, 7) + v17;
        *0x1::vector::borrow_mut<u64>(v11, 5) = *0x1::vector::borrow<u64>(v11, 5) - v17;
        *0x1::vector::borrow_mut<u64>(&mut v1.user_share_supply, 5) = *0x1::vector::borrow<u64>(&v1.user_share_supply, 5) - v17;
        update_snapshot_usd_value(v1, v4);
        assert!(v12 + v14 + v16 + v13 + v15 + v17 > 0, 0xe7fa4dae529d137d79ad1160950408451dc4c28e76610a999d463a4ef64c5f55::error::zero_value(arg5));
        let v18 = 0x1::string::utf8(b"capacity");
        assert!(*0x1::vector::borrow<u64>(&v1.user_share_supply, 6) + *0x1::vector::borrow<u64>(&v1.user_share_supply, 0) <= *0x2::vec_map::get<0x1::string::String, u64>(&v1.config, &v18), 0xe7fa4dae529d137d79ad1160950408451dc4c28e76610a999d463a4ef64c5f55::error::capacity_violation(arg5));
        let v19 = 0x1::vector::empty<0x1::string::String>();
        let v20 = &mut v19;
        0x1::vector::push_back<0x1::string::String>(v20, 0x1::string::utf8(b"index"));
        0x1::vector::push_back<0x1::string::String>(v20, 0x1::string::utf8(b"round"));
        0x1::vector::push_back<0x1::string::String>(v20, 0x1::string::utf8(b"main_balance_value"));
        0x1::vector::push_back<0x1::string::String>(v20, 0x1::string::utf8(b"hedge_balance_value"));
        0x1::vector::push_back<0x1::string::String>(v20, 0x1::string::utf8(b"main_deactivating_value"));
        0x1::vector::push_back<0x1::string::String>(v20, 0x1::string::utf8(b"hedge_deactivating_value"));
        0x1::vector::push_back<0x1::string::String>(v20, 0x1::string::utf8(b"main_inactive_value"));
        0x1::vector::push_back<0x1::string::String>(v20, 0x1::string::utf8(b"hedge_inactive_value"));
        0x1::vector::push_back<0x1::string::String>(v20, 0x1::string::utf8(b"exps"));
        0x1::vector::push_back<0x1::string::String>(v20, 0x1::string::utf8(b"points"));
        let v21 = 0x1::string::utf8(b"round");
        let v22 = 0x1::vector::empty<u64>();
        let v23 = &mut v22;
        0x1::vector::push_back<u64>(v23, arg5);
        0x1::vector::push_back<u64>(v23, *0x2::vec_map::get<0x1::string::String, u64>(&v1.info, &v21));
        0x1::vector::push_back<u64>(v23, v12);
        0x1::vector::push_back<u64>(v23, v13);
        0x1::vector::push_back<u64>(v23, v14);
        0x1::vector::push_back<u64>(v23, v15);
        0x1::vector::push_back<u64>(v23, v16);
        0x1::vector::push_back<u64>(v23, v17);
        0x1::vector::push_back<u64>(v23, v9);
        0x1::vector::push_back<u64>(v23, v10);
        0xe7fa4dae529d137d79ad1160950408451dc4c28e76610a999d463a4ef64c5f55::event::emit_user_event(0x1::string::utf8(b"raise_fund"), 0x2::vec_map::from_keys_values<0x1::string::String, u64>(v19, v22), 0x2::vec_map::empty<0x1::string::String, vector<u8>>());
        0x2::dynamic_field::add<0x1::string::String, 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::ManagerCap>(&mut arg4.id, 0x1::string::utf8(b"typus_manager_cap"), v0);
    }

    public fun reduce_fund<T0, T1>(arg0: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg1: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::leaderboard::TypusLeaderboardRegistry, arg2: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::user::TypusUserRegistry, arg3: &mut 0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::Version, arg4: &mut Registry, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: bool, arg11: 0x2::balance::Balance<0x2::sui::SUI>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        version_check(arg3);
        assert!(!arg4.transaction_suspended, 0xe7fa4dae529d137d79ad1160950408451dc4c28e76610a999d463a4ef64c5f55::error::transaction_suspended(arg5));
        let v0 = 0x2::dynamic_field::remove<0x1::string::String, 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::ManagerCap>(&mut arg4.id, 0x1::string::utf8(b"typus_manager_cap"));
        let v1 = 0x2::dynamic_object_field::borrow_mut<u64, Vault>(&mut arg4.id, arg5);
        token_type_check<T0, T1>(v1);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg11) == 0, 0xe7fa4dae529d137d79ad1160950408451dc4c28e76610a999d463a4ef64c5f55::error::invalid_fee_amount(arg5));
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::charge_fee<0x2::sui::SUI>(arg3, arg11);
        let v2 = 0x2::object::id_address<0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::account::Account>(0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::account::borrow_user_account(arg0, arg13));
        let (v3, v4) = update_typus_point(arg0, arg1, arg2, &v0, v1, v2, arg12, arg13);
        let v5 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::borrow_by_key_mut<address, vector<u64>>(&mut v1.user_share, v2);
        let v6 = 0x2::balance::zero<T0>();
        let v7 = 0x2::balance::zero<T1>();
        let v8 = if (*0x1::vector::borrow<u64>(v5, 6) < arg6) {
            *0x1::vector::borrow<u64>(v5, 6)
        } else {
            arg6
        };
        *0x1::vector::borrow_mut<u64>(v5, 6) = *0x1::vector::borrow<u64>(v5, 6) - v8;
        *0x1::vector::borrow_mut<u64>(&mut v1.user_share_supply, 6) = *0x1::vector::borrow<u64>(&v1.user_share_supply, 6) - v8;
        0x2::balance::join<T0>(&mut v6, 0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::balance::Balance<T0>>(&mut v1.id, 0x1::string::utf8(b"main_balance")), v8));
        let v9 = if (*0x1::vector::borrow<u64>(v5, 7) < arg7) {
            *0x1::vector::borrow<u64>(v5, 7)
        } else {
            arg7
        };
        *0x1::vector::borrow_mut<u64>(v5, 7) = *0x1::vector::borrow<u64>(v5, 7) - v9;
        *0x1::vector::borrow_mut<u64>(&mut v1.user_share_supply, 7) = *0x1::vector::borrow<u64>(&v1.user_share_supply, 7) - v9;
        0x2::balance::join<T1>(&mut v7, 0x2::balance::split<T1>(0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::balance::Balance<T1>>(&mut v1.id, 0x1::string::utf8(b"hedge_balance")), v9));
        let v10 = if (*0x1::vector::borrow<u64>(v5, 0) < arg8) {
            *0x1::vector::borrow<u64>(v5, 0)
        } else {
            arg8
        };
        *0x1::vector::borrow_mut<u64>(v5, 0) = *0x1::vector::borrow<u64>(v5, 0) - v10;
        *0x1::vector::borrow_mut<u64>(&mut v1.user_share_supply, 0) = *0x1::vector::borrow<u64>(&v1.user_share_supply, 0) - v10;
        *0x1::vector::borrow_mut<u64>(v5, 2) = *0x1::vector::borrow<u64>(v5, 2) + v10;
        *0x1::vector::borrow_mut<u64>(&mut v1.user_share_supply, 2) = *0x1::vector::borrow<u64>(&v1.user_share_supply, 2) + v10;
        let v11 = if (*0x1::vector::borrow<u64>(v5, 1) < arg9) {
            *0x1::vector::borrow<u64>(v5, 1)
        } else {
            arg9
        };
        *0x1::vector::borrow_mut<u64>(v5, 1) = *0x1::vector::borrow<u64>(v5, 1) - v11;
        *0x1::vector::borrow_mut<u64>(&mut v1.user_share_supply, 1) = *0x1::vector::borrow<u64>(&v1.user_share_supply, 1) - v11;
        *0x1::vector::borrow_mut<u64>(v5, 3) = *0x1::vector::borrow<u64>(v5, 3) + v11;
        *0x1::vector::borrow_mut<u64>(&mut v1.user_share_supply, 3) = *0x1::vector::borrow<u64>(&v1.user_share_supply, 3) + v11;
        let v12 = if (arg10) {
            *0x1::vector::borrow<u64>(v5, 4)
        } else {
            0
        };
        *0x1::vector::borrow_mut<u64>(v5, 4) = *0x1::vector::borrow<u64>(v5, 4) - v12;
        *0x1::vector::borrow_mut<u64>(&mut v1.user_share_supply, 4) = *0x1::vector::borrow<u64>(&v1.user_share_supply, 4) - v12;
        0x2::balance::join<T0>(&mut v6, 0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::balance::Balance<T0>>(&mut v1.id, 0x1::string::utf8(b"main_balance")), v12));
        let v13 = if (arg10) {
            *0x1::vector::borrow<u64>(v5, 5)
        } else {
            0
        };
        *0x1::vector::borrow_mut<u64>(v5, 5) = *0x1::vector::borrow<u64>(v5, 5) - v13;
        *0x1::vector::borrow_mut<u64>(&mut v1.user_share_supply, 5) = *0x1::vector::borrow<u64>(&v1.user_share_supply, 5) - v13;
        0x2::balance::join<T1>(&mut v7, 0x2::balance::split<T1>(0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::balance::Balance<T1>>(&mut v1.id, 0x1::string::utf8(b"hedge_balance")), v13));
        update_snapshot_usd_value(v1, v2);
        assert!(v8 + v10 + v12 > 0, 0xe7fa4dae529d137d79ad1160950408451dc4c28e76610a999d463a4ef64c5f55::error::zero_value(arg5));
        let v14 = 0x1::vector::empty<0x1::string::String>();
        let v15 = &mut v14;
        0x1::vector::push_back<0x1::string::String>(v15, 0x1::string::utf8(b"index"));
        0x1::vector::push_back<0x1::string::String>(v15, 0x1::string::utf8(b"round"));
        0x1::vector::push_back<0x1::string::String>(v15, 0x1::string::utf8(b"main_warmup_value"));
        0x1::vector::push_back<0x1::string::String>(v15, 0x1::string::utf8(b"hedge_warmup_value"));
        0x1::vector::push_back<0x1::string::String>(v15, 0x1::string::utf8(b"main_active_value"));
        0x1::vector::push_back<0x1::string::String>(v15, 0x1::string::utf8(b"hedge_active_value"));
        0x1::vector::push_back<0x1::string::String>(v15, 0x1::string::utf8(b"main_inactive_value"));
        0x1::vector::push_back<0x1::string::String>(v15, 0x1::string::utf8(b"hedge_inactive_value"));
        0x1::vector::push_back<0x1::string::String>(v15, 0x1::string::utf8(b"exps"));
        0x1::vector::push_back<0x1::string::String>(v15, 0x1::string::utf8(b"points"));
        let v16 = 0x1::string::utf8(b"round");
        let v17 = 0x1::vector::empty<u64>();
        let v18 = &mut v17;
        0x1::vector::push_back<u64>(v18, arg5);
        0x1::vector::push_back<u64>(v18, *0x2::vec_map::get<0x1::string::String, u64>(&v1.info, &v16));
        0x1::vector::push_back<u64>(v18, v8);
        0x1::vector::push_back<u64>(v18, v9);
        0x1::vector::push_back<u64>(v18, v10);
        0x1::vector::push_back<u64>(v18, v11);
        0x1::vector::push_back<u64>(v18, v12);
        0x1::vector::push_back<u64>(v18, v13);
        0x1::vector::push_back<u64>(v18, v3);
        0x1::vector::push_back<u64>(v18, v4);
        0xe7fa4dae529d137d79ad1160950408451dc4c28e76610a999d463a4ef64c5f55::event::emit_user_event(0x1::string::utf8(b"reduce_fund"), 0x2::vec_map::from_keys_values<0x1::string::String, u64>(v14, v17), 0x2::vec_map::empty<0x1::string::String, vector<u8>>());
        0x2::dynamic_field::add<0x1::string::String, 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::ManagerCap>(&mut arg4.id, 0x1::string::utf8(b"typus_manager_cap"), v0);
        (v6, v7)
    }

    public fun refresh<T0, T1>(arg0: &0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::Version, arg1: &mut Registry, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        verify(arg0, arg7);
        let v0 = 0x2::dynamic_object_field::borrow_mut<u64, Vault>(&mut arg1.id, arg2);
        let v1 = 0x1::string::utf8(b"refresh_ts_ms");
        assert!(0x2::clock::timestamp_ms(arg6) >= *0x2::vec_map::get<0x1::string::String, u64>(&v0.info, &v1), 0xe7fa4dae529d137d79ad1160950408451dc4c28e76610a999d463a4ef64c5f55::error::not_time_yet(arg2));
        let v2 = 0x1::string::utf8(b"status");
        let v3 = if (*0x2::vec_map::get<0x1::string::String, u64>(&v0.info, &v2) != 999) {
            true
        } else if (*0x1::vector::borrow<u64>(&v0.user_share_supply, 0) != 0) {
            true
        } else if (*0x1::vector::borrow<u64>(&v0.user_share_supply, 2) != 0) {
            true
        } else if (*0x1::vector::borrow<u64>(&v0.user_share_supply, 1) != 0) {
            true
        } else {
            *0x1::vector::borrow<u64>(&v0.user_share_supply, 3) != 0
        };
        assert!(v3, 0xe7fa4dae529d137d79ad1160950408451dc4c28e76610a999d463a4ef64c5f55::error::already_closed(arg2));
        let v4 = 0x1::string::utf8(b"status");
        let v5 = *0x2::vec_map::get<0x1::string::String, u64>(&v0.info, &v4) == 999;
        let v6 = 0x1::string::utf8(b"refresh_ts_ms");
        *0x2::vec_map::get_mut<0x1::string::String, u64>(&mut v0.info, &v6) = arg3;
        let v7 = 0x1::string::utf8(b"round");
        let v8 = 0x1::string::utf8(b"round");
        *0x2::vec_map::get_mut<0x1::string::String, u64>(&mut v0.info, &v8) = *0x2::vec_map::get<0x1::string::String, u64>(&v0.info, &v7) + 1;
        let v9 = 0x1::string::utf8(b"main_token_price_mbp");
        *0x2::vec_map::get_mut<0x1::string::String, u64>(&mut v0.info, &v9) = arg4;
        let v10 = 0x1::string::utf8(b"hedge_token_price_mbp");
        *0x2::vec_map::get_mut<0x1::string::String, u64>(&mut v0.info, &v10) = arg5;
        let v11 = 0x1::string::utf8(b"main_token_ratio");
        let v12 = *0x2::vec_map::get<0x1::string::String, u64>(&v0.config, &v11);
        let v13 = 0x1::string::utf8(b"hedge_token_ratio");
        let v14 = *0x2::vec_map::get<0x1::string::String, u64>(&v0.config, &v13);
        let v15 = 0x2::balance::value<T0>(0x2::dynamic_field::borrow<0x1::string::String, 0x2::balance::Balance<T0>>(&v0.id, 0x1::string::utf8(b"main_balance"))) - *0x1::vector::borrow<u64>(&v0.user_share_supply, 4) - *0x1::vector::borrow<u64>(&v0.user_share_supply, 6);
        let v16 = 0x2::balance::value<T1>(0x2::dynamic_field::borrow<0x1::string::String, 0x2::balance::Balance<T1>>(&v0.id, 0x1::string::utf8(b"hedge_balance"))) - *0x1::vector::borrow<u64>(&v0.user_share_supply, 5) - *0x1::vector::borrow<u64>(&v0.user_share_supply, 7);
        let v17 = *0x1::vector::borrow<u64>(&v0.user_share_supply, 0) + *0x1::vector::borrow<u64>(&v0.user_share_supply, 2);
        let v18 = *0x1::vector::borrow<u64>(&v0.user_share_supply, 1) + *0x1::vector::borrow<u64>(&v0.user_share_supply, 3);
        let v19 = 0;
        let v20 = 0;
        let v21 = *0x1::vector::borrow<u64>(&v0.user_share_supply, 4);
        let v22 = *0x1::vector::borrow<u64>(&v0.user_share_supply, 5);
        let v23 = *0x1::vector::borrow<u64>(&v0.user_share_supply, 6);
        let v24 = *0x1::vector::borrow<u64>(&v0.user_share_supply, 7);
        let v25 = &mut v0.user_share;
        let v26 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::length(v25);
        if (v26 > 0) {
            let v27 = (0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::slice_size(v25) as u64);
            let v28 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::borrow_slice_mut<address, vector<u64>>(v25, 0);
            let v29 = 0;
            while (v29 < v26) {
                let (_, v31) = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::borrow_from_slice_mut<address, vector<u64>>(v28, v29 % v27);
                if (*0x1::vector::borrow<u64>(v31, 0) > 0) {
                    let v32 = (((v15 as u128) * (*0x1::vector::borrow<u64>(v31, 0) as u128) / (v17 as u128)) as u64);
                    v15 = v15 - v32;
                    v17 = v17 - *0x1::vector::borrow<u64>(v31, 0);
                    *0x1::vector::borrow_mut<u64>(v31, 0) = v32;
                    v19 = v19 + v32;
                };
                if (*0x1::vector::borrow<u64>(v31, 2) > 0) {
                    let v33 = (((v15 as u128) * (*0x1::vector::borrow<u64>(v31, 2) as u128) / (v17 as u128)) as u64);
                    v15 = v15 - v33;
                    v17 = v17 - *0x1::vector::borrow<u64>(v31, 2);
                    *0x1::vector::borrow_mut<u64>(v31, 2) = v33;
                };
                if (*0x1::vector::borrow<u64>(v31, 1) > 0) {
                    let v34 = (((v16 as u128) * (*0x1::vector::borrow<u64>(v31, 1) as u128) / (v18 as u128)) as u64);
                    v16 = v16 - v34;
                    v18 = v18 - *0x1::vector::borrow<u64>(v31, 1);
                    *0x1::vector::borrow_mut<u64>(v31, 1) = v34;
                    v20 = v20 + v34;
                };
                if (*0x1::vector::borrow<u64>(v31, 3) > 0) {
                    let v35 = (((v16 as u128) * (*0x1::vector::borrow<u64>(v31, 3) as u128) / (v18 as u128)) as u64);
                    v16 = v16 - v35;
                    v18 = v18 - *0x1::vector::borrow<u64>(v31, 3);
                    *0x1::vector::borrow_mut<u64>(v31, 3) = v35;
                };
                let v36 = *0x1::vector::borrow<u64>(v31, 2);
                *0x1::vector::borrow_mut<u64>(v31, 4) = *0x1::vector::borrow<u64>(v31, 4) + v36;
                *0x1::vector::borrow_mut<u64>(v31, 2) = 0;
                let v37 = v21 + v36;
                v21 = v37;
                let v38 = *0x1::vector::borrow<u64>(v31, 3);
                *0x1::vector::borrow_mut<u64>(v31, 5) = *0x1::vector::borrow<u64>(v31, 5) + v38;
                *0x1::vector::borrow_mut<u64>(v31, 3) = 0;
                let v39 = v22 + v38;
                v22 = v39;
                if (v5) {
                    let v40 = *0x1::vector::borrow<u64>(v31, 0);
                    *0x1::vector::borrow_mut<u64>(v31, 4) = *0x1::vector::borrow<u64>(v31, 4) + v40;
                    *0x1::vector::borrow_mut<u64>(v31, 0) = 0;
                    v21 = v37 + v40;
                    let v41 = *0x1::vector::borrow<u64>(v31, 1);
                    *0x1::vector::borrow_mut<u64>(v31, 5) = *0x1::vector::borrow<u64>(v31, 5) + v41;
                    *0x1::vector::borrow_mut<u64>(v31, 1) = 0;
                    v22 = v39 + v41;
                } else {
                    let v42 = *0x1::vector::borrow<u64>(v31, 6);
                    *0x1::vector::borrow_mut<u64>(v31, 0) = *0x1::vector::borrow<u64>(v31, 0) + v42;
                    *0x1::vector::borrow_mut<u64>(v31, 6) = 0;
                    let v43 = v19 + v42;
                    v19 = v43;
                    let v44 = v23 - v42;
                    v23 = v44;
                    let v45 = *0x1::vector::borrow<u64>(v31, 7);
                    *0x1::vector::borrow_mut<u64>(v31, 1) = *0x1::vector::borrow<u64>(v31, 1) + v45;
                    *0x1::vector::borrow_mut<u64>(v31, 7) = 0;
                    let v46 = v20 + v45;
                    v20 = v46;
                    let v47 = v24 - v45;
                    v24 = v47;
                    let v48 = calculate_hedge_token_balance(*0x1::vector::borrow<u64>(v31, 0), v12, v14);
                    if (*0x1::vector::borrow<u64>(v31, 1) != v48) {
                        if (*0x1::vector::borrow<u64>(v31, 1) > v48) {
                            let v49 = *0x1::vector::borrow<u64>(v31, 1) - v48;
                            *0x1::vector::borrow_mut<u64>(v31, 1) = *0x1::vector::borrow<u64>(v31, 1) - v49;
                            *0x1::vector::borrow_mut<u64>(v31, 7) = v49;
                            v20 = v46 - v49;
                            v24 = v47 + v49;
                        } else {
                            let v50 = *0x1::vector::borrow<u64>(v31, 0) - calculate_main_token_balance(*0x1::vector::borrow<u64>(v31, 1), v12, v14);
                            *0x1::vector::borrow_mut<u64>(v31, 0) = *0x1::vector::borrow<u64>(v31, 0) - v50;
                            *0x1::vector::borrow_mut<u64>(v31, 6) = v50;
                            v19 = v43 - v50;
                            v23 = v44 + v50;
                        };
                    };
                };
                if (v29 + 1 < v26 && (v29 + 1) % v27 == 0) {
                    v28 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::borrow_slice_mut<address, vector<u64>>(v25, (((v29 + 1) / v27) as u16));
                };
                v29 = v29 + 1;
            };
        };
        if (v5) {
            *0x1::vector::borrow_mut<u64>(&mut v0.user_share_supply, 0) = 0;
            *0x1::vector::borrow_mut<u64>(&mut v0.user_share_supply, 1) = 0;
        } else {
            *0x1::vector::borrow_mut<u64>(&mut v0.user_share_supply, 0) = v19;
            *0x1::vector::borrow_mut<u64>(&mut v0.user_share_supply, 1) = v20;
        };
        *0x1::vector::borrow_mut<u64>(&mut v0.user_share_supply, 2) = 0;
        *0x1::vector::borrow_mut<u64>(&mut v0.user_share_supply, 3) = 0;
        *0x1::vector::borrow_mut<u64>(&mut v0.user_share_supply, 4) = v21;
        *0x1::vector::borrow_mut<u64>(&mut v0.user_share_supply, 5) = v22;
        *0x1::vector::borrow_mut<u64>(&mut v0.user_share_supply, 6) = v23;
        *0x1::vector::borrow_mut<u64>(&mut v0.user_share_supply, 7) = v24;
        let v51 = 0x1::vector::empty<0x1::string::String>();
        let v52 = &mut v51;
        0x1::vector::push_back<0x1::string::String>(v52, 0x1::string::utf8(b"index"));
        0x1::vector::push_back<0x1::string::String>(v52, 0x1::string::utf8(b"round"));
        0x1::vector::push_back<0x1::string::String>(v52, 0x1::string::utf8(b"refresh_ts_ms"));
        0x1::vector::push_back<0x1::string::String>(v52, 0x1::string::utf8(b"main_token_price_mbp"));
        0x1::vector::push_back<0x1::string::String>(v52, 0x1::string::utf8(b"hedge_token_price_mbp"));
        0x1::vector::push_back<0x1::string::String>(v52, 0x1::string::utf8(b"main_token_share_supply_active"));
        0x1::vector::push_back<0x1::string::String>(v52, 0x1::string::utf8(b"main_token_share_supply_deactivating"));
        0x1::vector::push_back<0x1::string::String>(v52, 0x1::string::utf8(b"main_token_share_supply_inactive"));
        0x1::vector::push_back<0x1::string::String>(v52, 0x1::string::utf8(b"main_token_share_supply_warmup"));
        0x1::vector::push_back<0x1::string::String>(v52, 0x1::string::utf8(b"hedge_token_share_supply_active"));
        0x1::vector::push_back<0x1::string::String>(v52, 0x1::string::utf8(b"hedge_token_share_supply_deactivating"));
        0x1::vector::push_back<0x1::string::String>(v52, 0x1::string::utf8(b"hedge_token_share_supply_inactive"));
        0x1::vector::push_back<0x1::string::String>(v52, 0x1::string::utf8(b"hedge_token_share_supply_warmup"));
        let v53 = 0x1::string::utf8(b"round");
        let v54 = 0x1::vector::empty<u64>();
        let v55 = &mut v54;
        0x1::vector::push_back<u64>(v55, arg2);
        0x1::vector::push_back<u64>(v55, *0x2::vec_map::get<0x1::string::String, u64>(&v0.info, &v53));
        0x1::vector::push_back<u64>(v55, arg3);
        0x1::vector::push_back<u64>(v55, arg4);
        0x1::vector::push_back<u64>(v55, arg5);
        0x1::vector::push_back<u64>(v55, *0x1::vector::borrow<u64>(&v0.user_share_supply, 0));
        0x1::vector::push_back<u64>(v55, *0x1::vector::borrow<u64>(&v0.user_share_supply, 2));
        0x1::vector::push_back<u64>(v55, *0x1::vector::borrow<u64>(&v0.user_share_supply, 4));
        0x1::vector::push_back<u64>(v55, *0x1::vector::borrow<u64>(&v0.user_share_supply, 6));
        0x1::vector::push_back<u64>(v55, *0x1::vector::borrow<u64>(&v0.user_share_supply, 1));
        0x1::vector::push_back<u64>(v55, *0x1::vector::borrow<u64>(&v0.user_share_supply, 3));
        0x1::vector::push_back<u64>(v55, *0x1::vector::borrow<u64>(&v0.user_share_supply, 5));
        0x1::vector::push_back<u64>(v55, *0x1::vector::borrow<u64>(&v0.user_share_supply, 7));
        0xe7fa4dae529d137d79ad1160950408451dc4c28e76610a999d463a4ef64c5f55::event::emit_manager_event(0x1::string::utf8(b"refresh"), 0x2::vec_map::from_keys_values<0x1::string::String, u64>(v51, v54), 0x2::vec_map::empty<0x1::string::String, vector<u8>>());
    }

    public(friend) fun registry_uid(arg0: &Registry) : &0x2::object::UID {
        &arg0.id
    }

    public fun remove_reward_token<T0>(arg0: &0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::Version, arg1: &mut Registry, arg2: u64, arg3: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        verify(arg0, arg3);
        let v0 = 0x2::dynamic_object_field::borrow_mut<u64, Vault>(&mut arg1.id, arg2);
        let v1 = 0x1::type_name::get<T0>();
        let (v2, v3) = 0x1::vector::index_of<0x1::type_name::TypeName>(&v0.reward_tokens, &v1);
        assert!(v2, 0xe7fa4dae529d137d79ad1160950408451dc4c28e76610a999d463a4ef64c5f55::error::invalid_token(arg2));
        0x1::vector::swap_remove<0x1::type_name::TypeName>(&mut v0.reward_tokens, v3);
        0x1::vector::swap_remove<u64>(&mut v0.reward_token_share_supply, v3);
        let v4 = &mut v0.reward_token_share;
        let v5 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::length(v4);
        if (v5 > 0) {
            let v6 = (0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::slice_size(v4) as u64);
            let v7 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::borrow_slice_mut<0x1::string::String, vector<u64>>(v4, 0);
            let v8 = 0;
            while (v8 < v5) {
                let (_, v10) = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::borrow_from_slice_mut<0x1::string::String, vector<u64>>(v7, v8 % v6);
                0x1::vector::swap_remove<u64>(v10, v3);
                if (v8 + 1 < v5 && (v8 + 1) % v6 == 0) {
                    v7 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::borrow_slice_mut<0x1::string::String, vector<u64>>(v4, (((v8 + 1) / v6) as u16));
                };
                v8 = v8 + 1;
            };
        };
        let v11 = 0x1::vector::empty<0x1::string::String>();
        let v12 = &mut v11;
        0x1::vector::push_back<0x1::string::String>(v12, 0x1::string::utf8(b"index"));
        0x1::vector::push_back<0x1::string::String>(v12, 0x1::string::utf8(b"round"));
        let v13 = 0x1::string::utf8(b"round");
        let v14 = 0x1::vector::empty<u64>();
        let v15 = &mut v14;
        0x1::vector::push_back<u64>(v15, arg2);
        0x1::vector::push_back<u64>(v15, *0x2::vec_map::get<0x1::string::String, u64>(&v0.info, &v13));
        let v16 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v16, 0x1::string::utf8(b"token"));
        let v17 = 0x1::type_name::get<T0>();
        let v18 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v18, 0x1::bcs::to_bytes<0x1::type_name::TypeName>(&v17));
        0xe7fa4dae529d137d79ad1160950408451dc4c28e76610a999d463a4ef64c5f55::event::emit_manager_event(0x1::string::utf8(b"remove_reward_token"), 0x2::vec_map::from_keys_values<0x1::string::String, u64>(v11, v14), 0x2::vec_map::from_keys_values<0x1::string::String, vector<u8>>(v16, v18));
        0x2::dynamic_field::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v0.id, 0x1::type_name::get<T0>())
    }

    entry fun resume_transaction(arg0: &0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::Version, arg1: &mut Registry, arg2: &0x2::tx_context::TxContext) {
        verify(arg0, arg2);
        arg1.transaction_suspended = false;
        0xe7fa4dae529d137d79ad1160950408451dc4c28e76610a999d463a4ef64c5f55::event::emit_manager_event(0x1::string::utf8(b"resume_transaction"), 0x2::vec_map::empty<0x1::string::String, u64>(), 0x2::vec_map::empty<0x1::string::String, vector<u8>>());
    }

    entry fun set_reward_token<T0>(arg0: &0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::Version, arg1: &mut Registry, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        verify(arg0, arg3);
        let v0 = 0x2::dynamic_object_field::borrow_mut<u64, Vault>(&mut arg1.id, arg2);
        let v1 = 0x1::type_name::get<T0>();
        let (v2, _) = 0x1::vector::index_of<0x1::type_name::TypeName>(&v0.reward_tokens, &v1);
        assert!(!v2, 0xe7fa4dae529d137d79ad1160950408451dc4c28e76610a999d463a4ef64c5f55::error::invalid_token(arg2));
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut v0.reward_tokens, 0x1::type_name::get<T0>());
        0x1::vector::push_back<u64>(&mut v0.reward_token_share_supply, 0);
        let v4 = &mut v0.reward_token_share;
        let v5 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::length(v4);
        if (v5 > 0) {
            let v6 = (0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::slice_size(v4) as u64);
            let v7 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::borrow_slice_mut<0x1::string::String, vector<u64>>(v4, 0);
            let v8 = 0;
            while (v8 < v5) {
                let (_, v10) = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::borrow_from_slice_mut<0x1::string::String, vector<u64>>(v7, v8 % v6);
                0x1::vector::push_back<u64>(v10, 0);
                if (v8 + 1 < v5 && (v8 + 1) % v6 == 0) {
                    v7 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::borrow_slice_mut<0x1::string::String, vector<u64>>(v4, (((v8 + 1) / v6) as u16));
                };
                v8 = v8 + 1;
            };
        };
        0x2::dynamic_field::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v0.id, 0x1::type_name::get<T0>(), 0x2::balance::zero<T0>());
        let v11 = 0x1::vector::empty<0x1::string::String>();
        let v12 = &mut v11;
        0x1::vector::push_back<0x1::string::String>(v12, 0x1::string::utf8(b"index"));
        0x1::vector::push_back<0x1::string::String>(v12, 0x1::string::utf8(b"round"));
        let v13 = 0x1::string::utf8(b"round");
        let v14 = 0x1::vector::empty<u64>();
        let v15 = &mut v14;
        0x1::vector::push_back<u64>(v15, arg2);
        0x1::vector::push_back<u64>(v15, *0x2::vec_map::get<0x1::string::String, u64>(&v0.info, &v13));
        let v16 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v16, 0x1::string::utf8(b"token"));
        let v17 = 0x1::type_name::get<T0>();
        let v18 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v18, 0x1::bcs::to_bytes<0x1::type_name::TypeName>(&v17));
        0xe7fa4dae529d137d79ad1160950408451dc4c28e76610a999d463a4ef64c5f55::event::emit_manager_event(0x1::string::utf8(b"set_reward_token"), 0x2::vec_map::from_keys_values<0x1::string::String, u64>(v11, v14), 0x2::vec_map::from_keys_values<0x1::string::String, vector<u8>>(v16, v18));
    }

    public fun snapshot(arg0: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg1: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::leaderboard::TypusLeaderboardRegistry, arg2: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::user::TypusUserRegistry, arg3: &mut 0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::Version, arg4: &mut Registry, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        version_check(arg3);
        assert!(!arg4.transaction_suspended, 0xe7fa4dae529d137d79ad1160950408451dc4c28e76610a999d463a4ef64c5f55::error::transaction_suspended(arg5));
        let v0 = 0x2::dynamic_field::remove<0x1::string::String, 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::ManagerCap>(&mut arg4.id, 0x1::string::utf8(b"typus_manager_cap"));
        let v1 = 0x2::object::id_address<0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::account::Account>(0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::account::borrow_user_account(arg0, arg7));
        let v2 = 0x2::dynamic_object_field::borrow_mut<u64, Vault>(&mut arg4.id, arg5);
        let (v3, v4) = update_typus_point(arg0, arg1, arg2, &v0, v2, v1, arg6, arg7);
        update_snapshot_usd_value(v2, v1);
        let v5 = 0x1::vector::empty<0x1::string::String>();
        let v6 = &mut v5;
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"index"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"round"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"exps"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"points"));
        let v7 = 0x1::string::utf8(b"round");
        let v8 = 0x1::vector::empty<u64>();
        let v9 = &mut v8;
        0x1::vector::push_back<u64>(v9, arg5);
        0x1::vector::push_back<u64>(v9, *0x2::vec_map::get<0x1::string::String, u64>(&v2.info, &v7));
        0x1::vector::push_back<u64>(v9, v3);
        0x1::vector::push_back<u64>(v9, v4);
        0xe7fa4dae529d137d79ad1160950408451dc4c28e76610a999d463a4ef64c5f55::event::emit_user_event(0x1::string::utf8(b"snapshot"), 0x2::vec_map::from_keys_values<0x1::string::String, u64>(v5, v8), 0x2::vec_map::empty<0x1::string::String, vector<u8>>());
        0x2::dynamic_field::add<0x1::string::String, 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::ManagerCap>(&mut arg4.id, 0x1::string::utf8(b"typus_manager_cap"), v0);
    }

    entry fun suspend_transaction(arg0: &0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::Version, arg1: &mut Registry, arg2: &0x2::tx_context::TxContext) {
        verify(arg0, arg2);
        arg1.transaction_suspended = true;
        0xe7fa4dae529d137d79ad1160950408451dc4c28e76610a999d463a4ef64c5f55::event::emit_manager_event(0x1::string::utf8(b"suspend_transaction"), 0x2::vec_map::empty<0x1::string::String, u64>(), 0x2::vec_map::empty<0x1::string::String, vector<u8>>());
    }

    fun token_type_check<T0, T1>(arg0: &Vault) {
        if (0x1::type_name::get<T0>() == arg0.main_token && 0x1::type_name::get<T1>() == arg0.hedge_token) {
            return
        } else {
            let v0 = 0x1::string::utf8(b"index");
            abort 0xe7fa4dae529d137d79ad1160950408451dc4c28e76610a999d463a4ef64c5f55::error::invalid_token(*0x2::vec_map::get<0x1::string::String, u64>(&arg0.info, &v0))
        };
    }

    entry fun update_hedge_ratio(arg0: &0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::Version, arg1: &mut Registry, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        verify(arg0, arg5);
        let v0 = 0x2::vec_map::empty<0x1::string::String, u64>();
        let v1 = 0x2::dynamic_object_field::borrow_mut<u64, Vault>(&mut arg1.id, arg2);
        let v2 = 0x1::string::utf8(b"main_token_ratio");
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v0, 0x1::string::utf8(b"previous_main_token_ratio"), *0x2::vec_map::get<0x1::string::String, u64>(&v1.config, &v2));
        let v3 = 0x1::string::utf8(b"hedge_token_ratio");
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v0, 0x1::string::utf8(b"previous_hedge_token_ratio"), *0x2::vec_map::get<0x1::string::String, u64>(&v1.config, &v3));
        let v4 = 0x1::string::utf8(b"main_token_ratio");
        *0x2::vec_map::get_mut<0x1::string::String, u64>(&mut v1.config, &v4) = arg3;
        let v5 = 0x1::string::utf8(b"hedge_token_ratio");
        *0x2::vec_map::get_mut<0x1::string::String, u64>(&mut v1.config, &v5) = arg4;
        let v6 = 0x1::string::utf8(b"main_token_ratio");
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v0, 0x1::string::utf8(b"current_main_token_ratio"), *0x2::vec_map::get<0x1::string::String, u64>(&v1.config, &v6));
        let v7 = 0x1::string::utf8(b"hedge_token_ratio");
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v0, 0x1::string::utf8(b"current_hedge_token_ratio"), *0x2::vec_map::get<0x1::string::String, u64>(&v1.config, &v7));
        0xe7fa4dae529d137d79ad1160950408451dc4c28e76610a999d463a4ef64c5f55::event::emit_manager_event(0x1::string::utf8(b"update_hedge_ratio"), v0, 0x2::vec_map::empty<0x1::string::String, vector<u8>>());
    }

    fun update_snapshot_usd_value(arg0: &mut Vault, arg1: address) {
        let v0 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::borrow_by_key_mut<address, vector<u64>>(&mut arg0.user_share, arg1);
        let v1 = 0x1::string::utf8(b"main_token_price_mbp");
        let v2 = 0x1::string::utf8(b"main_token_decimal");
        let v3 = 0x1::string::utf8(b"hedge_token_price_mbp");
        let v4 = 0x1::string::utf8(b"hedge_token_decimal");
        *0x1::vector::borrow_mut<u64>(v0, 8) = ((((*0x1::vector::borrow<u64>(v0, 0) + *0x1::vector::borrow<u64>(v0, 6)) as u128) * (*0x2::vec_map::get<0x1::string::String, u64>(&arg0.info, &v1) as u128) / (10000000 as u128) / (0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::utility::multiplier(*0x2::vec_map::get<0x1::string::String, u64>(&arg0.info, &v2)) as u128)) as u64) + ((((*0x1::vector::borrow<u64>(v0, 1) + *0x1::vector::borrow<u64>(v0, 7)) as u128) * (*0x2::vec_map::get<0x1::string::String, u64>(&arg0.info, &v3) as u128) / (10000000 as u128) / (0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::utility::multiplier(*0x2::vec_map::get<0x1::string::String, u64>(&arg0.info, &v4)) as u128)) as u64);
    }

    fun update_typus_point(arg0: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg1: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::leaderboard::TypusLeaderboardRegistry, arg2: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::user::TypusUserRegistry, arg3: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::ManagerCap, arg4: &mut Vault, arg5: address, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let v0 = 0x2::clock::timestamp_ms(arg6);
        let v1 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::keyed_big_vector::borrow_by_key_mut<address, vector<u64>>(&mut arg4.user_share, arg5);
        let v2 = *0x1::vector::borrow<u64>(v1, 8);
        let v3 = 0x1::string::utf8(b"exp_per_hour_bp");
        let v4 = (((v2 as u256) * ((v0 - *0x1::vector::borrow<u64>(v1, 9)) as u256) * (*0x2::vec_map::get<0x1::string::String, u64>(&arg4.config, &v3) as u256) / 3600000 / (10000 as u256)) as u64);
        let v5 = 0x1::string::utf8(b"point_per_hour_bp");
        let v6 = (((v2 as u256) * ((v0 - *0x1::vector::borrow<u64>(v1, 9)) as u256) * (*0x2::vec_map::get<0x1::string::String, u64>(&arg4.config, &v5) as u256) / 3600000 / (10000 as u256)) as u64);
        *0x1::vector::borrow_mut<u64>(v1, 9) = v0;
        0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::user::add_tails_exp_amount(arg3, arg0, arg2, 0x2::tx_context::sender(arg7), v4);
        0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::leaderboard::score(arg3, arg0, arg1, 0x1::ascii::string(b""), 0x2::tx_context::sender(arg7), v6, arg6, arg7);
        (v4, v6)
    }

    entry fun update_vault_config(arg0: &0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::Version, arg1: &mut Registry, arg2: u64, arg3: 0x1::string::String, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        verify(arg0, arg5);
        let v0 = 0x2::vec_map::empty<0x1::string::String, u64>();
        let v1 = 0x2::dynamic_object_field::borrow_mut<u64, Vault>(&mut arg1.id, arg2);
        if (!0x2::vec_map::contains<0x1::string::String, u64>(&v1.config, &arg3)) {
            0x2::vec_map::insert<0x1::string::String, u64>(&mut v1.config, arg3, 0);
        };
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v0, arg3, 0);
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v0, 0x1::string::utf8(b"previous"), *0x2::vec_map::get<0x1::string::String, u64>(&v1.config, &arg3));
        *0x2::vec_map::get_mut<0x1::string::String, u64>(&mut v1.config, &arg3) = arg4;
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v0, 0x1::string::utf8(b"current"), *0x2::vec_map::get<0x1::string::String, u64>(&v1.config, &arg3));
        0xe7fa4dae529d137d79ad1160950408451dc4c28e76610a999d463a4ef64c5f55::event::emit_manager_event(0x1::string::utf8(b"update_vault_config"), v0, 0x2::vec_map::empty<0x1::string::String, vector<u8>>());
    }

    entry fun update_vault_info(arg0: &0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::Version, arg1: &mut Registry, arg2: u64, arg3: 0x1::string::String, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        verify(arg0, arg5);
        let v0 = 0x2::vec_map::empty<0x1::string::String, u64>();
        let v1 = 0x2::dynamic_object_field::borrow_mut<u64, Vault>(&mut arg1.id, arg2);
        if (!0x2::vec_map::contains<0x1::string::String, u64>(&v1.info, &arg3)) {
            0x2::vec_map::insert<0x1::string::String, u64>(&mut v1.info, arg3, 0);
        };
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v0, arg3, 0);
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v0, 0x1::string::utf8(b"previous"), *0x2::vec_map::get<0x1::string::String, u64>(&v1.info, &arg3));
        *0x2::vec_map::get_mut<0x1::string::String, u64>(&mut v1.info, &arg3) = arg4;
        0x2::vec_map::insert<0x1::string::String, u64>(&mut v0, 0x1::string::utf8(b"current"), *0x2::vec_map::get<0x1::string::String, u64>(&v1.info, &arg3));
        0xe7fa4dae529d137d79ad1160950408451dc4c28e76610a999d463a4ef64c5f55::event::emit_manager_event(0x1::string::utf8(b"update_vault_info"), v0, 0x2::vec_map::empty<0x1::string::String, vector<u8>>());
    }

    fun verify(arg0: &0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::Version, arg1: &0x2::tx_context::TxContext) {
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_authority(arg0, arg1);
        let v0 = VERSION{dummy_field: false};
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_witness<VERSION>(arg0, v0);
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_version(arg0, 1);
    }

    fun version_check(arg0: &0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::Version) {
        let v0 = VERSION{dummy_field: false};
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_witness<VERSION>(arg0, v0);
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_version(arg0, 1);
    }

    public fun withdraw_hedge_token<T0: drop, T1>(arg0: T0, arg1: &0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::Version, arg2: &mut Registry, arg3: u64, arg4: 0x1::option::Option<u64>, arg5: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, vector<u64>) {
        verify(arg1, arg5);
        let v0 = 0x1::vector::empty<vector<u8>>();
        let v1 = &mut v0;
        0x1::vector::push_back<vector<u8>>(v1, b"");
        0x1::vector::push_back<vector<u8>>(v1, b"");
        let v2 = 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        assert!(0x1::vector::contains<vector<u8>>(&v0, &v2), 0xe7fa4dae529d137d79ad1160950408451dc4c28e76610a999d463a4ef64c5f55::error::invalid_witness(arg3));
        let v3 = 0x2::dynamic_object_field::borrow_mut<u64, Vault>(&mut arg2.id, arg3);
        let v4 = 0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::balance::Balance<T1>>(&mut v3.id, 0x1::string::utf8(b"hedge_balance"));
        let v5 = if (0x1::option::is_some<u64>(&arg4)) {
            0x1::option::destroy_some<u64>(arg4)
        } else {
            0x2::balance::value<T1>(v4) - *0x1::vector::borrow<u64>(&v3.user_share_supply, 5) - *0x1::vector::borrow<u64>(&v3.user_share_supply, 7)
        };
        assert!(0x2::balance::value<T1>(v4) >= *0x1::vector::borrow<u64>(&v3.user_share_supply, 5) + *0x1::vector::borrow<u64>(&v3.user_share_supply, 7) + v5, 0xe7fa4dae529d137d79ad1160950408451dc4c28e76610a999d463a4ef64c5f55::error::invalid_amount(arg3));
        let v6 = 0x1::vector::empty<0x1::string::String>();
        let v7 = &mut v6;
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"index"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"round"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"amount"));
        let v8 = 0x1::string::utf8(b"round");
        let v9 = 0x1::vector::empty<u64>();
        let v10 = &mut v9;
        0x1::vector::push_back<u64>(v10, arg3);
        0x1::vector::push_back<u64>(v10, *0x2::vec_map::get<0x1::string::String, u64>(&v3.info, &v8));
        0x1::vector::push_back<u64>(v10, v5);
        let v11 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v11, 0x1::string::utf8(b"token"));
        let v12 = 0x1::type_name::get<T1>();
        let v13 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v13, 0x1::bcs::to_bytes<0x1::type_name::TypeName>(&v12));
        0xe7fa4dae529d137d79ad1160950408451dc4c28e76610a999d463a4ef64c5f55::event::emit_manager_event(0x1::string::utf8(b"withdraw_hedge_token"), 0x2::vec_map::from_keys_values<0x1::string::String, u64>(v6, v9), 0x2::vec_map::from_keys_values<0x1::string::String, vector<u8>>(v11, v13));
        let v14 = 0x1::string::utf8(b"round");
        let v15 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v15, *0x2::vec_map::get<0x1::string::String, u64>(&v3.info, &v14));
        (0x2::balance::split<T1>(v4, v5), v15)
    }

    public fun withdraw_main_token<T0: drop, T1>(arg0: T0, arg1: &0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::Version, arg2: &mut Registry, arg3: u64, arg4: 0x1::option::Option<u64>, arg5: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, vector<u64>) {
        verify(arg1, arg5);
        let v0 = 0x1::vector::empty<vector<u8>>();
        let v1 = &mut v0;
        0x1::vector::push_back<vector<u8>>(v1, b"");
        0x1::vector::push_back<vector<u8>>(v1, b"");
        let v2 = 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        assert!(0x1::vector::contains<vector<u8>>(&v0, &v2), 0xe7fa4dae529d137d79ad1160950408451dc4c28e76610a999d463a4ef64c5f55::error::invalid_witness(arg3));
        let v3 = 0x2::dynamic_object_field::borrow_mut<u64, Vault>(&mut arg2.id, arg3);
        let v4 = 0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::balance::Balance<T1>>(&mut v3.id, 0x1::string::utf8(b"main_balance"));
        let v5 = if (0x1::option::is_some<u64>(&arg4)) {
            0x1::option::destroy_some<u64>(arg4)
        } else {
            0x2::balance::value<T1>(v4) - *0x1::vector::borrow<u64>(&v3.user_share_supply, 5) - *0x1::vector::borrow<u64>(&v3.user_share_supply, 7)
        };
        assert!(0x2::balance::value<T1>(v4) >= *0x1::vector::borrow<u64>(&v3.user_share_supply, 5) + *0x1::vector::borrow<u64>(&v3.user_share_supply, 7) + v5, 0xe7fa4dae529d137d79ad1160950408451dc4c28e76610a999d463a4ef64c5f55::error::invalid_amount(arg3));
        let v6 = 0x1::vector::empty<0x1::string::String>();
        let v7 = &mut v6;
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"index"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"round"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"amount"));
        let v8 = 0x1::string::utf8(b"round");
        let v9 = 0x1::vector::empty<u64>();
        let v10 = &mut v9;
        0x1::vector::push_back<u64>(v10, arg3);
        0x1::vector::push_back<u64>(v10, *0x2::vec_map::get<0x1::string::String, u64>(&v3.info, &v8));
        0x1::vector::push_back<u64>(v10, v5);
        let v11 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v11, 0x1::string::utf8(b"token"));
        let v12 = 0x1::type_name::get<T1>();
        let v13 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v13, 0x1::bcs::to_bytes<0x1::type_name::TypeName>(&v12));
        0xe7fa4dae529d137d79ad1160950408451dc4c28e76610a999d463a4ef64c5f55::event::emit_manager_event(0x1::string::utf8(b"withdraw_main_token"), 0x2::vec_map::from_keys_values<0x1::string::String, u64>(v6, v9), 0x2::vec_map::from_keys_values<0x1::string::String, vector<u8>>(v11, v13));
        let v14 = 0x1::string::utf8(b"round");
        let v15 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v15, *0x2::vec_map::get<0x1::string::String, u64>(&v3.info, &v14));
        (0x2::balance::split<T1>(v4, v5), v15)
    }

    public fun withdraw_other_token<T0: drop, T1>(arg0: T0, arg1: &0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::Version, arg2: &mut Registry, arg3: u64, arg4: 0x1::option::Option<u64>, arg5: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, vector<u64>) {
        verify(arg1, arg5);
        let v0 = 0x1::vector::empty<vector<u8>>();
        let v1 = &mut v0;
        0x1::vector::push_back<vector<u8>>(v1, b"");
        0x1::vector::push_back<vector<u8>>(v1, b"");
        let v2 = 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        assert!(0x1::vector::contains<vector<u8>>(&v0, &v2), 0xe7fa4dae529d137d79ad1160950408451dc4c28e76610a999d463a4ef64c5f55::error::invalid_witness(arg3));
        let v3 = 0x2::dynamic_object_field::borrow_mut<u64, Vault>(&mut arg2.id, arg3);
        let v4 = 0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut v3.id, 0x1::type_name::get<T1>());
        let v5 = if (0x1::option::is_some<u64>(&arg4)) {
            0x1::option::destroy_some<u64>(arg4)
        } else {
            0x2::balance::value<T1>(v4)
        };
        assert!(0x2::balance::value<T1>(v4) >= v5, 0xe7fa4dae529d137d79ad1160950408451dc4c28e76610a999d463a4ef64c5f55::error::invalid_amount(arg3));
        let v6 = 0x1::vector::empty<0x1::string::String>();
        let v7 = &mut v6;
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"index"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"round"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"amount"));
        let v8 = 0x1::string::utf8(b"round");
        let v9 = 0x1::vector::empty<u64>();
        let v10 = &mut v9;
        0x1::vector::push_back<u64>(v10, arg3);
        0x1::vector::push_back<u64>(v10, *0x2::vec_map::get<0x1::string::String, u64>(&v3.info, &v8));
        0x1::vector::push_back<u64>(v10, v5);
        let v11 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v11, 0x1::string::utf8(b"token"));
        let v12 = 0x1::type_name::get<T1>();
        let v13 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v13, 0x1::bcs::to_bytes<0x1::type_name::TypeName>(&v12));
        0xe7fa4dae529d137d79ad1160950408451dc4c28e76610a999d463a4ef64c5f55::event::emit_manager_event(0x1::string::utf8(b"withdraw_other_token"), 0x2::vec_map::from_keys_values<0x1::string::String, u64>(v6, v9), 0x2::vec_map::from_keys_values<0x1::string::String, vector<u8>>(v11, v13));
        let v14 = 0x1::string::utf8(b"round");
        let v15 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v15, *0x2::vec_map::get<0x1::string::String, u64>(&v3.info, &v14));
        (0x2::balance::split<T1>(v4, v5), v15)
    }

    // decompiled from Move bytecode v6
}

