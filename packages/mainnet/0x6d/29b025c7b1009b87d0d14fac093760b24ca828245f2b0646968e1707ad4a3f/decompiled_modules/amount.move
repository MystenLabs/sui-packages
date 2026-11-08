module 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::amount {
    struct Amount has copy, drop, store {
        value: 0x1::string::String,
        currency: 0x1::string::String,
    }

    struct Money has copy, drop, store {
        micros: u128,
        currency: 0x1::string::String,
        digits: u8,
    }

    public fun add(arg0: &Money, arg1: &Money) : 0x1::option::Option<Money> {
        if (!same_currency(arg0, arg1)) {
            return 0x1::option::none<Money>()
        };
        if (arg0.micros > 340282366920938463463374607431768211455 - arg1.micros) {
            return 0x1::option::none<Money>()
        };
        let v0 = if (arg0.digits > arg1.digits) {
            arg0.digits
        } else {
            arg1.digits
        };
        let v1 = Money{
            micros   : arg0.micros + arg1.micros,
            currency : arg0.currency,
            digits   : v0,
        };
        0x1::option::some<Money>(v1)
    }

    public fun compare(arg0: &Money, arg1: &Money) : 0x1::option::Option<u8> {
        if (!same_currency(arg0, arg1)) {
            return 0x1::option::none<u8>()
        };
        if (arg0.micros < arg1.micros) {
            0x1::option::some<u8>(0)
        } else if (arg0.micros == arg1.micros) {
            0x1::option::some<u8>(1)
        } else {
            0x1::option::some<u8>(2)
        }
    }

    public fun currency(arg0: &Amount) : &0x1::string::String {
        &arg0.currency
    }

    fun digits_to_u128(arg0: &vector<u8>) : 0x1::option::Option<u128> {
        if (0x1::vector::is_empty<u8>(arg0)) {
            return 0x1::option::none<u128>()
        };
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(arg0)) {
            let v2 = *0x1::vector::borrow<u8>(arg0, v1);
            if (!is_digit(v2)) {
                return 0x1::option::none<u128>()
            };
            if (v0 > (340282366920938463463374607431768211455 - 9) / 10) {
                return 0x1::option::none<u128>()
            };
            let v3 = v0 * 10;
            v0 = v3 + ((v2 - 48) as u128);
            v1 = v1 + 1;
        };
        0x1::option::some<u128>(v0)
    }

    public fun equal() : u8 {
        1
    }

    public fun format(arg0: &Money) : Amount {
        Amount{
            value    : format_value(arg0),
            currency : arg0.currency,
        }
    }

    public fun format_value(arg0: &Money) : 0x1::string::String {
        let v0 = arg0.micros % 1000000;
        let v1 = (arg0.digits as u64);
        let v2 = v1;
        let v3 = 6;
        while (v3 > 0 && v0 % 10 == 0) {
            v0 = v0 / 10;
            v3 = v3 - 1;
        };
        if (v3 > v1) {
            v2 = v3;
        };
        let v4 = 0x1::u128::to_string(arg0.micros / 1000000);
        if (v2 == 0) {
            return v4
        };
        let v5 = 0x1::string::into_bytes(0x1::u128::to_string(v0));
        while (0x1::vector::length<u8>(&v5) < 6) {
            0x1::vector::insert<u8>(&mut v5, 48, 0);
        };
        let v6 = b"";
        let v7 = 0;
        while (v7 < v2) {
            0x1::vector::push_back<u8>(&mut v6, *0x1::vector::borrow<u8>(&v5, v7));
            v7 = v7 + 1;
        };
        0x1::string::append(&mut v4, 0x1::string::utf8(b"."));
        0x1::string::append(&mut v4, 0x1::string::utf8(v6));
        v4
    }

    public fun greater() : u8 {
        2
    }

    fun is_alnum(arg0: u8) : bool {
        if (is_digit(arg0)) {
            true
        } else if (arg0 >= 65 && arg0 <= 90) {
            true
        } else {
            arg0 >= 97 && arg0 <= 122
        }
    }

    fun is_digit(arg0: u8) : bool {
        arg0 >= 48 && arg0 <= 57
    }

    public fun less() : u8 {
        0
    }

    public fun micros(arg0: &Money) : u128 {
        arg0.micros
    }

    public fun money_currency(arg0: &Money) : &0x1::string::String {
        &arg0.currency
    }

    public fun parse(arg0: &Amount) : 0x1::option::Option<Money> {
        parse_parts(&arg0.value, &arg0.currency)
    }

    public fun parse_parts(arg0: &0x1::string::String, arg1: &0x1::string::String) : 0x1::option::Option<Money> {
        let v0 = 0x1::string::as_bytes(arg1);
        if (0x1::vector::is_empty<u8>(v0)) {
            return 0x1::option::none<Money>()
        };
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(v0)) {
            if (!is_alnum(*0x1::vector::borrow<u8>(v0, v1))) {
                return 0x1::option::none<Money>()
            };
            v1 = v1 + 1;
        };
        let v2 = 0x1::string::as_bytes(arg0);
        let v3 = b"";
        let v4 = b"";
        let v5 = false;
        v1 = 0;
        while (v1 < 0x1::vector::length<u8>(v2)) {
            let v6 = *0x1::vector::borrow<u8>(v2, v1);
            if (!v5 && v6 == 46) {
                v5 = true;
            } else if (v5) {
                0x1::vector::push_back<u8>(&mut v4, v6);
            } else {
                0x1::vector::push_back<u8>(&mut v3, v6);
            };
            v1 = v1 + 1;
        };
        if (v5 && 0x1::vector::is_empty<u8>(&v4)) {
            return 0x1::option::none<Money>()
        };
        if (0x1::vector::length<u8>(&v4) > 6) {
            return 0x1::option::none<Money>()
        };
        let v7 = digits_to_u128(&v3);
        if (0x1::option::is_none<u128>(&v7)) {
            return 0x1::option::none<Money>()
        };
        let v8 = 0;
        if (!0x1::vector::is_empty<u8>(&v4)) {
            let v9 = digits_to_u128(&v4);
            if (0x1::option::is_none<u128>(&v9)) {
                return 0x1::option::none<Money>()
            };
            v8 = 0x1::option::destroy_some<u128>(v9);
        };
        let v10 = 0x1::vector::length<u8>(&v4);
        while (v10 < 6) {
            v8 = v8 * 10;
            v10 = v10 + 1;
        };
        let v11 = 0x1::option::destroy_some<u128>(v7);
        if (v11 > (340282366920938463463374607431768211455 - v8) / 1000000) {
            return 0x1::option::none<Money>()
        };
        let v12 = Money{
            micros   : v11 * 1000000 + v8,
            currency : *arg1,
            digits   : (0x1::vector::length<u8>(&v4) as u8),
        };
        0x1::option::some<Money>(v12)
    }

    fun same_currency(arg0: &Money, arg1: &Money) : bool {
        arg0.currency == arg1.currency
    }

    public fun scale_bps(arg0: &Money, arg1: u64) : Money {
        let v0 = (arg1 as u128);
        let v1 = if (v0 > 0 && arg0.micros > 340282366920938463463374607431768211455 / v0) {
            340282366920938463463374607431768211455 / 10000
        } else {
            arg0.micros * v0 / 10000
        };
        Money{
            micros   : v1,
            currency : arg0.currency,
            digits   : arg0.digits,
        }
    }

    public fun scale_bps_up(arg0: &Money, arg1: u64) : Money {
        let v0 = (arg1 as u128);
        let v1 = if (v0 > 0 && arg0.micros > 340282366920938463463374607431768211455 / v0) {
            340282366920938463463374607431768211455
        } else {
            arg0.micros * v0
        };
        let v2 = if (v1 % 10000 > 0) {
            v1 / 10000 + 1
        } else {
            v1 / 10000
        };
        Money{
            micros   : v2,
            currency : arg0.currency,
            digits   : arg0.digits,
        }
    }

    public fun sub(arg0: &Money, arg1: &Money) : 0x1::option::Option<Money> {
        if (!same_currency(arg0, arg1)) {
            return 0x1::option::none<Money>()
        };
        if (arg0.micros < arg1.micros) {
            return 0x1::option::none<Money>()
        };
        let v0 = if (arg0.digits > arg1.digits) {
            arg0.digits
        } else {
            arg1.digits
        };
        let v1 = Money{
            micros   : arg0.micros - arg1.micros,
            currency : arg0.currency,
            digits   : v0,
        };
        0x1::option::some<Money>(v1)
    }

    public fun value(arg0: &Amount) : &0x1::string::String {
        &arg0.value
    }

    public fun wire(arg0: 0x1::string::String, arg1: 0x1::string::String) : Amount {
        Amount{
            value    : arg0,
            currency : arg1,
        }
    }

    public fun zero_like(arg0: &Money) : Money {
        Money{
            micros   : 0,
            currency : arg0.currency,
            digits   : arg0.digits,
        }
    }

    // decompiled from Move bytecode v7
}

