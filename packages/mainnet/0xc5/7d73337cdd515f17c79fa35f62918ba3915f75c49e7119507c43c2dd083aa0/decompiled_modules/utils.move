module 0xc57d73337cdd515f17c79fa35f62918ba3915f75c49e7119507c43c2dd083aa0::utils {
    public(friend) fun concat<T0: copy>(arg0: vector<T0>, arg1: vector<T0>) : vector<T0> {
        0x1::vector::append<T0>(&mut arg0, arg1);
        arg0
    }

    // decompiled from Move bytecode v6
}

