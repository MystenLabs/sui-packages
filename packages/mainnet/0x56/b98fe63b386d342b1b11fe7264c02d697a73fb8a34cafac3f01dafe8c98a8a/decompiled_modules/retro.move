module 0x56b98fe63b386d342b1b11fe7264c02d697a73fb8a34cafac3f01dafe8c98a8a::retro {
    struct RetroUserInfo has store {
        s1_alloc: u64,
        s2_alloc: u64,
    }

    struct RetroUsersList has key {
        id: 0x2::object::UID,
        users: 0x2::table::Table<address, RetroUserInfo>,
    }

    public fun add_user(arg0: &0x56b98fe63b386d342b1b11fe7264c02d697a73fb8a34cafac3f01dafe8c98a8a::admin::AdminCap, arg1: &mut RetroUsersList, arg2: address, arg3: u64, arg4: u64) {
        let v0 = RetroUserInfo{
            s1_alloc : arg3,
            s2_alloc : arg4,
        };
        0x2::table::add<address, RetroUserInfo>(&mut arg1.users, arg2, v0);
    }

    public fun assert_exists(arg0: &RetroUsersList, arg1: address) {
        assert!(exists(arg0, arg1), 42);
    }

    public fun assert_not_exists(arg0: &RetroUsersList, arg1: address) {
        assert!(!exists(arg0, arg1), 42);
    }

    public fun exists(arg0: &RetroUsersList, arg1: address) : bool {
        0x2::table::contains<address, RetroUserInfo>(&arg0.users, arg1)
    }

    public fun get_user_info(arg0: &RetroUsersList, arg1: address) : (u64, u64) {
        let v0 = 0x2::table::borrow<address, RetroUserInfo>(&arg0.users, arg1);
        (v0.s1_alloc, v0.s2_alloc)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RetroUsersList{
            id    : 0x2::object::new(arg0),
            users : 0x2::table::new<address, RetroUserInfo>(arg0),
        };
        0x2::transfer::share_object<RetroUsersList>(v0);
    }

    // decompiled from Move bytecode v6
}

