module 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::fifth_move {
    struct FifthMoveConfig has key {
        id: 0x2::object::UID,
        admin: address,
        enabled: bool,
        utility_coin: 0x1::type_name::TypeName,
        min_underlying_tree_raw: u64,
        signer_public_key: vector<u8>,
        config_version: u64,
        max_attestation_age_ms: u64,
    }

    struct FifthMoveAttestationPayload has copy, drop, store {
        version: u8,
        domain: vector<u8>,
        network: vector<u8>,
        fifth_move_config_id: address,
        wallet: address,
        qualified: bool,
        verified_underlying_tree_raw: u64,
        threshold_raw: u64,
        source_bitmap: u8,
        config_version: u64,
        issued_at_ms: u64,
        expires_at_ms: u64,
    }

    struct FifthMoveEligibility has copy, drop, store {
        entitled: bool,
        verified_underlying_tree_raw: u64,
        source_bitmap: u8,
        config_version: u64,
        attestation_digest: vector<u8>,
    }

    struct FifthMoveThresholdUpdated has copy, drop {
        threshold_raw: u64,
        config_version: u64,
    }

    struct FifthMoveEnabledUpdated has copy, drop {
        enabled: bool,
        config_version: u64,
    }

    struct FifthMoveSignerUpdated has copy, drop {
        config_version: u64,
    }

    struct FifthMoveAttestationAgeUpdated has copy, drop {
        max_attestation_age_ms: u64,
        config_version: u64,
    }

    struct FifthMoveAdminTransferred has copy, drop {
        old_admin: address,
        new_admin: address,
    }

    public fun admin(arg0: &FifthMoveConfig) : address {
        arg0.admin
    }

    fun assert_admin(arg0: &FifthMoveConfig, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_admin_only());
    }

    fun assert_valid_public_key(arg0: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) == 32, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_fifth_move_malformed_public_key());
    }

    public fun attestation_digest(arg0: &FifthMoveEligibility) : vector<u8> {
        utils_clone_vec_u8(&arg0.attestation_digest)
    }

    fun bump_version(arg0: &mut FifthMoveConfig) {
        assert!(arg0.config_version < 18446744073709551615, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_fifth_move_version_overflow());
        arg0.config_version = arg0.config_version + 1;
    }

    public fun config_id(arg0: &FifthMoveConfig) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    public fun config_version(arg0: &FifthMoveConfig) : u64 {
        arg0.config_version
    }

    public fun eligibility_config_version(arg0: &FifthMoveEligibility) : u64 {
        arg0.config_version
    }

    public fun enabled(arg0: &FifthMoveConfig) : bool {
        arg0.enabled
    }

    public fun entitled(arg0: &FifthMoveEligibility) : bool {
        arg0.entitled
    }

    public entry fun init_fifth_move_config<T0>(arg0: vector<u8>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert_valid_public_key(&arg0);
        assert!(arg1 > 0, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_fifth_move_invalid_timestamp_ordering());
        let v0 = FifthMoveConfig{
            id                      : 0x2::object::new(arg2),
            admin                   : 0x2::tx_context::sender(arg2),
            enabled                 : false,
            utility_coin            : 0x1::type_name::with_original_ids<T0>(),
            min_underlying_tree_raw : 1000000000000,
            signer_public_key       : arg0,
            config_version          : 1,
            max_attestation_age_ms  : arg1,
        };
        0x2::transfer::share_object<FifthMoveConfig>(v0);
    }

    public fun is_utility_coin<T0>(arg0: &FifthMoveConfig) : bool {
        0x1::type_name::with_original_ids<T0>() == arg0.utility_coin
    }

    public fun max_attestation_age_ms(arg0: &FifthMoveConfig) : u64 {
        arg0.max_attestation_age_ms
    }

    public fun min_underlying_tree_raw(arg0: &FifthMoveConfig) : u64 {
        arg0.min_underlying_tree_raw
    }

    public fun payload(arg0: address, arg1: address, arg2: bool, arg3: u64, arg4: u64, arg5: u8, arg6: u64, arg7: u64, arg8: u64) : FifthMoveAttestationPayload {
        FifthMoveAttestationPayload{
            version                      : 1,
            domain                       : b"GARDEN_BATTLES_FIFTH_MOVE_V1",
            network                      : b"sui:mainnet",
            fifth_move_config_id         : arg0,
            wallet                       : arg1,
            qualified                    : arg2,
            verified_underlying_tree_raw : arg3,
            threshold_raw                : arg4,
            source_bitmap                : arg5,
            config_version               : arg6,
            issued_at_ms                 : arg7,
            expires_at_ms                : arg8,
        }
    }

    public fun payload_to_bytes(arg0: &FifthMoveAttestationPayload) : vector<u8> {
        0x2::bcs::to_bytes<FifthMoveAttestationPayload>(arg0)
    }

    public fun rotate_signer(arg0: &mut FifthMoveConfig, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg2);
        assert_valid_public_key(&arg1);
        assert!(arg1 != arg0.signer_public_key, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_fifth_move_config_noop());
        arg0.signer_public_key = arg1;
        bump_version(arg0);
        let v0 = FifthMoveSignerUpdated{config_version: arg0.config_version};
        0x2::event::emit<FifthMoveSignerUpdated>(v0);
    }

    public fun set_enabled(arg0: &mut FifthMoveConfig, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg2);
        assert!(arg1 != arg0.enabled, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_fifth_move_config_noop());
        arg0.enabled = arg1;
        bump_version(arg0);
        let v0 = FifthMoveEnabledUpdated{
            enabled        : arg1,
            config_version : arg0.config_version,
        };
        0x2::event::emit<FifthMoveEnabledUpdated>(v0);
    }

    public fun set_max_attestation_age(arg0: &mut FifthMoveConfig, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg2);
        assert!(arg1 > 0, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_fifth_move_invalid_timestamp_ordering());
        assert!(arg1 != arg0.max_attestation_age_ms, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_fifth_move_config_noop());
        arg0.max_attestation_age_ms = arg1;
        bump_version(arg0);
        let v0 = FifthMoveAttestationAgeUpdated{
            max_attestation_age_ms : arg1,
            config_version         : arg0.config_version,
        };
        0x2::event::emit<FifthMoveAttestationAgeUpdated>(v0);
    }

    public fun set_threshold(arg0: &mut FifthMoveConfig, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg2);
        assert!(arg1 > 0, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_fifth_move_threshold_mismatch());
        assert!(arg1 != arg0.min_underlying_tree_raw, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_fifth_move_config_noop());
        arg0.min_underlying_tree_raw = arg1;
        bump_version(arg0);
        let v0 = FifthMoveThresholdUpdated{
            threshold_raw  : arg1,
            config_version : arg0.config_version,
        };
        0x2::event::emit<FifthMoveThresholdUpdated>(v0);
    }

    public fun signer_public_key(arg0: &FifthMoveConfig) : vector<u8> {
        utils_clone_vec_u8(&arg0.signer_public_key)
    }

    public fun snapshot_eligibility(arg0: bool, arg1: u64, arg2: u8, arg3: u64, arg4: vector<u8>) : FifthMoveEligibility {
        FifthMoveEligibility{
            entitled                     : arg0,
            verified_underlying_tree_raw : arg1,
            source_bitmap                : arg2,
            config_version               : arg3,
            attestation_digest           : arg4,
        }
    }

    public fun source_bitmap(arg0: &FifthMoveEligibility) : u8 {
        arg0.source_bitmap
    }

    public fun standard_eligibility() : FifthMoveEligibility {
        FifthMoveEligibility{
            entitled                     : false,
            verified_underlying_tree_raw : 0,
            source_bitmap                : 0,
            config_version               : 0,
            attestation_digest           : 0x1::vector::empty<u8>(),
        }
    }

    public fun transfer_admin(arg0: &mut FifthMoveConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg2);
        assert!(arg1 != @0x0, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_invalid_address());
        assert!(arg1 != arg0.admin, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_admin_transfer_noop());
        arg0.admin = arg1;
        let v0 = FifthMoveAdminTransferred{
            old_admin : arg0.admin,
            new_admin : arg1,
        };
        0x2::event::emit<FifthMoveAdminTransferred>(v0);
    }

    fun utils_clone_vec_u8(arg0: &vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(arg0)) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, v1));
            v1 = v1 + 1;
        };
        v0
    }

    public fun verified_underlying_tree_raw(arg0: &FifthMoveEligibility) : u64 {
        arg0.verified_underlying_tree_raw
    }

    public fun verify_attestation(arg0: &FifthMoveConfig, arg1: FifthMoveAttestationPayload, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : FifthMoveEligibility {
        assert!(arg0.enabled, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_fifth_move_disabled());
        assert_valid_public_key(&arg0.signer_public_key);
        assert!(0x1::vector::length<u8>(&arg2) == 64, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_fifth_move_malformed_signature());
        assert!(arg1.version == 1, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_fifth_move_invalid_version());
        assert!(arg1.domain == b"GARDEN_BATTLES_FIFTH_MOVE_V1", 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_fifth_move_domain_mismatch());
        assert!(arg1.network == b"sui:mainnet", 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_fifth_move_network_mismatch());
        assert!(arg1.fifth_move_config_id == 0x2::object::uid_to_address(&arg0.id), 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_fifth_move_wrong_config_object());
        assert!(arg1.wallet == 0x2::tx_context::sender(arg4), 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_fifth_move_wrong_wallet());
        assert!(arg1.qualified, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_fifth_move_not_qualified());
        assert!(arg1.source_bitmap > 0 && arg1.source_bitmap <= 15, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_fifth_move_invalid_source_bitmap());
        assert!(arg1.verified_underlying_tree_raw >= arg0.min_underlying_tree_raw, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_fifth_move_not_qualified());
        assert!(arg1.threshold_raw == arg0.min_underlying_tree_raw, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_fifth_move_threshold_mismatch());
        assert!(arg1.config_version == arg0.config_version, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_fifth_move_config_mismatch());
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(arg1.issued_at_ms <= arg1.expires_at_ms, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_fifth_move_invalid_timestamp_ordering());
        if (arg1.issued_at_ms > v0) {
            assert!(arg1.issued_at_ms - v0 <= 60000, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_fifth_move_future_issued());
        };
        assert!(v0 <= arg1.expires_at_ms, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_fifth_move_expired());
        assert!(arg1.expires_at_ms - arg1.issued_at_ms <= arg0.max_attestation_age_ms, 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_fifth_move_expired());
        let v1 = payload_to_bytes(&arg1);
        assert!(0x2::ed25519::ed25519_verify(&arg2, &arg0.signer_public_key, &v1), 0x656ac984c39b952b40ccaaad4c26a3e074c4c99f56e2bac0862b811557de448b::errors::e_fifth_move_bad_signature());
        FifthMoveEligibility{
            entitled                     : true,
            verified_underlying_tree_raw : arg1.verified_underlying_tree_raw,
            source_bitmap                : arg1.source_bitmap,
            config_version               : arg1.config_version,
            attestation_digest           : v1,
        }
    }

    // decompiled from Move bytecode v7
}

