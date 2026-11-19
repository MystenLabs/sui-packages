module 0x35cd5b4bd816efcb55a9705e6b28d15cf6d51e01267690dce7919fa18b726b4c::runtime_config {
    struct RuntimeConfig has key {
        id: 0x2::object::UID,
        creator_claim_signers: 0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::delayed_set::DelayedSet<ClaimSignerKey, vector<u8>>,
        protocol_fee_share_bps: 0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::delayed::Delayed<ProtocolFeeShareKey, 0x7ff2de5a2df7cc9c8b514dfbb25285b6cc72074d5e166186d8891860143c2f45::bps::Bps>,
    }

    struct ProtocolFeeShareKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ClaimSignerKey has copy, drop, store {
        dummy_field: bool,
    }

    fun new(arg0: &mut 0x2::tx_context::TxContext) : RuntimeConfig {
        let v0 = 0x2::object::new(arg0);
        let v1 = ClaimSignerKey{dummy_field: false};
        let v2 = ProtocolFeeShareKey{dummy_field: false};
        RuntimeConfig{
            id                     : v0,
            creator_claim_signers  : 0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::delayed_set::new<ClaimSignerKey, vector<u8>>(v1, &v0, 0),
            protocol_fee_share_bps : 0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::delayed::new<ProtocolFeeShareKey, 0x7ff2de5a2df7cc9c8b514dfbb25285b6cc72074d5e166186d8891860143c2f45::bps::Bps>(v2, &v0, checked_protocol_fee_share(0x7ff2de5a2df7cc9c8b514dfbb25285b6cc72074d5e166186d8891860143c2f45::bps::new(5000)), 0),
        }
    }

    public(friend) fun is_guarded(arg0: &RuntimeConfig) : bool {
        0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::delayed_set::is_guarded<ClaimSignerKey, vector<u8>>(&arg0.creator_claim_signers) && 0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::delayed::is_guarded<ProtocolFeeShareKey, 0x7ff2de5a2df7cc9c8b514dfbb25285b6cc72074d5e166186d8891860143c2f45::bps::Bps>(&arg0.protocol_fee_share_bps)
    }

    public fun apply_creator_claim_signer(arg0: &mut RuntimeConfig, arg1: &0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::package_version::PackageVersion<0x35cd5b4bd816efcb55a9705e6b28d15cf6d51e01267690dce7919fa18b726b4c::blast_fun::BLAST_FUN>, arg2: vector<u8>, arg3: &0x2::clock::Clock) {
        0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::package_version::assert_current<0x35cd5b4bd816efcb55a9705e6b28d15cf6d51e01267690dce7919fa18b726b4c::blast_fun::BLAST_FUN>(arg1, 1);
        0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::delayed_set::apply_add<ClaimSignerKey, vector<u8>>(&mut arg0.creator_claim_signers, arg2, arg3);
    }

    public fun apply_creator_claim_signer_delay(arg0: &mut RuntimeConfig, arg1: &0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::package_version::PackageVersion<0x35cd5b4bd816efcb55a9705e6b28d15cf6d51e01267690dce7919fa18b726b4c::blast_fun::BLAST_FUN>, arg2: &0x2::clock::Clock) {
        0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::package_version::assert_current<0x35cd5b4bd816efcb55a9705e6b28d15cf6d51e01267690dce7919fa18b726b4c::blast_fun::BLAST_FUN>(arg1, 1);
        0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::delayed_set::apply_delay<ClaimSignerKey, vector<u8>>(&mut arg0.creator_claim_signers, arg2);
    }

    public fun apply_protocol_fee_share(arg0: &mut RuntimeConfig, arg1: &0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::package_version::PackageVersion<0x35cd5b4bd816efcb55a9705e6b28d15cf6d51e01267690dce7919fa18b726b4c::blast_fun::BLAST_FUN>, arg2: &0x2::clock::Clock) {
        0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::package_version::assert_current<0x35cd5b4bd816efcb55a9705e6b28d15cf6d51e01267690dce7919fa18b726b4c::blast_fun::BLAST_FUN>(arg1, 1);
        0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::delayed::apply<ProtocolFeeShareKey, 0x7ff2de5a2df7cc9c8b514dfbb25285b6cc72074d5e166186d8891860143c2f45::bps::Bps>(&mut arg0.protocol_fee_share_bps, arg2);
    }

    public fun cancel_creator_claim_signer(arg0: &mut RuntimeConfig, arg1: &0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::package_version::PackageVersion<0x35cd5b4bd816efcb55a9705e6b28d15cf6d51e01267690dce7919fa18b726b4c::blast_fun::BLAST_FUN>, arg2: &0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::blast_acl::AdminWitness<0x7ff2de5a2df7cc9c8b514dfbb25285b6cc72074d5e166186d8891860143c2f45::blast_domain::CancelAdmin>, arg3: vector<u8>) {
        0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::package_version::assert_current<0x35cd5b4bd816efcb55a9705e6b28d15cf6d51e01267690dce7919fa18b726b4c::blast_fun::BLAST_FUN>(arg1, 1);
        0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::delayed_set::cancel_add<ClaimSignerKey, vector<u8>>(&mut arg0.creator_claim_signers, arg3);
    }

    public fun cancel_creator_claim_signer_delay(arg0: &mut RuntimeConfig, arg1: &0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::package_version::PackageVersion<0x35cd5b4bd816efcb55a9705e6b28d15cf6d51e01267690dce7919fa18b726b4c::blast_fun::BLAST_FUN>, arg2: &0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::blast_acl::AdminWitness<0x7ff2de5a2df7cc9c8b514dfbb25285b6cc72074d5e166186d8891860143c2f45::blast_domain::CancelAdmin>) {
        0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::package_version::assert_current<0x35cd5b4bd816efcb55a9705e6b28d15cf6d51e01267690dce7919fa18b726b4c::blast_fun::BLAST_FUN>(arg1, 1);
        0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::delayed_set::cancel_delay<ClaimSignerKey, vector<u8>>(&mut arg0.creator_claim_signers);
    }

    public fun cancel_protocol_fee_share(arg0: &mut RuntimeConfig, arg1: &0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::package_version::PackageVersion<0x35cd5b4bd816efcb55a9705e6b28d15cf6d51e01267690dce7919fa18b726b4c::blast_fun::BLAST_FUN>, arg2: &0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::blast_acl::AdminWitness<0x7ff2de5a2df7cc9c8b514dfbb25285b6cc72074d5e166186d8891860143c2f45::blast_domain::CancelAdmin>) {
        0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::package_version::assert_current<0x35cd5b4bd816efcb55a9705e6b28d15cf6d51e01267690dce7919fa18b726b4c::blast_fun::BLAST_FUN>(arg1, 1);
        0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::delayed::cancel<ProtocolFeeShareKey, 0x7ff2de5a2df7cc9c8b514dfbb25285b6cc72074d5e166186d8891860143c2f45::bps::Bps>(&mut arg0.protocol_fee_share_bps);
    }

    fun checked_protocol_fee_share(arg0: 0x7ff2de5a2df7cc9c8b514dfbb25285b6cc72074d5e166186d8891860143c2f45::bps::Bps) : 0x7ff2de5a2df7cc9c8b514dfbb25285b6cc72074d5e166186d8891860143c2f45::bps::Bps {
        assert!(0x7ff2de5a2df7cc9c8b514dfbb25285b6cc72074d5e166186d8891860143c2f45::bps::value(arg0) <= 7000, 33);
        arg0
    }

    public(friend) fun creator_claim_signers(arg0: &RuntimeConfig) : vector<vector<u8>> {
        0x2::vec_set::into_keys<vector<u8>>(0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::delayed_set::members<ClaimSignerKey, vector<u8>>(&arg0.creator_claim_signers))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<RuntimeConfig>(new(arg0));
    }

    public(friend) fun protocol_fee_share(arg0: &RuntimeConfig) : 0x7ff2de5a2df7cc9c8b514dfbb25285b6cc72074d5e166186d8891860143c2f45::bps::Bps {
        0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::delayed::value<ProtocolFeeShareKey, 0x7ff2de5a2df7cc9c8b514dfbb25285b6cc72074d5e166186d8891860143c2f45::bps::Bps>(&arg0.protocol_fee_share_bps)
    }

    public fun revoke_creator_claim_signer(arg0: &mut RuntimeConfig, arg1: &0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::package_version::PackageVersion<0x35cd5b4bd816efcb55a9705e6b28d15cf6d51e01267690dce7919fa18b726b4c::blast_fun::BLAST_FUN>, arg2: &0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::blast_acl::AdminWitness<0x7ff2de5a2df7cc9c8b514dfbb25285b6cc72074d5e166186d8891860143c2f45::blast_domain::ClaimSignerAdmin>, arg3: vector<u8>) {
        0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::package_version::assert_current<0x35cd5b4bd816efcb55a9705e6b28d15cf6d51e01267690dce7919fa18b726b4c::blast_fun::BLAST_FUN>(arg1, 1);
        0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::delayed_set::remove<ClaimSignerKey, vector<u8>>(&mut arg0.creator_claim_signers, arg3);
    }

    public fun schedule_creator_claim_signer(arg0: &mut RuntimeConfig, arg1: &0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::package_version::PackageVersion<0x35cd5b4bd816efcb55a9705e6b28d15cf6d51e01267690dce7919fa18b726b4c::blast_fun::BLAST_FUN>, arg2: &0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::blast_acl::AdminWitness<0x7ff2de5a2df7cc9c8b514dfbb25285b6cc72074d5e166186d8891860143c2f45::blast_domain::ClaimSignerAdmin>, arg3: vector<u8>, arg4: &0x2::clock::Clock) {
        0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::package_version::assert_current<0x35cd5b4bd816efcb55a9705e6b28d15cf6d51e01267690dce7919fa18b726b4c::blast_fun::BLAST_FUN>(arg1, 1);
        assert!(0x1::vector::length<u8>(&arg3) == 32, 22);
        let v0 = &arg0.creator_claim_signers;
        let v1 = 0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::delayed_set::admission_ready_at_ms<ClaimSignerKey, vector<u8>>(v0, &arg3);
        let v2 = if (0x1::option::is_some<u64>(&v1)) {
            1
        } else {
            0
        };
        let v3 = 0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::delayed_set::members<ClaimSignerKey, vector<u8>>(v0);
        assert!(0x2::vec_set::length<vector<u8>>(&v3) + 0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::delayed_set::pending_count<ClaimSignerKey, vector<u8>>(v0) - v2 < 4, 31);
        0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::delayed_set::schedule_add<ClaimSignerKey, vector<u8>>(&mut arg0.creator_claim_signers, arg3, arg4);
    }

    public fun schedule_creator_claim_signer_delay(arg0: &mut RuntimeConfig, arg1: &0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::package_version::PackageVersion<0x35cd5b4bd816efcb55a9705e6b28d15cf6d51e01267690dce7919fa18b726b4c::blast_fun::BLAST_FUN>, arg2: &0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::blast_acl::AdminWitness<0x7ff2de5a2df7cc9c8b514dfbb25285b6cc72074d5e166186d8891860143c2f45::blast_domain::ClaimSignerAdmin>, arg3: u64, arg4: &0x2::clock::Clock) {
        0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::package_version::assert_current<0x35cd5b4bd816efcb55a9705e6b28d15cf6d51e01267690dce7919fa18b726b4c::blast_fun::BLAST_FUN>(arg1, 1);
        0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::delayed_set::schedule_delay<ClaimSignerKey, vector<u8>>(&mut arg0.creator_claim_signers, arg3, arg4);
    }

    public fun schedule_protocol_fee_share(arg0: &mut RuntimeConfig, arg1: &0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::package_version::PackageVersion<0x35cd5b4bd816efcb55a9705e6b28d15cf6d51e01267690dce7919fa18b726b4c::blast_fun::BLAST_FUN>, arg2: &0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::blast_acl::AdminWitness<0x7ff2de5a2df7cc9c8b514dfbb25285b6cc72074d5e166186d8891860143c2f45::blast_domain::FeeAdmin>, arg3: 0x7ff2de5a2df7cc9c8b514dfbb25285b6cc72074d5e166186d8891860143c2f45::bps::Bps, arg4: u64, arg5: &0x2::clock::Clock) {
        0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::package_version::assert_current<0x35cd5b4bd816efcb55a9705e6b28d15cf6d51e01267690dce7919fa18b726b4c::blast_fun::BLAST_FUN>(arg1, 1);
        0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::delayed::schedule<ProtocolFeeShareKey, 0x7ff2de5a2df7cc9c8b514dfbb25285b6cc72074d5e166186d8891860143c2f45::bps::Bps>(&mut arg0.protocol_fee_share_bps, checked_protocol_fee_share(arg3), arg4, arg5);
    }

    // decompiled from Move bytecode v7
}

