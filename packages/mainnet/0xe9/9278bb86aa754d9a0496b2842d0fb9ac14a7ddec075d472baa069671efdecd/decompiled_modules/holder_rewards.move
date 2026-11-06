module 0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::holder_rewards {
    struct Round<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        number: u64,
        claim_deadline_at_ms: u64,
        root: vector<u8>,
        leaf_count: u64,
        claimed_bitmap: vector<u256>,
        meme: 0x2::balance::Balance<T0>,
        quote: 0x2::balance::Balance<T1>,
        treasury: address,
        gas_reserve: 0x1::option::Option<0x2::balance::Balance<T1>>,
    }

    public fun apply_round_delay<T0, T1>(arg0: &mut 0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::vault::Vault<T0, T1>, arg1: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::PackageVersion<0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::blast_vault_package::BLAST_VAULT_PACKAGE>, arg2: &0x2::clock::Clock) {
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::assert_current<0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::blast_vault_package::BLAST_VAULT_PACKAGE>(arg1, 1);
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::assert_not_paused<0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::blast_vault_package::BLAST_VAULT_PACKAGE>(arg1, 1);
        0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::vault::apply_round_publication_delay<T0, T1>(arg0, arg2);
    }

    fun assert_fundable<T0, T1>(arg0: &0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::vault::Vault<T0, T1>, arg1: &0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::vault::RoundTerms) {
        assert!(0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::vault::number(arg1) == 0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::vault::next_round<T0, T1>(arg0), 17);
        let v0 = 0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::vault::last_checkpoint<T0, T1>(arg0);
        let v1 = &v0;
        assert!(0x1::option::is_none<u64>(v1) || *0x1::option::borrow<u64>(v1) <= 0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::vault::start_checkpoint(arg1), 18);
        let (v2, v3) = 0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::vault::rewards_balances<T0, T1>(arg0);
        let v4 = if (0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::vault::meme_amount(arg1) <= v2) {
            if (0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::vault::quote_amount(arg1) <= v3) {
                0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::vault::gas_reserve_amount(arg1) <= v3 - 0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::vault::quote_amount(arg1)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v4, 19);
    }

    public fun cancel_round<T0, T1>(arg0: &mut 0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::vault::Vault<T0, T1>, arg1: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::blast_acl::AdminWitness<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::blast_domain::CancelAdmin>, arg2: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::PackageVersion<0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::blast_vault_package::BLAST_VAULT_PACKAGE>) {
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::assert_current<0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::blast_vault_package::BLAST_VAULT_PACKAGE>(arg2, 1);
        0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::vault::cancel_round_publication<T0, T1>(arg0);
    }

    public fun cancel_round_delay<T0, T1>(arg0: &mut 0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::vault::Vault<T0, T1>, arg1: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::blast_acl::AdminWitness<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::blast_domain::CancelAdmin>, arg2: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::PackageVersion<0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::blast_vault_package::BLAST_VAULT_PACKAGE>) {
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::assert_current<0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::blast_vault_package::BLAST_VAULT_PACKAGE>(arg2, 1);
        0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::vault::cancel_round_publication_delay<T0, T1>(arg0);
    }

    public fun claim<T0, T1>(arg0: &mut Round<T0, T1>, arg1: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::PackageVersion<0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::blast_vault_package::BLAST_VAULT_PACKAGE>, arg2: u64, arg3: address, arg4: u64, arg5: u64, arg6: vector<vector<u8>>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::assert_current<0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::blast_vault_package::BLAST_VAULT_PACKAGE>(arg1, 1);
        assert!(0x2::clock::timestamp_ms(arg7) < arg0.claim_deadline_at_ms, 23);
        assert!(arg2 < arg0.leaf_count, 24);
        let (v0, v1) = claim_bit(arg2);
        assert!(*0x1::vector::borrow<u256>(&arg0.claimed_bitmap, v0) & v1 == 0, 25);
        assert!(arg3 != @0x0, 26);
        assert!(arg4 > 0 || arg5 > 0, 27);
        assert!(0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::merkle::verify(arg0.root, reward_leaf(arg0.vault_id, arg0.number, arg2, arg3, arg4, arg5), arg2, arg0.leaf_count, &arg6), 28);
        let v2 = 0x1::vector::borrow_mut<u256>(&mut arg0.claimed_bitmap, v0);
        *v2 = *v2 | v1;
        0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::payout::pay<T0>(&mut arg0.meme, arg4, arg3, arg8);
        0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::payout::pay<T1>(&mut arg0.quote, arg5, arg3, arg8);
        0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::blast_vault_events::reward_claimed<T0, T1>(0x2::object::uid_to_inner(&arg0.id), arg2, arg3, arg4, arg5, 0x2::balance::value<T0>(&arg0.meme), 0x2::balance::value<T1>(&arg0.quote));
    }

    fun claim_bit(arg0: u64) : (u64, u256) {
        (arg0 / 256, 1 << ((arg0 % 256) as u8))
    }

    public fun close_round<T0, T1>(arg0: Round<T0, T1>, arg1: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::PackageVersion<0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::blast_vault_package::BLAST_VAULT_PACKAGE>, arg2: &mut 0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::vault::Vault<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::assert_current<0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::blast_vault_package::BLAST_VAULT_PACKAGE>(arg1, 1);
        assert!(arg0.vault_id == 0x2::object::id<0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::vault::Vault<T0, T1>>(arg2), 29);
        assert!(0x2::clock::timestamp_ms(arg3) >= arg0.claim_deadline_at_ms, 32);
        let Round {
            id                   : v0,
            vault_id             : v1,
            number               : v2,
            claim_deadline_at_ms : _,
            root                 : _,
            leaf_count           : _,
            claimed_bitmap       : _,
            meme                 : v7,
            quote                : v8,
            treasury             : _,
            gas_reserve          : v10,
        } = arg0;
        let v11 = v8;
        let v12 = v7;
        let v13 = v0;
        let v14 = v10;
        let v15 = if (0x1::option::is_some<0x2::balance::Balance<T1>>(&v14)) {
            0x1::option::destroy_some<0x2::balance::Balance<T1>>(v14)
        } else {
            0x1::option::destroy_none<0x2::balance::Balance<T1>>(v14);
            0x2::balance::zero<T1>()
        };
        let v16 = v15;
        0x2::balance::join<T1>(&mut v11, v16);
        0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::vault::restore_rewards<T0, T1>(arg2, v12, v11);
        0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::blast_vault_events::round_closed<T0, T1>(v1, 0x2::object::uid_to_inner(&v13), v2, 0x2::balance::value<T0>(&v12), 0x2::balance::value<T1>(&v11), 0x2::balance::value<T1>(&v16));
        0x2::object::delete(v13);
    }

    public fun publish_round<T0, T1>(arg0: &mut 0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::vault::Vault<T0, T1>, arg1: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::PackageVersion<0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::blast_vault_package::BLAST_VAULT_PACKAGE>, arg2: &0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::blast_treasury::Treasury, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::assert_current<0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::blast_vault_package::BLAST_VAULT_PACKAGE>(arg1, 1);
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::assert_not_paused<0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::blast_vault_package::BLAST_VAULT_PACKAGE>(arg1, 1);
        let v0 = 0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::vault::take_round_publication<T0, T1>(arg0, arg3);
        let v1 = 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::blast_treasury::destination(arg2);
        assert!(v1 == 0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::vault::expected_treasury(&v0), 21);
        assert_fundable<T0, T1>(arg0, &v0);
        let v2 = 0x1::u64::checked_add(0x2::clock::timestamp_ms(arg3), 0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::vault::claim_window_duration_ms(&v0));
        if (0x1::option::is_some<u64>(&v2)) {
            let v3 = 0x1::option::destroy_some<u64>(v2);
            let v4 = 0x2::object::id<0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::vault::Vault<T0, T1>>(arg0);
            let v5 = 0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::vault::gas_reserve_amount(&v0);
            let (v6, v7) = 0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::vault::fund_round<T0, T1>(arg0, 0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::vault::end_checkpoint(&v0), 0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::vault::meme_amount(&v0), 0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::vault::quote_amount(&v0) + v5);
            let v8 = v7;
            let v9 = if (v5 > 0) {
                0x1::option::some<0x2::balance::Balance<T1>>(0x2::balance::split<T1>(&mut v8, v5))
            } else {
                0x1::option::none<0x2::balance::Balance<T1>>()
            };
            let v10 = vector[];
            let v11 = 0;
            while (v11 < 0x1::u64::div_ceil(0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::vault::leaf_count(&v0), 256)) {
                0x1::vector::push_back<u256>(&mut v10, 0);
                v11 = v11 + 1;
            };
            let v12 = Round<T0, T1>{
                id                   : 0x2::object::new(arg4),
                vault_id             : v4,
                number               : 0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::vault::number(&v0),
                claim_deadline_at_ms : v3,
                root                 : 0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::vault::root(&v0),
                leaf_count           : 0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::vault::leaf_count(&v0),
                claimed_bitmap       : v10,
                meme                 : v6,
                quote                : v8,
                treasury             : v1,
                gas_reserve          : v9,
            };
            let (v13, v14) = 0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::vault::rewards_balances<T0, T1>(arg0);
            0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::blast_vault_events::round_published<T0, T1>(v4, 0x2::object::uid_to_inner(&v12.id), 0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::vault::number(&v0), 0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::vault::start_checkpoint(&v0), 0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::vault::end_checkpoint(&v0), v3, 0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::vault::root(&v0), 0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::vault::manifest_digest(&v0), 0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::vault::leaf_count(&v0), 0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::vault::meme_amount(&v0), 0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::vault::quote_amount(&v0), v13, v14, v1, v5);
            0x2::transfer::share_object<Round<T0, T1>>(v12);
            return
        } else {
            0x1::option::destroy_none<u64>(v2);
            abort 22
        };
    }

    fun reward_leaf(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: address, arg4: u64, arg5: u64) : vector<u8> {
        let v0 = 0x1::bcs::to_bytes<0x2::object::ID>(&arg0);
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg2));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<address>(&arg3));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg4));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg5));
        0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::merkle::leaf(b"blast-holder-rewards-v2", v0)
    }

    public fun schedule_round<T0, T1>(arg0: &mut 0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::vault::Vault<T0, T1>, arg1: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::blast_acl::AdminWitness<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::blast_domain::RewardsAdmin>, arg2: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::PackageVersion<0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::blast_vault_package::BLAST_VAULT_PACKAGE>, arg3: u64, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: vector<u8>, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: address, arg14: &0x2::clock::Clock) {
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::assert_current<0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::blast_vault_package::BLAST_VAULT_PACKAGE>(arg2, 1);
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::assert_not_paused<0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::blast_vault_package::BLAST_VAULT_PACKAGE>(arg2, 1);
        let v0 = 0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::vault::new_round_terms(arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
        assert_fundable<T0, T1>(arg0, &v0);
        0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::vault::schedule_round_publication<T0, T1>(arg0, v0, arg14);
    }

    public fun schedule_round_delay<T0, T1>(arg0: &mut 0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::vault::Vault<T0, T1>, arg1: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::blast_acl::AdminWitness<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::blast_domain::RewardsAdmin>, arg2: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::PackageVersion<0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::blast_vault_package::BLAST_VAULT_PACKAGE>, arg3: u64, arg4: &0x2::clock::Clock) {
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::assert_current<0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::blast_vault_package::BLAST_VAULT_PACKAGE>(arg2, 1);
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::assert_not_paused<0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::blast_vault_package::BLAST_VAULT_PACKAGE>(arg2, 1);
        0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::vault::schedule_round_publication_delay<T0, T1>(arg0, arg3, arg4);
    }

    public fun settle_gas_reserve<T0, T1>(arg0: &mut Round<T0, T1>, arg1: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::blast_acl::AdminWitness<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::blast_domain::RewardsAdmin>, arg2: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::PackageVersion<0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::blast_vault_package::BLAST_VAULT_PACKAGE>, arg3: &mut 0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::vault::Vault<T0, T1>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::assert_current<0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::blast_vault_package::BLAST_VAULT_PACKAGE>(arg2, 1);
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::assert_not_paused<0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::blast_vault_package::BLAST_VAULT_PACKAGE>(arg2, 1);
        assert!(arg0.vault_id == 0x2::object::id<0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::vault::Vault<T0, T1>>(arg3), 29);
        assert!(0x1::option::is_some<0x2::balance::Balance<T1>>(&arg0.gas_reserve), 30);
        assert!(arg4 <= 0x2::balance::value<T1>(0x1::option::borrow<0x2::balance::Balance<T1>>(&arg0.gas_reserve)), 31);
        let v0 = 0x1::option::extract<0x2::balance::Balance<T1>>(&mut arg0.gas_reserve);
        0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::payout::pay<T1>(&mut v0, arg4, arg0.treasury, arg5);
        0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::vault::restore_rewards<T0, T1>(arg3, 0x2::balance::zero<T0>(), v0);
        let (_, v2) = 0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::vault::rewards_balances<T0, T1>(arg3);
        0xe99278bb86aa754d9a0496b2842d0fb9ac14a7ddec075d472baa069671efdecd::blast_vault_events::gas_reserve_settled<T0, T1>(arg0.vault_id, 0x2::object::uid_to_inner(&arg0.id), arg0.number, arg0.treasury, arg4, 0x2::balance::value<T1>(&v0) - arg4, v2);
    }

    // decompiled from Move bytecode v7
}

