module 0xe3a4c2ed36345bfc2207987708660ac9eb434752b0e6a6a4858897ecb50ad792::utils {
    public fun exists_<T0>(arg0: &vector<T0>, arg1: &T0) : bool {
        let (v0, _) = 0x1::vector::index_of<T0>(arg0, arg1);
        v0
    }

    // decompiled from Move bytecode v6
}

