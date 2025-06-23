module 0xc10835ced21dd0f78c61a6c36e5e7be5dbd06c536f229e260768d807cbe41b82::srate {
    struct SRate has copy, drop, store {
        is_positive: bool,
        value: 0xc10835ced21dd0f78c61a6c36e5e7be5dbd06c536f229e260768d807cbe41b82::rate::Rate,
    }

    public fun add(arg0: SRate, arg1: SRate) : SRate {
        if (is_zero(&arg0)) {
            return arg1
        };
        if (is_zero(&arg1)) {
            return arg0
        };
        let (v0, v1) = if (arg0.is_positive == arg1.is_positive) {
            (arg0.is_positive, 0xc10835ced21dd0f78c61a6c36e5e7be5dbd06c536f229e260768d807cbe41b82::rate::add(arg0.value, arg1.value))
        } else if (0xc10835ced21dd0f78c61a6c36e5e7be5dbd06c536f229e260768d807cbe41b82::rate::gt(&arg0.value, &arg1.value)) {
            (arg0.is_positive, 0xc10835ced21dd0f78c61a6c36e5e7be5dbd06c536f229e260768d807cbe41b82::rate::sub(arg0.value, arg1.value))
        } else {
            (arg1.is_positive, 0xc10835ced21dd0f78c61a6c36e5e7be5dbd06c536f229e260768d807cbe41b82::rate::sub(arg1.value, arg0.value))
        };
        SRate{
            is_positive : v0,
            value       : v1,
        }
    }

    public fun div_by_u64(arg0: SRate, arg1: u64) : SRate {
        SRate{
            is_positive : arg0.is_positive,
            value       : 0xc10835ced21dd0f78c61a6c36e5e7be5dbd06c536f229e260768d807cbe41b82::rate::div_by_u64(arg0.value, arg1),
        }
    }

    public fun eq(arg0: &SRate, arg1: &SRate) : bool {
        0xc10835ced21dd0f78c61a6c36e5e7be5dbd06c536f229e260768d807cbe41b82::rate::eq(&arg0.value, &arg1.value) && (is_zero(arg0) || arg0.is_positive == arg1.is_positive)
    }

    public fun is_zero(arg0: &SRate) : bool {
        0xc10835ced21dd0f78c61a6c36e5e7be5dbd06c536f229e260768d807cbe41b82::rate::is_zero(&arg0.value)
    }

    public fun mul_with_u64(arg0: SRate, arg1: u64) : SRate {
        SRate{
            is_positive : arg0.is_positive,
            value       : 0xc10835ced21dd0f78c61a6c36e5e7be5dbd06c536f229e260768d807cbe41b82::rate::mul_with_u64(arg0.value, arg1),
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
            (arg0.is_positive, 0xc10835ced21dd0f78c61a6c36e5e7be5dbd06c536f229e260768d807cbe41b82::rate::add(arg0.value, arg1.value))
        } else if (0xc10835ced21dd0f78c61a6c36e5e7be5dbd06c536f229e260768d807cbe41b82::rate::gt(&arg0.value, &arg1.value)) {
            (arg0.is_positive, 0xc10835ced21dd0f78c61a6c36e5e7be5dbd06c536f229e260768d807cbe41b82::rate::sub(arg0.value, arg1.value))
        } else {
            (!arg0.is_positive, 0xc10835ced21dd0f78c61a6c36e5e7be5dbd06c536f229e260768d807cbe41b82::rate::sub(arg1.value, arg0.value))
        };
        SRate{
            is_positive : v0,
            value       : v1,
        }
    }

    public fun zero() : SRate {
        SRate{
            is_positive : true,
            value       : 0xc10835ced21dd0f78c61a6c36e5e7be5dbd06c536f229e260768d807cbe41b82::rate::zero(),
        }
    }

    public fun add_with_rate(arg0: SRate, arg1: 0xc10835ced21dd0f78c61a6c36e5e7be5dbd06c536f229e260768d807cbe41b82::rate::Rate) : SRate {
        if (is_zero(&arg0)) {
            return from_rate(true, arg1)
        };
        let (v0, v1) = if (arg0.is_positive) {
            (true, 0xc10835ced21dd0f78c61a6c36e5e7be5dbd06c536f229e260768d807cbe41b82::rate::add(arg0.value, arg1))
        } else if (0xc10835ced21dd0f78c61a6c36e5e7be5dbd06c536f229e260768d807cbe41b82::rate::gt(&arg0.value, &arg1)) {
            (false, 0xc10835ced21dd0f78c61a6c36e5e7be5dbd06c536f229e260768d807cbe41b82::rate::sub(arg0.value, arg1))
        } else {
            (true, 0xc10835ced21dd0f78c61a6c36e5e7be5dbd06c536f229e260768d807cbe41b82::rate::sub(arg1, arg0.value))
        };
        SRate{
            is_positive : v0,
            value       : v1,
        }
    }

    public fun from_rate(arg0: bool, arg1: 0xc10835ced21dd0f78c61a6c36e5e7be5dbd06c536f229e260768d807cbe41b82::rate::Rate) : SRate {
        SRate{
            is_positive : arg0,
            value       : arg1,
        }
    }

    public fun is_positive(arg0: &SRate) : bool {
        arg0.is_positive
    }

    public fun sub_with_rate(arg0: SRate, arg1: 0xc10835ced21dd0f78c61a6c36e5e7be5dbd06c536f229e260768d807cbe41b82::rate::Rate) : SRate {
        if (is_zero(&arg0)) {
            return from_rate(false, arg1)
        };
        let (v0, v1) = if (arg0.is_positive) {
            if (0xc10835ced21dd0f78c61a6c36e5e7be5dbd06c536f229e260768d807cbe41b82::rate::gt(&arg0.value, &arg1)) {
                (true, 0xc10835ced21dd0f78c61a6c36e5e7be5dbd06c536f229e260768d807cbe41b82::rate::sub(arg0.value, arg1))
            } else {
                (false, 0xc10835ced21dd0f78c61a6c36e5e7be5dbd06c536f229e260768d807cbe41b82::rate::sub(arg1, arg0.value))
            }
        } else {
            (false, 0xc10835ced21dd0f78c61a6c36e5e7be5dbd06c536f229e260768d807cbe41b82::rate::add(arg0.value, arg1))
        };
        SRate{
            is_positive : v0,
            value       : v1,
        }
    }

    public fun value(arg0: &SRate) : 0xc10835ced21dd0f78c61a6c36e5e7be5dbd06c536f229e260768d807cbe41b82::rate::Rate {
        arg0.value
    }

    // decompiled from Move bytecode v6
}

