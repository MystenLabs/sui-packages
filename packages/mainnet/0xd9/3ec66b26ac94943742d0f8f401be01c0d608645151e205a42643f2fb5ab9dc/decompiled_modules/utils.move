module 0xd93ec66b26ac94943742d0f8f401be01c0d608645151e205a42643f2fb5ab9dc::utils {
    public fun exists_<T0>(arg0: &vector<T0>, arg1: &T0) : bool {
        let (v0, _) = 0x1::vector::index_of<T0>(arg0, arg1);
        v0
    }

    // decompiled from Move bytecode v6
}

