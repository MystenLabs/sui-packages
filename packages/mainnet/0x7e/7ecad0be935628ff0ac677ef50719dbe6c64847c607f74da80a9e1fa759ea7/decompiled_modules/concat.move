module 0x7e7ecad0be935628ff0ac677ef50719dbe6c64847c607f74da80a9e1fa759ea7::concat {
    public(friend) fun concat<T0: copy>(arg0: vector<T0>, arg1: vector<T0>) : vector<T0> {
        0x1::vector::append<T0>(&mut arg0, arg1);
        arg0
    }

    // decompiled from Move bytecode v6
}

