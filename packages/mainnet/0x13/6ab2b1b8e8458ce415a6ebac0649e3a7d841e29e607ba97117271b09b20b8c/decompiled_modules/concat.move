module 0x136ab2b1b8e8458ce415a6ebac0649e3a7d841e29e607ba97117271b09b20b8c::concat {
    public(friend) fun concat<T0: copy>(arg0: vector<T0>, arg1: vector<T0>) : vector<T0> {
        0x1::vector::append<T0>(&mut arg0, arg1);
        arg0
    }

    // decompiled from Move bytecode v6
}

