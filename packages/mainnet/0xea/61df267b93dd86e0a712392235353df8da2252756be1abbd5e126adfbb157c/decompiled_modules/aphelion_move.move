module 0xea61df267b93dd86e0a712392235353df8da2252756be1abbd5e126adfbb157c::aphelion_move {
    struct CoinPos has drop {
        locked: u64,
        free: u64,
    }

    struct Position has drop {
        base: CoinPos,
        quote: CoinPos,
        deep: CoinPos,
    }

    public fun get_balance<T0>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager) : u64 {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg0)
    }

    public fun get_position<T0, T1, T2>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager) : Position {
        let (v0, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::locked_balance<T0, T1>(arg0, arg1);
        let v3 = CoinPos{
            locked : v0,
            free   : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg1),
        };
        let v4 = CoinPos{
            locked : v1,
            free   : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg1),
        };
        let v5 = CoinPos{
            locked : v2,
            free   : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T2>(arg1),
        };
        Position{
            base  : v3,
            quote : v4,
            deep  : v5,
        }
    }

    // decompiled from Move bytecode v6
}

