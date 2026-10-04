module 0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::faucet {
    struct EligibilityKey has store {
        revoked: bool,
        signature_type: u8,
    }

    struct PlayCoinFaucet has key {
        id: 0x2::object::UID,
        ledger_id: 0x2::object::ID,
        module_version: u64,
        grant_amount: u64,
        eligibility_keys: 0x2::table::Table<vector<u8>, EligibilityKey>,
    }

    struct PlayCoinFaucetCreated has copy, drop {
        faucet_id: 0x2::object::ID,
        ledger_id: 0x2::object::ID,
        grant_amount: u64,
    }

    struct PlayCoinClaimed has copy, drop {
        faucet_id: 0x2::object::ID,
        ledger_id: 0x2::object::ID,
        recipient: address,
        amount: u64,
        balance: u64,
        issuance_seq: u64,
        signature_type: u8,
        public_key: vector<u8>,
    }

    struct EligibilityKeyRegistered has copy, drop {
        faucet_id: 0x2::object::ID,
        signature_type: u8,
        public_key: vector<u8>,
    }

    struct EligibilityKeyRotated has copy, drop {
        faucet_id: 0x2::object::ID,
        previous_public_key: vector<u8>,
        signature_type: u8,
        public_key: vector<u8>,
    }

    struct EligibilityKeyRevoked has copy, drop {
        faucet_id: 0x2::object::ID,
        public_key: vector<u8>,
    }

    fun assert_admitted_version(arg0: &PlayCoinFaucet) {
        assert!(is_admitted_version(arg0), 13906835630339129373);
    }

    fun assert_bound_faucet(arg0: &0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::play_coin::PlayCoinIssuerCap, arg1: &PlayCoinFaucet) {
        assert!(0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::play_coin::issuer_cap_ledger_id(arg0) == arg1.ledger_id, 13906835501488406531);
    }

    fun assert_valid_eligibility_key(arg0: u8, arg1: &vector<u8>) {
        assert!(0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::signature::is_valid_signature_type(arg0), 13906835518669455381);
        assert!(0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::signature::is_valid_public_key_length(arg0, arg1), 13906835522964553751);
    }

    public fun claim(arg0: &PlayCoinFaucet, arg1: &0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::play_coin::PlayCoinLedger, arg2: &mut 0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::play_coin::PlayCoinShard, arg3: address, arg4: u64, arg5: u64, arg6: u64, arg7: u8, arg8: vector<u8>, arg9: vector<u8>, arg10: &0x2::clock::Clock) {
        0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::play_coin::assert_admitted_version(arg1);
        0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::play_coin::assert_shard_admitted_version(arg2);
        assert_admitted_version(arg0);
        assert!(0x2::object::id<0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::play_coin::PlayCoinLedger>(arg1) == arg0.ledger_id, 13906835286740041731);
        assert!(0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::play_coin::issuance_seq_of(arg2, arg3) == 0, 13906835299625074693);
        assert!(arg4 == arg0.grant_amount, 13906835303920173063);
        assert!(arg5 > 0, 13906835308215271433);
        assert!(0x2::clock::timestamp_ms(arg10) < arg6, 13906835312510369803);
        assert!(0x2::table::contains<vector<u8>, EligibilityKey>(&arg0.eligibility_keys, arg8), 13906835316805468173);
        let v0 = 0x2::table::borrow<vector<u8>, EligibilityKey>(&arg0.eligibility_keys, arg8);
        assert!(!v0.revoked, 13906835325395533839);
        assert!(arg7 == v0.signature_type, 13906835329691287579);
        let v1 = claim_message(arg3, arg5, arg6);
        assert!(0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::signature::verify(arg7, &arg8, &v1, &arg9), 13906835351165468689);
        0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::play_coin::faucet_issue(arg1, arg2, arg3, arg4, arg5);
        let v2 = PlayCoinClaimed{
            faucet_id      : 0x2::object::id<PlayCoinFaucet>(arg0),
            ledger_id      : 0x2::object::id<0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::play_coin::PlayCoinLedger>(arg1),
            recipient      : arg3,
            amount         : arg4,
            balance        : 0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::play_coin::balance_of(arg2, arg3),
            issuance_seq   : arg5,
            signature_type : arg7,
            public_key     : arg8,
        };
        0x2::event::emit<PlayCoinClaimed>(v2);
    }

    fun claim_message(arg0: address, arg1: u64, arg2: u64) : vector<u8> {
        let v0 = b"dopan180/play-coin-faucet/claim-v1";
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg2));
        v0
    }

    public fun create_faucet(arg0: &0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::play_coin::PlayCoinIssuerCap, arg1: &mut 0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::play_coin::PlayCoinLedger, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::play_coin::assert_admitted_version(arg1);
        assert!(0x2::object::id<0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::play_coin::PlayCoinLedger>(arg1) == 0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::play_coin::issuer_cap_ledger_id(arg0), 13906834762754031619);
        assert!(arg2 > 0 && arg2 <= 0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::play_coin::max_issue_per_call(), 13906834779934949395);
        let v0 = 0x2::object::new(arg3);
        let v1 = PlayCoinFaucet{
            id               : v0,
            ledger_id        : 0x2::object::id<0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::play_coin::PlayCoinLedger>(arg1),
            module_version   : 2,
            grant_amount     : arg2,
            eligibility_keys : 0x2::table::new<vector<u8>, EligibilityKey>(arg3),
        };
        0x2::transfer::share_object<PlayCoinFaucet>(v1);
        let v2 = PlayCoinFaucetCreated{
            faucet_id    : 0x2::object::uid_to_inner(&v0),
            ledger_id    : 0x2::object::id<0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::play_coin::PlayCoinLedger>(arg1),
            grant_amount : arg2,
        };
        0x2::event::emit<PlayCoinFaucetCreated>(v2);
        0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::play_coin::destroy_faucet_registration(0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::play_coin::claim_faucet_registration(arg1));
    }

    public fun current_module_version() : u64 {
        2
    }

    public fun is_admitted_version(arg0: &PlayCoinFaucet) : bool {
        version_is_admitted(2, arg0.module_version)
    }

    public(friend) fun is_eligibility_key_revoked(arg0: &PlayCoinFaucet, arg1: vector<u8>) : bool {
        0x2::table::contains<vector<u8>, EligibilityKey>(&arg0.eligibility_keys, arg1) && 0x2::table::borrow<vector<u8>, EligibilityKey>(&arg0.eligibility_keys, arg1).revoked
    }

    public fun ledger_id(arg0: &PlayCoinFaucet) : 0x2::object::ID {
        arg0.ledger_id
    }

    public fun migrate_version(arg0: &mut PlayCoinFaucet, arg1: &0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::play_coin::PlayCoinIssuerCap) : u64 {
        if (arg0.module_version == 2) {
            return 2
        };
        assert!(arg0.module_version < 2, 13906835699058606109);
        arg0.module_version = 2;
        2
    }

    public fun module_version(arg0: &PlayCoinFaucet) : u64 {
        arg0.module_version
    }

    public fun register_eligibility_key(arg0: &0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::play_coin::PlayCoinIssuerCap, arg1: &mut PlayCoinFaucet, arg2: u8, arg3: vector<u8>) {
        assert_admitted_version(arg1);
        assert_bound_faucet(arg0, arg1);
        assert_valid_eligibility_key(arg2, &arg3);
        assert!(!0x2::table::contains<vector<u8>, EligibilityKey>(&arg1.eligibility_keys, arg3), 13906834921669263385);
        let v0 = EligibilityKey{
            revoked        : false,
            signature_type : arg2,
        };
        0x2::table::add<vector<u8>, EligibilityKey>(&mut arg1.eligibility_keys, arg3, v0);
        let v1 = EligibilityKeyRegistered{
            faucet_id      : 0x2::object::id<PlayCoinFaucet>(arg1),
            signature_type : arg2,
            public_key     : arg3,
        };
        0x2::event::emit<EligibilityKeyRegistered>(v1);
    }

    public fun revoke_eligibility_key(arg0: &0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::play_coin::PlayCoinIssuerCap, arg1: &mut PlayCoinFaucet, arg2: vector<u8>) {
        assert_admitted_version(arg1);
        assert_bound_faucet(arg0, arg1);
        assert!(0x2::table::contains<vector<u8>, EligibilityKey>(&arg1.eligibility_keys, arg2), 13906835110647037965);
        let v0 = 0x2::table::borrow_mut<vector<u8>, EligibilityKey>(&mut arg1.eligibility_keys, arg2);
        if (!v0.revoked) {
            v0.revoked = true;
            let v1 = EligibilityKeyRevoked{
                faucet_id  : 0x2::object::id<PlayCoinFaucet>(arg1),
                public_key : arg2,
            };
            0x2::event::emit<EligibilityKeyRevoked>(v1);
        };
    }

    public fun rotate_eligibility_key(arg0: &0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::play_coin::PlayCoinIssuerCap, arg1: &mut PlayCoinFaucet, arg2: vector<u8>, arg3: u8, arg4: vector<u8>) {
        assert_admitted_version(arg1);
        assert_bound_faucet(arg0, arg1);
        assert!(0x2::table::contains<vector<u8>, EligibilityKey>(&arg1.eligibility_keys, arg2), 13906835011862790157);
        assert!(!0x2::table::contains<vector<u8>, EligibilityKey>(&arg1.eligibility_keys, arg4), 13906835016158543897);
        assert_valid_eligibility_key(arg3, &arg4);
        0x2::table::borrow_mut<vector<u8>, EligibilityKey>(&mut arg1.eligibility_keys, arg2).revoked = true;
        let v0 = EligibilityKey{
            revoked        : false,
            signature_type : arg3,
        };
        0x2::table::add<vector<u8>, EligibilityKey>(&mut arg1.eligibility_keys, arg4, v0);
        let v1 = EligibilityKeyRotated{
            faucet_id           : 0x2::object::id<PlayCoinFaucet>(arg1),
            previous_public_key : arg2,
            signature_type      : arg3,
            public_key          : arg4,
        };
        0x2::event::emit<EligibilityKeyRotated>(v1);
    }

    public fun version_is_admitted(arg0: u64, arg1: u64) : bool {
        arg1 <= arg0
    }

    // decompiled from Move bytecode v7
}

