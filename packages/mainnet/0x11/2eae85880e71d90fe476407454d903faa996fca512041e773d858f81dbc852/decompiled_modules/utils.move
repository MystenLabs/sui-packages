module 0x112eae85880e71d90fe476407454d903faa996fca512041e773d858f81dbc852::utils {
    public fun exists_<T0>(arg0: &vector<T0>, arg1: &T0) : bool {
        let (v0, _) = 0x1::vector::index_of<T0>(arg0, arg1);
        v0
    }

    // decompiled from Move bytecode v6
}

