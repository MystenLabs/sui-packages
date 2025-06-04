module 0x7e7ecad0be935628ff0ac677ef50719dbe6c64847c607f74da80a9e1fa759ea7::vector {
    public(friend) fun get_sub_vector_without_first_elements(arg0: vector<u8>, arg1: u64) : vector<u8> {
        let v0 = 0x1::vector::length<u8>(&arg0);
        if (arg1 >= v0) {
            abort 0
        };
        let v1 = vector[];
        let v2 = 0;
        while (v2 < v0 - arg1) {
            0x1::vector::push_back<u64>(&mut v1, v2 + arg1);
            v2 = v2 + 1;
        };
        let v3 = b"";
        0x1::vector::reverse<u64>(&mut v1);
        while (0x1::vector::length<u64>(&v1) != 0) {
            0x1::vector::push_back<u8>(&mut v3, *0x1::vector::borrow<u8>(&arg0, 0x1::vector::pop_back<u64>(&mut v1)));
        };
        0x1::vector::destroy_empty<u64>(v1);
        v3
    }

    // decompiled from Move bytecode v6
}

