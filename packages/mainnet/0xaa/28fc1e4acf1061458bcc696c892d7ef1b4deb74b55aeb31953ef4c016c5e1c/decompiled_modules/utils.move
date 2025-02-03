module 0xaa28fc1e4acf1061458bcc696c892d7ef1b4deb74b55aeb31953ef4c016c5e1c::utils {
    public fun exists_<T0>(arg0: &vector<T0>, arg1: &T0) : bool {
        let (v0, _) = 0x1::vector::index_of<T0>(arg0, arg1);
        v0
    }

    // decompiled from Move bytecode v6
}

