module 0x79a1b44c551613cbc63cc0406f8ff8d717407378dd6f17d43d9e1b3fd63a573::runtime_config {
    struct RuntimeConfig has key {
        id: 0x2::object::UID,
        creator_claim_signer_public_key: vector<u8>,
        protocol_fee_share_bps: 0x79a1b44c551613cbc63cc0406f8ff8d717407378dd6f17d43d9e1b3fd63a573::bps::Bps,
        treasury: address,
    }

    fun new(arg0: &mut 0x2::tx_context::TxContext) : RuntimeConfig {
        RuntimeConfig{
            id                              : 0x2::object::new(arg0),
            creator_claim_signer_public_key : b"",
            protocol_fee_share_bps          : 0x79a1b44c551613cbc63cc0406f8ff8d717407378dd6f17d43d9e1b3fd63a573::bps::new(0),
            treasury                        : 0x2::tx_context::sender(arg0),
        }
    }

    public(friend) fun creator_claim_signer(arg0: &RuntimeConfig) : &vector<u8> {
        &arg0.creator_claim_signer_public_key
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<RuntimeConfig>(new(arg0));
    }

    public(friend) fun protocol_fee_share(arg0: &RuntimeConfig) : 0x79a1b44c551613cbc63cc0406f8ff8d717407378dd6f17d43d9e1b3fd63a573::bps::Bps {
        arg0.protocol_fee_share_bps
    }

    public fun set_creator_claim_signer(arg0: &mut RuntimeConfig, arg1: &0x79a1b44c551613cbc63cc0406f8ff8d717407378dd6f17d43d9e1b3fd63a573::blast_fun::PackageVersion, arg2: &0x4a27d816998b2ff015cf897a249c069c34859a09e789e56ad3a38992cf00d7ac::blast_acl::AdminWitness<0x79a1b44c551613cbc63cc0406f8ff8d717407378dd6f17d43d9e1b3fd63a573::blast_fun_domain::ClaimSignerAdmin>, arg3: vector<u8>) {
        0x79a1b44c551613cbc63cc0406f8ff8d717407378dd6f17d43d9e1b3fd63a573::blast_fun::assert_current(arg1);
        assert!(0x1::vector::is_empty<u8>(&arg3) || 0x1::vector::length<u8>(&arg3) == 32, 27);
        assert!(arg3 != arg0.creator_claim_signer_public_key, 23);
        arg0.creator_claim_signer_public_key = arg3;
        0x79a1b44c551613cbc63cc0406f8ff8d717407378dd6f17d43d9e1b3fd63a573::events::creator_claim_signer_set(arg3);
    }

    public fun set_protocol_fee_share(arg0: &mut RuntimeConfig, arg1: &0x79a1b44c551613cbc63cc0406f8ff8d717407378dd6f17d43d9e1b3fd63a573::blast_fun::PackageVersion, arg2: &0x4a27d816998b2ff015cf897a249c069c34859a09e789e56ad3a38992cf00d7ac::blast_acl::AdminWitness<0x79a1b44c551613cbc63cc0406f8ff8d717407378dd6f17d43d9e1b3fd63a573::blast_fun_domain::FeeAdmin>, arg3: 0x79a1b44c551613cbc63cc0406f8ff8d717407378dd6f17d43d9e1b3fd63a573::bps::Bps) {
        0x79a1b44c551613cbc63cc0406f8ff8d717407378dd6f17d43d9e1b3fd63a573::blast_fun::assert_current(arg1);
        assert!(arg3 != arg0.protocol_fee_share_bps, 23);
        arg0.protocol_fee_share_bps = arg3;
        0x79a1b44c551613cbc63cc0406f8ff8d717407378dd6f17d43d9e1b3fd63a573::events::protocol_fee_share_changed(0x79a1b44c551613cbc63cc0406f8ff8d717407378dd6f17d43d9e1b3fd63a573::bps::value(arg3));
    }

    public fun set_treasury(arg0: &mut RuntimeConfig, arg1: &0x79a1b44c551613cbc63cc0406f8ff8d717407378dd6f17d43d9e1b3fd63a573::blast_fun::PackageVersion, arg2: &0x4a27d816998b2ff015cf897a249c069c34859a09e789e56ad3a38992cf00d7ac::blast_acl::AdminWitness<0x79a1b44c551613cbc63cc0406f8ff8d717407378dd6f17d43d9e1b3fd63a573::blast_fun_domain::TreasuryAdmin>, arg3: address) {
        0x79a1b44c551613cbc63cc0406f8ff8d717407378dd6f17d43d9e1b3fd63a573::blast_fun::assert_current(arg1);
        assert!(arg3 != @0x0, 6);
        assert!(arg3 != arg0.treasury, 23);
        arg0.treasury = arg3;
        0x79a1b44c551613cbc63cc0406f8ff8d717407378dd6f17d43d9e1b3fd63a573::events::treasury_changed(arg3);
    }

    public(friend) fun treasury(arg0: &RuntimeConfig) : address {
        arg0.treasury
    }

    // decompiled from Move bytecode v7
}

