module 0x47d4499e61957043528233e970d1154cd63f5e73f1ce51b29aa7fe972ce5625a::quest {
    struct EventCheckin has copy, drop, store {
        day: u64,
        last_checkin_time: u64,
    }

    public fun migrate(arg0: &0x47d4499e61957043528233e970d1154cd63f5e73f1ce51b29aa7fe972ce5625a::guild::AdminCap, arg1: &mut 0x47d4499e61957043528233e970d1154cd63f5e73f1ce51b29aa7fe972ce5625a::guild::Config, arg2: u64) {
        0x47d4499e61957043528233e970d1154cd63f5e73f1ce51b29aa7fe972ce5625a::guild::migrate(arg0, arg1, arg2);
    }

    public fun checkin(arg0: &0x47d4499e61957043528233e970d1154cd63f5e73f1ce51b29aa7fe972ce5625a::guild::Config, arg1: &mut 0x47d4499e61957043528233e970d1154cd63f5e73f1ce51b29aa7fe972ce5625a::guild::UserArchive, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x47d4499e61957043528233e970d1154cd63f5e73f1ce51b29aa7fe972ce5625a::guild::verify_config(arg0, 0x1::string::utf8(b"QUEST_MODULE"));
        0x2::tx_context::sender(arg3);
        0x47d4499e61957043528233e970d1154cd63f5e73f1ce51b29aa7fe972ce5625a::guild::validate_archive_owner(arg1, arg3);
        0x47d4499e61957043528233e970d1154cd63f5e73f1ce51b29aa7fe972ce5625a::guild::init_checkin(arg1);
        let (v0, v1) = 0x47d4499e61957043528233e970d1154cd63f5e73f1ce51b29aa7fe972ce5625a::guild::set_checkin(arg0, arg1, arg2);
        let v2 = EventCheckin{
            day               : v0,
            last_checkin_time : v1,
        };
        0x2::event::emit<EventCheckin>(v2);
    }

    public fun paused(arg0: &0x47d4499e61957043528233e970d1154cd63f5e73f1ce51b29aa7fe972ce5625a::guild::AdminCap, arg1: &mut 0x47d4499e61957043528233e970d1154cd63f5e73f1ce51b29aa7fe972ce5625a::guild::Config, arg2: bool) {
        0x47d4499e61957043528233e970d1154cd63f5e73f1ce51b29aa7fe972ce5625a::guild::paused_v2(arg0, arg1, 0x1::string::utf8(b"QUEST_MODULE"), arg2);
    }

    // decompiled from Move bytecode v6
}

