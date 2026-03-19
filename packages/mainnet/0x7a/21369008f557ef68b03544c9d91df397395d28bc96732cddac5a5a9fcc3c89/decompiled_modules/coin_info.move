module 0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::coin_info {
    struct CoinInfo has copy, drop {
        price: 0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::Decimal,
        decimals: u8,
    }

    public fun decimals(arg0: &CoinInfo) : u8 {
        arg0.decimals
    }

    public fun new(arg0: 0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::Decimal, arg1: u8) : CoinInfo {
        CoinInfo{
            price    : arg0,
            decimals : arg1,
        }
    }

    public fun price(arg0: &CoinInfo) : 0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::Decimal {
        arg0.price
    }

    // decompiled from Move bytecode v6
}

