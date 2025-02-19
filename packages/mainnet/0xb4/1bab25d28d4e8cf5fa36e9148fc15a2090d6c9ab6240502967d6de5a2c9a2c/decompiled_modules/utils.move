module 0xb41bab25d28d4e8cf5fa36e9148fc15a2090d6c9ab6240502967d6de5a2c9a2c::utils {
    public(friend) fun concat<T0: copy>(arg0: vector<T0>, arg1: vector<T0>) : vector<T0> {
        0x1::vector::append<T0>(&mut arg0, arg1);
        arg0
    }

    // decompiled from Move bytecode v6
}

