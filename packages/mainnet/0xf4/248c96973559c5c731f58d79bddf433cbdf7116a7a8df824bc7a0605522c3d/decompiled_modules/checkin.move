module 0xf4248c96973559c5c731f58d79bddf433cbdf7116a7a8df824bc7a0605522c3d::checkin {
    struct CHECKIN has drop {
        dummy_field: bool,
    }

    struct EventCheckin has copy, drop, store {
        day: u8,
        last_checkin_time: u64,
        total_checkin_reward: u64,
    }

    public fun checkin<T0>(arg0: &0xf4248c96973559c5c731f58d79bddf433cbdf7116a7a8df824bc7a0605522c3d::config::Config, arg1: &mut 0xf4248c96973559c5c731f58d79bddf433cbdf7116a7a8df824bc7a0605522c3d::archive::UserArchive, arg2: &mut 0xf4248c96973559c5c731f58d79bddf433cbdf7116a7a8df824bc7a0605522c3d::pools::RewardPool<T0>, arg3: &0x2::clock::Clock, arg4: &0xf4248c96973559c5c731f58d79bddf433cbdf7116a7a8df824bc7a0605522c3d::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0xf4248c96973559c5c731f58d79bddf433cbdf7116a7a8df824bc7a0605522c3d::version::check_version(arg4, 0xf4248c96973559c5c731f58d79bddf433cbdf7116a7a8df824bc7a0605522c3d::version::module_type_checkin(), 1);
        0xf4248c96973559c5c731f58d79bddf433cbdf7116a7a8df824bc7a0605522c3d::config::validate_paused(arg0, 0xf4248c96973559c5c731f58d79bddf433cbdf7116a7a8df824bc7a0605522c3d::version::module_type_checkin());
        let v0 = 0x2::tx_context::sender(arg5);
        0xf4248c96973559c5c731f58d79bddf433cbdf7116a7a8df824bc7a0605522c3d::archive::validate_bird_archive(arg1, v0);
        assert!(0xf4248c96973559c5c731f58d79bddf433cbdf7116a7a8df824bc7a0605522c3d::pools::get_reward_balance<T0>(arg2) > 0, 5002);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = start_of_day(v1);
        let (v3, v4, _, _, _, _, _, _) = 0xf4248c96973559c5c731f58d79bddf433cbdf7116a7a8df824bc7a0605522c3d::archive::get_archive(arg1);
        assert!(v4 < v2, 5001);
        let (v11, v12) = 0xf4248c96973559c5c731f58d79bddf433cbdf7116a7a8df824bc7a0605522c3d::config::get_checkin_reward(arg0, v3);
        let (v13, v14) = 0xf4248c96973559c5c731f58d79bddf433cbdf7116a7a8df824bc7a0605522c3d::archive::set_checkin(arg1, v2, v11, v1);
        let v15 = EventCheckin{
            day                  : v13,
            last_checkin_time    : v14,
            total_checkin_reward : 0xf4248c96973559c5c731f58d79bddf433cbdf7116a7a8df824bc7a0605522c3d::pools::transfer_reward_checkin<T0>(arg1, v12, arg2, v0, arg5),
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

