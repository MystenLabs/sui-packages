module 0x3298ed2feea1f6d2cd9a21b2f3869fdd8cc750788c43457aa40ea7a6d1e13950::utils {
    public(friend) fun concat<T0: copy>(arg0: vector<T0>, arg1: vector<T0>) : vector<T0> {
        0x1::vector::append<T0>(&mut arg0, arg1);
        arg0
    }

    // decompiled from Move bytecode v6
}

