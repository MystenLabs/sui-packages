module 0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::fee_policy {
    struct FeePolicy has key {
        id: 0x2::object::UID,
        fees: 0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed::Delayed<FeesKey, ProtocolFees>,
    }

    struct FeesKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ProtocolFees has copy, drop, store {
        raise_bps: 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::Bps,
        token_bps: 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::Bps,
        lp_fee_meme_bps: 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::Bps,
        lp_fee_quote_bps: 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::Bps,
    }

    fun new(arg0: ProtocolFees, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : FeePolicy {
        let v0 = 0x2::object::new(arg2);
        let v1 = FeesKey{dummy_field: false};
        FeePolicy{
            id   : v0,
            fees : 0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed::new<FeesKey, ProtocolFees>(v1, &v0, arg0, arg1),
        }
    }

    public fun apply_fees(arg0: &mut FeePolicy, arg1: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::PackageVersion<0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::blast_presale_package::BLAST_PRESALE_PACKAGE>, arg2: &0x2::clock::Clock) {
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::assert_current<0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::blast_presale_package::BLAST_PRESALE_PACKAGE>(arg1, 1);
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed::apply<FeesKey, ProtocolFees>(&mut arg0.fees, arg2);
    }

    public fun cancel_fees(arg0: &mut FeePolicy, arg1: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::PackageVersion<0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::blast_presale_package::BLAST_PRESALE_PACKAGE>, arg2: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::blast_acl::AdminWitness<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::blast_domain::CancelAdmin>) {
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::assert_current<0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::blast_presale_package::BLAST_PRESALE_PACKAGE>(arg1, 1);
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed::cancel<FeesKey, ProtocolFees>(&mut arg0.fees);
    }

    public(friend) fun fees(arg0: &FeePolicy) : ProtocolFees {
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed::value<FeesKey, ProtocolFees>(&arg0.fees)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<FeePolicy>(new(protocol_fees(0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::new(200), 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::new(100), 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::new(1500), 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::new(1500)), 0, arg0));
    }

    public(friend) fun is_guarded(arg0: &FeePolicy) : bool {
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed::is_guarded<FeesKey, ProtocolFees>(&arg0.fees)
    }

    public(friend) fun lp_fee_meme_bps(arg0: &ProtocolFees) : 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::Bps {
        arg0.lp_fee_meme_bps
    }

    public(friend) fun lp_fee_quote_bps(arg0: &ProtocolFees) : 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::Bps {
        arg0.lp_fee_quote_bps
    }

    public(friend) fun protocol_fees(arg0: 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::Bps, arg1: 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::Bps, arg2: 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::Bps, arg3: 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::Bps) : ProtocolFees {
        let v0 = if (0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::value(arg0) <= 1000) {
            if (0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::value(arg1) <= 1000) {
                if (0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::value(arg2) <= 3000) {
                    0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::value(arg3) <= 3000
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

    public(friend) fun raise_bps(arg0: &ProtocolFees) : 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::Bps {
        arg0.raise_bps
    }

    public fun schedule_fees(arg0: &mut FeePolicy, arg1: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::PackageVersion<0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::blast_presale_package::BLAST_PRESALE_PACKAGE>, arg2: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::blast_acl::AdminWitness<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::blast_domain::FeeAdmin>, arg3: 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::Bps, arg4: 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::Bps, arg5: 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::Bps, arg6: 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::Bps, arg7: u64, arg8: &0x2::clock::Clock) {
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::assert_current<0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::blast_presale_package::BLAST_PRESALE_PACKAGE>(arg1, 1);
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed::schedule<FeesKey, ProtocolFees>(&mut arg0.fees, protocol_fees(arg3, arg4, arg5, arg6), arg7, arg8);
    }

    public(friend) fun token_bps(arg0: &ProtocolFees) : 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::Bps {
        arg0.token_bps
    }

    // decompiled from Move bytecode v7
}

