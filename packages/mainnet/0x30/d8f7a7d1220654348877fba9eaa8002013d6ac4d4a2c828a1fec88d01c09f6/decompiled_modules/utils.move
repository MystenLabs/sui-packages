module 0x30d8f7a7d1220654348877fba9eaa8002013d6ac4d4a2c828a1fec88d01c09f6::utils {
    public(friend) fun concat<T0: copy>(arg0: vector<T0>, arg1: vector<T0>) : vector<T0> {
        0x1::vector::append<T0>(&mut arg0, arg1);
        arg0
    }

    // decompiled from Move bytecode v6
}

