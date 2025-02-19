module 0xe9eaada3306c1b6d6bd052c5b81a5ebf30c0156ad7c9ef88d79fb12dcf35da14::utils {
    public(friend) fun concat<T0: copy>(arg0: vector<T0>, arg1: vector<T0>) : vector<T0> {
        0x1::vector::append<T0>(&mut arg0, arg1);
        arg0
    }

    // decompiled from Move bytecode v6
}

