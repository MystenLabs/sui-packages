module 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::collateral_exchange {
    public(friend) fun collateral_to_liquidity(arg0: 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::Decimal, arg1: 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::Decimal) : u64 {
        0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::floor(collateral_to_liquidity_decimal(arg0, arg1))
    }

    public(friend) fun collateral_to_liquidity_decimal(arg0: 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::Decimal, arg1: 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::Decimal) : 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::Decimal {
        0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::div(arg0, arg1)
    }

    public(friend) fun liquidity_to_collateral(arg0: 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::Decimal, arg1: 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::Decimal) : u64 {
        0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::floor(liquidity_to_collateral_decimal(arg0, arg1))
    }

    public(friend) fun liquidity_to_collateral_decimal(arg0: 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::Decimal, arg1: 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::Decimal) : 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::Decimal {
        0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::mul(arg1, arg0)
    }

    // decompiled from Move bytecode v6
}

