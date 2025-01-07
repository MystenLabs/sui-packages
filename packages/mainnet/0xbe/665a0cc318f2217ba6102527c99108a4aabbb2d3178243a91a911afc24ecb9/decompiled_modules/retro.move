module 0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::retro {
    struct RetroUserInfo has store {
        s1_alloc: u64,
        s2_alloc: u64,
    }

    struct RetroUsersList has key {
        id: 0x2::object::UID,
        users: 0x2::table::Table<address, RetroUserInfo>,
    }

    public fun add_user(arg0: &0xbe665a0cc318f2217ba6102527c99108a4aabbb2d3178243a91a911afc24ecb9::admin::AdminCap, arg1: &mut RetroUsersList, arg2: address, arg3: u64, arg4: u64) {
        let v0 = RetroUserInfo{
            s1_alloc : arg3,
            s2_alloc : arg4,
        };
        0x2::table::add<address, RetroUserInfo>(&mut arg1.users, arg2, v0);
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

