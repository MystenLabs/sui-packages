module 0x200e7a35a40dedada76d97b58409825943e54ecd5f445c0b5c7a98be75029888::vault_lens {
    public fun calculate_liquidity_bluefin<T0, T1, T2, T3>(arg0: &0x5d712497367b93e0cfdd24a28f4e75bb73eed057d37269a7a123eb618953995e::bluefin_executor::BluefinExecutorConfig, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T2, T3>, arg2: &0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg3: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg4: &vector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>, arg5: &vector<0xae9d0a79257bb9926a99088b385e99ccbda3d3e58aefc74568c58ef54c7212f4::nodo_price_feed::NodoPriceFeedInfo>, arg6: &0x2::clock::Clock) : u128 {
        let (v0, v1) = 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::get_vault_asset_balances<T0, T1>(arg2);
        let v2 = v1;
        let v3 = v0;
        let (v4, v5) = 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::get_withdraw_asset_balances<T0, T1>(arg2);
        let v6 = v5;
        let v7 = v4;
        let v8 = 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::get_pending_redemptions<T0, T1>(arg2);
        let (v9, v10, _) = 0x5d712497367b93e0cfdd24a28f4e75bb73eed057d37269a7a123eb618953995e::bluefin_executor::get_exactly_token_amount_from_positions<T2, T3>(arg0, arg1, 0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>>(arg2));
        let v12 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        let v13 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T2>());
        let v14 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T3>());
        let v15 = if (v13 == v12) {
            v9
        } else {
            0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::utils::get_amount_out(arg3, v13, v12, arg4, arg5, (v9 as u64), arg6)
        };
        let v16 = if (v14 == v12) {
            v10
        } else {
            0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::utils::get_amount_out(arg3, v14, v12, arg4, arg5, (v10 as u64), arg6)
        };
        let v17 = 0 + v15 + v16;
        let v18 = 0;
        while (v18 < 0x1::vector::length<0x1::ascii::String>(&v3)) {
            let v19 = 0x1::vector::borrow<0x1::ascii::String>(&v3, v18);
            let v20 = if (*v19 == v12) {
                *0x1::vector::borrow<u128>(&v2, v18)
            } else {
                0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::utils::get_amount_out(arg3, *v19, v12, arg4, arg5, (*0x1::vector::borrow<u128>(&v2, v18) as u64), arg6)
            };
            v17 = v17 + v20;
            v18 = v18 + 1;
        };
        let v21 = 0;
        while (v21 < 0x1::vector::length<0x1::ascii::String>(&v7)) {
            let v22 = 0x1::vector::borrow<0x1::ascii::String>(&v7, v21);
            let v23 = if (*v22 == v12) {
                *0x1::vector::borrow<u128>(&v6, v21)
            } else {
                0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::utils::get_amount_out(arg3, *v22, v12, arg4, arg5, (*0x1::vector::borrow<u128>(&v6, v21) as u64), arg6)
            };
            v17 = v17 + v23;
            v21 = v21 + 1;
        };
        if (v17 > v8) {
            v17 - v8
        } else {
            0
        }
    }

    public fun calculate_liquidity_cetus<T0, T1, T2, T3>(arg0: &0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg2: &0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg3: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg4: &vector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>, arg5: &vector<0xae9d0a79257bb9926a99088b385e99ccbda3d3e58aefc74568c58ef54c7212f4::nodo_price_feed::NodoPriceFeedInfo>, arg6: &0x2::clock::Clock) : u128 {
        let (v0, v1) = 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::get_vault_asset_balances<T0, T1>(arg2);
        let v2 = v1;
        let v3 = v0;
        let (v4, v5) = 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::get_withdraw_asset_balances<T0, T1>(arg2);
        let v6 = v5;
        let v7 = v4;
        let v8 = 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::get_pending_redemptions<T0, T1>(arg2);
        let (v9, v10, _) = 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::get_exactly_token_amount_from_positions<T2, T3>(arg0, arg1, 0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>>(arg2));
        let v12 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        let v13 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T2>());
        let v14 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T3>());
        let v15 = if (v13 == v12) {
            v9
        } else {
            0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::utils::get_amount_out(arg3, v13, v12, arg4, arg5, (v9 as u64), arg6)
        };
        let v16 = if (v14 == v12) {
            v10
        } else {
            0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::utils::get_amount_out(arg3, v14, v12, arg4, arg5, (v10 as u64), arg6)
        };
        let v17 = 0 + v15 + v16;
        let v18 = 0;
        while (v18 < 0x1::vector::length<0x1::ascii::String>(&v3)) {
            let v19 = 0x1::vector::borrow<0x1::ascii::String>(&v3, v18);
            let v20 = if (*v19 == v12) {
                *0x1::vector::borrow<u128>(&v2, v18)
            } else {
                0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::utils::get_amount_out(arg3, *v19, v12, arg4, arg5, (*0x1::vector::borrow<u128>(&v2, v18) as u64), arg6)
            };
            v17 = v17 + v20;
            v18 = v18 + 1;
        };
        let v21 = 0;
        while (v21 < 0x1::vector::length<0x1::ascii::String>(&v7)) {
            let v22 = 0x1::vector::borrow<0x1::ascii::String>(&v7, v21);
            let v23 = if (*v22 == v12) {
                *0x1::vector::borrow<u128>(&v6, v21)
            } else {
                0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::utils::get_amount_out(arg3, *v22, v12, arg4, arg5, (*0x1::vector::borrow<u128>(&v6, v21) as u64), arg6)
            };
            v17 = v17 + v23;
            v21 = v21 + 1;
        };
        if (v17 > v8) {
            v17 - v8
        } else {
            0
        }
    }

    public fun calculate_liquidity_mmt<T0, T1, T2, T3>(arg0: &0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T2, T3>, arg2: &0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>, arg3: &0x49e2fa4035f91c4c404f4738b9cfbd6213569fe6aaf4608da10e781b0a128c23::price_feed::PriceFeedConfig, arg4: &vector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>, arg5: &vector<0xae9d0a79257bb9926a99088b385e99ccbda3d3e58aefc74568c58ef54c7212f4::nodo_price_feed::NodoPriceFeedInfo>, arg6: &0x2::clock::Clock) : u128 {
        let (v0, v1) = 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::get_vault_asset_balances<T0, T1>(arg2);
        let v2 = v1;
        let v3 = v0;
        let (v4, v5) = 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::get_withdraw_asset_balances<T0, T1>(arg2);
        let v6 = v5;
        let v7 = v4;
        let v8 = 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::get_pending_redemptions<T0, T1>(arg2);
        let (v9, v10, _) = 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::get_exactly_token_amount_from_positions<T2, T3>(arg0, arg1, 0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>>(arg2));
        let v12 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>());
        let v13 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T2>());
        let v14 = 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T3>());
        let v15 = if (v13 == v12) {
            v9
        } else {
            0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::utils::get_amount_out(arg3, v13, v12, arg4, arg5, (v9 as u64), arg6)
        };
        let v16 = if (v14 == v12) {
            v10
        } else {
            0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::utils::get_amount_out(arg3, v14, v12, arg4, arg5, (v10 as u64), arg6)
        };
        let v17 = 0 + v15 + v16;
        let v18 = 0;
        while (v18 < 0x1::vector::length<0x1::ascii::String>(&v3)) {
            let v19 = 0x1::vector::borrow<0x1::ascii::String>(&v3, v18);
            let v20 = if (*v19 == v12) {
                *0x1::vector::borrow<u128>(&v2, v18)
            } else {
                0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::utils::get_amount_out(arg3, *v19, v12, arg4, arg5, (*0x1::vector::borrow<u128>(&v2, v18) as u64), arg6)
            };
            v17 = v17 + v20;
            v18 = v18 + 1;
        };
        let v21 = 0;
        while (v21 < 0x1::vector::length<0x1::ascii::String>(&v7)) {
            let v22 = 0x1::vector::borrow<0x1::ascii::String>(&v7, v21);
            let v23 = if (*v22 == v12) {
                *0x1::vector::borrow<u128>(&v6, v21)
            } else {
                0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::utils::get_amount_out(arg3, *v22, v12, arg4, arg5, (*0x1::vector::borrow<u128>(&v6, v21) as u64), arg6)
            };
            v17 = v17 + v23;
            v21 = v21 + 1;
        };
        if (v17 > v8) {
            v17 - v8
        } else {
            0
        }
    }

    public fun get_bluefin_position_liquidities(arg0: &0x5d712497367b93e0cfdd24a28f4e75bb73eed057d37269a7a123eb618953995e::bluefin_executor::BluefinExecutorConfig, arg1: vector<0x2::object::ID>) : (vector<0x2::object::ID>, vector<u128>) {
        0x5d712497367b93e0cfdd24a28f4e75bb73eed057d37269a7a123eb618953995e::bluefin_executor::get_position_liquidities(arg0, arg1)
    }

    public fun get_bluefin_vault_position_liquidities(arg0: &0x5d712497367b93e0cfdd24a28f4e75bb73eed057d37269a7a123eb618953995e::bluefin_executor::BluefinExecutorConfig, arg1: 0x2::object::ID) : (vector<0x2::object::ID>, vector<u128>) {
        0x5d712497367b93e0cfdd24a28f4e75bb73eed057d37269a7a123eb618953995e::bluefin_executor::get_vault_position_liquidities(arg0, arg1)
    }

    public fun get_bluefin_vault_position_value(arg0: &0x5d712497367b93e0cfdd24a28f4e75bb73eed057d37269a7a123eb618953995e::bluefin_executor::BluefinExecutorConfig, arg1: 0x2::object::ID) : (vector<0x2::object::ID>, vector<u128>, vector<u32>, vector<u32>) {
        0x5d712497367b93e0cfdd24a28f4e75bb73eed057d37269a7a123eb618953995e::bluefin_executor::get_vault_position_value(arg0, arg1)
    }

    public fun get_cetus_position_liquidities(arg0: &0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig, arg1: vector<0x2::object::ID>) : (vector<0x2::object::ID>, vector<u128>) {
        0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::get_position_liquidities(arg0, arg1)
    }

    public fun get_cetus_vault_position_liquidities(arg0: &0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig, arg1: 0x2::object::ID) : (vector<0x2::object::ID>, vector<u128>) {
        0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::get_vault_position_liquidities(arg0, arg1)
    }

    public fun get_cetus_vault_position_value(arg0: &0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig, arg1: 0x2::object::ID) : (vector<0x2::object::ID>, vector<u128>, vector<u32>, vector<u32>) {
        0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::get_vault_position_value(arg0, arg1)
    }

    public fun get_last_credit_profit<T0, T1>(arg0: &0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>) : (u64, u64, bool, u64) {
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::get_last_credit_profit<T0, T1>(arg0)
    }

    public fun get_mmt_position_liquidities(arg0: &0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig, arg1: vector<0x2::object::ID>) : (vector<0x2::object::ID>, vector<u128>) {
        0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::get_position_liquidities(arg0, arg1)
    }

    public fun get_mmt_vault_position_liquidities(arg0: &0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig, arg1: 0x2::object::ID) : (vector<0x2::object::ID>, vector<u128>) {
        0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::get_vault_position_liquidities(arg0, arg1)
    }

    public fun get_mmt_vault_position_value(arg0: &0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig, arg1: 0x2::object::ID) : (vector<0x2::object::ID>, vector<u128>, vector<u32>, vector<u32>) {
        0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::get_vault_position_value(arg0, arg1)
    }

    public fun get_vault_asset_balances<T0, T1>(arg0: &0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>) : (vector<0x1::ascii::String>, vector<u128>) {
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::get_vault_asset_balances<T0, T1>(arg0)
    }

    public fun get_vault_info_bluefin<T0, T1>(arg0: &0x5d712497367b93e0cfdd24a28f4e75bb73eed057d37269a7a123eb618953995e::bluefin_executor::BluefinExecutorConfig, arg1: &0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>) : (vector<0x2::object::ID>, vector<u128>, vector<u32>, vector<u32>, vector<0x1::ascii::String>, vector<u128>, vector<0x1::ascii::String>, vector<u128>) {
        let (v0, v1, v2, v3) = 0x5d712497367b93e0cfdd24a28f4e75bb73eed057d37269a7a123eb618953995e::bluefin_executor::get_vault_position_value(arg0, 0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>>(arg1));
        let (v4, v5) = 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::get_vault_asset_balances<T0, T1>(arg1);
        let (v6, v7) = 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::get_withdraw_asset_balances<T0, T1>(arg1);
        (v0, v1, v2, v3, v4, v5, v6, v7)
    }

    public fun get_vault_info_cetus<T0, T1>(arg0: &0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::CetusConfig, arg1: &0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>) : (vector<0x2::object::ID>, vector<u128>, vector<u32>, vector<u32>, vector<0x1::ascii::String>, vector<u128>, vector<0x1::ascii::String>, vector<u128>) {
        let (v0, v1, v2, v3) = 0xd94f8daf43ac5bad5873a0fdb5fd6c721b5c4af924a29e4036cacc306b850460::cetus_executor::get_vault_position_value(arg0, 0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>>(arg1));
        let (v4, v5) = 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::get_vault_asset_balances<T0, T1>(arg1);
        let (v6, v7) = 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::get_withdraw_asset_balances<T0, T1>(arg1);
        (v0, v1, v2, v3, v4, v5, v6, v7)
    }

    public fun get_vault_info_mmt<T0, T1>(arg0: &0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::MmtExecutorConfig, arg1: &0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>) : (vector<0x2::object::ID>, vector<u128>, vector<u32>, vector<u32>, vector<0x1::ascii::String>, vector<u128>, vector<0x1::ascii::String>, vector<u128>) {
        let (v0, v1, v2, v3) = 0x71da83eea4c31015c25114c556d01c93a25dc45e0c8b58b50c22bd15c18795d6::mmt_executor::get_vault_position_value(arg0, 0x2::object::id<0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>>(arg1));
        let (v4, v5) = 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::get_vault_asset_balances<T0, T1>(arg1);
        let (v6, v7) = 0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::get_withdraw_asset_balances<T0, T1>(arg1);
        (v0, v1, v2, v3, v4, v5, v6, v7)
    }

    public fun get_withdraw_asset_balances<T0, T1>(arg0: &0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::Vault<T0, T1>) : (vector<0x1::ascii::String>, vector<u128>) {
        0x4077a674df9e92a8d232e89b2b88b74061921d9955c52e8a517d7943758f22e0::vault::get_withdraw_asset_balances<T0, T1>(arg0)
    }

    // decompiled from Move bytecode v6
}

