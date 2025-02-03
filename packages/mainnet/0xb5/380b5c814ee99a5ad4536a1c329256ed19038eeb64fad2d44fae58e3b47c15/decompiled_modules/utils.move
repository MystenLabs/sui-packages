module 0xb5380b5c814ee99a5ad4536a1c329256ed19038eeb64fad2d44fae58e3b47c15::utils {
    public fun exists_<T0>(arg0: &vector<T0>, arg1: &T0) : bool {
        let (v0, _) = 0x1::vector::index_of<T0>(arg0, arg1);
        v0
    }

    // decompiled from Move bytecode v6
}

