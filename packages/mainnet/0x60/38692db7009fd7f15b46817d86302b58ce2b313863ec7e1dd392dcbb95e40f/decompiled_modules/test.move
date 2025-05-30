module 0x6038692db7009fd7f15b46817d86302b58ce2b313863ec7e1dd392dcbb95e40f::test {
    public fun new_female_name(arg0: &mut 0x2::random::RandomGenerator) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"");
        let v1 = if (0x2::random::generate_bool(arg0)) {
            0x6038692db7009fd7f15b46817d86302b58ce2b313863ec7e1dd392dcbb95e40f::consonant::select(0x2::random::generate_u8_in_range(arg0, 0, 30), 0x2::random::generate_u8_in_range(arg0, 0, 30))
        } else {
            0x6038692db7009fd7f15b46817d86302b58ce2b313863ec7e1dd392dcbb95e40f::last_name::select(0x2::random::generate_u16_in_range(arg0, 0, 1481))
        };
        0x1::string::append(&mut v0, 0x6038692db7009fd7f15b46817d86302b58ce2b313863ec7e1dd392dcbb95e40f::female::select(0x2::random::generate_u16_in_range(arg0, 0, 341)));
        0x1::string::append_utf8(&mut v0, b" ");
        0x1::string::append(&mut v0, v1);
        v0
    }

    public fun new_male_name(arg0: &mut 0x2::random::RandomGenerator) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"");
        let v1 = if (0x2::random::generate_bool(arg0)) {
            0x6038692db7009fd7f15b46817d86302b58ce2b313863ec7e1dd392dcbb95e40f::consonant::select(0x2::random::generate_u8_in_range(arg0, 0, 30), 0x2::random::generate_u8_in_range(arg0, 0, 30))
        } else {
            0x6038692db7009fd7f15b46817d86302b58ce2b313863ec7e1dd392dcbb95e40f::last_name::select(0x2::random::generate_u16_in_range(arg0, 0, 1481))
        };
        0x1::string::append(&mut v0, 0x6038692db7009fd7f15b46817d86302b58ce2b313863ec7e1dd392dcbb95e40f::male::select(0x2::random::generate_u16_in_range(arg0, 0, 343)));
        0x1::string::append_utf8(&mut v0, b" ");
        0x1::string::append(&mut v0, v1);
        v0
    }

    // decompiled from Move bytecode v6
}

