module 0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::policy_wallet {
    struct PolicyWallet has key {
        id: 0x2::object::UID,
        creator: address,
        signers: vector<address>,
        threshold: u64,
        admin_threshold: u64,
        timelock_spend_ms: u64,
        timelock_admin_ms: u64,
        request_expiry_ms: u64,
        paused: bool,
        setup_complete: bool,
        dwallets: 0x2::table::Table<u32, DWalletEntry>,
        presigns: 0x2::table::Table<PresignKey, vector<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPresignCap>>,
        network_encryption_key_id: 0x2::object::ID,
        ika_balance: 0x2::balance::Balance<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>,
        sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        chains: 0x2::table::Table<vector<u8>, ChainPolicy>,
        address_book: 0x2::table::Table<vector<u8>, vector<u8>>,
        requests: 0x2::table::Table<u64, SpendRequest>,
        request_counter: u64,
        proposals: 0x2::table::Table<u64, AdminProposal>,
        proposal_counter: u64,
        vault: 0x2::bag::Bag,
    }

    struct SignerCap has key {
        id: 0x2::object::UID,
        wallet_id: 0x2::object::ID,
    }

    struct DWalletEntry has store {
        cap: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap,
        dwallet_id: 0x2::object::ID,
    }

    struct PresignKey has copy, drop, store {
        curve: u32,
        signature_algorithm: u32,
    }

    struct ChainPolicy has store {
        kind: u8,
        enabled: bool,
        evm_chain_id: u128,
        curve: u32,
        signature_algorithm: u32,
        hash_scheme: u32,
        fast_path_limit: u128,
        per_tx_limit: u128,
        window_limit: u128,
        window_ms: u64,
        spent_in_window: u128,
        window_started_at_ms: u64,
        fee_limit: u128,
        allowlist_enabled: bool,
        allowlist: 0x2::vec_set::VecSet<vector<u8>>,
        blocklist: 0x2::vec_set::VecSet<vector<u8>>,
        allow_unverified: bool,
    }

    struct SpendRequest has store {
        id: u64,
        creator: address,
        chain_key: vector<u8>,
        asset: vector<u8>,
        destination: vector<u8>,
        amount: u128,
        verified_intent: bool,
        messages: vector<vector<u8>>,
        aux: vector<vector<u8>>,
        partial_sig_caps: vector<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPartialUserSignatureCap>,
        curve: u32,
        signature_algorithm: u32,
        hash_scheme: u32,
        approvals: 0x2::vec_set::VecSet<address>,
        rejections: 0x2::vec_set::VecSet<address>,
        created_at_ms: u64,
        threshold_reached_at_ms: u64,
        status: u8,
        sign_ids: vector<0x2::object::ID>,
    }

    struct AdminProposal has store {
        id: u64,
        creator: address,
        action: u8,
        chain_key: vector<u8>,
        addr_param: 0x1::option::Option<address>,
        bytes_param: vector<u8>,
        u_params: vector<u128>,
        bool_param: bool,
        approvals: 0x2::vec_set::VecSet<address>,
        rejections: 0x2::vec_set::VecSet<address>,
        created_at_ms: u64,
        threshold_reached_at_ms: u64,
        status: u8,
    }

    struct AssetPolicyKey has copy, drop, store {
        chain_key: vector<u8>,
        asset: vector<u8>,
    }

    struct AssetPolicy has copy, drop, store {
        fast_path_limit: u128,
        per_tx_limit: u128,
        window_limit: u128,
        window_ms: u64,
        spent_in_window: u128,
        window_started_at_ms: u64,
    }

    public fun vault_deposit<T0>(arg0: &mut PolicyWallet, arg1: 0x2::coin::Coin<T0>) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.vault, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.vault, v0), 0x2::coin::into_balance<T0>(arg1));
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.vault, v0, 0x2::coin::into_balance<T0>(arg1));
        };
        0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::events::vault_deposit(0x2::object::id<PolicyWallet>(arg0), 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())), 0x2::coin::value<T0>(&arg1));
    }

    public fun add_dwallet(arg0: &mut PolicyWallet, arg1: &mut 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator, arg2: u32, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) {
        assert_signer(arg0, arg7);
        assert!(!0x2::table::contains<u32, DWalletEntry>(&arg0.dwallets, arg2), 31);
        let v0 = 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::register_session_identifier(arg1, arg6, arg7);
        let (v1, v2) = withdraw_payments(arg0, arg7);
        let v3 = v2;
        let v4 = v1;
        let (v5, _) = 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::request_dwallet_dkg_with_public_user_secret_key_share(arg1, arg0.network_encryption_key_id, arg2, arg3, arg4, arg5, 0x1::option::none<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::SignDuringDKGRequest>(), v0, &mut v4, &mut v3, arg7);
        let v7 = v5;
        return_payments(arg0, v4, v3);
        let v8 = 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::dwallet_id(&v7);
        let v9 = DWalletEntry{
            cap        : v7,
            dwallet_id : v8,
        };
        0x2::table::add<u32, DWalletEntry>(&mut arg0.dwallets, arg2, v9);
        0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::events::dwallet_added(0x2::object::id<PolicyWallet>(arg0), arg2, v8, 0x2::object::id<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap>(&v7));
    }

    public fun add_presign(arg0: &mut PolicyWallet, arg1: &mut 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator, arg2: u32, arg3: u32, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = (arg2 == 0 || arg2 == 1) && arg3 == 0;
        do_add_presign(arg0, arg1, arg2, arg3, !v0, arg4);
    }

    public fun add_presign_v2(arg0: &mut PolicyWallet, arg1: &mut 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator, arg2: u32, arg3: u32, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        do_add_presign(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public fun address_book_entry(arg0: &PolicyWallet, arg1: vector<u8>) : vector<u8> {
        *0x2::table::borrow<vector<u8>, vector<u8>>(&arg0.address_book, arg1)
    }

    public fun admin_threshold(arg0: &PolicyWallet) : u64 {
        arg0.admin_threshold
    }

    fun apply_proposal(arg0: &mut PolicyWallet, arg1: &mut 0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::registry::Registry, arg2: u8, arg3: vector<u8>, arg4: 0x1::option::Option<address>, arg5: vector<u8>, arg6: vector<u128>, arg7: bool, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<PolicyWallet>(arg0);
        if (arg2 == 1) {
            let v1 = *0x1::option::borrow<address>(&arg4);
            assert!(!0x1::vector::contains<address>(&arg0.signers, &v1), 3);
            assert!(0x1::vector::length<address>(&arg0.signers) < 16, 45);
            0x1::vector::push_back<address>(&mut arg0.signers, v1);
            0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::registry::add_signer(arg1, v1, v0);
            let v2 = SignerCap{
                id        : 0x2::object::new(arg8),
                wallet_id : v0,
            };
            0x2::transfer::transfer<SignerCap>(v2, v1);
            0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::events::signer_added(v0, v1);
        } else if (arg2 == 2) {
            let v3 = *0x1::option::borrow<address>(&arg4);
            let (v4, v5) = 0x1::vector::index_of<address>(&arg0.signers, &v3);
            assert!(v4, 0);
            let v6 = 0x1::vector::length<address>(&arg0.signers) - 1;
            assert!(v6 >= arg0.threshold && v6 >= arg0.admin_threshold, 1);
            0x1::vector::swap_remove<address>(&mut arg0.signers, v5);
            0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::registry::remove_signer(arg1, v3, v0);
            0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::events::signer_removed(v0, v3);
        } else if (arg2 == 3) {
            let v7 = *0x1::vector::borrow<u128>(&arg6, 0);
            let v8 = *0x1::vector::borrow<u128>(&arg6, 1);
            let v9 = (0x1::vector::length<address>(&arg0.signers) as u128);
            assert!(v7 >= 1 && v7 <= v9, 1);
            assert!(v8 >= v7 && v8 <= v9, 1);
            arg0.threshold = (v7 as u64);
            arg0.admin_threshold = (v8 as u64);
        } else if (arg2 == 4) {
            assert!(*0x1::vector::borrow<u128>(&arg6, 0) <= 18446744073709551615 && *0x1::vector::borrow<u128>(&arg6, 1) <= 18446744073709551615, 35);
            arg0.timelock_spend_ms = (*0x1::vector::borrow<u128>(&arg6, 0) as u64);
            arg0.timelock_admin_ms = (*0x1::vector::borrow<u128>(&arg6, 1) as u64);
        } else if (arg2 == 5) {
            assert!(*0x1::vector::borrow<u128>(&arg6, 0) > 0 && *0x1::vector::borrow<u128>(&arg6, 0) <= 18446744073709551615, 35);
            arg0.request_expiry_ms = (*0x1::vector::borrow<u128>(&arg6, 0) as u64);
        } else if (arg2 == 6) {
            let v10 = 0x2::table::borrow_mut<vector<u8>, ChainPolicy>(&mut arg0.chains, arg3);
            let v11 = *0x1::vector::borrow<u128>(&arg6, 0);
            let v12 = *0x1::vector::borrow<u128>(&arg6, 1);
            let v13 = *0x1::vector::borrow<u128>(&arg6, 2);
            let v14 = *0x1::vector::borrow<u128>(&arg6, 3);
            let v15 = if (v12 > 0) {
                if (v11 <= v12) {
                    v13 >= v12
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v15, 12);
            assert!(v14 > 0 && v14 <= 18446744073709551615, 12);
            v10.fast_path_limit = v11;
            v10.per_tx_limit = v12;
            v10.window_limit = v13;
            v10.window_ms = (v14 as u64);
            v10.fee_limit = *0x1::vector::borrow<u128>(&arg6, 4);
        } else if (arg2 == 7) {
            let v16 = 0x2::table::borrow_mut<vector<u8>, ChainPolicy>(&mut arg0.chains, arg3);
            if (!0x2::vec_set::contains<vector<u8>>(&v16.allowlist, &arg5)) {
                0x2::vec_set::insert<vector<u8>>(&mut v16.allowlist, arg5);
            };
        } else if (arg2 == 8) {
            let v17 = 0x2::table::borrow_mut<vector<u8>, ChainPolicy>(&mut arg0.chains, arg3);
            if (0x2::vec_set::contains<vector<u8>>(&v17.allowlist, &arg5)) {
                0x2::vec_set::remove<vector<u8>>(&mut v17.allowlist, &arg5);
            };
        } else if (arg2 == 9) {
            let v18 = 0x2::table::borrow_mut<vector<u8>, ChainPolicy>(&mut arg0.chains, arg3);
            if (!0x2::vec_set::contains<vector<u8>>(&v18.blocklist, &arg5)) {
                0x2::vec_set::insert<vector<u8>>(&mut v18.blocklist, arg5);
            };
        } else if (arg2 == 10) {
            let v19 = 0x2::table::borrow_mut<vector<u8>, ChainPolicy>(&mut arg0.chains, arg3);
            if (0x2::vec_set::contains<vector<u8>>(&v19.blocklist, &arg5)) {
                0x2::vec_set::remove<vector<u8>>(&mut v19.blocklist, &arg5);
            };
        } else if (arg2 == 11) {
            assert!(arg0.paused, 5);
            arg0.paused = false;
            0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::events::wallet_unpaused(v0);
        } else if (arg2 == 12) {
            if (0x2::table::contains<vector<u8>, vector<u8>>(&arg0.address_book, arg3)) {
                *0x2::table::borrow_mut<vector<u8>, vector<u8>>(&mut arg0.address_book, arg3) = arg5;
            } else {
                0x2::table::add<vector<u8>, vector<u8>>(&mut arg0.address_book, arg3, arg5);
            };
            0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::events::address_recorded(v0, arg3, arg5);
        } else if (arg2 == 13) {
            let v20 = 0x2::table::borrow_mut<vector<u8>, ChainPolicy>(&mut arg0.chains, arg3);
            v20.enabled = arg7;
            0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::events::chain_configured(v0, arg3, v20.kind, arg7);
        } else if (arg2 == 14) {
            0x2::table::borrow_mut<vector<u8>, ChainPolicy>(&mut arg0.chains, arg3).allowlist_enabled = arg7;
        } else if (arg2 == 15) {
            0x2::table::borrow_mut<vector<u8>, ChainPolicy>(&mut arg0.chains, arg3).allow_unverified = arg7;
        } else if (arg2 == 16) {
            let v21 = *0x1::option::borrow<address>(&arg4);
            let v22 = *0x1::vector::borrow<u128>(&arg6, 0);
            let v23 = *0x1::vector::borrow<u128>(&arg6, 1);
            assert!(v22 <= 18446744073709551615 && v23 <= 18446744073709551615, 35);
            if (v22 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>>(0x2::coin::from_balance<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(0x2::balance::split<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(&mut arg0.ika_balance, (v22 as u64)), arg8), v21);
            };
            if (v23 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_balance, (v23 as u64)), arg8), v21);
            };
        } else if (arg2 == 17) {
            assert!(0x2::table::contains<vector<u8>, ChainPolicy>(&arg0.chains, arg3), 9);
            assert!(!0x1::vector::is_empty<u8>(&arg5), 35);
            assert!(!is_native_asset(0x2::table::borrow<vector<u8>, ChainPolicy>(&arg0.chains, arg3).kind, &arg5), 35);
            let v24 = *0x1::vector::borrow<u128>(&arg6, 0);
            let v25 = *0x1::vector::borrow<u128>(&arg6, 1);
            let v26 = *0x1::vector::borrow<u128>(&arg6, 2);
            let v27 = *0x1::vector::borrow<u128>(&arg6, 3);
            let v28 = if (v25 > 0) {
                if (v24 <= v25) {
                    v26 >= v25
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v28, 12);
            assert!(v27 > 0 && v27 <= 18446744073709551615, 12);
            let v29 = AssetPolicyKey{
                chain_key : arg3,
                asset     : arg5,
            };
            if (0x2::dynamic_field::exists_<AssetPolicyKey>(&arg0.id, v29)) {
                let v30 = 0x2::dynamic_field::borrow_mut<AssetPolicyKey, AssetPolicy>(&mut arg0.id, v29);
                v30.fast_path_limit = v24;
                v30.per_tx_limit = v25;
                v30.window_limit = v26;
                v30.window_ms = (v27 as u64);
            } else {
                let v31 = AssetPolicy{
                    fast_path_limit      : v24,
                    per_tx_limit         : v25,
                    window_limit         : v26,
                    window_ms            : (v27 as u64),
                    spent_in_window      : 0,
                    window_started_at_ms : 0,
                };
                0x2::dynamic_field::add<AssetPolicyKey, AssetPolicy>(&mut arg0.id, v29, v31);
            };
            0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::events::asset_limits_set(v0, arg3, arg5, v24, v25, v26, (v27 as u64));
        } else {
            assert!(arg2 == 18, 35);
            let v32 = AssetPolicyKey{
                chain_key : arg3,
                asset     : arg5,
            };
            if (0x2::dynamic_field::exists_<AssetPolicyKey>(&arg0.id, v32)) {
                0x2::dynamic_field::remove<AssetPolicyKey, AssetPolicy>(&mut arg0.id, v32);
                0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::events::asset_limits_removed(v0, arg3, arg5);
            };
        };
    }

    fun assert_per_tx_limit(arg0: &PolicyWallet, arg1: &vector<u8>, arg2: &vector<u8>, arg3: u128) {
        if (is_native_asset(0x2::table::borrow<vector<u8>, ChainPolicy>(&arg0.chains, *arg1).kind, arg2)) {
            assert!(arg3 <= 0x2::table::borrow<vector<u8>, ChainPolicy>(&arg0.chains, *arg1).per_tx_limit, 20);
        } else if (has_asset_policy(arg0, arg1, arg2)) {
            assert!(arg3 <= 0x2::dynamic_field::borrow<AssetPolicyKey, AssetPolicy>(&arg0.id, asset_policy_key(arg1, arg2)).per_tx_limit, 20);
        };
    }

    fun assert_signer(arg0: &PolicyWallet, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x1::vector::contains<address>(&arg0.signers, &v0), 0);
    }

    public fun asset_per_tx_limit(arg0: &PolicyWallet, arg1: vector<u8>, arg2: vector<u8>) : 0x1::option::Option<u128> {
        if (is_native_asset(0x2::table::borrow<vector<u8>, ChainPolicy>(&arg0.chains, arg1).kind, &arg2)) {
            0x1::option::some<u128>(0x2::table::borrow<vector<u8>, ChainPolicy>(&arg0.chains, arg1).per_tx_limit)
        } else if (has_asset_policy(arg0, &arg1, &arg2)) {
            0x1::option::some<u128>(0x2::dynamic_field::borrow<AssetPolicyKey, AssetPolicy>(&arg0.id, asset_policy_key(&arg1, &arg2)).per_tx_limit)
        } else {
            0x1::option::none<u128>()
        }
    }

    public fun asset_policy_exists(arg0: &PolicyWallet, arg1: vector<u8>, arg2: vector<u8>) : bool {
        has_asset_policy(arg0, &arg1, &arg2)
    }

    fun asset_policy_key(arg0: &vector<u8>, arg1: &vector<u8>) : AssetPolicyKey {
        AssetPolicyKey{
            chain_key : *arg0,
            asset     : *arg1,
        }
    }

    public fun asset_spent_in_window(arg0: &PolicyWallet, arg1: vector<u8>, arg2: vector<u8>) : u128 {
        if (has_asset_policy(arg0, &arg1, &arg2)) {
            0x2::dynamic_field::borrow<AssetPolicyKey, AssetPolicy>(&arg0.id, asset_policy_key(&arg1, &arg2)).spent_in_window
        } else {
            0
        }
    }

    fun borrow_address_book(arg0: &PolicyWallet, arg1: &vector<u8>) : &vector<u8> {
        assert!(0x2::table::contains<vector<u8>, vector<u8>>(&arg0.address_book, *arg1), 32);
        0x2::table::borrow<vector<u8>, vector<u8>>(&arg0.address_book, *arg1)
    }

    public fun cancel_proposal(arg0: &mut PolicyWallet, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<u64, AdminProposal>(&arg0.proposals, arg1), 33);
        let v0 = 0x2::table::borrow_mut<u64, AdminProposal>(&mut arg0.proposals, arg1);
        assert!(v0.creator == 0x2::tx_context::sender(arg2), 44);
        assert!(v0.status == 0, 34);
        v0.status = 3;
        0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::events::proposal_cancelled(0x2::object::id<PolicyWallet>(arg0), arg1);
    }

    public fun cancel_spend(arg0: &mut PolicyWallet, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<u64, SpendRequest>(&arg0.requests, arg1), 13);
        let v0 = 0x2::table::borrow_mut<u64, SpendRequest>(&mut arg0.requests, arg1);
        assert!(v0.creator == 0x2::tx_context::sender(arg2), 44);
        assert!(v0.status == 0, 14);
        v0.status = 3;
        0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::events::spend_cancelled(0x2::object::id<PolicyWallet>(arg0), arg1);
    }

    public fun chain_spent_in_window(arg0: &PolicyWallet, arg1: vector<u8>) : u128 {
        0x2::table::borrow<vector<u8>, ChainPolicy>(&arg0.chains, arg1).spent_in_window
    }

    public fun configure_chain(arg0: &mut PolicyWallet, arg1: vector<u8>, arg2: u8, arg3: u128, arg4: u128, arg5: u128, arg6: u128, arg7: u64, arg8: u128, arg9: bool, arg10: bool, arg11: &0x2::tx_context::TxContext) {
        assert!(!arg0.setup_complete, 7);
        assert!(0x2::tx_context::sender(arg11) == arg0.creator, 8);
        assert!(!0x2::table::contains<vector<u8>, ChainPolicy>(&arg0.chains, arg1), 11);
        assert!(arg2 <= 4, 12);
        assert!(arg5 > 0, 12);
        assert!(arg4 <= arg5, 12);
        assert!(arg6 >= arg5, 12);
        assert!(arg7 > 0, 12);
        let (v0, v1, v2) = if (arg2 == 0) {
            (0, 0, 2)
        } else if (arg2 == 1) {
            assert!(arg3 > 0, 12);
            (0, 0, 0)
        } else if (arg2 == 2) {
            (2, 0, 0)
        } else if (arg2 == 3) {
            (0, 0, 0)
        } else {
            assert!(arg10, 12);
            (0, 0, 2)
        };
        if (arg2 != 3) {
            assert!(0x2::table::contains<u32, DWalletEntry>(&arg0.dwallets, v0), 30);
        };
        let v3 = ChainPolicy{
            kind                 : arg2,
            enabled              : true,
            evm_chain_id         : arg3,
            curve                : v0,
            signature_algorithm  : v1,
            hash_scheme          : v2,
            fast_path_limit      : arg4,
            per_tx_limit         : arg5,
            window_limit         : arg6,
            window_ms            : arg7,
            spent_in_window      : 0,
            window_started_at_ms : 0,
            fee_limit            : arg8,
            allowlist_enabled    : arg9,
            allowlist            : 0x2::vec_set::empty<vector<u8>>(),
            blocklist            : 0x2::vec_set::empty<vector<u8>>(),
            allow_unverified     : arg10,
        };
        0x2::table::add<vector<u8>, ChainPolicy>(&mut arg0.chains, arg1, v3);
        0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::events::chain_configured(0x2::object::id<PolicyWallet>(arg0), arg1, arg2, true);
    }

    fun count_current_signers(arg0: &PolicyWallet, arg1: &0x2::vec_set::VecSet<address>) : u64 {
        let v0 = 0x2::vec_set::keys<address>(arg1);
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(v0)) {
            if (0x1::vector::contains<address>(&arg0.signers, 0x1::vector::borrow<address>(v0, v2))) {
                v1 = v1 + 1;
            };
            v2 = v2 + 1;
        };
        v1
    }

    public fun create_proposal(arg0: &mut PolicyWallet, arg1: u8, arg2: vector<u8>, arg3: 0x1::option::Option<address>, arg4: vector<u8>, arg5: vector<u128>, arg6: bool, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) : u64 {
        assert_signer(arg0, arg8);
        validate_proposal(arg0, arg1, &arg2, &arg3, &arg4, &arg5);
        arg0.proposal_counter = arg0.proposal_counter + 1;
        let v0 = arg0.proposal_counter;
        let v1 = 0x2::clock::timestamp_ms(arg7);
        let v2 = 0x2::vec_set::empty<address>();
        0x2::vec_set::insert<address>(&mut v2, 0x2::tx_context::sender(arg8));
        let v3 = AdminProposal{
            id                      : v0,
            creator                 : 0x2::tx_context::sender(arg8),
            action                  : arg1,
            chain_key               : arg2,
            addr_param              : arg3,
            bytes_param             : arg4,
            u_params                : arg5,
            bool_param              : arg6,
            approvals               : v2,
            rejections              : 0x2::vec_set::empty<address>(),
            created_at_ms           : v1,
            threshold_reached_at_ms : 0,
            status                  : 0,
        };
        0x2::table::add<u64, AdminProposal>(&mut arg0.proposals, v0, v3);
        0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::events::proposal_created(0x2::object::id<PolicyWallet>(arg0), v0, 0x2::tx_context::sender(arg8), arg1, arg2, v1 + arg0.request_expiry_ms);
        update_proposal_threshold_state(arg0, v0, v1);
        v0
    }

    public fun create_spend_request(arg0: &mut PolicyWallet, arg1: &mut 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u128, arg6: vector<vector<u8>>, arg7: vector<vector<u8>>, arg8: vector<0x2::object::ID>, arg9: vector<vector<u8>>, arg10: bool, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(arg0.setup_complete, 6);
        assert!(!arg0.paused, 4);
        assert_signer(arg0, arg12);
        assert!(arg5 > 0, 19);
        assert!(0x2::table::contains<vector<u8>, ChainPolicy>(&arg0.chains, arg2), 9);
        let v0 = 0x2::table::borrow<vector<u8>, ChainPolicy>(&arg0.chains, arg2);
        assert!(v0.enabled, 10);
        assert!(!0x2::vec_set::contains<vector<u8>>(&v0.blocklist, &arg4), 22);
        let v1 = v0.kind == 2 && arg3 == b"solana:nonce";
        if (v0.allowlist_enabled && !v1) {
            assert!(0x2::vec_set::contains<vector<u8>>(&v0.allowlist, &arg4), 23);
        };
        if (arg10 || v0.kind == 4) {
            assert!(v0.allow_unverified, 24);
        };
        let v2 = v0.kind;
        let v3 = v0.curve;
        let v4 = v0.signature_algorithm;
        let v5 = v0.hash_scheme;
        assert_per_tx_limit(arg0, &arg2, &arg3, arg5);
        assert!(v2 != 3, 36);
        let v6 = if (arg10 || v2 == 4) {
            assert!(!0x1::vector::is_empty<vector<u8>>(&arg6), 26);
            false
        } else if (v2 == 0) {
            assert!(!0x1::vector::is_empty<vector<u8>>(&arg6), 26);
            assert!(0x1::vector::length<vector<u8>>(&arg9) == 2, 12);
            0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::verify_btc::verify(&arg6, 0x1::vector::borrow<vector<u8>>(&arg9, 0), 0x1::vector::borrow<vector<u8>>(&arg9, 1), borrow_address_book(arg0, &arg2), &arg4, arg5, v0.fee_limit);
            true
        } else if (v2 == 1) {
            assert!(0x1::vector::length<vector<u8>>(&arg6) == 1, 25);
            0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::verify_evm::verify(0x1::vector::borrow<vector<u8>>(&arg6, 0), v0.evm_chain_id, &arg3, &arg4, arg5, v0.fee_limit);
            true
        } else {
            assert!(v2 == 2, 12);
            assert!(0x1::vector::length<vector<u8>>(&arg6) == 1, 25);
            let v7 = borrow_address_book(arg0, &arg2);
            if (arg3 == b"solana:nonce") {
                assert!(arg5 <= 5000000, 20);
                0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::verify_solana::verify_nonce_setup(0x1::vector::borrow<vector<u8>>(&arg6, 0), v7, &arg4, arg5);
            } else {
                0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::verify_solana::verify_with_asset(0x1::vector::borrow<vector<u8>>(&arg6, 0), v7, &arg3, &arg4, arg5);
            };
            true
        };
        let v8 = 0x1::vector::empty<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPartialUserSignatureCap>();
        let v9 = 0x1::vector::length<vector<u8>>(&arg6);
        assert!(0x1::vector::length<vector<u8>>(&arg7) == v9, 25);
        assert!(0x1::vector::length<0x2::object::ID>(&arg8) == v9, 25);
        assert!(0x2::table::contains<u32, DWalletEntry>(&arg0.dwallets, v3), 30);
        let v10 = 0x2::table::borrow<u32, DWalletEntry>(&arg0.dwallets, v3).dwallet_id;
        let (v11, v12) = withdraw_payments(arg0, arg12);
        let v13 = v12;
        let v14 = v11;
        let v15 = PresignKey{
            curve               : v3,
            signature_algorithm : v4,
        };
        let v16 = 0;
        while (v16 < v9) {
            assert!(0x2::table::contains<PresignKey, vector<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPresignCap>>(&arg0.presigns, v15), 27);
            let v17 = 0x2::table::borrow_mut<PresignKey, vector<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPresignCap>>(&mut arg0.presigns, v15);
            assert!(!0x1::vector::is_empty<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPresignCap>(v17), 27);
            let v18 = 0x1::vector::pop_back<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPresignCap>(v17);
            assert!(0x2::object::id<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPresignCap>(&v18) == *0x1::vector::borrow<0x2::object::ID>(&arg8, v16), 28);
            assert!(0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::is_presign_valid(arg1, &v18), 29);
            let v19 = 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::verify_presign_cap(arg1, v18, arg12);
            let v20 = fresh_session(arg1, arg12);
            0x1::vector::push_back<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPartialUserSignatureCap>(&mut v8, 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::request_future_sign(arg1, v10, v19, *0x1::vector::borrow<vector<u8>>(&arg6, v16), v5, *0x1::vector::borrow<vector<u8>>(&arg7, v16), v20, &mut v14, &mut v13, arg12));
            v16 = v16 + 1;
        };
        return_payments(arg0, v14, v13);
        store_request(arg0, arg2, arg3, arg4, arg5, v6, arg6, arg9, v8, v3, v4, v5, 0x2::clock::timestamp_ms(arg11), arg12)
    }

    public fun create_vault_spend_request(arg0: &mut PolicyWallet, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u128, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(arg0.setup_complete, 6);
        assert!(!arg0.paused, 4);
        assert_signer(arg0, arg6);
        assert!(arg4 > 0, 19);
        assert!(0x2::table::contains<vector<u8>, ChainPolicy>(&arg0.chains, arg1), 9);
        let v0 = 0x2::table::borrow<vector<u8>, ChainPolicy>(&arg0.chains, arg1);
        assert!(v0.kind == 3, 42);
        assert!(v0.enabled, 10);
        assert!(!0x2::vec_set::contains<vector<u8>>(&v0.blocklist, &arg3), 22);
        if (v0.allowlist_enabled) {
            assert!(0x2::vec_set::contains<vector<u8>>(&v0.allowlist, &arg3), 23);
        };
        assert_per_tx_limit(arg0, &arg1, &arg2, arg4);
        assert!(0x1::vector::length<u8>(&arg3) == 32, 41);
        store_request(arg0, arg1, arg2, arg3, arg4, true, 0x1::vector::empty<vector<u8>>(), 0x1::vector::empty<vector<u8>>(), 0x1::vector::empty<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPartialUserSignatureCap>(), 0, 0, 0, 0x2::clock::timestamp_ms(arg5), arg6)
    }

    public fun create_wallet(arg0: &mut 0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::registry::Registry, arg1: &mut 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator, arg2: vector<address>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: 0x2::object::ID, arg9: vector<u8>, arg10: vector<u8>, arg11: vector<u8>, arg12: vector<u8>, arg13: 0x2::coin::Coin<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>, arg14: 0x2::coin::Coin<0x2::sui::SUI>, arg15: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg2);
        assert!(v0 >= 1 && v0 <= 16, 2);
        assert!(arg3 >= 1 && arg3 <= v0, 1);
        assert!(arg4 >= arg3 && arg4 <= v0, 1);
        assert!(arg7 > 0, 43);
        let v1 = 0x2::vec_set::from_keys<address>(arg2);
        assert!(0x2::vec_set::length<address>(&v1) == v0, 3);
        let (v2, _) = 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::request_dwallet_dkg_with_public_user_secret_key_share(arg1, arg8, 0, arg9, arg10, arg11, 0x1::option::none<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::SignDuringDKGRequest>(), 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::register_session_identifier(arg1, arg12, arg15), &mut arg13, &mut arg14, arg15);
        let v4 = v2;
        let v5 = 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::dwallet_id(&v4);
        let v6 = PolicyWallet{
            id                        : 0x2::object::new(arg15),
            creator                   : 0x2::tx_context::sender(arg15),
            signers                   : arg2,
            threshold                 : arg3,
            admin_threshold           : arg4,
            timelock_spend_ms         : arg5,
            timelock_admin_ms         : arg6,
            request_expiry_ms         : arg7,
            paused                    : false,
            setup_complete            : false,
            dwallets                  : 0x2::table::new<u32, DWalletEntry>(arg15),
            presigns                  : 0x2::table::new<PresignKey, vector<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPresignCap>>(arg15),
            network_encryption_key_id : arg8,
            ika_balance               : 0x2::coin::into_balance<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(arg13),
            sui_balance               : 0x2::coin::into_balance<0x2::sui::SUI>(arg14),
            chains                    : 0x2::table::new<vector<u8>, ChainPolicy>(arg15),
            address_book              : 0x2::table::new<vector<u8>, vector<u8>>(arg15),
            requests                  : 0x2::table::new<u64, SpendRequest>(arg15),
            request_counter           : 0,
            proposals                 : 0x2::table::new<u64, AdminProposal>(arg15),
            proposal_counter          : 0,
            vault                     : 0x2::bag::new(arg15),
        };
        let v7 = DWalletEntry{
            cap        : v4,
            dwallet_id : v5,
        };
        0x2::table::add<u32, DWalletEntry>(&mut v6.dwallets, 0, v7);
        let v8 = 0x2::object::id<PolicyWallet>(&v6);
        0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::registry::register_wallet(arg0);
        let v9 = 0;
        while (v9 < 0x1::vector::length<address>(&v6.signers)) {
            let v10 = *0x1::vector::borrow<address>(&v6.signers, v9);
            0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::registry::add_signer(arg0, v10, v8);
            let v11 = SignerCap{
                id        : 0x2::object::new(arg15),
                wallet_id : v8,
            };
            0x2::transfer::transfer<SignerCap>(v11, v10);
            v9 = v9 + 1;
        };
        0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::events::wallet_created(v8, 0x2::tx_context::sender(arg15), v6.signers, arg3, arg4, v5, 0x2::object::id<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap>(&v4));
        0x2::transfer::share_object<PolicyWallet>(v6);
    }

    public fun deposit_balances(arg0: &mut PolicyWallet, arg1: 0x2::coin::Coin<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>, arg2: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(&mut arg0.ika_balance, 0x2::coin::into_balance<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(arg1));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::events::balance_deposited(0x2::object::id<PolicyWallet>(arg0), 0x2::coin::value<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(&arg1), 0x2::coin::value<0x2::sui::SUI>(&arg2));
    }

    fun do_add_presign(arg0: &mut PolicyWallet, arg1: &mut 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator, arg2: u32, arg3: u32, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        assert_signer(arg0, arg5);
        assert!(0x2::table::contains<u32, DWalletEntry>(&arg0.dwallets, arg2), 30);
        let (v0, v1) = withdraw_payments(arg0, arg5);
        let v2 = v1;
        let v3 = v0;
        let v4 = fresh_session(arg1, arg5);
        let v5 = if (arg4) {
            0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::request_global_presign(arg1, arg0.network_encryption_key_id, arg2, arg3, v4, &mut v3, &mut v2, arg5)
        } else {
            0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::request_presign(arg1, 0x2::table::borrow<u32, DWalletEntry>(&arg0.dwallets, arg2).dwallet_id, arg3, v4, &mut v3, &mut v2, arg5)
        };
        let v6 = v5;
        return_payments(arg0, v3, v2);
        let v7 = PresignKey{
            curve               : arg2,
            signature_algorithm : arg3,
        };
        if (!0x2::table::contains<PresignKey, vector<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPresignCap>>(&arg0.presigns, v7)) {
            0x2::table::add<PresignKey, vector<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPresignCap>>(&mut arg0.presigns, v7, 0x1::vector::empty<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPresignCap>());
        };
        0x1::vector::push_back<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPresignCap>(0x2::table::borrow_mut<PresignKey, vector<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPresignCap>>(&mut arg0.presigns, v7), v6);
        0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::events::presign_added(0x2::object::id<PolicyWallet>(arg0), arg2, arg3, 0x2::object::id<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPresignCap>(&v6));
    }

    public fun execute_proposal(arg0: &mut PolicyWallet, arg1: &mut 0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::registry::Registry, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_signer(arg0, arg4);
        assert!(0x2::table::contains<u64, AdminProposal>(&arg0.proposals, arg2), 33);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = 0x2::object::id<PolicyWallet>(arg0);
        let v2 = 0x2::table::borrow<u64, AdminProposal>(&arg0.proposals, arg2);
        assert!(v2.status == 0, 34);
        assert!(count_current_signers(arg0, &v2.approvals) >= arg0.admin_threshold, 17);
        assert!(v2.threshold_reached_at_ms != 0, 17);
        let v3 = v2.threshold_reached_at_ms + arg0.timelock_admin_ms;
        assert!(v0 >= v3, 18);
        assert!(v0 <= v3 + arg0.request_expiry_ms, 16);
        let v4 = v2.action;
        apply_proposal(arg0, arg1, v4, v2.chain_key, v2.addr_param, v2.bytes_param, v2.u_params, v2.bool_param, arg4);
        0x2::table::borrow_mut<u64, AdminProposal>(&mut arg0.proposals, arg2).status = 1;
        0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::events::proposal_executed(v1, arg2, v4);
    }

    public fun execute_spend(arg0: &mut PolicyWallet, arg1: &mut 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_signer(arg0, arg4);
        assert!(!arg0.paused, 4);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = 0x2::object::id<PolicyWallet>(arg0);
        let (v2, v3, v4, v5, v6, v7, v8) = validate_execution(arg0, arg2, v0, false);
        let v9 = v8;
        let v10 = v3;
        let v11 = v2;
        record_window_spend(arg0, &v11, &v10, v4, v0);
        let v12 = 0x1::vector::empty<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPartialUserSignatureCap>();
        let v13 = 0x2::table::borrow_mut<u64, SpendRequest>(&mut arg0.requests, arg2);
        while (!0x1::vector::is_empty<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPartialUserSignatureCap>(&v13.partial_sig_caps)) {
            0x1::vector::push_back<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPartialUserSignatureCap>(&mut v12, 0x1::vector::pop_back<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPartialUserSignatureCap>(&mut v13.partial_sig_caps));
        };
        0x1::vector::reverse<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPartialUserSignatureCap>(&mut v12);
        v13.status = 1;
        let (v14, v15) = withdraw_payments(arg0, arg4);
        let v16 = v15;
        let v17 = v14;
        let v18 = 0x1::vector::empty<0x2::object::ID>();
        let v19 = 0x2::table::borrow<u32, DWalletEntry>(&arg0.dwallets, v5);
        while (!0x1::vector::is_empty<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPartialUserSignatureCap>(&v12)) {
            let v20 = 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::verify_partial_user_signature_cap(arg1, 0x1::vector::pop_back<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPartialUserSignatureCap>(&mut v12), arg4);
            let v21 = 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::approve_message(arg1, &v19.cap, v6, v7, *0x1::vector::borrow<vector<u8>>(&v9, 0x1::vector::length<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPartialUserSignatureCap>(&v12)));
            let v22 = fresh_session(arg1, arg4);
            0x1::vector::push_back<0x2::object::ID>(&mut v18, 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::request_sign_with_partial_user_signature_and_return_id(arg1, v20, v21, v22, &mut v17, &mut v16, arg4));
        };
        0x1::vector::destroy_empty<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPartialUserSignatureCap>(v12);
        return_payments(arg0, v17, v16);
        0x1::vector::reverse<0x2::object::ID>(&mut v18);
        0x2::table::borrow_mut<u64, SpendRequest>(&mut arg0.requests, arg2).sign_ids = v18;
        0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::events::spend_executed(v1, arg2, 0x2::tx_context::sender(arg4), v18);
    }

    public fun execute_vault_spend<T0>(arg0: &mut PolicyWallet, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_signer(arg0, arg3);
        assert!(!arg0.paused, 4);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0x2::object::id<PolicyWallet>(arg0);
        let (v2, v3, v4, _, _, _, _) = validate_execution(arg0, arg1, v0, true);
        let v9 = v3;
        let v10 = v2;
        record_window_spend(arg0, &v10, &v9, v4, v0);
        let v11 = 0x2::table::borrow_mut<u64, SpendRequest>(&mut arg0.requests, arg1);
        v11.status = 1;
        let v12 = v11.destination;
        let v13 = 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        assert!(v11.asset == v13, 37);
        assert!(v4 <= 18446744073709551615, 39);
        let v14 = (v4 as u64);
        let v15 = 0x1::type_name::get<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.vault, v15), 38);
        let v16 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.vault, v15);
        assert!(0x2::balance::value<T0>(v16) >= v14, 38);
        let v17 = 0x2::address::from_bytes(v12);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v16, v14), arg3), v17);
        0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::events::vault_withdrawal(v1, arg1, v13, v14, v17);
        0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::events::spend_executed(v1, arg1, 0x2::tx_context::sender(arg3), 0x1::vector::empty<0x2::object::ID>());
    }

    fun fast_path_limit_for(arg0: &PolicyWallet, arg1: &vector<u8>, arg2: &vector<u8>) : u128 {
        let v0 = 0x2::table::borrow<vector<u8>, ChainPolicy>(&arg0.chains, *arg1).kind;
        if (v0 == 2 && *arg2 == b"solana:nonce") {
            return 5000000
        };
        if (is_native_asset(v0, arg2)) {
            0x2::table::borrow<vector<u8>, ChainPolicy>(&arg0.chains, *arg1).fast_path_limit
        } else if (has_asset_policy(arg0, arg1, arg2)) {
            0x2::dynamic_field::borrow<AssetPolicyKey, AssetPolicy>(&arg0.id, asset_policy_key(arg1, arg2)).fast_path_limit
        } else {
            0
        }
    }

    public fun finalize_setup(arg0: &mut PolicyWallet, arg1: &0x2::tx_context::TxContext) {
        assert!(!arg0.setup_complete, 7);
        assert!(0x2::tx_context::sender(arg1) == arg0.creator, 8);
        arg0.setup_complete = true;
        0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::events::setup_finalized(0x2::object::id<PolicyWallet>(arg0));
    }

    fun fresh_session(arg0: &mut 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator, arg1: &mut 0x2::tx_context::TxContext) : 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::sessions_manager::SessionIdentifier {
        0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::register_session_identifier(arg0, 0x2::address::to_bytes(0x2::tx_context::fresh_object_address(arg1)), arg1)
    }

    fun has_asset_policy(arg0: &PolicyWallet, arg1: &vector<u8>, arg2: &vector<u8>) : bool {
        0x2::dynamic_field::exists_<AssetPolicyKey>(&arg0.id, asset_policy_key(arg1, arg2))
    }

    fun is_fast_path(arg0: &PolicyWallet, arg1: u64) : bool {
        let v0 = 0x2::table::borrow<u64, SpendRequest>(&arg0.requests, arg1);
        let v1 = v0.amount;
        let v2 = v0.verified_intent;
        let v3 = v0.asset;
        let v4 = v0.chain_key;
        let v5 = fast_path_limit_for(arg0, &v4, &v3);
        if (v5 > 0) {
            if (v1 <= v5) {
                if (v2) {
                    0x2::vec_set::length<address>(&v0.rejections) == 0
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        }
    }

    fun is_native_asset(arg0: u8, arg1: &vector<u8>) : bool {
        if (0x1::vector::is_empty<u8>(arg1)) {
            return true
        };
        arg0 == 3 && *arg1 == sui_native_asset_bytes()
    }

    public fun is_paused(arg0: &PolicyWallet) : bool {
        arg0.paused
    }

    public fun is_setup_complete(arg0: &PolicyWallet) : bool {
        arg0.setup_complete
    }

    public fun is_signer(arg0: &PolicyWallet, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.signers, &arg1)
    }

    public fun pause(arg0: &mut PolicyWallet, arg1: &0x2::tx_context::TxContext) {
        assert_signer(arg0, arg1);
        assert!(!arg0.paused, 4);
        arg0.paused = true;
        0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::events::wallet_paused(0x2::object::id<PolicyWallet>(arg0), 0x2::tx_context::sender(arg1));
    }

    public fun proposal_status(arg0: &PolicyWallet, arg1: u64) : u8 {
        0x2::table::borrow<u64, AdminProposal>(&arg0.proposals, arg1).status
    }

    public fun record_address(arg0: &mut PolicyWallet, arg1: vector<u8>, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        assert!(!arg0.setup_complete, 7);
        assert!(0x2::tx_context::sender(arg3) == arg0.creator, 8);
        if (0x2::table::contains<vector<u8>, vector<u8>>(&arg0.address_book, arg1)) {
            *0x2::table::borrow_mut<vector<u8>, vector<u8>>(&mut arg0.address_book, arg1) = arg2;
        } else {
            0x2::table::add<vector<u8>, vector<u8>>(&mut arg0.address_book, arg1, arg2);
        };
        0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::events::address_recorded(0x2::object::id<PolicyWallet>(arg0), arg1, arg2);
    }

    fun record_window_spend(arg0: &mut PolicyWallet, arg1: &vector<u8>, arg2: &vector<u8>, arg3: u128, arg4: u64) {
        if (is_native_asset(0x2::table::borrow<vector<u8>, ChainPolicy>(&arg0.chains, *arg1).kind, arg2)) {
            let v0 = 0x2::table::borrow_mut<vector<u8>, ChainPolicy>(&mut arg0.chains, *arg1);
            if (arg4 >= v0.window_started_at_ms + v0.window_ms) {
                v0.spent_in_window = 0;
                v0.window_started_at_ms = arg4;
            };
            assert!(v0.spent_in_window + arg3 <= v0.window_limit, 21);
            v0.spent_in_window = v0.spent_in_window + arg3;
        } else if (has_asset_policy(arg0, arg1, arg2)) {
            let v1 = 0x2::dynamic_field::borrow_mut<AssetPolicyKey, AssetPolicy>(&mut arg0.id, asset_policy_key(arg1, arg2));
            if (arg4 >= v1.window_started_at_ms + v1.window_ms) {
                v1.spent_in_window = 0;
                v1.window_started_at_ms = arg4;
            };
            assert!(v1.spent_in_window + arg3 <= v1.window_limit, 21);
            v1.spent_in_window = v1.spent_in_window + arg3;
        };
    }

    public fun request_approvals(arg0: &PolicyWallet, arg1: u64) : u64 {
        0x2::vec_set::length<address>(&0x2::table::borrow<u64, SpendRequest>(&arg0.requests, arg1).approvals)
    }

    public fun request_status(arg0: &PolicyWallet, arg1: u64) : u8 {
        0x2::table::borrow<u64, SpendRequest>(&arg0.requests, arg1).status
    }

    fun required_approvals_for(arg0: &PolicyWallet, arg1: u64) : u64 {
        if (is_fast_path(arg0, arg1)) {
            1
        } else {
            arg0.threshold
        }
    }

    fun return_payments(arg0: &mut PolicyWallet, arg1: 0x2::coin::Coin<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>, arg2: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(&mut arg0.ika_balance, 0x2::coin::into_balance<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(arg1));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
    }

    public fun setup_allowlist_add(arg0: &mut PolicyWallet, arg1: vector<u8>, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        assert!(!arg0.setup_complete, 7);
        assert!(0x2::tx_context::sender(arg3) == arg0.creator, 8);
        assert!(0x2::table::contains<vector<u8>, ChainPolicy>(&arg0.chains, arg1), 9);
        let v0 = 0x2::table::borrow_mut<vector<u8>, ChainPolicy>(&mut arg0.chains, arg1);
        if (!0x2::vec_set::contains<vector<u8>>(&v0.allowlist, &arg2)) {
            0x2::vec_set::insert<vector<u8>>(&mut v0.allowlist, arg2);
        };
    }

    public fun signer_cap_wallet_id(arg0: &SignerCap) : 0x2::object::ID {
        arg0.wallet_id
    }

    public fun signers(arg0: &PolicyWallet) : vector<address> {
        arg0.signers
    }

    fun store_request(arg0: &mut PolicyWallet, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u128, arg5: bool, arg6: vector<vector<u8>>, arg7: vector<vector<u8>>, arg8: vector<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPartialUserSignatureCap>, arg9: u32, arg10: u32, arg11: u32, arg12: u64, arg13: &0x2::tx_context::TxContext) : u64 {
        arg0.request_counter = arg0.request_counter + 1;
        let v0 = arg0.request_counter;
        let v1 = 0x2::vec_set::empty<address>();
        0x2::vec_set::insert<address>(&mut v1, 0x2::tx_context::sender(arg13));
        let v2 = SpendRequest{
            id                      : v0,
            creator                 : 0x2::tx_context::sender(arg13),
            chain_key               : arg1,
            asset                   : arg2,
            destination             : arg3,
            amount                  : arg4,
            verified_intent         : arg5,
            messages                : arg6,
            aux                     : arg7,
            partial_sig_caps        : arg8,
            curve                   : arg9,
            signature_algorithm     : arg10,
            hash_scheme             : arg11,
            approvals               : v1,
            rejections              : 0x2::vec_set::empty<address>(),
            created_at_ms           : arg12,
            threshold_reached_at_ms : 0,
            status                  : 0,
            sign_ids                : 0x1::vector::empty<0x2::object::ID>(),
        };
        0x2::table::add<u64, SpendRequest>(&mut arg0.requests, v0, v2);
        0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::events::spend_request_created(0x2::object::id<PolicyWallet>(arg0), v0, 0x2::tx_context::sender(arg13), arg1, arg2, arg3, arg4, arg5, 0x1::vector::length<vector<u8>>(&arg6), arg12 + arg0.request_expiry_ms);
        0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::events::spend_vote_cast(0x2::object::id<PolicyWallet>(arg0), v0, 0x2::tx_context::sender(arg13), true, 1, 0);
        update_request_threshold_state(arg0, v0, arg12);
        v0
    }

    fun sui_native_asset_bytes() : vector<u8> {
        0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<0x2::sui::SUI>()))
    }

    public fun threshold(arg0: &PolicyWallet) : u64 {
        arg0.threshold
    }

    fun update_proposal_threshold_state(arg0: &mut PolicyWallet, arg1: u64, arg2: u64) {
        let v0 = 0x2::table::borrow_mut<u64, AdminProposal>(&mut arg0.proposals, arg1);
        if (v0.threshold_reached_at_ms == 0 && count_current_signers(arg0, &0x2::table::borrow<u64, AdminProposal>(&arg0.proposals, arg1).approvals) >= arg0.admin_threshold) {
            v0.threshold_reached_at_ms = arg2;
            0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::events::proposal_threshold_reached(0x2::object::id<PolicyWallet>(arg0), arg1, arg2 + arg0.timelock_admin_ms);
        };
    }

    fun update_request_threshold_state(arg0: &mut PolicyWallet, arg1: u64, arg2: u64) {
        let v0 = if (is_fast_path(arg0, arg1)) {
            0
        } else {
            arg0.timelock_spend_ms
        };
        let v1 = 0x2::table::borrow_mut<u64, SpendRequest>(&mut arg0.requests, arg1);
        if (v1.threshold_reached_at_ms == 0 && count_current_signers(arg0, &0x2::table::borrow<u64, SpendRequest>(&arg0.requests, arg1).approvals) >= required_approvals_for(arg0, arg1)) {
            v1.threshold_reached_at_ms = arg2;
            0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::events::spend_threshold_reached(0x2::object::id<PolicyWallet>(arg0), arg1, arg2 + v0);
        };
    }

    fun validate_execution(arg0: &PolicyWallet, arg1: u64, arg2: u64, arg3: bool) : (vector<u8>, vector<u8>, u128, u32, u32, u32, vector<vector<u8>>) {
        assert!(0x2::table::contains<u64, SpendRequest>(&arg0.requests, arg1), 13);
        let v0 = 0x2::table::borrow<u64, SpendRequest>(&arg0.requests, arg1);
        assert!(v0.status == 0, 14);
        let v1 = 0x2::table::borrow<vector<u8>, ChainPolicy>(&arg0.chains, v0.chain_key);
        assert!(v1.enabled, 10);
        if (arg3) {
            assert!(v1.kind == 3, 42);
        } else {
            assert!(v1.kind != 3, 36);
        };
        assert!(count_current_signers(arg0, &v0.approvals) >= required_approvals_for(arg0, arg1), 17);
        assert!(v0.threshold_reached_at_ms != 0, 17);
        let v2 = 0x2::table::borrow<u64, SpendRequest>(&arg0.requests, arg1);
        let v3 = if (is_fast_path(arg0, arg1)) {
            0
        } else {
            arg0.timelock_spend_ms
        };
        let v4 = v2.threshold_reached_at_ms + v3;
        assert!(arg2 >= v4, 18);
        assert!(arg2 <= v4 + arg0.request_expiry_ms, 16);
        (v2.chain_key, v2.asset, v2.amount, v2.curve, v2.signature_algorithm, v2.hash_scheme, v2.messages)
    }

    fun validate_proposal(arg0: &PolicyWallet, arg1: u8, arg2: &vector<u8>, arg3: &0x1::option::Option<address>, arg4: &vector<u8>, arg5: &vector<u128>) {
        if (arg1 == 1) {
            assert!(0x1::option::is_some<address>(arg3), 35);
            assert!(!0x1::vector::contains<address>(&arg0.signers, 0x1::option::borrow<address>(arg3)), 3);
            assert!(0x1::vector::length<address>(&arg0.signers) < 16, 45);
        } else if (arg1 == 2) {
            assert!(0x1::option::is_some<address>(arg3), 35);
            assert!(0x1::vector::contains<address>(&arg0.signers, 0x1::option::borrow<address>(arg3)), 0);
            let v0 = 0x1::vector::length<address>(&arg0.signers) - 1;
            assert!(v0 >= arg0.threshold && v0 >= arg0.admin_threshold, 1);
        } else if (arg1 == 3) {
            assert!(0x1::vector::length<u128>(arg5) == 2, 35);
            let v1 = *0x1::vector::borrow<u128>(arg5, 0);
            let v2 = *0x1::vector::borrow<u128>(arg5, 1);
            let v3 = (0x1::vector::length<address>(&arg0.signers) as u128);
            assert!(v1 >= 1 && v1 <= v3, 1);
            assert!(v2 >= v1 && v2 <= v3, 1);
        } else if (arg1 == 4) {
            assert!(0x1::vector::length<u128>(arg5) == 2, 35);
        } else if (arg1 == 5) {
            assert!(0x1::vector::length<u128>(arg5) == 1 && *0x1::vector::borrow<u128>(arg5, 0) > 0, 35);
        } else if (arg1 == 6) {
            assert!(0x2::table::contains<vector<u8>, ChainPolicy>(&arg0.chains, *arg2), 9);
            assert!(0x1::vector::length<u128>(arg5) == 5, 35);
        } else {
            let v4 = if (arg1 == 7) {
                true
            } else if (arg1 == 8) {
                true
            } else if (arg1 == 9) {
                true
            } else if (arg1 == 10) {
                true
            } else if (arg1 == 13) {
                true
            } else if (arg1 == 14) {
                true
            } else if (arg1 == 15) {
                true
            } else {
                arg1 == 12
            };
            if (v4) {
                assert!(0x2::table::contains<vector<u8>, ChainPolicy>(&arg0.chains, *arg2) || arg1 == 12, 9);
            } else if (arg1 == 11) {
                assert!(arg0.paused, 5);
            } else if (arg1 == 16) {
                assert!(0x1::option::is_some<address>(arg3), 35);
                assert!(0x1::vector::length<u128>(arg5) == 2, 35);
            } else if (arg1 == 17) {
                assert!(0x2::table::contains<vector<u8>, ChainPolicy>(&arg0.chains, *arg2), 9);
                assert!(!0x1::vector::is_empty<u8>(arg4), 35);
                assert!(!is_native_asset(0x2::table::borrow<vector<u8>, ChainPolicy>(&arg0.chains, *arg2).kind, arg4), 35);
                assert!(0x1::vector::length<u128>(arg5) == 4, 35);
                let v5 = *0x1::vector::borrow<u128>(arg5, 1);
                let v6 = *0x1::vector::borrow<u128>(arg5, 3);
                let v7 = if (v5 > 0) {
                    if (*0x1::vector::borrow<u128>(arg5, 0) <= v5) {
                        *0x1::vector::borrow<u128>(arg5, 2) >= v5
                    } else {
                        false
                    }
                } else {
                    false
                };
                assert!(v7, 35);
                assert!(v6 > 0 && v6 <= 18446744073709551615, 35);
            } else {
                assert!(arg1 == 18, 35);
                assert!(0x2::table::contains<vector<u8>, ChainPolicy>(&arg0.chains, *arg2), 9);
                assert!(!0x1::vector::is_empty<u8>(arg4), 35);
            };
        };
    }

    public fun veto_proposal(arg0: &mut PolicyWallet, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert_signer(arg0, arg2);
        assert!(0x2::table::contains<u64, AdminProposal>(&arg0.proposals, arg1), 33);
        let v0 = 0x2::object::id<PolicyWallet>(arg0);
        let v1 = 0x2::table::borrow_mut<u64, AdminProposal>(&mut arg0.proposals, arg1);
        assert!(v1.status == 0, 34);
        assert!(v1.threshold_reached_at_ms != 0, 17);
        let v2 = 0x2::tx_context::sender(arg2);
        if (!0x2::vec_set::contains<address>(&v1.rejections, &v2)) {
            0x2::vec_set::insert<address>(&mut v1.rejections, v2);
        };
        v1.status = 2;
        0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::events::proposal_vetoed(v0, arg1, v2);
        0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::events::proposal_rejected(v0, arg1);
    }

    public fun veto_spend(arg0: &mut PolicyWallet, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert_signer(arg0, arg2);
        assert!(0x2::table::contains<u64, SpendRequest>(&arg0.requests, arg1), 13);
        let v0 = 0x2::object::id<PolicyWallet>(arg0);
        let v1 = 0x2::table::borrow_mut<u64, SpendRequest>(&mut arg0.requests, arg1);
        assert!(v1.status == 0, 14);
        assert!(v1.threshold_reached_at_ms != 0, 17);
        let v2 = 0x2::tx_context::sender(arg2);
        if (!0x2::vec_set::contains<address>(&v1.rejections, &v2)) {
            0x2::vec_set::insert<address>(&mut v1.rejections, v2);
        };
        v1.status = 2;
        0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::events::spend_vetoed(v0, arg1, v2);
        0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::events::spend_rejected(v0, arg1);
    }

    public fun vote_proposal(arg0: &mut PolicyWallet, arg1: u64, arg2: bool, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_signer(arg0, arg4);
        assert!(0x2::table::contains<u64, AdminProposal>(&arg0.proposals, arg1), 33);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = 0x2::object::id<PolicyWallet>(arg0);
        let v2 = 0x2::table::borrow_mut<u64, AdminProposal>(&mut arg0.proposals, arg1);
        assert!(v2.status == 0, 34);
        if (v2.threshold_reached_at_ms == 0 && v0 > v2.created_at_ms + arg0.request_expiry_ms || v0 > v2.threshold_reached_at_ms + arg0.timelock_admin_ms + arg0.request_expiry_ms) {
            v2.status = 4;
            0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::events::proposal_rejected(v1, arg1);
            return
        };
        let v3 = 0x2::tx_context::sender(arg4);
        assert!(!0x2::vec_set::contains<address>(&v2.approvals, &v3) && !0x2::vec_set::contains<address>(&v2.rejections, &v3), 15);
        if (arg2) {
            0x2::vec_set::insert<address>(&mut v2.approvals, v3);
        } else {
            0x2::vec_set::insert<address>(&mut v2.rejections, v3);
        };
        0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::events::proposal_vote_cast(v1, arg1, 0x2::tx_context::sender(arg4), arg2, 0x2::vec_set::length<address>(&v2.approvals), 0x2::vec_set::length<address>(&v2.rejections));
        if (count_current_signers(arg0, &0x2::table::borrow<u64, AdminProposal>(&arg0.proposals, arg1).rejections) > 0x1::vector::length<address>(&arg0.signers) - arg0.admin_threshold) {
            0x2::table::borrow_mut<u64, AdminProposal>(&mut arg0.proposals, arg1).status = 2;
            0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::events::proposal_rejected(v1, arg1);
            return
        };
        update_proposal_threshold_state(arg0, arg1, v0);
    }

    public fun vote_spend(arg0: &mut PolicyWallet, arg1: u64, arg2: bool, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_signer(arg0, arg4);
        if (arg2) {
            assert!(!arg0.paused, 4);
        };
        assert!(0x2::table::contains<u64, SpendRequest>(&arg0.requests, arg1), 13);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = 0x2::object::id<PolicyWallet>(arg0);
        let v2 = 0x2::table::borrow_mut<u64, SpendRequest>(&mut arg0.requests, arg1);
        assert!(v2.status == 0, 14);
        if (v2.threshold_reached_at_ms == 0 && v0 > v2.created_at_ms + arg0.request_expiry_ms || v0 > v2.threshold_reached_at_ms + arg0.timelock_spend_ms + arg0.request_expiry_ms) {
            v2.status = 4;
            0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::events::spend_rejected(v1, arg1);
            return
        };
        let v3 = 0x2::tx_context::sender(arg4);
        assert!(!0x2::vec_set::contains<address>(&v2.approvals, &v3) && !0x2::vec_set::contains<address>(&v2.rejections, &v3), 15);
        if (arg2) {
            0x2::vec_set::insert<address>(&mut v2.approvals, v3);
        } else {
            0x2::vec_set::insert<address>(&mut v2.rejections, v3);
        };
        0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::events::spend_vote_cast(v1, arg1, 0x2::tx_context::sender(arg4), arg2, 0x2::vec_set::length<address>(&v2.approvals), 0x2::vec_set::length<address>(&v2.rejections));
        if (count_current_signers(arg0, &0x2::table::borrow<u64, SpendRequest>(&arg0.requests, arg1).rejections) > 0x1::vector::length<address>(&arg0.signers) - required_approvals_for(arg0, arg1)) {
            0x2::table::borrow_mut<u64, SpendRequest>(&mut arg0.requests, arg1).status = 2;
            0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::events::spend_rejected(v1, arg1);
            return
        };
        update_request_threshold_state(arg0, arg1, v0);
    }

    fun withdraw_payments(arg0: &mut PolicyWallet, arg1: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>, 0x2::coin::Coin<0x2::sui::SUI>) {
        (0x2::coin::from_balance<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(0x2::balance::withdraw_all<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(&mut arg0.ika_balance), arg1), 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.sui_balance), arg1))
    }

    // decompiled from Move bytecode v7
}

