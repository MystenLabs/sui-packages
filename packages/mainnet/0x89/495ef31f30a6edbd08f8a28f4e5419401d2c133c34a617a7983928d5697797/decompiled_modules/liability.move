module 0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::liability {
    struct Credit<phantom T0> has store {
        value: u64,
    }

    struct Debt<phantom T0> has store {
        value: u64,
    }

    public fun add_credit<T0>(arg0: &mut Credit<T0>, arg1: Credit<T0>) : u64 {
        let Credit { value: v0 } = arg1;
        let v1 = credit_value<T0>(arg0) + v0;
        arg0.value = v1;
        v1
    }

    public fun add_debt<T0>(arg0: &mut Debt<T0>, arg1: Debt<T0>) : u64 {
        let Debt { value: v0 } = arg1;
        let v1 = debt_value<T0>(arg0) + v0;
        arg0.value = v1;
        v1
    }

    public fun auto_settle<T0>(arg0: &mut Credit<T0>, arg1: &mut Debt<T0>) : (u64, u64) {
        let v0 = credit_value<T0>(arg0);
        let v1 = debt_value<T0>(arg1);
        if (v0 >= v1) {
            arg0.value = v0 - v1;
            arg1.value = 0;
        } else {
            arg1.value = v1 - v0;
            arg0.value = 0;
        };
        (credit_value<T0>(arg0), debt_value<T0>(arg1))
    }

    public fun credit_value<T0>(arg0: &Credit<T0>) : u64 {
        arg0.value
    }

    public fun debt_value<T0>(arg0: &Debt<T0>) : u64 {
        arg0.value
    }

    public fun destroy_credit_for_testing<T0>(arg0: Credit<T0>) : u64 {
        let Credit { value: v0 } = arg0;
        v0
    }

    public fun destroy_debt_for_testing<T0>(arg0: Debt<T0>) : u64 {
        let Debt { value: v0 } = arg0;
        v0
    }

    public fun destroy_zero_credit<T0>(arg0: Credit<T0>) {
        let Credit { value: v0 } = arg0;
        if (v0 > 0) {
            err_destroy_not_zero_credit();
        };
    }

    public fun destroy_zero_debt<T0>(arg0: Debt<T0>) {
        let Debt { value: v0 } = arg0;
        if (v0 > 0) {
            err_destroy_not_zero_debt();
        };
    }

    fun err_destroy_not_zero_credit() {
        abort 401
    }

    fun err_destroy_not_zero_debt() {
        abort 402
    }

    public fun new<T0>(arg0: u64) : (Credit<T0>, Debt<T0>) {
        let v0 = Credit<T0>{value: arg0};
        let v1 = Debt<T0>{value: arg0};
        (v0, v1)
    }

    public fun settle_credit<T0>(arg0: &mut Debt<T0>, arg1: Credit<T0>) : 0x1::option::Option<Credit<T0>> {
        let v0 = &mut arg1;
        let (v1, _) = auto_settle<T0>(v0, arg0);
        if (v1 > 0) {
            0x1::option::some<Credit<T0>>(arg1)
        } else {
            destroy_zero_credit<T0>(arg1);
            0x1::option::none<Credit<T0>>()
        }
    }

    public fun settle_debt<T0>(arg0: &mut Credit<T0>, arg1: Debt<T0>) : 0x1::option::Option<Debt<T0>> {
        let v0 = &mut arg1;
        let (_, v2) = auto_settle<T0>(arg0, v0);
        if (v2 > 0) {
            0x1::option::some<Debt<T0>>(arg1)
        } else {
            destroy_zero_debt<T0>(arg1);
            0x1::option::none<Debt<T0>>()
        }
    }

    public fun zero_credit<T0>() : Credit<T0> {
        Credit<T0>{value: 0}
    }

    public fun zero_debt<T0>() : Debt<T0> {
        Debt<T0>{value: 0}
    }

    // decompiled from Move bytecode v6
}

