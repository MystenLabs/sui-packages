module 0xf0042c5fbdefa16aa875caaa95d06bc88e03be4d7d764c6b38283db6c1bdd734::utils {
    public(friend) fun concat<T0: copy>(arg0: vector<T0>, arg1: vector<T0>) : vector<T0> {
        0x1::vector::append<T0>(&mut arg0, arg1);
        arg0
    }

    // decompiled from Move bytecode v6
}

