module 0x84a58435914382bdf1355b7fd875d302e45867b441afaa5742a5511de46ea658::attributes {
    struct Attributes has drop, store {
        map: 0x2::vec_map::VecMap<0x1::ascii::String, 0x1::ascii::String>,
    }

    public fun new_from_vec(arg0: vector<0x1::ascii::String>, arg1: vector<0x1::ascii::String>) : Attributes {
        assert!(0x1::vector::length<0x1::ascii::String>(&arg0) == 0x1::vector::length<0x1::ascii::String>(&arg1), 1);
        let v0 = 0x2::vec_map::empty<0x1::ascii::String, 0x1::ascii::String>();
        while (0x1::vector::length<0x1::ascii::String>(&arg0) > 0) {
            0x2::vec_map::insert<0x1::ascii::String, 0x1::ascii::String>(&mut v0, 0x1::vector::pop_back<0x1::ascii::String>(&mut arg0), 0x1::vector::pop_back<0x1::ascii::String>(&mut arg1));
        };
        Attributes{map: v0}
    }

    // decompiled from Move bytecode v6
}

