module 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::stake {
    struct Stake has copy, drop, store {
        amount: u64,
        unit: 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::Float,
        cumulant: u64,
    }

    public fun add(arg0: &mut Stake, arg1: u64) : u64 {
        let v0 = amount(arg0) + arg1;
        arg0.amount = v0;
        v0
    }

    public fun amount(arg0: &Stake) : u64 {
        arg0.amount
    }

    public fun cumulant(arg0: &Stake) : u64 {
        arg0.cumulant
    }

    public fun cumulate(arg0: &mut Stake, arg1: u64) : u64 {
        let v0 = cumulant(arg0) + arg1;
        arg0.cumulant = v0;
        v0
    }

    fun err_not_enough_to_unstake() {
        abort 0
    }

    public fun new(arg0: u64, arg1: 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::Float) : Stake {
        Stake{
            amount   : arg0,
            unit     : arg1,
            cumulant : 0,
        }
    }

    public fun set_unit(arg0: &mut Stake, arg1: 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::Float) {
        arg0.unit = arg1;
    }

    public fun sub(arg0: &mut Stake, arg1: u64) : u64 {
        if (amount(arg0) < arg1) {
            err_not_enough_to_unstake();
        };
        let v0 = amount(arg0) - arg1;
        arg0.amount = v0;
        v0
    }

    public fun unit(arg0: &Stake) : 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::Float {
        arg0.unit
    }

    // decompiled from Move bytecode v6
}

