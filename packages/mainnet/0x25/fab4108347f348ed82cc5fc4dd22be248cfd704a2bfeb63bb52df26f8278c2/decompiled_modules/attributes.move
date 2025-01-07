module 0x25fab4108347f348ed82cc5fc4dd22be248cfd704a2bfeb63bb52df26f8278c2::attributes {
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

