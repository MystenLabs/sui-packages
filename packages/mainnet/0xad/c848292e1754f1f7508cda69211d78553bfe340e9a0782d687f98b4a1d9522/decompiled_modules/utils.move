module 0xadc848292e1754f1f7508cda69211d78553bfe340e9a0782d687f98b4a1d9522::utils {
    public(friend) fun concat<T0: copy>(arg0: vector<T0>, arg1: vector<T0>) : vector<T0> {
        0x1::vector::append<T0>(&mut arg0, arg1);
        arg0
    }

    // decompiled from Move bytecode v6
}

