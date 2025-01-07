module 0xf18351bb2aa70e4b93e03c28b96aa825ae4e16c11bfaac35d67ce880611a541d::attributes {
    struct Attributes has drop, store {
        map: 0x2::vec_map::VecMap<0x1::ascii::String, 0x1::ascii::String>,
    }

    public fun new_from_vec(arg0: vector<0x1::ascii::String>, arg1: vector<0x1::ascii::String>) : Attributes {
        assert!(0x1::vector::length<0x1::ascii::String>(&arg0) == 0x1::vector::length<0x1::ascii::String>(&arg1), 1);
        let v0 = 0;
        let v1 = 0x2::vec_map::empty<0x1::ascii::String, 0x1::ascii::String>();
        while (v0 < 0x1::vector::length<0x1::ascii::String>(&arg0)) {
            0x2::vec_map::insert<0x1::ascii::String, 0x1::ascii::String>(&mut v1, 0x1::vector::pop_back<0x1::ascii::String>(&mut arg0), 0x1::vector::pop_back<0x1::ascii::String>(&mut arg1));
            v0 = v0 + 1;
        };
        Attributes{map: v1}
    }

    // decompiled from Move bytecode v6
}

