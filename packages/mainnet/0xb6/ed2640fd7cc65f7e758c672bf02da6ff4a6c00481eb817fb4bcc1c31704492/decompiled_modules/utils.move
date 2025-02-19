module 0xb6ed2640fd7cc65f7e758c672bf02da6ff4a6c00481eb817fb4bcc1c31704492::utils {
    public(friend) fun concat<T0: copy>(arg0: vector<T0>, arg1: vector<T0>) : vector<T0> {
        0x1::vector::append<T0>(&mut arg0, arg1);
        arg0
    }

    // decompiled from Move bytecode v6
}

