module 0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::decimal {
    struct Decimal has copy, drop, store {
        value: u256,
    }

    public fun add(arg0: Decimal, arg1: Decimal) : Decimal {
        Decimal{value: arg0.value + arg1.value}
    }

    public fun ceil(arg0: Decimal) : u64 {
        (((arg0.value + 0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::constant::wad() - 1) / 0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::constant::wad()) as u64)
    }

    public fun div(arg0: Decimal, arg1: Decimal) : Decimal {
        Decimal{value: arg0.value * 0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::constant::wad() / arg1.value}
    }

    public fun eq(arg0: Decimal, arg1: Decimal) : bool {
        arg0.value == arg1.value
    }

    public fun floor(arg0: Decimal) : u64 {
        ((arg0.value / 0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::constant::wad()) as u64)
    }

    public fun from(arg0: u64) : Decimal {
        Decimal{value: (arg0 as u256) * 0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::constant::wad()}
    }

    public fun from_percent(arg0: u8) : Decimal {
        Decimal{value: (arg0 as u256) * 0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::constant::wad() / 100}
    }

    public fun from_u256(arg0: u256) : Decimal {
        Decimal{value: arg0}
    }

    public fun gt(arg0: Decimal, arg1: Decimal) : bool {
        arg0.value > arg1.value
    }

    public fun gte(arg0: Decimal, arg1: Decimal) : bool {
        arg0.value >= arg1.value
    }

    public fun lt(arg0: Decimal, arg1: Decimal) : bool {
        arg0.value < arg1.value
    }

    public fun lte(arg0: Decimal, arg1: Decimal) : bool {
        arg0.value <= arg1.value
    }

    public fun max(arg0: Decimal, arg1: Decimal) : Decimal {
        if (arg0.value > arg1.value) {
            Decimal{value: arg0.value}
        } else {
            Decimal{value: arg1.value}
        }
    }

    public fun min(arg0: Decimal, arg1: Decimal) : Decimal {
        if (arg0.value < arg1.value) {
            Decimal{value: arg0.value}
        } else {
            Decimal{value: arg1.value}
        }
    }

    public fun mul(arg0: Decimal, arg1: Decimal) : Decimal {
        Decimal{value: arg0.value * arg1.value / 0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::constant::wad()}
    }

    public fun pow(arg0: Decimal, arg1: u64) : Decimal {
        let v0 = from(1);
        while (arg1 > 0) {
            if (arg1 % 2 == 1) {
                v0 = mul(v0, arg0);
            };
            arg0 = mul(arg0, arg0);
            arg1 = arg1 / 2;
        };
        v0
    }

    public fun sub(arg0: Decimal, arg1: Decimal) : Decimal {
        Decimal{value: arg0.value - arg1.value}
    }

    public fun to_u256(arg0: Decimal) : u256 {
        (arg0.value as u256)
    }

    public fun to_u64(arg0: Decimal) : u64 {
        ((arg0.value / 0x197844a26a7aef416c46be09c6f6cf091f66a02534212f52cf037ac3ce28f0c3::constant::wad()) as u64)
    }

    public fun zero() : Decimal {
        Decimal{value: 0}
    }

    // decompiled from Move bytecode v6
}

