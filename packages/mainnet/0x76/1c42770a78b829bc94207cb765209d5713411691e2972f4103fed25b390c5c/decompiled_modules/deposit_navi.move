module 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::deposit_navi {
    struct DepositEvent has copy, drop {
        vault_id: 0x2::object::ID,
        deposit_type: 0x1::type_name::TypeName,
        vt_type: 0x1::type_name::TypeName,
        deposit_amount: u64,
        vt_amount: u64,
        total_deposited: u64,
        total_vt_supply: u64,
    }

    public fun deposit<T0, T1>(arg0: &mut 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::Vault<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg6: &0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::version::Version, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::version::assert_current_version(arg6);
        assert!(0x2::balance::value<T0>(&arg1) > 0, 43);
        let v0 = 0x2::balance::value<T0>(&arg1);
        let v1 = 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::utils::safe_mul_div(v0, 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::total_vt_supply<T0, T1>(arg0), 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::deposited<T0, T1>(arg0, arg3, arg2));
        0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::deposit<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg7, arg8);
        let v2 = DepositEvent{
            vault_id        : 0x2::object::id<0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::Vault<T0, T1>>(arg0),
            deposit_type    : 0x1::type_name::get<T0>(),
            vt_type         : 0x1::type_name::get<T1>(),
            deposit_amount  : v0,
            vt_amount       : v1,
            total_deposited : 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::deposited<T0, T1>(arg0, arg3, arg2),
            total_vt_supply : 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::total_vt_supply<T0, T1>(arg0),
        };
        0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::event::emit<DepositEvent>(v2);
        0x2::coin::into_balance<T1>(0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::mint_vt<T0, T1>(arg0, v1, arg8))
    }

    public fun deposit_<T0, T1>(arg0: &mut 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::Vault<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg6: &0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::version::Version, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::version::assert_current_version(arg6);
        assert!(0x2::balance::value<T0>(&arg1) > 0, 43);
        let v0 = 0x2::balance::value<T0>(&arg1);
        let v1 = 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::utils::safe_mul_div(v0, 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::total_vt_supply<T0, T1>(arg0), 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::deposited<T0, T1>(arg0, arg3, arg2));
        0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::deposit_<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg7, arg8);
        let v2 = DepositEvent{
            vault_id        : 0x2::object::id<0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::Vault<T0, T1>>(arg0),
            deposit_type    : 0x1::type_name::get<T0>(),
            vt_type         : 0x1::type_name::get<T1>(),
            deposit_amount  : v0,
            vt_amount       : v1,
            total_deposited : 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::deposited<T0, T1>(arg0, arg3, arg2),
            total_vt_supply : 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::total_vt_supply<T0, T1>(arg0),
        };
        0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::event::emit<DepositEvent>(v2);
        0x2::coin::into_balance<T1>(0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::mint_vt<T0, T1>(arg0, v1, arg8))
    }

    public fun get_deposited_in_navi<T0>(arg0: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg2: u8, arg3: address) : u64 {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::unnormal_amount<T0>(arg1, (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_collateral_balance(arg0, arg2, arg3) as u64))
    }

    public fun migrate_and_deposit<T0, T1>(arg0: &mut 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::Vault<T0, T1>, arg1: u64, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg6: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::version::Version, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let v0 = get_deposited_in_navi<T0>(arg2, arg3, 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::deposit_asset_index<T0, T1>(arg0), 0x2::tx_context::sender(arg9));
        assert!(v0 > arg1, 32);
        let v1 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::withdraw<T0>(arg8, arg6, arg2, arg3, 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::deposit_asset_index<T0, T1>(arg0), arg1, arg4, arg5, arg9);
        deposit<T0, T1>(arg0, v1, arg2, arg3, arg4, arg5, arg7, arg8, arg9)
    }

    // decompiled from Move bytecode v6
}

