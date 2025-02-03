module 0x627bbd4e0478a19c942909353ffd25894f6bda30b424cf1c4ff8cef6bb7b31f6::srate {
    struct SRate has copy, drop, store {
        is_positive: bool,
        value: 0x627bbd4e0478a19c942909353ffd25894f6bda30b424cf1c4ff8cef6bb7b31f6::rate::Rate,
    }

    public fun add(arg0: SRate, arg1: SRate) : SRate {
        if (is_zero(&arg0)) {
            return arg1
        };
        if (is_zero(&arg1)) {
            return arg0
        };
        let (v0, v1) = if (arg0.is_positive == arg1.is_positive) {
            (arg0.is_positive, 0x627bbd4e0478a19c942909353ffd25894f6bda30b424cf1c4ff8cef6bb7b31f6::rate::add(arg0.value, arg1.value))
        } else if (0x627bbd4e0478a19c942909353ffd25894f6bda30b424cf1c4ff8cef6bb7b31f6::rate::gt(&arg0.value, &arg1.value)) {
            (arg0.is_positive, 0x627bbd4e0478a19c942909353ffd25894f6bda30b424cf1c4ff8cef6bb7b31f6::rate::sub(arg0.value, arg1.value))
        } else {
            (arg1.is_positive, 0x627bbd4e0478a19c942909353ffd25894f6bda30b424cf1c4ff8cef6bb7b31f6::rate::sub(arg1.value, arg0.value))
        };
        SRate{
            is_positive : v0,
            value       : v1,
        }
    }

    public fun div_by_u64(arg0: SRate, arg1: u64) : SRate {
        SRate{
            is_positive : arg0.is_positive,
            value       : 0x627bbd4e0478a19c942909353ffd25894f6bda30b424cf1c4ff8cef6bb7b31f6::rate::div_by_u64(arg0.value, arg1),
        }
    }

    public fun eq(arg0: &SRate, arg1: &SRate) : bool {
        0x627bbd4e0478a19c942909353ffd25894f6bda30b424cf1c4ff8cef6bb7b31f6::rate::eq(&arg0.value, &arg1.value) && (is_zero(arg0) || arg0.is_positive == arg1.is_positive)
    }

    public fun is_zero(arg0: &SRate) : bool {
        0x627bbd4e0478a19c942909353ffd25894f6bda30b424cf1c4ff8cef6bb7b31f6::rate::is_zero(&arg0.value)
    }

    public fun mul_with_u64(arg0: SRate, arg1: u64) : SRate {
        SRate{
            is_positive : arg0.is_positive,
            value       : 0x627bbd4e0478a19c942909353ffd25894f6bda30b424cf1c4ff8cef6bb7b31f6::rate::mul_with_u64(arg0.value, arg1),
        }
    }

    public fun sub(arg0: SRate, arg1: SRate) : SRate {
        if (is_zero(&arg0)) {
            return from_rate(!arg1.is_positive, arg1.value)
        };
        if (is_zero(&arg1)) {
            return arg0
        };
        let (v0, v1) = if (arg0.is_positive != arg1.is_positive) {
            (arg0.is_positive, 0x627bbd4e0478a19c942909353ffd25894f6bda30b424cf1c4ff8cef6bb7b31f6::rate::add(arg0.value, arg1.value))
        } else if (0x627bbd4e0478a19c942909353ffd25894f6bda30b424cf1c4ff8cef6bb7b31f6::rate::gt(&arg0.value, &arg1.value)) {
            (arg0.is_positive, 0x627bbd4e0478a19c942909353ffd25894f6bda30b424cf1c4ff8cef6bb7b31f6::rate::sub(arg0.value, arg1.value))
        } else {
            (!arg0.is_positive, 0x627bbd4e0478a19c942909353ffd25894f6bda30b424cf1c4ff8cef6bb7b31f6::rate::sub(arg1.value, arg0.value))
        };
        SRate{
            is_positive : v0,
            value       : v1,
        }
    }

    public fun zero() : SRate {
        SRate{
            is_positive : true,
            value       : 0x627bbd4e0478a19c942909353ffd25894f6bda30b424cf1c4ff8cef6bb7b31f6::rate::zero(),
        }
    }

    public fun add_with_rate(arg0: SRate, arg1: 0x627bbd4e0478a19c942909353ffd25894f6bda30b424cf1c4ff8cef6bb7b31f6::rate::Rate) : SRate {
        if (is_zero(&arg0)) {
            return from_rate(true, arg1)
        };
        let (v0, v1) = if (arg0.is_positive) {
            (true, 0x627bbd4e0478a19c942909353ffd25894f6bda30b424cf1c4ff8cef6bb7b31f6::rate::add(arg0.value, arg1))
        } else if (0x627bbd4e0478a19c942909353ffd25894f6bda30b424cf1c4ff8cef6bb7b31f6::rate::gt(&arg0.value, &arg1)) {
            (false, 0x627bbd4e0478a19c942909353ffd25894f6bda30b424cf1c4ff8cef6bb7b31f6::rate::sub(arg0.value, arg1))
        } else {
            (true, 0x627bbd4e0478a19c942909353ffd25894f6bda30b424cf1c4ff8cef6bb7b31f6::rate::sub(arg1, arg0.value))
        };
        SRate{
            is_positive : v0,
            value       : v1,
        }
    }

    public fun from_rate(arg0: bool, arg1: 0x627bbd4e0478a19c942909353ffd25894f6bda30b424cf1c4ff8cef6bb7b31f6::rate::Rate) : SRate {
        SRate{
            is_positive : arg0,
            value       : arg1,
        }
    }

    public fun is_positive(arg0: &SRate) : bool {
        arg0.is_positive
    }

    public fun sub_with_rate(arg0: SRate, arg1: 0x627bbd4e0478a19c942909353ffd25894f6bda30b424cf1c4ff8cef6bb7b31f6::rate::Rate) : SRate {
        if (is_zero(&arg0)) {
            return from_rate(false, arg1)
        };
        let (v0, v1) = if (arg0.is_positive) {
            if (0x627bbd4e0478a19c942909353ffd25894f6bda30b424cf1c4ff8cef6bb7b31f6::rate::gt(&arg0.value, &arg1)) {
                (true, 0x627bbd4e0478a19c942909353ffd25894f6bda30b424cf1c4ff8cef6bb7b31f6::rate::sub(arg0.value, arg1))
            } else {
                (false, 0x627bbd4e0478a19c942909353ffd25894f6bda30b424cf1c4ff8cef6bb7b31f6::rate::sub(arg1, arg0.value))
            }
        } else {
            (false, 0x627bbd4e0478a19c942909353ffd25894f6bda30b424cf1c4ff8cef6bb7b31f6::rate::add(arg0.value, arg1))
        };
        SRate{
            is_positive : v0,
            value       : v1,
        }
    }

    public fun value(arg0: &SRate) : 0x627bbd4e0478a19c942909353ffd25894f6bda30b424cf1c4ff8cef6bb7b31f6::rate::Rate {
        arg0.value
    }

    // decompiled from Move bytecode v6
}

