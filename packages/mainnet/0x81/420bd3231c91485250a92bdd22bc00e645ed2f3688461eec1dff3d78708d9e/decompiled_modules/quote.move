module 0x81420bd3231c91485250a92bdd22bc00e645ed2f3688461eec1dff3d78708d9e::quote {
    struct SwapQuote has copy, drop, store {
        amount_in: u64,
        amount_out: u64,
        output_fees: SwapFee,
        a2b: bool,
    }

    struct SwapFee has copy, drop, store {
        protocol_fees: u64,
        pool_fees: u64,
    }

    struct DepositQuote has copy, drop, store {
        initial_deposit: bool,
        deposit_a: u64,
        deposit_b: u64,
        mint_lp: u64,
    }

    struct RedeemQuote has copy, drop, store {
        withdraw_a: u64,
        withdraw_b: u64,
        burn_lp: u64,
    }

    public(friend) fun quote(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: bool) : SwapQuote {
        let v0 = SwapFee{
            protocol_fees : arg2,
            pool_fees     : arg3,
        };
        SwapQuote{
            amount_in   : arg0,
            amount_out  : arg1,
            output_fees : v0,
            a2b         : arg4,
        }
    }

    public fun a2b(arg0: &SwapQuote) : bool {
        arg0.a2b
    }

    public(friend) fun add_extra_fees(arg0: &mut SwapQuote, arg1: u64, arg2: u64) {
        arg0.output_fees.protocol_fees = arg0.output_fees.protocol_fees + arg1;
        arg0.output_fees.pool_fees = arg0.output_fees.pool_fees + arg2;
    }

    public fun amount_in(arg0: &SwapQuote) : u64 {
        arg0.amount_in
    }

    public fun amount_out(arg0: &SwapQuote) : u64 {
        arg0.amount_out
    }

    public fun amount_out_net(arg0: &SwapQuote) : u64 {
        arg0.amount_out - arg0.output_fees.protocol_fees - arg0.output_fees.pool_fees
    }

    public fun amount_out_net_of_pool_fees(arg0: &SwapQuote) : u64 {
        arg0.amount_out - arg0.output_fees.pool_fees
    }

    public fun amount_out_net_of_protocol_fees(arg0: &SwapQuote) : u64 {
        arg0.amount_out - arg0.output_fees.protocol_fees
    }

    public fun burn_lp(arg0: &RedeemQuote) : u64 {
        arg0.burn_lp
    }

    public fun deposit_a(arg0: &DepositQuote) : u64 {
        arg0.deposit_a
    }

    public fun deposit_b(arg0: &DepositQuote) : u64 {
        arg0.deposit_b
    }

    public(friend) fun deposit_quote(arg0: bool, arg1: u64, arg2: u64, arg3: u64) : DepositQuote {
        DepositQuote{
            initial_deposit : arg0,
            deposit_a       : arg1,
            deposit_b       : arg2,
            mint_lp         : arg3,
        }
    }

    public fun initial_deposit(arg0: &DepositQuote) : bool {
        arg0.initial_deposit
    }

    public fun mint_lp(arg0: &DepositQuote) : u64 {
        arg0.mint_lp
    }

    public fun output_fees(arg0: &SwapQuote) : &SwapFee {
        &arg0.output_fees
    }

    public fun pool_fees(arg0: &SwapFee) : u64 {
        arg0.pool_fees
    }

    public fun protocol_fees(arg0: &SwapFee) : u64 {
        arg0.protocol_fees
    }

    public(friend) fun redeem_quote(arg0: u64, arg1: u64, arg2: u64) : RedeemQuote {
        RedeemQuote{
            withdraw_a : arg0,
            withdraw_b : arg1,
            burn_lp    : arg2,
        }
    }

    public fun withdraw_a(arg0: &RedeemQuote) : u64 {
        arg0.withdraw_a
    }

    public fun withdraw_b(arg0: &RedeemQuote) : u64 {
        arg0.withdraw_b
    }

    // decompiled from Move bytecode v6
}

