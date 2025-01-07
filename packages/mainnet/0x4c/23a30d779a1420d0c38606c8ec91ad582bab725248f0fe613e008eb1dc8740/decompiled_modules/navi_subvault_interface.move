module 0x4c23a30d779a1420d0c38606c8ec91ad582bab725248f0fe613e008eb1dc8740::navi_subvault_interface {
    struct NaviVaultParams<phantom T0, phantom T1> {
        storage: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage,
        vault: 0x4c23a30d779a1420d0c38606c8ec91ad582bab725248f0fe613e008eb1dc8740::navi_subvault::NaviSubVault<T0, T1>,
    }

    public fun create_vault<T0, T1>(arg0: &0xc3ad71130e000268b4f098db9137babe318551a7bdd5365204117ace8fcb048c::admin::AdminCap, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) {
        0x4c23a30d779a1420d0c38606c8ec91ad582bab725248f0fe613e008eb1dc8740::navi_subvault::create_vault<T0, T1>(arg1, arg2);
    }

    public fun toggle_deposits<T0, T1>(arg0: &0xc3ad71130e000268b4f098db9137babe318551a7bdd5365204117ace8fcb048c::admin::AdminCap, arg1: &mut 0x4c23a30d779a1420d0c38606c8ec91ad582bab725248f0fe613e008eb1dc8740::navi_subvault::NaviSubVault<T0, T1>, arg2: bool) {
        0x4c23a30d779a1420d0c38606c8ec91ad582bab725248f0fe613e008eb1dc8740::navi_subvault::toggle_deposits<T0, T1>(arg1, arg2);
    }

    public fun uid<T0, T1>(arg0: &0xc3ad71130e000268b4f098db9137babe318551a7bdd5365204117ace8fcb048c::admin::AdminCap, arg1: &mut 0x4c23a30d779a1420d0c38606c8ec91ad582bab725248f0fe613e008eb1dc8740::navi_subvault::NaviSubVault<T0, T1>) : &mut 0x2::object::UID {
        0x4c23a30d779a1420d0c38606c8ec91ad582bab725248f0fe613e008eb1dc8740::navi_subvault::uid<T0, T1>(arg1)
    }

    public fun claim_rewards<T0, T1, T2>(arg0: &mut 0x4c23a30d779a1420d0c38606c8ec91ad582bab725248f0fe613e008eb1dc8740::navi_subvault::NaviSubVault<T0, T1>, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<T2>, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg4: &0xc3ad71130e000268b4f098db9137babe318551a7bdd5365204117ace8fcb048c::admin::AdminCap, arg5: u8, arg6: &0x2::clock::Clock, arg7: &0x4c23a30d779a1420d0c38606c8ec91ad582bab725248f0fe613e008eb1dc8740::version::Version, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0x4c23a30d779a1420d0c38606c8ec91ad582bab725248f0fe613e008eb1dc8740::version::assert_current_version(arg7);
        let v0 = 0x2::coin::from_balance<T2>(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::claim_reward_non_entry<T2>(arg6, arg3, arg1, arg2, 0x4c23a30d779a1420d0c38606c8ec91ad582bab725248f0fe613e008eb1dc8740::navi_subvault::asset_id<T0, T1>(arg0), arg5, arg8), arg8);
        0x4c23a30d779a1420d0c38606c8ec91ad582bab725248f0fe613e008eb1dc8740::navi_events::navi_vault_rewards_claimed(0x2::object::id_address<0x4c23a30d779a1420d0c38606c8ec91ad582bab725248f0fe613e008eb1dc8740::navi_subvault::NaviSubVault<T0, T1>>(arg0), 0x2::coin::value<T2>(&v0));
        v0
    }

    public fun public_deposit<T0, T1>(arg0: &mut 0x4c23a30d779a1420d0c38606c8ec91ad582bab725248f0fe613e008eb1dc8740::navi_subvault::NaviSubVault<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg6: &mut 0xe8b64e5c5fb006a7cca7c1f516ae66ac087884524948a033fc3822ee93e8da93::session_async::SessionAsync<T0, T1>, arg7: &0x2::clock::Clock, arg8: &0x4c23a30d779a1420d0c38606c8ec91ad582bab725248f0fe613e008eb1dc8740::version::Version, arg9: &mut 0x2::tx_context::TxContext) {
        0x4c23a30d779a1420d0c38606c8ec91ad582bab725248f0fe613e008eb1dc8740::version::assert_current_version(arg8);
        assert!(0x4c23a30d779a1420d0c38606c8ec91ad582bab725248f0fe613e008eb1dc8740::navi_subvault::deposits_open<T0, T1>(arg0), 9223372238718238721);
        assert!(0xe8b64e5c5fb006a7cca7c1f516ae66ac087884524948a033fc3822ee93e8da93::session_async::kind<T0, T1>(arg6) == 0xe8b64e5c5fb006a7cca7c1f516ae66ac087884524948a033fc3822ee93e8da93::session_async::deposit_kind(), 9223372243013337091);
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::entry_deposit<T0>(arg7, arg2, arg3, 0x4c23a30d779a1420d0c38606c8ec91ad582bab725248f0fe613e008eb1dc8740::navi_subvault::asset_id<T0, T1>(arg0), arg1, 0xe8b64e5c5fb006a7cca7c1f516ae66ac087884524948a033fc3822ee93e8da93::session_async::value<T0, T1>(arg6), arg4, arg5, arg9);
        0x4c23a30d779a1420d0c38606c8ec91ad582bab725248f0fe613e008eb1dc8740::navi_events::navi_vault_deposit(0x2::object::id_address<0x4c23a30d779a1420d0c38606c8ec91ad582bab725248f0fe613e008eb1dc8740::navi_subvault::NaviSubVault<T0, T1>>(arg0), 0xe8b64e5c5fb006a7cca7c1f516ae66ac087884524948a033fc3822ee93e8da93::session_async::value<T0, T1>(arg6));
        0xe8b64e5c5fb006a7cca7c1f516ae66ac087884524948a033fc3822ee93e8da93::session_async::mark_done<T0, T1>(0x4c23a30d779a1420d0c38606c8ec91ad582bab725248f0fe613e008eb1dc8740::navi_subvault::uid<T0, T1>(arg0), arg6);
    }

    public fun public_withdraw<T0, T1>(arg0: &mut 0x4c23a30d779a1420d0c38606c8ec91ad582bab725248f0fe613e008eb1dc8740::navi_subvault::NaviSubVault<T0, T1>, arg1: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg3: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg6: &mut 0xe8b64e5c5fb006a7cca7c1f516ae66ac087884524948a033fc3822ee93e8da93::session_async::SessionAsync<T0, T1>, arg7: &0x2::clock::Clock, arg8: &0x4c23a30d779a1420d0c38606c8ec91ad582bab725248f0fe613e008eb1dc8740::version::Version, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x4c23a30d779a1420d0c38606c8ec91ad582bab725248f0fe613e008eb1dc8740::version::assert_current_version(arg8);
        assert!(0xe8b64e5c5fb006a7cca7c1f516ae66ac087884524948a033fc3822ee93e8da93::session_async::kind<T0, T1>(arg6) == 0xe8b64e5c5fb006a7cca7c1f516ae66ac087884524948a033fc3822ee93e8da93::session_async::withdraw_kind(), 9223372389042225155);
        let v0 = 0x2::coin::from_balance<T0>(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::withdraw<T0>(arg7, arg3, arg1, arg2, 0x4c23a30d779a1420d0c38606c8ec91ad582bab725248f0fe613e008eb1dc8740::navi_subvault::asset_id<T0, T1>(arg0), 0xe8b64e5c5fb006a7cca7c1f516ae66ac087884524948a033fc3822ee93e8da93::session_async::value<T0, T1>(arg6), arg4, arg5, arg9), arg9);
        0x4c23a30d779a1420d0c38606c8ec91ad582bab725248f0fe613e008eb1dc8740::navi_events::navi_vault_withdraw(0x2::object::id_address<0x4c23a30d779a1420d0c38606c8ec91ad582bab725248f0fe613e008eb1dc8740::navi_subvault::NaviSubVault<T0, T1>>(arg0), 0x2::coin::value<T0>(&v0));
        0xe8b64e5c5fb006a7cca7c1f516ae66ac087884524948a033fc3822ee93e8da93::session_async::mark_done<T0, T1>(0x4c23a30d779a1420d0c38606c8ec91ad582bab725248f0fe613e008eb1dc8740::navi_subvault::uid<T0, T1>(arg0), arg6);
        v0
    }

    public fun start_admin_withdraw<T0, T1>(arg0: &0xc3ad71130e000268b4f098db9137babe318551a7bdd5365204117ace8fcb048c::admin::AdminCap, arg1: &mut 0x4c23a30d779a1420d0c38606c8ec91ad582bab725248f0fe613e008eb1dc8740::navi_subvault::NaviSubVault<T0, T1>, arg2: u64, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg8: &0x2::clock::Clock, arg9: &0x4c23a30d779a1420d0c38606c8ec91ad582bab725248f0fe613e008eb1dc8740::version::Version, arg10: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0xe8b64e5c5fb006a7cca7c1f516ae66ac087884524948a033fc3822ee93e8da93::session_async::SessionAsync<T0, T1>) {
        0x4c23a30d779a1420d0c38606c8ec91ad582bab725248f0fe613e008eb1dc8740::version::assert_current_version(arg9);
        let v0 = 0x2::coin::from_balance<T0>(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::withdraw<T0>(arg8, arg5, arg3, arg4, 0x4c23a30d779a1420d0c38606c8ec91ad582bab725248f0fe613e008eb1dc8740::navi_subvault::asset_id<T0, T1>(arg1), arg2, arg6, arg7, arg10), arg10);
        let v1 = 0xe8b64e5c5fb006a7cca7c1f516ae66ac087884524948a033fc3822ee93e8da93::session_async::create_session<T0, T1>(0x4c23a30d779a1420d0c38606c8ec91ad582bab725248f0fe613e008eb1dc8740::navi_subvault::uid<T0, T1>(arg1), arg2, 0xe8b64e5c5fb006a7cca7c1f516ae66ac087884524948a033fc3822ee93e8da93::session_async::withdraw_kind());
        0xe8b64e5c5fb006a7cca7c1f516ae66ac087884524948a033fc3822ee93e8da93::session_async::mark_done<T0, T1>(0x4c23a30d779a1420d0c38606c8ec91ad582bab725248f0fe613e008eb1dc8740::navi_subvault::uid<T0, T1>(arg1), &mut v1);
        0x4c23a30d779a1420d0c38606c8ec91ad582bab725248f0fe613e008eb1dc8740::navi_events::navi_vault_withdraw(0x2::object::id_address<0x4c23a30d779a1420d0c38606c8ec91ad582bab725248f0fe613e008eb1dc8740::navi_subvault::NaviSubVault<T0, T1>>(arg1), 0x2::coin::value<T0>(&v0));
        (v0, v1)
    }

    public fun total_assets<T0, T1>(arg0: &mut NaviVaultParams<T0, T1>) : u64 {
        let (v0, _) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_user_balance(&mut arg0.storage, 0x4c23a30d779a1420d0c38606c8ec91ad582bab725248f0fe613e008eb1dc8740::navi_subvault::asset_id<T0, T1>(&arg0.vault), 0x2::object::id_address<0x4c23a30d779a1420d0c38606c8ec91ad582bab725248f0fe613e008eb1dc8740::navi_subvault::NaviSubVault<T0, T1>>(&arg0.vault));
        (v0 as u64)
    }

    // decompiled from Move bytecode v6
}

