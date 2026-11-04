module 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::release_schedule {
    struct ReleaseScheduleAbility has drop {
        dummy_field: bool,
    }

    struct ReleaseSchedule<phantom T0> has key {
        id: 0x2::object::UID,
        config: 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::schedule_config::ScheduleConfig,
    }

    struct ReleaseScheduleCreated<phantom T0> has copy, drop {
        schedule_id: 0x2::object::ID,
        sender: address,
    }

    public fun new<T0>(arg0: &0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::Auth<T0>, arg1: 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::schedule_config::ScheduleConfig, arg2: &mut 0x2::tx_context::TxContext) : ReleaseSchedule<T0> {
        assert!(0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::auth::has_ability<T0, ReleaseScheduleAbility>(arg0), 0);
        let v0 = ReleaseSchedule<T0>{
            id     : 0x2::object::new(arg2),
            config : arg1,
        };
        let v1 = ReleaseScheduleCreated<T0>{
            schedule_id : 0x2::object::id<ReleaseSchedule<T0>>(&v0),
            sender      : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<ReleaseScheduleCreated<T0>>(v1);
        v0
    }

    public fun calculate_unlocked<T0>(arg0: &ReleaseSchedule<T0>, arg1: u64, arg2: u64, arg3: u64) : u64 {
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::schedule_config::calculate_unlocked(arg0.config, arg1, arg2, arg3)
    }

    public fun config<T0>(arg0: &ReleaseSchedule<T0>) : &0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::schedule_config::ScheduleConfig {
        &arg0.config
    }

    public fun delay_until_first_release_in_ms<T0>(arg0: &ReleaseSchedule<T0>) : u64 {
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::schedule_config::delay_until_first_release_in_ms(&arg0.config)
    }

    public fun initial_release_portion_in_bps<T0>(arg0: &ReleaseSchedule<T0>) : u16 {
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::schedule_config::initial_release_portion_in_bps(&arg0.config)
    }

    public fun period_between_releases_in_ms<T0>(arg0: &ReleaseSchedule<T0>) : u64 {
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::schedule_config::period_between_releases_in_ms(&arg0.config)
    }

    public fun release_count<T0>(arg0: &ReleaseSchedule<T0>) : u64 {
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::schedule_config::release_count(&arg0.config)
    }

    public fun share<T0>(arg0: ReleaseSchedule<T0>) {
        0x2::transfer::share_object<ReleaseSchedule<T0>>(arg0);
    }

    // decompiled from Move bytecode v7
}

