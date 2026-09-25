module 0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::view {
    struct BuyQuote has copy, drop {
        amount_in: u64,
        amount_out: u64,
        refund: u64,
        fee: u64,
        graduates: bool,
    }

    struct SellQuote has copy, drop {
        amount_in: u64,
        amount_out: u64,
        fee: u64,
    }

    public fun config<T0>(arg0: &0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::config::Config<T0>) : vector<u8> {
        0x2::bcs::to_bytes<0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::config::Config<T0>>(arg0)
    }

    public fun pool<T0, T1>(arg0: &0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::pool::Pool<T0, T1>) : 0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::pool::Snapshot {
        0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::pool::snapshot<T0, T1>(arg0)
    }

    public fun quote_buy<T0, T1>(arg0: &0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::pool::Pool<T0, T1>, arg1: u64, arg2: address, arg3: &0x2::clock::Clock) : BuyQuote {
        let (v0, _, v2, v3, v4) = 0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::pool::quote_buy<T0, T1>(arg0, arg1, arg2, arg3);
        BuyQuote{
            amount_in  : v0,
            amount_out : v2,
            refund     : arg1 - v0,
            fee        : v3,
            graduates  : v4,
        }
    }

    public fun quote_sell<T0, T1>(arg0: &0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::pool::Pool<T0, T1>, arg1: u64) : SellQuote {
        let (v0, v1) = 0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::pool::quote_sell<T0, T1>(arg0, arg1);
        SellQuote{
            amount_in  : arg1,
            amount_out : v1,
            fee        : v0 - v1,
        }
    }

    // decompiled from Move bytecode v7
}

