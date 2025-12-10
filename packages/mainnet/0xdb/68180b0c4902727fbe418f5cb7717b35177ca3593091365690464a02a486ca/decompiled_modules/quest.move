module 0xe6112bc4ebba8265aaf39292eb93a3d18b8c54f9ca626fbe8335d8d92094b1f9::quest {
    struct EventCheckin has copy, drop, store {
        user: address,
        day: u64,
        last_checkin_time: u64,
    }

    public fun migrate(arg0: &0xe6112bc4ebba8265aaf39292eb93a3d18b8c54f9ca626fbe8335d8d92094b1f9::guild::AdminCap, arg1: &mut 0xe6112bc4ebba8265aaf39292eb93a3d18b8c54f9ca626fbe8335d8d92094b1f9::guild::Config, arg2: u64) {
        0xe6112bc4ebba8265aaf39292eb93a3d18b8c54f9ca626fbe8335d8d92094b1f9::guild::migrate(arg0, arg1, arg2);
    }

    public fun checkin(arg0: &0xe6112bc4ebba8265aaf39292eb93a3d18b8c54f9ca626fbe8335d8d92094b1f9::guild::Config, arg1: &mut 0xe6112bc4ebba8265aaf39292eb93a3d18b8c54f9ca626fbe8335d8d92094b1f9::guild::UserArchive, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xe6112bc4ebba8265aaf39292eb93a3d18b8c54f9ca626fbe8335d8d92094b1f9::guild::verify_config(arg0, 0x1::string::utf8(b"QUEST_MODULE"));
        0xe6112bc4ebba8265aaf39292eb93a3d18b8c54f9ca626fbe8335d8d92094b1f9::guild::validate_archive_owner(arg1, arg3);
        0xe6112bc4ebba8265aaf39292eb93a3d18b8c54f9ca626fbe8335d8d92094b1f9::guild::init_checkin(arg1);
        let (v0, v1) = 0xe6112bc4ebba8265aaf39292eb93a3d18b8c54f9ca626fbe8335d8d92094b1f9::guild::set_checkin(arg0, arg1, arg2);
        let v2 = EventCheckin{
            user              : 0x2::tx_context::sender(arg3),
            day               : v0,
            last_checkin_time : v1,
        };
        0x2::event::emit<EventCheckin>(v2);
    }

    public fun paused(arg0: &0xe6112bc4ebba8265aaf39292eb93a3d18b8c54f9ca626fbe8335d8d92094b1f9::guild::AdminCap, arg1: &mut 0xe6112bc4ebba8265aaf39292eb93a3d18b8c54f9ca626fbe8335d8d92094b1f9::guild::Config, arg2: bool) {
        0xe6112bc4ebba8265aaf39292eb93a3d18b8c54f9ca626fbe8335d8d92094b1f9::guild::paused_v2(arg0, arg1, 0x1::string::utf8(b"QUEST_MODULE"), arg2);
    }

    // decompiled from Move bytecode v6
}

