module 0x3586aed9f82dac85d95ddab4df93e5bfb179931c10b2f3348c9e952d08624504::attributes {
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

