module 0x7b268447986e73ee61d4a148e4e3caf93e9e360afac486ea9e6b7585549372b8::utils {
    public(friend) fun concat<T0: copy>(arg0: vector<T0>, arg1: vector<T0>) : vector<T0> {
        0x1::vector::append<T0>(&mut arg0, arg1);
        arg0
    }

    // decompiled from Move bytecode v6
}

