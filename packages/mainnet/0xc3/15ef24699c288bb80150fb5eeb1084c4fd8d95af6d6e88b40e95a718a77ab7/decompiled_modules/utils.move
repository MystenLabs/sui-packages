module 0xc315ef24699c288bb80150fb5eeb1084c4fd8d95af6d6e88b40e95a718a77ab7::utils {
    public(friend) fun concat<T0: copy>(arg0: vector<T0>, arg1: vector<T0>) : vector<T0> {
        0x1::vector::append<T0>(&mut arg0, arg1);
        arg0
    }

    // decompiled from Move bytecode v6
}

