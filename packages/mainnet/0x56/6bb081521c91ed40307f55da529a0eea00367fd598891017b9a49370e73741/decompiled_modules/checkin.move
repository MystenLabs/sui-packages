module 0x4303ab2dddffa047975448b71240f0e7ddbe174f41024bd898f7b3023d274f4e::checkin {
    struct CHECKIN has drop {
        dummy_field: bool,
    }

    struct EventCheckin has copy, drop, store {
        day: u8,
        last_checkin_time: u64,
        total_checkin_reward: u64,
    }

    public fun checkin<T0>(arg0: &0x4303ab2dddffa047975448b71240f0e7ddbe174f41024bd898f7b3023d274f4e::config::Config, arg1: &mut 0x4303ab2dddffa047975448b71240f0e7ddbe174f41024bd898f7b3023d274f4e::archive::UserArchive, arg2: &mut 0x4303ab2dddffa047975448b71240f0e7ddbe174f41024bd898f7b3023d274f4e::pools::RewardPool<T0>, arg3: &0x2::clock::Clock, arg4: &0x4303ab2dddffa047975448b71240f0e7ddbe174f41024bd898f7b3023d274f4e::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0x4303ab2dddffa047975448b71240f0e7ddbe174f41024bd898f7b3023d274f4e::version::check_version(arg4, 0x4303ab2dddffa047975448b71240f0e7ddbe174f41024bd898f7b3023d274f4e::version::module_type_checkin(), 1);
        0x4303ab2dddffa047975448b71240f0e7ddbe174f41024bd898f7b3023d274f4e::config::validate_paused(arg0, 0x4303ab2dddffa047975448b71240f0e7ddbe174f41024bd898f7b3023d274f4e::version::module_type_checkin());
        let v0 = 0x2::tx_context::sender(arg5);
        0x4303ab2dddffa047975448b71240f0e7ddbe174f41024bd898f7b3023d274f4e::archive::validate_bird_archive(arg1, v0);
        assert!(0x4303ab2dddffa047975448b71240f0e7ddbe174f41024bd898f7b3023d274f4e::pools::get_reward_balance<T0>(arg2) > 0, 5002);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = start_of_day(v1);
        let (_, v4, _, _, _, _, _) = 0x4303ab2dddffa047975448b71240f0e7ddbe174f41024bd898f7b3023d274f4e::archive::get_archive(arg1);
        assert!(v4 < v2, 5001);
        let (v10, v11) = 0x4303ab2dddffa047975448b71240f0e7ddbe174f41024bd898f7b3023d274f4e::archive::set_checkin(arg1, v2, 0x4303ab2dddffa047975448b71240f0e7ddbe174f41024bd898f7b3023d274f4e::config::get_max_checkin_days(arg0), v1);
        let v12 = EventCheckin{
            day                  : v10,
            last_checkin_time    : v11,
            total_checkin_reward : 0x4303ab2dddffa047975448b71240f0e7ddbe174f41024bd898f7b3023d274f4e::pools::transfer_checkin_reward<T0>(arg1, 0x4303ab2dddffa047975448b71240f0e7ddbe174f41024bd898f7b3023d274f4e::config::get_checkin_reward(arg0, v10), arg2, v0, arg5),
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

