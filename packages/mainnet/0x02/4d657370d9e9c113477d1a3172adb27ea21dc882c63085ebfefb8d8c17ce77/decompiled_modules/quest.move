module 0x24d657370d9e9c113477d1a3172adb27ea21dc882c63085ebfefb8d8c17ce77::quest {
    struct EventCheckin has copy, drop, store {
        user: address,
        day: u64,
        last_checkin_time: u64,
    }

    public fun migrate(arg0: &0x24d657370d9e9c113477d1a3172adb27ea21dc882c63085ebfefb8d8c17ce77::guild::AdminCap, arg1: &mut 0x24d657370d9e9c113477d1a3172adb27ea21dc882c63085ebfefb8d8c17ce77::guild::Config, arg2: u64) {
        0x24d657370d9e9c113477d1a3172adb27ea21dc882c63085ebfefb8d8c17ce77::guild::migrate(arg0, arg1, arg2);
    }

    public fun register(arg0: &mut 0x24d657370d9e9c113477d1a3172adb27ea21dc882c63085ebfefb8d8c17ce77::guild::Logs, arg1: &mut 0x24d657370d9e9c113477d1a3172adb27ea21dc882c63085ebfefb8d8c17ce77::guild::Config, arg2: &mut 0x2::tx_context::TxContext) : 0x24d657370d9e9c113477d1a3172adb27ea21dc882c63085ebfefb8d8c17ce77::guild::UserArchive {
        0x24d657370d9e9c113477d1a3172adb27ea21dc882c63085ebfefb8d8c17ce77::guild::register(arg0, arg1, arg2)
    }

    public fun set_max_check_in_days(arg0: &0x24d657370d9e9c113477d1a3172adb27ea21dc882c63085ebfefb8d8c17ce77::guild::AdminCap, arg1: &mut 0x24d657370d9e9c113477d1a3172adb27ea21dc882c63085ebfefb8d8c17ce77::guild::Config, arg2: u64) {
        0x24d657370d9e9c113477d1a3172adb27ea21dc882c63085ebfefb8d8c17ce77::guild::set_max_check_in_days(arg0, arg1, arg2);
    }

    public fun checkin(arg0: &0x24d657370d9e9c113477d1a3172adb27ea21dc882c63085ebfefb8d8c17ce77::guild::Config, arg1: &mut 0x24d657370d9e9c113477d1a3172adb27ea21dc882c63085ebfefb8d8c17ce77::guild::UserArchive, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x24d657370d9e9c113477d1a3172adb27ea21dc882c63085ebfefb8d8c17ce77::guild::verify_config(arg0, 0x1::string::utf8(b"QUEST_MODULE"));
        0x24d657370d9e9c113477d1a3172adb27ea21dc882c63085ebfefb8d8c17ce77::guild::validate_archive_owner(arg1, arg3);
        0x24d657370d9e9c113477d1a3172adb27ea21dc882c63085ebfefb8d8c17ce77::guild::init_checkin(arg1);
        let (v0, v1) = 0x24d657370d9e9c113477d1a3172adb27ea21dc882c63085ebfefb8d8c17ce77::guild::set_checkin(arg0, arg1, arg2);
        let v2 = EventCheckin{
            user              : 0x2::tx_context::sender(arg3),
            day               : v0,
            last_checkin_time : v1,
        };
        0x2::event::emit<EventCheckin>(v2);
    }

    public fun paused(arg0: &0x24d657370d9e9c113477d1a3172adb27ea21dc882c63085ebfefb8d8c17ce77::guild::AdminCap, arg1: &mut 0x24d657370d9e9c113477d1a3172adb27ea21dc882c63085ebfefb8d8c17ce77::guild::Config, arg2: bool) {
        0x24d657370d9e9c113477d1a3172adb27ea21dc882c63085ebfefb8d8c17ce77::guild::paused_v2(arg0, arg1, 0x1::string::utf8(b"QUEST_MODULE"), arg2);
    }

    // decompiled from Move bytecode v6
}

