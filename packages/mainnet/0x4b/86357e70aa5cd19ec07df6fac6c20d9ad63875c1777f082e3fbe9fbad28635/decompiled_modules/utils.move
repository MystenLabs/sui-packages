module 0x4b86357e70aa5cd19ec07df6fac6c20d9ad63875c1777f082e3fbe9fbad28635::utils {
    public(friend) fun concat<T0: copy>(arg0: vector<T0>, arg1: vector<T0>) : vector<T0> {
        0x1::vector::append<T0>(&mut arg0, arg1);
        arg0
    }

    // decompiled from Move bytecode v6
}

