module 0x5d5f4dbf37cbf5e4dedde55632af69b676112ffe4c5a6e1f29a5c434090c6aa4::attributes {
    struct Attributes has copy, drop, store {
        map: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    public fun from_vec(arg0: &mut vector<0x1::string::String>, arg1: &mut vector<0x1::string::String>) : Attributes {
        let v0 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        while (0x1::vector::length<0x1::string::String>(arg0) > 0) {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::vector::pop_back<0x1::string::String>(arg0), 0x1::vector::pop_back<0x1::string::String>(arg1));
        };
        new(v0)
    }

    public fun new(arg0: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>) : Attributes {
        Attributes{map: arg0}
    }

    // decompiled from Move bytecode v6
}

