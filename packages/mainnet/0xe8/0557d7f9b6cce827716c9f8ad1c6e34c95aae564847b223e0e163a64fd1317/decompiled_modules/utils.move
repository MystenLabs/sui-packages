module 0xe80557d7f9b6cce827716c9f8ad1c6e34c95aae564847b223e0e163a64fd1317::utils {
    public(friend) fun concat<T0: copy>(arg0: vector<T0>, arg1: vector<T0>) : vector<T0> {
        0x1::vector::append<T0>(&mut arg0, arg1);
        arg0
    }

    // decompiled from Move bytecode v6
}

