module 0x8d30bd6b46cf6c31b2c253cf3a93ab163cea960e3cf2c1de625e90f020ecd8f9::admin {
    struct ADMIN has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct JetpackCounter has key {
        id: 0x2::object::UID,
        count: u64,
        minted: 0x2::table::Table<address, u64>,
    }

    public(friend) fun clear_mint(arg0: &mut JetpackCounter, arg1: address) {
        if (0x2::table::contains<address, u64>(&arg0.minted, arg1)) {
            0x2::table::remove<address, u64>(&mut arg0.minted, arg1);
        };
    }

    public fun counter_value(arg0: &JetpackCounter) : u64 {
        arg0.count
    }

    public fun has_minted(arg0: &JetpackCounter, arg1: address) : bool {
        0x2::table::contains<address, u64>(&arg0.minted, arg1)
    }

    fun init(arg0: ADMIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<ADMIN>(arg0, arg1);
        let v1 = 0x2::display::new<0x8d30bd6b46cf6c31b2c253cf3a93ab163cea960e3cf2c1de625e90f020ecd8f9::jetpack::JetpackConso>(&v0, arg1);
        0x2::display::add<0x8d30bd6b46cf6c31b2c253cf3a93ab163cea960e3cf2c1de625e90f020ecd8f9::jetpack::JetpackConso>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Jetpack Conso #{jetpack_id}"));
        0x2::display::add<0x8d30bd6b46cf6c31b2c253cf3a93ab163cea960e3cf2c1de625e90f020ecd8f9::jetpack::JetpackConso>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{play_count} Plays | Highest Score {highest_score} m | Total Distance {total_distance} m | {total_zaps} Zaps"));
        0x2::display::add<0x8d30bd6b46cf6c31b2c253cf3a93ab163cea960e3cf2c1de625e90f020ecd8f9::jetpack::JetpackConso>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://api.conso.xyz/jetpack/{player}"));
        0x2::display::add<0x8d30bd6b46cf6c31b2c253cf3a93ab163cea960e3cf2c1de625e90f020ecd8f9::jetpack::JetpackConso>(&mut v1, 0x1::string::utf8(b"link"), 0x1::string::utf8(b"https://jetpack.conso.xyz"));
        0x2::display::add<0x8d30bd6b46cf6c31b2c253cf3a93ab163cea960e3cf2c1de625e90f020ecd8f9::jetpack::JetpackConso>(&mut v1, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://conso.xyz"));
        0x2::display::add<0x8d30bd6b46cf6c31b2c253cf3a93ab163cea960e3cf2c1de625e90f020ecd8f9::jetpack::JetpackConso>(&mut v1, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"Conso Labs"));
        0x2::display::update_version<0x8d30bd6b46cf6c31b2c253cf3a93ab163cea960e3cf2c1de625e90f020ecd8f9::jetpack::JetpackConso>(&mut v1);
        0x2::transfer::public_transfer<0x2::display::Display<0x8d30bd6b46cf6c31b2c253cf3a93ab163cea960e3cf2c1de625e90f020ecd8f9::jetpack::JetpackConso>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        let v2 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v2, 0x2::tx_context::sender(arg1));
        let v3 = JetpackCounter{
            id     : 0x2::object::new(arg1),
            count  : 0,
            minted : 0x2::table::new<address, u64>(arg1),
        };
        0x2::transfer::share_object<JetpackCounter>(v3);
    }

    public(friend) fun next_jetpack_id(arg0: &mut JetpackCounter) : u64 {
        arg0.count = arg0.count + 1;
        arg0.count
    }

    public(friend) fun record_mint(arg0: &mut JetpackCounter, arg1: address, arg2: u64) {
        0x2::table::add<address, u64>(&mut arg0.minted, arg1, arg2);
    }

    // decompiled from Move bytecode v7
}

