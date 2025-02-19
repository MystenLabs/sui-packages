module 0x60839462a074b6bffd0e9903992090cccb95d4eb9db7cc1de7cbb103bbbc0ea6::utils {
    public(friend) fun concat<T0: copy>(arg0: vector<T0>, arg1: vector<T0>) : vector<T0> {
        0x1::vector::append<T0>(&mut arg0, arg1);
        arg0
    }

    // decompiled from Move bytecode v6
}

