module 0xaf88fcde57f11424ddaafabe8abe5985e94b23355b3f95ae96130d8db2f202ed::fee_policy {
    struct FeePolicy has key {
        id: 0x2::object::UID,
        destination: 0xbda3fdf4eb1abcba8224fd02da869ee92c109ac75fad3fd51800004c200a7949::delayed::Delayed<address>,
        fees: 0xbda3fdf4eb1abcba8224fd02da869ee92c109ac75fad3fd51800004c200a7949::delayed::Delayed<ProtocolFees>,
    }

    struct ProtocolFees has copy, drop, store {
        raise_bps: 0xaf88fcde57f11424ddaafabe8abe5985e94b23355b3f95ae96130d8db2f202ed::bps::Bps,
        token_bps: 0xaf88fcde57f11424ddaafabe8abe5985e94b23355b3f95ae96130d8db2f202ed::bps::Bps,
        lp_fee_meme_bps: 0xaf88fcde57f11424ddaafabe8abe5985e94b23355b3f95ae96130d8db2f202ed::bps::Bps,
        lp_fee_quote_bps: 0xaf88fcde57f11424ddaafabe8abe5985e94b23355b3f95ae96130d8db2f202ed::bps::Bps,
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
            destination : 0xbda3fdf4eb1abcba8224fd02da869ee92c109ac75fad3fd51800004c200a7949::delayed::new<address>(arg0, arg2),
            fees        : 0xbda3fdf4eb1abcba8224fd02da869ee92c109ac75fad3fd51800004c200a7949::delayed::new<ProtocolFees>(arg1, arg2),
        }
    }

    public fun apply_destination(arg0: &mut FeePolicy, arg1: &0xaf88fcde57f11424ddaafabe8abe5985e94b23355b3f95ae96130d8db2f202ed::blast_presale_package::PackageVersion, arg2: &0x2::clock::Clock) {
        0xaf88fcde57f11424ddaafabe8abe5985e94b23355b3f95ae96130d8db2f202ed::blast_presale_package::assert_current(arg1);
        let v0 = DestinationChanged{destination: 0xbda3fdf4eb1abcba8224fd02da869ee92c109ac75fad3fd51800004c200a7949::delayed::apply<address>(&mut arg0.destination, arg2)};
        0x2::event::emit<DestinationChanged>(v0);
    }

    public fun apply_fees(arg0: &mut FeePolicy, arg1: &0xaf88fcde57f11424ddaafabe8abe5985e94b23355b3f95ae96130d8db2f202ed::blast_presale_package::PackageVersion, arg2: &0x2::clock::Clock) {
        0xaf88fcde57f11424ddaafabe8abe5985e94b23355b3f95ae96130d8db2f202ed::blast_presale_package::assert_current(arg1);
        let v0 = 0xbda3fdf4eb1abcba8224fd02da869ee92c109ac75fad3fd51800004c200a7949::delayed::apply<ProtocolFees>(&mut arg0.fees, arg2);
        let v1 = FeesChanged{
            raise_bps        : 0xaf88fcde57f11424ddaafabe8abe5985e94b23355b3f95ae96130d8db2f202ed::bps::value(v0.raise_bps),
            token_bps        : 0xaf88fcde57f11424ddaafabe8abe5985e94b23355b3f95ae96130d8db2f202ed::bps::value(v0.token_bps),
            lp_fee_meme_bps  : 0xaf88fcde57f11424ddaafabe8abe5985e94b23355b3f95ae96130d8db2f202ed::bps::value(v0.lp_fee_meme_bps),
            lp_fee_quote_bps : 0xaf88fcde57f11424ddaafabe8abe5985e94b23355b3f95ae96130d8db2f202ed::bps::value(v0.lp_fee_quote_bps),
        };
        0x2::event::emit<FeesChanged>(v1);
    }

    public fun cancel_destination(arg0: &mut FeePolicy, arg1: &0xaf88fcde57f11424ddaafabe8abe5985e94b23355b3f95ae96130d8db2f202ed::blast_presale_package::PackageVersion, arg2: &0xbda3fdf4eb1abcba8224fd02da869ee92c109ac75fad3fd51800004c200a7949::blast_acl::AdminWitness<0xaf88fcde57f11424ddaafabe8abe5985e94b23355b3f95ae96130d8db2f202ed::blast_presale_domain::CancelAdmin>) {
        0xaf88fcde57f11424ddaafabe8abe5985e94b23355b3f95ae96130d8db2f202ed::blast_presale_package::assert_current(arg1);
        let v0 = DestinationCancelled{destination: 0xbda3fdf4eb1abcba8224fd02da869ee92c109ac75fad3fd51800004c200a7949::delayed::cancel<address>(&mut arg0.destination)};
        0x2::event::emit<DestinationCancelled>(v0);
    }

    public fun cancel_fees(arg0: &mut FeePolicy, arg1: &0xaf88fcde57f11424ddaafabe8abe5985e94b23355b3f95ae96130d8db2f202ed::blast_presale_package::PackageVersion, arg2: &0xbda3fdf4eb1abcba8224fd02da869ee92c109ac75fad3fd51800004c200a7949::blast_acl::AdminWitness<0xaf88fcde57f11424ddaafabe8abe5985e94b23355b3f95ae96130d8db2f202ed::blast_presale_domain::CancelAdmin>) {
        0xaf88fcde57f11424ddaafabe8abe5985e94b23355b3f95ae96130d8db2f202ed::blast_presale_package::assert_current(arg1);
        let v0 = 0xbda3fdf4eb1abcba8224fd02da869ee92c109ac75fad3fd51800004c200a7949::delayed::cancel<ProtocolFees>(&mut arg0.fees);
        let v1 = FeesCancelled{
            raise_bps        : 0xaf88fcde57f11424ddaafabe8abe5985e94b23355b3f95ae96130d8db2f202ed::bps::value(v0.raise_bps),
            token_bps        : 0xaf88fcde57f11424ddaafabe8abe5985e94b23355b3f95ae96130d8db2f202ed::bps::value(v0.token_bps),
            lp_fee_meme_bps  : 0xaf88fcde57f11424ddaafabe8abe5985e94b23355b3f95ae96130d8db2f202ed::bps::value(v0.lp_fee_meme_bps),
            lp_fee_quote_bps : 0xaf88fcde57f11424ddaafabe8abe5985e94b23355b3f95ae96130d8db2f202ed::bps::value(v0.lp_fee_quote_bps),
        };
        0x2::event::emit<FeesCancelled>(v1);
    }

    public(friend) fun destination(arg0: &FeePolicy) : address {
        0xbda3fdf4eb1abcba8224fd02da869ee92c109ac75fad3fd51800004c200a7949::delayed::value<address>(&arg0.destination)
    }

    public(friend) fun fees(arg0: &FeePolicy) : ProtocolFees {
        0xbda3fdf4eb1abcba8224fd02da869ee92c109ac75fad3fd51800004c200a7949::delayed::value<ProtocolFees>(&arg0.fees)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<FeePolicy>(new(@0xffc747a45e5f9ed7355fc03261f84156d6fc3497a7b88295f63ea9129f69ca0a, protocol_fees(0xaf88fcde57f11424ddaafabe8abe5985e94b23355b3f95ae96130d8db2f202ed::bps::new(200), 0xaf88fcde57f11424ddaafabe8abe5985e94b23355b3f95ae96130d8db2f202ed::bps::new(100), 0xaf88fcde57f11424ddaafabe8abe5985e94b23355b3f95ae96130d8db2f202ed::bps::new(1500), 0xaf88fcde57f11424ddaafabe8abe5985e94b23355b3f95ae96130d8db2f202ed::bps::new(1500)), 0, arg0));
    }

    public(friend) fun lp_fee_meme_bps(arg0: &ProtocolFees) : 0xaf88fcde57f11424ddaafabe8abe5985e94b23355b3f95ae96130d8db2f202ed::bps::Bps {
        arg0.lp_fee_meme_bps
    }

    public(friend) fun lp_fee_quote_bps(arg0: &ProtocolFees) : 0xaf88fcde57f11424ddaafabe8abe5985e94b23355b3f95ae96130d8db2f202ed::bps::Bps {
        arg0.lp_fee_quote_bps
    }

    public(friend) fun protocol_fees(arg0: 0xaf88fcde57f11424ddaafabe8abe5985e94b23355b3f95ae96130d8db2f202ed::bps::Bps, arg1: 0xaf88fcde57f11424ddaafabe8abe5985e94b23355b3f95ae96130d8db2f202ed::bps::Bps, arg2: 0xaf88fcde57f11424ddaafabe8abe5985e94b23355b3f95ae96130d8db2f202ed::bps::Bps, arg3: 0xaf88fcde57f11424ddaafabe8abe5985e94b23355b3f95ae96130d8db2f202ed::bps::Bps) : ProtocolFees {
        assert!(0xaf88fcde57f11424ddaafabe8abe5985e94b23355b3f95ae96130d8db2f202ed::bps::value(arg0) < 0xaf88fcde57f11424ddaafabe8abe5985e94b23355b3f95ae96130d8db2f202ed::bps::denominator() && 0xaf88fcde57f11424ddaafabe8abe5985e94b23355b3f95ae96130d8db2f202ed::bps::value(arg1) <= 9998, 13835058841261244418);
        ProtocolFees{
            raise_bps        : arg0,
            token_bps        : arg1,
            lp_fee_meme_bps  : arg2,
            lp_fee_quote_bps : arg3,
        }
    }

    public(friend) fun raise_bps(arg0: &ProtocolFees) : 0xaf88fcde57f11424ddaafabe8abe5985e94b23355b3f95ae96130d8db2f202ed::bps::Bps {
        arg0.raise_bps
    }

    public fun schedule_destination(arg0: &mut FeePolicy, arg1: &0xaf88fcde57f11424ddaafabe8abe5985e94b23355b3f95ae96130d8db2f202ed::blast_presale_package::PackageVersion, arg2: &0xbda3fdf4eb1abcba8224fd02da869ee92c109ac75fad3fd51800004c200a7949::blast_acl::AdminWitness<0xaf88fcde57f11424ddaafabe8abe5985e94b23355b3f95ae96130d8db2f202ed::blast_presale_domain::TreasuryAdmin>, arg3: address, arg4: u64, arg5: &0x2::clock::Clock) {
        0xaf88fcde57f11424ddaafabe8abe5985e94b23355b3f95ae96130d8db2f202ed::blast_presale_package::assert_current(arg1);
        assert!(arg3 != @0x0, 13835621563581661190);
        assert!(arg3 != 0xbda3fdf4eb1abcba8224fd02da869ee92c109ac75fad3fd51800004c200a7949::delayed::value<address>(&arg0.destination) || arg4 != 0xbda3fdf4eb1abcba8224fd02da869ee92c109ac75fad3fd51800004c200a7949::delayed::delay_ms<address>(&arg0.destination), 13835621585056497670);
        let v0 = DestinationScheduled{
            destination : arg3,
            ready_at_ms : 0xbda3fdf4eb1abcba8224fd02da869ee92c109ac75fad3fd51800004c200a7949::delayed::schedule<address>(&mut arg0.destination, arg3, arg4, arg5),
            delay_ms    : arg4,
        };
        0x2::event::emit<DestinationScheduled>(v0);
    }

    public fun schedule_fees(arg0: &mut FeePolicy, arg1: &0xaf88fcde57f11424ddaafabe8abe5985e94b23355b3f95ae96130d8db2f202ed::blast_presale_package::PackageVersion, arg2: &0xbda3fdf4eb1abcba8224fd02da869ee92c109ac75fad3fd51800004c200a7949::blast_acl::AdminWitness<0xaf88fcde57f11424ddaafabe8abe5985e94b23355b3f95ae96130d8db2f202ed::blast_presale_domain::FeeAdmin>, arg3: 0xaf88fcde57f11424ddaafabe8abe5985e94b23355b3f95ae96130d8db2f202ed::bps::Bps, arg4: 0xaf88fcde57f11424ddaafabe8abe5985e94b23355b3f95ae96130d8db2f202ed::bps::Bps, arg5: 0xaf88fcde57f11424ddaafabe8abe5985e94b23355b3f95ae96130d8db2f202ed::bps::Bps, arg6: 0xaf88fcde57f11424ddaafabe8abe5985e94b23355b3f95ae96130d8db2f202ed::bps::Bps, arg7: u64, arg8: &0x2::clock::Clock) {
        0xaf88fcde57f11424ddaafabe8abe5985e94b23355b3f95ae96130d8db2f202ed::blast_presale_package::assert_current(arg1);
        let v0 = protocol_fees(arg3, arg4, arg5, arg6);
        assert!(v0 != 0xbda3fdf4eb1abcba8224fd02da869ee92c109ac75fad3fd51800004c200a7949::delayed::value<ProtocolFees>(&arg0.fees) || arg7 != 0xbda3fdf4eb1abcba8224fd02da869ee92c109ac75fad3fd51800004c200a7949::delayed::delay_ms<ProtocolFees>(&arg0.fees), 13835339787957108740);
        let v1 = FeesScheduled{
            raise_bps        : 0xaf88fcde57f11424ddaafabe8abe5985e94b23355b3f95ae96130d8db2f202ed::bps::value(arg3),
            token_bps        : 0xaf88fcde57f11424ddaafabe8abe5985e94b23355b3f95ae96130d8db2f202ed::bps::value(arg4),
            lp_fee_meme_bps  : 0xaf88fcde57f11424ddaafabe8abe5985e94b23355b3f95ae96130d8db2f202ed::bps::value(arg5),
            lp_fee_quote_bps : 0xaf88fcde57f11424ddaafabe8abe5985e94b23355b3f95ae96130d8db2f202ed::bps::value(arg6),
            ready_at_ms      : 0xbda3fdf4eb1abcba8224fd02da869ee92c109ac75fad3fd51800004c200a7949::delayed::schedule<ProtocolFees>(&mut arg0.fees, v0, arg7, arg8),
            delay_ms         : arg7,
        };
        0x2::event::emit<FeesScheduled>(v1);
    }

    public(friend) fun token_bps(arg0: &ProtocolFees) : 0xaf88fcde57f11424ddaafabe8abe5985e94b23355b3f95ae96130d8db2f202ed::bps::Bps {
        arg0.token_bps
    }

    public(friend) fun with_lp_fees(arg0: ProtocolFees, arg1: 0xaf88fcde57f11424ddaafabe8abe5985e94b23355b3f95ae96130d8db2f202ed::bps::Bps, arg2: 0xaf88fcde57f11424ddaafabe8abe5985e94b23355b3f95ae96130d8db2f202ed::bps::Bps) : ProtocolFees {
        arg0.lp_fee_meme_bps = arg1;
        arg0.lp_fee_quote_bps = arg2;
        arg0
    }

    // decompiled from Move bytecode v7
}

