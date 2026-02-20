module 0xd1a6cf9d5a66fe91cdbcacba79fb7d9f10190df7b24716615370f11509855b21::query_types {
    struct AssetValuation has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        usd: 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal,
        price: 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal,
    }

    struct AssetBorrow has copy, drop {
        valuation: AssetValuation,
        borrow_index: 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal,
    }

    struct AssetDeposit has copy, drop {
        is_collateral: bool,
        valuation: AssetValuation,
        ctoken_amount: u64,
        exchange_rate: 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal,
    }

    public fun new_asset_borrow(arg0: 0x1::type_name::TypeName, arg1: u64, arg2: 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal, arg3: u8, arg4: 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal) : AssetBorrow {
        let v0 = AssetValuation{
            coin_type : arg0,
            amount    : arg1,
            usd       : 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::div_u64(0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::mul_u64(arg2, arg1), 0x1::u64::pow(10, arg3)),
            price     : arg2,
        };
        AssetBorrow{
            valuation    : v0,
            borrow_index : arg4,
        }
    }

    public fun new_asset_collateral_from_ctoken(arg0: 0x1::type_name::TypeName, arg1: u64, arg2: 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal, arg3: u8, arg4: 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal) : AssetDeposit {
        let v0 = 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::int_mul(arg4, arg1);
        let v1 = AssetValuation{
            coin_type : arg0,
            amount    : v0,
            usd       : 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::div_u64(0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::mul_u64(arg2, v0), 0x1::u64::pow(10, arg3)),
            price     : arg2,
        };
        AssetDeposit{
            is_collateral : true,
            valuation     : v1,
            ctoken_amount : arg1,
            exchange_rate : arg4,
        }
    }

    public fun new_asset_deposit(arg0: 0x1::type_name::TypeName, arg1: bool, arg2: u64, arg3: 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal, arg4: u8, arg5: 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::Decimal) : AssetDeposit {
        let v0 = AssetValuation{
            coin_type : arg0,
            amount    : arg2,
            usd       : 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::div_u64(0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::mul_u64(arg3, arg2), 0x1::u64::pow(10, arg4)),
            price     : arg3,
        };
        AssetDeposit{
            is_collateral : arg1,
            valuation     : v0,
            ctoken_amount : 0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::floor(0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::div(0x19a53942ca9b7cef4fbc820e0b06ebbf213e4853457ce8b7a5149ebcb4131766::float::from(arg2), arg5)),
            exchange_rate : arg5,
        }
    }

    // decompiled from Move bytecode v6
}

