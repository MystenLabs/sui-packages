module 0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::funding_domain {
    struct EffectAppliedKey has copy, drop, store {
        effect_id: vector<u8>,
    }

    struct ReservationAppliedKey has copy, drop, store {
        reservation_id: vector<u8>,
    }

    struct RefundAppliedKey has copy, drop, store {
        reservation_id: vector<u8>,
    }

    struct FundingPart has copy, drop {
        source: u8,
        custody_object_id: vector<u8>,
        amount: u64,
    }

    struct PredictReservationV1 has copy, drop {
        version: u16,
        chain_id: vector<u8>,
        funding_domain_id: vector<u8>,
        wallet: vector<u8>,
        operation_id: vector<u8>,
        reservation_id: vector<u8>,
        amount: u64,
        funding_parts: vector<FundingPart>,
        binding_digest: vector<u8>,
        original_intent_digest: vector<u8>,
        wallet_ownership_epoch: u64,
        wallet_revision: u64,
        decision: u8,
        fill_digest: 0x1::option::Option<vector<u8>>,
    }

    struct PredictEffectV1 has copy, drop {
        version: u16,
        binding: 0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::ownership::PredictBindingV1,
        effect_id: vector<u8>,
        economic_intent_digest: vector<u8>,
        execution_ownership_epoch: u64,
        kind: u8,
        payload_digest: vector<u8>,
    }

    struct PredictFillV1 has copy, drop {
        version: u16,
        binding: 0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::ownership::PredictBindingV1,
        operation_id: vector<u8>,
        wallet: vector<u8>,
        wallet_nonce: u64,
        reservation_id: vector<u8>,
        amount: u64,
        outcome: u16,
        shares: u64,
        market_sequence: u64,
        prior_market_digest: vector<u8>,
        resulting_market_digest: vector<u8>,
        original_intent_digest: vector<u8>,
        arrival_evidence_digest: vector<u8>,
    }

    struct PredictDrainV1 has copy, drop {
        version: u16,
        chain_id: vector<u8>,
        environment_id: vector<u8>,
        package_id: vector<u8>,
        funding_domain_id: vector<u8>,
        wallet: vector<u8>,
        wallet_ownership_epoch: u64,
        zero_obligation_root: vector<u8>,
    }

    struct WalletEnrolled has copy, drop {
        holder: address,
        domain_id: vector<u8>,
        epoch: u64,
    }

    struct ReservedStakeSwept has copy, drop {
        effect_id: vector<u8>,
        holder: address,
        amount: u64,
        reserve_id: 0x2::object::ID,
    }

    struct ExecutionCreditGranted has copy, drop {
        holder: address,
        execution_id: vector<u8>,
        amount: u64,
        reserve_id: 0x2::object::ID,
    }

    struct DelegationReleased has copy, drop {
        holder: address,
        domain_id: vector<u8>,
        epoch: u64,
    }

    fun apply_parts(arg0: &mut 0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::reserve::ExecutionReserve, arg1: &0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::play_coin::PlayCoinLedger, arg2: &mut 0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::play_coin::PlayCoinShard, arg3: &mut 0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::play_coin::PlayCoinEscrowBook, arg4: &0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::eligibility::EligibilityRegistry, arg5: address, arg6: vector<u8>, arg7: &PredictReservationV1) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<FundingPart>(&arg7.funding_parts)) {
            let v1 = 0x1::vector::borrow<FundingPart>(&arg7.funding_parts, v0);
            if (v1.source == 0) {
                0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::play_coin::decrease_delegated_backing(arg1, arg2, arg5, v1.amount);
                0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::reserve::record_domain_contribution(arg0, arg1, arg2, arg3, arg4, arg5, v1.amount);
            } else {
                assert!(v1.source == 1, 13906838430657806365);
                assert!(arg6 == 0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::reserve::execution_id(arg0), 13906838434952642587);
                let v2 = 0x2::object::id<0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::reserve::ExecutionReserve>(arg0);
                assert!(v1.custody_object_id == 0x2::object::id_to_bytes(&v2), 13906838456429445177);
                0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::play_coin::take_execution_credit(arg2, arg5, arg6, v1.amount);
                0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::reserve::record_domain_credit_contribution(arg0, arg5, v1.amount);
            };
            v0 = v0 + 1;
        };
    }

    public(friend) fun assert_domain_current(arg0: &0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::play_coin::PlayCoinLedger, arg1: address, arg2: u64) {
        0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::play_coin::assert_enrolled(arg0, arg1);
        assert!(0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::play_coin::domain_epoch(arg0, arg1) == arg2, 13906838340462837779);
    }

    fun authorize_effect(arg0: &0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::reserve::ExecutionReserve, arg1: &0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::frontier_commitment::FrontierCommitmentStore, arg2: &0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::AttestationRegistry<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::NitroEvidence>, arg3: &0x2::clock::Clock, arg4: &PredictEffectV1, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>) : vector<u8> {
        assert!(arg4.payload_digest == arg4.economic_intent_digest, 13906837777824088113);
        0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::ownership::assert_deployment_identity(arg1, 0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::ownership::binding_chain_id(&arg4.binding), 0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::ownership::binding_environment_id(&arg4.binding), 0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::ownership::binding_package_id(&arg4.binding));
        let v0 = 0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::ownership::binding_execution_id(&arg4.binding);
        assert!(v0 == 0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::reserve::execution_id(arg0), 13906837816477351963);
        let v1 = 0x2::object::id<0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::reserve::ExecutionReserve>(arg0);
        assert!(0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::ownership::binding_reserve_id(&arg4.binding) == 0x2::object::id_to_bytes(&v1), 13906837829363302443);
        assert!(0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::ownership::execution_fence_epoch(arg1, v0) == arg4.execution_ownership_epoch, 13906837846541991961);
        0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::ownership::verify_execution_envelope(arg1, arg2, arg3, v0, 0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::ownership::record_digest(b"dopa_predict::runtime_effect_v1", arg5), arg6, arg7);
        let v2 = derive_effect_id(0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::ownership::embedded_binding_bytes(&arg5), arg4.kind, arg4.economic_intent_digest);
        assert!(v2 == arg4.effect_id, 13906837915262779437);
        v2
    }

    fun binding_digest_of(arg0: vector<u8>) : vector<u8> {
        0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::ownership::binding_digest(0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::ownership::embedded_binding_bytes(&arg0))
    }

    public(friend) fun decode_drain(arg0: vector<u8>) : PredictDrainV1 {
        let v0 = 0x2::bcs::new(arg0);
        let v1 = 0x2::bcs::peel_u16(&mut v0);
        assert!(v1 == 1, 13906838507966169101);
        let v2 = PredictDrainV1{
            version                : v1,
            chain_id               : 0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::ownership::peel_id32(&mut v0),
            environment_id         : 0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::ownership::peel_id32(&mut v0),
            package_id             : 0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::ownership::peel_id32(&mut v0),
            funding_domain_id      : 0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::ownership::peel_id32(&mut v0),
            wallet                 : 0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::ownership::peel_id32(&mut v0),
            wallet_ownership_epoch : 0x2::bcs::peel_u64(&mut v0),
            zero_obligation_root   : 0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::ownership::peel_id32(&mut v0),
        };
        0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::ownership::assert_consumed(v0);
        v2
    }

    public(friend) fun decode_effect(arg0: vector<u8>) : PredictEffectV1 {
        let v0 = 0x2::bcs::new(arg0);
        let v1 = 0x2::bcs::peel_u16(&mut v0);
        assert!(v1 == 1, 13906838851563552781);
        let v2 = PredictEffectV1{
            version                   : v1,
            binding                   : 0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::ownership::peel_binding(&mut v0),
            effect_id                 : 0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::ownership::peel_id32(&mut v0),
            economic_intent_digest    : 0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::ownership::peel_id32(&mut v0),
            execution_ownership_epoch : 0x2::bcs::peel_u64(&mut v0),
            kind                      : 0x2::bcs::peel_u8(&mut v0),
            payload_digest            : 0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::ownership::peel_id32(&mut v0),
        };
        assert!(v2.kind <= 5, 13906838898809372703);
        0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::ownership::assert_consumed(v0);
        v2
    }

    public(friend) fun decode_fill(arg0: vector<u8>) : PredictFillV1 {
        let v0 = 0x2::bcs::new(arg0);
        let v1 = 0x2::bcs::peel_u16(&mut v0);
        assert!(v1 == 1, 13906838933167931405);
        let v2 = PredictFillV1{
            version                 : v1,
            binding                 : 0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::ownership::peel_binding(&mut v0),
            operation_id            : 0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::ownership::peel_id32(&mut v0),
            wallet                  : 0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::ownership::peel_id32(&mut v0),
            wallet_nonce            : 0x2::bcs::peel_u64(&mut v0),
            reservation_id          : 0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::ownership::peel_id32(&mut v0),
            amount                  : 0x2::bcs::peel_u64(&mut v0),
            outcome                 : 0x2::bcs::peel_u16(&mut v0),
            shares                  : 0x2::bcs::peel_u64(&mut v0),
            market_sequence         : 0x2::bcs::peel_u64(&mut v0),
            prior_market_digest     : 0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::ownership::peel_id32(&mut v0),
            resulting_market_digest : 0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::ownership::peel_id32(&mut v0),
            original_intent_digest  : 0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::ownership::peel_id32(&mut v0),
            arrival_evidence_digest : 0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::ownership::peel_id32(&mut v0),
        };
        0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::ownership::assert_consumed(v0);
        v2
    }

    public(friend) fun decode_reservation(arg0: vector<u8>) : PredictReservationV1 {
        let v0 = 0x2::bcs::new(arg0);
        let v1 = 0x2::bcs::peel_u16(&mut v0);
        assert!(v1 == 1, 13906838585275580429);
        let v2 = 0x2::bcs::peel_u64(&mut v0);
        let v3 = 0x2::bcs::peel_vec_length(&mut v0);
        assert!(v3 >= 1 && v3 <= 2, 13906838619636760611);
        let v4 = 0x1::vector::empty<FundingPart>();
        let v5 = 0;
        let v6 = 0x1::option::none<u8>();
        let v7 = 0;
        while (v7 < v3) {
            let v8 = 0x2::bcs::peel_u8(&mut v0);
            assert!(v8 == 0 || v8 == 1, 13906838649701138461);
            if (0x1::option::is_some<u8>(&v6)) {
                assert!(v8 > *0x1::option::borrow<u8>(&v6), 13906838658291466275);
            };
            v6 = 0x1::option::some<u8>(v8);
            let v9 = 0x2::bcs::peel_u64(&mut v0);
            assert!(v9 > 0, 13906838679766302755);
            v5 = v5 + v9;
            let v10 = FundingPart{
                source            : v8,
                custody_object_id : 0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::ownership::peel_id32(&mut v0),
                amount            : v9,
            };
            0x1::vector::push_back<FundingPart>(&mut v4, v10);
            v7 = v7 + 1;
        };
        assert!(v5 == v2, 13906838701241139235);
        let v11 = 0x2::bcs::peel_u8(&mut v0);
        assert!(v11 <= 2, 13906838727010811937);
        let v12 = 0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::ownership::peel_option_id32(&mut v0);
        if (v11 == 1) {
            assert!(0x1::option::is_some<vector<u8>>(&v12), 13906838739896238121);
        } else {
            assert!(0x1::option::is_none<vector<u8>>(&v12), 13906838748486172713);
        };
        0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::ownership::assert_consumed(v0);
        PredictReservationV1{
            version                : v1,
            chain_id               : 0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::ownership::peel_id32(&mut v0),
            funding_domain_id      : 0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::ownership::peel_id32(&mut v0),
            wallet                 : 0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::ownership::peel_id32(&mut v0),
            operation_id           : 0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::ownership::peel_id32(&mut v0),
            reservation_id         : 0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::ownership::peel_id32(&mut v0),
            amount                 : v2,
            funding_parts          : v4,
            binding_digest         : 0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::ownership::peel_id32(&mut v0),
            original_intent_digest : 0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::ownership::peel_id32(&mut v0),
            wallet_ownership_epoch : 0x2::bcs::peel_u64(&mut v0),
            wallet_revision        : 0x2::bcs::peel_u64(&mut v0),
            decision               : v11,
            fill_digest            : v12,
        }
    }

    public(friend) fun delegation_drain_domain() : vector<u8> {
        b"dopa_predict::delegation_drain_v1"
    }

    fun derive_effect_id(arg0: vector<u8>, arg1: u8, arg2: vector<u8>) : vector<u8> {
        0x1::vector::push_back<u8>(&mut arg0, arg1);
        0x1::vector::append<u8>(&mut arg0, arg2);
        0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::ownership::record_digest(b"dopa_predict::runtime_effect_v1", arg0)
    }

    public(friend) fun drain_chain_id(arg0: &PredictDrainV1) : vector<u8> {
        arg0.chain_id
    }

    public(friend) fun drain_environment_id(arg0: &PredictDrainV1) : vector<u8> {
        arg0.environment_id
    }

    public(friend) fun drain_funding_domain_id(arg0: &PredictDrainV1) : vector<u8> {
        arg0.funding_domain_id
    }

    public(friend) fun drain_package_id(arg0: &PredictDrainV1) : vector<u8> {
        arg0.package_id
    }

    public(friend) fun drain_version(arg0: &PredictDrainV1) : u16 {
        arg0.version
    }

    public(friend) fun drain_wallet(arg0: &PredictDrainV1) : vector<u8> {
        arg0.wallet
    }

    public(friend) fun drain_wallet_epoch(arg0: &PredictDrainV1) : u64 {
        arg0.wallet_ownership_epoch
    }

    public(friend) fun drain_wallet_ownership_epoch(arg0: &PredictDrainV1) : u64 {
        arg0.wallet_ownership_epoch
    }

    public(friend) fun drain_zero_obligation_root(arg0: &PredictDrainV1) : vector<u8> {
        arg0.zero_obligation_root
    }

    public(friend) fun effect_binding_execution_id(arg0: &PredictEffectV1) : vector<u8> {
        0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::ownership::binding_execution_id(&arg0.binding)
    }

    public(friend) fun effect_execution_epoch(arg0: &PredictEffectV1) : u64 {
        arg0.execution_ownership_epoch
    }

    public(friend) fun effect_id_of(arg0: &PredictEffectV1) : vector<u8> {
        arg0.effect_id
    }

    public(friend) fun effect_intent_digest(arg0: &PredictEffectV1) : vector<u8> {
        arg0.economic_intent_digest
    }

    public(friend) fun effect_kind(arg0: &PredictEffectV1) : u8 {
        arg0.kind
    }

    public(friend) fun effect_payload_digest(arg0: &PredictEffectV1) : vector<u8> {
        arg0.payload_digest
    }

    public(friend) fun effect_version(arg0: &PredictEffectV1) : u16 {
        arg0.version
    }

    public(friend) fun empty_root() : vector<u8> {
        x"fa9849e44b8ec17fe1a9a7b2b7d823877ce796316f08f098562d630a2616a18d"
    }

    public fun enroll_wallet(arg0: &mut 0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::play_coin::PlayCoinLedger, arg1: &0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::frontier_commitment::FrontierCommitmentStore, arg2: &mut 0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::play_coin::PlayCoinShard, arg3: &0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::AttestationRegistry<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::NitroEvidence>, arg4: address, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::play_coin::assert_admitted_version(arg0);
        0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::frontier_commitment::assert_admitted_version(arg1);
        0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::play_coin::assert_shard_admitted_version(arg2);
        let v0 = decode_drain(arg6);
        0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::ownership::assert_deployment_identity(arg1, v0.chain_id, v0.environment_id, v0.package_id);
        assert!(v0.zero_obligation_root == x"fa9849e44b8ec17fe1a9a7b2b7d823877ce796316f08f098562d630a2616a18d", 13906835252381089807);
        assert!(v0.funding_domain_id == arg5, 13906835256676188177);
        assert!(0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::ownership::id32_to_address(v0.wallet) == arg4, 13906835260971155473);
        assert!(0x1::vector::length<u8>(&arg5) == 32, 13906835265266122769);
        if (0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::play_coin::is_enrolled(arg0, arg4)) {
            assert!(0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::play_coin::domain_id(arg0, arg4) == arg5, 13906835273856057361);
            return
        };
        assert!(0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::ownership::has_wallet_fence(arg0, arg4), 13906835286741352471);
        0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::ownership::verify_wallet_envelope(arg0, arg3, arg9, arg4, 0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::ownership::record_digest(b"dopa_predict::delegation_drain_v1", arg6), arg7, arg8);
        let v1 = 0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::ownership::wallet_fence_epoch(arg0, arg4);
        0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::play_coin::add_wallet_domain(arg0, arg2, arg4, arg5, v1, 0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::ownership::wallet_fresh_key(arg0, arg4), arg10);
        let v2 = WalletEnrolled{
            holder    : arg4,
            domain_id : arg5,
            epoch     : v1,
        };
        0x2::event::emit<WalletEnrolled>(v2);
    }

    public(friend) fun fill_amount(arg0: &PredictFillV1) : u64 {
        arg0.amount
    }

    public(friend) fun fill_arrival_digest(arg0: &PredictFillV1) : vector<u8> {
        arg0.arrival_evidence_digest
    }

    public(friend) fun fill_binding_execution_id(arg0: &PredictFillV1) : vector<u8> {
        0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::ownership::binding_execution_id(&arg0.binding)
    }

    public(friend) fun fill_intent_digest(arg0: &PredictFillV1) : vector<u8> {
        arg0.original_intent_digest
    }

    public(friend) fun fill_market_sequence(arg0: &PredictFillV1) : u64 {
        arg0.market_sequence
    }

    public(friend) fun fill_operation_id(arg0: &PredictFillV1) : vector<u8> {
        arg0.operation_id
    }

    public(friend) fun fill_outcome(arg0: &PredictFillV1) : u16 {
        arg0.outcome
    }

    public(friend) fun fill_prior_market_digest(arg0: &PredictFillV1) : vector<u8> {
        arg0.prior_market_digest
    }

    public(friend) fun fill_reservation_id(arg0: &PredictFillV1) : vector<u8> {
        arg0.reservation_id
    }

    public(friend) fun fill_resulting_market_digest(arg0: &PredictFillV1) : vector<u8> {
        arg0.resulting_market_digest
    }

    public(friend) fun fill_shares(arg0: &PredictFillV1) : u64 {
        arg0.shares
    }

    public(friend) fun fill_version(arg0: &PredictFillV1) : u16 {
        arg0.version
    }

    public(friend) fun fill_wallet(arg0: &PredictFillV1) : vector<u8> {
        arg0.wallet
    }

    public(friend) fun fill_wallet_nonce(arg0: &PredictFillV1) : u64 {
        arg0.wallet_nonce
    }

    public fun grant_execution_credit(arg0: &mut 0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::reserve::ExecutionReserve, arg1: &0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::play_coin::PlayCoinLedger, arg2: &mut 0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::play_coin::PlayCoinShard, arg3: &0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::play_coin::PlayCoinEscrowBook, arg4: &0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::frontier_commitment::FrontierCommitmentStore, arg5: &0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::AttestationRegistry<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::NitroEvidence>, arg6: &0x2::clock::Clock, arg7: vector<u8>, arg8: vector<u8>, arg9: vector<u8>, arg10: vector<u8>) {
        0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::reserve::assert_admitted_version(arg0);
        0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::play_coin::assert_admitted_version(arg1);
        0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::play_coin::assert_shard_admitted_version(arg2);
        0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::play_coin::assert_book_admitted_version(arg3);
        0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::frontier_commitment::assert_admitted_version(arg4);
        let v0 = decode_fill(arg7);
        0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::ownership::assert_deployment_identity(arg4, 0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::ownership::binding_chain_id(&v0.binding), 0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::ownership::binding_environment_id(&v0.binding), 0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::ownership::binding_package_id(&v0.binding));
        let v1 = 0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::ownership::binding_execution_id(&v0.binding);
        assert!(v1 == 0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::reserve::execution_id(arg0), 13906837459995066395);
        let v2 = 0x2::object::id<0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::reserve::ExecutionReserve>(arg0);
        assert!(0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::ownership::binding_reserve_id(&v0.binding) == 0x2::object::id_to_bytes(&v2), 13906837472879968283);
        0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::ownership::verify_execution_envelope(arg4, arg5, arg6, v1, 0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::ownership::record_digest(b"dopa_predict::attested_fill_v1", arg7), arg8, arg9);
        0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::terminal_gate::require_endorsement(arg4, 0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::ownership::binding_digest(0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::ownership::embedded_binding_bytes(&arg7)), arg10);
        let v3 = 0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::ownership::id32_to_address(v0.wallet);
        0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::play_coin::assert_enrolled(arg1, v3);
        assert!(!0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::play_coin::domain_terminal(arg1, v3), 13906837550188986389);
        let v4 = EffectAppliedKey{effect_id: derive_effect_id(0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::ownership::embedded_binding_bytes(&arg7), 3, 0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::ownership::record_digest(b"dopa_predict::attested_fill_v1", arg7))};
        if (0x2::dynamic_field::exists_with_type<EffectAppliedKey, bool>(0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::reserve::uid(arg0), v4)) {
            return
        };
        0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::reserve::reserve_execution_credit(arg0, arg1, arg3, v0.amount);
        0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::play_coin::add_execution_credit(arg2, v3, v1, v0.amount);
        0x2::dynamic_field::add<EffectAppliedKey, bool>(0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::reserve::uid_mut(arg0), v4, true);
        let v5 = ExecutionCreditGranted{
            holder       : v3,
            execution_id : v1,
            amount       : v0.amount,
            reserve_id   : 0x2::object::id<0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::reserve::ExecutionReserve>(arg0),
        };
        0x2::event::emit<ExecutionCreditGranted>(v5);
    }

    public fun issue_and_enroll(arg0: &0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::play_coin::PlayCoinIssuerCap, arg1: &mut 0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::play_coin::PlayCoinLedger, arg2: &0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::frontier_commitment::FrontierCommitmentStore, arg3: &mut 0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::play_coin::PlayCoinShard, arg4: &0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::AttestationRegistry<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::NitroEvidence>, arg5: address, arg6: u64, arg7: u64, arg8: vector<u8>, arg9: vector<u8>, arg10: vector<u8>, arg11: vector<u8>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::play_coin::assert_admitted_version(arg1);
        0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::frontier_commitment::assert_admitted_version(arg2);
        0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::play_coin::assert_shard_admitted_version(arg3);
        0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::play_coin::issue(arg0, arg1, arg3, arg5, arg6, arg7);
        enroll_wallet(arg1, arg2, arg3, arg4, arg5, arg8, arg9, arg10, arg11, arg12, arg13);
    }

    fun mark_reservation_applied(arg0: &mut 0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::reserve::ExecutionReserve, arg1: vector<u8>, arg2: vector<u8>) : bool {
        let v0 = 0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::reserve::uid_mut(arg0);
        let v1 = EffectAppliedKey{effect_id: arg1};
        if (0x2::dynamic_field::exists_with_type<EffectAppliedKey, bool>(v0, v1)) {
            return false
        };
        let v2 = ReservationAppliedKey{reservation_id: arg2};
        assert!(!0x2::dynamic_field::exists_with_type<ReservationAppliedKey, bool>(v0, v2), 13906838009752977467);
        0x2::dynamic_field::add<EffectAppliedKey, bool>(v0, v1, true);
        0x2::dynamic_field::add<ReservationAppliedKey, bool>(v0, v2, true);
        true
    }

    public fun refund_by_terminal(arg0: &mut 0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::reserve::ExecutionReserve, arg1: &0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::play_coin::PlayCoinLedger, arg2: &mut 0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::play_coin::PlayCoinShard, arg3: &mut 0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::play_coin::PlayCoinEscrowBook, arg4: &0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::AttestationRegistry<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::NitroEvidence>, arg5: &0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::frontier_commitment::FrontierCommitmentStore, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: vector<u8>, arg10: &0x2::clock::Clock) {
        0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::reserve::assert_admitted_version(arg0);
        0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::play_coin::assert_admitted_version(arg1);
        0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::play_coin::assert_shard_admitted_version(arg2);
        0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::play_coin::assert_book_admitted_version(arg3);
        0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::frontier_commitment::assert_admitted_version(arg5);
        let v0 = decode_effect(arg6);
        assert!(v0.kind == 4, 13906837047678992423);
        let v1 = binding_digest_of(arg6);
        0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::terminal_gate::require_cancelled(arg5, v1);
        let v2 = decode_fill(arg9);
        assert!(0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::ownership::record_digest(b"dopa_predict::attested_fill_v1", arg9) == v0.payload_digest, 13906837120693960751);
        assert!(0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::ownership::binding_digest(0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::ownership::embedded_binding_bytes(&arg9)) == v1, 13906837150758731823);
        let v3 = EffectAppliedKey{effect_id: authorize_effect(arg0, arg5, arg4, arg10, &v0, arg6, arg7, arg8)};
        if (0x2::dynamic_field::exists_with_type<EffectAppliedKey, bool>(0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::reserve::uid_mut(arg0), v3)) {
            return
        };
        0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::reserve::assert_open(arg0);
        let v4 = 0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::reserve::uid_mut(arg0);
        0x2::dynamic_field::add<EffectAppliedKey, bool>(v4, v3, true);
        let v5 = RefundAppliedKey{reservation_id: v2.reservation_id};
        0x2::dynamic_field::add<RefundAppliedKey, bool>(v4, v5, true);
        if (v2.amount > 0) {
            let v6 = 0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::ownership::id32_to_address(v2.wallet);
            0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::reserve::debit_contribution(arg0, v6, v2.amount);
            0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::play_coin::emit_inplay_stake_settled(0x2::object::id<0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::reserve::ExecutionReserve>(arg0), v6, v2.amount);
            0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::play_coin::release_to_holder(arg1, arg2, arg3, 0x2::object::id<0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::reserve::ExecutionReserve>(arg0), v6, v2.amount);
        };
        0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::reserve::assert_backed(arg0, 0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::play_coin::escrow_account_balance(arg3, 0x2::object::id<0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::reserve::ExecutionReserve>(arg0)));
    }

    public fun release_delegation(arg0: &mut 0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::play_coin::PlayCoinLedger, arg1: &mut 0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::play_coin::PlayCoinShard, arg2: &0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::frontier_commitment::FrontierCommitmentStore, arg3: &0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::AttestationRegistry<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::NitroEvidence>, arg4: &0x2::clock::Clock, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>) {
        0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::play_coin::assert_admitted_version(arg0);
        0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::play_coin::assert_shard_admitted_version(arg1);
        0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::frontier_commitment::assert_admitted_version(arg2);
        let v0 = decode_drain(arg5);
        0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::ownership::assert_deployment_identity(arg2, v0.chain_id, v0.environment_id, v0.package_id);
        assert!(v0.zero_obligation_root == x"fa9849e44b8ec17fe1a9a7b2b7d823877ce796316f08f098562d630a2616a18d", 13906838207318589455);
        let v1 = 0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::ownership::id32_to_address(v0.wallet);
        0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::play_coin::assert_enrolled(arg0, v1);
        assert!(0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::play_coin::domain_id(arg0, v1) == v0.funding_domain_id, 13906838220203622417);
        if (0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::play_coin::domain_terminal(arg0, v1)) {
            return
        };
        assert_domain_current(arg0, v1, v0.wallet_ownership_epoch);
        0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::ownership::verify_wallet_envelope(arg0, arg3, arg4, v1, 0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::ownership::record_digest(b"dopa_predict::delegation_drain_v1", arg5), arg6, arg7);
        0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::play_coin::set_domain_terminal(arg0, v1);
        let v2 = DelegationReleased{
            holder    : v1,
            domain_id : v0.funding_domain_id,
            epoch     : v0.wallet_ownership_epoch,
        };
        0x2::event::emit<DelegationReleased>(v2);
    }

    public(friend) fun reservation_amount(arg0: &PredictReservationV1) : u64 {
        arg0.amount
    }

    public(friend) fun reservation_binding_digest(arg0: &PredictReservationV1) : vector<u8> {
        arg0.binding_digest
    }

    public(friend) fun reservation_chain_id(arg0: &PredictReservationV1) : vector<u8> {
        arg0.chain_id
    }

    public(friend) fun reservation_decision(arg0: &PredictReservationV1) : u8 {
        arg0.decision
    }

    public(friend) fun reservation_domain_id(arg0: &PredictReservationV1) : vector<u8> {
        arg0.funding_domain_id
    }

    public(friend) fun reservation_fill_digest(arg0: &PredictReservationV1) : 0x1::option::Option<vector<u8>> {
        arg0.fill_digest
    }

    public(friend) fun reservation_id_of(arg0: &PredictReservationV1) : vector<u8> {
        arg0.reservation_id
    }

    public(friend) fun reservation_intent_digest(arg0: &PredictReservationV1) : vector<u8> {
        arg0.original_intent_digest
    }

    public(friend) fun reservation_operation_id(arg0: &PredictReservationV1) : vector<u8> {
        arg0.operation_id
    }

    public(friend) fun reservation_part_amount(arg0: &PredictReservationV1, arg1: u64) : u64 {
        0x1::vector::borrow<FundingPart>(&arg0.funding_parts, arg1).amount
    }

    public(friend) fun reservation_part_custody(arg0: &PredictReservationV1, arg1: u64) : vector<u8> {
        0x1::vector::borrow<FundingPart>(&arg0.funding_parts, arg1).custody_object_id
    }

    public(friend) fun reservation_part_source(arg0: &PredictReservationV1, arg1: u64) : u8 {
        0x1::vector::borrow<FundingPart>(&arg0.funding_parts, arg1).source
    }

    public(friend) fun reservation_parts_len(arg0: &PredictReservationV1) : u64 {
        0x1::vector::length<FundingPart>(&arg0.funding_parts)
    }

    public(friend) fun reservation_revision(arg0: &PredictReservationV1) : u64 {
        arg0.wallet_revision
    }

    public(friend) fun reservation_version(arg0: &PredictReservationV1) : u16 {
        arg0.version
    }

    public(friend) fun reservation_wallet(arg0: &PredictReservationV1) : vector<u8> {
        arg0.wallet
    }

    public(friend) fun reservation_wallet_epoch(arg0: &PredictReservationV1) : u64 {
        arg0.wallet_ownership_epoch
    }

    public fun sweep_reserved_catalog_fill(arg0: &mut 0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::market::PredictionMarket, arg1: &mut 0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::reserve::ExecutionReserve, arg2: &0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::play_coin::PlayCoinLedger, arg3: &mut 0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::play_coin::PlayCoinShard, arg4: &mut 0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::play_coin::PlayCoinEscrowBook, arg5: &0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::eligibility::EligibilityRegistry, arg6: &0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::AttestationRegistry<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::NitroEvidence>, arg7: &0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::frontier_commitment::FrontierCommitmentStore, arg8: vector<u8>, arg9: vector<u8>, arg10: vector<u8>, arg11: vector<u8>, arg12: vector<u8>, arg13: vector<u8>, arg14: vector<u8>, arg15: &0x2::clock::Clock) {
        0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::market::assert_writable(arg0);
        0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::reserve::assert_admitted_version(arg1);
        0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::play_coin::assert_admitted_version(arg2);
        0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::play_coin::assert_shard_admitted_version(arg3);
        0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::play_coin::assert_book_admitted_version(arg4);
        0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::eligibility::assert_admitted_version(arg5);
        0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::frontier_commitment::assert_admitted_version(arg7);
        let v0 = decode_effect(arg8);
        assert!(v0.kind == 0, 13906836450678407205);
        let v1 = decode_fill(arg14);
        assert!(0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::ownership::record_digest(b"dopa_predict::attested_fill_v1", arg14) == v0.payload_digest, 13906836480743833647);
        0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::market::assert_binding_names_this_market(arg0, &v0.binding);
        let v2 = decode_reservation(arg11);
        if (!sweep_reserved_stake_parts(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg15)) {
            return
        };
        assert!(v1.amount == v2.amount, 13906836635362656303);
        0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::market::assert_open_for_positions(arg0, arg15);
        0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::market::credit_position(arg0, 0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::ownership::id32_to_address(v2.wallet), v1.outcome, v2.amount, v1.shares);
    }

    public fun sweep_reserved_stake(arg0: &mut 0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::reserve::ExecutionReserve, arg1: &0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::play_coin::PlayCoinLedger, arg2: &mut 0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::play_coin::PlayCoinShard, arg3: &mut 0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::play_coin::PlayCoinEscrowBook, arg4: &0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::eligibility::EligibilityRegistry, arg5: &0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::AttestationRegistry<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::NitroEvidence>, arg6: &0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::frontier_commitment::FrontierCommitmentStore, arg7: vector<u8>, arg8: vector<u8>, arg9: vector<u8>, arg10: vector<u8>, arg11: vector<u8>, arg12: vector<u8>, arg13: &0x2::clock::Clock) {
        0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::reserve::assert_admitted_version(arg0);
        0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::play_coin::assert_admitted_version(arg1);
        0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::play_coin::assert_shard_admitted_version(arg2);
        0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::play_coin::assert_book_admitted_version(arg3);
        0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::eligibility::assert_admitted_version(arg4);
        0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::frontier_commitment::assert_admitted_version(arg6);
        if (sweep_reserved_stake_parts(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13)) {
            let v0 = decode_reservation(arg10);
            0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::play_coin::emit_inplay_stake_opened(0x2::object::id<0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::reserve::ExecutionReserve>(arg0), 0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::ownership::id32_to_address(v0.wallet), v0.amount);
        };
    }

    fun sweep_reserved_stake_parts(arg0: &mut 0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::reserve::ExecutionReserve, arg1: &0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::play_coin::PlayCoinLedger, arg2: &mut 0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::play_coin::PlayCoinShard, arg3: &mut 0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::play_coin::PlayCoinEscrowBook, arg4: &0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::eligibility::EligibilityRegistry, arg5: &0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::AttestationRegistry<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::NitroEvidence>, arg6: &0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::frontier_commitment::FrontierCommitmentStore, arg7: vector<u8>, arg8: vector<u8>, arg9: vector<u8>, arg10: vector<u8>, arg11: vector<u8>, arg12: vector<u8>, arg13: &0x2::clock::Clock) : bool {
        let v0 = decode_effect(arg7);
        assert!(v0.kind == 0, 13906835930987364389);
        let v1 = authorize_effect(arg0, arg6, arg5, arg13, &v0, arg7, arg8, arg9);
        let v2 = decode_reservation(arg10);
        0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::ownership::assert_deployment_chain_id(arg6, v2.chain_id);
        assert!(v2.decision == 1, 13906835991117168681);
        assert!(*0x1::option::borrow<vector<u8>>(&v2.fill_digest) == v0.payload_digest, 13906836012592922679);
        assert!(v2.binding_digest == binding_digest_of(arg7), 13906836029772791863);
        let v3 = 0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::ownership::id32_to_address(v2.wallet);
        0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::play_coin::assert_enrolled(arg1, v3);
        assert!(!0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::play_coin::domain_terminal(arg1, v3), 13906836051245400085);
        assert!(0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::play_coin::domain_id(arg1, v3) == v2.funding_domain_id, 13906836064130039825);
        assert_domain_current(arg1, v3, v2.wallet_ownership_epoch);
        assert!(0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::ownership::wallet_fence_epoch(arg1, v3) == v2.wallet_ownership_epoch, 13906836085605269527);
        0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::ownership::verify_wallet_envelope(arg1, arg5, arg13, v3, 0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::ownership::record_digest(b"dopa_predict::wallet_reservation_v1", arg10), arg11, arg12);
        let v4 = mark_reservation_applied(arg0, v1, v2.reservation_id);
        if (!v4) {
            return false
        };
        let v5 = RefundAppliedKey{reservation_id: v2.reservation_id};
        assert!(!0x2::dynamic_field::exists_with_type<RefundAppliedKey, bool>(0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::reserve::uid(arg0), v5), 13906836184391483445);
        apply_parts(arg0, arg1, arg2, arg3, arg4, v3, 0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::ownership::binding_execution_id(&v0.binding), &v2);
        let v6 = ReservedStakeSwept{
            effect_id  : v1,
            holder     : v3,
            amount     : v2.amount,
            reserve_id : 0x2::object::id<0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::reserve::ExecutionReserve>(arg0),
        };
        0x2::event::emit<ReservedStakeSwept>(v6);
        true
    }

    public fun void_reservation(arg0: &mut 0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::reserve::ExecutionReserve, arg1: &0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::AttestationRegistry<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::NitroEvidence>, arg2: &0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::frontier_commitment::FrontierCommitmentStore, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: &0x2::clock::Clock) {
        0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::reserve::assert_admitted_version(arg0);
        0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::frontier_commitment::assert_admitted_version(arg2);
        let v0 = decode_effect(arg3);
        assert!(v0.kind == 4, 13906836759916183591);
        let v1 = decode_reservation(arg6);
        assert!(v1.decision != 0, 13906836824341479475);
        let v2 = binding_digest_of(arg3);
        assert!(v1.binding_digest == v2, 13906836837226643511);
        assert!(v0.payload_digest == 0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::ownership::record_digest(b"dopa_predict::wallet_reservation_v1", arg6), 13906836854406905917);
        let v3 = authorize_effect(arg0, arg2, arg1, arg7, &v0, arg3, arg4, arg5);
        0x3134eb579bf9ffc33e30fd53f919502dead510400b5ebbf1a1fdc241938583a::terminal_gate::require_cancelled(arg2, v2);
        if (!mark_reservation_applied(arg0, v3, v1.reservation_id)) {
            return
        };
    }

    public(friend) fun wallet_reservation_domain() : vector<u8> {
        b"dopa_predict::wallet_reservation_v1"
    }

    // decompiled from Move bytecode v7
}

