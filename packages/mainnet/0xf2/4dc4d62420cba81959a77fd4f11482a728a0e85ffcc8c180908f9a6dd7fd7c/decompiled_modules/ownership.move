module 0xf24dc4d62420cba81959a77fd4f11482a728a0e85ffcc8c180908f9a6dd7fd7c::ownership {
    struct PredictProfileConfig has key {
        id: 0x2::object::UID,
        coordination_public_key: vector<u8>,
        profile_digest: vector<u8>,
        environment_id: vector<u8>,
    }

    struct ChainIdentityKey has copy, drop, store {
        dummy_field: bool,
    }

    struct PredictProfileConfigCreated has copy, drop {
        config_id: 0x2::object::ID,
        profile_digest: vector<u8>,
        environment_id: vector<u8>,
    }

    struct ExecutionOwnershipKey has copy, drop, store {
        execution_id: vector<u8>,
    }

    struct LlmTerminalOwnershipKey has copy, drop, store {
        execution_id: vector<u8>,
    }

    struct WalletOwnershipKey has copy, drop, store {
        holder: address,
    }

    struct OwnershipFenceV1 has store {
        profile_digest: vector<u8>,
        admission_digest: vector<u8>,
        epoch: u64,
        fresh_public_key: vector<u8>,
    }

    struct PredictOwnershipGrantV1 has copy, drop {
        version: u16,
        profile_digest: vector<u8>,
        scope_kind: u8,
        scope_id: vector<u8>,
        admission_digest: vector<u8>,
        expected_chain_epoch: u64,
        new_ownership_epoch: u64,
        fresh_runtime_public_key: vector<u8>,
    }

    struct PredictBindingV1 has copy, drop {
        version: u16,
        chain_id: vector<u8>,
        environment_id: vector<u8>,
        package_id: vector<u8>,
        execution_id: vector<u8>,
        market_object_id: vector<u8>,
        market_local_id: u64,
        reserve_id: vector<u8>,
        window_id: u64,
        contract_kind: u8,
        policy_digest: vector<u8>,
        selection_revision: u64,
        predecessor_commitment: vector<u8>,
    }

    struct ScopeFenced has copy, drop {
        scope_kind: u8,
        scope_id: vector<u8>,
        epoch: u64,
        fresh_public_key: vector<u8>,
    }

    fun apply_fence<T0: copy + drop + store>(arg0: &mut 0x2::object::UID, arg1: T0, arg2: &PredictOwnershipGrantV1) {
        if (0x2::dynamic_field::exists_with_type<T0, OwnershipFenceV1>(arg0, arg1)) {
            let v0 = 0x2::dynamic_field::borrow<T0, OwnershipFenceV1>(arg0, arg1);
            if (v0.epoch == arg2.new_ownership_epoch && v0.fresh_public_key == arg2.fresh_runtime_public_key) {
                return
            };
            if (v0.epoch == arg2.new_ownership_epoch) {
                abort 13906836450678210594
            };
            assert!(arg2.expected_chain_epoch == v0.epoch, 13906836459268276260);
            assert!(arg2.new_ownership_epoch > v0.epoch, 13906836463563112482);
            let v1 = 0x2::dynamic_field::borrow_mut<T0, OwnershipFenceV1>(arg0, arg1);
            v1.profile_digest = arg2.profile_digest;
            v1.admission_digest = arg2.admission_digest;
            v1.epoch = arg2.new_ownership_epoch;
            v1.fresh_public_key = arg2.fresh_runtime_public_key;
        } else {
            assert!(arg2.expected_chain_epoch == 0, 13906836493628014628);
            let v2 = OwnershipFenceV1{
                profile_digest   : arg2.profile_digest,
                admission_digest : arg2.admission_digest,
                epoch            : arg2.new_ownership_epoch,
                fresh_public_key : arg2.fresh_runtime_public_key,
            };
            0x2::dynamic_field::add<T0, OwnershipFenceV1>(arg0, arg1, v2);
        };
        let v3 = ScopeFenced{
            scope_kind       : arg2.scope_kind,
            scope_id         : arg2.scope_id,
            epoch            : arg2.new_ownership_epoch,
            fresh_public_key : arg2.fresh_runtime_public_key,
        };
        0x2::event::emit<ScopeFenced>(v3);
    }

    fun apply_wallet_fence(arg0: &mut 0xf24dc4d62420cba81959a77fd4f11482a728a0e85ffcc8c180908f9a6dd7fd7c::play_coin::PlayCoinLedger, arg1: &mut 0xf24dc4d62420cba81959a77fd4f11482a728a0e85ffcc8c180908f9a6dd7fd7c::frontier_commitment::FrontierCommitmentStore, arg2: &PredictProfileConfig, arg3: &PredictOwnershipGrantV1, arg4: &0x2::clock::Clock) {
        install_config_identity(arg1, arg2);
        let v0 = id32_to_address(arg3.scope_id);
        let v1 = 0xf24dc4d62420cba81959a77fd4f11482a728a0e85ffcc8c180908f9a6dd7fd7c::play_coin::uid_mut(arg0);
        let v2 = WalletOwnershipKey{holder: v0};
        apply_fence<WalletOwnershipKey>(v1, v2, arg3);
        if (0xf24dc4d62420cba81959a77fd4f11482a728a0e85ffcc8c180908f9a6dd7fd7c::play_coin::is_enrolled(arg0, v0)) {
            0xf24dc4d62420cba81959a77fd4f11482a728a0e85ffcc8c180908f9a6dd7fd7c::play_coin::set_domain_epoch_and_key(arg0, v0, arg3.new_ownership_epoch, arg3.fresh_runtime_public_key);
        };
    }

    public(friend) fun assert_consumed(arg0: 0x2::bcs::BCS) {
        let v0 = 0x2::bcs::into_remainder_bytes(arg0);
        assert!(0x1::vector::is_empty<u8>(&v0), 13906838155778785292);
    }

    public(friend) fun assert_deployment_chain_id(arg0: &0xf24dc4d62420cba81959a77fd4f11482a728a0e85ffcc8c180908f9a6dd7fd7c::frontier_commitment::FrontierCommitmentStore, arg1: vector<u8>) {
        let v0 = 0xf24dc4d62420cba81959a77fd4f11482a728a0e85ffcc8c180908f9a6dd7fd7c::frontier_commitment::deployment_identity(arg0);
        assert!(arg1 == 0xf24dc4d62420cba81959a77fd4f11482a728a0e85ffcc8c180908f9a6dd7fd7c::frontier_commitment::identity_chain_id(&v0), 13906838495083757619);
    }

    public(friend) fun assert_deployment_identity(arg0: &0xf24dc4d62420cba81959a77fd4f11482a728a0e85ffcc8c180908f9a6dd7fd7c::frontier_commitment::FrontierCommitmentStore, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>) {
        let v0 = 0xf24dc4d62420cba81959a77fd4f11482a728a0e85ffcc8c180908f9a6dd7fd7c::frontier_commitment::deployment_identity(arg0);
        assert!(arg1 == 0xf24dc4d62420cba81959a77fd4f11482a728a0e85ffcc8c180908f9a6dd7fd7c::frontier_commitment::identity_chain_id(&v0), 13906838568098201651);
        assert!(arg2 == 0xf24dc4d62420cba81959a77fd4f11482a728a0e85ffcc8c180908f9a6dd7fd7c::frontier_commitment::identity_environment_id(&v0), 13906838580983103539);
        assert!(arg3 == 0xf24dc4d62420cba81959a77fd4f11482a728a0e85ffcc8c180908f9a6dd7fd7c::frontier_commitment::identity_package_id(&v0), 13906838589573038131);
    }

    public(friend) fun binding_chain_id(arg0: &PredictBindingV1) : vector<u8> {
        arg0.chain_id
    }

    public(friend) fun binding_contract_kind(arg0: &PredictBindingV1) : u8 {
        arg0.contract_kind
    }

    public(friend) fun binding_digest(arg0: vector<u8>) : vector<u8> {
        record_digest(b"predict_attested_execution_v1", arg0)
    }

    public(friend) fun binding_environment_id(arg0: &PredictBindingV1) : vector<u8> {
        arg0.environment_id
    }

    public(friend) fun binding_execution_id(arg0: &PredictBindingV1) : vector<u8> {
        arg0.execution_id
    }

    public(friend) fun binding_market_local_id(arg0: &PredictBindingV1) : u64 {
        arg0.market_local_id
    }

    public(friend) fun binding_market_object_id(arg0: &PredictBindingV1) : vector<u8> {
        arg0.market_object_id
    }

    public(friend) fun binding_package_id(arg0: &PredictBindingV1) : vector<u8> {
        arg0.package_id
    }

    public(friend) fun binding_reserve_id(arg0: &PredictBindingV1) : vector<u8> {
        arg0.reserve_id
    }

    public(friend) fun binding_selection_revision(arg0: &PredictBindingV1) : u64 {
        arg0.selection_revision
    }

    public(friend) fun binding_window_id(arg0: &PredictBindingV1) : u64 {
        arg0.window_id
    }

    fun borrow_execution_fence(arg0: &0xf24dc4d62420cba81959a77fd4f11482a728a0e85ffcc8c180908f9a6dd7fd7c::frontier_commitment::FrontierCommitmentStore, arg1: vector<u8>) : &OwnershipFenceV1 {
        let v0 = ExecutionOwnershipKey{execution_id: arg1};
        assert!(0x2::dynamic_field::exists_with_type<ExecutionOwnershipKey, OwnershipFenceV1>(0xf24dc4d62420cba81959a77fd4f11482a728a0e85ffcc8c180908f9a6dd7fd7c::frontier_commitment::uid(arg0), v0), 13906836957484613670);
        0x2::dynamic_field::borrow<ExecutionOwnershipKey, OwnershipFenceV1>(0xf24dc4d62420cba81959a77fd4f11482a728a0e85ffcc8c180908f9a6dd7fd7c::frontier_commitment::uid(arg0), v0)
    }

    fun borrow_llm_fence(arg0: &0xf24dc4d62420cba81959a77fd4f11482a728a0e85ffcc8c180908f9a6dd7fd7c::frontier_commitment::FrontierCommitmentStore, arg1: vector<u8>) : &OwnershipFenceV1 {
        let v0 = LlmTerminalOwnershipKey{execution_id: arg1};
        assert!(0x2::dynamic_field::exists_with_type<LlmTerminalOwnershipKey, OwnershipFenceV1>(0xf24dc4d62420cba81959a77fd4f11482a728a0e85ffcc8c180908f9a6dd7fd7c::frontier_commitment::uid(arg0), v0), 13906837021909123110);
        0x2::dynamic_field::borrow<LlmTerminalOwnershipKey, OwnershipFenceV1>(0xf24dc4d62420cba81959a77fd4f11482a728a0e85ffcc8c180908f9a6dd7fd7c::frontier_commitment::uid(arg0), v0)
    }

    fun borrow_wallet_fence(arg0: &0xf24dc4d62420cba81959a77fd4f11482a728a0e85ffcc8c180908f9a6dd7fd7c::play_coin::PlayCoinLedger, arg1: address) : &OwnershipFenceV1 {
        let v0 = WalletOwnershipKey{holder: arg1};
        assert!(0x2::dynamic_field::exists_with_type<WalletOwnershipKey, OwnershipFenceV1>(0xf24dc4d62420cba81959a77fd4f11482a728a0e85ffcc8c180908f9a6dd7fd7c::play_coin::uid(arg0), v0), 13906837073448730662);
        0x2::dynamic_field::borrow<WalletOwnershipKey, OwnershipFenceV1>(0xf24dc4d62420cba81959a77fd4f11482a728a0e85ffcc8c180908f9a6dd7fd7c::play_coin::uid(arg0), v0)
    }

    public(friend) fun config_chain_id(arg0: &PredictProfileConfig) : vector<u8> {
        let v0 = ChainIdentityKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists_with_type<ChainIdentityKey, vector<u8>>(&arg0.id, v0), 13906838615342972981);
        let v1 = ChainIdentityKey{dummy_field: false};
        *0x2::dynamic_field::borrow<ChainIdentityKey, vector<u8>>(&arg0.id, v1)
    }

    public(friend) fun config_environment_id(arg0: &PredictProfileConfig) : vector<u8> {
        arg0.environment_id
    }

    public(friend) fun config_profile_digest(arg0: &PredictProfileConfig) : vector<u8> {
        arg0.profile_digest
    }

    fun decode_and_verify_grant(arg0: &PredictProfileConfig, arg1: &0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::AttestationRegistry<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::NitroEvidence>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: u8, arg9: vector<u8>) : PredictOwnershipGrantV1 {
        let v0 = decode_ownership_grant(arg2);
        assert!(v0.scope_kind == arg8, 13906836171504418836);
        assert!(v0.profile_digest == arg0.profile_digest, 13906836175799517206);
        let v1 = record_digest(b"dopa_predict::ownership_grant_v2", arg2);
        assert!(0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::signature::verify(0, &arg0.coordination_public_key, &v1, &arg3), 13906836214454485018);
        assert!(0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::is_current_nitro_registration(arg1, &arg4, &arg9, 0x2::clock::timestamp_ms(arg7)), 13906836248814616608);
        assert!(0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::signature::verify(0, &arg4, &v1, &arg5), 13906836261699256348);
        assert!(0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::signature::verify(0, &v0.fresh_runtime_public_key, &v1, &arg6), 13906836300354093086);
        v0
    }

    public(friend) fun decode_binding(arg0: vector<u8>) : PredictBindingV1 {
        let v0 = 0x2::bcs::new(arg0);
        let v1 = &mut v0;
        assert_consumed(v0);
        peel_binding(v1)
    }

    public(friend) fun decode_ownership_grant(arg0: vector<u8>) : PredictOwnershipGrantV1 {
        let v0 = 0x2::bcs::new(arg0);
        let v1 = &mut v0;
        assert_consumed(v0);
        peel_ownership_grant(v1)
    }

    public(friend) fun embedded_binding_bytes(arg0: &vector<u8>) : vector<u8> {
        assert!(0x1::vector::length<u8>(arg0) >= 2 + 283, 13906837893786042384);
        let v0 = b"";
        let v1 = 2;
        while (v1 < 2 + 283) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, v1));
            v1 = v1 + 1;
        };
        v0
    }

    public(friend) fun execution_fence_epoch(arg0: &0xf24dc4d62420cba81959a77fd4f11482a728a0e85ffcc8c180908f9a6dd7fd7c::frontier_commitment::FrontierCommitmentStore, arg1: vector<u8>) : u64 {
        borrow_execution_fence(arg0, arg1).epoch
    }

    public(friend) fun execution_fresh_key(arg0: &0xf24dc4d62420cba81959a77fd4f11482a728a0e85ffcc8c180908f9a6dd7fd7c::frontier_commitment::FrontierCommitmentStore, arg1: vector<u8>) : vector<u8> {
        borrow_execution_fence(arg0, arg1).fresh_public_key
    }

    public fun fence_execution(arg0: &mut 0xf24dc4d62420cba81959a77fd4f11482a728a0e85ffcc8c180908f9a6dd7fd7c::frontier_commitment::FrontierCommitmentStore, arg1: &PredictProfileConfig, arg2: &0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::AttestationRegistry<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::NitroEvidence>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: &0x2::clock::Clock) {
        let v0 = decode_and_verify_grant(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, 0, b"dopan180/predict-runtime-v1");
        install_config_identity(arg0, arg1);
        let v1 = 0xf24dc4d62420cba81959a77fd4f11482a728a0e85ffcc8c180908f9a6dd7fd7c::frontier_commitment::uid_mut(arg0);
        let v2 = ExecutionOwnershipKey{execution_id: v0.scope_id};
        apply_fence<ExecutionOwnershipKey>(v1, v2, &v0);
    }

    public fun fence_llm_terminal(arg0: &mut 0xf24dc4d62420cba81959a77fd4f11482a728a0e85ffcc8c180908f9a6dd7fd7c::frontier_commitment::FrontierCommitmentStore, arg1: &PredictProfileConfig, arg2: &0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::AttestationRegistry<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::NitroEvidence>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: &0x2::clock::Clock) {
        let v0 = decode_and_verify_grant(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, 2, b"dopan180/predict-llm-terminal-v1");
        install_config_identity(arg0, arg1);
        let v1 = 0xf24dc4d62420cba81959a77fd4f11482a728a0e85ffcc8c180908f9a6dd7fd7c::frontier_commitment::uid_mut(arg0);
        let v2 = LlmTerminalOwnershipKey{execution_id: v0.scope_id};
        apply_fence<LlmTerminalOwnershipKey>(v1, v2, &v0);
    }

    public fun fence_wallet_domain(arg0: &mut 0xf24dc4d62420cba81959a77fd4f11482a728a0e85ffcc8c180908f9a6dd7fd7c::play_coin::PlayCoinLedger, arg1: &mut 0xf24dc4d62420cba81959a77fd4f11482a728a0e85ffcc8c180908f9a6dd7fd7c::frontier_commitment::FrontierCommitmentStore, arg2: &PredictProfileConfig, arg3: &0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::AttestationRegistry<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::NitroEvidence>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: &0x2::clock::Clock) {
        let v0 = decode_and_verify_grant(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, 1, b"dopan180/predict-runtime-v1");
        apply_wallet_fence(arg0, arg1, arg2, &v0, arg9);
    }

    public(friend) fun grant_admission_digest(arg0: &PredictOwnershipGrantV1) : vector<u8> {
        arg0.admission_digest
    }

    public(friend) fun grant_expected_chain_epoch(arg0: &PredictOwnershipGrantV1) : u64 {
        arg0.expected_chain_epoch
    }

    public(friend) fun grant_fresh_runtime_public_key(arg0: &PredictOwnershipGrantV1) : vector<u8> {
        arg0.fresh_runtime_public_key
    }

    public(friend) fun grant_new_ownership_epoch(arg0: &PredictOwnershipGrantV1) : u64 {
        arg0.new_ownership_epoch
    }

    public(friend) fun grant_profile_digest(arg0: &PredictOwnershipGrantV1) : vector<u8> {
        arg0.profile_digest
    }

    public(friend) fun grant_scope_id(arg0: &PredictOwnershipGrantV1) : vector<u8> {
        arg0.scope_id
    }

    public(friend) fun grant_scope_kind(arg0: &PredictOwnershipGrantV1) : u8 {
        arg0.scope_kind
    }

    public(friend) fun grant_version(arg0: &PredictOwnershipGrantV1) : u16 {
        arg0.version
    }

    public(friend) fun has_execution_fence(arg0: &0xf24dc4d62420cba81959a77fd4f11482a728a0e85ffcc8c180908f9a6dd7fd7c::frontier_commitment::FrontierCommitmentStore, arg1: vector<u8>) : bool {
        let v0 = ExecutionOwnershipKey{execution_id: arg1};
        0x2::dynamic_field::exists_with_type<ExecutionOwnershipKey, OwnershipFenceV1>(0xf24dc4d62420cba81959a77fd4f11482a728a0e85ffcc8c180908f9a6dd7fd7c::frontier_commitment::uid(arg0), v0)
    }

    public(friend) fun has_llm_fence(arg0: &0xf24dc4d62420cba81959a77fd4f11482a728a0e85ffcc8c180908f9a6dd7fd7c::frontier_commitment::FrontierCommitmentStore, arg1: vector<u8>) : bool {
        let v0 = LlmTerminalOwnershipKey{execution_id: arg1};
        0x2::dynamic_field::exists_with_type<LlmTerminalOwnershipKey, OwnershipFenceV1>(0xf24dc4d62420cba81959a77fd4f11482a728a0e85ffcc8c180908f9a6dd7fd7c::frontier_commitment::uid(arg0), v0)
    }

    public(friend) fun has_wallet_fence(arg0: &0xf24dc4d62420cba81959a77fd4f11482a728a0e85ffcc8c180908f9a6dd7fd7c::play_coin::PlayCoinLedger, arg1: address) : bool {
        let v0 = WalletOwnershipKey{holder: arg1};
        0x2::dynamic_field::exists_with_type<WalletOwnershipKey, OwnershipFenceV1>(0xf24dc4d62420cba81959a77fd4f11482a728a0e85ffcc8c180908f9a6dd7fd7c::play_coin::uid(arg0), v0)
    }

    public(friend) fun id32_to_address(arg0: vector<u8>) : address {
        assert!(0x1::vector::length<u8>(&arg0) == 32, 13906838211613622288);
        let v0 = 0x2::bcs::new(arg0);
        0x2::bcs::peel_address(&mut v0)
    }

    fun install_config_identity(arg0: &mut 0xf24dc4d62420cba81959a77fd4f11482a728a0e85ffcc8c180908f9a6dd7fd7c::frontier_commitment::FrontierCommitmentStore, arg1: &PredictProfileConfig) {
        0xf24dc4d62420cba81959a77fd4f11482a728a0e85ffcc8c180908f9a6dd7fd7c::frontier_commitment::install_deployment_identity(arg0, config_chain_id(arg1), config_environment_id(arg1), 0xf24dc4d62420cba81959a77fd4f11482a728a0e85ffcc8c180908f9a6dd7fd7c::frontier_commitment::lineage_package_id());
    }

    public(friend) fun llm_fence_epoch(arg0: &0xf24dc4d62420cba81959a77fd4f11482a728a0e85ffcc8c180908f9a6dd7fd7c::frontier_commitment::FrontierCommitmentStore, arg1: vector<u8>) : u64 {
        borrow_llm_fence(arg0, arg1).epoch
    }

    public(friend) fun llm_fresh_key(arg0: &0xf24dc4d62420cba81959a77fd4f11482a728a0e85ffcc8c180908f9a6dd7fd7c::frontier_commitment::FrontierCommitmentStore, arg1: vector<u8>) : vector<u8> {
        borrow_llm_fence(arg0, arg1).fresh_public_key
    }

    public(friend) fun peel_binding(arg0: &mut 0x2::bcs::BCS) : PredictBindingV1 {
        let v0 = 0x2::bcs::peel_u16(arg0);
        assert!(v0 == 1, 13906837945325518862);
        let v1 = peel_id32(arg0);
        let v2 = peel_id32(arg0);
        let v3 = peel_id32(arg0);
        let v4 = peel_id32(arg0);
        let v5 = peel_id32(arg0);
        let v6 = 0x2::bcs::peel_u64(arg0);
        let v7 = peel_id32(arg0);
        let v8 = 0x2::bcs::peel_u64(arg0);
        let v9 = 0x2::bcs::peel_u8(arg0);
        assert!(v9 <= 2, 13906837988275453970);
        let v10 = peel_id32(arg0);
        let v11 = 0x2::bcs::peel_u64(arg0);
        PredictBindingV1{
            version                : v0,
            chain_id               : v1,
            environment_id         : v2,
            package_id             : v3,
            execution_id           : v4,
            market_object_id       : v5,
            market_local_id        : v6,
            reserve_id             : v7,
            window_id              : v8,
            contract_kind          : v9,
            policy_digest          : v10,
            selection_revision     : v11,
            predecessor_commitment : peel_id32(arg0),
        }
    }

    public(friend) fun peel_id32(arg0: &mut 0x2::bcs::BCS) : vector<u8> {
        let v0 = b"";
        let v1 = 0;
        while (v1 < 32) {
            0x1::vector::push_back<u8>(&mut v0, 0x2::bcs::peel_u8(arg0));
            v1 = v1 + 1;
        };
        v0
    }

    public(friend) fun peel_option_id32(arg0: &mut 0x2::bcs::BCS) : 0x1::option::Option<vector<u8>> {
        let v0 = 0x2::bcs::peel_u8(arg0);
        if (v0 == 0) {
            0x1::option::none<vector<u8>>()
        } else {
            assert!(v0 == 1, 13906838130008981516);
            0x1::option::some<vector<u8>>(peel_id32(arg0))
        }
    }

    public(friend) fun peel_ownership_grant(arg0: &mut 0x2::bcs::BCS) : PredictOwnershipGrantV1 {
        let v0 = 0x2::bcs::peel_u16(arg0);
        assert!(v0 == 1, 13906837704807350286);
        let v1 = peel_id32(arg0);
        let v2 = 0x2::bcs::peel_u8(arg0);
        let v3 = if (v2 == 0) {
            true
        } else if (v2 == 1) {
            true
        } else {
            v2 == 2
        };
        assert!(v3, 13906837726282448914);
        let v4 = peel_id32(arg0);
        let v5 = peel_id32(arg0);
        let v6 = 0x2::bcs::peel_u64(arg0);
        let v7 = 0x2::bcs::peel_u64(arg0);
        PredictOwnershipGrantV1{
            version                  : v0,
            profile_digest           : v1,
            scope_kind               : v2,
            scope_id                 : v4,
            admission_digest         : v5,
            expected_chain_epoch     : v6,
            new_ownership_epoch      : v7,
            fresh_runtime_public_key : peel_id32(arg0),
        }
    }

    public(friend) fun peel_signature_envelope(arg0: &mut 0x2::bcs::BCS) : (vector<u8>, u8, vector<u8>, u64, u64, vector<u8>) {
        assert!(0x2::bcs::peel_u16(arg0) == 1, 13906837167936438286);
        let v0 = peel_id32(arg0);
        let v1 = 0x2::bcs::peel_u8(arg0);
        let v2 = peel_id32(arg0);
        let v3 = 0x2::bcs::peel_u64(arg0);
        let v4 = 0x2::bcs::peel_u64(arg0);
        (v0, v1, v2, v3, v4, peel_id32(arg0))
    }

    public(friend) fun predict_llm_terminal_role_tag() : vector<u8> {
        b"dopan180/predict-llm-terminal-v1"
    }

    public(friend) fun record_digest(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
        let v0 = b"";
        0x1::vector::push_back<u8>(&mut v0, (0x1::vector::length<u8>(&arg0) as u8));
        0x1::vector::append<u8>(&mut v0, arg0);
        0x1::vector::append<u8>(&mut v0, arg1);
        0x2::hash::blake2b256(&v0)
    }

    public fun refresh_execution(arg0: &mut 0xf24dc4d62420cba81959a77fd4f11482a728a0e85ffcc8c180908f9a6dd7fd7c::frontier_commitment::FrontierCommitmentStore, arg1: &PredictProfileConfig, arg2: &0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::AttestationRegistry<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::NitroEvidence>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: &0x2::clock::Clock) {
        let v0 = decode_and_verify_grant(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, 0, b"dopan180/predict-runtime-v1");
        install_config_identity(arg0, arg1);
        let v1 = 0xf24dc4d62420cba81959a77fd4f11482a728a0e85ffcc8c180908f9a6dd7fd7c::frontier_commitment::uid_mut(arg0);
        let v2 = ExecutionOwnershipKey{execution_id: v0.scope_id};
        refresh_fence<ExecutionOwnershipKey>(v1, v2, &v0);
    }

    fun refresh_fence<T0: copy + drop + store>(arg0: &mut 0x2::object::UID, arg1: T0, arg2: &PredictOwnershipGrantV1) {
        assert!(0x2::dynamic_field::exists_with_type<T0, OwnershipFenceV1>(arg0, arg1), 13906836613887229990);
        let v0 = 0x2::dynamic_field::borrow<T0, OwnershipFenceV1>(arg0, arg1);
        assert!(arg2.expected_chain_epoch == v0.epoch, 13906836622477033508);
        assert!(arg2.new_ownership_epoch == v0.epoch, 13906836626772262952);
        assert!(arg2.fresh_runtime_public_key == v0.fresh_public_key, 13906836631067230248);
    }

    public fun refresh_llm_terminal(arg0: &mut 0xf24dc4d62420cba81959a77fd4f11482a728a0e85ffcc8c180908f9a6dd7fd7c::frontier_commitment::FrontierCommitmentStore, arg1: &PredictProfileConfig, arg2: &0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::AttestationRegistry<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::NitroEvidence>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: &0x2::clock::Clock) {
        let v0 = decode_and_verify_grant(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, 2, b"dopan180/predict-llm-terminal-v1");
        install_config_identity(arg0, arg1);
        let v1 = 0xf24dc4d62420cba81959a77fd4f11482a728a0e85ffcc8c180908f9a6dd7fd7c::frontier_commitment::uid_mut(arg0);
        let v2 = LlmTerminalOwnershipKey{execution_id: v0.scope_id};
        refresh_fence<LlmTerminalOwnershipKey>(v1, v2, &v0);
    }

    public fun refresh_wallet_domain(arg0: &mut 0xf24dc4d62420cba81959a77fd4f11482a728a0e85ffcc8c180908f9a6dd7fd7c::play_coin::PlayCoinLedger, arg1: &mut 0xf24dc4d62420cba81959a77fd4f11482a728a0e85ffcc8c180908f9a6dd7fd7c::frontier_commitment::FrontierCommitmentStore, arg2: &PredictProfileConfig, arg3: &0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::AttestationRegistry<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::NitroEvidence>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: &0x2::clock::Clock) {
        let v0 = decode_and_verify_grant(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, 1, b"dopan180/predict-runtime-v1");
        install_config_identity(arg1, arg2);
        let v1 = 0xf24dc4d62420cba81959a77fd4f11482a728a0e85ffcc8c180908f9a6dd7fd7c::play_coin::uid_mut(arg0);
        let v2 = WalletOwnershipKey{holder: id32_to_address(v0.scope_id)};
        refresh_fence<WalletOwnershipKey>(v1, v2, &v0);
    }

    public(friend) fun scope_execution() : u8 {
        0
    }

    public(friend) fun scope_llm() : u8 {
        2
    }

    public(friend) fun scope_wallet() : u8 {
        1
    }

    public(friend) fun set_chain_identity(arg0: &mut PredictProfileConfig, arg1: vector<u8>) {
        assert!(0x1::vector::length<u8>(&arg1) == 32, 13906838430656954384);
        let v0 = ChainIdentityKey{dummy_field: false};
        assert!(!0x2::dynamic_field::exists_with_type<ChainIdentityKey, vector<u8>>(&arg0.id, v0), 13906838443544412215);
        let v1 = ChainIdentityKey{dummy_field: false};
        0x2::dynamic_field::add<ChainIdentityKey, vector<u8>>(&mut arg0.id, v1, arg1);
    }

    public(friend) fun share_profile_config(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg0) == 32, 13906835106352791576);
        assert!(0x1::vector::length<u8>(&arg1) == 32, 13906835110647234576);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 13906835114942201872);
        assert!(0x1::vector::length<u8>(&arg3) == 32, 13906835119237169168);
        let v0 = PredictProfileConfig{
            id                      : 0x2::object::new(arg4),
            coordination_public_key : arg0,
            profile_digest          : arg1,
            environment_id          : arg2,
        };
        let v1 = PredictProfileConfigCreated{
            config_id      : 0x2::object::uid_to_inner(&v0.id),
            profile_digest : arg1,
            environment_id : arg2,
        };
        0x2::event::emit<PredictProfileConfigCreated>(v1);
        let v2 = &mut v0;
        set_chain_identity(v2, arg3);
        0x2::transfer::share_object<PredictProfileConfig>(v0);
    }

    public(friend) fun verify_execution_envelope(arg0: &0xf24dc4d62420cba81959a77fd4f11482a728a0e85ffcc8c180908f9a6dd7fd7c::frontier_commitment::FrontierCommitmentStore, arg1: &0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::AttestationRegistry<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::NitroEvidence>, arg2: &0x2::clock::Clock, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>) {
        assert!(has_execution_fence(arg0, arg3), 13906837292492062758);
        let v0 = execution_fresh_key(arg0, arg3);
        let v1 = 0x2::bcs::new(arg5);
        let v2 = &mut v1;
        let (v3, v4, v5, _, v7, v8) = peel_signature_envelope(v2);
        assert_consumed(v1);
        assert!(v3 == arg4, 13906837322557095978);
        assert!(v4 == 0, 13906837326852063274);
        assert!(v5 == arg3, 13906837331147030570);
        assert!(v7 == execution_fence_epoch(arg0, arg3), 13906837335442128940);
        assert!(v8 == v0, 13906837339736965162);
        let v9 = b"dopan180/predict-runtime-v1";
        assert!(0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::is_current_nitro_registration(arg1, &v0, &v9, 0x2::clock::timestamp_ms(arg2)), 13906837395571933232);
        let v10 = record_digest(b"dopa_predict::runtime_signature_v1", arg5);
        assert!(0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::signature::verify(0, &v0, &v10, &arg6), 13906837417046638638);
    }

    public(friend) fun verify_wallet_envelope(arg0: &0xf24dc4d62420cba81959a77fd4f11482a728a0e85ffcc8c180908f9a6dd7fd7c::play_coin::PlayCoinLedger, arg1: &0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::AttestationRegistry<0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::NitroEvidence>, arg2: &0x2::clock::Clock, arg3: address, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>) {
        assert!(has_wallet_fence(arg0, arg3), 13906837528715264038);
        let v0 = wallet_fresh_key(arg0, arg3);
        let v1 = 0x2::bcs::new(arg5);
        let v2 = &mut v1;
        let (v3, v4, v5, _, v7, v8) = peel_signature_envelope(v2);
        assert_consumed(v1);
        assert!(v3 == arg4, 13906837558781280313);
        assert!(v4 == 1, 13906837563076247609);
        assert!(v5 == 0x2::bcs::to_bytes<address>(&arg3), 13906837567371214905);
        assert!(v7 == wallet_fence_epoch(arg0, arg3), 13906837571666313275);
        assert!(v8 == v0, 13906837575961149497);
        let v9 = b"dopan180/predict-runtime-v1";
        assert!(0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::attestation_registry::is_current_nitro_registration(arg1, &v0, &v9, 0x2::clock::timestamp_ms(arg2)), 13906837627500167216);
        let v10 = record_digest(b"dopa_predict::runtime_signature_v1", arg5);
        assert!(0x71e598af84b93acfda780b1a772b1bfe61dadaba75ebcdd7833df3efa9391eee::signature::verify(0, &v0, &v10, &arg6), 13906837648975855677);
    }

    public(friend) fun wallet_fence_epoch(arg0: &0xf24dc4d62420cba81959a77fd4f11482a728a0e85ffcc8c180908f9a6dd7fd7c::play_coin::PlayCoinLedger, arg1: address) : u64 {
        borrow_wallet_fence(arg0, arg1).epoch
    }

    public(friend) fun wallet_fresh_key(arg0: &0xf24dc4d62420cba81959a77fd4f11482a728a0e85ffcc8c180908f9a6dd7fd7c::play_coin::PlayCoinLedger, arg1: address) : vector<u8> {
        borrow_wallet_fence(arg0, arg1).fresh_public_key
    }

    // decompiled from Move bytecode v7
}

