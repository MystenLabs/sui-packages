module 0xafbd425a6668d9a26d7b3dc668232d779d76b2f719e2f4178a51fd41078d69c3::fee_policy {
    struct FeePolicy has key {
        id: 0x2::object::UID,
        destination: address,
        fees: ProtocolFees,
    }

    struct ProtocolFees has copy, drop, store {
        raise_bps: 0xafbd425a6668d9a26d7b3dc668232d779d76b2f719e2f4178a51fd41078d69c3::bps::Bps,
        token_bps: 0xafbd425a6668d9a26d7b3dc668232d779d76b2f719e2f4178a51fd41078d69c3::bps::Bps,
        lp_fee_meme_bps: 0xafbd425a6668d9a26d7b3dc668232d779d76b2f719e2f4178a51fd41078d69c3::bps::Bps,
        lp_fee_quote_bps: 0xafbd425a6668d9a26d7b3dc668232d779d76b2f719e2f4178a51fd41078d69c3::bps::Bps,
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

    fun new(arg0: &mut 0x2::tx_context::TxContext) : FeePolicy {
        let v0 = ProtocolFees{
            raise_bps        : 0xafbd425a6668d9a26d7b3dc668232d779d76b2f719e2f4178a51fd41078d69c3::bps::new(0),
            token_bps        : 0xafbd425a6668d9a26d7b3dc668232d779d76b2f719e2f4178a51fd41078d69c3::bps::new(0),
            lp_fee_meme_bps  : 0xafbd425a6668d9a26d7b3dc668232d779d76b2f719e2f4178a51fd41078d69c3::bps::new(0),
            lp_fee_quote_bps : 0xafbd425a6668d9a26d7b3dc668232d779d76b2f719e2f4178a51fd41078d69c3::bps::new(0),
        };
        FeePolicy{
            id          : 0x2::object::new(arg0),
            destination : 0x2::tx_context::sender(arg0),
            fees        : v0,
        }
    }

    public(friend) fun destination(arg0: &FeePolicy) : address {
        arg0.destination
    }

    public(friend) fun fees(arg0: &FeePolicy) : ProtocolFees {
        arg0.fees
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<FeePolicy>(new(arg0));
    }

    public(friend) fun lp_fee_meme_bps(arg0: &ProtocolFees) : 0xafbd425a6668d9a26d7b3dc668232d779d76b2f719e2f4178a51fd41078d69c3::bps::Bps {
        arg0.lp_fee_meme_bps
    }

    public(friend) fun lp_fee_quote_bps(arg0: &ProtocolFees) : 0xafbd425a6668d9a26d7b3dc668232d779d76b2f719e2f4178a51fd41078d69c3::bps::Bps {
        arg0.lp_fee_quote_bps
    }

    public(friend) fun protocol_fees(arg0: 0xafbd425a6668d9a26d7b3dc668232d779d76b2f719e2f4178a51fd41078d69c3::bps::Bps, arg1: 0xafbd425a6668d9a26d7b3dc668232d779d76b2f719e2f4178a51fd41078d69c3::bps::Bps, arg2: 0xafbd425a6668d9a26d7b3dc668232d779d76b2f719e2f4178a51fd41078d69c3::bps::Bps, arg3: 0xafbd425a6668d9a26d7b3dc668232d779d76b2f719e2f4178a51fd41078d69c3::bps::Bps) : ProtocolFees {
        assert!(0xafbd425a6668d9a26d7b3dc668232d779d76b2f719e2f4178a51fd41078d69c3::bps::value(arg0) < 0xafbd425a6668d9a26d7b3dc668232d779d76b2f719e2f4178a51fd41078d69c3::bps::denominator() && 0xafbd425a6668d9a26d7b3dc668232d779d76b2f719e2f4178a51fd41078d69c3::bps::value(arg1) <= 9998, 13835058441829285890);
        ProtocolFees{
            raise_bps        : arg0,
            token_bps        : arg1,
            lp_fee_meme_bps  : arg2,
            lp_fee_quote_bps : arg3,
        }
    }

    public(friend) fun raise_bps(arg0: &ProtocolFees) : 0xafbd425a6668d9a26d7b3dc668232d779d76b2f719e2f4178a51fd41078d69c3::bps::Bps {
        arg0.raise_bps
    }

    public fun set_destination(arg0: &mut FeePolicy, arg1: &0xafbd425a6668d9a26d7b3dc668232d779d76b2f719e2f4178a51fd41078d69c3::blast_presale_admin::AdminRegistry, arg2: &0xafbd425a6668d9a26d7b3dc668232d779d76b2f719e2f4178a51fd41078d69c3::blast_presale_admin::AdminCap, arg3: address) {
        0xafbd425a6668d9a26d7b3dc668232d779d76b2f719e2f4178a51fd41078d69c3::blast_presale_admin::assert_admin_cap(arg1, arg2);
        assert!(arg3 != @0x0 && arg3 != arg0.destination, 13835621310178590726);
        arg0.destination = arg3;
        let v0 = DestinationChanged{destination: arg3};
        0x2::event::emit<DestinationChanged>(v0);
    }

    public fun set_fees(arg0: &mut FeePolicy, arg1: &0xafbd425a6668d9a26d7b3dc668232d779d76b2f719e2f4178a51fd41078d69c3::blast_presale_admin::AdminRegistry, arg2: &0xafbd425a6668d9a26d7b3dc668232d779d76b2f719e2f4178a51fd41078d69c3::blast_presale_admin::AdminCap, arg3: 0xafbd425a6668d9a26d7b3dc668232d779d76b2f719e2f4178a51fd41078d69c3::bps::Bps, arg4: 0xafbd425a6668d9a26d7b3dc668232d779d76b2f719e2f4178a51fd41078d69c3::bps::Bps, arg5: 0xafbd425a6668d9a26d7b3dc668232d779d76b2f719e2f4178a51fd41078d69c3::bps::Bps, arg6: 0xafbd425a6668d9a26d7b3dc668232d779d76b2f719e2f4178a51fd41078d69c3::bps::Bps) {
        0xafbd425a6668d9a26d7b3dc668232d779d76b2f719e2f4178a51fd41078d69c3::blast_presale_admin::assert_admin_cap(arg1, arg2);
        let v0 = protocol_fees(arg3, arg4, arg5, arg6);
        assert!(v0 != arg0.fees, 13835339749302403076);
        arg0.fees = v0;
        let v1 = FeesChanged{
            raise_bps        : 0xafbd425a6668d9a26d7b3dc668232d779d76b2f719e2f4178a51fd41078d69c3::bps::value(arg3),
            token_bps        : 0xafbd425a6668d9a26d7b3dc668232d779d76b2f719e2f4178a51fd41078d69c3::bps::value(arg4),
            lp_fee_meme_bps  : 0xafbd425a6668d9a26d7b3dc668232d779d76b2f719e2f4178a51fd41078d69c3::bps::value(arg5),
            lp_fee_quote_bps : 0xafbd425a6668d9a26d7b3dc668232d779d76b2f719e2f4178a51fd41078d69c3::bps::value(arg6),
        };
        0x2::event::emit<FeesChanged>(v1);
    }

    public(friend) fun token_bps(arg0: &ProtocolFees) : 0xafbd425a6668d9a26d7b3dc668232d779d76b2f719e2f4178a51fd41078d69c3::bps::Bps {
        arg0.token_bps
    }

    public(friend) fun with_lp_fees(arg0: ProtocolFees, arg1: 0xafbd425a6668d9a26d7b3dc668232d779d76b2f719e2f4178a51fd41078d69c3::bps::Bps, arg2: 0xafbd425a6668d9a26d7b3dc668232d779d76b2f719e2f4178a51fd41078d69c3::bps::Bps) : ProtocolFees {
        arg0.lp_fee_meme_bps = arg1;
        arg0.lp_fee_quote_bps = arg2;
        arg0
    }

    // decompiled from Move bytecode v7
}

