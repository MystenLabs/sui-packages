module 0x6a84b89e4179548d04d26341d520e4a81af35855ec3d1c5c39fbc6f77aef51f7::concat {
    public(friend) fun concat<T0: copy>(arg0: vector<T0>, arg1: vector<T0>) : vector<T0> {
        0x1::vector::append<T0>(&mut arg0, arg1);
        arg0
    }

    // decompiled from Move bytecode v6
}

