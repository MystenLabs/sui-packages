module 0x3f2e6f190036693c425d3327240fe2f08fe1062ab279b998dff02aed459db508::fee_policy {
    struct FeePolicy has key {
        id: 0x2::object::UID,
        fees: 0x7c323cdc962a2875a255ac79cd2fc595dc0a491beed896652fd5182b1820662b::delayed::Delayed<FeesKey, ProtocolFees>,
    }

    struct FeesKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ProtocolFees has copy, drop, store {
        raise_bps: 0xf02c2127356906e1fa184be1f065c71df0adfe693ecd9279cedcacc6aa66216::bps::Bps,
        token_bps: 0xf02c2127356906e1fa184be1f065c71df0adfe693ecd9279cedcacc6aa66216::bps::Bps,
        lp_fee_meme_bps: 0xf02c2127356906e1fa184be1f065c71df0adfe693ecd9279cedcacc6aa66216::bps::Bps,
        lp_fee_quote_bps: 0xf02c2127356906e1fa184be1f065c71df0adfe693ecd9279cedcacc6aa66216::bps::Bps,
    }

    fun new(arg0: ProtocolFees, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : FeePolicy {
        let v0 = 0x2::object::new(arg2);
        let v1 = FeesKey{dummy_field: false};
        FeePolicy{
            id   : v0,
            fees : 0x7c323cdc962a2875a255ac79cd2fc595dc0a491beed896652fd5182b1820662b::delayed::new<FeesKey, ProtocolFees>(v1, &v0, arg0, arg1),
        }
    }

    public fun apply_fees(arg0: &mut FeePolicy, arg1: &0x7c323cdc962a2875a255ac79cd2fc595dc0a491beed896652fd5182b1820662b::package_version::PackageVersion<0x3f2e6f190036693c425d3327240fe2f08fe1062ab279b998dff02aed459db508::blast_presale_package::BLAST_PRESALE_PACKAGE>, arg2: &0x2::clock::Clock) {
        0x7c323cdc962a2875a255ac79cd2fc595dc0a491beed896652fd5182b1820662b::package_version::assert_current<0x3f2e6f190036693c425d3327240fe2f08fe1062ab279b998dff02aed459db508::blast_presale_package::BLAST_PRESALE_PACKAGE>(arg1, 1);
        0x7c323cdc962a2875a255ac79cd2fc595dc0a491beed896652fd5182b1820662b::delayed::apply<FeesKey, ProtocolFees>(&mut arg0.fees, arg2);
    }

    public fun cancel_fees(arg0: &mut FeePolicy, arg1: &0x7c323cdc962a2875a255ac79cd2fc595dc0a491beed896652fd5182b1820662b::package_version::PackageVersion<0x3f2e6f190036693c425d3327240fe2f08fe1062ab279b998dff02aed459db508::blast_presale_package::BLAST_PRESALE_PACKAGE>, arg2: &0x7c323cdc962a2875a255ac79cd2fc595dc0a491beed896652fd5182b1820662b::blast_acl::AdminWitness<0xf02c2127356906e1fa184be1f065c71df0adfe693ecd9279cedcacc6aa66216::blast_domain::CancelAdmin>) {
        0x7c323cdc962a2875a255ac79cd2fc595dc0a491beed896652fd5182b1820662b::package_version::assert_current<0x3f2e6f190036693c425d3327240fe2f08fe1062ab279b998dff02aed459db508::blast_presale_package::BLAST_PRESALE_PACKAGE>(arg1, 1);
        0x7c323cdc962a2875a255ac79cd2fc595dc0a491beed896652fd5182b1820662b::delayed::cancel<FeesKey, ProtocolFees>(&mut arg0.fees);
    }

    public(friend) fun fees(arg0: &FeePolicy) : ProtocolFees {
        0x7c323cdc962a2875a255ac79cd2fc595dc0a491beed896652fd5182b1820662b::delayed::value<FeesKey, ProtocolFees>(&arg0.fees)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<FeePolicy>(new(protocol_fees(0xf02c2127356906e1fa184be1f065c71df0adfe693ecd9279cedcacc6aa66216::bps::new(200), 0xf02c2127356906e1fa184be1f065c71df0adfe693ecd9279cedcacc6aa66216::bps::new(100), 0xf02c2127356906e1fa184be1f065c71df0adfe693ecd9279cedcacc6aa66216::bps::new(1500), 0xf02c2127356906e1fa184be1f065c71df0adfe693ecd9279cedcacc6aa66216::bps::new(1500)), 0, arg0));
    }

    public(friend) fun is_guarded(arg0: &FeePolicy) : bool {
        0x7c323cdc962a2875a255ac79cd2fc595dc0a491beed896652fd5182b1820662b::delayed::is_guarded<FeesKey, ProtocolFees>(&arg0.fees)
    }

    public(friend) fun lp_fee_meme_bps(arg0: &ProtocolFees) : 0xf02c2127356906e1fa184be1f065c71df0adfe693ecd9279cedcacc6aa66216::bps::Bps {
        arg0.lp_fee_meme_bps
    }

    public(friend) fun lp_fee_quote_bps(arg0: &ProtocolFees) : 0xf02c2127356906e1fa184be1f065c71df0adfe693ecd9279cedcacc6aa66216::bps::Bps {
        arg0.lp_fee_quote_bps
    }

    public(friend) fun protocol_fees(arg0: 0xf02c2127356906e1fa184be1f065c71df0adfe693ecd9279cedcacc6aa66216::bps::Bps, arg1: 0xf02c2127356906e1fa184be1f065c71df0adfe693ecd9279cedcacc6aa66216::bps::Bps, arg2: 0xf02c2127356906e1fa184be1f065c71df0adfe693ecd9279cedcacc6aa66216::bps::Bps, arg3: 0xf02c2127356906e1fa184be1f065c71df0adfe693ecd9279cedcacc6aa66216::bps::Bps) : ProtocolFees {
        let v0 = if (0xf02c2127356906e1fa184be1f065c71df0adfe693ecd9279cedcacc6aa66216::bps::value(arg0) <= 1000) {
            if (0xf02c2127356906e1fa184be1f065c71df0adfe693ecd9279cedcacc6aa66216::bps::value(arg1) <= 1000) {
                if (0xf02c2127356906e1fa184be1f065c71df0adfe693ecd9279cedcacc6aa66216::bps::value(arg2) <= 3000) {
                    0xf02c2127356906e1fa184be1f065c71df0adfe693ecd9279cedcacc6aa66216::bps::value(arg3) <= 3000
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

    public(friend) fun raise_bps(arg0: &ProtocolFees) : 0xf02c2127356906e1fa184be1f065c71df0adfe693ecd9279cedcacc6aa66216::bps::Bps {
        arg0.raise_bps
    }

    public fun schedule_fees(arg0: &mut FeePolicy, arg1: &0x7c323cdc962a2875a255ac79cd2fc595dc0a491beed896652fd5182b1820662b::package_version::PackageVersion<0x3f2e6f190036693c425d3327240fe2f08fe1062ab279b998dff02aed459db508::blast_presale_package::BLAST_PRESALE_PACKAGE>, arg2: &0x7c323cdc962a2875a255ac79cd2fc595dc0a491beed896652fd5182b1820662b::blast_acl::AdminWitness<0xf02c2127356906e1fa184be1f065c71df0adfe693ecd9279cedcacc6aa66216::blast_domain::FeeAdmin>, arg3: 0xf02c2127356906e1fa184be1f065c71df0adfe693ecd9279cedcacc6aa66216::bps::Bps, arg4: 0xf02c2127356906e1fa184be1f065c71df0adfe693ecd9279cedcacc6aa66216::bps::Bps, arg5: 0xf02c2127356906e1fa184be1f065c71df0adfe693ecd9279cedcacc6aa66216::bps::Bps, arg6: 0xf02c2127356906e1fa184be1f065c71df0adfe693ecd9279cedcacc6aa66216::bps::Bps, arg7: u64, arg8: &0x2::clock::Clock) {
        0x7c323cdc962a2875a255ac79cd2fc595dc0a491beed896652fd5182b1820662b::package_version::assert_current<0x3f2e6f190036693c425d3327240fe2f08fe1062ab279b998dff02aed459db508::blast_presale_package::BLAST_PRESALE_PACKAGE>(arg1, 1);
        0x7c323cdc962a2875a255ac79cd2fc595dc0a491beed896652fd5182b1820662b::delayed::schedule<FeesKey, ProtocolFees>(&mut arg0.fees, protocol_fees(arg3, arg4, arg5, arg6), arg7, arg8);
    }

    public(friend) fun token_bps(arg0: &ProtocolFees) : 0xf02c2127356906e1fa184be1f065c71df0adfe693ecd9279cedcacc6aa66216::bps::Bps {
        arg0.token_bps
    }

    // decompiled from Move bytecode v7
}

