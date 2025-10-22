module 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::collateral_exchange {
    public(friend) fun collateral_to_liquidity(arg0: 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::decimal::Decimal, arg1: 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::decimal::Decimal) : u64 {
        0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::decimal::floor(collateral_to_liquidity_decimal(arg0, arg1))
    }

    public(friend) fun collateral_to_liquidity_decimal(arg0: 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::decimal::Decimal, arg1: 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::decimal::Decimal) : 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::decimal::Decimal {
        0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::decimal::div(arg0, arg1)
    }

    public(friend) fun liquidity_to_collateral(arg0: 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::decimal::Decimal, arg1: 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::decimal::Decimal) : u64 {
        0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::decimal::floor(liquidity_to_collateral_decimal(arg0, arg1))
    }

    public(friend) fun liquidity_to_collateral_decimal(arg0: 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::decimal::Decimal, arg1: 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::decimal::Decimal) : 0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::decimal::Decimal {
        0x2e3fd69ee38edee6962faefe19b562b1fed3568da49274d331df02a7ab0b249d::decimal::mul(arg1, arg0)
    }

    // decompiled from Move bytecode v6
}

