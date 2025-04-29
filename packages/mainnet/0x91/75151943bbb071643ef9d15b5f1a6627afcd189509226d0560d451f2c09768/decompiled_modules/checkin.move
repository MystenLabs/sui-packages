module 0x9175151943bbb071643ef9d15b5f1a6627afcd189509226d0560d451f2c09768::checkin {
    struct CHECKIN has drop {
        dummy_field: bool,
    }

    struct EventCheckin has copy, drop, store {
        day: u8,
        last_checkin_time: u64,
        total_checkin_reward: u64,
    }

    public fun checkin<T0>(arg0: &0x9175151943bbb071643ef9d15b5f1a6627afcd189509226d0560d451f2c09768::config::Config, arg1: &mut 0x9175151943bbb071643ef9d15b5f1a6627afcd189509226d0560d451f2c09768::archive::UserArchive, arg2: &mut 0x9175151943bbb071643ef9d15b5f1a6627afcd189509226d0560d451f2c09768::pools::RewardPool<T0>, arg3: &0x2::clock::Clock, arg4: &0x9175151943bbb071643ef9d15b5f1a6627afcd189509226d0560d451f2c09768::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0x9175151943bbb071643ef9d15b5f1a6627afcd189509226d0560d451f2c09768::version::check_version(arg4, 0x9175151943bbb071643ef9d15b5f1a6627afcd189509226d0560d451f2c09768::version::module_type_checkin(), 1);
        0x9175151943bbb071643ef9d15b5f1a6627afcd189509226d0560d451f2c09768::config::validate_paused(arg0, 0x9175151943bbb071643ef9d15b5f1a6627afcd189509226d0560d451f2c09768::version::module_type_checkin());
        let v0 = 0x2::tx_context::sender(arg5);
        0x9175151943bbb071643ef9d15b5f1a6627afcd189509226d0560d451f2c09768::archive::validate_bird_archive(arg1, v0);
        assert!(0x9175151943bbb071643ef9d15b5f1a6627afcd189509226d0560d451f2c09768::pools::get_reward_balance<T0>(arg2) > 0, 5002);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = start_of_day(v1);
        let (_, v4, _, _, _, _, _) = 0x9175151943bbb071643ef9d15b5f1a6627afcd189509226d0560d451f2c09768::archive::get_archive(arg1);
        assert!(v4 < v2, 5001);
        let (v10, v11) = 0x9175151943bbb071643ef9d15b5f1a6627afcd189509226d0560d451f2c09768::archive::set_checkin(arg1, v2, 0x9175151943bbb071643ef9d15b5f1a6627afcd189509226d0560d451f2c09768::config::get_max_checkin_days(arg0), v1);
        let v12 = EventCheckin{
            day                  : v10,
            last_checkin_time    : v11,
            total_checkin_reward : 0x9175151943bbb071643ef9d15b5f1a6627afcd189509226d0560d451f2c09768::pools::transfer_checkin_reward<T0>(arg1, 0x9175151943bbb071643ef9d15b5f1a6627afcd189509226d0560d451f2c09768::config::get_checkin_reward(arg0, v10), arg2, v0, arg5),
        };
        0x2::event::emit<EventCheckin>(v12);
    }

    fun init(arg0: CHECKIN, arg1: &mut 0x2::tx_context::TxContext) {
    }

    fun start_of_day(arg0: u64) : u64 {
        arg0 / 86400000 * 86400000
    }

    // decompiled from Move bytecode v6
}

