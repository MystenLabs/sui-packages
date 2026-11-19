module 0xdfd64752823117be6057f1dab00a84d7d9e128667a9e73ccab247e99cc92f67d::fee_policy {
    struct FeePolicy has key {
        id: 0x2::object::UID,
        fees: 0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::delayed::Delayed<FeesKey, ProtocolFees>,
    }

    struct FeesKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ProtocolFees has copy, drop, store {
        raise_bps: 0x7ff2de5a2df7cc9c8b514dfbb25285b6cc72074d5e166186d8891860143c2f45::bps::Bps,
        token_bps: 0x7ff2de5a2df7cc9c8b514dfbb25285b6cc72074d5e166186d8891860143c2f45::bps::Bps,
        lp_fee_meme_bps: 0x7ff2de5a2df7cc9c8b514dfbb25285b6cc72074d5e166186d8891860143c2f45::bps::Bps,
        lp_fee_quote_bps: 0x7ff2de5a2df7cc9c8b514dfbb25285b6cc72074d5e166186d8891860143c2f45::bps::Bps,
    }

    fun new(arg0: ProtocolFees, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : FeePolicy {
        let v0 = 0x2::object::new(arg2);
        let v1 = FeesKey{dummy_field: false};
        FeePolicy{
            id   : v0,
            fees : 0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::delayed::new<FeesKey, ProtocolFees>(v1, &v0, arg0, arg1),
        }
    }

    public(friend) fun is_guarded(arg0: &FeePolicy) : bool {
        0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::delayed::is_guarded<FeesKey, ProtocolFees>(&arg0.fees)
    }

    public fun apply_fees(arg0: &mut FeePolicy, arg1: &0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::package_version::PackageVersion<0xdfd64752823117be6057f1dab00a84d7d9e128667a9e73ccab247e99cc92f67d::blast_presale_package::BLAST_PRESALE_PACKAGE>, arg2: &0x2::clock::Clock) {
        0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::package_version::assert_current<0xdfd64752823117be6057f1dab00a84d7d9e128667a9e73ccab247e99cc92f67d::blast_presale_package::BLAST_PRESALE_PACKAGE>(arg1, 1);
        0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::delayed::apply<FeesKey, ProtocolFees>(&mut arg0.fees, arg2);
    }

    public fun cancel_fees(arg0: &mut FeePolicy, arg1: &0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::package_version::PackageVersion<0xdfd64752823117be6057f1dab00a84d7d9e128667a9e73ccab247e99cc92f67d::blast_presale_package::BLAST_PRESALE_PACKAGE>, arg2: &0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::blast_acl::AdminWitness<0x7ff2de5a2df7cc9c8b514dfbb25285b6cc72074d5e166186d8891860143c2f45::blast_domain::CancelAdmin>) {
        0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::package_version::assert_current<0xdfd64752823117be6057f1dab00a84d7d9e128667a9e73ccab247e99cc92f67d::blast_presale_package::BLAST_PRESALE_PACKAGE>(arg1, 1);
        0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::delayed::cancel<FeesKey, ProtocolFees>(&mut arg0.fees);
    }

    public(friend) fun fees(arg0: &FeePolicy) : ProtocolFees {
        0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::delayed::value<FeesKey, ProtocolFees>(&arg0.fees)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<FeePolicy>(new(protocol_fees(0x7ff2de5a2df7cc9c8b514dfbb25285b6cc72074d5e166186d8891860143c2f45::bps::new(200), 0x7ff2de5a2df7cc9c8b514dfbb25285b6cc72074d5e166186d8891860143c2f45::bps::new(100), 0x7ff2de5a2df7cc9c8b514dfbb25285b6cc72074d5e166186d8891860143c2f45::bps::new(1500), 0x7ff2de5a2df7cc9c8b514dfbb25285b6cc72074d5e166186d8891860143c2f45::bps::new(1500)), 0, arg0));
    }

    public(friend) fun lp_fee_meme_bps(arg0: &ProtocolFees) : 0x7ff2de5a2df7cc9c8b514dfbb25285b6cc72074d5e166186d8891860143c2f45::bps::Bps {
        arg0.lp_fee_meme_bps
    }

    public(friend) fun lp_fee_quote_bps(arg0: &ProtocolFees) : 0x7ff2de5a2df7cc9c8b514dfbb25285b6cc72074d5e166186d8891860143c2f45::bps::Bps {
        arg0.lp_fee_quote_bps
    }

    public(friend) fun protocol_fees(arg0: 0x7ff2de5a2df7cc9c8b514dfbb25285b6cc72074d5e166186d8891860143c2f45::bps::Bps, arg1: 0x7ff2de5a2df7cc9c8b514dfbb25285b6cc72074d5e166186d8891860143c2f45::bps::Bps, arg2: 0x7ff2de5a2df7cc9c8b514dfbb25285b6cc72074d5e166186d8891860143c2f45::bps::Bps, arg3: 0x7ff2de5a2df7cc9c8b514dfbb25285b6cc72074d5e166186d8891860143c2f45::bps::Bps) : ProtocolFees {
        let v0 = if (0x7ff2de5a2df7cc9c8b514dfbb25285b6cc72074d5e166186d8891860143c2f45::bps::value(arg0) <= 1000) {
            if (0x7ff2de5a2df7cc9c8b514dfbb25285b6cc72074d5e166186d8891860143c2f45::bps::value(arg1) <= 1000) {
                if (0x7ff2de5a2df7cc9c8b514dfbb25285b6cc72074d5e166186d8891860143c2f45::bps::value(arg2) <= 3000) {
                    0x7ff2de5a2df7cc9c8b514dfbb25285b6cc72074d5e166186d8891860143c2f45::bps::value(arg3) <= 3000
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

    public(friend) fun raise_bps(arg0: &ProtocolFees) : 0x7ff2de5a2df7cc9c8b514dfbb25285b6cc72074d5e166186d8891860143c2f45::bps::Bps {
        arg0.raise_bps
    }

    public fun schedule_fees(arg0: &mut FeePolicy, arg1: &0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::package_version::PackageVersion<0xdfd64752823117be6057f1dab00a84d7d9e128667a9e73ccab247e99cc92f67d::blast_presale_package::BLAST_PRESALE_PACKAGE>, arg2: &0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::blast_acl::AdminWitness<0x7ff2de5a2df7cc9c8b514dfbb25285b6cc72074d5e166186d8891860143c2f45::blast_domain::FeeAdmin>, arg3: 0x7ff2de5a2df7cc9c8b514dfbb25285b6cc72074d5e166186d8891860143c2f45::bps::Bps, arg4: 0x7ff2de5a2df7cc9c8b514dfbb25285b6cc72074d5e166186d8891860143c2f45::bps::Bps, arg5: 0x7ff2de5a2df7cc9c8b514dfbb25285b6cc72074d5e166186d8891860143c2f45::bps::Bps, arg6: 0x7ff2de5a2df7cc9c8b514dfbb25285b6cc72074d5e166186d8891860143c2f45::bps::Bps, arg7: u64, arg8: &0x2::clock::Clock) {
        0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::package_version::assert_current<0xdfd64752823117be6057f1dab00a84d7d9e128667a9e73ccab247e99cc92f67d::blast_presale_package::BLAST_PRESALE_PACKAGE>(arg1, 1);
        0xde7a411dcc38f03fef78877747cc1027abe9009c054c831540e7f8a4128ad9b::delayed::schedule<FeesKey, ProtocolFees>(&mut arg0.fees, protocol_fees(arg3, arg4, arg5, arg6), arg7, arg8);
    }

    public(friend) fun token_bps(arg0: &ProtocolFees) : 0x7ff2de5a2df7cc9c8b514dfbb25285b6cc72074d5e166186d8891860143c2f45::bps::Bps {
        arg0.token_bps
    }

    // decompiled from Move bytecode v7
}

