module 0x3e70fb9284a3a45e466713b4eb05097095be4d0d90b6348b6d9dd832d2c49227::fee_policy {
    struct FeePolicy has key {
        id: 0x2::object::UID,
        fees: 0x39d26c7fbd757342149e0d69ffa873e748b177b2034f49b36d9e21b4bc8168dc::delayed::Delayed<FeesKey, ProtocolFees>,
    }

    struct FeesKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ProtocolFees has copy, drop, store {
        raise_bps: 0xeba5715e19b20c4d6599cc579bd080e5775d1aaa484e3802ec9d29974f61f5f5::bps::Bps,
        token_bps: 0xeba5715e19b20c4d6599cc579bd080e5775d1aaa484e3802ec9d29974f61f5f5::bps::Bps,
        lp_fee_meme_bps: 0xeba5715e19b20c4d6599cc579bd080e5775d1aaa484e3802ec9d29974f61f5f5::bps::Bps,
        lp_fee_quote_bps: 0xeba5715e19b20c4d6599cc579bd080e5775d1aaa484e3802ec9d29974f61f5f5::bps::Bps,
    }

    fun new(arg0: ProtocolFees, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : FeePolicy {
        let v0 = 0x2::object::new(arg2);
        let v1 = FeesKey{dummy_field: false};
        FeePolicy{
            id   : v0,
            fees : 0x39d26c7fbd757342149e0d69ffa873e748b177b2034f49b36d9e21b4bc8168dc::delayed::new<FeesKey, ProtocolFees>(v1, &v0, arg0, arg1),
        }
    }

    public(friend) fun is_guarded(arg0: &FeePolicy) : bool {
        0x39d26c7fbd757342149e0d69ffa873e748b177b2034f49b36d9e21b4bc8168dc::delayed::is_guarded<FeesKey, ProtocolFees>(&arg0.fees)
    }

    public fun apply_fees(arg0: &mut FeePolicy, arg1: &0x39d26c7fbd757342149e0d69ffa873e748b177b2034f49b36d9e21b4bc8168dc::package_version::PackageVersion<0x3e70fb9284a3a45e466713b4eb05097095be4d0d90b6348b6d9dd832d2c49227::blast_presale_package::BLAST_PRESALE_PACKAGE>, arg2: &0x2::clock::Clock) {
        0x39d26c7fbd757342149e0d69ffa873e748b177b2034f49b36d9e21b4bc8168dc::package_version::assert_current<0x3e70fb9284a3a45e466713b4eb05097095be4d0d90b6348b6d9dd832d2c49227::blast_presale_package::BLAST_PRESALE_PACKAGE>(arg1, 1);
        0x39d26c7fbd757342149e0d69ffa873e748b177b2034f49b36d9e21b4bc8168dc::delayed::apply<FeesKey, ProtocolFees>(&mut arg0.fees, arg2);
    }

    public fun cancel_fees(arg0: &mut FeePolicy, arg1: &0x39d26c7fbd757342149e0d69ffa873e748b177b2034f49b36d9e21b4bc8168dc::package_version::PackageVersion<0x3e70fb9284a3a45e466713b4eb05097095be4d0d90b6348b6d9dd832d2c49227::blast_presale_package::BLAST_PRESALE_PACKAGE>, arg2: &0x39d26c7fbd757342149e0d69ffa873e748b177b2034f49b36d9e21b4bc8168dc::blast_acl::AdminWitness<0xeba5715e19b20c4d6599cc579bd080e5775d1aaa484e3802ec9d29974f61f5f5::blast_domain::CancelAdmin>) {
        0x39d26c7fbd757342149e0d69ffa873e748b177b2034f49b36d9e21b4bc8168dc::package_version::assert_current<0x3e70fb9284a3a45e466713b4eb05097095be4d0d90b6348b6d9dd832d2c49227::blast_presale_package::BLAST_PRESALE_PACKAGE>(arg1, 1);
        0x39d26c7fbd757342149e0d69ffa873e748b177b2034f49b36d9e21b4bc8168dc::delayed::cancel<FeesKey, ProtocolFees>(&mut arg0.fees);
    }

    public(friend) fun fees(arg0: &FeePolicy) : ProtocolFees {
        0x39d26c7fbd757342149e0d69ffa873e748b177b2034f49b36d9e21b4bc8168dc::delayed::value<FeesKey, ProtocolFees>(&arg0.fees)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<FeePolicy>(new(protocol_fees(0xeba5715e19b20c4d6599cc579bd080e5775d1aaa484e3802ec9d29974f61f5f5::bps::new(200), 0xeba5715e19b20c4d6599cc579bd080e5775d1aaa484e3802ec9d29974f61f5f5::bps::new(100), 0xeba5715e19b20c4d6599cc579bd080e5775d1aaa484e3802ec9d29974f61f5f5::bps::new(1500), 0xeba5715e19b20c4d6599cc579bd080e5775d1aaa484e3802ec9d29974f61f5f5::bps::new(1500)), 0, arg0));
    }

    public(friend) fun lp_fee_meme_bps(arg0: &ProtocolFees) : 0xeba5715e19b20c4d6599cc579bd080e5775d1aaa484e3802ec9d29974f61f5f5::bps::Bps {
        arg0.lp_fee_meme_bps
    }

    public(friend) fun lp_fee_quote_bps(arg0: &ProtocolFees) : 0xeba5715e19b20c4d6599cc579bd080e5775d1aaa484e3802ec9d29974f61f5f5::bps::Bps {
        arg0.lp_fee_quote_bps
    }

    public(friend) fun protocol_fees(arg0: 0xeba5715e19b20c4d6599cc579bd080e5775d1aaa484e3802ec9d29974f61f5f5::bps::Bps, arg1: 0xeba5715e19b20c4d6599cc579bd080e5775d1aaa484e3802ec9d29974f61f5f5::bps::Bps, arg2: 0xeba5715e19b20c4d6599cc579bd080e5775d1aaa484e3802ec9d29974f61f5f5::bps::Bps, arg3: 0xeba5715e19b20c4d6599cc579bd080e5775d1aaa484e3802ec9d29974f61f5f5::bps::Bps) : ProtocolFees {
        let v0 = if (0xeba5715e19b20c4d6599cc579bd080e5775d1aaa484e3802ec9d29974f61f5f5::bps::value(arg0) <= 1000) {
            if (0xeba5715e19b20c4d6599cc579bd080e5775d1aaa484e3802ec9d29974f61f5f5::bps::value(arg1) <= 1000) {
                if (0xeba5715e19b20c4d6599cc579bd080e5775d1aaa484e3802ec9d29974f61f5f5::bps::value(arg2) <= 3000) {
                    0xeba5715e19b20c4d6599cc579bd080e5775d1aaa484e3802ec9d29974f61f5f5::bps::value(arg3) <= 3000
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 5);
        ProtocolFees{
            raise_bps        : arg0,
            token_bps        : arg1,
            lp_fee_meme_bps  : arg2,
            lp_fee_quote_bps : arg3,
        }
    }

    public(friend) fun raise_bps(arg0: &ProtocolFees) : 0xeba5715e19b20c4d6599cc579bd080e5775d1aaa484e3802ec9d29974f61f5f5::bps::Bps {
        arg0.raise_bps
    }

    public fun schedule_fees(arg0: &mut FeePolicy, arg1: &0x39d26c7fbd757342149e0d69ffa873e748b177b2034f49b36d9e21b4bc8168dc::package_version::PackageVersion<0x3e70fb9284a3a45e466713b4eb05097095be4d0d90b6348b6d9dd832d2c49227::blast_presale_package::BLAST_PRESALE_PACKAGE>, arg2: &0x39d26c7fbd757342149e0d69ffa873e748b177b2034f49b36d9e21b4bc8168dc::blast_acl::AdminWitness<0xeba5715e19b20c4d6599cc579bd080e5775d1aaa484e3802ec9d29974f61f5f5::blast_domain::FeeAdmin>, arg3: 0xeba5715e19b20c4d6599cc579bd080e5775d1aaa484e3802ec9d29974f61f5f5::bps::Bps, arg4: 0xeba5715e19b20c4d6599cc579bd080e5775d1aaa484e3802ec9d29974f61f5f5::bps::Bps, arg5: 0xeba5715e19b20c4d6599cc579bd080e5775d1aaa484e3802ec9d29974f61f5f5::bps::Bps, arg6: 0xeba5715e19b20c4d6599cc579bd080e5775d1aaa484e3802ec9d29974f61f5f5::bps::Bps, arg7: u64, arg8: &0x2::clock::Clock) {
        0x39d26c7fbd757342149e0d69ffa873e748b177b2034f49b36d9e21b4bc8168dc::package_version::assert_current<0x3e70fb9284a3a45e466713b4eb05097095be4d0d90b6348b6d9dd832d2c49227::blast_presale_package::BLAST_PRESALE_PACKAGE>(arg1, 1);
        0x39d26c7fbd757342149e0d69ffa873e748b177b2034f49b36d9e21b4bc8168dc::delayed::schedule<FeesKey, ProtocolFees>(&mut arg0.fees, protocol_fees(arg3, arg4, arg5, arg6), arg7, arg8);
    }

    public(friend) fun token_bps(arg0: &ProtocolFees) : 0xeba5715e19b20c4d6599cc579bd080e5775d1aaa484e3802ec9d29974f61f5f5::bps::Bps {
        arg0.token_bps
    }

    // decompiled from Move bytecode v7
}

