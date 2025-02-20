module 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::withdraw_navi {
    struct WithdrawEvent has copy, drop {
        vault_id: 0x2::object::ID,
        deposit_type: 0x1::type_name::TypeName,
        vt_type: 0x1::type_name::TypeName,
        withdraw_amount: u64,
        vt_amount: u64,
        total_deposited: u64,
        total_vt_supply: u64,
    }

    public fun withdraw<T0, T1>(arg0: &mut 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::Vault<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg6: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::version::Version, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::version::assert_current_version(arg7);
        assert!(0x2::balance::value<T1>(&arg1) > 0, 32);
        let v0 = 0x2::balance::value<T1>(&arg1);
        let v1 = 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::utils::safe_mul_div(v0, 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::deposited<T0, T1>(arg0, arg3, arg2), 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::total_vt_supply<T0, T1>(arg0));
        0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::burn_vt<T0, T1>(arg0, 0x2::coin::from_balance<T1>(arg1, arg9));
        let v2 = WithdrawEvent{
            vault_id        : 0x2::object::id<0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::Vault<T0, T1>>(arg0),
            deposit_type    : 0x1::type_name::get<T0>(),
            vt_type         : 0x1::type_name::get<T1>(),
            withdraw_amount : v1,
            vt_amount       : v0,
            total_deposited : 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::deposited<T0, T1>(arg0, arg3, arg2),
            total_vt_supply : 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::total_vt_supply<T0, T1>(arg0),
        };
        0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::event::emit<WithdrawEvent>(v2);
        let v3 = 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::withdraw<T0, T1>(arg0, v1, arg2, arg3, arg4, arg5, arg6, arg8);
        let (v4, v5) = 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::withdrawal_fees<T0, T1>(arg0);
        0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::navi_vault::collect_withdrawal_fees<T0, T1>(arg0, 0x2::balance::split<T0>(&mut v3, 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::utils::safe_mul_div(v0, v4, v5)));
        v3
    }

    // decompiled from Move bytecode v6
}

