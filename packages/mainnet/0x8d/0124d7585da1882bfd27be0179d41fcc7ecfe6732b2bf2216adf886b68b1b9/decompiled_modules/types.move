module 0x8d0124d7585da1882bfd27be0179d41fcc7ecfe6732b2bf2216adf886b68b1b9::types {
    struct AssetValuation has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        usd: 0xc2188746cc9c6c44133b260c125625d96d9fc297667623679e4b2832723bbd40::float::Decimal,
        price: 0xc2188746cc9c6c44133b260c125625d96d9fc297667623679e4b2832723bbd40::float::Decimal,
    }

    struct AssetBorrow has copy, drop {
        valuation: AssetValuation,
        borrow_index: 0xc2188746cc9c6c44133b260c125625d96d9fc297667623679e4b2832723bbd40::float::Decimal,
    }

    struct AssetDeposit has copy, drop {
        is_collateral: bool,
        valuation: AssetValuation,
        exchange_rate: 0xc2188746cc9c6c44133b260c125625d96d9fc297667623679e4b2832723bbd40::float::Decimal,
    }

    public fun new_asset_borrow(arg0: 0x1::type_name::TypeName, arg1: u64, arg2: 0xc2188746cc9c6c44133b260c125625d96d9fc297667623679e4b2832723bbd40::float::Decimal, arg3: u8, arg4: 0xc2188746cc9c6c44133b260c125625d96d9fc297667623679e4b2832723bbd40::float::Decimal) : AssetBorrow {
        let v0 = AssetValuation{
            coin_type : arg0,
            amount    : arg1,
            usd       : 0xc2188746cc9c6c44133b260c125625d96d9fc297667623679e4b2832723bbd40::float::div_u64(0xc2188746cc9c6c44133b260c125625d96d9fc297667623679e4b2832723bbd40::float::mul_u64(arg2, arg1), 0x1::u64::pow(10, arg3)),
            price     : arg2,
        };
        AssetBorrow{
            valuation    : v0,
            borrow_index : arg4,
        }
    }

    public fun new_asset_collateral_from_ctoken(arg0: 0x1::type_name::TypeName, arg1: u64, arg2: 0xc2188746cc9c6c44133b260c125625d96d9fc297667623679e4b2832723bbd40::float::Decimal, arg3: u8, arg4: 0xc2188746cc9c6c44133b260c125625d96d9fc297667623679e4b2832723bbd40::float::Decimal) : AssetDeposit {
        let v0 = 0xc2188746cc9c6c44133b260c125625d96d9fc297667623679e4b2832723bbd40::float::int_mul(arg4, arg1);
        let v1 = AssetValuation{
            coin_type : arg0,
            amount    : v0,
            usd       : 0xc2188746cc9c6c44133b260c125625d96d9fc297667623679e4b2832723bbd40::float::div_u64(0xc2188746cc9c6c44133b260c125625d96d9fc297667623679e4b2832723bbd40::float::mul_u64(arg2, v0), 0x1::u64::pow(10, arg3)),
            price     : arg2,
        };
        AssetDeposit{
            is_collateral : true,
            valuation     : v1,
            exchange_rate : arg4,
        }
    }

    public fun new_asset_deposit(arg0: 0x1::type_name::TypeName, arg1: bool, arg2: u64, arg3: 0xc2188746cc9c6c44133b260c125625d96d9fc297667623679e4b2832723bbd40::float::Decimal, arg4: u8, arg5: 0xc2188746cc9c6c44133b260c125625d96d9fc297667623679e4b2832723bbd40::float::Decimal) : AssetDeposit {
        let v0 = AssetValuation{
            coin_type : arg0,
            amount    : arg2,
            usd       : 0xc2188746cc9c6c44133b260c125625d96d9fc297667623679e4b2832723bbd40::float::div_u64(0xc2188746cc9c6c44133b260c125625d96d9fc297667623679e4b2832723bbd40::float::mul_u64(arg3, arg2), 0x1::u64::pow(10, arg4)),
            price     : arg3,
        };
        AssetDeposit{
            is_collateral : arg1,
            valuation     : v0,
            exchange_rate : arg5,
        }
    }

    // decompiled from Move bytecode v6
}

