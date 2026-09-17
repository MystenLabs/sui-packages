module 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::progression {
    struct HpKey has copy, drop, store {
        dummy_field: bool,
    }

    struct SpellBookKey has copy, drop, store {
        dummy_field: bool,
    }

    struct Hp has copy, drop, store {
        current: u64,
        last_ms: u64,
    }

    struct JobXpKey has copy, drop, store {
        pos0: 0x1::string::String,
    }

    public(friend) fun award_experience(arg0: &mut 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::Character, arg1: u64, arg2: &0x2::clock::Clock) {
        0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::add_experience(arg0, arg1);
        if (0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::level(arg0) > 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::level(arg0)) {
            let v0 = max_hp(arg0);
            set_hp(arg0, v0, arg2);
        };
    }

    public(friend) fun bank_job_xp(arg0: &mut 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::Character, arg1: 0x1::string::String, arg2: u64) {
        let v0 = 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::uid_mut(arg0);
        let v1 = JobXpKey{pos0: arg1};
        if (0x2::dynamic_field::exists<JobXpKey>(v0, v1)) {
            let v2 = JobXpKey{pos0: arg1};
            let v3 = 0x2::dynamic_field::borrow_mut<JobXpKey, u64>(v0, v2);
            *v3 = *v3 + arg2;
        } else {
            let v4 = JobXpKey{pos0: arg1};
            0x2::dynamic_field::add<JobXpKey, u64>(v0, v4, arg2);
        };
    }

    public(friend) fun heal(arg0: &mut 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::Character, arg1: u64, arg2: &0x2::clock::Clock) {
        let v0 = max_hp(arg0);
        let v1 = touch(arg0, arg2);
        let v2 = if (v1 + arg1 > v0) {
            v0
        } else {
            v1 + arg1
        };
        set_hp(arg0, v2, arg2);
    }

    public fun job_level_of(arg0: &0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::Character, arg1: 0x1::string::String) : u64 {
        0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::job_xp::level_from_xp(job_xp_of(arg0, arg1))
    }

    public fun job_xp_of(arg0: &0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::Character, arg1: 0x1::string::String) : u64 {
        let v0 = 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::uid(arg0);
        let v1 = JobXpKey{pos0: arg1};
        if (!0x2::dynamic_field::exists<JobXpKey>(v0, v1)) {
            return 0
        };
        let v2 = JobXpKey{pos0: arg1};
        *0x2::dynamic_field::borrow<JobXpKey, u64>(v0, v2)
    }

    public(friend) fun max_hp(arg0: &0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::Character) : u64 {
        let v0 = 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::equipment::folded(arg0);
        0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_stats::apply_centered_to_base(50 + 5 * (0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::level(arg0) as u64) + (0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::vitality(arg0) as u64), (0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::item_stats::vitality(&v0) as u64))
    }

    public(friend) fun raise_spell(arg0: &mut 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::Character, arg1: &0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::spell_rows::SpellTemplate) {
        let v0 = spell_level(arg0, arg1);
        assert!(v0 >= 1, 1601);
        assert!(v0 < 0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::spell_rows::max_spell_level(arg1), 1602);
        assert!((0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::available_spell_points(arg0) as u64) >= v0, 1603);
        0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::spend_spell_points(arg0, (v0 as u16));
        let v1 = 0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::spell_rows::name(arg1);
        let v2 = 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::uid_mut(arg0);
        let v3 = SpellBookKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<SpellBookKey>(v2, v3)) {
            let v4 = SpellBookKey{dummy_field: false};
            0x2::dynamic_field::add<SpellBookKey, 0x2::vec_map::VecMap<0x1::string::String, u8>>(v2, v4, 0x2::vec_map::empty<0x1::string::String, u8>());
        };
        let v5 = SpellBookKey{dummy_field: false};
        let v6 = 0x2::dynamic_field::borrow_mut<SpellBookKey, 0x2::vec_map::VecMap<0x1::string::String, u8>>(v2, v5);
        if (0x2::vec_map::contains<0x1::string::String, u8>(v6, &v1)) {
            let v7 = 0x2::vec_map::get_mut<0x1::string::String, u8>(v6, &v1);
            *v7 = *v7 + 1;
        } else {
            0x2::vec_map::insert<0x1::string::String, u8>(v6, v1, ((v0 + 1) as u8));
        };
    }

    public(friend) fun reset_spells(arg0: &mut 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::Character) {
        let v0 = 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::uid_mut(arg0);
        let v1 = SpellBookKey{dummy_field: false};
        if (0x2::dynamic_field::exists<SpellBookKey>(v0, v1)) {
            let v2 = SpellBookKey{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<SpellBookKey, 0x2::vec_map::VecMap<0x1::string::String, u8>>(v0, v2) = 0x2::vec_map::empty<0x1::string::String, u8>();
        };
        0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::reset_spell_points(arg0);
    }

    public(friend) fun set_hp(arg0: &mut 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::Character, arg1: u64, arg2: &0x2::clock::Clock) {
        let v0 = 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::uid_mut(arg0);
        let v1 = HpKey{dummy_field: false};
        if (0x2::dynamic_field::exists<HpKey>(v0, v1)) {
            let v2 = HpKey{dummy_field: false};
            let v3 = 0x2::dynamic_field::borrow_mut<HpKey, Hp>(v0, v2);
            v3.current = arg1;
            v3.last_ms = 0x2::clock::timestamp_ms(arg2);
        } else {
            let v4 = HpKey{dummy_field: false};
            let v5 = Hp{
                current : arg1,
                last_ms : 0x2::clock::timestamp_ms(arg2),
            };
            0x2::dynamic_field::add<HpKey, Hp>(v0, v4, v5);
        };
    }

    public fun spell_level(arg0: &0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::Character, arg1: &0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::spell_rows::SpellTemplate) : u64 {
        if ((0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::level(arg0) as u64) < (0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::spell_rows::unlock_level(arg1) as u64)) {
            return 0
        };
        let v0 = 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::uid(arg0);
        let v1 = SpellBookKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<SpellBookKey>(v0, v1)) {
            return 1
        };
        let v2 = SpellBookKey{dummy_field: false};
        let v3 = 0x2::dynamic_field::borrow<SpellBookKey, 0x2::vec_map::VecMap<0x1::string::String, u8>>(v0, v2);
        let v4 = 0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::spell_rows::name(arg1);
        if (0x2::vec_map::contains<0x1::string::String, u8>(v3, &v4)) {
            (*0x2::vec_map::get<0x1::string::String, u8>(v3, &v4) as u64)
        } else {
            1
        }
    }

    public(friend) fun touch(arg0: &mut 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::Character, arg1: &0x2::clock::Clock) : u64 {
        let v0 = max_hp(arg0);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        let v2 = 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::character::uid_mut(arg0);
        let v3 = HpKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<HpKey>(v2, v3)) {
            let v4 = HpKey{dummy_field: false};
            let v5 = Hp{
                current : v0,
                last_ms : v1,
            };
            0x2::dynamic_field::add<HpKey, Hp>(v2, v4, v5);
            return v0
        };
        let v6 = HpKey{dummy_field: false};
        let v7 = 0x2::dynamic_field::borrow_mut<HpKey, Hp>(v2, v6);
        let v8 = if (v1 >= v7.last_ms) {
            v1 - v7.last_ms
        } else {
            0
        };
        let v9 = v8 / 1000;
        v7.current = v7.current + v9;
        v7.last_ms = v7.last_ms + v9 * 1000;
        if (v7.current > v0) {
            v7.current = v0;
        };
        v7.current
    }

    // decompiled from Move bytecode v7
}

