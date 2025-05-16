module 0xd4b2f75f1103462b2a1c1ff7969b4c3addad400e8bc166915f48242b3cac091f::picks {
    struct Picks has copy, drop, store {
        normal_numbers: 0x2::vec_set::VecSet<u8>,
        special_numbers: 0x2::vec_set::VecSet<u8>,
    }

    public fun get_normal_hits(arg0: &Picks, arg1: &vector<u8>) : u8 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(arg1)) {
            if (0x2::vec_set::contains<u8>(&arg0.normal_numbers, 0x1::vector::borrow<u8>(arg1, v1))) {
                v0 = v0 + 1;
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun get_special_hits(arg0: &Picks, arg1: &vector<u8>) : u8 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(arg1)) {
            if (0x2::vec_set::contains<u8>(&arg0.special_numbers, 0x1::vector::borrow<u8>(arg1, v1))) {
                v0 = v0 + 1;
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun new(arg0: vector<u8>, arg1: vector<u8>) : Picks {
        Picks{
            normal_numbers  : 0x2::vec_set::from_keys<u8>(arg0),
            special_numbers : 0x2::vec_set::from_keys<u8>(arg1),
        }
    }

    public fun normal_numbers(arg0: &Picks) : &0x2::vec_set::VecSet<u8> {
        &arg0.normal_numbers
    }

    public fun special_numbers(arg0: &Picks) : &0x2::vec_set::VecSet<u8> {
        &arg0.special_numbers
    }

    // decompiled from Move bytecode v6
}

