module 0xaf37bfd6a962981a92df195c737bda22fe2bac176db5f9bd4dea4eabe182a7a1::attributes {
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

