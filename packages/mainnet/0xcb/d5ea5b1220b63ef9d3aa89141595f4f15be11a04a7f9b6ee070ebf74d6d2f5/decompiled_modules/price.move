module 0xcbd5ea5b1220b63ef9d3aa89141595f4f15be11a04a7f9b6ee070ebf74d6d2f5::price {
    struct Price has copy, drop, store {
        base: u128,
        expo: u64,
        is_expo_negative: bool,
    }

    public fun base(arg0: &Price) : u128 {
        arg0.base
    }

    public fun expo(arg0: &Price) : u64 {
        arg0.expo
    }

    public fun is_expo_negative(arg0: &Price) : bool {
        arg0.is_expo_negative
    }

    public fun is_zero(arg0: &Price) : bool {
        arg0.base == 0
    }

    public fun new(arg0: u128, arg1: u64, arg2: bool) : Price {
        Price{
            base             : arg0,
            expo             : arg1,
            is_expo_negative : arg2,
        }
    }

    // decompiled from Move bytecode v6
}

