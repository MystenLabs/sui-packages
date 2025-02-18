module 0x73a3d2279e4360b9a0fd96f01cf8157f3f7ad13a24cfbec3375344d957ac11a3::utils {
    public(friend) fun concat<T0: copy>(arg0: vector<T0>, arg1: vector<T0>) : vector<T0> {
        0x1::vector::append<T0>(&mut arg0, arg1);
        arg0
    }

    // decompiled from Move bytecode v6
}

