module 0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::deposit {
    struct DepositEvent has copy, drop, store {
        vault_id: 0x2::object::ID,
        user: address,
        deposit_amount: u64,
        lp_shares_minted: u64,
        total_deposited_a: u64,
        total_borrowed_b: u64,
        aum_in_a: u64,
        total_lp_supply: u64,
    }

    public fun calc_vt_shares<T0, T1, T2>(arg0: &0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::vault::Vault<T0, T1, T2>, arg1: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg2: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg3: &0x7903ed759a2e2749ecdb64a8f100b0a547185f2ef7ea286048aa1f174c8a8b9a::oracle::KriyaOracle, arg4: &0xa0f0687f5122e80366716e6594d9a5aae2015b24003d9bcb6b4576af357635b2::registry::CoinDecimalsRegistry, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg6: u64, arg7: &0x2::clock::Clock) : u64 {
        let v0 = 0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::vault::total_vt_supply<T0, T1, T2>(arg0);
        if (v0 == 0) {
            return arg6
        };
        let (v1, _, _) = 0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::utils::calc_aum<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg7);
        (((arg6 as u256) * (v0 as u256) / (v1 as u256)) as u64)
    }

    fun get_deposit_flash_swap_amount(arg0: u64, arg1: u64) : u64 {
        (((arg1 as u256) * (((arg0 as u64) - 0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::vault::leverage_scaling()) as u256) / (0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::vault::leverage_scaling() as u256)) as u64)
    }

    public fun get_deposit_receipt<T0, T1, T2>(arg0: &0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::vault::Vault<T0, T1, T2>, arg1: 0x2::coin::Coin<T0>, arg2: &0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::vault_acl::VaultAcl, arg3: &0x5b39a0546472916a91febe47e5dd680775c7fcc2aa57e481d942e7fc696c822::acl::AggregatorAcl, arg4: &0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::version::Version, arg5: &mut 0x2::tx_context::TxContext) : 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt {
        0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::version::assert_current_version(arg4);
        let v0 = 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::issue<0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::vault_acl::Access>(0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::vault_acl::access(arg2), 0x1::option::some<0x2::object::ID>(0x5b39a0546472916a91febe47e5dd680775c7fcc2aa57e481d942e7fc696c822::acl::access_id(arg3)), arg5);
        let (v1, v2) = 0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::vault::slippage<T0, T1, T2>(arg0);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u128, 0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::vault_acl::Access>(&mut v0, 0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::vault_acl::access(arg2), b"slippage_up", v1);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u128, 0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::vault_acl::Access>(&mut v0, 0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::vault_acl::access(arg2), b"slippage_down", v2);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x2::balance::Balance<T0>, 0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::vault_acl::Access>(&mut v0, 0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::vault_acl::access(arg2), b"deposit_balance", 0x2::coin::into_balance<T0>(arg1));
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u64, 0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::vault_acl::Access>(&mut v0, 0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::vault_acl::access(arg2), b"amount", get_deposit_flash_swap_amount(0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::vault::leverage<T0, T1, T2>(arg0), 0x2::coin::value<T0>(&arg1)));
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x1::type_name::TypeName, 0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::vault_acl::Access>(&mut v0, 0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::vault_acl::access(arg2), b"input_type", 0x1::type_name::get<T1>());
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, bool, 0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::vault_acl::Access>(&mut v0, 0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::vault_acl::access(arg2), b"fix_input", false);
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x2::object::ID, 0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::vault_acl::Access>(&mut v0, 0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::vault_acl::access(arg2), b"pool_id", 0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::vault::pool_id<T0, T1, T2>(arg0));
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, u8, 0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::vault_acl::Access>(&mut v0, 0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::vault_acl::access(arg2), b"flow_id", 0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::utils::deposit_flow_id());
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x2::object::ID, 0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::vault_acl::Access>(&mut v0, 0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::vault_acl::access(arg2), b"vault_id", 0x2::object::id<0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::vault::Vault<T0, T1, T2>>(arg0));
        v0
    }

    public fun process_deposit_receipt<T0, T1, T2>(arg0: &mut 0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::vault::Vault<T0, T1, T2>, arg1: &0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::vault_acl::VaultAcl, arg2: &mut 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::PermissionedReceipt, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg8: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg9: &0x7903ed759a2e2749ecdb64a8f100b0a547185f2ef7ea286048aa1f174c8a8b9a::oracle::KriyaOracle, arg10: &0xa0f0687f5122e80366716e6594d9a5aae2015b24003d9bcb6b4576af357635b2::registry::CoinDecimalsRegistry, arg11: &0x2::clock::Clock, arg12: &0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::version::Version, arg13: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::version::assert_current_version(arg12);
        let v0 = 0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::vault_acl::access(arg1);
        assert!(0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, u8, 0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::vault_acl::Access>(arg2, v0, b"flow_id") == 0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::utils::deposit_flow_id(), 0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::error::invalid_flow_id());
        assert!(0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x2::object::ID, 0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::vault_acl::Access>(arg2, v0, b"vault_id") == 0x2::object::id<0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::vault::Vault<T0, T1, T2>>(arg0), 0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::error::invalid_vault());
        let v1 = 0x2::coin::from_balance<T0>(0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x2::balance::Balance<T0>, 0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::vault_acl::Access>(arg2, v0, b"deposit_balance"), arg13);
        let v2 = 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, 0x2::balance::Balance<T0>, 0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::vault_acl::Access>(arg2, v0, b"funds");
        let v3 = 0x2::coin::value<T0>(&v1);
        let v4 = calc_vt_shares<T0, T1, T2>(arg0, arg4, arg5, arg9, arg10, arg3, ((((v3 + 0x2::balance::value<T0>(&v2)) as u128) * (0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::vault::leverage_scaling() as u128) / (0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::vault::leverage<T0, T1, T2>(arg0) as u128)) as u64), arg11);
        0x2::coin::join<T0>(&mut v1, 0x2::coin::from_balance<T0>(v2, arg13));
        0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::add_data<vector<u8>, 0x2::balance::Balance<T1>, 0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::vault_acl::Access>(arg2, 0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::vault_acl::access(arg1), b"funds", 0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::vault::deposit<T0, T1, T2>(arg0, v1, 0xfe579a58d32d38e154a8c0d4aa646238851f340258d10c7482cef9bea165b823::receipt::remove_data<vector<u8>, u64, 0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::vault_acl::Access>(arg2, v0, b"repay_amount"), arg3, arg4, arg5, arg6, arg7, arg8, arg11));
        let v5 = 0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::vault::mint_vt<T0, T1, T2>(arg0, v4, arg13);
        let (v6, v7, v8) = 0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::utils::calc_aum<T0, T1, T2>(arg0, arg4, arg5, arg9, arg10, arg3, arg11);
        0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::vault::assert_deposits_enabled<T0, T1, T2>(arg0, v6);
        let v9 = DepositEvent{
            vault_id          : 0x2::object::id<0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::vault::Vault<T0, T1, T2>>(arg0),
            user              : 0x2::tx_context::sender(arg13),
            deposit_amount    : v3,
            lp_shares_minted  : 0x2::coin::value<T2>(&v5),
            total_deposited_a : v7,
            total_borrowed_b  : v8,
            aum_in_a          : v6,
            total_lp_supply   : 0x7b26d048716351ca9a820247fe5afb6d5058dc51171da1858eb6ab8b772ba5ed::vault::total_vt_supply<T0, T1, T2>(arg0),
        };
        0x2::event::emit<DepositEvent>(v9);
        v5
    }

    // decompiled from Move bytecode v6
}

