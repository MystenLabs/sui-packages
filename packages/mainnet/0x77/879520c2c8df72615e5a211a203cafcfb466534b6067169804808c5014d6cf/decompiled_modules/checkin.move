module 0x77879520c2c8df72615e5a211a203cafcfb466534b6067169804808c5014d6cf::checkin {
    struct CHECKIN has drop {
        dummy_field: bool,
    }

    struct EventCheckin has copy, drop, store {
        day: u8,
        last_checkin_time: u64,
        total_checkin_reward: u64,
    }

    public fun checkin<T0>(arg0: &0x77879520c2c8df72615e5a211a203cafcfb466534b6067169804808c5014d6cf::config::Config, arg1: &mut 0x77879520c2c8df72615e5a211a203cafcfb466534b6067169804808c5014d6cf::archive::UserArchive, arg2: &mut 0x77879520c2c8df72615e5a211a203cafcfb466534b6067169804808c5014d6cf::pools::RewardPool<T0>, arg3: &0x2::clock::Clock, arg4: &0x77879520c2c8df72615e5a211a203cafcfb466534b6067169804808c5014d6cf::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0x77879520c2c8df72615e5a211a203cafcfb466534b6067169804808c5014d6cf::version::check_version(arg4, 0x77879520c2c8df72615e5a211a203cafcfb466534b6067169804808c5014d6cf::version::module_type_checkin(), 1);
        0x77879520c2c8df72615e5a211a203cafcfb466534b6067169804808c5014d6cf::config::validate_paused(arg0, 0x77879520c2c8df72615e5a211a203cafcfb466534b6067169804808c5014d6cf::version::module_type_checkin());
        let v0 = 0x2::tx_context::sender(arg5);
        0x77879520c2c8df72615e5a211a203cafcfb466534b6067169804808c5014d6cf::archive::validate_bird_archive(arg1, v0);
        assert!(0x77879520c2c8df72615e5a211a203cafcfb466534b6067169804808c5014d6cf::pools::get_reward_balance<T0>(arg2) > 0, 5002);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = start_of_day(v1);
        let (_, v4, _, _, _, _, _) = 0x77879520c2c8df72615e5a211a203cafcfb466534b6067169804808c5014d6cf::archive::get_archive(arg1);
        assert!(v4 < v2, 5001);
        let (v10, v11) = 0x77879520c2c8df72615e5a211a203cafcfb466534b6067169804808c5014d6cf::archive::set_checkin(arg1, v2, 0x77879520c2c8df72615e5a211a203cafcfb466534b6067169804808c5014d6cf::config::get_max_checkin_days(arg0), v1);
        let v12 = EventCheckin{
            day                  : v10,
            last_checkin_time    : v11,
            total_checkin_reward : 0x77879520c2c8df72615e5a211a203cafcfb466534b6067169804808c5014d6cf::pools::transfer_checkin_reward<T0>(arg1, 0x77879520c2c8df72615e5a211a203cafcfb466534b6067169804808c5014d6cf::config::get_checkin_reward(arg0, v10), arg2, v0, arg5),
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

