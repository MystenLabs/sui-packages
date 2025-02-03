module 0xe5beebecbc63dd0552da2af0e6c773a6f1873ec25954d6db6320e853786e713e::utils {
    public fun exists_<T0>(arg0: &vector<T0>, arg1: &T0) : bool {
        let (v0, _) = 0x1::vector::index_of<T0>(arg0, arg1);
        v0
    }

    // decompiled from Move bytecode v6
}

