module 0xe0bf08296843677ea6401189b15f291373a2000a78774c720ca5ed054289c983::n {
    public fun bl(arg0: bool) : u128 {
        if (arg0) {
            4295048016 + 1
        } else {
            79226673515401279992447579055 - 1
        }
    }

    public fun lm(arg0: bool) : u128 {
        if (arg0) {
            4295048016
        } else {
            79226673515401279992447579055
        }
    }

    public fun mx() : u8 {
        24
    }

    public fun pf(arg0: u64, arg1: u64) : u64 {
        if (arg1 > arg0) {
            arg1 - arg0
        } else {
            0
        }
    }

    public fun sc(arg0: u64, arg1: u64) : u128 {
        (arg1 as u128) + 18446744073709551616 - (arg0 as u128)
    }

    public fun tl(arg0: bool) : u128 {
        lm(arg0)
    }

    // decompiled from Move bytecode v7
}

