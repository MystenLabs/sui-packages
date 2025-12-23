module 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::staking_v2 {
    struct StakingReceiptV2 has key {
        id: 0x2::object::UID,
        principal: 0x2::balance::Balance<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE>,
        stake_timestamp: u64,
        lockup_end_timestamp: u64,
        lockup_duration_ms: u64,
        cooldown_end_timestamp: u64,
        migration_reward: 0x2::balance::Balance<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE>,
    }

    struct ClaimMessage has copy, drop {
        staking_receipt_id: 0x2::object::ID,
        receiver: address,
        reward_amount: u64,
        valid_until: u64,
        chain_id: u64,
    }

    struct DepositedV2 has copy, drop {
        staking_receipt_id: 0x2::object::ID,
        user: address,
        principal_amount: u64,
        lockup_duration_ms: u64,
        stake_timestamp: u64,
        lockup_end_timestamp: u64,
        referral: 0x1::string::String,
        migration_reward_amount: u64,
    }

    struct UnstakeRequestedV2 has copy, drop {
        staking_receipt_id: 0x2::object::ID,
        user: address,
        principal_amount: u64,
        unstake_timestamp: u64,
        cooldown_end_timestamp: u64,
    }

    struct ClaimedV2 has copy, drop {
        staking_receipt_id: 0x2::object::ID,
        user: address,
        principal_amount: u64,
        claim_timestamp: u64,
        reward_amount: u64,
    }

    struct MigratedFromV1 has copy, drop {
        v1_staking_receipt_id: 0x2::object::ID,
        v2_staking_receipt_id: 0x2::object::ID,
        owner: address,
        principal_amount: u64,
        migration_reward_amount: u64,
    }

    struct PenaltyAppliedV2 has copy, drop {
        staking_receipt_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        user: address,
        penalty_amount: u64,
    }

    fun check_message(arg0: 0x2::object::ID, arg1: &ClaimMessage, arg2: u64, arg3: address, arg4: u64) {
        assert!(arg1.staking_receipt_id == arg0, 8);
        assert!(arg1.receiver == arg3, 9);
        assert!(arg2 <= arg1.valid_until, 11);
        assert!(arg1.chain_id == arg4, 12);
    }

    public fun claim_v2(arg0: &0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::config::StakingConfig, arg1: &mut 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::stats::Stats, arg2: StakingReceiptV2, arg3: &mut 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::vault_v2::Vault<0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::vault_v2::RewardRole>, arg4: vector<vector<u8>>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE> {
        assert!(0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::vault_v2::get_reward_vault_id(arg3) == 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::config::get_reward_vault_id(arg0), 18);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let StakingReceiptV2 {
            id                     : v1,
            principal              : v2,
            stake_timestamp        : _,
            lockup_end_timestamp   : _,
            lockup_duration_ms     : _,
            cooldown_end_timestamp : v6,
            migration_reward       : v7,
        } = arg2;
        let v8 = v7;
        let v9 = v2;
        let v10 = v1;
        assert!(v6 != 0, 5);
        assert!(v0 >= v6, 6);
        let v11 = 0x2::balance::value<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE>(&v9);
        let v12 = 0x2::object::uid_to_inner(&v10);
        let v13 = 0x2::tx_context::sender(arg6);
        let v14 = validate_and_extract_extra_message(arg4, v12, v0, v13, 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::config::get_signer_public_key(arg0), 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::config::get_chain_id(arg0));
        let v15 = v14.reward_amount;
        0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::stats::sub_unstaking_amount(arg1, v11);
        let v16 = ClaimedV2{
            staking_receipt_id : v12,
            user               : v13,
            principal_amount   : v11,
            claim_timestamp    : v0,
            reward_amount      : 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::safe_math::safe_add_u64(v15, 0x2::balance::value<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE>(&v8)),
        };
        0x2::event::emit<ClaimedV2>(v16);
        let v17 = 0x2::coin::from_balance<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE>(v9, arg6);
        0x2::coin::join<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE>(&mut v17, 0x2::coin::from_balance<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE>(v8, arg6));
        0x2::coin::join<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE>(&mut v17, 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::vault_v2::claim_reward(arg3, v15, arg6));
        0x2::object::delete(v10);
        v17
    }

    public fun deposit_v2(arg0: &0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::config::StakingConfig, arg1: &mut 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::stats::Stats, arg2: u64, arg3: &mut 0x2::coin::Coin<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE>, arg4: u64, arg5: 0x1::string::String, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = deposit_v2_internal(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        0x2::transfer::transfer<StakingReceiptV2>(v0, 0x2::tx_context::sender(arg7));
    }

    fun deposit_v2_internal(arg0: &0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::config::StakingConfig, arg1: &mut 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::stats::Stats, arg2: u64, arg3: &mut 0x2::coin::Coin<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE>, arg4: u64, arg5: 0x1::string::String, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : StakingReceiptV2 {
        assert!(0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::config::is_pool_exists(arg0, arg2), 2);
        assert!(arg4 > 0, 0);
        assert!(0x2::coin::value<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE>(arg3) >= arg4, 1);
        let v0 = 0x2::clock::timestamp_ms(arg6);
        let v1 = 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::safe_math::safe_add_u64(v0, arg2);
        0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::stats::add_staked_amount(arg1, arg4);
        let v2 = 0x2::object::new(arg7);
        let v3 = DepositedV2{
            staking_receipt_id      : 0x2::object::uid_to_inner(&v2),
            user                    : 0x2::tx_context::sender(arg7),
            principal_amount        : arg4,
            lockup_duration_ms      : arg2,
            stake_timestamp         : v0,
            lockup_end_timestamp    : v1,
            referral                : arg5,
            migration_reward_amount : 0,
        };
        0x2::event::emit<DepositedV2>(v3);
        StakingReceiptV2{
            id                     : v2,
            principal              : 0x2::coin::into_balance<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE>(0x2::coin::split<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE>(arg3, arg4, arg7)),
            stake_timestamp        : v0,
            lockup_end_timestamp   : v1,
            lockup_duration_ms     : arg2,
            cooldown_end_timestamp : 0,
            migration_reward       : 0x2::balance::zero<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE>(),
        }
    }

    public fun emergency_unstake_v2(arg0: &0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::config::StakingConfig, arg1: &mut 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::stats::Stats, arg2: &mut StakingReceiptV2, arg3: &mut 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::vault_v2::Vault<0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::vault_v2::PenaltyRole>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(v0 < arg2.lockup_end_timestamp, 17);
        assert!(arg2.cooldown_end_timestamp == 0, 5);
        assert!(is_migrated(arg2), 16);
        let v1 = 0x2::object::uid_to_inner(&arg2.id);
        let v2 = 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::vault_v2::get_penalty_vault_id(arg3);
        assert!(v2 == 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::config::get_penalty_vault_id(arg0), 19);
        let v3 = 0x2::balance::value<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE>(&arg2.principal);
        assert!(v3 > 0, 0);
        let v4 = 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::safe_math::safe_mul_div_u64(v3, 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::config::get_emergency_penalty_bps(arg0), 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::constants::basis_points_denominator());
        0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::vault_v2::deposit_penalty(arg3, 0x2::coin::from_balance<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE>(0x2::balance::split<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE>(&mut arg2.principal, v4), arg5), arg5);
        arg2.cooldown_end_timestamp = v0;
        0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::stats::add_unstaking_amount(arg1, 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::safe_math::safe_sub_u64(v3, v4));
        0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::stats::sub_staked_amount(arg1, v3);
        let v5 = UnstakeRequestedV2{
            staking_receipt_id     : v1,
            user                   : 0x2::tx_context::sender(arg5),
            principal_amount       : 0x2::balance::value<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE>(&arg2.principal),
            unstake_timestamp      : v0,
            cooldown_end_timestamp : arg2.cooldown_end_timestamp,
        };
        0x2::event::emit<UnstakeRequestedV2>(v5);
        let v6 = PenaltyAppliedV2{
            staking_receipt_id : v1,
            vault_id           : v2,
            user               : 0x2::tx_context::sender(arg5),
            penalty_amount     : v4,
        };
        0x2::event::emit<PenaltyAppliedV2>(v6);
    }

    public fun is_migrated(arg0: &StakingReceiptV2) : bool {
        0x2::balance::value<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE>(&arg0.migration_reward) > 0
    }

    public fun migrate_from_v1(arg0: &mut 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::config::StakingConfig, arg1: &mut 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::staking::StakingPoolConfig, arg2: &mut 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::stats::Stats, arg3: &0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::admin::AdminCap, arg4: address, arg5: u64, arg6: u64, arg7: 0x2::object::ID, arg8: u64, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::safe_math::safe_mul_u64(arg9, 1000);
        assert!(0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::config::is_pool_exists(arg0, v0), 2);
        let (v1, v2) = 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::staking::withdraw_principal_and_reward_balance_internal(arg1, arg5, arg6, arg12);
        let v3 = 0x2::object::id_to_address(&arg7);
        assert!(!0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::config::is_migrated_v1_receipt(arg0, v3), 15);
        let v4 = 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::safe_math::safe_add_u64(arg8, v0);
        0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::stats::add_staked_amount(arg2, arg5);
        0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::config::mark_migrated_v1_receipt(arg0, v3);
        let v5 = StakingReceiptV2{
            id                     : 0x2::object::new(arg12),
            principal              : v1,
            stake_timestamp        : arg8,
            lockup_end_timestamp   : v4,
            lockup_duration_ms     : v0,
            cooldown_end_timestamp : 0,
            migration_reward       : v2,
        };
        let v6 = 0x2::object::uid_to_inner(&v5.id);
        let v7 = DepositedV2{
            staking_receipt_id      : v6,
            user                    : arg4,
            principal_amount        : arg5,
            lockup_duration_ms      : v0,
            stake_timestamp         : arg10,
            lockup_end_timestamp    : v4,
            referral                : 0x1::string::utf8(b""),
            migration_reward_amount : arg6,
        };
        0x2::event::emit<DepositedV2>(v7);
        let v8 = MigratedFromV1{
            v1_staking_receipt_id   : arg7,
            v2_staking_receipt_id   : v6,
            owner                   : arg4,
            principal_amount        : arg5,
            migration_reward_amount : arg6,
        };
        0x2::event::emit<MigratedFromV1>(v8);
        0x2::transfer::transfer<StakingReceiptV2>(v5, arg4);
    }

    fun parse_claim_message(arg0: vector<u8>) : ClaimMessage {
        let v0 = 0x2::bcs::new(arg0);
        ClaimMessage{
            staking_receipt_id : 0x2::object::id_from_address(0x2::bcs::peel_address(&mut v0)),
            receiver           : 0x2::bcs::peel_address(&mut v0),
            reward_amount      : 0x2::bcs::peel_u64(&mut v0),
            valid_until        : 0x2::bcs::peel_u64(&mut v0),
            chain_id           : 0x2::bcs::peel_u64(&mut v0),
        }
    }

    public fun request_unstake_v2(arg0: &0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::config::StakingConfig, arg1: &mut 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::stats::Stats, arg2: &mut StakingReceiptV2, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(arg2.cooldown_end_timestamp == 0, 3);
        assert!(v0 >= arg2.lockup_end_timestamp, 4);
        arg2.cooldown_end_timestamp = 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::safe_math::safe_add_u64(v0, 0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::config::get_unstaking_delay_ms(arg0));
        0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::stats::add_unstaking_amount(arg1, 0x2::balance::value<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE>(&arg2.principal));
        0x2b5b2081ce2428bdd67057ed6d62d1112173ded3588eab63ab93c2042a0b296a::stats::sub_staked_amount(arg1, 0x2::balance::value<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE>(&arg2.principal));
        let v1 = UnstakeRequestedV2{
            staking_receipt_id     : 0x2::object::uid_to_inner(&arg2.id),
            user                   : 0x2::tx_context::sender(arg4),
            principal_amount       : 0x2::balance::value<0x76a49ebaf991fa2d4cb6a352af14425d453fe2ba6802b5ed2361b227150b6689::take::TAKE>(&arg2.principal),
            unstake_timestamp      : v0,
            cooldown_end_timestamp : arg2.cooldown_end_timestamp,
        };
        0x2::event::emit<UnstakeRequestedV2>(v1);
    }

    fun validate_and_extract_extra_message(arg0: vector<vector<u8>>, arg1: 0x2::object::ID, arg2: u64, arg3: address, arg4: vector<u8>, arg5: u64) : ClaimMessage {
        assert!(0x1::vector::length<vector<u8>>(&arg0) == 2, 7);
        let v0 = 0x1::vector::remove<vector<u8>>(&mut arg0, 0);
        let v1 = 0x1::vector::remove<vector<u8>>(&mut arg0, 0);
        assert!(0x1::vector::length<u8>(&v0) > 0, 7);
        assert!(0x1::vector::length<u8>(&v1) > 0, 7);
        verify_signature(&v0, &arg4, &v1);
        let v2 = parse_claim_message(v0);
        check_message(arg1, &v2, arg2, arg3, arg5);
        v2
    }

    fun verify_signature(arg0: &vector<u8>, arg1: &vector<u8>, arg2: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg1) == 33, 14);
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 1;
        loop {
            if (v1 == 33) {
                break
            };
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg1, v1));
            v1 = v1 + 1;
        };
        assert!(0x2::ed25519::ed25519_verify(arg2, &v0, arg0), 13);
    }

    // decompiled from Move bytecode v6
}

