module 0xd8d998b035bf89d04286635c918d9733a47bff6f7164c233d7d7ec2765d23593::attributes {
    struct ImmAttributes has store {
        map: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    public fun contains(arg0: &ImmAttributes, arg1: &0x1::string::String) : bool {
        0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&arg0.map, arg1)
    }

    public fun get(arg0: &ImmAttributes, arg1: &0x1::string::String) : &0x1::string::String {
        0x2::vec_map::get<0x1::string::String, 0x1::string::String>(&arg0.map, arg1)
    }

    public fun from_vec(arg0: vector<0x1::string::String>, arg1: vector<0x1::string::String>) : ImmAttributes {
        let v0 = 0x1::vector::length<0x1::string::String>(&arg0);
        assert!(v0 == 0x1::vector::length<0x1::string::String>(&arg1), 0);
        let v1 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        while (0 < v0) {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v1, 0x1::vector::pop_back<0x1::string::String>(&mut arg0), 0x1::vector::pop_back<0x1::string::String>(&mut arg1));
        };
        ImmAttributes{map: v1}
    }

    public fun new(arg0: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>) : ImmAttributes {
        ImmAttributes{map: arg0}
    }

    // decompiled from Move bytecode v6
}

