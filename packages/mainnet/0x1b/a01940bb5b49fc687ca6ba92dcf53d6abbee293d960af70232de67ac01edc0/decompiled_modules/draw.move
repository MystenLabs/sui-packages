module 0x1ba01940bb5b49fc687ca6ba92dcf53d6abbee293d960af70232de67ac01edc0::draw {
    struct DrawConfig has copy, drop, store {
        normal_count: u8,
        normal_range: 0x1ba01940bb5b49fc687ca6ba92dcf53d6abbee293d960af70232de67ac01edc0::range::Range,
        special_count: u8,
        special_range: 0x1ba01940bb5b49fc687ca6ba92dcf53d6abbee293d960af70232de67ac01edc0::range::Range,
    }

    struct DrawResult has copy, drop, store {
        normal_numbers: vector<u8>,
        special_numbers: vector<u8>,
    }

    public fun bytes_to_u256(arg0: vector<u8>) : u256 {
        let v0 = 0;
        0x1::vector::reverse<u8>(&mut arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(&arg0)) {
            let v2 = v0 << 8;
            v0 = v2 | (0x1::vector::pop_back<u8>(&mut arg0) as u256);
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<u8>(arg0);
        v0
    }

    public fun default() : DrawConfig {
        new(5, 1, 45, 2, 1, 10)
    }

    public fun from_picks(arg0: &0x1ba01940bb5b49fc687ca6ba92dcf53d6abbee293d960af70232de67ac01edc0::picks::Picks) : DrawResult {
        DrawResult{
            normal_numbers  : *0x2::vec_set::keys<u8>(0x1ba01940bb5b49fc687ca6ba92dcf53d6abbee293d960af70232de67ac01edc0::picks::normal_numbers(arg0)),
            special_numbers : *0x2::vec_set::keys<u8>(0x1ba01940bb5b49fc687ca6ba92dcf53d6abbee293d960af70232de67ac01edc0::picks::special_numbers(arg0)),
        }
    }

    public(friend) fun get_result(arg0: &DrawConfig, arg1: vector<u8>) : DrawResult {
        let v0 = 0x2::vec_set::empty<u8>();
        while (0x2::vec_set::size<u8>(&v0) < (arg0.normal_count as u64)) {
            let v1 = 0x1ba01940bb5b49fc687ca6ba92dcf53d6abbee293d960af70232de67ac01edc0::range::fold(&arg0.normal_range, bytes_to_u256(arg1));
            let v2 = &arg1;
            arg1 = 0x2::hash::blake2b256(v2);
            if (!0x2::vec_set::contains<u8>(&v0, &v1)) {
                0x2::vec_set::insert<u8>(&mut v0, v1);
            };
        };
        let v3 = 0x2::vec_set::empty<u8>();
        while (0x2::vec_set::size<u8>(&v3) < (arg0.special_count as u64)) {
            let v4 = 0x1ba01940bb5b49fc687ca6ba92dcf53d6abbee293d960af70232de67ac01edc0::range::fold(&arg0.special_range, bytes_to_u256(arg1));
            let v5 = &arg1;
            arg1 = 0x2::hash::blake2b256(v5);
            if (!0x2::vec_set::contains<u8>(&v3, &v4)) {
                0x2::vec_set::insert<u8>(&mut v3, v4);
            };
        };
        DrawResult{
            normal_numbers  : 0x2::vec_set::into_keys<u8>(v0),
            special_numbers : 0x2::vec_set::into_keys<u8>(v3),
        }
    }

    public fun into_picks(arg0: &DrawResult) : 0x1ba01940bb5b49fc687ca6ba92dcf53d6abbee293d960af70232de67ac01edc0::picks::Picks {
        0x1ba01940bb5b49fc687ca6ba92dcf53d6abbee293d960af70232de67ac01edc0::picks::new(arg0.normal_numbers, arg0.special_numbers)
    }

    public fun is_valid_picks(arg0: &DrawConfig, arg1: &0x1ba01940bb5b49fc687ca6ba92dcf53d6abbee293d960af70232de67ac01edc0::picks::Picks) : bool {
        let v0 = if (0x2::vec_set::size<u8>(0x1ba01940bb5b49fc687ca6ba92dcf53d6abbee293d960af70232de67ac01edc0::picks::normal_numbers(arg1)) == (arg0.normal_count as u64)) {
            let v1 = 0x2::vec_set::keys<u8>(0x1ba01940bb5b49fc687ca6ba92dcf53d6abbee293d960af70232de67ac01edc0::picks::normal_numbers(arg1));
            let v2 = 0;
            let v0;
            while (v2 < 0x1::vector::length<u8>(v1)) {
                if (!0x1ba01940bb5b49fc687ca6ba92dcf53d6abbee293d960af70232de67ac01edc0::range::contains(&arg0.normal_range, 0x1::vector::borrow<u8>(v1, v2))) {
                    /* label 9 */
                    if (false) {
                        if (0x2::vec_set::size<u8>(0x1ba01940bb5b49fc687ca6ba92dcf53d6abbee293d960af70232de67ac01edc0::picks::special_numbers(arg1)) == (arg0.special_count as u64)) {
                            let v3 = 0x2::vec_set::keys<u8>(0x1ba01940bb5b49fc687ca6ba92dcf53d6abbee293d960af70232de67ac01edc0::picks::special_numbers(arg1));
                            let v4 = 0;
                            while (v4 < 0x1::vector::length<u8>(v3)) {
                                if (!0x1ba01940bb5b49fc687ca6ba92dcf53d6abbee293d960af70232de67ac01edc0::range::contains(&arg0.special_range, 0x1::vector::borrow<u8>(v3, v4))) {
                                    /* label 20 */
                                    v0 = false;
                                    return v0
                                } else {
                                    /* goto 22 */
                                };
                            };
                        } else {
                            v0 = false;
                            return v0
                        };
                    } else {
                        /* goto 24 */
                    };
                } else {
                    /* goto 25 */
                };
            };
            v0
        } else {
            false
        };
        return v0
        /* label 22 */
        /* goto 15 */
        continue;
        /* goto 20 */
        /* label 24 */
        v0 = false;
        return v0
        /* label 25 */
        /* goto 4 */
        continue;
        /* goto 9 */
    }

    public fun new(arg0: u8, arg1: u8, arg2: u8, arg3: u8, arg4: u8, arg5: u8) : DrawConfig {
        DrawConfig{
            normal_count  : arg0,
            normal_range  : 0x1ba01940bb5b49fc687ca6ba92dcf53d6abbee293d960af70232de67ac01edc0::range::new(arg1, arg2),
            special_count : arg3,
            special_range : 0x1ba01940bb5b49fc687ca6ba92dcf53d6abbee293d960af70232de67ac01edc0::range::new(arg4, arg5),
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

