module 0xde0c7967a1290bb17686f2f1c12602ded7c6b121383e3aca424f80f049967bc0::navi_vault {
    struct Vault<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        swap_pool_id: 0x2::object::ID,
        navi_pool_id: 0x2::object::ID,
        storage_id: 0x2::object::ID,
        oracle_id: 0x2::object::ID,
        incentive_v2_id: 0x2::object::ID,
        incentive_v3_id: 0x2::object::ID,
        asset_id: u8,
        account_cap: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap,
        withdraw_admin: address,
        config_version: u64,
        deposit_enabled: bool,
        swap_enabled: bool,
        withdraw_enabled: bool,
        recipient_hashes: vector<vector<u8>>,
        withdrawal_ids: 0x2::table::Table<vector<u8>, bool>,
    }

    struct NaviVaultCreated has copy, drop {
        vault_id: 0x2::object::ID,
        swap_pool_id: 0x2::object::ID,
        account: address,
        navi_pool_id: 0x2::object::ID,
        asset_id: u8,
        withdraw_admin: address,
        timestamp_ms: u64,
    }

    struct NaviFunded has copy, drop {
        vault_id: 0x2::object::ID,
        swap_pool_id: 0x2::object::ID,
        operator: address,
        amount: u64,
        timestamp_ms: u64,
    }

    struct NaviSwapExecuted has copy, drop {
        vault_id: 0x2::object::ID,
        swap_pool_id: 0x2::object::ID,
        trader: address,
        direction: u8,
        amount_in: u64,
        amount_out: u64,
        timestamp_ms: u64,
    }

    struct NaviWithdrawn has copy, drop {
        vault_id: 0x2::object::ID,
        swap_pool_id: 0x2::object::ID,
        operator: address,
        recipient: address,
        amount: u64,
        request_id: vector<u8>,
        config_version: u64,
        timestamp_ms: u64,
    }

    struct NaviConfigUpdated has copy, drop {
        vault_id: 0x2::object::ID,
        swap_pool_id: 0x2::object::ID,
        operator: address,
        withdraw_admin: address,
        deposit_enabled: bool,
        swap_enabled: bool,
        withdraw_enabled: bool,
        config_version: u64,
        timestamp_ms: u64,
    }

    struct NaviRecipientUpdated has copy, drop {
        vault_id: 0x2::object::ID,
        swap_pool_id: 0x2::object::ID,
        operator: address,
        commitment: vector<u8>,
        allowed: bool,
        config_version: u64,
        timestamp_ms: u64,
    }

    public fun account_address<T0, T1>(arg0: &Vault<T0, T1>) : address {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.account_cap)
    }

    fun assert_bound<T0, T1>(arg0: &0xde0c7967a1290bb17686f2f1c12602ded7c6b121383e3aca424f80f049967bc0::swap::SwapPool<T0, T1>, arg1: &Vault<T0, T1>) {
        assert!(arg1.swap_pool_id == 0xde0c7967a1290bb17686f2f1c12602ded7c6b121383e3aca424f80f049967bc0::swap::get_pool_id<T0, T1>(arg0), 1);
        0xde0c7967a1290bb17686f2f1c12602ded7c6b121383e3aca424f80f049967bc0::swap::assert_navi_vault<T0, T1>(arg0, 0x2::object::id<Vault<T0, T1>>(arg1));
    }

    fun assert_config<T0, T1>(arg0: &0xde0c7967a1290bb17686f2f1c12602ded7c6b121383e3aca424f80f049967bc0::swap::SwapPool<T0, T1>, arg1: &Vault<T0, T1>, arg2: &0xde0c7967a1290bb17686f2f1c12602ded7c6b121383e3aca424f80f049967bc0::swap::SwapPauseAdminCap<T0, T1>, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert_bound<T0, T1>(arg0, arg1);
        0xde0c7967a1290bb17686f2f1c12602ded7c6b121383e3aca424f80f049967bc0::swap::assert_navi_config_admin<T0, T1>(arg0, arg2, arg4);
        assert!(arg1.config_version == arg3, 4);
    }

    fun assert_market<T0, T1>(arg0: &Vault<T0, T1>, arg1: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg3: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg4: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive) {
        let v0 = if (arg0.storage_id == 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage>(arg1)) {
            if (arg0.navi_pool_id == 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>>(arg2)) {
                if (arg0.incentive_v2_id == 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive>(arg3)) {
                    arg0.incentive_v3_id == 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive>(arg4)
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 1);
    }

    fun authorize_withdraw<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64, arg2: address, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg6) == arg0.withdraw_admin, 3);
        assert!(arg0.withdraw_enabled, 2);
        assert!(arg0.config_version == arg5, 4);
        assert!(arg1 > 0, 8);
        assert!(0x1::vector::length<u8>(&arg4) == 32, 6);
        let v0 = recipient_commitment(0x2::object::id<Vault<T0, T1>>(arg0), arg2, arg3);
        assert!(0x1::vector::contains<vector<u8>>(&arg0.recipient_hashes, &v0), 5);
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg0.withdrawal_ids, arg4), 7);
        0x2::table::add<vector<u8>, bool>(&mut arg0.withdrawal_ids, arg4, true);
    }

    public fun buy<T0, T1>(arg0: &mut 0xde0c7967a1290bb17686f2f1c12602ded7c6b121383e3aca424f80f049967bc0::swap::SwapPool<T0, T1>, arg1: &mut Vault<T0, T1>, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg6: 0x2::coin::Coin<T1>, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert_bound<T0, T1>(arg0, arg1);
        assert!(arg1.swap_enabled && arg1.deposit_enabled, 2);
        let v0 = 0x2::coin::value<T1>(&arg6);
        let v1 = 0xde0c7967a1290bb17686f2f1c12602ded7c6b121383e3aca424f80f049967bc0::swap::settle_navi_buy<T0, T1>(arg0, 0x2::object::id<Vault<T0, T1>>(arg1), v0, arg7, arg8, arg9, arg10, arg11, arg12);
        deposit<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg11);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v1, arg12), 0x2::tx_context::sender(arg12));
        let v2 = NaviSwapExecuted{
            vault_id     : 0x2::object::id<Vault<T0, T1>>(arg1),
            swap_pool_id : arg1.swap_pool_id,
            trader       : 0x2::tx_context::sender(arg12),
            direction    : 1,
            amount_in    : v0,
            amount_out   : 0x2::balance::value<T0>(&v1),
            timestamp_ms : 0x2::clock::timestamp_ms(arg11),
        };
        0x2::event::emit<NaviSwapExecuted>(v2);
    }

    public fun create<T0, T1>(arg0: &mut 0xde0c7967a1290bb17686f2f1c12602ded7c6b121383e3aca424f80f049967bc0::swap::SwapPool<T0, T1>, arg1: &0xde0c7967a1290bb17686f2f1c12602ded7c6b121383e3aca424f80f049967bc0::swap::SwapPauseAdminCap<T0, T1>, arg2: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg4: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg5: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg6: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg7: u8, arg8: address, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        0xde0c7967a1290bb17686f2f1c12602ded7c6b121383e3aca424f80f049967bc0::swap::assert_navi_config_admin<T0, T1>(arg0, arg1, arg10);
        assert!(arg8 != @0x0, 3);
        assert!(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_market_id(arg2) == 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::get_market_id<T1>(arg3), 1);
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::verify_market_storage_incentive(arg2, arg6);
        assert!(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_coin_type(arg2, arg7) == 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>()), 1);
        let (_, _, _, v3, _, _, _, _, _, _, _, _) = 0xde0c7967a1290bb17686f2f1c12602ded7c6b121383e3aca424f80f049967bc0::swap::get_pool_info<T0, T1>(arg0);
        assert!(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::get_coin_decimal<T1>(arg3) == v3, 1);
        let v12 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::create_account(arg10);
        let v13 = new_vault<T0, T1>(0xde0c7967a1290bb17686f2f1c12602ded7c6b121383e3aca424f80f049967bc0::swap::get_pool_id<T0, T1>(arg0), 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>>(arg3), 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage>(arg2), 0x2::object::id<0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle>(arg4), 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive>(arg5), 0x2::object::id<0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive>(arg6), arg7, arg8, v12, arg10);
        let v14 = 0x2::object::id<Vault<T0, T1>>(&v13);
        0xde0c7967a1290bb17686f2f1c12602ded7c6b121383e3aca424f80f049967bc0::swap::bind_navi_vault<T0, T1>(arg0, v14, arg1, arg10);
        let v15 = NaviVaultCreated{
            vault_id       : v14,
            swap_pool_id   : v13.swap_pool_id,
            account        : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&v12),
            navi_pool_id   : v13.navi_pool_id,
            asset_id       : arg7,
            withdraw_admin : arg8,
            timestamp_ms   : 0x2::clock::timestamp_ms(arg9),
        };
        0x2::event::emit<NaviVaultCreated>(v15);
        0x2::transfer::share_object<Vault<T0, T1>>(v13);
    }

    fun deposit<T0, T1>(arg0: &Vault<T0, T1>, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg5: 0x2::coin::Coin<T1>, arg6: &0x2::clock::Clock) {
        assert_market<T0, T1>(arg0, arg1, arg2, arg3, arg4);
        assert!(0x2::coin::value<T1>(&arg5) > 0, 8);
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::deposit_with_account_cap<T1>(arg6, arg1, arg2, arg0.asset_id, arg5, arg3, arg4, &arg0.account_cap);
    }

    public(friend) fun deposit_bound_usdc<T0, T1>(arg0: &0xde0c7967a1290bb17686f2f1c12602ded7c6b121383e3aca424f80f049967bc0::swap::SwapPool<T0, T1>, arg1: &Vault<T0, T1>, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg6: 0x2::coin::Coin<T1>, arg7: &0x2::clock::Clock) {
        assert_bound<T0, T1>(arg0, arg1);
        assert!(arg1.deposit_enabled, 2);
        deposit<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    fun emit_config<T0, T1>(arg0: &Vault<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        let v0 = NaviConfigUpdated{
            vault_id         : 0x2::object::id<Vault<T0, T1>>(arg0),
            swap_pool_id     : arg0.swap_pool_id,
            operator         : 0x2::tx_context::sender(arg2),
            withdraw_admin   : arg0.withdraw_admin,
            deposit_enabled  : arg0.deposit_enabled,
            swap_enabled     : arg0.swap_enabled,
            withdraw_enabled : arg0.withdraw_enabled,
            config_version   : arg0.config_version,
            timestamp_ms     : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<NaviConfigUpdated>(v0);
    }

    public fun fund<T0, T1>(arg0: &0xde0c7967a1290bb17686f2f1c12602ded7c6b121383e3aca424f80f049967bc0::swap::SwapPool<T0, T1>, arg1: &mut Vault<T0, T1>, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg6: 0x2::coin::Coin<T1>, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        deposit_bound_usdc<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        let v0 = NaviFunded{
            vault_id     : 0x2::object::id<Vault<T0, T1>>(arg1),
            swap_pool_id : arg1.swap_pool_id,
            operator     : 0x2::tx_context::sender(arg8),
            amount       : 0x2::coin::value<T1>(&arg6),
            timestamp_ms : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::event::emit<NaviFunded>(v0);
    }

    fun new_vault<T0, T1>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: 0x2::object::ID, arg6: u8, arg7: address, arg8: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap, arg9: &mut 0x2::tx_context::TxContext) : Vault<T0, T1> {
        Vault<T0, T1>{
            id               : 0x2::object::new(arg9),
            swap_pool_id     : arg0,
            navi_pool_id     : arg1,
            storage_id       : arg2,
            oracle_id        : arg3,
            incentive_v2_id  : arg4,
            incentive_v3_id  : arg5,
            asset_id         : arg6,
            account_cap      : arg8,
            withdraw_admin   : arg7,
            config_version   : 1,
            deposit_enabled  : false,
            swap_enabled     : false,
            withdraw_enabled : false,
            recipient_hashes : vector[],
            withdrawal_ids   : 0x2::table::new<vector<u8>, bool>(arg9),
        }
    }

    public fun recipient_commitment(arg0: 0x2::object::ID, arg1: address, arg2: vector<u8>) : vector<u8> {
        assert!(0x1::vector::length<u8>(&arg2) == 32 && arg1 != @0x0, 6);
        let v0 = b"AST_NAVI_RECIPIENT_V1";
        0x1::vector::append<u8>(&mut v0, 0x2::object::id_to_bytes(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&arg1));
        0x1::vector::append<u8>(&mut v0, arg2);
        0x2::hash::blake2b256(&v0)
    }

    fun redeem<T0, T1>(arg0: &Vault<T0, T1>, arg1: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg6: u64, arg7: &0x2::clock::Clock) : 0x2::balance::Balance<T1> {
        assert_market<T0, T1>(arg0, arg2, arg3, arg4, arg5);
        assert!(arg0.oracle_id == 0x2::object::id<0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle>(arg1), 1);
        let v0 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::withdraw_with_account_cap<T1>(arg7, arg1, arg2, arg3, arg0.asset_id, arg6, arg4, arg5, &arg0.account_cap);
        assert!(0x2::balance::value<T1>(&v0) == arg6, 8);
        v0
    }

    public fun sell<T0, T1>(arg0: &mut 0xde0c7967a1290bb17686f2f1c12602ded7c6b121383e3aca424f80f049967bc0::swap::SwapPool<T0, T1>, arg1: &mut Vault<T0, T1>, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg7: 0x2::coin::Coin<T0>, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        assert_bound<T0, T1>(arg0, arg1);
        assert!(arg1.swap_enabled, 2);
        let v0 = 0xde0c7967a1290bb17686f2f1c12602ded7c6b121383e3aca424f80f049967bc0::swap::settle_navi_sell<T0, T1>(arg0, 0x2::object::id<Vault<T0, T1>>(arg1), arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(redeem<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, v0, arg12), arg13), 0x2::tx_context::sender(arg13));
        let v1 = NaviSwapExecuted{
            vault_id     : 0x2::object::id<Vault<T0, T1>>(arg1),
            swap_pool_id : arg1.swap_pool_id,
            trader       : 0x2::tx_context::sender(arg13),
            direction    : 2,
            amount_in    : 0x2::coin::value<T0>(&arg7),
            amount_out   : v0,
            timestamp_ms : 0x2::clock::timestamp_ms(arg12),
        };
        0x2::event::emit<NaviSwapExecuted>(v1);
    }

    public fun set_flags<T0, T1>(arg0: &0xde0c7967a1290bb17686f2f1c12602ded7c6b121383e3aca424f80f049967bc0::swap::SwapPool<T0, T1>, arg1: &mut Vault<T0, T1>, arg2: &0xde0c7967a1290bb17686f2f1c12602ded7c6b121383e3aca424f80f049967bc0::swap::SwapPauseAdminCap<T0, T1>, arg3: bool, arg4: bool, arg5: bool, arg6: u64, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        assert_config<T0, T1>(arg0, arg1, arg2, arg6, arg8);
        arg1.deposit_enabled = arg3;
        arg1.swap_enabled = arg4;
        arg1.withdraw_enabled = arg5;
        arg1.config_version = arg1.config_version + 1;
        emit_config<T0, T1>(arg1, arg7, arg8);
    }

    public fun set_recipient<T0, T1>(arg0: &0xde0c7967a1290bb17686f2f1c12602ded7c6b121383e3aca424f80f049967bc0::swap::SwapPool<T0, T1>, arg1: &mut Vault<T0, T1>, arg2: &0xde0c7967a1290bb17686f2f1c12602ded7c6b121383e3aca424f80f049967bc0::swap::SwapPauseAdminCap<T0, T1>, arg3: vector<u8>, arg4: bool, arg5: u64, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        assert_config<T0, T1>(arg0, arg1, arg2, arg5, arg7);
        assert!(0x1::vector::length<u8>(&arg3) == 32, 6);
        let (v0, v1) = 0x1::vector::index_of<vector<u8>>(&arg1.recipient_hashes, &arg3);
        if (arg4 && !v0) {
            0x1::vector::push_back<vector<u8>>(&mut arg1.recipient_hashes, arg3);
        };
        if (!arg4 && v0) {
            0x1::vector::remove<vector<u8>>(&mut arg1.recipient_hashes, v1);
        };
        arg1.config_version = arg1.config_version + 1;
        let v2 = NaviRecipientUpdated{
            vault_id       : 0x2::object::id<Vault<T0, T1>>(arg1),
            swap_pool_id   : arg1.swap_pool_id,
            operator       : 0x2::tx_context::sender(arg7),
            commitment     : arg3,
            allowed        : arg4,
            config_version : arg1.config_version,
            timestamp_ms   : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<NaviRecipientUpdated>(v2);
    }

    public fun set_withdraw_admin<T0, T1>(arg0: &0xde0c7967a1290bb17686f2f1c12602ded7c6b121383e3aca424f80f049967bc0::swap::SwapPool<T0, T1>, arg1: &mut Vault<T0, T1>, arg2: &0xde0c7967a1290bb17686f2f1c12602ded7c6b121383e3aca424f80f049967bc0::swap::SwapPauseAdminCap<T0, T1>, arg3: address, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert_config<T0, T1>(arg0, arg1, arg2, arg4, arg6);
        assert!(arg3 != @0x0, 3);
        arg1.withdraw_admin = arg3;
        arg1.config_version = arg1.config_version + 1;
        emit_config<T0, T1>(arg1, arg5, arg6);
    }

    public fun withdraw<T0, T1>(arg0: &0xde0c7967a1290bb17686f2f1c12602ded7c6b121383e3aca424f80f049967bc0::swap::SwapPool<T0, T1>, arg1: &mut Vault<T0, T1>, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg7: u64, arg8: address, arg9: vector<u8>, arg10: vector<u8>, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        assert_bound<T0, T1>(arg0, arg1);
        authorize_withdraw<T0, T1>(arg1, arg7, arg8, arg9, arg10, arg11, arg13);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(redeem<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg12), arg13), arg8);
        let v0 = NaviWithdrawn{
            vault_id       : 0x2::object::id<Vault<T0, T1>>(arg1),
            swap_pool_id   : arg1.swap_pool_id,
            operator       : 0x2::tx_context::sender(arg13),
            recipient      : arg8,
            amount         : arg7,
            request_id     : arg10,
            config_version : arg1.config_version,
            timestamp_ms   : 0x2::clock::timestamp_ms(arg12),
        };
        0x2::event::emit<NaviWithdrawn>(v0);
    }

    // decompiled from Move bytecode v7
}

