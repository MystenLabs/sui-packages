module 0x7620ab6e09f11f48b84ad091f4fc5926bd92d739158fbc3a07ca7ed2d1c8aba3::quest {
    struct EventCheckin has copy, drop, store {
        day: u64,
        last_checkin_time: u64,
    }

    public fun migrate(arg0: &0x7620ab6e09f11f48b84ad091f4fc5926bd92d739158fbc3a07ca7ed2d1c8aba3::guild::AdminCap, arg1: &mut 0x7620ab6e09f11f48b84ad091f4fc5926bd92d739158fbc3a07ca7ed2d1c8aba3::guild::Config, arg2: u64) {
        0x7620ab6e09f11f48b84ad091f4fc5926bd92d739158fbc3a07ca7ed2d1c8aba3::guild::migrate(arg0, arg1, arg2);
    }

    public fun checkin(arg0: &0x7620ab6e09f11f48b84ad091f4fc5926bd92d739158fbc3a07ca7ed2d1c8aba3::guild::Config, arg1: &mut 0x7620ab6e09f11f48b84ad091f4fc5926bd92d739158fbc3a07ca7ed2d1c8aba3::guild::UserArchive, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x7620ab6e09f11f48b84ad091f4fc5926bd92d739158fbc3a07ca7ed2d1c8aba3::guild::verify_config(arg0, 0x1::string::utf8(b"QUEST_MODULE"));
        0x2::tx_context::sender(arg3);
        0x7620ab6e09f11f48b84ad091f4fc5926bd92d739158fbc3a07ca7ed2d1c8aba3::guild::validate_archive_owner(arg1, arg3);
        0x7620ab6e09f11f48b84ad091f4fc5926bd92d739158fbc3a07ca7ed2d1c8aba3::guild::init_checkin(arg1);
        let (v0, v1) = 0x7620ab6e09f11f48b84ad091f4fc5926bd92d739158fbc3a07ca7ed2d1c8aba3::guild::set_checkin(arg0, arg1, arg2);
        let v2 = EventCheckin{
            day               : v0,
            last_checkin_time : v1,
        };
        0x2::event::emit<EventCheckin>(v2);
    }

    public fun paused(arg0: &0x7620ab6e09f11f48b84ad091f4fc5926bd92d739158fbc3a07ca7ed2d1c8aba3::guild::AdminCap, arg1: &mut 0x7620ab6e09f11f48b84ad091f4fc5926bd92d739158fbc3a07ca7ed2d1c8aba3::guild::Config, arg2: bool) {
        0x7620ab6e09f11f48b84ad091f4fc5926bd92d739158fbc3a07ca7ed2d1c8aba3::guild::paused_v2(arg0, arg1, 0x1::string::utf8(b"QUEST_MODULE"), arg2);
    }

    // decompiled from Move bytecode v6
}

