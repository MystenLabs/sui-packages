module 0x8e4f745b9c0748d24d3c4248658a385822c5ae6c38dba4d8739ad2389a14529f::safu {
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

    struct Share has copy, drop, store {
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

    public fun swap<T0, T1>(arg0: &mut 0x8e4f745b9c0748d24d3c4248658a385822c5ae6c38dba4d8739ad2389a14529f::version::Version, arg1: &Registry, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: u64, arg5: 0x2::coin::Coin<T0>, arg6: 0x2::coin::Coin<T1>, arg7: bool, arg8: u64, arg9: u128, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x8e4f745b9c0748d24d3c4248658a385822c5ae6c38dba4d8739ad2389a14529f::version::verify(arg0, arg11);
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, T1>(arg3, arg7, true, arg8);
        let (v1, v2, v3) = if (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v0) == 0) {
            if (arg7) {
                0x8e4f745b9c0748d24d3c4248658a385822c5ae6c38dba4d8739ad2389a14529f::version::charge_fee<T0>(arg0, 0x2::coin::into_balance<T0>(arg5));
                (0x2::coin::zero<T0>(arg11), arg6, 0)
            } else {
                0x8e4f745b9c0748d24d3c4248658a385822c5ae6c38dba4d8739ad2389a14529f::version::charge_fee<T1>(arg0, 0x2::coin::into_balance<T1>(arg6));
                (arg5, 0x2::coin::zero<T1>(arg11), 0)
            }
        } else {
            let (v4, v5) = 0x8e4f745b9c0748d24d3c4248658a385822c5ae6c38dba4d8739ad2389a14529f::utility::swap<T0, T1>(arg2, arg3, arg5, arg6, arg7, true, arg8, arg9, arg10, arg11);
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
        assert!(!v11, 6);
        (v7, v6)
    }

    public fun claim_reward<T0>(arg0: &0x8e4f745b9c0748d24d3c4248658a385822c5ae6c38dba4d8739ad2389a14529f::version::Version, arg1: &mut Registry, arg2: u64, arg3: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x8e4f745b9c0748d24d3c4248658a385822c5ae6c38dba4d8739ad2389a14529f::version::version_check(arg0);
        assert!(!arg1.transaction_suspended, 0);
        let v0 = 0x2::dynamic_object_field::borrow_mut<u64, Vault>(&mut arg1.id, arg2);
        let v1 = 0x1::type_name::get<T0>();
        let (v2, v3) = 0x1::vector::index_of<0x1::type_name::TypeName>(&v0.reward_tokens, &v1);
        assert!(v2, 7);
        *0x1::vector::borrow_mut<u64>(&mut v0.share_supply, v3 + 5) = 0x2::balance::value<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v0.id, 0x1::type_name::get<T0>()));
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
                    assert!(v9 > 0, 1);
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
        abort 5
    }

    public fun close(arg0: &0x8e4f745b9c0748d24d3c4248658a385822c5ae6c38dba4d8739ad2389a14529f::version::Version, arg1: &mut Registry, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x8e4f745b9c0748d24d3c4248658a385822c5ae6c38dba4d8739ad2389a14529f::version::verify(arg0, arg3);
        let v0 = 0x2::dynamic_object_field::borrow_mut<u64, Vault>(&mut arg1.id, arg2);
        assert!(*0x1::vector::borrow<u64>(&v0.info, 10) == 0, 13);
        *0x1::vector::borrow_mut<u64>(&mut v0.info, 10) = 1;
    }

    public fun deposit_scallop_basic<T0>(arg0: &0x8e4f745b9c0748d24d3c4248658a385822c5ae6c38dba4d8739ad2389a14529f::version::Version, arg1: &mut Registry, arg2: u64, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x8e4f745b9c0748d24d3c4248658a385822c5ae6c38dba4d8739ad2389a14529f::version::verify(arg0, arg6);
        let v0 = 0x2::dynamic_object_field::borrow_mut<u64, Vault>(&mut arg1.id, arg2);
        assert!(*0x1::vector::borrow<u64>(&v0.info, 5) == 1, 10);
        assert!(0x2::clock::timestamp_ms(arg5) < *0x1::vector::borrow<u64>(&v0.info, 3), 9);
        assert!(*0x1::vector::borrow<u64>(&v0.info, 4) == 0, 8);
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

    public fun deposit_scallop_spool<T0>(arg0: &0x8e4f745b9c0748d24d3c4248658a385822c5ae6c38dba4d8739ad2389a14529f::version::Version, arg1: &mut Registry, arg2: u64, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x8e4f745b9c0748d24d3c4248658a385822c5ae6c38dba4d8739ad2389a14529f::version::verify(arg0, arg7);
        let v0 = 0x2::dynamic_object_field::borrow_mut<u64, Vault>(&mut arg1.id, arg2);
        assert!(*0x1::vector::borrow<u64>(&v0.info, 5) == 1, 10);
        assert!(0x2::clock::timestamp_ms(arg6) < *0x1::vector::borrow<u64>(&v0.info, 3), 9);
        assert!(*0x1::vector::borrow<u64>(&v0.info, 4) == 0, 8);
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

    public fun deposit_suilend<T0>(arg0: &0x8e4f745b9c0748d24d3c4248658a385822c5ae6c38dba4d8739ad2389a14529f::version::Version, arg1: &mut Registry, arg2: u64, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x8e4f745b9c0748d24d3c4248658a385822c5ae6c38dba4d8739ad2389a14529f::version::verify(arg0, arg6);
        let v0 = 0x2::dynamic_object_field::borrow_mut<u64, Vault>(&mut arg1.id, arg2);
        assert!(*0x1::vector::borrow<u64>(&v0.info, 5) == 1, 10);
        assert!(0x2::clock::timestamp_ms(arg5) < *0x1::vector::borrow<u64>(&v0.info, 3), 9);
        assert!(*0x1::vector::borrow<u64>(&v0.info, 4) == 0, 8);
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
                        return 0x1::option::some<Share>(*0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_from_slice<Share>(v3, v4 % v2))
                    };
                    if (v4 + 1 < v1 && (v4 + 1) % v2 == 0) {
                        let v5 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::get_slice_idx<Share>(v3) + 1;
                        v3 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_slice<Share>(&v0.share, v5);
                    };
                    v4 = v4 + 1;
                };
            };
        };
        0x1::option::none<Share>()
    }

    entry fun hotfix_share_supply(arg0: &0x8e4f745b9c0748d24d3c4248658a385822c5ae6c38dba4d8739ad2389a14529f::version::Version, arg1: &mut Registry, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x8e4f745b9c0748d24d3c4248658a385822c5ae6c38dba4d8739ad2389a14529f::version::verify(arg0, arg3);
        let v0 = 0x2::dynamic_object_field::borrow_mut<u64, Vault>(&mut arg1.id, arg2);
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        let v6 = 0;
        let v7 = 0;
        let v8 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::length(&v0.share);
        if (v8 > 0) {
            let v9 = (0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::slice_size(&v0.share) as u64);
            let v10 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_slice_mut<Share>(&mut v0.share, 0);
            let v11 = 0;
            while (v11 < v8) {
                let v12 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_from_slice_mut<Share>(v10, v11 % v9);
                v1 = v1 + *0x1::vector::borrow<u64>(&v12.share, 0);
                v2 = v2 + *0x1::vector::borrow<u64>(&v12.share, 1);
                v3 = v3 + *0x1::vector::borrow<u64>(&v12.share, 2);
                v4 = v4 + *0x1::vector::borrow<u64>(&v12.share, 3);
                v5 = v5 + *0x1::vector::borrow<u64>(&v12.share, 4);
                if (0x1::vector::length<0x1::type_name::TypeName>(&v0.reward_tokens) > 0) {
                    v6 = v6 + *0x1::vector::borrow<u64>(&v12.share, 5);
                };
                if (0x1::vector::length<0x1::type_name::TypeName>(&v0.reward_tokens) > 1) {
                    v7 = v7 + *0x1::vector::borrow<u64>(&v12.share, 6);
                };
                if (v11 + 1 < v8 && (v11 + 1) % v9 == 0) {
                    let v13 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::get_slice_idx<Share>(v10) + 1;
                    v10 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_slice_mut<Share>(&mut v0.share, v13);
                };
                v11 = v11 + 1;
            };
        };
        *0x1::vector::borrow_mut<u64>(&mut v0.share_supply, 0) = v1;
        *0x1::vector::borrow_mut<u64>(&mut v0.share_supply, 1) = v2;
        *0x1::vector::borrow_mut<u64>(&mut v0.share_supply, 2) = v3;
        *0x1::vector::borrow_mut<u64>(&mut v0.share_supply, 3) = v4;
        *0x1::vector::borrow_mut<u64>(&mut v0.share_supply, 4) = v5;
        if (0x1::vector::length<0x1::type_name::TypeName>(&v0.reward_tokens) > 0) {
            *0x1::vector::borrow_mut<u64>(&mut v0.share_supply, 5) = v6;
        };
        if (0x1::vector::length<0x1::type_name::TypeName>(&v0.reward_tokens) > 1) {
            *0x1::vector::borrow_mut<u64>(&mut v0.share_supply, 6) = v7;
        };
    }

    entry fun hotfix_vault_0(arg0: &0x8e4f745b9c0748d24d3c4248658a385822c5ae6c38dba4d8739ad2389a14529f::version::Version, arg1: &mut Registry, arg2: &0x2::tx_context::TxContext) {
        0x8e4f745b9c0748d24d3c4248658a385822c5ae6c38dba4d8739ad2389a14529f::version::verify(arg0, arg2);
        let v0 = 0x2::dynamic_object_field::borrow_mut<u64, Vault>(&mut arg1.id, 0);
        let v1 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::length(&v0.share);
        if (v1 > 0) {
            let v2 = (0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::slice_size(&v0.share) as u64);
            let v3 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_slice_mut<Share>(&mut v0.share, 0);
            let v4 = 0;
            while (v4 < v1) {
                *0x1::vector::borrow_mut<u64>(&mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_from_slice_mut<Share>(v3, v4 % v2).share, 5) = 0;
                if (v4 + 1 < v1 && (v4 + 1) % v2 == 0) {
                    let v5 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::get_slice_idx<Share>(v3) + 1;
                    v3 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_slice_mut<Share>(&mut v0.share, v5);
                };
                v4 = v4 + 1;
            };
        };
    }

    entry fun hotfix_vault_1(arg0: &0x8e4f745b9c0748d24d3c4248658a385822c5ae6c38dba4d8739ad2389a14529f::version::Version, arg1: &mut Registry, arg2: &0x2::tx_context::TxContext) {
        0x8e4f745b9c0748d24d3c4248658a385822c5ae6c38dba4d8739ad2389a14529f::version::verify(arg0, arg2);
        let v0 = 0x2::dynamic_object_field::borrow_mut<u64, Vault>(&mut arg1.id, 1);
        let v1 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::length(&v0.share);
        if (v1 > 0) {
            let v2 = (0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::slice_size(&v0.share) as u64);
            let v3 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_slice_mut<Share>(&mut v0.share, 0);
            let v4 = 0;
            while (v4 < v1) {
                let v5 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_from_slice_mut<Share>(v3, v4 % v2);
                if (v5.user == @0xd15f079d5f60b8fdfdcf3ca66c0d3473790c758b04b6418929d5d2991c5443ee) {
                    *0x1::vector::borrow_mut<u64>(&mut v5.share, 6) = 0;
                };
                if (v4 + 1 < v1 && (v4 + 1) % v2 == 0) {
                    let v6 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::get_slice_idx<Share>(v3) + 1;
                    v3 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_slice_mut<Share>(&mut v0.share, v6);
                };
                v4 = v4 + 1;
            };
        };
    }

    entry fun hotfix_vault_balance<T0>(arg0: &0x8e4f745b9c0748d24d3c4248658a385822c5ae6c38dba4d8739ad2389a14529f::version::Version, arg1: &mut Registry, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x8e4f745b9c0748d24d3c4248658a385822c5ae6c38dba4d8739ad2389a14529f::version::verify(arg0, arg3);
        let v0 = 0x2::dynamic_object_field::borrow_mut<u64, Vault>(&mut arg1.id, arg2);
        let v1 = 0x1::type_name::get<T0>();
        let (v2, v3) = 0x1::vector::index_of<0x1::type_name::TypeName>(&v0.reward_tokens, &v1);
        if (v2) {
            let v4 = 0x2::balance::value<T0>(0x2::dynamic_field::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&v0.id, 0x1::type_name::get<T0>()));
            if (*0x1::vector::borrow<u64>(&v0.share_supply, v3 + 5) < v4) {
                0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut v0.id, 0x1::ascii::string(b"deposit_balance")), 0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v0.id, 0x1::type_name::get<T0>()), v4 - *0x1::vector::borrow<u64>(&v0.share_supply, v3 + 5)));
            };
        };
    }

    public fun incentivise<T0>(arg0: &0x8e4f745b9c0748d24d3c4248658a385822c5ae6c38dba4d8739ad2389a14529f::version::Version, arg1: &mut Registry, arg2: u64, arg3: 0x2::balance::Balance<T0>, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        0x8e4f745b9c0748d24d3c4248658a385822c5ae6c38dba4d8739ad2389a14529f::version::verify(arg0, arg5);
        let v0 = 0x2::dynamic_object_field::borrow_mut<u64, Vault>(&mut arg1.id, arg2);
        let v1 = 0x1::type_name::get<T0>();
        let (v2, v3) = 0x1::vector::index_of<0x1::type_name::TypeName>(&v0.reward_tokens, &v1);
        assert!(v2, 7);
        let v4 = 0x1::ascii::string(b"incentivise");
        let v5 = if (arg4) {
            0x1::ascii::string(b"_fixed")
        } else {
            0x1::ascii::string(b"_bp")
        };
        0x1::ascii::append(&mut v4, v5);
        let v6 = 0x1::vector::empty<u64>();
        let v7 = &mut v6;
        0x1::vector::push_back<u64>(v7, arg2);
        0x1::vector::push_back<u64>(v7, *0x1::vector::borrow<u64>(&v0.info, 1));
        0x1::vector::push_back<u64>(v7, 0x2::balance::value<T0>(&arg3));
        let v8 = ManagerEvent{
            action      : v4,
            log         : v6,
            bcs_padding : vector[],
        };
        0x2::event::emit<ManagerEvent>(v8);
        let v9 = 0x2::balance::value<T0>(&arg3);
        let v10 = *0x1::vector::borrow<u64>(&v0.share_supply, 0) + *0x1::vector::borrow<u64>(&v0.share_supply, 1);
        let v11 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::length(&v0.share);
        if (v11 > 0) {
            let v12 = (0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::slice_size(&v0.share) as u64);
            let v13 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_slice_mut<Share>(&mut v0.share, 0);
            let v14 = 0;
            while (v14 < v11 && v10 > 0) {
                let v15 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_from_slice_mut<Share>(v13, v14 % v12);
                let v16 = (((v9 as u128) * ((*0x1::vector::borrow<u64>(&v15.share, 0) + *0x1::vector::borrow<u64>(&v15.share, 1)) as u128) / (v10 as u128)) as u64);
                *0x1::vector::borrow_mut<u64>(&mut v15.share, v3 + 5) = *0x1::vector::borrow<u64>(&v15.share, v3 + 5) + v16;
                v9 = v9 - v16;
                v10 = v10 - *0x1::vector::borrow<u64>(&v15.share, 0) + *0x1::vector::borrow<u64>(&v15.share, 1);
                if (v14 + 1 < v11 && (v14 + 1) % v12 == 0) {
                    let v17 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::get_slice_idx<Share>(v13) + 1;
                    v13 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_slice_mut<Share>(&mut v0.share, v17);
                };
                v14 = v14 + 1;
            };
        };
        *0x1::vector::borrow_mut<u64>(&mut v0.share_supply, v3 + 5) = *0x1::vector::borrow<u64>(&v0.share_supply, v3 + 5) + 0x2::balance::value<T0>(&arg3);
        0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v0.id, 0x1::type_name::get<T0>()), arg3);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id                    : 0x2::object::new(arg0),
            num_of_vault          : 0,
            transaction_suspended : false,
        };
        0x2::transfer::share_object<Registry>(v0);
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

    public fun log_apr(arg0: &0x8e4f745b9c0748d24d3c4248658a385822c5ae6c38dba4d8739ad2389a14529f::version::Version, arg1: &mut Registry, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x8e4f745b9c0748d24d3c4248658a385822c5ae6c38dba4d8739ad2389a14529f::version::verify(arg0, arg4);
        let v0 = 0x2::dynamic_object_field::borrow_mut<u64, Vault>(&mut arg1.id, arg2);
        assert!(*0x1::vector::borrow<u64>(&v0.info, 5) == 1, 10);
        *0x1::vector::borrow_mut<u64>(&mut v0.info, 11) = arg3;
        let v1 = 0x1::vector::empty<u64>();
        let v2 = &mut v1;
        0x1::vector::push_back<u64>(v2, arg2);
        0x1::vector::push_back<u64>(v2, *0x1::vector::borrow<u64>(&v0.info, 1));
        0x1::vector::push_back<u64>(v2, *0x1::vector::borrow<u64>(&v0.info, 4));
        0x1::vector::push_back<u64>(v2, arg3);
        let v3 = ManagerEvent{
            action      : 0x1::ascii::string(b"log_apr"),
            log         : v1,
            bcs_padding : vector[],
        };
        0x2::event::emit<ManagerEvent>(v3);
    }

    entry fun new_vault<T0>(arg0: &0x8e4f745b9c0748d24d3c4248658a385822c5ae6c38dba4d8739ad2389a14529f::version::Version, arg1: &mut Registry, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: bool, arg10: u64, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) {
        0x8e4f745b9c0748d24d3c4248658a385822c5ae6c38dba4d8739ad2389a14529f::version::verify(arg0, arg12);
        let v0 = 0x2::object::new(arg12);
        0x2::dynamic_field::add<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut v0, 0x1::ascii::string(b"deposit_balance"), 0x2::balance::zero<T0>());
        let v1 = vector[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
        *0x1::vector::borrow_mut<u64>(&mut v1, 0) = arg1.num_of_vault;
        *0x1::vector::borrow_mut<u64>(&mut v1, 1) = 0;
        *0x1::vector::borrow_mut<u64>(&mut v1, 2) = arg2;
        *0x1::vector::borrow_mut<u64>(&mut v1, 3) = arg3;
        *0x1::vector::borrow_mut<u64>(&mut v1, 4) = 0;
        let v2 = if (arg9) {
            1
        } else {
            0
        };
        *0x1::vector::borrow_mut<u64>(&mut v1, 5) = v2;
        *0x1::vector::borrow_mut<u64>(&mut v1, 6) = arg10;
        *0x1::vector::borrow_mut<u64>(&mut v1, 7) = 1;
        *0x1::vector::borrow_mut<u64>(&mut v1, 8) = 1;
        *0x1::vector::borrow_mut<u64>(&mut v1, 9) = arg11;
        let v3 = vector[0, 0, 0, 0, 0, 0, 0, 0];
        *0x1::vector::borrow_mut<u64>(&mut v3, 0) = arg4;
        *0x1::vector::borrow_mut<u64>(&mut v3, 1) = arg5;
        *0x1::vector::borrow_mut<u64>(&mut v3, 2) = arg6;
        *0x1::vector::borrow_mut<u64>(&mut v3, 3) = arg7;
        *0x1::vector::borrow_mut<u64>(&mut v3, 4) = arg8;
        *0x1::vector::borrow_mut<u64>(&mut v3, 5) = 50;
        *0x1::vector::borrow_mut<u64>(&mut v3, 6) = 0;
        *0x1::vector::borrow_mut<u64>(&mut v3, 7) = 0;
        let v4 = Vault{
            id            : v0,
            deposit_token : 0x1::type_name::get<T0>(),
            reward_tokens : 0x1::vector::empty<0x1::type_name::TypeName>(),
            info          : v1,
            config        : v3,
            share         : 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::new<Share>(1000, arg12),
            share_supply  : vector[0, 0, 0, 0, 0],
            u64_padding   : 0x1::vector::empty<u64>(),
            bcs_padding   : 0x1::vector::empty<u8>(),
        };
        let v5 = 0x1::vector::empty<u64>();
        let v6 = &mut v5;
        0x1::vector::push_back<u64>(v6, arg1.num_of_vault);
        0x1::vector::push_back<u64>(v6, arg2);
        0x1::vector::push_back<u64>(v6, arg3);
        0x1::vector::push_back<u64>(v6, arg4);
        0x1::vector::push_back<u64>(v6, arg5);
        0x1::vector::push_back<u64>(v6, arg6);
        0x1::vector::push_back<u64>(v6, arg7);
        0x1::vector::push_back<u64>(v6, arg8);
        0x1::vector::push_back<u64>(v6, arg10);
        let v7 = 0x1::type_name::get<T0>();
        let v8 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v8, 0x1::bcs::to_bytes<0x1::type_name::TypeName>(&v7));
        let v9 = ManagerEvent{
            action      : 0x1::ascii::string(b"new_vault"),
            log         : v5,
            bcs_padding : v8,
        };
        0x2::event::emit<ManagerEvent>(v9);
        arg1.num_of_vault = arg1.num_of_vault + 1;
        0x2::dynamic_object_field::add<u64, Vault>(&mut arg1.id, *0x1::vector::borrow<u64>(&v4.info, 0), v4);
    }

    public fun post_bid_balance<T0>(arg0: &0x8e4f745b9c0748d24d3c4248658a385822c5ae6c38dba4d8739ad2389a14529f::version::Version, arg1: &mut Registry, arg2: u64, arg3: 0x2::balance::Balance<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        0x8e4f745b9c0748d24d3c4248658a385822c5ae6c38dba4d8739ad2389a14529f::version::verify(arg0, arg4);
        if (0x2::balance::value<T0>(&arg3) == 0) {
            0x2::balance::destroy_zero<T0>(arg3);
            return
        };
        let v0 = 0x2::dynamic_object_field::borrow_mut<u64, Vault>(&mut arg1.id, arg2);
        let v1 = 0x1::vector::empty<u64>();
        let v2 = &mut v1;
        0x1::vector::push_back<u64>(v2, arg2);
        0x1::vector::push_back<u64>(v2, *0x1::vector::borrow<u64>(&v0.info, 1));
        0x1::vector::push_back<u64>(v2, 0x2::balance::value<T0>(&arg3));
        let v3 = ManagerEvent{
            action      : 0x1::ascii::string(b"post_bid_balance"),
            log         : v1,
            bcs_padding : vector[],
        };
        0x2::event::emit<ManagerEvent>(v3);
        let v4 = 0x2::balance::value<T0>(&arg3);
        let v5 = *0x1::vector::borrow<u64>(&v0.share_supply, 0) + *0x1::vector::borrow<u64>(&v0.share_supply, 1);
        let v6 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::length(&v0.share);
        if (v6 > 0) {
            let v7 = (0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::slice_size(&v0.share) as u64);
            let v8 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_slice_mut<Share>(&mut v0.share, 0);
            let v9 = 0;
            while (v9 < v6) {
                let v10 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_from_slice_mut<Share>(v8, v9 % v7);
                let v11 = (((v4 as u128) * ((*0x1::vector::borrow<u64>(&v10.share, 0) + *0x1::vector::borrow<u64>(&v10.share, 1)) as u128) / (v5 as u128)) as u64);
                *0x1::vector::borrow_mut<u64>(&mut v10.share, 3) = *0x1::vector::borrow<u64>(&v10.share, 3) + v11;
                v4 = v4 - v11;
                v5 = v5 - *0x1::vector::borrow<u64>(&v10.share, 0) + *0x1::vector::borrow<u64>(&v10.share, 1);
                if (v9 + 1 < v6 && (v9 + 1) % v7 == 0) {
                    let v12 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::get_slice_idx<Share>(v8) + 1;
                    v8 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_slice_mut<Share>(&mut v0.share, v12);
                };
                v9 = v9 + 1;
            };
        };
        *0x1::vector::borrow_mut<u64>(&mut v0.share_supply, 3) = *0x1::vector::borrow<u64>(&v0.share_supply, 3) + 0x2::balance::value<T0>(&arg3);
        0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut v0.id, 0x1::ascii::string(b"deposit_balance")), arg3);
    }

    public fun post_bid_balance_v2<T0>(arg0: &mut 0x8e4f745b9c0748d24d3c4248658a385822c5ae6c38dba4d8739ad2389a14529f::version::Version, arg1: &mut Registry, arg2: u64, arg3: 0x2::balance::Balance<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        0x8e4f745b9c0748d24d3c4248658a385822c5ae6c38dba4d8739ad2389a14529f::version::verify(arg0, arg4);
        if (0x2::balance::value<T0>(&arg3) == 0) {
            0x2::balance::destroy_zero<T0>(arg3);
            return
        };
        let v0 = 0x2::dynamic_object_field::borrow_mut<u64, Vault>(&mut arg1.id, arg2);
        let v1 = (((0x2::balance::value<T0>(&arg3) as u128) * (*0x1::vector::borrow<u64>(&v0.config, 3) as u128) / 10000) as u64);
        0x8e4f745b9c0748d24d3c4248658a385822c5ae6c38dba4d8739ad2389a14529f::version::charge_fee<T0>(arg0, 0x2::balance::split<T0>(&mut arg3, v1));
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

    public fun post_bid_receipt<T0: store + key>(arg0: &0x8e4f745b9c0748d24d3c4248658a385822c5ae6c38dba4d8739ad2389a14529f::version::Version, arg1: &mut Registry, arg2: u64, arg3: 0x1::option::Option<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        0x8e4f745b9c0748d24d3c4248658a385822c5ae6c38dba4d8739ad2389a14529f::version::verify(arg0, arg4);
        if (0x1::option::is_none<T0>(&arg3)) {
            0x1::option::destroy_none<T0>(arg3);
            return
        };
        let v0 = 0x1::option::destroy_some<T0>(arg3);
        let v1 = 0x2::dynamic_object_field::borrow_mut<u64, Vault>(&mut arg1.id, arg2);
        assert!(*0x1::vector::borrow<u64>(&v1.info, 10) == 0, 13);
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

    public fun post_exercise<T0>(arg0: &0x8e4f745b9c0748d24d3c4248658a385822c5ae6c38dba4d8739ad2389a14529f::version::Version, arg1: &mut Registry, arg2: u64, arg3: 0x2::balance::Balance<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        0x8e4f745b9c0748d24d3c4248658a385822c5ae6c38dba4d8739ad2389a14529f::version::verify(arg0, arg4);
        let v0 = 0x2::dynamic_object_field::borrow_mut<u64, Vault>(&mut arg1.id, arg2);
        let v1 = 0x1::type_name::get<T0>();
        let (v2, v3) = 0x1::vector::index_of<0x1::type_name::TypeName>(&v0.reward_tokens, &v1);
        assert!(v2, 7);
        let v4 = 0x1::vector::empty<u64>();
        let v5 = &mut v4;
        0x1::vector::push_back<u64>(v5, arg2);
        0x1::vector::push_back<u64>(v5, *0x1::vector::borrow<u64>(&v0.info, 1));
        0x1::vector::push_back<u64>(v5, 0x2::balance::value<T0>(&arg3));
        let v6 = ManagerEvent{
            action      : 0x1::ascii::string(b"post_exercise"),
            log         : v4,
            bcs_padding : vector[],
        };
        0x2::event::emit<ManagerEvent>(v6);
        let v7 = 0x2::balance::value<T0>(&arg3);
        let v8 = *0x1::vector::borrow<u64>(&v0.share_supply, 4);
        let v9 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::length(&v0.share);
        if (v9 > 0) {
            let v10 = (0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::slice_size(&v0.share) as u64);
            let v11 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_slice_mut<Share>(&mut v0.share, 0);
            let v12 = 0;
            while (v12 < v9 && v8 > 0) {
                let v13 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_from_slice_mut<Share>(v11, v12 % v10);
                let v14 = (((v7 as u128) * (*0x1::vector::borrow<u64>(&v13.share, 4) as u128) / (v8 as u128)) as u64);
                *0x1::vector::borrow_mut<u64>(&mut v13.share, v3 + 5) = *0x1::vector::borrow<u64>(&v13.share, v3 + 5) + v14;
                v7 = v7 - v14;
                v8 = v8 - *0x1::vector::borrow<u64>(&v13.share, 4);
                if (v12 + 1 < v9 && (v12 + 1) % v10 == 0) {
                    let v15 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::get_slice_idx<Share>(v11) + 1;
                    v11 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_slice_mut<Share>(&mut v0.share, v15);
                };
                v12 = v12 + 1;
            };
        };
        *0x1::vector::borrow_mut<u64>(&mut v0.share_supply, v3 + 5) = *0x1::vector::borrow<u64>(&v0.share_supply, v3 + 5) + 0x2::balance::value<T0>(&arg3);
        0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v0.id, 0x1::type_name::get<T0>()), arg3);
    }

    public fun pre_exercise<T0: store + key>(arg0: &0x8e4f745b9c0748d24d3c4248658a385822c5ae6c38dba4d8739ad2389a14529f::version::Version, arg1: &mut Registry, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : T0 {
        0x8e4f745b9c0748d24d3c4248658a385822c5ae6c38dba4d8739ad2389a14529f::version::verify(arg0, arg3);
        let v0 = 0x2::dynamic_object_field::borrow_mut<u64, Vault>(&mut arg1.id, arg2);
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

    public fun raise_fund<T0>(arg0: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg1: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::leaderboard::TypusLeaderboardRegistry, arg2: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::user::TypusUserRegistry, arg3: &0x8e4f745b9c0748d24d3c4248658a385822c5ae6c38dba4d8739ad2389a14529f::version::Version, arg4: &mut Registry, arg5: u64, arg6: 0x2::balance::Balance<T0>, arg7: u64, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        0x8e4f745b9c0748d24d3c4248658a385822c5ae6c38dba4d8739ad2389a14529f::version::version_check(arg3);
        assert!(!arg4.transaction_suspended, 0);
        let v0 = 0x2::clock::timestamp_ms(arg10);
        let v1 = 0x2::dynamic_field::remove<0x1::ascii::String, 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::ManagerCap>(&mut arg4.id, 0x1::ascii::string(b"typus_manager_cap"));
        let v2 = 0x2::dynamic_object_field::borrow_mut<u64, Vault>(&mut arg4.id, arg5);
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
        let v15 = (((*0x1::vector::borrow<u64>(&v14.u64_padding, 0) as u256) * ((v0 - *0x1::vector::borrow<u64>(&v14.u64_padding, 1)) as u256) * (*0x1::vector::borrow<u64>(&v2.config, 5) as u256) / 3600000 / 10000) as u64);
        *0x1::vector::borrow_mut<u64>(&mut v14.u64_padding, 1) = v0;
        0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::leaderboard::score(&v1, arg0, arg1, 0x1::ascii::string(b"depositor_program"), v3, v15, arg10, arg11);
        0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::user::add_tails_exp_amount(&v1, arg0, arg2, v3, v15);
        let v16 = 0x2::balance::value<T0>(&arg6);
        *0x1::vector::borrow_mut<u64>(&mut v14.share, 3) = *0x1::vector::borrow<u64>(&v14.share, 3) + v16;
        *0x1::vector::borrow_mut<u64>(&mut v2.share_supply, 3) = *0x1::vector::borrow<u64>(&v2.share_supply, 3) + v16;
        0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut v2.id, 0x1::ascii::string(b"deposit_balance")), arg6);
        let v17 = if (*0x1::vector::borrow<u64>(&v14.share, 1) < arg7) {
            *0x1::vector::borrow<u64>(&v14.share, 1)
        } else {
            arg7
        };
        *0x1::vector::borrow_mut<u64>(&mut v14.share, 0) = *0x1::vector::borrow<u64>(&v14.share, 0) + v17;
        *0x1::vector::borrow_mut<u64>(&mut v2.share_supply, 0) = *0x1::vector::borrow<u64>(&v2.share_supply, 0) + v17;
        *0x1::vector::borrow_mut<u64>(&mut v14.share, 1) = *0x1::vector::borrow<u64>(&v14.share, 1) - v17;
        *0x1::vector::borrow_mut<u64>(&mut v2.share_supply, 1) = *0x1::vector::borrow<u64>(&v2.share_supply, 1) - v17;
        let v18 = if (*0x1::vector::borrow<u64>(&v14.share, 2) < arg8) {
            *0x1::vector::borrow<u64>(&v14.share, 2)
        } else {
            arg8
        };
        *0x1::vector::borrow_mut<u64>(&mut v14.share, 3) = *0x1::vector::borrow<u64>(&v14.share, 3) + v18;
        *0x1::vector::borrow_mut<u64>(&mut v2.share_supply, 3) = *0x1::vector::borrow<u64>(&v2.share_supply, 3) + v18;
        *0x1::vector::borrow_mut<u64>(&mut v14.share, 2) = *0x1::vector::borrow<u64>(&v14.share, 2) - v18;
        *0x1::vector::borrow_mut<u64>(&mut v2.share_supply, 2) = *0x1::vector::borrow<u64>(&v2.share_supply, 2) - v18;
        let v19 = 0;
        if (arg9 > 0) {
            let v20 = 0x1::type_name::get<T0>();
            let (v21, v22) = 0x1::vector::index_of<0x1::type_name::TypeName>(&v2.reward_tokens, &v20);
            if (v21) {
                *0x1::vector::borrow_mut<u64>(&mut v2.share_supply, v22 + 5) = 0x2::balance::value<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v2.id, 0x1::type_name::get<T0>()));
                let v23 = if (*0x1::vector::borrow<u64>(&v14.share, v22 + 5) < arg9) {
                    *0x1::vector::borrow<u64>(&v14.share, v22 + 5)
                } else {
                    arg9
                };
                v19 = v23;
                *0x1::vector::borrow_mut<u64>(&mut v14.share, 3) = *0x1::vector::borrow<u64>(&v14.share, 3) + v23;
                *0x1::vector::borrow_mut<u64>(&mut v2.share_supply, 3) = *0x1::vector::borrow<u64>(&v2.share_supply, 3) + v23;
                *0x1::vector::borrow_mut<u64>(&mut v14.share, v22 + 5) = *0x1::vector::borrow<u64>(&v14.share, v22 + 5) - v23;
                *0x1::vector::borrow_mut<u64>(&mut v2.share_supply, v22 + 5) = *0x1::vector::borrow<u64>(&v2.share_supply, v22 + 5) - v23;
                0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut v2.id, 0x1::ascii::string(b"deposit_balance")), 0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v2.id, 0x1::type_name::get<T0>()), v23));
            };
        };
        *0x1::vector::borrow_mut<u64>(&mut v14.u64_padding, 0) = ((((*0x1::vector::borrow<u64>(&v14.share, 0) + *0x1::vector::borrow<u64>(&v14.share, 3)) as u128) * (*0x1::vector::borrow<u64>(&v2.info, 6) as u128) / 10000 / (0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::utility::multiplier(*0x1::vector::borrow<u64>(&v2.info, 9)) as u128)) as u64);
        assert!(v16 + v17 + v18 + v19 > 0, 1);
        assert!(v16 == 0 || v16 >= *0x1::vector::borrow<u64>(&v2.config, 1) && v16 % *0x1::vector::borrow<u64>(&v2.config, 1) == 0, 3);
        assert!(v16 == 0 || v16 >= *0x1::vector::borrow<u64>(&v2.config, 2), 4);
        assert!(*0x1::vector::borrow<u64>(&v2.share_supply, 3) + *0x1::vector::borrow<u64>(&v2.share_supply, 0) <= *0x1::vector::borrow<u64>(&v2.config, 0), 2);
        let v24 = 0x1::vector::empty<u64>();
        let v25 = &mut v24;
        0x1::vector::push_back<u64>(v25, arg5);
        0x1::vector::push_back<u64>(v25, *0x1::vector::borrow<u64>(&v2.info, 1));
        0x1::vector::push_back<u64>(v25, v16);
        0x1::vector::push_back<u64>(v25, v17);
        0x1::vector::push_back<u64>(v25, v18);
        0x1::vector::push_back<u64>(v25, v19);
        0x1::vector::push_back<u64>(v25, v15);
        let v26 = 0x1::type_name::get<T0>();
        let v27 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v27, 0x1::bcs::to_bytes<0x1::type_name::TypeName>(&v26));
        let v28 = UserEvent{
            action      : 0x1::ascii::string(b"raise_fund"),
            log         : v24,
            bcs_padding : v27,
        };
        0x2::event::emit<UserEvent>(v28);
        0x2::dynamic_field::add<0x1::ascii::String, 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::ManagerCap>(&mut arg4.id, 0x1::ascii::string(b"typus_manager_cap"), v1);
    }

    public fun reduce_fund<T0>(arg0: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg1: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::leaderboard::TypusLeaderboardRegistry, arg2: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::user::TypusUserRegistry, arg3: &0x8e4f745b9c0748d24d3c4248658a385822c5ae6c38dba4d8739ad2389a14529f::version::Version, arg4: &mut Registry, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x8e4f745b9c0748d24d3c4248658a385822c5ae6c38dba4d8739ad2389a14529f::version::version_check(arg3);
        assert!(!arg4.transaction_suspended, 0);
        let v0 = 0x2::clock::timestamp_ms(arg9);
        let v1 = 0x2::dynamic_field::remove<0x1::ascii::String, 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::ManagerCap>(&mut arg4.id, 0x1::ascii::string(b"typus_manager_cap"));
        let v2 = 0x2::dynamic_object_field::borrow_mut<u64, Vault>(&mut arg4.id, arg5);
        let v3 = 0x2::tx_context::sender(arg10);
        let v4 = 0x2::balance::zero<T0>();
        let v5 = 0;
        let v6 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::length(&v2.share);
        if (v6 > 0) {
            let v7 = (0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::slice_size(&v2.share) as u64);
            let v8 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_slice<Share>(&v2.share, 0);
            while (v5 < v6) {
                if (0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_from_slice<Share>(v8, v5 % v7).user == v3) {
                    break
                };
                if (v5 + 1 < v6 && (v5 + 1) % v7 == 0) {
                    let v9 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::get_slice_idx<Share>(v8) + 1;
                    v8 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_slice<Share>(&v2.share, v9);
                };
                v5 = v5 + 1;
            };
        };
        assert!(v5 < v6, 5);
        let v10 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_mut<Share>(&mut v2.share, v5);
        let v11 = (((*0x1::vector::borrow<u64>(&v10.u64_padding, 0) as u256) * ((v0 - *0x1::vector::borrow<u64>(&v10.u64_padding, 1)) as u256) * (*0x1::vector::borrow<u64>(&v2.config, 5) as u256) / 3600000 / 10000) as u64);
        *0x1::vector::borrow_mut<u64>(&mut v10.u64_padding, 1) = v0;
        0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::leaderboard::score(&v1, arg0, arg1, 0x1::ascii::string(b"depositor_program"), v3, v11, arg9, arg10);
        0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::user::add_tails_exp_amount(&v1, arg0, arg2, v3, v11);
        let v12 = if (*0x1::vector::borrow<u64>(&v10.share, 3) < arg6) {
            *0x1::vector::borrow<u64>(&v10.share, 3)
        } else {
            arg6
        };
        *0x1::vector::borrow_mut<u64>(&mut v10.share, 3) = *0x1::vector::borrow<u64>(&v10.share, 3) - v12;
        *0x1::vector::borrow_mut<u64>(&mut v2.share_supply, 3) = *0x1::vector::borrow<u64>(&v2.share_supply, 3) - v12;
        0x2::balance::join<T0>(&mut v4, 0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut v2.id, 0x1::ascii::string(b"deposit_balance")), v12));
        let v13 = if (*0x1::vector::borrow<u64>(&v10.share, 0) < arg7) {
            *0x1::vector::borrow<u64>(&v10.share, 0)
        } else {
            arg7
        };
        *0x1::vector::borrow_mut<u64>(&mut v10.share, 0) = *0x1::vector::borrow<u64>(&v10.share, 0) - v13;
        *0x1::vector::borrow_mut<u64>(&mut v2.share_supply, 0) = *0x1::vector::borrow<u64>(&v2.share_supply, 0) - v13;
        *0x1::vector::borrow_mut<u64>(&mut v10.share, 1) = *0x1::vector::borrow<u64>(&v10.share, 1) + v13;
        *0x1::vector::borrow_mut<u64>(&mut v2.share_supply, 1) = *0x1::vector::borrow<u64>(&v2.share_supply, 1) + v13;
        let v14 = if (*0x1::vector::borrow<u64>(&v10.share, 2) < arg8) {
            *0x1::vector::borrow<u64>(&v10.share, 2)
        } else {
            arg8
        };
        *0x1::vector::borrow_mut<u64>(&mut v10.share, 2) = *0x1::vector::borrow<u64>(&v10.share, 2) - v14;
        *0x1::vector::borrow_mut<u64>(&mut v2.share_supply, 2) = *0x1::vector::borrow<u64>(&v2.share_supply, 2) - v14;
        0x2::balance::join<T0>(&mut v4, 0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut v2.id, 0x1::ascii::string(b"deposit_balance")), v14));
        *0x1::vector::borrow_mut<u64>(&mut v10.u64_padding, 0) = ((((*0x1::vector::borrow<u64>(&v10.share, 0) + *0x1::vector::borrow<u64>(&v10.share, 3)) as u128) * (*0x1::vector::borrow<u64>(&v2.info, 6) as u128) / 10000 / (0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::utility::multiplier(*0x1::vector::borrow<u64>(&v2.info, 9)) as u128)) as u64);
        assert!(v12 + v13 + v14 > 0, 1);
        let v15 = 0x1::vector::empty<u64>();
        let v16 = &mut v15;
        0x1::vector::push_back<u64>(v16, arg5);
        0x1::vector::push_back<u64>(v16, *0x1::vector::borrow<u64>(&v2.info, 1));
        0x1::vector::push_back<u64>(v16, v12);
        0x1::vector::push_back<u64>(v16, v13);
        0x1::vector::push_back<u64>(v16, v14);
        0x1::vector::push_back<u64>(v16, v11);
        let v17 = 0x1::type_name::get<T0>();
        let v18 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v18, 0x1::bcs::to_bytes<0x1::type_name::TypeName>(&v17));
        let v19 = UserEvent{
            action      : 0x1::ascii::string(b"reduce_fund"),
            log         : v15,
            bcs_padding : v18,
        };
        0x2::event::emit<UserEvent>(v19);
        if (is_empty(v10)) {
            0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::swap_remove<Share>(&mut v2.share, v5);
        };
        0x2::dynamic_field::add<0x1::ascii::String, 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::ManagerCap>(&mut arg4.id, 0x1::ascii::string(b"typus_manager_cap"), v1);
        v4
    }

    public fun refresh(arg0: &0x8e4f745b9c0748d24d3c4248658a385822c5ae6c38dba4d8739ad2389a14529f::version::Version, arg1: &mut Registry, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x8e4f745b9c0748d24d3c4248658a385822c5ae6c38dba4d8739ad2389a14529f::version::verify(arg0, arg6);
        let v0 = 0x2::dynamic_object_field::borrow_mut<u64, Vault>(&mut arg1.id, arg2);
        assert!(0x2::clock::timestamp_ms(arg5) >= *0x1::vector::borrow<u64>(&v0.info, 3), 9);
        assert!(*0x1::vector::borrow<u64>(&v0.info, 4) == 0, 8);
        let v1 = *0x1::vector::borrow<u64>(&v0.share_supply, 0) + *0x1::vector::borrow<u64>(&v0.share_supply, 1);
        assert!(*0x1::vector::borrow<u64>(&v0.info, 7) == 1 || v1 == 0, 12);
        assert!(*0x1::vector::borrow<u64>(&v0.info, 8) == 1 || v1 == 0, 12);
        let v2 = *0x1::vector::borrow<u64>(&v0.info, 10) == 1;
        let v3 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::length(&v0.share);
        if (v3 > 0) {
            let v4 = (0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::slice_size(&v0.share) as u64);
            let v5 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_slice_mut<Share>(&mut v0.share, 0);
            let v6 = 0;
            while (v6 < v3) {
                let v7 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::big_vector::borrow_from_slice_mut<Share>(v5, v6 % v4);
                *0x1::vector::borrow_mut<u64>(&mut v7.share, 4) = *0x1::vector::borrow<u64>(&v7.share, 0) + *0x1::vector::borrow<u64>(&v7.share, 1);
                *0x1::vector::borrow_mut<u64>(&mut v7.share, 2) = *0x1::vector::borrow<u64>(&v7.share, 2) + *0x1::vector::borrow<u64>(&v7.share, 1);
                *0x1::vector::borrow_mut<u64>(&mut v7.share, 1) = 0;
                if (v2) {
                    *0x1::vector::borrow_mut<u64>(&mut v7.share, 2) = *0x1::vector::borrow<u64>(&v7.share, 2) + *0x1::vector::borrow<u64>(&v7.share, 0);
                    *0x1::vector::borrow_mut<u64>(&mut v7.share, 0) = 0;
                } else {
                    *0x1::vector::borrow_mut<u64>(&mut v7.share, 0) = *0x1::vector::borrow<u64>(&v7.share, 0) + *0x1::vector::borrow<u64>(&v7.share, 3);
                    *0x1::vector::borrow_mut<u64>(&mut v7.share, 3) = 0;
                };
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
        *0x1::vector::borrow_mut<u64>(&mut v0.share_supply, 4) = *0x1::vector::borrow_mut<u64>(&mut v0.share_supply, 0) + *0x1::vector::borrow_mut<u64>(&mut v0.share_supply, 1);
        *0x1::vector::borrow_mut<u64>(&mut v0.share_supply, 2) = *0x1::vector::borrow_mut<u64>(&mut v0.share_supply, 2) + *0x1::vector::borrow_mut<u64>(&mut v0.share_supply, 1);
        *0x1::vector::borrow_mut<u64>(&mut v0.share_supply, 1) = 0;
        if (v2) {
            *0x1::vector::borrow_mut<u64>(&mut v0.share_supply, 2) = *0x1::vector::borrow_mut<u64>(&mut v0.share_supply, 2) + *0x1::vector::borrow_mut<u64>(&mut v0.share_supply, 0);
            *0x1::vector::borrow_mut<u64>(&mut v0.share_supply, 0) = 0;
            *0x1::vector::borrow_mut<u64>(&mut v0.info, 7) = 1;
            *0x1::vector::borrow_mut<u64>(&mut v0.info, 8) = 1;
        } else {
            *0x1::vector::borrow_mut<u64>(&mut v0.share_supply, 0) = *0x1::vector::borrow_mut<u64>(&mut v0.share_supply, 0) + *0x1::vector::borrow_mut<u64>(&mut v0.share_supply, 3);
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
    }

    public fun refund<T0>(arg0: &0x8e4f745b9c0748d24d3c4248658a385822c5ae6c38dba4d8739ad2389a14529f::version::Version, arg1: &mut Registry, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x8e4f745b9c0748d24d3c4248658a385822c5ae6c38dba4d8739ad2389a14529f::version::verify(arg0, arg4);
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

    entry fun resume_transaction(arg0: &0x8e4f745b9c0748d24d3c4248658a385822c5ae6c38dba4d8739ad2389a14529f::version::Version, arg1: &mut Registry, arg2: &0x2::tx_context::TxContext) {
        0x8e4f745b9c0748d24d3c4248658a385822c5ae6c38dba4d8739ad2389a14529f::version::verify(arg0, arg2);
        arg1.transaction_suspended = false;
        let v0 = ManagerEvent{
            action      : 0x1::ascii::string(b"resume_transaction"),
            log         : vector[],
            bcs_padding : vector[],
        };
        0x2::event::emit<ManagerEvent>(v0);
    }

    public fun reward<T0>(arg0: &0x8e4f745b9c0748d24d3c4248658a385822c5ae6c38dba4d8739ad2389a14529f::version::Version, arg1: &mut Registry, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x8e4f745b9c0748d24d3c4248658a385822c5ae6c38dba4d8739ad2389a14529f::version::verify(arg0, arg4);
        let v0 = 0x2::dynamic_object_field::borrow_mut<u64, Vault>(&mut arg1.id, arg2);
        let v1 = 0x1::type_name::get<T0>();
        let (v2, v3) = 0x1::vector::index_of<0x1::type_name::TypeName>(&v0.reward_tokens, &v1);
        assert!(v2, 7);
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

    public fun set_incentivise<T0>(arg0: &0x8e4f745b9c0748d24d3c4248658a385822c5ae6c38dba4d8739ad2389a14529f::version::Version, arg1: &mut Registry, arg2: u64, arg3: 0x2::balance::Balance<T0>, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x8e4f745b9c0748d24d3c4248658a385822c5ae6c38dba4d8739ad2389a14529f::version::verify(arg0, arg5);
        let v0 = 0x2::dynamic_object_field::borrow_mut<u64, Vault>(&mut arg1.id, arg2);
        if (arg4) {
            assert!(*0x1::vector::borrow<u64>(&v0.info, 8) == 0, 11);
            *0x1::vector::borrow_mut<u64>(&mut v0.info, 8) = 1;
        } else {
            assert!(*0x1::vector::borrow<u64>(&v0.info, 7) == 0, 11);
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
        let v5 = ManagerEvent{
            action      : v1,
            log         : v3,
            bcs_padding : vector[],
        };
        0x2::event::emit<ManagerEvent>(v5);
        arg3
    }

    public fun set_reward_token<T0>(arg0: &0x8e4f745b9c0748d24d3c4248658a385822c5ae6c38dba4d8739ad2389a14529f::version::Version, arg1: &mut Registry, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x8e4f745b9c0748d24d3c4248658a385822c5ae6c38dba4d8739ad2389a14529f::version::verify(arg0, arg3);
        let v0 = 0x2::dynamic_object_field::borrow_mut<u64, Vault>(&mut arg1.id, arg2);
        let v1 = 0x1::type_name::get<T0>();
        let (v2, _) = 0x1::vector::index_of<0x1::type_name::TypeName>(&v0.reward_tokens, &v1);
        assert!(!v2, 7);
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

    public fun snapshot(arg0: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg1: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::leaderboard::TypusLeaderboardRegistry, arg2: &mut 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::user::TypusUserRegistry, arg3: &0x8e4f745b9c0748d24d3c4248658a385822c5ae6c38dba4d8739ad2389a14529f::version::Version, arg4: &mut Registry, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x8e4f745b9c0748d24d3c4248658a385822c5ae6c38dba4d8739ad2389a14529f::version::version_check(arg3);
        assert!(!arg4.transaction_suspended, 0);
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
        let v10 = (((*0x1::vector::borrow<u64>(&v9.u64_padding, 0) as u256) * ((v0 - *0x1::vector::borrow<u64>(&v9.u64_padding, 1)) as u256) * (*0x1::vector::borrow<u64>(&v2.config, 5) as u256) / 3600000 / 10000) as u64);
        *0x1::vector::borrow_mut<u64>(&mut v9.u64_padding, 1) = v0;
        0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::leaderboard::score(&v1, arg0, arg1, 0x1::ascii::string(b"depositor_program"), v3, v10, arg6, arg7);
        0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::user::add_tails_exp_amount(&v1, arg0, arg2, v3, v10);
        *0x1::vector::borrow_mut<u64>(&mut v9.u64_padding, 0) = ((((*0x1::vector::borrow<u64>(&v9.share, 0) + *0x1::vector::borrow<u64>(&v9.share, 3)) as u128) * (*0x1::vector::borrow<u64>(&v2.info, 6) as u128) / 10000 / (0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::utility::multiplier(*0x1::vector::borrow<u64>(&v2.info, 9)) as u128)) as u64);
        let v11 = 0x1::vector::empty<u64>();
        let v12 = &mut v11;
        0x1::vector::push_back<u64>(v12, arg5);
        0x1::vector::push_back<u64>(v12, *0x1::vector::borrow<u64>(&v2.info, 1));
        0x1::vector::push_back<u64>(v12, v10);
        let v13 = UserEvent{
            action      : 0x1::ascii::string(b"snapshot"),
            log         : v11,
            bcs_padding : vector[],
        };
        0x2::event::emit<UserEvent>(v13);
        0x2::dynamic_field::add<0x1::ascii::String, 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::ManagerCap>(&mut arg4.id, 0x1::ascii::string(b"typus_manager_cap"), v1);
    }

    entry fun suspend_transaction(arg0: &0x8e4f745b9c0748d24d3c4248658a385822c5ae6c38dba4d8739ad2389a14529f::version::Version, arg1: &mut Registry, arg2: &0x2::tx_context::TxContext) {
        0x8e4f745b9c0748d24d3c4248658a385822c5ae6c38dba4d8739ad2389a14529f::version::verify(arg0, arg2);
        arg1.transaction_suspended = true;
        let v0 = ManagerEvent{
            action      : 0x1::ascii::string(b"suspend_transaction"),
            log         : vector[],
            bcs_padding : vector[],
        };
        0x2::event::emit<ManagerEvent>(v0);
    }

    entry fun update_vault_config(arg0: &0x8e4f745b9c0748d24d3c4248658a385822c5ae6c38dba4d8739ad2389a14529f::version::Version, arg1: &mut Registry, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        0x8e4f745b9c0748d24d3c4248658a385822c5ae6c38dba4d8739ad2389a14529f::version::verify(arg0, arg5);
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

    public(friend) fun vault_uid(arg0: &Vault) : &0x2::object::UID {
        &arg0.id
    }

    public fun withdraw_scallop_basic<T0>(arg0: &mut 0x8e4f745b9c0748d24d3c4248658a385822c5ae6c38dba4d8739ad2389a14529f::version::Version, arg1: &mut Registry, arg2: u64, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x8e4f745b9c0748d24d3c4248658a385822c5ae6c38dba4d8739ad2389a14529f::version::verify(arg0, arg6);
        let v0 = 0x2::dynamic_object_field::borrow_mut<u64, Vault>(&mut arg1.id, arg2);
        assert!(*0x1::vector::borrow<u64>(&v0.info, 4) == 2, 8);
        *0x1::vector::borrow_mut<u64>(&mut v0.info, 4) = 0;
        let v1 = 0x2::coin::into_balance<T0>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<T0>(arg3, arg4, 0x2::dynamic_object_field::remove<0x1::ascii::String, 0x2::coin::Coin<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(&mut v0.id, 0x1::ascii::string(b"scallop_market_coin")), arg5, arg6));
        let v2 = *0x1::vector::borrow<u64>(&v0.share_supply, 0) + *0x1::vector::borrow<u64>(&v0.share_supply, 1);
        0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut v0.id, 0x1::ascii::string(b"deposit_balance")), 0x2::balance::split<T0>(&mut v1, v2));
        let v3 = 0x1::vector::empty<u64>();
        let v4 = &mut v3;
        0x1::vector::push_back<u64>(v4, arg2);
        0x1::vector::push_back<u64>(v4, *0x1::vector::borrow<u64>(&v0.info, 1));
        0x1::vector::push_back<u64>(v4, v2);
        0x1::vector::push_back<u64>(v4, 0x2::balance::value<T0>(&v1));
        let v5 = ManagerEvent{
            action      : 0x1::ascii::string(b"withdraw_scallop_basic"),
            log         : v3,
            bcs_padding : vector[],
        };
        0x2::event::emit<ManagerEvent>(v5);
        v1
    }

    public fun withdraw_scallop_spool<T0, T1>(arg0: &mut 0x8e4f745b9c0748d24d3c4248658a385822c5ae6c38dba4d8739ad2389a14529f::version::Version, arg1: &mut Registry, arg2: u64, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg6: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::rewards_pool::RewardsPool<T1>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0x8e4f745b9c0748d24d3c4248658a385822c5ae6c38dba4d8739ad2389a14529f::version::verify(arg0, arg8);
        let v0 = 0x2::dynamic_object_field::borrow_mut<u64, Vault>(&mut arg1.id, arg2);
        assert!(*0x1::vector::borrow<u64>(&v0.info, 4) == 1, 8);
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
        let v5 = *0x1::vector::borrow<u64>(&v0.share_supply, 0) + *0x1::vector::borrow<u64>(&v0.share_supply, 1);
        0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut v0.id, 0x1::ascii::string(b"deposit_balance")), 0x2::balance::split<T0>(&mut v4, v5));
        let v6 = 0x1::vector::empty<u64>();
        let v7 = &mut v6;
        0x1::vector::push_back<u64>(v7, arg2);
        0x1::vector::push_back<u64>(v7, *0x1::vector::borrow<u64>(&v0.info, 1));
        0x1::vector::push_back<u64>(v7, v5);
        0x1::vector::push_back<u64>(v7, 0x2::balance::value<T0>(&v4));
        0x1::vector::push_back<u64>(v7, 0x2::balance::value<T1>(&v3));
        let v8 = ManagerEvent{
            action      : 0x1::ascii::string(b"withdraw_scallop_spool"),
            log         : v6,
            bcs_padding : vector[],
        };
        0x2::event::emit<ManagerEvent>(v8);
        (v4, v3)
    }

    public fun withdraw_suilend<T0>(arg0: &mut 0x8e4f745b9c0748d24d3c4248658a385822c5ae6c38dba4d8739ad2389a14529f::version::Version, arg1: &mut Registry, arg2: u64, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x8e4f745b9c0748d24d3c4248658a385822c5ae6c38dba4d8739ad2389a14529f::version::verify(arg0, arg6);
        let v0 = 0x2::dynamic_object_field::borrow_mut<u64, Vault>(&mut arg1.id, arg2);
        assert!(*0x1::vector::borrow<u64>(&v0.info, 5) == 1, 10);
        assert!(*0x1::vector::borrow<u64>(&v0.info, 4) == 3, 8);
        *0x1::vector::borrow_mut<u64>(&mut v0.info, 4) = 0;
        let v1 = if (0x2::dynamic_object_field::exists_<0x1::ascii::String>(&v0.id, 0x1::ascii::string(b"suilend_obligation_owner_cap"))) {
            0x2::dynamic_object_field::remove<0x1::ascii::String, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>>(&mut v0.id, 0x1::ascii::string(b"suilend_obligation_owner_cap"))
        } else {
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::create_obligation<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>(arg3, arg6)
        };
        let v2 = v1;
        let v3 = 0x2::coin::into_balance<T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg3, arg4, arg5, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::withdraw_ctokens<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>(arg3, arg4, &v2, arg5, 18446744073709551615, arg6), 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL, T0>>(), arg6));
        0x2::dynamic_object_field::add<0x1::ascii::String, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::suilend::MAIN_POOL>>(&mut v0.id, 0x1::ascii::string(b"suilend_obligation_owner_cap"), v2);
        let v4 = *0x1::vector::borrow<u64>(&v0.share_supply, 0) + *0x1::vector::borrow<u64>(&v0.share_supply, 1);
        0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::ascii::String, 0x2::balance::Balance<T0>>(&mut v0.id, 0x1::ascii::string(b"deposit_balance")), 0x2::balance::split<T0>(&mut v3, v4));
        let v5 = 0x1::vector::empty<u64>();
        let v6 = &mut v5;
        0x1::vector::push_back<u64>(v6, arg2);
        0x1::vector::push_back<u64>(v6, *0x1::vector::borrow<u64>(&v0.info, 1));
        0x1::vector::push_back<u64>(v6, v4);
        0x1::vector::push_back<u64>(v6, 0x2::balance::value<T0>(&v3));
        let v7 = ManagerEvent{
            action      : 0x1::ascii::string(b"withdraw_suilend"),
            log         : v5,
            bcs_padding : vector[],
        };
        0x2::event::emit<ManagerEvent>(v7);
        v3
    }

    // decompiled from Move bytecode v6
}

