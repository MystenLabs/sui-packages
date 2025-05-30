module 0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::safu {
    struct Registry has key {
        id: 0x2::object::UID,
        num_of_vault: u64,
        transaction_suspended: bool,
    }

    struct Vault has store, key {
        id: 0x2::object::UID,
        deposit_token: 0x1::type_name::TypeName,
        reward_tokens: vector<0x1::type_name::TypeName>,
        info: vector<u64>,
        config: vector<u64>,
        share: 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::BigVector,
        share_supply: vector<u64>,
        u64_padding: vector<u64>,
        bcs_padding: vector<u8>,
    }

    struct Share has drop, store {
        user: address,
        share: vector<u64>,
        u64_padding: vector<u64>,
        bcs_padding: vector<u8>,
    }

    struct ManagerEvent has copy, drop {
        action: 0x1::ascii::String,
        log: vector<u64>,
        bcs_padding: vector<vector<u8>>,
    }

    struct UserEvent has copy, drop {
        action: 0x1::ascii::String,
        log: vector<u64>,
        bcs_padding: vector<vector<u8>>,
    }

    public fun swap<T0, T1>(arg0: &mut 0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::version::Version, arg1: &Registry, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: u64, arg5: 0x2::coin::Coin<T0>, arg6: 0x2::coin::Coin<T1>, arg7: bool, arg8: u64, arg9: u128, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::version::verify(arg0, arg11);
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, T1>(arg3, arg7, true, arg8);
        let (v1, v2, v3) = if (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v0) == 0) {
            if (arg7) {
                0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::version::charge_fee<T0>(arg0, 0x2::coin::into_balance<T0>(arg5));
                (0x2::coin::zero<T0>(arg11), arg6, 0)
            } else {
                0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::version::charge_fee<T1>(arg0, 0x2::coin::into_balance<T1>(arg6));
                (arg5, 0x2::coin::zero<T1>(arg11), 0)
            }
        } else {
            let (v4, v5) = 0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::utility::swap<T0, T1>(arg2, arg3, arg5, arg6, arg7, true, arg8, arg9, arg10, arg11);
            (v4, v5, 1)
        };
        let v6 = v2;
        let v7 = v1;
        let v8 = 0x1::vector::empty<u64>();
        let v9 = &mut v8;
        0x1::vector::push_back<u64>(v9, arg4);
        0x1::vector::push_back<u64>(v9, *0x1::vector::borrow<u64>(&0x2::dynamic_object_field::borrow<u64, Vault>(&arg1.id, arg4).info, 1));
        0x1::vector::push_back<u64>(v9, 0x2::coin::value<T0>(&arg5));
        0x1::vector::push_back<u64>(v9, 0x2::coin::value<T1>(&arg6));
        0x1::vector::push_back<u64>(v9, 0x2::coin::value<T0>(&v7));
        0x1::vector::push_back<u64>(v9, 0x2::coin::value<T1>(&v6));
        0x1::vector::push_back<u64>(v9, v3);
        let v10 = ManagerEvent{
            action      : 0x1::ascii::string(b"safu_swap"),
            log         : v8,
            bcs_padding : vector[],
        };
        0x2::event::emit<ManagerEvent>(v10);
        let v11 = 0x2::coin::value<T0>(&v7) > 0 && 0x2::coin::value<T1>(&v6) > 0;
        assert!(!v11, invalid_input(arg4));
        (v7, v6)
    }

    fun already_closed(arg0: u64) : u64 {
        abort arg0
    }

    fun already_incentivised(arg0: u64) : u64 {
        abort arg0
    }

    fun calculate_bid_size(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        let v0 = (((arg3 as u128) * (0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::utility::multiplier(arg1) as u128) / (((((arg2 as u128) * ((arg0 + 10000) as u128) / (10000 as u128)) as u64) + 1) as u128)) as u64);
        if (arg4 < v0) {
            arg4
        } else {
            v0
        }
    }

    fun calculate_bid_value(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        let v0 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::utility::multiplier(arg1);
        let v1 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::utility::multiplier(arg2);
        let v2 = (((arg3 as u128) * (arg4 as u128) / (v0 as u128)) as u64);
        (((v2 as u128) * (v0 as u128) / (v1 as u128)) as u64) + ((((((v2 as u128) * (arg0 as u128) / (10000 as u128)) as u64) as u128) * (v0 as u128) / (v1 as u128)) as u64)
    }

    fun capacity_violation(arg0: u64) : u64 {
        abort arg0
    }

    public fun claim_reward<T0>(arg0: &0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::version::Version, arg1: &mut Registry, arg2: u64, arg3: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::version::version_check(arg0);
        assert!(!arg1.transaction_suspended, transaction_suspended(arg2));
        let v0 = 0x2::dynamic_object_field::borrow_mut<u64, Vault>(&mut arg1.id, arg2);
        let v1 = 0x1::type_name::get<T0>();
        let (v2, v3) = 0x1::vector::index_of<0x1::type_name::TypeName>(&v0.reward_tokens, &v1);
        assert!(v2, invalid_token(arg2));
        let v4 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::length(&v0.share);
        if (v4 > 0) {
            let v5 = (0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::slice_size(&v0.share) as u64);
            let v6 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_slice_mut<Share>(&mut v0.share, 0);
            let v7 = 0;
            while (v7 < v4) {
                let v8 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_from_slice_mut<Share>(v6, v7 % v5);
                if (v8.user == 0x2::tx_context::sender(arg3)) {
                    let v9 = *0x1::vector::borrow<u64>(&v8.share, v3 + 5);
                    *0x1::vector::borrow_mut<u64>(&mut v8.share, v3 + 5) = 0;
                    *0x1::vector::borrow_mut<u64>(&mut v0.share_supply, v3 + 5) = *0x1::vector::borrow<u64>(&v0.share_supply, v3 + 5) - v9;
                    assert!(v9 > 0, zero_value(arg2));
                    let v10 = 0x1::vector::empty<u64>();
                    let v11 = &mut v10;
                    0x1::vector::push_back<u64>(v11, arg2);
                    0x1::vector::push_back<u64>(v11, *0x1::vector::borrow<u64>(&v0.info, 1));
                    0x1::vector::push_back<u64>(v11, v9);
                    let v12 = 0x1::type_name::get<T0>();
                    let v13 = 0x1::vector::empty<vector<u8>>();
                    0x1::vector::push_back<vector<u8>>(&mut v13, 0x1::bcs::to_bytes<0x1::type_name::TypeName>(&v12));
                    let v14 = UserEvent{
                        action      : 0x1::ascii::string(b"claim_reward"),
                        log         : v10,
                        bcs_padding : v13,
                    };
                    0x2::event::emit<UserEvent>(v14);
                    if (is_empty(v8)) {
                        0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::swap_remove<Share>(&mut v0.share, v7);
                    };
                    return 0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v0.id, 0x1::type_name::get<T0>()), v9)
                };
                if (v7 + 1 < v4 && (v7 + 1) % v5 == 0) {
                    let v15 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::get_slice_idx<Share>(v6) + 1;
                    v6 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_slice_mut<Share>(&mut v0.share, v15);
                };
                v7 = v7 + 1;
            };
        };
        abort user_share_not_found(arg2)
    }

    public fun close(arg0: &0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::version::Version, arg1: &mut Registry, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::version::verify(arg0, arg3);
        let v0 = 0x2::dynamic_object_field::borrow_mut<u64, Vault>(&mut arg1.id, arg2);
        assert!(*0x1::vector::borrow<u64>(&v0.info, 5) != 0 || *0x1::vector::borrow<u64>(&v0.config, 4) != 0, already_closed(arg2));
        *0x1::vector::borrow_mut<u64>(&mut v0.info, 5) = 0;
        *0x1::vector::borrow_mut<u64>(&mut v0.config, 4) = 0;
        let v1 = 0x1::vector::empty<u64>();
        let v2 = &mut v1;
        0x1::vector::push_back<u64>(v2, arg2);
        0x1::vector::push_back<u64>(v2, *0x1::vector::borrow<u64>(&v0.info, 1));
        let v3 = ManagerEvent{
            action      : 0x1::ascii::string(b"close"),
            log         : v1,
            bcs_padding : vector[],
        };
        0x2::event::emit<ManagerEvent>(v3);
    }

    fun contaminated_share(arg0: u64) : u64 {
        abort arg0
    }

    entry fun deposit_mist_balance<T0>(arg0: &0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::version::Version, arg1: &mut Registry, arg2: u64, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::tx_context::TxContext) {
        0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::version::verify(arg0, arg4);
        let v0 = 0x2::dynamic_object_field::borrow_mut<u64, Vault>(&mut arg1.id, arg2);
        0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut v0.id, 0x1::ascii::string(b"mist_balance")), 0x2::coin::into_balance<T0>(arg3));
        let v1 = 0x1::vector::empty<u64>();
        let v2 = &mut v1;
        0x1::vector::push_back<u64>(v2, arg2);
        0x1::vector::push_back<u64>(v2, *0x1::vector::borrow<u64>(&v0.info, 1));
        0x1::vector::push_back<u64>(v2, 0x2::balance::value<T0>(0x2::dynamic_field::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut v0.id, 0x1::ascii::string(b"mist_balance"))));
        let v3 = ManagerEvent{
            action      : 0x1::ascii::string(b"deposit_mist_balance"),
            log         : v1,
            bcs_padding : vector[],
        };
        0x2::event::emit<ManagerEvent>(v3);
    }

    public fun deposit_navi<T0>(arg0: &0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::version::Version, arg1: &mut Registry, arg2: u64, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: u8, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        deprecated();
        abort 0
    }

    public fun deposit_navi_v2<T0>(arg0: &0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::version::Version, arg1: &mut Registry, arg2: u64, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: u8, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::version::verify(arg0, arg9);
        let v0 = 0x2::dynamic_object_field::borrow_mut<u64, Vault>(&mut arg1.id, arg2);
        assert!(*0x1::vector::borrow<u64>(&v0.info, 5) == 1, lending_disabled(arg2));
        assert!(0x2::clock::timestamp_ms(arg8) < *0x1::vector::borrow<u64>(&v0.info, 3), not_time_yet(arg2));
        assert!(*0x1::vector::borrow<u64>(&v0.info, 4) == 0, invalid_status(arg2));
        *0x1::vector::borrow_mut<u64>(&mut v0.info, 4) = 4;
        let v1 = 0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut v0.id, 0x1::ascii::string(b"deposit_balance")), *0x1::vector::borrow<u64>(&v0.share_supply, 0) + *0x1::vector::borrow<u64>(&v0.share_supply, 1));
        let v2 = 0x2::balance::value<T0>(&v1);
        if (v2 == 0) {
            0x2::balance::destroy_zero<T0>(v1);
            return
        };
        let v3 = if (0x2::dynamic_object_field::exists_<0x1::ascii::String>(&v0.id, 0x1::ascii::string(b"navi_account_cap"))) {
            0x2::dynamic_object_field::remove<0x1::ascii::String, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(&mut v0.id, 0x1::ascii::string(b"navi_account_cap"))
        } else {
            0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::create_account(arg9)
        };
        let v4 = v3;
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::deposit_with_account_cap<T0>(arg8, arg3, arg4, arg5, 0x2::coin::from_balance<T0>(v1, arg9), arg6, arg7, &v4);
        0x2::dynamic_object_field::add<0x1::ascii::String, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(&mut v0.id, 0x1::ascii::string(b"navi_account_cap"), v4);
        let v5 = 0x1::vector::empty<u64>();
        let v6 = &mut v5;
        0x1::vector::push_back<u64>(v6, arg2);
        0x1::vector::push_back<u64>(v6, *0x1::vector::borrow<u64>(&v0.info, 1));
        0x1::vector::push_back<u64>(v6, v2);
        let v7 = ManagerEvent{
            action      : 0x1::ascii::string(b"deposit_navi"),
            log         : v5,
            bcs_padding : vector[],
        };
        0x2::event::emit<ManagerEvent>(v7);
    }

    public fun deposit_scallop_basic<T0>(arg0: &0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::version::Version, arg1: &mut Registry, arg2: u64, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::version::verify(arg0, arg6);
        let v0 = 0x2::dynamic_object_field::borrow_mut<u64, Vault>(&mut arg1.id, arg2);
        assert!(*0x1::vector::borrow<u64>(&v0.info, 5) == 1, lending_disabled(arg2));
        assert!(0x2::clock::timestamp_ms(arg5) < *0x1::vector::borrow<u64>(&v0.info, 3), not_time_yet(arg2));
        assert!(*0x1::vector::borrow<u64>(&v0.info, 4) == 0, invalid_status(arg2));
        *0x1::vector::borrow_mut<u64>(&mut v0.info, 4) = 2;
        let v1 = 0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut v0.id, 0x1::ascii::string(b"deposit_balance")), *0x1::vector::borrow<u64>(&v0.share_supply, 0) + *0x1::vector::borrow<u64>(&v0.share_supply, 1));
        let v2 = 0x2::balance::value<T0>(&v1);
        if (v2 == 0) {
            0x2::balance::destroy_zero<T0>(v1);
            return
        };
        let v3 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::mint::mint<T0>(arg3, arg4, 0x2::coin::from_balance<T0>(v1, arg6), arg5, arg6);
        0x2::dynamic_object_field::add<0x1::ascii::String, 0x2::coin::Coin<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(&mut v0.id, 0x1::ascii::string(b"scallop_market_coin"), v3);
        let v4 = 0x1::vector::empty<u64>();
        let v5 = &mut v4;
        0x1::vector::push_back<u64>(v5, arg2);
        0x1::vector::push_back<u64>(v5, *0x1::vector::borrow<u64>(&v0.info, 1));
        0x1::vector::push_back<u64>(v5, v2);
        0x1::vector::push_back<u64>(v5, 0x2::coin::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&v3));
        let v6 = ManagerEvent{
            action      : 0x1::ascii::string(b"deposit_scallop_basic"),
            log         : v4,
            bcs_padding : vector[],
        };
        0x2::event::emit<ManagerEvent>(v6);
    }

    public fun deposit_scallop_spool<T0>(arg0: &0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::version::Version, arg1: &mut Registry, arg2: u64, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::version::verify(arg0, arg7);
        let v0 = 0x2::dynamic_object_field::borrow_mut<u64, Vault>(&mut arg1.id, arg2);
        assert!(*0x1::vector::borrow<u64>(&v0.info, 5) == 1, lending_disabled(arg2));
        assert!(0x2::clock::timestamp_ms(arg6) < *0x1::vector::borrow<u64>(&v0.info, 3), not_time_yet(arg2));
        assert!(*0x1::vector::borrow<u64>(&v0.info, 4) == 0, invalid_status(arg2));
        *0x1::vector::borrow_mut<u64>(&mut v0.info, 4) = 1;
        let v1 = 0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut v0.id, 0x1::ascii::string(b"deposit_balance")), *0x1::vector::borrow<u64>(&v0.share_supply, 0) + *0x1::vector::borrow<u64>(&v0.share_supply, 1));
        let v2 = 0x2::balance::value<T0>(&v1);
        if (v2 == 0) {
            0x2::balance::destroy_zero<T0>(v1);
            return
        };
        let v3 = if (0x2::dynamic_object_field::exists_<0x1::ascii::String>(&v0.id, 0x1::ascii::string(b"scallop_spool_account"))) {
            0x2::dynamic_object_field::remove<0x1::ascii::String, 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::SpoolAccount<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(&mut v0.id, 0x1::ascii::string(b"scallop_spool_account"))
        } else {
            0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::user::new_spool_account<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(arg5, arg6, arg7)
        };
        let v4 = v3;
        let v5 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::mint::mint<T0>(arg3, arg4, 0x2::coin::from_balance<T0>(v1, arg7), arg6, arg7);
        0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::user::stake<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(arg5, &mut v4, v5, arg6, arg7);
        0x2::dynamic_object_field::add<0x1::ascii::String, 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::SpoolAccount<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(&mut v0.id, 0x1::ascii::string(b"scallop_spool_account"), v4);
        let v6 = 0x1::vector::empty<u64>();
        let v7 = &mut v6;
        0x1::vector::push_back<u64>(v7, arg2);
        0x1::vector::push_back<u64>(v7, *0x1::vector::borrow<u64>(&v0.info, 1));
        0x1::vector::push_back<u64>(v7, v2);
        0x1::vector::push_back<u64>(v7, 0x2::coin::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&v5));
        let v8 = ManagerEvent{
            action      : 0x1::ascii::string(b"deposit_scallop_spool"),
            log         : v6,
            bcs_padding : vector[],
        };
        0x2::event::emit<ManagerEvent>(v8);
    }

    public fun deposit_suilend<T0>(arg0: &0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::version::Version, arg1: &mut Registry, arg2: u64, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::version::verify(arg0, arg6);
        let v0 = 0x2::dynamic_object_field::borrow_mut<u64, Vault>(&mut arg1.id, arg2);
        assert!(*0x1::vector::borrow<u64>(&v0.info, 5) == 1, lending_disabled(arg2));
        assert!(0x2::clock::timestamp_ms(arg5) < *0x1::vector::borrow<u64>(&v0.info, 3), not_time_yet(arg2));
        assert!(*0x1::vector::borrow<u64>(&v0.info, 4) == 0, invalid_status(arg2));
        *0x1::vector::borrow_mut<u64>(&mut v0.info, 4) = 3;
        let v1 = 0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut v0.id, 0x1::ascii::string(b"deposit_balance")), *0x1::vector::borrow<u64>(&v0.share_supply, 0) + *0x1::vector::borrow<u64>(&v0.share_supply, 1));
        let v2 = 0x2::balance::value<T0>(&v1);
        if (v2 == 0) {
            0x2::balance::destroy_zero<T0>(v1);
            return
        };
        let v3 = if (0x2::dynamic_object_field::exists_<0x1::ascii::String>(&v0.id, 0x1::ascii::string(b"suilend_obligation_owner_cap"))) {
            0x2::dynamic_object_field::remove<0x1::ascii::String, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>>(&mut v0.id, 0x1::ascii::string(b"suilend_obligation_owner_cap"))
        } else {
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::create_obligation<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg3, arg6)
        };
        let v4 = v3;
        let v5 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_liquidity_and_mint_ctokens<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg3, arg4, arg5, 0x2::coin::from_balance<T0>(v1, arg6), arg6);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_ctokens_into_obligation<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg3, arg4, &v4, arg5, v5, arg6);
        0x2::dynamic_object_field::add<0x1::ascii::String, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>>(&mut v0.id, 0x1::ascii::string(b"suilend_obligation_owner_cap"), v4);
        let v6 = 0x1::vector::empty<u64>();
        let v7 = &mut v6;
        0x1::vector::push_back<u64>(v7, arg2);
        0x1::vector::push_back<u64>(v7, *0x1::vector::borrow<u64>(&v0.info, 1));
        0x1::vector::push_back<u64>(v7, v2);
        0x1::vector::push_back<u64>(v7, 0x2::coin::value<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>>(&v5));
        let v8 = ManagerEvent{
            action      : 0x1::ascii::string(b"deposit_suilend"),
            log         : v6,
            bcs_padding : vector[],
        };
        0x2::event::emit<ManagerEvent>(v8);
    }

    fun deprecated() : u64 {
        abort 0
    }

    public fun get_reward_navi_parameters(arg0: &0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::version::Version, arg1: &Registry, arg2: u64, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : vector<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::ClaimableReward> {
        0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::version::verify(arg0, arg6);
        let v0 = 0x2::dynamic_object_field::borrow<u64, Vault>(&arg1.id, arg2);
        assert!(*0x1::vector::borrow<u64>(&v0.info, 4) == 4, invalid_status(arg2));
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::get_user_claimable_rewards(arg5, arg3, arg4, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(0x2::dynamic_object_field::borrow<0x1::ascii::String, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(&v0.id, 0x1::ascii::string(b"navi_account_cap"))))
    }

    public(friend) fun get_user_share(arg0: &Registry, arg1: u64, arg2: address) : 0x1::option::Option<Share> {
        if (0x2::dynamic_object_field::exists_<u64>(&arg0.id, arg1)) {
            let v0 = 0x2::dynamic_object_field::borrow<u64, Vault>(&arg0.id, arg1);
            let v1 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::length(&v0.share);
            if (v1 > 0) {
                let v2 = (0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::slice_size(&v0.share) as u64);
                let v3 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_slice<Share>(&v0.share, 0);
                let v4 = 0;
                while (v4 < v1) {
                    if (0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_from_slice<Share>(v3, v4 % v2).user == arg2) {
                        let v5 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_from_slice<Share>(v3, v4 % v2);
                        let v6 = Share{
                            user        : v5.user,
                            share       : v5.share,
                            u64_padding : v5.u64_padding,
                            bcs_padding : v5.bcs_padding,
                        };
                        return 0x1::option::some<Share>(v6)
                    };
                    if (v4 + 1 < v1 && (v4 + 1) % v2 == 0) {
                        let v7 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::get_slice_idx<Share>(v3) + 1;
                        v3 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_slice<Share>(&v0.share, v7);
                    };
                    v4 = v4 + 1;
                };
            };
        };
        0x1::option::none<Share>()
    }

    public fun incentivise<T0>(arg0: &0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::version::Version, arg1: &mut Registry, arg2: u64, arg3: 0x2::balance::Balance<T0>, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        deprecated();
        abort 0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id                    : 0x2::object::new(arg0),
            num_of_vault          : 0,
            transaction_suspended : false,
        };
        0x2::transfer::share_object<Registry>(v0);
    }

    fun invalid_fee_amount(arg0: u64) : u64 {
        abort arg0
    }

    fun invalid_input(arg0: u64) : u64 {
        abort arg0
    }

    fun invalid_status(arg0: u64) : u64 {
        abort arg0
    }

    fun invalid_token(arg0: u64) : u64 {
        abort arg0
    }

    fun invalid_witness(arg0: u64) : u64 {
        abort arg0
    }

    fun is_empty(arg0: &Share) : bool {
        if (*0x1::vector::borrow<u64>(&arg0.u64_padding, 0) > 0) {
            return false
        };
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg0.share)) {
            if (*0x1::vector::borrow<u64>(&arg0.share, v0) > 0) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    entry fun issue_typus_manager_cap(arg0: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg1: &mut Registry, arg2: &0x2::tx_context::TxContext) {
        0x2::dynamic_field::add<0x1::ascii::String, 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::ManagerCap>(&mut arg1.id, 0x1::ascii::string(b"typus_manager_cap"), 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::issue_manager_cap(arg0, arg2));
    }

    fun lending_disabled(arg0: u64) : u64 {
        abort arg0
    }

    fun lot_size_violation(arg0: u64) : u64 {
        abort arg0
    }

    fun min_size_violation(arg0: u64) : u64 {
        abort arg0
    }

    entry fun new_vault<T0>(arg0: &0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::version::Version, arg1: &mut Registry, arg2: u64, arg3: u64, arg4: bool, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: vector<u64>, arg10: 0x2::coin::Coin<T0>, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::version::verify(arg0, arg12);
        let v0 = 0x2::object::new(arg12);
        0x2::dynamic_field::add<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut v0, 0x1::ascii::string(b"deposit_balance"), 0x2::balance::zero<T0>());
        0x2::dynamic_field::add<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut v0, 0x1::ascii::string(b"mist_balance"), 0x2::coin::into_balance<T0>(arg10));
        let v1 = vector[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
        *0x1::vector::borrow_mut<u64>(&mut v1, 0) = arg1.num_of_vault;
        *0x1::vector::borrow_mut<u64>(&mut v1, 2) = arg2;
        *0x1::vector::borrow_mut<u64>(&mut v1, 3) = arg3;
        let v2 = if (arg4) {
            1
        } else {
            0
        };
        *0x1::vector::borrow_mut<u64>(&mut v1, 5) = v2;
        *0x1::vector::borrow_mut<u64>(&mut v1, 6) = arg5;
        *0x1::vector::borrow_mut<u64>(&mut v1, 7) = 1;
        *0x1::vector::borrow_mut<u64>(&mut v1, 8) = 1;
        *0x1::vector::borrow_mut<u64>(&mut v1, 9) = arg6;
        *0x1::vector::borrow_mut<u64>(&mut v1, 10) = arg7;
        *0x1::vector::borrow_mut<u64>(&mut v1, 11) = 0x2::clock::timestamp_ms(arg11);
        *0x1::vector::borrow_mut<u64>(&mut v1, 12) = arg8 + 1;
        assert!(0x1::vector::length<u64>(&arg9) == 12, invalid_input(*0x1::vector::borrow<u64>(&v1, 0)));
        let v3 = Vault{
            id            : v0,
            deposit_token : 0x1::type_name::get<T0>(),
            reward_tokens : 0x1::vector::empty<0x1::type_name::TypeName>(),
            info          : v1,
            config        : arg9,
            share         : 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::new<Share>(1000, arg12),
            share_supply  : vector[0, 0, 0, 0, 0],
            u64_padding   : 0x1::vector::empty<u64>(),
            bcs_padding   : 0x1::vector::empty<u8>(),
        };
        let v4 = vector[];
        0x1::vector::append<u64>(&mut v4, v3.info);
        0x1::vector::append<u64>(&mut v4, v3.config);
        let v5 = 0x1::type_name::get<T0>();
        let v6 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v6, 0x1::bcs::to_bytes<0x1::type_name::TypeName>(&v5));
        let v7 = ManagerEvent{
            action      : 0x1::ascii::string(b"new_vault"),
            log         : v4,
            bcs_padding : v6,
        };
        0x2::event::emit<ManagerEvent>(v7);
        arg1.num_of_vault = arg1.num_of_vault + 1;
        0x2::dynamic_object_field::add<u64, Vault>(&mut arg1.id, *0x1::vector::borrow<u64>(&v3.info, 0), v3);
    }

    fun not_time_yet(arg0: u64) : u64 {
        abort arg0
    }

    fun not_yet_incentivised(arg0: u64) : u64 {
        abort arg0
    }

    public fun post_bid_balance<T0>(arg0: &mut 0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::version::Version, arg1: &mut Registry, arg2: u64, arg3: 0x2::balance::Balance<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::version::verify(arg0, arg4);
        if (0x2::balance::value<T0>(&arg3) == 0) {
            0x2::balance::destroy_zero<T0>(arg3);
            return
        };
        let v0 = 0x2::dynamic_object_field::borrow_mut<u64, Vault>(&mut arg1.id, arg2);
        assert!(*0x1::vector::borrow<u64>(&v0.info, 4) == 0, invalid_status(arg2));
        let v1 = (((0x2::balance::value<T0>(&arg3) as u128) * (*0x1::vector::borrow<u64>(&v0.config, 3) as u128) / (10000 as u128)) as u64);
        0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::version::charge_fee<T0>(arg0, 0x2::balance::split<T0>(&mut arg3, v1));
        let v2 = 0x1::vector::empty<u64>();
        let v3 = &mut v2;
        0x1::vector::push_back<u64>(v3, arg2);
        0x1::vector::push_back<u64>(v3, *0x1::vector::borrow<u64>(&v0.info, 1));
        0x1::vector::push_back<u64>(v3, 0x2::balance::value<T0>(&arg3));
        0x1::vector::push_back<u64>(v3, v1);
        let v4 = ManagerEvent{
            action      : 0x1::ascii::string(b"post_bid_balance"),
            log         : v2,
            bcs_padding : vector[],
        };
        0x2::event::emit<ManagerEvent>(v4);
        let v5 = 0x2::balance::value<T0>(&arg3);
        let v6 = *0x1::vector::borrow<u64>(&v0.share_supply, 0) + *0x1::vector::borrow<u64>(&v0.share_supply, 1);
        let v7 = 0;
        let v8 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::length(&v0.share);
        if (v8 > 0) {
            let v9 = (0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::slice_size(&v0.share) as u64);
            let v10 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_slice_mut<Share>(&mut v0.share, 0);
            let v11 = 0;
            while (v11 < v8 && v6 > 0) {
                let v12 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_from_slice_mut<Share>(v10, v11 % v9);
                let v13 = (((v5 as u128) * ((*0x1::vector::borrow<u64>(&v12.share, 0) + *0x1::vector::borrow<u64>(&v12.share, 1)) as u128) / (v6 as u128)) as u64);
                if (*0x1::vector::borrow<u64>(&v12.share, 0) > 0) {
                    *0x1::vector::borrow_mut<u64>(&mut v12.share, 3) = *0x1::vector::borrow<u64>(&v12.share, 3) + v13;
                    v7 = v7 + v13;
                } else {
                    *0x1::vector::borrow_mut<u64>(&mut v12.share, 2) = *0x1::vector::borrow<u64>(&v12.share, 2) + v13;
                };
                v5 = v5 - v13;
                v6 = v6 - *0x1::vector::borrow<u64>(&v12.share, 0) + *0x1::vector::borrow<u64>(&v12.share, 1);
                if (v11 + 1 < v8 && (v11 + 1) % v9 == 0) {
                    let v14 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::get_slice_idx<Share>(v10) + 1;
                    v10 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_slice_mut<Share>(&mut v0.share, v14);
                };
                v11 = v11 + 1;
            };
        };
        *0x1::vector::borrow_mut<u64>(&mut v0.share_supply, 3) = *0x1::vector::borrow<u64>(&v0.share_supply, 3) + v7;
        *0x1::vector::borrow_mut<u64>(&mut v0.share_supply, 2) = *0x1::vector::borrow<u64>(&v0.share_supply, 2) + 0x2::balance::value<T0>(&arg3) - v7;
        0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut v0.id, 0x1::ascii::string(b"deposit_balance")), arg3);
    }

    public fun post_bid_receipt<T0: store + key>(arg0: &0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::version::Version, arg1: &mut Registry, arg2: u64, arg3: 0x1::option::Option<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::version::verify(arg0, arg4);
        if (0x1::option::is_none<T0>(&arg3)) {
            0x1::option::destroy_none<T0>(arg3);
            return
        };
        let v0 = 0x1::option::destroy_some<T0>(arg3);
        let v1 = 0x2::dynamic_object_field::borrow_mut<u64, Vault>(&mut arg1.id, arg2);
        assert!(*0x1::vector::borrow<u64>(&v1.info, 4) == 0, invalid_status(arg2));
        let v2 = 0x1::vector::empty<u64>();
        let v3 = &mut v2;
        0x1::vector::push_back<u64>(v3, arg2);
        0x1::vector::push_back<u64>(v3, *0x1::vector::borrow<u64>(&v1.info, 1));
        let v4 = 0x2::object::id_address<T0>(&v0);
        let v5 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v5, 0x1::bcs::to_bytes<address>(&v4));
        let v6 = ManagerEvent{
            action      : 0x1::ascii::string(b"post_bid_receipt"),
            log         : v2,
            bcs_padding : v5,
        };
        0x2::event::emit<ManagerEvent>(v6);
        0x2::dynamic_object_field::add<0x1::ascii::String, T0>(&mut v1.id, 0x1::ascii::string(b"typus_bid_receipt"), v0);
    }

    public fun post_deposit_dov<T0: drop, T1: store + key>(arg0: T0, arg1: &0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::version::Version, arg2: &mut Registry, arg3: u64, arg4: T1, arg5: &mut 0x2::tx_context::TxContext) {
        0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::version::verify(arg1, arg5);
        assert!(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())) == b"6eb0c5a7deb53fe42162e21908b498879f6580da6f9939e4f8a547772c6db438::dov_safu::VERSION", invalid_witness(arg3));
        let v0 = 0x2::dynamic_object_field::borrow_mut<u64, Vault>(&mut arg2.id, arg3);
        let v1 = 0x1::vector::empty<u64>();
        let v2 = &mut v1;
        0x1::vector::push_back<u64>(v2, arg3);
        0x1::vector::push_back<u64>(v2, *0x1::vector::borrow<u64>(&v0.info, 1));
        let v3 = 0x2::object::id_address<T1>(&arg4);
        let v4 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v4, 0x1::bcs::to_bytes<address>(&v3));
        let v5 = ManagerEvent{
            action      : 0x1::ascii::string(b"post_deposit_dov"),
            log         : v1,
            bcs_padding : v4,
        };
        0x2::event::emit<ManagerEvent>(v5);
        0x2::dynamic_object_field::add<0x1::ascii::String, T1>(&mut v0.id, 0x1::ascii::string(b"typus_deposit_receipt"), arg4);
    }

    public fun post_exercise<T0>(arg0: &0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::version::Version, arg1: &mut Registry, arg2: u64, arg3: 0x2::balance::Balance<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        deprecated();
        abort 0
    }

    public fun post_exercise_v2<T0>(arg0: &mut 0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::version::Version, arg1: &mut Registry, arg2: u64, arg3: 0x2::balance::Balance<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::version::verify(arg0, arg4);
        let v0 = 0x2::dynamic_object_field::borrow_mut<u64, Vault>(&mut arg1.id, arg2);
        assert!(*0x1::vector::borrow<u64>(&v0.info, 4) == 0, invalid_status(arg2));
        let v1 = (((0x2::balance::value<T0>(&arg3) as u128) * (*0x1::vector::borrow<u64>(&v0.config, 9) as u128) / (10000 as u128)) as u64);
        0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::version::charge_fee<T0>(arg0, 0x2::balance::split<T0>(&mut arg3, v1));
        let v2 = 0x1::vector::empty<u64>();
        let v3 = &mut v2;
        0x1::vector::push_back<u64>(v3, arg2);
        0x1::vector::push_back<u64>(v3, *0x1::vector::borrow<u64>(&v0.info, 1));
        0x1::vector::push_back<u64>(v3, 0x2::balance::value<T0>(&arg3));
        0x1::vector::push_back<u64>(v3, v1);
        let v4 = ManagerEvent{
            action      : 0x1::ascii::string(b"post_exercise"),
            log         : v2,
            bcs_padding : vector[],
        };
        0x2::event::emit<ManagerEvent>(v4);
        let v5 = 0x2::balance::value<T0>(&arg3);
        let v6 = *0x1::vector::borrow<u64>(&v0.share_supply, 4);
        let v7 = 0;
        let v8 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::length(&v0.share);
        if (v8 > 0) {
            let v9 = (0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::slice_size(&v0.share) as u64);
            let v10 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_slice_mut<Share>(&mut v0.share, 0);
            let v11 = 0;
            while (v11 < v8 && v6 > 0) {
                let v12 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_from_slice_mut<Share>(v10, v11 % v9);
                let v13 = (((v5 as u128) * (*0x1::vector::borrow<u64>(&v12.share, 4) as u128) / (v6 as u128)) as u64);
                if (*0x1::vector::borrow<u64>(&v12.share, 0) > 0) {
                    *0x1::vector::borrow_mut<u64>(&mut v12.share, 3) = *0x1::vector::borrow<u64>(&v12.share, 3) + v13;
                    v7 = v7 + v13;
                } else {
                    *0x1::vector::borrow_mut<u64>(&mut v12.share, 2) = *0x1::vector::borrow<u64>(&v12.share, 2) + v13;
                };
                v5 = v5 - v13;
                v6 = v6 - *0x1::vector::borrow<u64>(&v12.share, 4);
                if (v11 + 1 < v8 && (v11 + 1) % v9 == 0) {
                    let v14 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::get_slice_idx<Share>(v10) + 1;
                    v10 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_slice_mut<Share>(&mut v0.share, v14);
                };
                v11 = v11 + 1;
            };
        };
        *0x1::vector::borrow_mut<u64>(&mut v0.share_supply, 3) = *0x1::vector::borrow<u64>(&v0.share_supply, 3) + v7;
        *0x1::vector::borrow_mut<u64>(&mut v0.share_supply, 2) = *0x1::vector::borrow<u64>(&v0.share_supply, 2) + 0x2::balance::value<T0>(&arg3) - v7;
        0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut v0.id, 0x1::ascii::string(b"deposit_balance")), arg3);
    }

    public fun post_withdraw_dov<T0: drop, T1>(arg0: T0, arg1: &0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::version::Version, arg2: &mut Registry, arg3: u64, arg4: 0x2::balance::Balance<T1>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::version::verify(arg1, arg5);
        assert!(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())) == b"6eb0c5a7deb53fe42162e21908b498879f6580da6f9939e4f8a547772c6db438::dov_safu::VERSION", invalid_witness(arg3));
        let v0 = 0x2::dynamic_object_field::borrow_mut<u64, Vault>(&mut arg2.id, arg3);
        assert!(*0x1::vector::borrow<u64>(&v0.info, 4) == 5, invalid_status(arg3));
        *0x1::vector::borrow_mut<u64>(&mut v0.info, 4) = 0;
        let v1 = 0x2::balance::value<T1>(&arg4);
        let v2 = *0x1::vector::borrow<u64>(&v0.share_supply, 0) + *0x1::vector::borrow<u64>(&v0.share_supply, 1);
        if (v1 < v2) {
            0x2::balance::join<T1>(&mut arg4, 0x2::balance::split<T1>(0x2::dynamic_field::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T1>>(&mut v0.id, 0x1::ascii::string(b"mist_balance")), 1));
        };
        0x2::balance::join<T1>(0x2::dynamic_field::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T1>>(&mut v0.id, 0x1::ascii::string(b"deposit_balance")), 0x2::balance::split<T1>(&mut arg4, v2));
        if (0x2::balance::value<T1>(&arg4) > 0 && 0x2::balance::value<T1>(0x2::dynamic_field::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T1>>(&mut v0.id, 0x1::ascii::string(b"mist_balance"))) == 0) {
            0x2::balance::join<T1>(0x2::dynamic_field::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T1>>(&mut v0.id, 0x1::ascii::string(b"mist_balance")), 0x2::balance::split<T1>(&mut arg4, 1));
        };
        let v3 = 0x1::vector::empty<u64>();
        let v4 = &mut v3;
        0x1::vector::push_back<u64>(v4, arg3);
        0x1::vector::push_back<u64>(v4, *0x1::vector::borrow<u64>(&v0.info, 1));
        0x1::vector::push_back<u64>(v4, v2);
        0x1::vector::push_back<u64>(v4, v1);
        let v5 = ManagerEvent{
            action      : 0x1::ascii::string(b"post_withdraw_dov"),
            log         : v3,
            bcs_padding : vector[],
        };
        0x2::event::emit<ManagerEvent>(v5);
        arg4
    }

    public fun pre_bid<T0, T1>(arg0: &mut 0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::version::Version, arg1: &mut Registry, arg2: u64, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: 0x2::balance::Balance<T0>, arg6: 0x2::balance::Balance<T1>, arg7: bool, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u128, arg14: u128, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::version::verify(arg0, arg16);
        let v0 = 0x2::dynamic_object_field::borrow_mut<u64, Vault>(&mut arg1.id, arg2);
        assert!(*0x1::vector::borrow<u64>(&v0.info, 4) == 0, invalid_status(arg2));
        let v1 = if (arg7) {
            0x2::balance::value<T0>(&arg5)
        } else {
            0x2::balance::value<T1>(&arg6)
        };
        let v2 = arg7;
        let v3 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, T1>(arg4, v2, true, v1);
        let v4 = if (arg7) {
            0x2::balance::value<T1>(&arg6)
        } else {
            0x2::balance::value<T0>(&arg5)
        };
        let v5 = calculate_bid_value(arg8, arg9, arg10, arg12, calculate_bid_size(arg8, arg10, arg12, ((((v4 + 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v3)) as u128) * (*0x1::vector::borrow<u64>(&v0.config, 4) as u128) / (10000 as u128)) as u64), arg11));
        let (v6, v7) = if (arg7) {
            if (0x2::balance::value<T1>(&arg6) < v5) {
                let (v8, v9) = swap_<T0, T1>(arg3, arg4, arg5, 0x2::balance::zero<T1>(), true, false, v5 - 0x2::balance::value<T1>(&arg6), arg13, arg15, arg16);
                0x2::balance::join<T1>(&mut arg6, v9);
                (v8, arg6)
            } else {
                let (v10, v11) = swap_<T0, T1>(arg3, arg4, 0x2::balance::zero<T0>(), arg6, false, true, 0x2::balance::value<T1>(&arg6), arg14, arg15, arg16);
                let v12 = v11;
                if (0x2::balance::value<T1>(&v12) > 0) {
                    0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::version::charge_fee<T1>(arg0, v12);
                } else {
                    0x2::balance::destroy_zero<T1>(v12);
                };
                0x2::balance::join<T0>(&mut arg5, v10);
                (arg5, 0x2::balance::split<T1>(&mut arg6, v5))
            }
        } else if (0x2::balance::value<T0>(&arg5) < v5) {
            let (v13, v14) = swap_<T0, T1>(arg3, arg4, 0x2::balance::zero<T0>(), arg6, false, false, v5 - 0x2::balance::value<T0>(&arg5), arg14, arg15, arg16);
            0x2::balance::join<T0>(&mut arg5, v13);
            (arg5, v14)
        } else {
            let (v15, v16) = swap_<T0, T1>(arg3, arg4, arg5, 0x2::balance::zero<T1>(), true, true, 0x2::balance::value<T0>(&arg5), arg13, arg15, arg16);
            let v17 = v15;
            if (0x2::balance::value<T0>(&v17) > 0) {
                0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::version::charge_fee<T0>(arg0, v17);
            } else {
                0x2::balance::destroy_zero<T0>(v17);
            };
            0x2::balance::join<T1>(&mut arg6, v16);
            (0x2::balance::split<T0>(&mut arg5, v5), arg6)
        };
        let v18 = v7;
        let v19 = v6;
        let v20 = if (arg7) {
            0x2::balance::value<T0>(&v19)
        } else {
            0x2::balance::value<T1>(&v18)
        };
        let v21 = if (arg7) {
            0x2::balance::value<T1>(&v18)
        } else {
            0x2::balance::value<T0>(&v19)
        };
        let v22 = 0x1::vector::empty<u64>();
        let v23 = &mut v22;
        0x1::vector::push_back<u64>(v23, arg2);
        0x1::vector::push_back<u64>(v23, *0x1::vector::borrow<u64>(&v0.info, 1));
        0x1::vector::push_back<u64>(v23, v20);
        0x1::vector::push_back<u64>(v23, v21);
        let v24 = ManagerEvent{
            action      : 0x1::ascii::string(b"pre_bid"),
            log         : v22,
            bcs_padding : vector[],
        };
        0x2::event::emit<ManagerEvent>(v24);
        (v19, v18)
    }

    public fun pre_deposit_dov<T0: drop, T1>(arg0: T0, arg1: &0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::version::Version, arg2: &mut Registry, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, u64) {
        0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::version::verify(arg1, arg5);
        assert!(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())) == b"6eb0c5a7deb53fe42162e21908b498879f6580da6f9939e4f8a547772c6db438::dov_safu::VERSION", invalid_witness(arg3));
        let v0 = 0x2::dynamic_object_field::borrow_mut<u64, Vault>(&mut arg2.id, arg3);
        assert!(*0x1::vector::borrow<u64>(&v0.info, 5) == 1, lending_disabled(arg3));
        assert!(0x2::clock::timestamp_ms(arg4) < *0x1::vector::borrow<u64>(&v0.info, 3), not_time_yet(arg3));
        assert!(*0x1::vector::borrow<u64>(&v0.info, 4) == 0, invalid_status(arg3));
        *0x1::vector::borrow_mut<u64>(&mut v0.info, 4) = 5;
        let v1 = 0x2::balance::split<T1>(0x2::dynamic_field::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T1>>(&mut v0.id, 0x1::ascii::string(b"deposit_balance")), *0x1::vector::borrow<u64>(&v0.share_supply, 0) + *0x1::vector::borrow<u64>(&v0.share_supply, 1));
        let v2 = 0x1::vector::empty<u64>();
        let v3 = &mut v2;
        0x1::vector::push_back<u64>(v3, arg3);
        0x1::vector::push_back<u64>(v3, *0x1::vector::borrow<u64>(&v0.info, 1));
        0x1::vector::push_back<u64>(v3, 0x2::balance::value<T1>(&v1));
        let v4 = ManagerEvent{
            action      : 0x1::ascii::string(b"pre_deposit_dov"),
            log         : v2,
            bcs_padding : vector[],
        };
        0x2::event::emit<ManagerEvent>(v4);
        (v1, *0x1::vector::borrow<u64>(&v0.info, 12))
    }

    public fun pre_exercise<T0: store + key>(arg0: &0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::version::Version, arg1: &mut Registry, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : T0 {
        0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::version::verify(arg0, arg3);
        let v0 = 0x2::dynamic_object_field::borrow_mut<u64, Vault>(&mut arg1.id, arg2);
        assert!(*0x1::vector::borrow<u64>(&v0.info, 4) == 0, invalid_status(arg2));
        let v1 = 0x2::dynamic_object_field::remove<0x1::ascii::String, T0>(&mut v0.id, 0x1::ascii::string(b"typus_bid_receipt"));
        let v2 = 0x1::vector::empty<u64>();
        let v3 = &mut v2;
        0x1::vector::push_back<u64>(v3, arg2);
        0x1::vector::push_back<u64>(v3, *0x1::vector::borrow<u64>(&v0.info, 1));
        let v4 = 0x2::object::id_address<T0>(&v1);
        let v5 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v5, 0x1::bcs::to_bytes<address>(&v4));
        let v6 = ManagerEvent{
            action      : 0x1::ascii::string(b"pre_exercise"),
            log         : v2,
            bcs_padding : v5,
        };
        0x2::event::emit<ManagerEvent>(v6);
        v1
    }

    public fun pre_withdraw_dov<T0: drop, T1: store + key>(arg0: T0, arg1: &0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::version::Version, arg2: &mut Registry, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (T1, u64) {
        0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::version::verify(arg1, arg4);
        assert!(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())) == b"6eb0c5a7deb53fe42162e21908b498879f6580da6f9939e4f8a547772c6db438::dov_safu::VERSION", invalid_witness(arg3));
        let v0 = 0x2::dynamic_object_field::borrow_mut<u64, Vault>(&mut arg2.id, arg3);
        assert!(*0x1::vector::borrow<u64>(&v0.info, 4) == 5, invalid_status(arg3));
        let v1 = 0x2::dynamic_object_field::remove<0x1::ascii::String, T1>(&mut v0.id, 0x1::ascii::string(b"typus_deposit_receipt"));
        let v2 = 0x1::vector::empty<u64>();
        let v3 = &mut v2;
        0x1::vector::push_back<u64>(v3, arg3);
        0x1::vector::push_back<u64>(v3, *0x1::vector::borrow<u64>(&v0.info, 1));
        let v4 = 0x2::object::id_address<T1>(&v1);
        let v5 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v5, 0x1::bcs::to_bytes<address>(&v4));
        let v6 = ManagerEvent{
            action      : 0x1::ascii::string(b"pre_withdraw_dov"),
            log         : v2,
            bcs_padding : v5,
        };
        0x2::event::emit<ManagerEvent>(v6);
        (v1, *0x1::vector::borrow<u64>(&v0.info, 12))
    }

    public fun raise_fund<T0>(arg0: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg1: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::leaderboard::TypusLeaderboardRegistry, arg2: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::user::TypusUserRegistry, arg3: &0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::version::Version, arg4: &mut Registry, arg5: u64, arg6: 0x2::balance::Balance<T0>, arg7: u64, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::version::version_check(arg3);
        assert!(!arg4.transaction_suspended, transaction_suspended(arg5));
        let v0 = 0x2::clock::timestamp_ms(arg10);
        let v1 = 0x2::dynamic_field::remove<0x1::ascii::String, 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::ManagerCap>(&mut arg4.id, 0x1::ascii::string(b"typus_manager_cap"));
        let v2 = 0x2::dynamic_object_field::borrow_mut<u64, Vault>(&mut arg4.id, arg5);
        assert!(*0x1::vector::borrow<u64>(&v2.info, 4) != 999, already_closed(arg5));
        let v3 = 0x2::tx_context::sender(arg11);
        let v4 = 0;
        let v5 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::length(&v2.share);
        if (v5 > 0) {
            let v6 = (0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::slice_size(&v2.share) as u64);
            let v7 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_slice<Share>(&v2.share, 0);
            while (v4 < v5) {
                if (0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_from_slice<Share>(v7, v4 % v6).user == v3) {
                    break
                };
                if (v4 + 1 < v5 && (v4 + 1) % v6 == 0) {
                    let v8 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::get_slice_idx<Share>(v7) + 1;
                    v7 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_slice<Share>(&v2.share, v8);
                };
                v4 = v4 + 1;
            };
        };
        if (v4 == v5) {
            let v9 = vector[0, 0, 0, 0, 0];
            let v10 = 0;
            while (v10 < 0x1::vector::length<0x1::type_name::TypeName>(&v2.reward_tokens)) {
                0x1::vector::push_back<u64>(&mut v9, 0);
                v10 = v10 + 1;
            };
            let v11 = 0x1::vector::empty<u64>();
            let v12 = &mut v11;
            0x1::vector::push_back<u64>(v12, 0);
            0x1::vector::push_back<u64>(v12, v0);
            let v13 = Share{
                user        : v3,
                share       : v9,
                u64_padding : v11,
                bcs_padding : b"",
            };
            0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::push_back<Share>(&mut v2.share, v13);
        };
        let v14 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_mut<Share>(&mut v2.share, v4);
        let v15 = (((*0x1::vector::borrow<u64>(&v14.u64_padding, 0) as u256) * ((v0 - *0x1::vector::borrow<u64>(&v14.u64_padding, 1)) as u256) * (*0x1::vector::borrow<u64>(&v2.config, 5) as u256) / 3600000 / (10000 as u256)) as u64);
        let v16 = (((*0x1::vector::borrow<u64>(&v14.u64_padding, 0) as u256) * ((v0 - *0x1::vector::borrow<u64>(&v14.u64_padding, 1)) as u256) * (*0x1::vector::borrow<u64>(&v2.config, 8) as u256) / 3600000 / (10000 as u256)) as u64);
        *0x1::vector::borrow_mut<u64>(&mut v14.u64_padding, 1) = v0;
        0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::user::add_tails_exp_amount(&v1, arg0, arg2, v3, v15);
        0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::leaderboard::score(&v1, arg0, arg1, 0x1::ascii::string(b"depositor_program"), v3, v16, arg10, arg11);
        let v17 = 0x2::balance::value<T0>(&arg6);
        *0x1::vector::borrow_mut<u64>(&mut v14.share, 3) = *0x1::vector::borrow<u64>(&v14.share, 3) + v17;
        *0x1::vector::borrow_mut<u64>(&mut v2.share_supply, 3) = *0x1::vector::borrow<u64>(&v2.share_supply, 3) + v17;
        0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut v2.id, 0x1::ascii::string(b"deposit_balance")), arg6);
        let v18 = if (*0x1::vector::borrow<u64>(&v14.share, 1) < arg7) {
            *0x1::vector::borrow<u64>(&v14.share, 1)
        } else {
            arg7
        };
        *0x1::vector::borrow_mut<u64>(&mut v14.share, 0) = *0x1::vector::borrow<u64>(&v14.share, 0) + v18;
        *0x1::vector::borrow_mut<u64>(&mut v2.share_supply, 0) = *0x1::vector::borrow<u64>(&v2.share_supply, 0) + v18;
        *0x1::vector::borrow_mut<u64>(&mut v14.share, 1) = *0x1::vector::borrow<u64>(&v14.share, 1) - v18;
        *0x1::vector::borrow_mut<u64>(&mut v2.share_supply, 1) = *0x1::vector::borrow<u64>(&v2.share_supply, 1) - v18;
        let v19 = if (*0x1::vector::borrow<u64>(&v14.share, 2) < arg8) {
            *0x1::vector::borrow<u64>(&v14.share, 2)
        } else {
            arg8
        };
        *0x1::vector::borrow_mut<u64>(&mut v14.share, 3) = *0x1::vector::borrow<u64>(&v14.share, 3) + v19;
        *0x1::vector::borrow_mut<u64>(&mut v2.share_supply, 3) = *0x1::vector::borrow<u64>(&v2.share_supply, 3) + v19;
        *0x1::vector::borrow_mut<u64>(&mut v14.share, 2) = *0x1::vector::borrow<u64>(&v14.share, 2) - v19;
        *0x1::vector::borrow_mut<u64>(&mut v2.share_supply, 2) = *0x1::vector::borrow<u64>(&v2.share_supply, 2) - v19;
        let v20 = 0;
        if (arg9 > 0) {
            let v21 = 0x1::type_name::get<T0>();
            let (v22, v23) = 0x1::vector::index_of<0x1::type_name::TypeName>(&v2.reward_tokens, &v21);
            if (v22) {
                let v24 = if (*0x1::vector::borrow<u64>(&v14.share, v23 + 5) < arg9) {
                    *0x1::vector::borrow<u64>(&v14.share, v23 + 5)
                } else {
                    arg9
                };
                v20 = v24;
                *0x1::vector::borrow_mut<u64>(&mut v14.share, 3) = *0x1::vector::borrow<u64>(&v14.share, 3) + v24;
                *0x1::vector::borrow_mut<u64>(&mut v2.share_supply, 3) = *0x1::vector::borrow<u64>(&v2.share_supply, 3) + v24;
                *0x1::vector::borrow_mut<u64>(&mut v14.share, v23 + 5) = *0x1::vector::borrow<u64>(&v14.share, v23 + 5) - v24;
                *0x1::vector::borrow_mut<u64>(&mut v2.share_supply, v23 + 5) = *0x1::vector::borrow<u64>(&v2.share_supply, v23 + 5) - v24;
                0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut v2.id, 0x1::ascii::string(b"deposit_balance")), 0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v2.id, 0x1::type_name::get<T0>()), v24));
            };
        };
        *0x1::vector::borrow_mut<u64>(&mut v14.u64_padding, 0) = ((((*0x1::vector::borrow<u64>(&v14.share, 0) + *0x1::vector::borrow<u64>(&v14.share, 3)) as u128) * (*0x1::vector::borrow<u64>(&v2.info, 6) as u128) / (10000000 as u128) / (0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::utility::multiplier(*0x1::vector::borrow<u64>(&v2.info, 9)) as u128)) as u64);
        let v25 = v17 + v18 + v19 + v20;
        assert!(v25 > 0, zero_value(arg5));
        assert!(v20 != 0 || v25 >= *0x1::vector::borrow<u64>(&v2.config, 1) && v25 % *0x1::vector::borrow<u64>(&v2.config, 1) == 0, lot_size_violation(arg5));
        assert!(v20 != 0 || v25 >= *0x1::vector::borrow<u64>(&v2.config, 2), min_size_violation(arg5));
        assert!(*0x1::vector::borrow<u64>(&v2.share_supply, 3) + *0x1::vector::borrow<u64>(&v2.share_supply, 0) <= *0x1::vector::borrow<u64>(&v2.config, 0), capacity_violation(arg5));
        let v26 = 0x1::vector::empty<u64>();
        let v27 = &mut v26;
        0x1::vector::push_back<u64>(v27, arg5);
        0x1::vector::push_back<u64>(v27, *0x1::vector::borrow<u64>(&v2.info, 1));
        0x1::vector::push_back<u64>(v27, v17);
        0x1::vector::push_back<u64>(v27, v18);
        0x1::vector::push_back<u64>(v27, v19);
        0x1::vector::push_back<u64>(v27, v20);
        0x1::vector::push_back<u64>(v27, v16);
        let v28 = 0x1::type_name::get<T0>();
        let v29 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v29, 0x1::bcs::to_bytes<0x1::type_name::TypeName>(&v28));
        let v30 = UserEvent{
            action      : 0x1::ascii::string(b"raise_fund"),
            log         : v26,
            bcs_padding : v29,
        };
        0x2::event::emit<UserEvent>(v30);
        0x2::dynamic_field::add<0x1::ascii::String, 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::ManagerCap>(&mut arg4.id, 0x1::ascii::string(b"typus_manager_cap"), v1);
    }

    public fun reduce_fund<T0>(arg0: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg1: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::leaderboard::TypusLeaderboardRegistry, arg2: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::user::TypusUserRegistry, arg3: &0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::version::Version, arg4: &mut Registry, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        deprecated();
        abort 0
    }

    public fun reduce_fund_v2<T0>(arg0: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg1: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::leaderboard::TypusLeaderboardRegistry, arg2: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::user::TypusUserRegistry, arg3: &mut 0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::version::Version, arg4: &mut Registry, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: 0x2::coin::Coin<0x2::sui::SUI>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::version::version_check(arg3);
        assert!(!arg4.transaction_suspended, transaction_suspended(arg5));
        let v0 = 0x2::clock::timestamp_ms(arg10);
        let v1 = 0x2::dynamic_field::remove<0x1::ascii::String, 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::ManagerCap>(&mut arg4.id, 0x1::ascii::string(b"typus_manager_cap"));
        let v2 = 0x2::dynamic_object_field::borrow_mut<u64, Vault>(&mut arg4.id, arg5);
        let v3 = if (arg6 == 0) {
            if (arg7 == 0) {
                arg8 > 0
            } else {
                false
            }
        } else {
            false
        };
        if (v3) {
            assert!(0x2::coin::value<0x2::sui::SUI>(&arg9) == 0, invalid_fee_amount(arg5));
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg9);
        } else {
            assert!(0x2::coin::value<0x2::sui::SUI>(&arg9) == *0x1::vector::borrow<u64>(&v2.config, 11), invalid_fee_amount(arg5));
            0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::version::charge_fee<0x2::sui::SUI>(arg3, 0x2::coin::into_balance<0x2::sui::SUI>(arg9));
        };
        let v4 = 0x2::tx_context::sender(arg11);
        let v5 = 0x2::balance::zero<T0>();
        let v6 = 0;
        let v7 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::length(&v2.share);
        if (v7 > 0) {
            let v8 = (0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::slice_size(&v2.share) as u64);
            let v9 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_slice<Share>(&v2.share, 0);
            while (v6 < v7) {
                if (0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_from_slice<Share>(v9, v6 % v8).user == v4) {
                    break
                };
                if (v6 + 1 < v7 && (v6 + 1) % v8 == 0) {
                    let v10 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::get_slice_idx<Share>(v9) + 1;
                    v9 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_slice<Share>(&v2.share, v10);
                };
                v6 = v6 + 1;
            };
        };
        assert!(v6 < v7, user_share_not_found(arg5));
        let v11 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_mut<Share>(&mut v2.share, v6);
        let v12 = (((*0x1::vector::borrow<u64>(&v11.u64_padding, 0) as u256) * ((v0 - *0x1::vector::borrow<u64>(&v11.u64_padding, 1)) as u256) * (*0x1::vector::borrow<u64>(&v2.config, 5) as u256) / 3600000 / (10000 as u256)) as u64);
        let v13 = (((*0x1::vector::borrow<u64>(&v11.u64_padding, 0) as u256) * ((v0 - *0x1::vector::borrow<u64>(&v11.u64_padding, 1)) as u256) * (*0x1::vector::borrow<u64>(&v2.config, 8) as u256) / 3600000 / (10000 as u256)) as u64);
        *0x1::vector::borrow_mut<u64>(&mut v11.u64_padding, 1) = v0;
        0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::user::add_tails_exp_amount(&v1, arg0, arg2, v4, v12);
        0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::leaderboard::score(&v1, arg0, arg1, 0x1::ascii::string(b"depositor_program"), v4, v13, arg10, arg11);
        let v14 = if (*0x1::vector::borrow<u64>(&v11.share, 3) < arg6) {
            *0x1::vector::borrow<u64>(&v11.share, 3)
        } else {
            arg6
        };
        *0x1::vector::borrow_mut<u64>(&mut v11.share, 3) = *0x1::vector::borrow<u64>(&v11.share, 3) - v14;
        *0x1::vector::borrow_mut<u64>(&mut v2.share_supply, 3) = *0x1::vector::borrow<u64>(&v2.share_supply, 3) - v14;
        0x2::balance::join<T0>(&mut v5, 0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut v2.id, 0x1::ascii::string(b"deposit_balance")), v14));
        let v15 = if (*0x1::vector::borrow<u64>(&v11.share, 0) < arg7) {
            *0x1::vector::borrow<u64>(&v11.share, 0)
        } else {
            arg7
        };
        *0x1::vector::borrow_mut<u64>(&mut v11.share, 0) = *0x1::vector::borrow<u64>(&v11.share, 0) - v15;
        *0x1::vector::borrow_mut<u64>(&mut v2.share_supply, 0) = *0x1::vector::borrow<u64>(&v2.share_supply, 0) - v15;
        *0x1::vector::borrow_mut<u64>(&mut v11.share, 1) = *0x1::vector::borrow<u64>(&v11.share, 1) + v15;
        *0x1::vector::borrow_mut<u64>(&mut v2.share_supply, 1) = *0x1::vector::borrow<u64>(&v2.share_supply, 1) + v15;
        let v16 = if (*0x1::vector::borrow<u64>(&v11.share, 2) < arg8) {
            *0x1::vector::borrow<u64>(&v11.share, 2)
        } else {
            arg8
        };
        *0x1::vector::borrow_mut<u64>(&mut v11.share, 2) = *0x1::vector::borrow<u64>(&v11.share, 2) - v16;
        *0x1::vector::borrow_mut<u64>(&mut v2.share_supply, 2) = *0x1::vector::borrow<u64>(&v2.share_supply, 2) - v16;
        0x2::balance::join<T0>(&mut v5, 0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut v2.id, 0x1::ascii::string(b"deposit_balance")), v16));
        *0x1::vector::borrow_mut<u64>(&mut v11.u64_padding, 0) = ((((*0x1::vector::borrow<u64>(&v11.share, 0) + *0x1::vector::borrow<u64>(&v11.share, 3)) as u128) * (*0x1::vector::borrow<u64>(&v2.info, 6) as u128) / (10000000 as u128) / (0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::utility::multiplier(*0x1::vector::borrow<u64>(&v2.info, 9)) as u128)) as u64);
        assert!(v14 + v15 + v16 > 0, zero_value(arg5));
        if (is_empty(v11)) {
            0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::swap_remove<Share>(&mut v2.share, v6);
        };
        let v17 = (((0x2::balance::value<T0>(&v5) as u128) * (*0x1::vector::borrow<u64>(&v2.config, 10) as u128) / (10000 as u128)) as u64);
        0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::version::charge_fee<T0>(arg3, 0x2::balance::split<T0>(&mut v5, v17));
        let v18 = 0x1::vector::empty<u64>();
        let v19 = &mut v18;
        0x1::vector::push_back<u64>(v19, arg5);
        0x1::vector::push_back<u64>(v19, *0x1::vector::borrow<u64>(&v2.info, 1));
        0x1::vector::push_back<u64>(v19, v14);
        0x1::vector::push_back<u64>(v19, v15);
        0x1::vector::push_back<u64>(v19, v16);
        0x1::vector::push_back<u64>(v19, v13);
        0x1::vector::push_back<u64>(v19, v17);
        0x1::vector::push_back<u64>(v19, *0x1::vector::borrow<u64>(&v2.config, 11));
        let v20 = 0x1::type_name::get<T0>();
        let v21 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v21, 0x1::bcs::to_bytes<0x1::type_name::TypeName>(&v20));
        let v22 = UserEvent{
            action      : 0x1::ascii::string(b"reduce_fund"),
            log         : v18,
            bcs_padding : v21,
        };
        0x2::event::emit<UserEvent>(v22);
        0x2::dynamic_field::add<0x1::ascii::String, 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::ManagerCap>(&mut arg4.id, 0x1::ascii::string(b"typus_manager_cap"), v1);
        v5
    }

    public fun refresh<T0>(arg0: &0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::version::Version, arg1: &mut Registry, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::version::verify(arg0, arg7);
        let v0 = 0x2::dynamic_object_field::borrow_mut<u64, Vault>(&mut arg1.id, arg2);
        assert!(0x2::clock::timestamp_ms(arg6) >= *0x1::vector::borrow<u64>(&v0.info, 3), not_time_yet(arg2));
        assert!(*0x1::vector::borrow<u64>(&v0.info, 4) == 0, invalid_status(arg2));
        let v1 = *0x1::vector::borrow<u64>(&v0.share_supply, 0) + *0x1::vector::borrow<u64>(&v0.share_supply, 1);
        assert!(*0x1::vector::borrow<u64>(&v0.info, 7) == 1 || v1 == 0, not_yet_incentivised(arg2));
        assert!(*0x1::vector::borrow<u64>(&v0.info, 8) == 1 || v1 == 0, not_yet_incentivised(arg2));
        assert!(*0x1::vector::borrow<u64>(&v0.share_supply, 0) + *0x1::vector::borrow<u64>(&v0.share_supply, 1) + *0x1::vector::borrow<u64>(&v0.share_supply, 2) + *0x1::vector::borrow<u64>(&v0.share_supply, 3) == 0x2::balance::value<T0>(0x2::dynamic_field::borrow<0x1::ascii::String, 0x2::balance::Balance<T0>>(&v0.id, 0x1::ascii::string(b"deposit_balance"))), contaminated_share(arg2));
        let v2 = *0x1::vector::borrow<u64>(&v0.info, 5) == 0 && *0x1::vector::borrow<u64>(&v0.config, 4) == 0;
        let v3 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::length(&v0.share);
        if (v3 > 0) {
            let v4 = (0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::slice_size(&v0.share) as u64);
            let v5 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_slice_mut<Share>(&mut v0.share, 0);
            let v6 = 0;
            while (v6 < v3) {
                let v7 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_from_slice_mut<Share>(v5, v6 % v4);
                if (v2) {
                    *0x1::vector::borrow_mut<u64>(&mut v7.share, 4) = 0;
                    *0x1::vector::borrow_mut<u64>(&mut v7.share, 2) = *0x1::vector::borrow<u64>(&v7.share, 2) + *0x1::vector::borrow<u64>(&v7.share, 0);
                    *0x1::vector::borrow_mut<u64>(&mut v7.share, 0) = 0;
                } else {
                    *0x1::vector::borrow_mut<u64>(&mut v7.share, 4) = *0x1::vector::borrow<u64>(&v7.share, 0) + *0x1::vector::borrow<u64>(&v7.share, 1);
                    *0x1::vector::borrow_mut<u64>(&mut v7.share, 0) = *0x1::vector::borrow<u64>(&v7.share, 0) + *0x1::vector::borrow<u64>(&v7.share, 3);
                    *0x1::vector::borrow_mut<u64>(&mut v7.share, 3) = 0;
                };
                *0x1::vector::borrow_mut<u64>(&mut v7.share, 2) = *0x1::vector::borrow<u64>(&v7.share, 2) + *0x1::vector::borrow<u64>(&v7.share, 1);
                *0x1::vector::borrow_mut<u64>(&mut v7.share, 1) = 0;
                if (v6 + 1 < v3 && (v6 + 1) % v4 == 0) {
                    let v8 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::get_slice_idx<Share>(v5) + 1;
                    v5 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_slice_mut<Share>(&mut v0.share, v8);
                };
                v6 = v6 + 1;
            };
        };
        *0x1::vector::borrow_mut<u64>(&mut v0.info, 3) = arg3;
        *0x1::vector::borrow_mut<u64>(&mut v0.info, 1) = *0x1::vector::borrow<u64>(&v0.info, 1) + 1;
        *0x1::vector::borrow_mut<u64>(&mut v0.info, 6) = arg4;
        *0x1::vector::borrow_mut<u64>(&mut v0.info, 10) = arg5;
        if (v2) {
            *0x1::vector::borrow_mut<u64>(&mut v0.info, 4) = 999;
        };
        let v9 = 0x1::vector::empty<u64>();
        let v10 = &mut v9;
        0x1::vector::push_back<u64>(v10, arg2);
        0x1::vector::push_back<u64>(v10, *0x1::vector::borrow<u64>(&v0.info, 1));
        0x1::vector::push_back<u64>(v10, arg3);
        0x1::vector::push_back<u64>(v10, arg4);
        0x1::vector::push_back<u64>(v10, *0x1::vector::borrow<u64>(&v0.share_supply, 0));
        0x1::vector::push_back<u64>(v10, *0x1::vector::borrow<u64>(&v0.share_supply, 1));
        0x1::vector::push_back<u64>(v10, *0x1::vector::borrow<u64>(&v0.share_supply, 2));
        0x1::vector::push_back<u64>(v10, *0x1::vector::borrow<u64>(&v0.share_supply, 3));
        let v11 = ManagerEvent{
            action      : 0x1::ascii::string(b"refresh"),
            log         : v9,
            bcs_padding : vector[],
        };
        0x2::event::emit<ManagerEvent>(v11);
        if (v2) {
            *0x1::vector::borrow_mut<u64>(&mut v0.share_supply, 4) = 0;
            *0x1::vector::borrow_mut<u64>(&mut v0.share_supply, 2) = *0x1::vector::borrow<u64>(&v0.share_supply, 2) + *0x1::vector::borrow<u64>(&v0.share_supply, 0);
            *0x1::vector::borrow_mut<u64>(&mut v0.share_supply, 0) = 0;
            *0x1::vector::borrow_mut<u64>(&mut v0.info, 7) = 1;
            *0x1::vector::borrow_mut<u64>(&mut v0.info, 8) = 1;
        } else {
            *0x1::vector::borrow_mut<u64>(&mut v0.share_supply, 4) = *0x1::vector::borrow<u64>(&v0.share_supply, 0) + *0x1::vector::borrow<u64>(&v0.share_supply, 1);
            *0x1::vector::borrow_mut<u64>(&mut v0.share_supply, 0) = *0x1::vector::borrow<u64>(&v0.share_supply, 0) + *0x1::vector::borrow<u64>(&v0.share_supply, 3);
            *0x1::vector::borrow_mut<u64>(&mut v0.share_supply, 3) = 0;
            let v12 = if (*0x1::vector::borrow<u64>(&v0.config, 6) > 0 && *0x1::vector::borrow<u64>(&v0.share_supply, 0) > 0) {
                0
            } else {
                1
            };
            *0x1::vector::borrow_mut<u64>(&mut v0.info, 7) = v12;
            let v13 = if (*0x1::vector::borrow<u64>(&v0.config, 7) > 0 && *0x1::vector::borrow<u64>(&v0.share_supply, 0) > 0) {
                0
            } else {
                1
            };
            *0x1::vector::borrow_mut<u64>(&mut v0.info, 8) = v13;
        };
        *0x1::vector::borrow_mut<u64>(&mut v0.share_supply, 2) = *0x1::vector::borrow<u64>(&v0.share_supply, 2) + *0x1::vector::borrow<u64>(&v0.share_supply, 1);
        *0x1::vector::borrow_mut<u64>(&mut v0.share_supply, 1) = 0;
    }

    public fun refund<T0>(arg0: &0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::version::Version, arg1: &mut Registry, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::version::verify(arg0, arg4);
        let v0 = 0x2::dynamic_object_field::borrow_mut<u64, Vault>(&mut arg1.id, arg2);
        let v1 = 0x2::dynamic_field::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut v0.id, 0x1::ascii::string(b"deposit_balance"));
        let v2 = vector[];
        let v3 = vector[];
        let v4 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::length(&v0.share);
        if (v4 > 0) {
            let v5 = (0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::slice_size(&v0.share) as u64);
            let v6 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_slice_mut<Share>(&mut v0.share, 0);
            let v7 = 0;
            while (v7 < v4 && arg3 > 0) {
                let v8 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_from_slice_mut<Share>(v6, v7 % v5);
                let v9 = *0x1::vector::borrow<u64>(&v8.share, 2);
                let v10 = *0x1::vector::borrow<u64>(&v8.share, 3);
                if (v9 + v10 > 0) {
                    0x1::vector::push_back<address>(&mut v2, v8.user);
                    0x1::vector::push_back<u64>(&mut v3, v9 + v10);
                    *0x1::vector::borrow_mut<u64>(&mut v8.share, 2) = 0;
                    *0x1::vector::borrow_mut<u64>(&mut v8.share, 3) = 0;
                    *0x1::vector::borrow_mut<u64>(&mut v0.share_supply, 2) = *0x1::vector::borrow_mut<u64>(&mut v0.share_supply, 2) - v9;
                    *0x1::vector::borrow_mut<u64>(&mut v0.share_supply, 3) = *0x1::vector::borrow_mut<u64>(&mut v0.share_supply, 3) - v10;
                    arg3 = arg3 - 1;
                    0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v1, v9 + v10), arg4), v8.user);
                };
                if (v7 + 1 < v4 && (v7 + 1) % v5 == 0) {
                    let v11 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::get_slice_idx<Share>(v6) + 1;
                    v6 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_slice_mut<Share>(&mut v0.share, v11);
                };
                v7 = v7 + 1;
            };
        };
        let v12 = 0x1::vector::empty<u64>();
        let v13 = &mut v12;
        0x1::vector::push_back<u64>(v13, arg2);
        0x1::vector::push_back<u64>(v13, *0x1::vector::borrow<u64>(&v0.info, 1));
        let v14 = 0x1::vector::empty<vector<u8>>();
        let v15 = &mut v14;
        0x1::vector::push_back<vector<u8>>(v15, 0x1::bcs::to_bytes<vector<address>>(&v2));
        0x1::vector::push_back<vector<u8>>(v15, 0x1::bcs::to_bytes<vector<u64>>(&v3));
        let v16 = ManagerEvent{
            action      : 0x1::ascii::string(b"refund"),
            log         : v12,
            bcs_padding : v14,
        };
        0x2::event::emit<ManagerEvent>(v16);
    }

    public(friend) fun registry_uid(arg0: &Registry) : &0x2::object::UID {
        &arg0.id
    }

    public fun remove_reward_token<T0>(arg0: &0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::version::Version, arg1: &mut Registry, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::version::verify(arg0, arg3);
        let v0 = 0x2::dynamic_object_field::borrow_mut<u64, Vault>(&mut arg1.id, arg2);
        let v1 = 0x1::type_name::get<T0>();
        let (v2, v3) = 0x1::vector::index_of<0x1::type_name::TypeName>(&v0.reward_tokens, &v1);
        assert!(v2, invalid_token(arg2));
        assert!(*0x1::vector::borrow<u64>(&v0.share_supply, v3 + 5) == 0, invalid_status(arg2));
        0x1::vector::swap_remove<0x1::type_name::TypeName>(&mut v0.reward_tokens, v3);
        0x1::vector::swap_remove<u64>(&mut v0.share_supply, v3 + 5);
        let v4 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::length(&v0.share);
        if (v4 > 0) {
            let v5 = (0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::slice_size(&v0.share) as u64);
            let v6 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_slice_mut<Share>(&mut v0.share, 0);
            let v7 = 0;
            while (v7 < v4) {
                0x1::vector::swap_remove<u64>(&mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_from_slice_mut<Share>(v6, v7 % v5).share, v3 + 5);
                if (v7 + 1 < v4 && (v7 + 1) % v5 == 0) {
                    let v8 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::get_slice_idx<Share>(v6) + 1;
                    v6 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_slice_mut<Share>(&mut v0.share, v8);
                };
                v7 = v7 + 1;
            };
        };
        0x2::balance::destroy_zero<T0>(0x2::dynamic_field::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v0.id, 0x1::type_name::get<T0>()));
        let v9 = 0x1::vector::empty<u64>();
        let v10 = &mut v9;
        0x1::vector::push_back<u64>(v10, arg2);
        0x1::vector::push_back<u64>(v10, *0x1::vector::borrow<u64>(&v0.info, 1));
        let v11 = 0x1::type_name::get<T0>();
        let v12 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v12, 0x1::bcs::to_bytes<0x1::type_name::TypeName>(&v11));
        let v13 = ManagerEvent{
            action      : 0x1::ascii::string(b"remove_reward_token"),
            log         : v9,
            bcs_padding : v12,
        };
        0x2::event::emit<ManagerEvent>(v13);
    }

    entry fun resume_transaction(arg0: &0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::version::Version, arg1: &mut Registry, arg2: &0x2::tx_context::TxContext) {
        0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::version::verify(arg0, arg2);
        arg1.transaction_suspended = false;
        let v0 = ManagerEvent{
            action      : 0x1::ascii::string(b"resume_transaction"),
            log         : vector[],
            bcs_padding : vector[],
        };
        0x2::event::emit<ManagerEvent>(v0);
    }

    public fun reward<T0>(arg0: &0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::version::Version, arg1: &mut Registry, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::version::verify(arg0, arg4);
        let v0 = 0x2::dynamic_object_field::borrow_mut<u64, Vault>(&mut arg1.id, arg2);
        let v1 = 0x1::type_name::get<T0>();
        let (v2, v3) = 0x1::vector::index_of<0x1::type_name::TypeName>(&v0.reward_tokens, &v1);
        assert!(v2, invalid_token(arg2));
        let v4 = 0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v0.id, 0x1::type_name::get<T0>());
        let v5 = vector[];
        let v6 = vector[];
        let v7 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::length(&v0.share);
        if (v7 > 0) {
            let v8 = (0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::slice_size(&v0.share) as u64);
            let v9 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_slice_mut<Share>(&mut v0.share, 0);
            let v10 = 0;
            while (v10 < v7 && arg3 > 0) {
                let v11 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_from_slice_mut<Share>(v9, v10 % v8);
                let v12 = *0x1::vector::borrow<u64>(&v11.share, v3 + 5);
                if (v12 > 0) {
                    0x1::vector::push_back<address>(&mut v5, v11.user);
                    0x1::vector::push_back<u64>(&mut v6, v12);
                    *0x1::vector::borrow_mut<u64>(&mut v11.share, v3 + 5) = 0;
                    *0x1::vector::borrow_mut<u64>(&mut v0.share_supply, v3 + 5) = *0x1::vector::borrow_mut<u64>(&mut v0.share_supply, v3 + 5) - v12;
                    arg3 = arg3 - 1;
                    0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v4, v12), arg4), v11.user);
                };
                if (v10 + 1 < v7 && (v10 + 1) % v8 == 0) {
                    let v13 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::get_slice_idx<Share>(v9) + 1;
                    v9 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_slice_mut<Share>(&mut v0.share, v13);
                };
                v10 = v10 + 1;
            };
        };
        let v14 = 0x1::vector::empty<u64>();
        let v15 = &mut v14;
        0x1::vector::push_back<u64>(v15, arg2);
        0x1::vector::push_back<u64>(v15, *0x1::vector::borrow<u64>(&v0.info, 1));
        let v16 = 0x1::vector::empty<vector<u8>>();
        let v17 = &mut v16;
        0x1::vector::push_back<vector<u8>>(v17, 0x1::bcs::to_bytes<vector<address>>(&v5));
        0x1::vector::push_back<vector<u8>>(v17, 0x1::bcs::to_bytes<vector<u64>>(&v6));
        let v18 = ManagerEvent{
            action      : 0x1::ascii::string(b"reward"),
            log         : v14,
            bcs_padding : v16,
        };
        0x2::event::emit<ManagerEvent>(v18);
    }

    public fun reward_navi<T0>(arg0: &0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::version::Version, arg1: &mut Registry, arg2: u64, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<T0>, arg5: u8, arg6: u8, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        deprecated();
        abort 0
    }

    public fun reward_navi_v2<T0>(arg0: &0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::version::Version, arg1: &Registry, arg2: u64, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::RewardFund<T0>, arg5: vector<0x1::ascii::String>, arg6: vector<address>, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::version::verify(arg0, arg9);
        let v0 = 0x2::dynamic_object_field::borrow<u64, Vault>(&arg1.id, arg2);
        assert!(*0x1::vector::borrow<u64>(&v0.info, 4) == 4, invalid_status(arg2));
        let v1 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::claim_reward_with_account_cap<T0>(arg8, arg7, arg3, arg4, arg5, arg6, 0x2::dynamic_object_field::borrow<0x1::ascii::String, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(&v0.id, 0x1::ascii::string(b"navi_account_cap")));
        let v2 = 0x1::vector::empty<u64>();
        let v3 = &mut v2;
        0x1::vector::push_back<u64>(v3, arg2);
        0x1::vector::push_back<u64>(v3, *0x1::vector::borrow<u64>(&v0.info, 1));
        0x1::vector::push_back<u64>(v3, 0x2::balance::value<T0>(&v1));
        let v4 = ManagerEvent{
            action      : 0x1::ascii::string(b"reward_navi"),
            log         : v2,
            bcs_padding : vector[],
        };
        0x2::event::emit<ManagerEvent>(v4);
        v1
    }

    public fun reward_suilend<T0>(arg0: &0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::version::Version, arg1: &mut Registry, arg2: u64, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::version::verify(arg0, arg7);
        let v0 = 0x2::dynamic_object_field::borrow_mut<u64, Vault>(&mut arg1.id, arg2);
        assert!(*0x1::vector::borrow<u64>(&v0.info, 4) == 3, invalid_status(arg2));
        let v1 = 0x2::dynamic_object_field::remove<0x1::ascii::String, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>>(&mut v0.id, 0x1::ascii::string(b"suilend_obligation_owner_cap"));
        let v2 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::claim_rewards<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg3, &v1, arg6, arg4, arg5, true, arg7);
        0x2::dynamic_object_field::add<0x1::ascii::String, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>>(&mut v0.id, 0x1::ascii::string(b"suilend_obligation_owner_cap"), v1);
        let v3 = 0x1::vector::empty<u64>();
        let v4 = &mut v3;
        0x1::vector::push_back<u64>(v4, arg2);
        0x1::vector::push_back<u64>(v4, *0x1::vector::borrow<u64>(&v0.info, 1));
        0x1::vector::push_back<u64>(v4, 0x2::coin::value<T0>(&v2));
        let v5 = ManagerEvent{
            action      : 0x1::ascii::string(b"reward_suilend"),
            log         : v3,
            bcs_padding : vector[],
        };
        0x2::event::emit<ManagerEvent>(v5);
        0x2::coin::into_balance<T0>(v2)
    }

    public fun set_incentivise<T0>(arg0: &0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::version::Version, arg1: &mut Registry, arg2: u64, arg3: 0x2::balance::Balance<T0>, arg4: bool, arg5: vector<u64>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::version::verify(arg0, arg6);
        let v0 = 0x2::dynamic_object_field::borrow_mut<u64, Vault>(&mut arg1.id, arg2);
        if (arg4) {
            assert!(*0x1::vector::borrow<u64>(&v0.info, 8) == 0, already_incentivised(arg2));
            *0x1::vector::borrow_mut<u64>(&mut v0.info, 8) = 1;
        } else {
            assert!(*0x1::vector::borrow<u64>(&v0.info, 7) == 0, already_incentivised(arg2));
            *0x1::vector::borrow_mut<u64>(&mut v0.info, 7) = 1;
        };
        let v1 = 0x1::ascii::string(b"set_incentivise");
        let v2 = if (arg4) {
            0x1::ascii::string(b"_fixed")
        } else {
            0x1::ascii::string(b"_bp")
        };
        0x1::ascii::append(&mut v1, v2);
        let v3 = 0x1::vector::empty<u64>();
        let v4 = &mut v3;
        0x1::vector::push_back<u64>(v4, arg2);
        0x1::vector::push_back<u64>(v4, *0x1::vector::borrow<u64>(&v0.info, 1));
        0x1::vector::push_back<u64>(v4, 0x2::balance::value<T0>(&arg3));
        0x1::vector::append<u64>(&mut v3, arg5);
        let v5 = ManagerEvent{
            action      : v1,
            log         : v3,
            bcs_padding : vector[],
        };
        0x2::event::emit<ManagerEvent>(v5);
        arg3
    }

    public fun set_reward_token<T0>(arg0: &0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::version::Version, arg1: &mut Registry, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::version::verify(arg0, arg3);
        let v0 = 0x2::dynamic_object_field::borrow_mut<u64, Vault>(&mut arg1.id, arg2);
        let v1 = 0x1::type_name::get<T0>();
        let (v2, _) = 0x1::vector::index_of<0x1::type_name::TypeName>(&v0.reward_tokens, &v1);
        assert!(!v2, invalid_token(arg2));
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut v0.reward_tokens, 0x1::type_name::get<T0>());
        0x1::vector::push_back<u64>(&mut v0.share_supply, 0);
        let v4 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::length(&v0.share);
        if (v4 > 0) {
            let v5 = (0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::slice_size(&v0.share) as u64);
            let v6 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_slice_mut<Share>(&mut v0.share, 0);
            let v7 = 0;
            while (v7 < v4) {
                0x1::vector::push_back<u64>(&mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_from_slice_mut<Share>(v6, v7 % v5).share, 0);
                if (v7 + 1 < v4 && (v7 + 1) % v5 == 0) {
                    let v8 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::get_slice_idx<Share>(v6) + 1;
                    v6 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_slice_mut<Share>(&mut v0.share, v8);
                };
                v7 = v7 + 1;
            };
        };
        0x2::dynamic_field::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v0.id, 0x1::type_name::get<T0>(), 0x2::balance::zero<T0>());
        let v9 = 0x1::vector::empty<u64>();
        let v10 = &mut v9;
        0x1::vector::push_back<u64>(v10, arg2);
        0x1::vector::push_back<u64>(v10, *0x1::vector::borrow<u64>(&v0.info, 1));
        let v11 = 0x1::type_name::get<T0>();
        let v12 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v12, 0x1::bcs::to_bytes<0x1::type_name::TypeName>(&v11));
        let v13 = ManagerEvent{
            action      : 0x1::ascii::string(b"set_reward_token"),
            log         : v9,
            bcs_padding : v12,
        };
        0x2::event::emit<ManagerEvent>(v13);
    }

    public fun snapshot(arg0: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg1: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::leaderboard::TypusLeaderboardRegistry, arg2: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::user::TypusUserRegistry, arg3: &0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::version::Version, arg4: &mut Registry, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::version::version_check(arg3);
        assert!(!arg4.transaction_suspended, transaction_suspended(arg5));
        let v0 = 0x2::clock::timestamp_ms(arg6);
        let v1 = 0x2::dynamic_field::remove<0x1::ascii::String, 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::ManagerCap>(&mut arg4.id, 0x1::ascii::string(b"typus_manager_cap"));
        let v2 = 0x2::dynamic_object_field::borrow_mut<u64, Vault>(&mut arg4.id, arg5);
        let v3 = 0x2::tx_context::sender(arg7);
        let v4 = 0;
        let v5 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::length(&v2.share);
        if (v5 > 0) {
            let v6 = (0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::slice_size(&v2.share) as u64);
            let v7 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_slice<Share>(&v2.share, 0);
            while (v4 < v5) {
                if (0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_from_slice<Share>(v7, v4 % v6).user == v3) {
                    break
                };
                if (v4 + 1 < v5 && (v4 + 1) % v6 == 0) {
                    let v8 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::get_slice_idx<Share>(v7) + 1;
                    v7 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_slice<Share>(&v2.share, v8);
                };
                v4 = v4 + 1;
            };
        };
        if (v4 == v5) {
            0x2::dynamic_field::add<0x1::ascii::String, 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::ManagerCap>(&mut arg4.id, 0x1::ascii::string(b"typus_manager_cap"), v1);
            return
        };
        let v9 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_mut<Share>(&mut v2.share, v4);
        let v10 = (((*0x1::vector::borrow<u64>(&v9.u64_padding, 0) as u256) * ((v0 - *0x1::vector::borrow<u64>(&v9.u64_padding, 1)) as u256) * (*0x1::vector::borrow<u64>(&v2.config, 5) as u256) / 3600000 / (10000 as u256)) as u64);
        let v11 = (((*0x1::vector::borrow<u64>(&v9.u64_padding, 0) as u256) * ((v0 - *0x1::vector::borrow<u64>(&v9.u64_padding, 1)) as u256) * (*0x1::vector::borrow<u64>(&v2.config, 8) as u256) / 3600000 / (10000 as u256)) as u64);
        *0x1::vector::borrow_mut<u64>(&mut v9.u64_padding, 1) = v0;
        0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::user::add_tails_exp_amount(&v1, arg0, arg2, v3, v10);
        0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::leaderboard::score(&v1, arg0, arg1, 0x1::ascii::string(b"depositor_program"), v3, v11, arg6, arg7);
        *0x1::vector::borrow_mut<u64>(&mut v9.u64_padding, 0) = ((((*0x1::vector::borrow<u64>(&v9.share, 0) + *0x1::vector::borrow<u64>(&v9.share, 3)) as u128) * (*0x1::vector::borrow<u64>(&v2.info, 6) as u128) / (10000000 as u128) / (0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::utility::multiplier(*0x1::vector::borrow<u64>(&v2.info, 9)) as u128)) as u64);
        let v12 = 0x1::vector::empty<u64>();
        let v13 = &mut v12;
        0x1::vector::push_back<u64>(v13, arg5);
        0x1::vector::push_back<u64>(v13, *0x1::vector::borrow<u64>(&v2.info, 1));
        0x1::vector::push_back<u64>(v13, v11);
        let v14 = UserEvent{
            action      : 0x1::ascii::string(b"snapshot"),
            log         : v12,
            bcs_padding : vector[],
        };
        0x2::event::emit<UserEvent>(v14);
        0x2::dynamic_field::add<0x1::ascii::String, 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::ManagerCap>(&mut arg4.id, 0x1::ascii::string(b"typus_manager_cap"), v1);
    }

    entry fun suspend_transaction(arg0: &0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::version::Version, arg1: &mut Registry, arg2: &0x2::tx_context::TxContext) {
        0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::version::verify(arg0, arg2);
        arg1.transaction_suspended = true;
        let v0 = ManagerEvent{
            action      : 0x1::ascii::string(b"suspend_transaction"),
            log         : vector[],
            bcs_padding : vector[],
        };
        0x2::event::emit<ManagerEvent>(v0);
    }

    fun swap_<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: bool, arg5: bool, arg6: u64, arg7: u128, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, T1>(arg1, arg4, arg5, arg6);
        if (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v0) == 0) {
            (arg2, arg3)
        } else {
            let (v3, v4) = 0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::utility::swap<T0, T1>(arg0, arg1, 0x2::coin::from_balance<T0>(arg2, arg9), 0x2::coin::from_balance<T1>(arg3, arg9), arg4, arg5, arg6, arg7, arg8, arg9);
            (0x2::coin::into_balance<T0>(v3), 0x2::coin::into_balance<T1>(v4))
        }
    }

    fun transaction_suspended(arg0: u64) : u64 {
        abort arg0
    }

    entry fun update_vault_config(arg0: &0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::version::Version, arg1: &mut Registry, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::version::verify(arg0, arg5);
        let v0 = 0x2::dynamic_object_field::borrow_mut<u64, Vault>(&mut arg1.id, arg2);
        while (0x1::vector::length<u64>(&v0.config) < arg3 + 1) {
            0x1::vector::push_back<u64>(&mut v0.config, 0);
        };
        let v1 = 0x1::vector::empty<u64>();
        let v2 = &mut v1;
        0x1::vector::push_back<u64>(v2, arg2);
        0x1::vector::push_back<u64>(v2, *0x1::vector::borrow<u64>(&v0.info, 1));
        0x1::vector::push_back<u64>(v2, arg3);
        0x1::vector::push_back<u64>(v2, *0x1::vector::borrow<u64>(&v0.config, arg3));
        0x1::vector::push_back<u64>(v2, arg4);
        let v3 = ManagerEvent{
            action      : 0x1::ascii::string(b"update_vault_config"),
            log         : v1,
            bcs_padding : vector[],
        };
        0x2::event::emit<ManagerEvent>(v3);
        *0x1::vector::borrow_mut<u64>(&mut v0.config, arg3) = arg4;
        if (arg3 == 6) {
            if (arg4 > 0) {
                *0x1::vector::borrow_mut<u64>(&mut v0.info, 7) = 0;
            } else {
                *0x1::vector::borrow_mut<u64>(&mut v0.info, 7) = 1;
            };
        };
        if (arg3 == 7) {
            if (arg4 > 0) {
                *0x1::vector::borrow_mut<u64>(&mut v0.info, 8) = 0;
            } else {
                *0x1::vector::borrow_mut<u64>(&mut v0.info, 8) = 1;
            };
        };
    }

    entry fun update_vault_info(arg0: &0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::version::Version, arg1: &mut Registry, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::version::verify(arg0, arg5);
        let v0 = 0x2::dynamic_object_field::borrow_mut<u64, Vault>(&mut arg1.id, arg2);
        while (0x1::vector::length<u64>(&v0.info) < arg3 + 1) {
            0x1::vector::push_back<u64>(&mut v0.info, 0);
        };
        let v1 = 0x1::vector::empty<u64>();
        let v2 = &mut v1;
        0x1::vector::push_back<u64>(v2, arg2);
        0x1::vector::push_back<u64>(v2, *0x1::vector::borrow<u64>(&v0.info, 1));
        0x1::vector::push_back<u64>(v2, arg3);
        0x1::vector::push_back<u64>(v2, *0x1::vector::borrow<u64>(&v0.info, arg3));
        0x1::vector::push_back<u64>(v2, arg4);
        let v3 = ManagerEvent{
            action      : 0x1::ascii::string(b"update_vault_info"),
            log         : v1,
            bcs_padding : vector[],
        };
        0x2::event::emit<ManagerEvent>(v3);
        *0x1::vector::borrow_mut<u64>(&mut v0.info, arg3) = arg4;
    }

    fun user_share_not_found(arg0: u64) : u64 {
        abort arg0
    }

    public(friend) fun vault_uid(arg0: &Vault) : &0x2::object::UID {
        &arg0.id
    }

    public fun withdraw_navi<T0>(arg0: &0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::version::Version, arg1: &mut Registry, arg2: u64, arg3: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg4: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg5: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: address, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg10: u8, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        deprecated();
        abort 0
    }

    public fun withdraw_navi_v2<T0>(arg0: &0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::version::Version, arg1: &mut Registry, arg2: u64, arg3: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::config::OracleConfig, arg4: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg5: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: address, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg10: u8, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::version::verify(arg0, arg14);
        let v0 = 0x2::dynamic_object_field::borrow_mut<u64, Vault>(&mut arg1.id, arg2);
        assert!(*0x1::vector::borrow<u64>(&v0.info, 4) == 4, invalid_status(arg2));
        *0x1::vector::borrow_mut<u64>(&mut v0.info, 4) = 0;
        0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle_pro::update_single_price(arg13, arg3, arg4, arg5, arg6, arg7);
        let v1 = 0x2::dynamic_object_field::remove<0x1::ascii::String, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(&mut v0.id, 0x1::ascii::string(b"navi_account_cap"));
        let v2 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::withdraw_with_account_cap<T0>(arg13, arg4, arg8, arg9, arg10, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::unnormal_amount<T0>(arg9, (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_collateral_balance(arg8, arg10, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&v1)) as u64)) + 1, arg11, arg12, &v1);
        0x2::dynamic_object_field::add<0x1::ascii::String, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap>(&mut v0.id, 0x1::ascii::string(b"navi_account_cap"), v1);
        let v3 = 0x2::balance::value<T0>(&v2);
        let v4 = *0x1::vector::borrow<u64>(&v0.share_supply, 0) + *0x1::vector::borrow<u64>(&v0.share_supply, 1);
        if (v3 < v4) {
            0x2::balance::join<T0>(&mut v2, 0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut v0.id, 0x1::ascii::string(b"mist_balance")), 1));
        };
        0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut v0.id, 0x1::ascii::string(b"deposit_balance")), 0x2::balance::split<T0>(&mut v2, v4));
        if (0x2::balance::value<T0>(&v2) > 0 && 0x2::balance::value<T0>(0x2::dynamic_field::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut v0.id, 0x1::ascii::string(b"mist_balance"))) == 0) {
            0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut v0.id, 0x1::ascii::string(b"mist_balance")), 0x2::balance::split<T0>(&mut v2, 1));
        };
        let v5 = 0x1::vector::empty<u64>();
        let v6 = &mut v5;
        0x1::vector::push_back<u64>(v6, arg2);
        0x1::vector::push_back<u64>(v6, *0x1::vector::borrow<u64>(&v0.info, 1));
        0x1::vector::push_back<u64>(v6, v4);
        0x1::vector::push_back<u64>(v6, v3);
        let v7 = ManagerEvent{
            action      : 0x1::ascii::string(b"withdraw_navi"),
            log         : v5,
            bcs_padding : vector[],
        };
        0x2::event::emit<ManagerEvent>(v7);
        v2
    }

    public fun withdraw_scallop_basic<T0>(arg0: &0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::version::Version, arg1: &mut Registry, arg2: u64, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::version::verify(arg0, arg6);
        let v0 = 0x2::dynamic_object_field::borrow_mut<u64, Vault>(&mut arg1.id, arg2);
        assert!(*0x1::vector::borrow<u64>(&v0.info, 4) == 2, invalid_status(arg2));
        *0x1::vector::borrow_mut<u64>(&mut v0.info, 4) = 0;
        let v1 = 0x2::coin::into_balance<T0>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<T0>(arg3, arg4, 0x2::dynamic_object_field::remove<0x1::ascii::String, 0x2::coin::Coin<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(&mut v0.id, 0x1::ascii::string(b"scallop_market_coin")), arg5, arg6));
        let v2 = 0x2::balance::value<T0>(&v1);
        let v3 = *0x1::vector::borrow<u64>(&v0.share_supply, 0) + *0x1::vector::borrow<u64>(&v0.share_supply, 1);
        if (v2 < v3) {
            0x2::balance::join<T0>(&mut v1, 0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut v0.id, 0x1::ascii::string(b"mist_balance")), 1));
        };
        0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut v0.id, 0x1::ascii::string(b"deposit_balance")), 0x2::balance::split<T0>(&mut v1, v3));
        if (0x2::balance::value<T0>(&v1) > 0 && 0x2::balance::value<T0>(0x2::dynamic_field::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut v0.id, 0x1::ascii::string(b"mist_balance"))) == 0) {
            0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut v0.id, 0x1::ascii::string(b"mist_balance")), 0x2::balance::split<T0>(&mut v1, 1));
        };
        let v4 = 0x1::vector::empty<u64>();
        let v5 = &mut v4;
        0x1::vector::push_back<u64>(v5, arg2);
        0x1::vector::push_back<u64>(v5, *0x1::vector::borrow<u64>(&v0.info, 1));
        0x1::vector::push_back<u64>(v5, v3);
        0x1::vector::push_back<u64>(v5, v2);
        let v6 = ManagerEvent{
            action      : 0x1::ascii::string(b"withdraw_scallop_basic"),
            log         : v4,
            bcs_padding : vector[],
        };
        0x2::event::emit<ManagerEvent>(v6);
        v1
    }

    public fun withdraw_scallop_spool<T0, T1>(arg0: &0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::version::Version, arg1: &mut Registry, arg2: u64, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg6: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::rewards_pool::RewardsPool<T1>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::version::verify(arg0, arg8);
        let v0 = 0x2::dynamic_object_field::borrow_mut<u64, Vault>(&mut arg1.id, arg2);
        assert!(*0x1::vector::borrow<u64>(&v0.info, 4) == 1, invalid_status(arg2));
        *0x1::vector::borrow_mut<u64>(&mut v0.info, 4) = 0;
        let v1 = 0x2::dynamic_object_field::remove<0x1::ascii::String, 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::SpoolAccount<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(&mut v0.id, 0x1::ascii::string(b"scallop_spool_account"));
        let v2 = 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::stake_amount<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&v1);
        if (v2 == 0) {
            0x2::dynamic_object_field::add<0x1::ascii::String, 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::SpoolAccount<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(&mut v0.id, 0x1::ascii::string(b"scallop_spool_account"), v1);
            return (0x2::balance::zero<T0>(), 0x2::balance::zero<T1>())
        };
        let v3 = 0x2::coin::into_balance<T1>(0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::user::redeem_rewards<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>, T1>(arg5, arg6, &mut v1, arg7, arg8));
        let v4 = 0x2::coin::into_balance<T0>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<T0>(arg3, arg4, 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::user::unstake<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(arg5, &mut v1, v2, arg7, arg8), arg7, arg8));
        0x2::dynamic_object_field::add<0x1::ascii::String, 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::SpoolAccount<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(&mut v0.id, 0x1::ascii::string(b"scallop_spool_account"), v1);
        let v5 = 0x2::balance::value<T0>(&v4);
        let v6 = *0x1::vector::borrow<u64>(&v0.share_supply, 0) + *0x1::vector::borrow<u64>(&v0.share_supply, 1);
        if (v5 < v6) {
            0x2::balance::join<T0>(&mut v4, 0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut v0.id, 0x1::ascii::string(b"mist_balance")), 1));
        };
        0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut v0.id, 0x1::ascii::string(b"deposit_balance")), 0x2::balance::split<T0>(&mut v4, v6));
        if (0x2::balance::value<T0>(&v4) > 0 && 0x2::balance::value<T0>(0x2::dynamic_field::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut v0.id, 0x1::ascii::string(b"mist_balance"))) == 0) {
            0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut v0.id, 0x1::ascii::string(b"mist_balance")), 0x2::balance::split<T0>(&mut v4, 1));
        };
        let v7 = 0x1::vector::empty<u64>();
        let v8 = &mut v7;
        0x1::vector::push_back<u64>(v8, arg2);
        0x1::vector::push_back<u64>(v8, *0x1::vector::borrow<u64>(&v0.info, 1));
        0x1::vector::push_back<u64>(v8, v6);
        0x1::vector::push_back<u64>(v8, v5);
        0x1::vector::push_back<u64>(v8, 0x2::balance::value<T1>(&v3));
        let v9 = ManagerEvent{
            action      : 0x1::ascii::string(b"withdraw_scallop_spool"),
            log         : v7,
            bcs_padding : vector[],
        };
        0x2::event::emit<ManagerEvent>(v9);
        (v4, v3)
    }

    public fun withdraw_suilend<T0>(arg0: &0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::version::Version, arg1: &mut Registry, arg2: u64, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0xa7bedeaa28ff3defa50d012812618178727f530bc5a70af5d03fc6424a984cc7::version::verify(arg0, arg6);
        let v0 = 0x2::dynamic_object_field::borrow_mut<u64, Vault>(&mut arg1.id, arg2);
        assert!(*0x1::vector::borrow<u64>(&v0.info, 4) == 3, invalid_status(arg2));
        *0x1::vector::borrow_mut<u64>(&mut v0.info, 4) = 0;
        let v1 = 0x2::dynamic_object_field::remove<0x1::ascii::String, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>>(&mut v0.id, 0x1::ascii::string(b"suilend_obligation_owner_cap"));
        let v2 = 0x2::coin::into_balance<T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg3, arg4, arg5, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::withdraw_ctokens<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg3, arg4, &v1, arg5, 18446744073709551615, arg6), 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>>(), arg6));
        0x2::dynamic_object_field::add<0x1::ascii::String, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>>(&mut v0.id, 0x1::ascii::string(b"suilend_obligation_owner_cap"), v1);
        let v3 = 0x2::balance::value<T0>(&v2);
        let v4 = *0x1::vector::borrow<u64>(&v0.share_supply, 0) + *0x1::vector::borrow<u64>(&v0.share_supply, 1);
        if (v3 < v4) {
            0x2::balance::join<T0>(&mut v2, 0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut v0.id, 0x1::ascii::string(b"mist_balance")), 1));
        };
        0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut v0.id, 0x1::ascii::string(b"deposit_balance")), 0x2::balance::split<T0>(&mut v2, v4));
        if (0x2::balance::value<T0>(&v2) > 0 && 0x2::balance::value<T0>(0x2::dynamic_field::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut v0.id, 0x1::ascii::string(b"mist_balance"))) == 0) {
            0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut v0.id, 0x1::ascii::string(b"mist_balance")), 0x2::balance::split<T0>(&mut v2, 1));
        };
        let v5 = 0x1::vector::empty<u64>();
        let v6 = &mut v5;
        0x1::vector::push_back<u64>(v6, arg2);
        0x1::vector::push_back<u64>(v6, *0x1::vector::borrow<u64>(&v0.info, 1));
        0x1::vector::push_back<u64>(v6, v4);
        0x1::vector::push_back<u64>(v6, v3);
        let v7 = ManagerEvent{
            action      : 0x1::ascii::string(b"withdraw_suilend"),
            log         : v5,
            bcs_padding : vector[],
        };
        0x2::event::emit<ManagerEvent>(v7);
        v2
    }

    fun zero_value(arg0: u64) : u64 {
        abort arg0
    }

    // decompiled from Move bytecode v6
}

