module 0x270a8687b7d3f45f7b01c5089e6f08985509f9f88a044496a58159941ebe6974::capybara_stats {
    struct CapybaraStats has store, key {
        id: 0x2::object::UID,
        double_xp_until: u64,
    }

    struct Attribute has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        level: u64,
        experience: u64,
    }

    fun add_stat(arg0: &mut CapybaraStats, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Attribute{
            id         : 0x2::object::new(arg2),
            name       : arg1,
            level      : 0,
            experience : 0,
        };
        0x2::dynamic_object_field::add<0x1::string::String, Attribute>(&mut arg0.id, arg1, v0);
    }

    fun check_level_up(arg0: u64, arg1: u64) : (bool, u64) {
        let v0 = arg1 + 1;
        if (arg0 >= cumulative_experience(v0)) {
            return (true, v0)
        };
        (false, arg1)
    }

    fun cumulative_experience(arg0: u64) : u64 {
        150 * arg0 * arg0 + 300 * arg0
    }

    public(friend) fun get_experience(arg0: &mut CapybaraStats, arg1: 0x1::string::String) : u64 {
        assert!(0x2::dynamic_object_field::exists_<0x1::string::String>(&arg0.id, arg1), 0);
        0x2::dynamic_object_field::borrow_mut<0x1::string::String, Attribute>(&mut arg0.id, arg1).experience
    }

    public(friend) fun get_level(arg0: &mut CapybaraStats, arg1: 0x1::string::String) : u64 {
        assert!(0x2::dynamic_object_field::exists_<0x1::string::String>(&arg0.id, arg1), 0);
        0x2::dynamic_object_field::borrow_mut<0x1::string::String, Attribute>(&mut arg0.id, arg1).level
    }

    public(friend) fun new_capybara_stats(arg0: &mut 0x2::tx_context::TxContext) : CapybaraStats {
        let v0 = CapybaraStats{
            id              : 0x2::object::new(arg0),
            double_xp_until : 0,
        };
        let v1 = &mut v0;
        add_stat(v1, 0x1::string::utf8(b"agility"), arg0);
        let v2 = &mut v0;
        add_stat(v2, 0x1::string::utf8(b"dexterity"), arg0);
        let v3 = &mut v0;
        add_stat(v3, 0x1::string::utf8(b"durability"), arg0);
        let v4 = &mut v0;
        add_stat(v4, 0x1::string::utf8(b"defense"), arg0);
        let v5 = &mut v0;
        add_stat(v5, 0x1::string::utf8(b"strength"), arg0);
        v0
    }

    public(friend) fun set_double_xp(arg0: &mut CapybaraStats, arg1: u64) {
        arg0.double_xp_until = arg1;
    }

    public(friend) fun train_stat(arg0: &mut CapybaraStats, arg1: u64, arg2: 0x1::string::String, arg3: &0x2::clock::Clock) {
        assert!(0x2::dynamic_object_field::exists_<0x1::string::String>(&arg0.id, arg2), 0);
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x1::string::String, Attribute>(&mut arg0.id, arg2);
        if (0x2::clock::timestamp_ms(arg3) < arg0.double_xp_until) {
            v0.experience = v0.experience + arg1 + arg1;
        } else {
            v0.experience = v0.experience + arg1;
        };
        let (v1, v2) = check_level_up(v0.experience, v0.level);
        if (v1) {
            v0.level = v2;
        };
    }

    // decompiled from Move bytecode v6
}

