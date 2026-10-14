module 0x806e8570f5a254d46eccdbc721ae4977aa7b3d8ff53dda1457944d6944a02953::guard {
    struct Cleared<phantom T0> has copy, drop {
        proceeds: u64,
        min_value: u64,
    }

    public fun check<T0>(arg0: &0x2::balance::Balance<T0>, arg1: u64) {
        let v0 = 0x2::balance::value<T0>(arg0);
        assert!(v0 >= arg1, arg1 - v0);
        let v1 = Cleared<T0>{
            proceeds  : v0,
            min_value : arg1,
        };
        0x2::event::emit<Cleared<T0>>(v1);
    }

    // decompiled from Move bytecode v7
}

