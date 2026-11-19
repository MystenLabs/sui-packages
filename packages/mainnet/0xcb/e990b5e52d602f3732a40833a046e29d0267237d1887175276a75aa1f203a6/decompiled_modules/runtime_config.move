module 0xcbe990b5e52d602f3732a40833a046e29d0267237d1887175276a75aa1f203a6::runtime_config {
    struct RuntimeConfig has key {
        id: 0x2::object::UID,
        creator_claim_signers: 0x39d26c7fbd757342149e0d69ffa873e748b177b2034f49b36d9e21b4bc8168dc::delayed_set::DelayedSet<ClaimSignerKey, vector<u8>>,
        protocol_fee_share_bps: 0x39d26c7fbd757342149e0d69ffa873e748b177b2034f49b36d9e21b4bc8168dc::delayed::Delayed<ProtocolFeeShareKey, 0xeba5715e19b20c4d6599cc579bd080e5775d1aaa484e3802ec9d29974f61f5f5::bps::Bps>,
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
            creator_claim_signers  : 0x39d26c7fbd757342149e0d69ffa873e748b177b2034f49b36d9e21b4bc8168dc::delayed_set::new<ClaimSignerKey, vector<u8>>(v1, &v0, 0),
            protocol_fee_share_bps : 0x39d26c7fbd757342149e0d69ffa873e748b177b2034f49b36d9e21b4bc8168dc::delayed::new<ProtocolFeeShareKey, 0xeba5715e19b20c4d6599cc579bd080e5775d1aaa484e3802ec9d29974f61f5f5::bps::Bps>(v2, &v0, checked_protocol_fee_share(0xeba5715e19b20c4d6599cc579bd080e5775d1aaa484e3802ec9d29974f61f5f5::bps::new(5000)), 0),
        }
    }

    public(friend) fun is_guarded(arg0: &RuntimeConfig) : bool {
        0x39d26c7fbd757342149e0d69ffa873e748b177b2034f49b36d9e21b4bc8168dc::delayed_set::is_guarded<ClaimSignerKey, vector<u8>>(&arg0.creator_claim_signers) && 0x39d26c7fbd757342149e0d69ffa873e748b177b2034f49b36d9e21b4bc8168dc::delayed::is_guarded<ProtocolFeeShareKey, 0xeba5715e19b20c4d6599cc579bd080e5775d1aaa484e3802ec9d29974f61f5f5::bps::Bps>(&arg0.protocol_fee_share_bps)
    }

    public fun apply_creator_claim_signer(arg0: &mut RuntimeConfig, arg1: &0x39d26c7fbd757342149e0d69ffa873e748b177b2034f49b36d9e21b4bc8168dc::package_version::PackageVersion<0xcbe990b5e52d602f3732a40833a046e29d0267237d1887175276a75aa1f203a6::blast_fun::BLAST_FUN>, arg2: vector<u8>, arg3: &0x2::clock::Clock) {
        0x39d26c7fbd757342149e0d69ffa873e748b177b2034f49b36d9e21b4bc8168dc::package_version::assert_current<0xcbe990b5e52d602f3732a40833a046e29d0267237d1887175276a75aa1f203a6::blast_fun::BLAST_FUN>(arg1, 1);
        0x39d26c7fbd757342149e0d69ffa873e748b177b2034f49b36d9e21b4bc8168dc::delayed_set::apply_add<ClaimSignerKey, vector<u8>>(&mut arg0.creator_claim_signers, arg2, arg3);
    }

    public fun apply_creator_claim_signer_delay(arg0: &mut RuntimeConfig, arg1: &0x39d26c7fbd757342149e0d69ffa873e748b177b2034f49b36d9e21b4bc8168dc::package_version::PackageVersion<0xcbe990b5e52d602f3732a40833a046e29d0267237d1887175276a75aa1f203a6::blast_fun::BLAST_FUN>, arg2: &0x2::clock::Clock) {
        0x39d26c7fbd757342149e0d69ffa873e748b177b2034f49b36d9e21b4bc8168dc::package_version::assert_current<0xcbe990b5e52d602f3732a40833a046e29d0267237d1887175276a75aa1f203a6::blast_fun::BLAST_FUN>(arg1, 1);
        0x39d26c7fbd757342149e0d69ffa873e748b177b2034f49b36d9e21b4bc8168dc::delayed_set::apply_delay<ClaimSignerKey, vector<u8>>(&mut arg0.creator_claim_signers, arg2);
    }

    public fun apply_protocol_fee_share(arg0: &mut RuntimeConfig, arg1: &0x39d26c7fbd757342149e0d69ffa873e748b177b2034f49b36d9e21b4bc8168dc::package_version::PackageVersion<0xcbe990b5e52d602f3732a40833a046e29d0267237d1887175276a75aa1f203a6::blast_fun::BLAST_FUN>, arg2: &0x2::clock::Clock) {
        0x39d26c7fbd757342149e0d69ffa873e748b177b2034f49b36d9e21b4bc8168dc::package_version::assert_current<0xcbe990b5e52d602f3732a40833a046e29d0267237d1887175276a75aa1f203a6::blast_fun::BLAST_FUN>(arg1, 1);
        0x39d26c7fbd757342149e0d69ffa873e748b177b2034f49b36d9e21b4bc8168dc::delayed::apply<ProtocolFeeShareKey, 0xeba5715e19b20c4d6599cc579bd080e5775d1aaa484e3802ec9d29974f61f5f5::bps::Bps>(&mut arg0.protocol_fee_share_bps, arg2);
    }

    public fun cancel_creator_claim_signer(arg0: &mut RuntimeConfig, arg1: &0x39d26c7fbd757342149e0d69ffa873e748b177b2034f49b36d9e21b4bc8168dc::package_version::PackageVersion<0xcbe990b5e52d602f3732a40833a046e29d0267237d1887175276a75aa1f203a6::blast_fun::BLAST_FUN>, arg2: &0x39d26c7fbd757342149e0d69ffa873e748b177b2034f49b36d9e21b4bc8168dc::blast_acl::AdminWitness<0xeba5715e19b20c4d6599cc579bd080e5775d1aaa484e3802ec9d29974f61f5f5::blast_domain::CancelAdmin>, arg3: vector<u8>) {
        0x39d26c7fbd757342149e0d69ffa873e748b177b2034f49b36d9e21b4bc8168dc::package_version::assert_current<0xcbe990b5e52d602f3732a40833a046e29d0267237d1887175276a75aa1f203a6::blast_fun::BLAST_FUN>(arg1, 1);
        0x39d26c7fbd757342149e0d69ffa873e748b177b2034f49b36d9e21b4bc8168dc::delayed_set::cancel_add<ClaimSignerKey, vector<u8>>(&mut arg0.creator_claim_signers, arg3);
    }

    public fun cancel_creator_claim_signer_delay(arg0: &mut RuntimeConfig, arg1: &0x39d26c7fbd757342149e0d69ffa873e748b177b2034f49b36d9e21b4bc8168dc::package_version::PackageVersion<0xcbe990b5e52d602f3732a40833a046e29d0267237d1887175276a75aa1f203a6::blast_fun::BLAST_FUN>, arg2: &0x39d26c7fbd757342149e0d69ffa873e748b177b2034f49b36d9e21b4bc8168dc::blast_acl::AdminWitness<0xeba5715e19b20c4d6599cc579bd080e5775d1aaa484e3802ec9d29974f61f5f5::blast_domain::CancelAdmin>) {
        0x39d26c7fbd757342149e0d69ffa873e748b177b2034f49b36d9e21b4bc8168dc::package_version::assert_current<0xcbe990b5e52d602f3732a40833a046e29d0267237d1887175276a75aa1f203a6::blast_fun::BLAST_FUN>(arg1, 1);
        0x39d26c7fbd757342149e0d69ffa873e748b177b2034f49b36d9e21b4bc8168dc::delayed_set::cancel_delay<ClaimSignerKey, vector<u8>>(&mut arg0.creator_claim_signers);
    }

    public fun cancel_protocol_fee_share(arg0: &mut RuntimeConfig, arg1: &0x39d26c7fbd757342149e0d69ffa873e748b177b2034f49b36d9e21b4bc8168dc::package_version::PackageVersion<0xcbe990b5e52d602f3732a40833a046e29d0267237d1887175276a75aa1f203a6::blast_fun::BLAST_FUN>, arg2: &0x39d26c7fbd757342149e0d69ffa873e748b177b2034f49b36d9e21b4bc8168dc::blast_acl::AdminWitness<0xeba5715e19b20c4d6599cc579bd080e5775d1aaa484e3802ec9d29974f61f5f5::blast_domain::CancelAdmin>) {
        0x39d26c7fbd757342149e0d69ffa873e748b177b2034f49b36d9e21b4bc8168dc::package_version::assert_current<0xcbe990b5e52d602f3732a40833a046e29d0267237d1887175276a75aa1f203a6::blast_fun::BLAST_FUN>(arg1, 1);
        0x39d26c7fbd757342149e0d69ffa873e748b177b2034f49b36d9e21b4bc8168dc::delayed::cancel<ProtocolFeeShareKey, 0xeba5715e19b20c4d6599cc579bd080e5775d1aaa484e3802ec9d29974f61f5f5::bps::Bps>(&mut arg0.protocol_fee_share_bps);
    }

    fun checked_protocol_fee_share(arg0: 0xeba5715e19b20c4d6599cc579bd080e5775d1aaa484e3802ec9d29974f61f5f5::bps::Bps) : 0xeba5715e19b20c4d6599cc579bd080e5775d1aaa484e3802ec9d29974f61f5f5::bps::Bps {
        assert!(0xeba5715e19b20c4d6599cc579bd080e5775d1aaa484e3802ec9d29974f61f5f5::bps::value(arg0) <= 7000, 33);
        arg0
    }

    public(friend) fun creator_claim_signers(arg0: &RuntimeConfig) : vector<vector<u8>> {
        0x2::vec_set::into_keys<vector<u8>>(0x39d26c7fbd757342149e0d69ffa873e748b177b2034f49b36d9e21b4bc8168dc::delayed_set::members<ClaimSignerKey, vector<u8>>(&arg0.creator_claim_signers))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<RuntimeConfig>(new(arg0));
    }

    public(friend) fun protocol_fee_share(arg0: &RuntimeConfig) : 0xeba5715e19b20c4d6599cc579bd080e5775d1aaa484e3802ec9d29974f61f5f5::bps::Bps {
        0x39d26c7fbd757342149e0d69ffa873e748b177b2034f49b36d9e21b4bc8168dc::delayed::value<ProtocolFeeShareKey, 0xeba5715e19b20c4d6599cc579bd080e5775d1aaa484e3802ec9d29974f61f5f5::bps::Bps>(&arg0.protocol_fee_share_bps)
    }

    public fun revoke_creator_claim_signer(arg0: &mut RuntimeConfig, arg1: &0x39d26c7fbd757342149e0d69ffa873e748b177b2034f49b36d9e21b4bc8168dc::package_version::PackageVersion<0xcbe990b5e52d602f3732a40833a046e29d0267237d1887175276a75aa1f203a6::blast_fun::BLAST_FUN>, arg2: &0x39d26c7fbd757342149e0d69ffa873e748b177b2034f49b36d9e21b4bc8168dc::blast_acl::AdminWitness<0xeba5715e19b20c4d6599cc579bd080e5775d1aaa484e3802ec9d29974f61f5f5::blast_domain::ClaimSignerAdmin>, arg3: vector<u8>) {
        0x39d26c7fbd757342149e0d69ffa873e748b177b2034f49b36d9e21b4bc8168dc::package_version::assert_current<0xcbe990b5e52d602f3732a40833a046e29d0267237d1887175276a75aa1f203a6::blast_fun::BLAST_FUN>(arg1, 1);
        0x39d26c7fbd757342149e0d69ffa873e748b177b2034f49b36d9e21b4bc8168dc::delayed_set::remove<ClaimSignerKey, vector<u8>>(&mut arg0.creator_claim_signers, arg3);
    }

    public fun schedule_creator_claim_signer(arg0: &mut RuntimeConfig, arg1: &0x39d26c7fbd757342149e0d69ffa873e748b177b2034f49b36d9e21b4bc8168dc::package_version::PackageVersion<0xcbe990b5e52d602f3732a40833a046e29d0267237d1887175276a75aa1f203a6::blast_fun::BLAST_FUN>, arg2: &0x39d26c7fbd757342149e0d69ffa873e748b177b2034f49b36d9e21b4bc8168dc::blast_acl::AdminWitness<0xeba5715e19b20c4d6599cc579bd080e5775d1aaa484e3802ec9d29974f61f5f5::blast_domain::ClaimSignerAdmin>, arg3: vector<u8>, arg4: &0x2::clock::Clock) {
        0x39d26c7fbd757342149e0d69ffa873e748b177b2034f49b36d9e21b4bc8168dc::package_version::assert_current<0xcbe990b5e52d602f3732a40833a046e29d0267237d1887175276a75aa1f203a6::blast_fun::BLAST_FUN>(arg1, 1);
        assert!(0x1::vector::length<u8>(&arg3) == 32, 22);
        let v0 = &arg0.creator_claim_signers;
        let v1 = 0x39d26c7fbd757342149e0d69ffa873e748b177b2034f49b36d9e21b4bc8168dc::delayed_set::admission_ready_at_ms<ClaimSignerKey, vector<u8>>(v0, &arg3);
        let v2 = if (0x1::option::is_some<u64>(&v1)) {
            1
        } else {
            0
        };
        let v3 = 0x39d26c7fbd757342149e0d69ffa873e748b177b2034f49b36d9e21b4bc8168dc::delayed_set::members<ClaimSignerKey, vector<u8>>(v0);
        assert!(0x2::vec_set::length<vector<u8>>(&v3) + 0x39d26c7fbd757342149e0d69ffa873e748b177b2034f49b36d9e21b4bc8168dc::delayed_set::pending_count<ClaimSignerKey, vector<u8>>(v0) - v2 < 4, 31);
        0x39d26c7fbd757342149e0d69ffa873e748b177b2034f49b36d9e21b4bc8168dc::delayed_set::schedule_add<ClaimSignerKey, vector<u8>>(&mut arg0.creator_claim_signers, arg3, arg4);
    }

    public fun schedule_creator_claim_signer_delay(arg0: &mut RuntimeConfig, arg1: &0x39d26c7fbd757342149e0d69ffa873e748b177b2034f49b36d9e21b4bc8168dc::package_version::PackageVersion<0xcbe990b5e52d602f3732a40833a046e29d0267237d1887175276a75aa1f203a6::blast_fun::BLAST_FUN>, arg2: &0x39d26c7fbd757342149e0d69ffa873e748b177b2034f49b36d9e21b4bc8168dc::blast_acl::AdminWitness<0xeba5715e19b20c4d6599cc579bd080e5775d1aaa484e3802ec9d29974f61f5f5::blast_domain::ClaimSignerAdmin>, arg3: u64, arg4: &0x2::clock::Clock) {
        0x39d26c7fbd757342149e0d69ffa873e748b177b2034f49b36d9e21b4bc8168dc::package_version::assert_current<0xcbe990b5e52d602f3732a40833a046e29d0267237d1887175276a75aa1f203a6::blast_fun::BLAST_FUN>(arg1, 1);
        0x39d26c7fbd757342149e0d69ffa873e748b177b2034f49b36d9e21b4bc8168dc::delayed_set::schedule_delay<ClaimSignerKey, vector<u8>>(&mut arg0.creator_claim_signers, arg3, arg4);
    }

    public fun schedule_protocol_fee_share(arg0: &mut RuntimeConfig, arg1: &0x39d26c7fbd757342149e0d69ffa873e748b177b2034f49b36d9e21b4bc8168dc::package_version::PackageVersion<0xcbe990b5e52d602f3732a40833a046e29d0267237d1887175276a75aa1f203a6::blast_fun::BLAST_FUN>, arg2: &0x39d26c7fbd757342149e0d69ffa873e748b177b2034f49b36d9e21b4bc8168dc::blast_acl::AdminWitness<0xeba5715e19b20c4d6599cc579bd080e5775d1aaa484e3802ec9d29974f61f5f5::blast_domain::FeeAdmin>, arg3: 0xeba5715e19b20c4d6599cc579bd080e5775d1aaa484e3802ec9d29974f61f5f5::bps::Bps, arg4: u64, arg5: &0x2::clock::Clock) {
        0x39d26c7fbd757342149e0d69ffa873e748b177b2034f49b36d9e21b4bc8168dc::package_version::assert_current<0xcbe990b5e52d602f3732a40833a046e29d0267237d1887175276a75aa1f203a6::blast_fun::BLAST_FUN>(arg1, 1);
        0x39d26c7fbd757342149e0d69ffa873e748b177b2034f49b36d9e21b4bc8168dc::delayed::schedule<ProtocolFeeShareKey, 0xeba5715e19b20c4d6599cc579bd080e5775d1aaa484e3802ec9d29974f61f5f5::bps::Bps>(&mut arg0.protocol_fee_share_bps, checked_protocol_fee_share(arg3), arg4, arg5);
    }

    // decompiled from Move bytecode v7
}

