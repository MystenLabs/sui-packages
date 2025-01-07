module 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::character_stats {
    struct StatsKey has copy, drop, store {
        dummy_field: bool,
    }

    struct StatsResetEvent has copy, drop {
        character_id: 0x2::object::ID,
    }

    struct CharacterStatistics has store {
        vitality: u16,
        wisdom: u16,
        strength: u16,
        intelligence: u16,
        chance: u16,
        agility: u16,
        available_points: u16,
    }

    public fun add_agility(arg0: &mut 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::character::Character, arg1: u16, arg2: &0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::version::Version) {
        0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::version::assert_latest(arg2);
        let v0 = borrow_stats_mut(arg0);
        use_points(v0, arg1);
        v0.agility = v0.agility + arg1;
    }

    public fun add_chance(arg0: &mut 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::character::Character, arg1: u16, arg2: &0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::version::Version) {
        0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::version::assert_latest(arg2);
        let v0 = borrow_stats_mut(arg0);
        use_points(v0, arg1);
        v0.chance = v0.chance + arg1;
    }

    public fun add_intelligence(arg0: &mut 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::character::Character, arg1: u16, arg2: &0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::version::Version) {
        0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::version::assert_latest(arg2);
        let v0 = borrow_stats_mut(arg0);
        use_points(v0, arg1);
        v0.intelligence = v0.intelligence + arg1;
    }

    public fun add_strength(arg0: &mut 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::character::Character, arg1: u16, arg2: &0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::version::Version) {
        0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::version::assert_latest(arg2);
        let v0 = borrow_stats_mut(arg0);
        use_points(v0, arg1);
        v0.strength = v0.strength + arg1;
    }

    public(friend) fun add_to_character(arg0: &mut 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::character::Character) {
        let v0 = StatsKey{dummy_field: false};
        let v1 = CharacterStatistics{
            vitality         : 0,
            wisdom           : 0,
            strength         : 0,
            intelligence     : 0,
            chance           : 0,
            agility          : 0,
            available_points : 0,
        };
        0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::character::add_field<StatsKey, CharacterStatistics>(arg0, v0, v1);
    }

    public fun add_vitality(arg0: &mut 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::character::Character, arg1: u16, arg2: &0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::version::Version) {
        0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::version::assert_latest(arg2);
        let v0 = borrow_stats_mut(arg0);
        use_points(v0, arg1);
        v0.vitality = v0.vitality + arg1;
    }

    public fun add_wisdom(arg0: &mut 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::character::Character, arg1: u16, arg2: &0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::version::Version) {
        0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::version::assert_latest(arg2);
        let v0 = borrow_stats_mut(arg0);
        use_points(v0, arg1);
        v0.wisdom = v0.wisdom + arg1;
    }

    public fun admin_add_stat_points(arg0: &0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::admin::AdminCap, arg1: u16, arg2: &mut 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::character::Character, arg3: &0x2::tx_context::TxContext) {
        0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::admin::verify(arg0, arg3);
        let v0 = borrow_stats_mut(arg2);
        v0.available_points = v0.available_points + arg1;
    }

    fun borrow_stats_mut(arg0: &mut 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::character::Character) : &mut CharacterStatistics {
        let v0 = StatsKey{dummy_field: false};
        0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::character::borrow_field_mut<StatsKey, CharacterStatistics>(arg0, v0)
    }

    fun reset(arg0: &mut CharacterStatistics) {
        arg0.available_points = arg0.available_points + arg0.vitality + arg0.wisdom + arg0.strength + arg0.intelligence + arg0.chance + arg0.agility;
        arg0.vitality = 0;
        arg0.wisdom = 0;
        arg0.strength = 0;
        arg0.intelligence = 0;
        arg0.chance = 0;
        arg0.agility = 0;
    }

    public fun reset_character_stats(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &mut 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::character::Character, arg3: 0x2::object::ID, arg4: &0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::protected_policy::AresRPG_TransferPolicy<0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item::Item>, arg5: &0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::version::assert_latest(arg5);
        let v0 = 0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::protected_policy::extract_from_kiosk<0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item::Item>(arg4, arg0, arg1, arg3, arg6);
        0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item::assert_item_type(&v0, b"reset_orb");
        0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::item::destroy(v0);
        let v1 = borrow_stats_mut(arg2);
        reset(v1);
        let v2 = StatsResetEvent{character_id: 0x2::object::id<0x7d9e4be6689138a66c60876e64ee4dc17c2ec5fd37814f9d7cc796de6c10fcde::character::Character>(arg2)};
        0x2::event::emit<StatsResetEvent>(v2);
    }

    fun use_points(arg0: &mut CharacterStatistics, arg1: u16) {
        assert!(arg0.available_points >= arg1, 1);
        arg0.available_points = arg0.available_points - arg1;
    }

    // decompiled from Move bytecode v6
}

