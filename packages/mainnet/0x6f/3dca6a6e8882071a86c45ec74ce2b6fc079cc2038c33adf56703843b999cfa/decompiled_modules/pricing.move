module 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::pricing {
    struct BuyQuote has copy, drop {
        gross_in: u64,
        fee: 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::fees::Parts,
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
        fee: 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::fees::Parts,
        from_basket: u64,
        to_seller: u64,
        new_x: u64,
        new_y: u64,
    }

    public fun buy(arg0: &0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::fees::Split, arg1: u64, arg2: bool, arg3: u128, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64) : BuyQuote {
        let v0 = 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::fees::fee_on(arg8, arg1);
        assert!(arg8 > v0, 500);
        let v1 = arg8 - v0;
        let v2 = 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::fees::split(arg0, v0, arg1, arg2);
        let (_, _, _, _, v7, _) = 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::fees::parts(&v2);
        let v9 = 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::shares::mint(v1, arg6, arg7);
        assert!(v9 > 0, 500);
        let (v10, v11, v12) = 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::curve::price_buy(arg3, arg4, arg5, v9);
        BuyQuote{
            gross_in      : arg8,
            fee           : v2,
            to_basket     : v1 + v7,
            shares_minted : v9,
            tokens_out    : v10,
            new_x         : v11,
            new_y         : v12,
        }
    }

    public fun buy_parts(arg0: &BuyQuote) : (u64, 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::fees::Parts, u64, u64, u64, u64, u64) {
        (arg0.gross_in, arg0.fee, arg0.to_basket, arg0.shares_minted, arg0.tokens_out, arg0.new_x, arg0.new_y)
    }

    public fun sell(arg0: &0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::fees::Split, arg1: bool, arg2: u128, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) : SellQuote {
        let v0 = 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::fees::trade_fee_bps(arg0);
        let (v1, v2, v3) = 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::curve::price_sell(arg2, arg3, arg4, arg7, arg5);
        let v4 = 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::shares::redeem(v1, arg3 - arg5, arg6);
        let v5 = 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::fees::fee_on(v4, v0);
        assert!(v4 > v5, 500);
        let v6 = 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::fees::split(arg0, v5, v0, arg1);
        let (_, _, _, _, v11, _) = 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::fees::parts(&v6);
        SellQuote{
            tokens_in     : arg7,
            shares_burned : v1,
            gross_out     : v4,
            fee           : v6,
            from_basket   : v4 - v11,
            to_seller     : v4 - v5,
            new_x         : v2,
            new_y         : v3,
        }
    }

    public fun sell_parts(arg0: &SellQuote) : (u64, u64, u64, 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::fees::Parts, u64, u64, u64, u64) {
        (arg0.tokens_in, arg0.shares_burned, arg0.gross_out, arg0.fee, arg0.from_basket, arg0.to_seller, arg0.new_x, arg0.new_y)
    }

    // decompiled from Move bytecode v7
}

