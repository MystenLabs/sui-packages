module 0xcbf333daabf3984dd4be97e3c44a94c7de72bc450b8a8312d4ea155f695ee95d::attributes {
    struct Attributes has drop, store {
        map: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    public fun from_vec(arg0: &mut vector<0x1::string::String>, arg1: &mut vector<0x1::string::String>) : Attributes {
        let v0 = 0;
        let v1 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        while (v0 < 0x1::vector::length<0x1::string::String>(arg0)) {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v1, 0x1::vector::pop_back<0x1::string::String>(arg0), 0x1::vector::pop_back<0x1::string::String>(arg1));
            v0 = v0 + 1;
        };
        new(v1)
    }

    public fun new(arg0: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>) : Attributes {
        Attributes{map: arg0}
    }

    // decompiled from Move bytecode v6
}

