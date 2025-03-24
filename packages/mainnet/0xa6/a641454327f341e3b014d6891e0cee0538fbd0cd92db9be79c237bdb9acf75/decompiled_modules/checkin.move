module 0xa6a641454327f341e3b014d6891e0cee0538fbd0cd92db9be79c237bdb9acf75::checkin {
    struct CHECKIN has drop {
        dummy_field: bool,
    }

    struct EventCheckin has copy, drop, store {
        day: u8,
        last_checkin_time: u64,
        total_checkin_reward: u64,
    }

    public fun checkin<T0>(arg0: &0xa6a641454327f341e3b014d6891e0cee0538fbd0cd92db9be79c237bdb9acf75::config::Config, arg1: &mut 0xa6a641454327f341e3b014d6891e0cee0538fbd0cd92db9be79c237bdb9acf75::archive::UserArchive, arg2: &mut 0xa6a641454327f341e3b014d6891e0cee0538fbd0cd92db9be79c237bdb9acf75::pools::RewardPool<T0>, arg3: &0x2::clock::Clock, arg4: &0xa6a641454327f341e3b014d6891e0cee0538fbd0cd92db9be79c237bdb9acf75::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0xa6a641454327f341e3b014d6891e0cee0538fbd0cd92db9be79c237bdb9acf75::version::check_version(arg4, 0xa6a641454327f341e3b014d6891e0cee0538fbd0cd92db9be79c237bdb9acf75::version::module_type_checkin(), 1);
        0xa6a641454327f341e3b014d6891e0cee0538fbd0cd92db9be79c237bdb9acf75::config::validate_paused(arg0, 0xa6a641454327f341e3b014d6891e0cee0538fbd0cd92db9be79c237bdb9acf75::version::module_type_checkin());
        let v0 = 0x2::tx_context::sender(arg5);
        0xa6a641454327f341e3b014d6891e0cee0538fbd0cd92db9be79c237bdb9acf75::archive::validate_bird_archive(arg1, v0);
        assert!(0xa6a641454327f341e3b014d6891e0cee0538fbd0cd92db9be79c237bdb9acf75::pools::get_reward_balance<T0>(arg2) > 0, 5002);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = start_of_day(v1);
        let (v3, v4, _, _, _, _, _, _) = 0xa6a641454327f341e3b014d6891e0cee0538fbd0cd92db9be79c237bdb9acf75::archive::get_archive(arg1);
        assert!(v4 < v2, 5001);
        let (v11, v12) = 0xa6a641454327f341e3b014d6891e0cee0538fbd0cd92db9be79c237bdb9acf75::config::get_checkin_reward(arg0, v3);
        let (v13, v14) = 0xa6a641454327f341e3b014d6891e0cee0538fbd0cd92db9be79c237bdb9acf75::archive::set_checkin(arg1, v2, v11, v1);
        let v15 = EventCheckin{
            day                  : v13,
            last_checkin_time    : v14,
            total_checkin_reward : 0xa6a641454327f341e3b014d6891e0cee0538fbd0cd92db9be79c237bdb9acf75::pools::transfer_reward_checkin<T0>(arg1, v12, arg2, v0, arg5),
        };
        0x2::event::emit<EventCheckin>(v15);
    }

    fun init(arg0: CHECKIN, arg1: &mut 0x2::tx_context::TxContext) {
    }

    fun start_of_day(arg0: u64) : u64 {
        arg0 / 86400000 * 86400000
    }

    // decompiled from Move bytecode v6
}

