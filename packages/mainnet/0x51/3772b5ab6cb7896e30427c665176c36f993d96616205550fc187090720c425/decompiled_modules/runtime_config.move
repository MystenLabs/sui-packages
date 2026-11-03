module 0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::runtime_config {
    struct RuntimeConfig has key {
        id: 0x2::object::UID,
        creator_claim_signer_public_key: vector<u8>,
        protocol_fee_share_bps: 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::Delayed<0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::bps::Bps>,
        treasury: 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::Delayed<address>,
    }

    fun new(arg0: &mut 0x2::tx_context::TxContext) : RuntimeConfig {
        RuntimeConfig{
            id                              : 0x2::object::new(arg0),
            creator_claim_signer_public_key : b"",
            protocol_fee_share_bps          : 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::new<0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::bps::Bps>(0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::bps::new(5000), 0),
            treasury                        : 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::new<address>(@0x52ecee5e58e2f3a7461cc604f4efcc3b68031e4715456d821e3a2719b0593600, 0),
        }
    }

    public fun apply_protocol_fee_share(arg0: &mut RuntimeConfig, arg1: &0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::blast_fun::PackageVersion, arg2: &0x2::clock::Clock) {
        0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::blast_fun::assert_current(arg1);
        0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::events::protocol_fee_share_changed(0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::bps::value(0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::apply<0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::bps::Bps>(&mut arg0.protocol_fee_share_bps, arg2)));
    }

    public fun apply_treasury(arg0: &mut RuntimeConfig, arg1: &0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::blast_fun::PackageVersion, arg2: &0x2::clock::Clock) {
        0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::blast_fun::assert_current(arg1);
        0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::events::treasury_changed(0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::apply<address>(&mut arg0.treasury, arg2));
    }

    public fun cancel_protocol_fee_share(arg0: &mut RuntimeConfig, arg1: &0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::blast_fun::PackageVersion, arg2: &0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::blast_acl::AdminWitness<0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::blast_fun_domain::CancelAdmin>) {
        0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::blast_fun::assert_current(arg1);
        0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::events::protocol_fee_share_cancelled(0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::bps::value(0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::cancel<0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::bps::Bps>(&mut arg0.protocol_fee_share_bps)));
    }

    public fun cancel_treasury(arg0: &mut RuntimeConfig, arg1: &0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::blast_fun::PackageVersion, arg2: &0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::blast_acl::AdminWitness<0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::blast_fun_domain::CancelAdmin>) {
        0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::blast_fun::assert_current(arg1);
        0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::events::treasury_cancelled(0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::cancel<address>(&mut arg0.treasury));
    }

    public(friend) fun creator_claim_signer(arg0: &RuntimeConfig) : &vector<u8> {
        &arg0.creator_claim_signer_public_key
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<RuntimeConfig>(new(arg0));
    }

    public(friend) fun protocol_fee_share(arg0: &RuntimeConfig) : 0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::bps::Bps {
        0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::value<0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::bps::Bps>(&arg0.protocol_fee_share_bps)
    }

    public fun revoke_creator_claim_signer(arg0: &mut RuntimeConfig, arg1: &0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::blast_fun::PackageVersion, arg2: &0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::blast_acl::AdminWitness<0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::blast_fun_domain::ClaimSignerAdmin>) {
        0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::blast_fun::assert_current(arg1);
        assert!(!0x1::vector::is_empty<u8>(&arg0.creator_claim_signer_public_key), 23);
        arg0.creator_claim_signer_public_key = b"";
        0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::events::creator_claim_signer_set(b"");
    }

    public fun schedule_protocol_fee_share(arg0: &mut RuntimeConfig, arg1: &0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::blast_fun::PackageVersion, arg2: &0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::blast_acl::AdminWitness<0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::blast_fun_domain::FeeAdmin>, arg3: 0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::bps::Bps, arg4: u64, arg5: &0x2::clock::Clock) {
        0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::blast_fun::assert_current(arg1);
        assert!(arg3 != 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::value<0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::bps::Bps>(&arg0.protocol_fee_share_bps) || arg4 != 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::delay_ms<0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::bps::Bps>(&arg0.protocol_fee_share_bps), 23);
        0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::events::protocol_fee_share_scheduled(0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::bps::value(arg3), 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::schedule<0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::bps::Bps>(&mut arg0.protocol_fee_share_bps, arg3, arg4, arg5), arg4);
    }

    public fun schedule_treasury(arg0: &mut RuntimeConfig, arg1: &0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::blast_fun::PackageVersion, arg2: &0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::blast_acl::AdminWitness<0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::blast_fun_domain::TreasuryAdmin>, arg3: address, arg4: u64, arg5: &0x2::clock::Clock) {
        0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::blast_fun::assert_current(arg1);
        assert!(arg3 != @0x0, 6);
        assert!(arg3 != 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::value<address>(&arg0.treasury) || arg4 != 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::delay_ms<address>(&arg0.treasury), 23);
        0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::events::treasury_scheduled(arg3, 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::schedule<address>(&mut arg0.treasury, arg3, arg4, arg5), arg4);
    }

    public fun set_creator_claim_signer(arg0: &mut RuntimeConfig, arg1: &0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::blast_fun::PackageVersion, arg2: &0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::blast_acl::AdminWitness<0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::blast_fun_domain::ClaimSignerAdmin>, arg3: vector<u8>) {
        0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::blast_fun::assert_current(arg1);
        assert!(0x1::vector::length<u8>(&arg3) == 32, 27);
        assert!(arg3 != arg0.creator_claim_signer_public_key, 23);
        arg0.creator_claim_signer_public_key = arg3;
        0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::events::creator_claim_signer_set(arg3);
    }

    public(friend) fun treasury(arg0: &RuntimeConfig) : address {
        0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::value<address>(&arg0.treasury)
    }

    // decompiled from Move bytecode v7
}

