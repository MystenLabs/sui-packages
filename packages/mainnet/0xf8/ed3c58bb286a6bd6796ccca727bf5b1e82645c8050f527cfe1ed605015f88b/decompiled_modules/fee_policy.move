module 0xf8ed3c58bb286a6bd6796ccca727bf5b1e82645c8050f527cfe1ed605015f88b::fee_policy {
    struct FeePolicy has key {
        id: 0x2::object::UID,
        destination: 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::Delayed<address>,
        fees: 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::Delayed<ProtocolFees>,
    }

    struct ProtocolFees has copy, drop, store {
        raise_bps: 0xf8ed3c58bb286a6bd6796ccca727bf5b1e82645c8050f527cfe1ed605015f88b::bps::Bps,
        token_bps: 0xf8ed3c58bb286a6bd6796ccca727bf5b1e82645c8050f527cfe1ed605015f88b::bps::Bps,
        lp_fee_meme_bps: 0xf8ed3c58bb286a6bd6796ccca727bf5b1e82645c8050f527cfe1ed605015f88b::bps::Bps,
        lp_fee_quote_bps: 0xf8ed3c58bb286a6bd6796ccca727bf5b1e82645c8050f527cfe1ed605015f88b::bps::Bps,
    }

    struct DestinationScheduled has copy, drop {
        destination: address,
        ready_at_ms: u64,
        delay_ms: u64,
    }

    struct DestinationCancelled has copy, drop {
        destination: address,
    }

    struct FeesScheduled has copy, drop {
        raise_bps: u64,
        token_bps: u64,
        lp_fee_meme_bps: u64,
        lp_fee_quote_bps: u64,
        ready_at_ms: u64,
        delay_ms: u64,
    }

    struct FeesCancelled has copy, drop {
        raise_bps: u64,
        token_bps: u64,
        lp_fee_meme_bps: u64,
        lp_fee_quote_bps: u64,
    }

    struct FeesChanged has copy, drop {
        raise_bps: u64,
        token_bps: u64,
        lp_fee_meme_bps: u64,
        lp_fee_quote_bps: u64,
    }

    struct DestinationChanged has copy, drop {
        destination: address,
    }

    fun new(arg0: address, arg1: ProtocolFees, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : FeePolicy {
        FeePolicy{
            id          : 0x2::object::new(arg3),
            destination : 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::new<address>(arg0, arg2),
            fees        : 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::new<ProtocolFees>(arg1, arg2),
        }
    }

    public fun apply_destination(arg0: &mut FeePolicy, arg1: &0xf8ed3c58bb286a6bd6796ccca727bf5b1e82645c8050f527cfe1ed605015f88b::blast_presale_package::PackageVersion, arg2: &0x2::clock::Clock) {
        0xf8ed3c58bb286a6bd6796ccca727bf5b1e82645c8050f527cfe1ed605015f88b::blast_presale_package::assert_current(arg1);
        let v0 = DestinationChanged{destination: 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::apply<address>(&mut arg0.destination, arg2)};
        0x2::event::emit<DestinationChanged>(v0);
    }

    public fun apply_fees(arg0: &mut FeePolicy, arg1: &0xf8ed3c58bb286a6bd6796ccca727bf5b1e82645c8050f527cfe1ed605015f88b::blast_presale_package::PackageVersion, arg2: &0x2::clock::Clock) {
        0xf8ed3c58bb286a6bd6796ccca727bf5b1e82645c8050f527cfe1ed605015f88b::blast_presale_package::assert_current(arg1);
        let v0 = 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::apply<ProtocolFees>(&mut arg0.fees, arg2);
        let v1 = FeesChanged{
            raise_bps        : 0xf8ed3c58bb286a6bd6796ccca727bf5b1e82645c8050f527cfe1ed605015f88b::bps::value(v0.raise_bps),
            token_bps        : 0xf8ed3c58bb286a6bd6796ccca727bf5b1e82645c8050f527cfe1ed605015f88b::bps::value(v0.token_bps),
            lp_fee_meme_bps  : 0xf8ed3c58bb286a6bd6796ccca727bf5b1e82645c8050f527cfe1ed605015f88b::bps::value(v0.lp_fee_meme_bps),
            lp_fee_quote_bps : 0xf8ed3c58bb286a6bd6796ccca727bf5b1e82645c8050f527cfe1ed605015f88b::bps::value(v0.lp_fee_quote_bps),
        };
        0x2::event::emit<FeesChanged>(v1);
    }

    public fun cancel_destination(arg0: &mut FeePolicy, arg1: &0xf8ed3c58bb286a6bd6796ccca727bf5b1e82645c8050f527cfe1ed605015f88b::blast_presale_package::PackageVersion, arg2: &0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::blast_acl::AdminWitness<0xf8ed3c58bb286a6bd6796ccca727bf5b1e82645c8050f527cfe1ed605015f88b::blast_presale_domain::CancelAdmin>) {
        0xf8ed3c58bb286a6bd6796ccca727bf5b1e82645c8050f527cfe1ed605015f88b::blast_presale_package::assert_current(arg1);
        let v0 = DestinationCancelled{destination: 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::cancel<address>(&mut arg0.destination)};
        0x2::event::emit<DestinationCancelled>(v0);
    }

    public fun cancel_fees(arg0: &mut FeePolicy, arg1: &0xf8ed3c58bb286a6bd6796ccca727bf5b1e82645c8050f527cfe1ed605015f88b::blast_presale_package::PackageVersion, arg2: &0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::blast_acl::AdminWitness<0xf8ed3c58bb286a6bd6796ccca727bf5b1e82645c8050f527cfe1ed605015f88b::blast_presale_domain::CancelAdmin>) {
        0xf8ed3c58bb286a6bd6796ccca727bf5b1e82645c8050f527cfe1ed605015f88b::blast_presale_package::assert_current(arg1);
        let v0 = 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::cancel<ProtocolFees>(&mut arg0.fees);
        let v1 = FeesCancelled{
            raise_bps        : 0xf8ed3c58bb286a6bd6796ccca727bf5b1e82645c8050f527cfe1ed605015f88b::bps::value(v0.raise_bps),
            token_bps        : 0xf8ed3c58bb286a6bd6796ccca727bf5b1e82645c8050f527cfe1ed605015f88b::bps::value(v0.token_bps),
            lp_fee_meme_bps  : 0xf8ed3c58bb286a6bd6796ccca727bf5b1e82645c8050f527cfe1ed605015f88b::bps::value(v0.lp_fee_meme_bps),
            lp_fee_quote_bps : 0xf8ed3c58bb286a6bd6796ccca727bf5b1e82645c8050f527cfe1ed605015f88b::bps::value(v0.lp_fee_quote_bps),
        };
        0x2::event::emit<FeesCancelled>(v1);
    }

    public(friend) fun destination(arg0: &FeePolicy) : address {
        0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::value<address>(&arg0.destination)
    }

    public(friend) fun fees(arg0: &FeePolicy) : ProtocolFees {
        0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::value<ProtocolFees>(&arg0.fees)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<FeePolicy>(new(@0x52ecee5e58e2f3a7461cc604f4efcc3b68031e4715456d821e3a2719b0593600, protocol_fees(0xf8ed3c58bb286a6bd6796ccca727bf5b1e82645c8050f527cfe1ed605015f88b::bps::new(200), 0xf8ed3c58bb286a6bd6796ccca727bf5b1e82645c8050f527cfe1ed605015f88b::bps::new(100), 0xf8ed3c58bb286a6bd6796ccca727bf5b1e82645c8050f527cfe1ed605015f88b::bps::new(1500), 0xf8ed3c58bb286a6bd6796ccca727bf5b1e82645c8050f527cfe1ed605015f88b::bps::new(1500)), 0, arg0));
    }

    public(friend) fun lp_fee_meme_bps(arg0: &ProtocolFees) : 0xf8ed3c58bb286a6bd6796ccca727bf5b1e82645c8050f527cfe1ed605015f88b::bps::Bps {
        arg0.lp_fee_meme_bps
    }

    public(friend) fun lp_fee_quote_bps(arg0: &ProtocolFees) : 0xf8ed3c58bb286a6bd6796ccca727bf5b1e82645c8050f527cfe1ed605015f88b::bps::Bps {
        arg0.lp_fee_quote_bps
    }

    public(friend) fun protocol_fees(arg0: 0xf8ed3c58bb286a6bd6796ccca727bf5b1e82645c8050f527cfe1ed605015f88b::bps::Bps, arg1: 0xf8ed3c58bb286a6bd6796ccca727bf5b1e82645c8050f527cfe1ed605015f88b::bps::Bps, arg2: 0xf8ed3c58bb286a6bd6796ccca727bf5b1e82645c8050f527cfe1ed605015f88b::bps::Bps, arg3: 0xf8ed3c58bb286a6bd6796ccca727bf5b1e82645c8050f527cfe1ed605015f88b::bps::Bps) : ProtocolFees {
        assert!(0xf8ed3c58bb286a6bd6796ccca727bf5b1e82645c8050f527cfe1ed605015f88b::bps::value(arg0) < 0xf8ed3c58bb286a6bd6796ccca727bf5b1e82645c8050f527cfe1ed605015f88b::bps::denominator() && 0xf8ed3c58bb286a6bd6796ccca727bf5b1e82645c8050f527cfe1ed605015f88b::bps::value(arg1) <= 9998, 13835058841261244418);
        ProtocolFees{
            raise_bps        : arg0,
            token_bps        : arg1,
            lp_fee_meme_bps  : arg2,
            lp_fee_quote_bps : arg3,
        }
    }

    public(friend) fun raise_bps(arg0: &ProtocolFees) : 0xf8ed3c58bb286a6bd6796ccca727bf5b1e82645c8050f527cfe1ed605015f88b::bps::Bps {
        arg0.raise_bps
    }

    public fun schedule_destination(arg0: &mut FeePolicy, arg1: &0xf8ed3c58bb286a6bd6796ccca727bf5b1e82645c8050f527cfe1ed605015f88b::blast_presale_package::PackageVersion, arg2: &0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::blast_acl::AdminWitness<0xf8ed3c58bb286a6bd6796ccca727bf5b1e82645c8050f527cfe1ed605015f88b::blast_presale_domain::TreasuryAdmin>, arg3: address, arg4: u64, arg5: &0x2::clock::Clock) {
        0xf8ed3c58bb286a6bd6796ccca727bf5b1e82645c8050f527cfe1ed605015f88b::blast_presale_package::assert_current(arg1);
        assert!(arg3 != @0x0, 13835621563581661190);
        assert!(arg3 != 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::value<address>(&arg0.destination) || arg4 != 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::delay_ms<address>(&arg0.destination), 13835621585056497670);
        let v0 = DestinationScheduled{
            destination : arg3,
            ready_at_ms : 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::schedule<address>(&mut arg0.destination, arg3, arg4, arg5),
            delay_ms    : arg4,
        };
        0x2::event::emit<DestinationScheduled>(v0);
    }

    public fun schedule_fees(arg0: &mut FeePolicy, arg1: &0xf8ed3c58bb286a6bd6796ccca727bf5b1e82645c8050f527cfe1ed605015f88b::blast_presale_package::PackageVersion, arg2: &0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::blast_acl::AdminWitness<0xf8ed3c58bb286a6bd6796ccca727bf5b1e82645c8050f527cfe1ed605015f88b::blast_presale_domain::FeeAdmin>, arg3: 0xf8ed3c58bb286a6bd6796ccca727bf5b1e82645c8050f527cfe1ed605015f88b::bps::Bps, arg4: 0xf8ed3c58bb286a6bd6796ccca727bf5b1e82645c8050f527cfe1ed605015f88b::bps::Bps, arg5: 0xf8ed3c58bb286a6bd6796ccca727bf5b1e82645c8050f527cfe1ed605015f88b::bps::Bps, arg6: 0xf8ed3c58bb286a6bd6796ccca727bf5b1e82645c8050f527cfe1ed605015f88b::bps::Bps, arg7: u64, arg8: &0x2::clock::Clock) {
        0xf8ed3c58bb286a6bd6796ccca727bf5b1e82645c8050f527cfe1ed605015f88b::blast_presale_package::assert_current(arg1);
        let v0 = protocol_fees(arg3, arg4, arg5, arg6);
        assert!(v0 != 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::value<ProtocolFees>(&arg0.fees) || arg7 != 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::delay_ms<ProtocolFees>(&arg0.fees), 13835339787957108740);
        let v1 = FeesScheduled{
            raise_bps        : 0xf8ed3c58bb286a6bd6796ccca727bf5b1e82645c8050f527cfe1ed605015f88b::bps::value(arg3),
            token_bps        : 0xf8ed3c58bb286a6bd6796ccca727bf5b1e82645c8050f527cfe1ed605015f88b::bps::value(arg4),
            lp_fee_meme_bps  : 0xf8ed3c58bb286a6bd6796ccca727bf5b1e82645c8050f527cfe1ed605015f88b::bps::value(arg5),
            lp_fee_quote_bps : 0xf8ed3c58bb286a6bd6796ccca727bf5b1e82645c8050f527cfe1ed605015f88b::bps::value(arg6),
            ready_at_ms      : 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::schedule<ProtocolFees>(&mut arg0.fees, v0, arg7, arg8),
            delay_ms         : arg7,
        };
        0x2::event::emit<FeesScheduled>(v1);
    }

    public(friend) fun token_bps(arg0: &ProtocolFees) : 0xf8ed3c58bb286a6bd6796ccca727bf5b1e82645c8050f527cfe1ed605015f88b::bps::Bps {
        arg0.token_bps
    }

    public(friend) fun with_lp_fees(arg0: ProtocolFees, arg1: 0xf8ed3c58bb286a6bd6796ccca727bf5b1e82645c8050f527cfe1ed605015f88b::bps::Bps, arg2: 0xf8ed3c58bb286a6bd6796ccca727bf5b1e82645c8050f527cfe1ed605015f88b::bps::Bps) : ProtocolFees {
        arg0.lp_fee_meme_bps = arg1;
        arg0.lp_fee_quote_bps = arg2;
        arg0
    }

    // decompiled from Move bytecode v7
}

