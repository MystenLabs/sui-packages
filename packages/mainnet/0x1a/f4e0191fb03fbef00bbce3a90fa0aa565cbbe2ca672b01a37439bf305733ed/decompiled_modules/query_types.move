module 0x7d4349725e74a4bf14c54ef65c7619f2f4fbfa6fd8dbc3bf86225f63406d2175::query_types {
    struct AssetValuation has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        usd: 0xcc44b47970ebffcad509111c6937c84daf732265c15b9829fc188e06a5942d13::float::Decimal,
        price: 0xcc44b47970ebffcad509111c6937c84daf732265c15b9829fc188e06a5942d13::float::Decimal,
    }

    struct AssetBorrow has copy, drop {
        valuation: AssetValuation,
        borrow_index: 0xcc44b47970ebffcad509111c6937c84daf732265c15b9829fc188e06a5942d13::float::Decimal,
    }

    struct AssetDeposit has copy, drop {
        is_collateral: bool,
        valuation: AssetValuation,
        ctoken_amount: u64,
        exchange_rate: 0xcc44b47970ebffcad509111c6937c84daf732265c15b9829fc188e06a5942d13::float::Decimal,
    }

    public(friend) fun new_asset_borrow(arg0: 0x1::type_name::TypeName, arg1: u64, arg2: 0xcc44b47970ebffcad509111c6937c84daf732265c15b9829fc188e06a5942d13::float::Decimal, arg3: u8, arg4: 0xcc44b47970ebffcad509111c6937c84daf732265c15b9829fc188e06a5942d13::float::Decimal) : AssetBorrow {
        let v0 = AssetValuation{
            coin_type : arg0,
            amount    : arg1,
            usd       : 0xcc44b47970ebffcad509111c6937c84daf732265c15b9829fc188e06a5942d13::float::div_u64(0xcc44b47970ebffcad509111c6937c84daf732265c15b9829fc188e06a5942d13::float::mul_u64(arg2, arg1), 0x1::u64::pow(10, arg3)),
            price     : arg2,
        };
        AssetBorrow{
            valuation    : v0,
            borrow_index : arg4,
        }
    }

    public(friend) fun new_asset_collateral_from_ctoken(arg0: 0x1::type_name::TypeName, arg1: u64, arg2: 0xcc44b47970ebffcad509111c6937c84daf732265c15b9829fc188e06a5942d13::float::Decimal, arg3: u8, arg4: 0xcc44b47970ebffcad509111c6937c84daf732265c15b9829fc188e06a5942d13::float::Decimal) : AssetDeposit {
        let v0 = 0xcc44b47970ebffcad509111c6937c84daf732265c15b9829fc188e06a5942d13::float::int_mul(arg4, arg1);
        let v1 = AssetValuation{
            coin_type : arg0,
            amount    : v0,
            usd       : 0xcc44b47970ebffcad509111c6937c84daf732265c15b9829fc188e06a5942d13::float::div_u64(0xcc44b47970ebffcad509111c6937c84daf732265c15b9829fc188e06a5942d13::float::mul_u64(arg2, v0), 0x1::u64::pow(10, arg3)),
            price     : arg2,
        };
        AssetDeposit{
            is_collateral : true,
            valuation     : v1,
            ctoken_amount : arg1,
            exchange_rate : arg4,
        }
    }

    public(friend) fun new_asset_deposit(arg0: 0x1::type_name::TypeName, arg1: bool, arg2: u64, arg3: 0xcc44b47970ebffcad509111c6937c84daf732265c15b9829fc188e06a5942d13::float::Decimal, arg4: u8, arg5: 0xcc44b47970ebffcad509111c6937c84daf732265c15b9829fc188e06a5942d13::float::Decimal) : AssetDeposit {
        let v0 = AssetValuation{
            coin_type : arg0,
            amount    : arg2,
            usd       : 0xcc44b47970ebffcad509111c6937c84daf732265c15b9829fc188e06a5942d13::float::div_u64(0xcc44b47970ebffcad509111c6937c84daf732265c15b9829fc188e06a5942d13::float::mul_u64(arg3, arg2), 0x1::u64::pow(10, arg4)),
            price     : arg3,
        };
        AssetDeposit{
            is_collateral : arg1,
            valuation     : v0,
            ctoken_amount : 0xcc44b47970ebffcad509111c6937c84daf732265c15b9829fc188e06a5942d13::float::floor(0xcc44b47970ebffcad509111c6937c84daf732265c15b9829fc188e06a5942d13::float::div(0xcc44b47970ebffcad509111c6937c84daf732265c15b9829fc188e06a5942d13::float::from(arg2), arg5)),
            exchange_rate : arg5,
        }
    }

    // decompiled from Move bytecode v7
}

