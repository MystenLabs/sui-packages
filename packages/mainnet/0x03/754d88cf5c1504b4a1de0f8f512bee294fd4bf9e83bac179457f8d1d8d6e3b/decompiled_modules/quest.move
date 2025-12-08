module 0xcdd2b74ffd1271fd32ce2d6dd5954434eb9b962e44b82647f6af4ec98bd8a54a::quest {
    struct EventCheckin has copy, drop, store {
        day: u64,
        last_checkin_time: u64,
    }

    public fun migrate(arg0: &0xcdd2b74ffd1271fd32ce2d6dd5954434eb9b962e44b82647f6af4ec98bd8a54a::guild::AdminCap, arg1: &mut 0xcdd2b74ffd1271fd32ce2d6dd5954434eb9b962e44b82647f6af4ec98bd8a54a::guild::Config, arg2: u64) {
        0xcdd2b74ffd1271fd32ce2d6dd5954434eb9b962e44b82647f6af4ec98bd8a54a::guild::migrate(arg0, arg1, arg2);
    }

    public fun checkin(arg0: &0xcdd2b74ffd1271fd32ce2d6dd5954434eb9b962e44b82647f6af4ec98bd8a54a::guild::Config, arg1: &mut 0xcdd2b74ffd1271fd32ce2d6dd5954434eb9b962e44b82647f6af4ec98bd8a54a::guild::UserArchive, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xcdd2b74ffd1271fd32ce2d6dd5954434eb9b962e44b82647f6af4ec98bd8a54a::guild::verify_config(arg0, 0x1::string::utf8(b"QUEST_MODULE"));
        0x2::tx_context::sender(arg3);
        0xcdd2b74ffd1271fd32ce2d6dd5954434eb9b962e44b82647f6af4ec98bd8a54a::guild::validate_archive_owner(arg1, arg3);
        0xcdd2b74ffd1271fd32ce2d6dd5954434eb9b962e44b82647f6af4ec98bd8a54a::guild::init_checkin(arg1);
        let (v0, v1) = 0xcdd2b74ffd1271fd32ce2d6dd5954434eb9b962e44b82647f6af4ec98bd8a54a::guild::set_checkin(arg0, arg1, arg2);
        let v2 = EventCheckin{
            day               : v0,
            last_checkin_time : v1,
        };
        0x2::event::emit<EventCheckin>(v2);
    }

    public fun paused(arg0: &0xcdd2b74ffd1271fd32ce2d6dd5954434eb9b962e44b82647f6af4ec98bd8a54a::guild::AdminCap, arg1: &mut 0xcdd2b74ffd1271fd32ce2d6dd5954434eb9b962e44b82647f6af4ec98bd8a54a::guild::Config, arg2: bool) {
        0xcdd2b74ffd1271fd32ce2d6dd5954434eb9b962e44b82647f6af4ec98bd8a54a::guild::paused_v2(arg0, arg1, 0x1::string::utf8(b"QUEST_MODULE"), arg2);
    }

    // decompiled from Move bytecode v6
}

