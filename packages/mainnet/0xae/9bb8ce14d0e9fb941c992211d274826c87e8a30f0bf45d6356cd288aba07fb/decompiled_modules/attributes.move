module 0xae9bb8ce14d0e9fb941c992211d274826c87e8a30f0bf45d6356cd288aba07fb::attributes {
    struct Attributes has copy, drop, store {
        map: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    public fun empty() : Attributes {
        new(0x2::vec_map::empty<0x1::string::String, 0x1::string::String>())
    }

    public fun get(arg0: &Attributes, arg1: 0x1::string::String) : 0x1::string::String {
        *0x2::vec_map::get<0x1::string::String, 0x1::string::String>(&arg0.map, &arg1)
    }

    public fun keys(arg0: &Attributes) : vector<0x1::string::String> {
        0x2::vec_map::keys<0x1::string::String, 0x1::string::String>(&arg0.map)
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

    public fun values(arg0: &Attributes) : vector<0x1::string::String> {
        let (_, v1) = 0x2::vec_map::into_keys_values<0x1::string::String, 0x1::string::String>(arg0.map);
        v1
    }

    // decompiled from Move bytecode v6
}

