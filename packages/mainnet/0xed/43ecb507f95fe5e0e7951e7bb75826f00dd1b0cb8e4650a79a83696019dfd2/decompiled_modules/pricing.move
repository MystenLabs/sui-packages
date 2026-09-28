module 0xed43ecb507f95fe5e0e7951e7bb75826f00dd1b0cb8e4650a79a83696019dfd2::pricing {
    struct BuyQuote has copy, drop {
        gross_in: u64,
        fee: 0xed43ecb507f95fe5e0e7951e7bb75826f00dd1b0cb8e4650a79a83696019dfd2::fees::Parts,
        to_basket: u64,
        shares_minted: u64,
        tokens_out: u64,
        new_x: u64,
        new_y: u64,
    }

    struct SellQuote has copy, drop {
        tokens_in: u64,
        shares_burned: u64,
        gross_out: u64,
        fee: 0xed43ecb507f95fe5e0e7951e7bb75826f00dd1b0cb8e4650a79a83696019dfd2::fees::Parts,
        from_basket: u64,
        to_seller: u64,
        new_x: u64,
        new_y: u64,
    }

    public fun buy(arg0: &0xed43ecb507f95fe5e0e7951e7bb75826f00dd1b0cb8e4650a79a83696019dfd2::fees::Split, arg1: u64, arg2: u64, arg3: bool, arg4: u128, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64) : BuyQuote {
        let v0 = 0xed43ecb507f95fe5e0e7951e7bb75826f00dd1b0cb8e4650a79a83696019dfd2::fees::fee_on(arg9, arg1);
        let v1 = 0xed43ecb507f95fe5e0e7951e7bb75826f00dd1b0cb8e4650a79a83696019dfd2::fees::fee_on(arg9, arg2);
        let v2 = v0 + v1;
        assert!(arg9 > v2, 500);
        let v3 = arg9 - v2;
        let v4 = 0xed43ecb507f95fe5e0e7951e7bb75826f00dd1b0cb8e4650a79a83696019dfd2::fees::with_basket_extra(0xed43ecb507f95fe5e0e7951e7bb75826f00dd1b0cb8e4650a79a83696019dfd2::fees::split(arg0, v0, arg1, arg3), v1);
        let (_, _, _, _, v9, _) = 0xed43ecb507f95fe5e0e7951e7bb75826f00dd1b0cb8e4650a79a83696019dfd2::fees::parts(&v4);
        let v11 = 0xed43ecb507f95fe5e0e7951e7bb75826f00dd1b0cb8e4650a79a83696019dfd2::shares::mint(v3, arg7, arg8);
        assert!(v11 > 0, 500);
        let (v12, v13, v14) = 0xed43ecb507f95fe5e0e7951e7bb75826f00dd1b0cb8e4650a79a83696019dfd2::curve::price_buy(arg4, arg5, arg6, v11);
        BuyQuote{
            gross_in      : arg9,
            fee           : v4,
            to_basket     : v3 + v9,
            shares_minted : v11,
            tokens_out    : v12,
            new_x         : v13,
            new_y         : v14,
        }
    }

    public fun buy_parts(arg0: &BuyQuote) : (u64, 0xed43ecb507f95fe5e0e7951e7bb75826f00dd1b0cb8e4650a79a83696019dfd2::fees::Parts, u64, u64, u64, u64, u64) {
        (arg0.gross_in, arg0.fee, arg0.to_basket, arg0.shares_minted, arg0.tokens_out, arg0.new_x, arg0.new_y)
    }

    public fun sell(arg0: &0xed43ecb507f95fe5e0e7951e7bb75826f00dd1b0cb8e4650a79a83696019dfd2::fees::Split, arg1: u64, arg2: bool, arg3: u128, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64) : SellQuote {
        let v0 = 0xed43ecb507f95fe5e0e7951e7bb75826f00dd1b0cb8e4650a79a83696019dfd2::fees::trade_fee_bps(arg0);
        let (v1, v2, v3) = 0xed43ecb507f95fe5e0e7951e7bb75826f00dd1b0cb8e4650a79a83696019dfd2::curve::price_sell(arg3, arg4, arg5, arg8, arg6);
        let v4 = 0xed43ecb507f95fe5e0e7951e7bb75826f00dd1b0cb8e4650a79a83696019dfd2::shares::redeem(v1, arg4 - arg6, arg7);
        let v5 = 0xed43ecb507f95fe5e0e7951e7bb75826f00dd1b0cb8e4650a79a83696019dfd2::fees::fee_on(v4, v0);
        let v6 = 0xed43ecb507f95fe5e0e7951e7bb75826f00dd1b0cb8e4650a79a83696019dfd2::fees::fee_on(v4, arg1);
        let v7 = v5 + v6;
        assert!(v4 > v7, 500);
        let v8 = 0xed43ecb507f95fe5e0e7951e7bb75826f00dd1b0cb8e4650a79a83696019dfd2::fees::with_basket_extra(0xed43ecb507f95fe5e0e7951e7bb75826f00dd1b0cb8e4650a79a83696019dfd2::fees::split(arg0, v5, v0, arg2), v6);
        let (_, _, _, _, v13, _) = 0xed43ecb507f95fe5e0e7951e7bb75826f00dd1b0cb8e4650a79a83696019dfd2::fees::parts(&v8);
        SellQuote{
            tokens_in     : arg8,
            shares_burned : v1,
            gross_out     : v4,
            fee           : v8,
            from_basket   : v4 - v13,
            to_seller     : v4 - v7,
            new_x         : v2,
            new_y         : v3,
        }
    }

    public fun sell_parts(arg0: &SellQuote) : (u64, u64, u64, 0xed43ecb507f95fe5e0e7951e7bb75826f00dd1b0cb8e4650a79a83696019dfd2::fees::Parts, u64, u64, u64, u64) {
        (arg0.tokens_in, arg0.shares_burned, arg0.gross_out, arg0.fee, arg0.from_basket, arg0.to_seller, arg0.new_x, arg0.new_y)
    }

    // decompiled from Move bytecode v7
}

