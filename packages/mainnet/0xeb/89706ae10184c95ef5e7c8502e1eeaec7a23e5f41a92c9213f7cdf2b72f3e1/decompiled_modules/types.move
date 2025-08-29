module 0xeb89706ae10184c95ef5e7c8502e1eeaec7a23e5f41a92c9213f7cdf2b72f3e1::types {
    struct AssetValuation has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        usd: 0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::Decimal,
        price: 0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::Decimal,
    }

    struct AssetBorrow has copy, drop {
        valuation: AssetValuation,
        borrow_index: 0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::Decimal,
    }

    struct AssetDeposit has copy, drop {
        is_collateral: bool,
        valuation: AssetValuation,
        ctoken_amount: u64,
        exchange_rate: 0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::Decimal,
    }

    public fun new_asset_borrow(arg0: 0x1::type_name::TypeName, arg1: u64, arg2: 0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::Decimal, arg3: u8, arg4: 0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::Decimal) : AssetBorrow {
        let v0 = AssetValuation{
            coin_type : arg0,
            amount    : arg1,
            usd       : 0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::div_u64(0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::mul_u64(arg2, arg1), 0x1::u64::pow(10, arg3)),
            price     : arg2,
        };
        AssetBorrow{
            valuation    : v0,
            borrow_index : arg4,
        }
    }

    public fun new_asset_collateral_from_ctoken(arg0: 0x1::type_name::TypeName, arg1: u64, arg2: 0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::Decimal, arg3: u8, arg4: 0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::Decimal) : AssetDeposit {
        let v0 = 0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::int_mul(arg4, arg1);
        let v1 = AssetValuation{
            coin_type : arg0,
            amount    : v0,
            usd       : 0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::div_u64(0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::mul_u64(arg2, v0), 0x1::u64::pow(10, arg3)),
            price     : arg2,
        };
        AssetDeposit{
            is_collateral : true,
            valuation     : v1,
            ctoken_amount : arg1,
            exchange_rate : arg4,
        }
    }

    public fun new_asset_deposit(arg0: 0x1::type_name::TypeName, arg1: bool, arg2: u64, arg3: 0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::Decimal, arg4: u8, arg5: 0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::Decimal) : AssetDeposit {
        let v0 = AssetValuation{
            coin_type : arg0,
            amount    : arg2,
            usd       : 0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::div_u64(0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::mul_u64(arg3, arg2), 0x1::u64::pow(10, arg4)),
            price     : arg3,
        };
        AssetDeposit{
            is_collateral : arg1,
            valuation     : v0,
            ctoken_amount : 0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::floor(0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::div(0x684131467d610004df3734295dc4604132f8d2af79479874a3bc69a06b676aca::float::from(arg2), arg5)),
            exchange_rate : arg5,
        }
    }

    // decompiled from Move bytecode v6
}

