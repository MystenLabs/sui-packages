module 0x876e82ed5892b96e0b6ae8009d4f16b190fa2dd29a923539f4ed881f60601a4e::utils {
    public fun exists_<T0>(arg0: &vector<T0>, arg1: &T0) : bool {
        let (v0, _) = 0x1::vector::index_of<T0>(arg0, arg1);
        v0
    }

    // decompiled from Move bytecode v6
}

