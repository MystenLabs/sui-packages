module 0xd4b2f75f1103462b2a1c1ff7969b4c3addad400e8bc166915f48242b3cac091f::draw {
    struct DrawConfig has copy, drop, store {
        normal_count: u8,
        normal_range: 0xd4b2f75f1103462b2a1c1ff7969b4c3addad400e8bc166915f48242b3cac091f::range::Range,
        special_count: u8,
        special_range: 0xd4b2f75f1103462b2a1c1ff7969b4c3addad400e8bc166915f48242b3cac091f::range::Range,
    }

    struct DrawResult has copy, drop, store {
        normal_numbers: vector<u8>,
        special_numbers: vector<u8>,
    }

    public fun from_picks(arg0: &0xd4b2f75f1103462b2a1c1ff7969b4c3addad400e8bc166915f48242b3cac091f::picks::Picks) : DrawResult {
        DrawResult{
            normal_numbers  : *0x2::vec_set::keys<u8>(0xd4b2f75f1103462b2a1c1ff7969b4c3addad400e8bc166915f48242b3cac091f::picks::normal_numbers(arg0)),
            special_numbers : *0x2::vec_set::keys<u8>(0xd4b2f75f1103462b2a1c1ff7969b4c3addad400e8bc166915f48242b3cac091f::picks::special_numbers(arg0)),
        }
    }

    public(friend) fun get_result(arg0: &DrawConfig, arg1: &mut 0x2::random::RandomGenerator) : DrawResult {
        let v0 = 0x2::vec_set::empty<u8>();
        while (0x2::vec_set::size<u8>(&v0) < (arg0.normal_count as u64)) {
            let v1 = 0xd4b2f75f1103462b2a1c1ff7969b4c3addad400e8bc166915f48242b3cac091f::range::fold(&arg0.normal_range, 0x2::random::generate_u256(arg1));
            if (!0x2::vec_set::contains<u8>(&v0, &v1)) {
                0x2::vec_set::insert<u8>(&mut v0, v1);
            };
        };
        let v2 = 0x2::vec_set::empty<u8>();
        while (0x2::vec_set::size<u8>(&v2) < (arg0.special_count as u64)) {
            let v3 = 0xd4b2f75f1103462b2a1c1ff7969b4c3addad400e8bc166915f48242b3cac091f::range::fold(&arg0.special_range, 0x2::random::generate_u256(arg1));
            if (!0x2::vec_set::contains<u8>(&v2, &v3)) {
                0x2::vec_set::insert<u8>(&mut v2, v3);
            };
        };
        DrawResult{
            normal_numbers  : 0x2::vec_set::into_keys<u8>(v0),
            special_numbers : 0x2::vec_set::into_keys<u8>(v2),
        }
    }

    public fun into_picks(arg0: &DrawResult) : 0xd4b2f75f1103462b2a1c1ff7969b4c3addad400e8bc166915f48242b3cac091f::picks::Picks {
        0xd4b2f75f1103462b2a1c1ff7969b4c3addad400e8bc166915f48242b3cac091f::picks::new(arg0.normal_numbers, arg0.special_numbers)
    }

    public fun is_valid_picks(arg0: &DrawConfig, arg1: &0xd4b2f75f1103462b2a1c1ff7969b4c3addad400e8bc166915f48242b3cac091f::picks::Picks) : bool {
        if (0x2::vec_set::size<u8>(0xd4b2f75f1103462b2a1c1ff7969b4c3addad400e8bc166915f48242b3cac091f::picks::normal_numbers(arg1)) == (arg0.normal_count as u64)) {
            let v0 = 0x2::vec_set::keys<u8>(0xd4b2f75f1103462b2a1c1ff7969b4c3addad400e8bc166915f48242b3cac091f::picks::normal_numbers(arg1));
            let v1 = 0;
            let v2;
            while (v1 < 0x1::vector::length<u8>(v0)) {
                if (!0xd4b2f75f1103462b2a1c1ff7969b4c3addad400e8bc166915f48242b3cac091f::range::contains(&arg0.normal_range, 0x1::vector::borrow<u8>(v0, v1))) {
                    v2 = false;
                    /* label 8 */
                    let v3 = if (v2) {
                        if (0x2::vec_set::size<u8>(0xd4b2f75f1103462b2a1c1ff7969b4c3addad400e8bc166915f48242b3cac091f::picks::special_numbers(arg1)) == (arg0.special_count as u64)) {
                            let v4 = 0x2::vec_set::keys<u8>(0xd4b2f75f1103462b2a1c1ff7969b4c3addad400e8bc166915f48242b3cac091f::picks::special_numbers(arg1));
                            let v5 = 0;
                            let v3;
                            while (v5 < 0x1::vector::length<u8>(v4)) {
                                if (!0xd4b2f75f1103462b2a1c1ff7969b4c3addad400e8bc166915f48242b3cac091f::range::contains(&arg0.special_range, 0x1::vector::borrow<u8>(v4, v5))) {
                                    /* label 20 */
                                    v3 = false;
                                    return v3
                                } else {
                                    /* goto 22 */
                                };
                            };
                            v3
                        } else {
                            false
                        }
                    } else {
                        false
                    };
                    return v3
                    /* label 22 */
                    /* goto 15 */
                    continue;
                    /* goto 20 */
                };
                v1 = v1 + 1;
            };
            v2 = true;
            /* goto 8 */
        } else {
            return false
        };
    }

    public fun new(arg0: u8, arg1: u8, arg2: u8, arg3: u8, arg4: u8, arg5: u8) : DrawConfig {
        DrawConfig{
            normal_count  : arg0,
            normal_range  : 0xd4b2f75f1103462b2a1c1ff7969b4c3addad400e8bc166915f48242b3cac091f::range::new(arg1, arg2),
            special_count : arg3,
            special_range : 0xd4b2f75f1103462b2a1c1ff7969b4c3addad400e8bc166915f48242b3cac091f::range::new(arg4, arg5),
        }
    }

    public fun normal_numbers(arg0: &DrawResult) : &vector<u8> {
        &arg0.normal_numbers
    }

    public fun special_numbers(arg0: &DrawResult) : &vector<u8> {
        &arg0.special_numbers
    }

    // decompiled from Move bytecode v6
}

