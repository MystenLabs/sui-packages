module 0x8f872e7ee6d62402fa934a908bb238931778fe11513e0a8ecc72487b93aae294::profile_and_rank {
    struct Profile has copy, drop, store {
        image_url: 0x1::string::String,
        username: 0x1::string::String,
        trophies: u64,
    }

    struct ProfileTable has key {
        id: 0x2::object::UID,
        profiles: 0x2::table::Table<address, Profile>,
        version: u64,
    }

    public entry fun add_or_update_profile(arg0: &mut ProfileTable, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = Profile{
            image_url : arg1,
            username  : arg2,
            trophies  : 50,
        };
        if (0x2::table::contains<address, Profile>(&arg0.profiles, v0)) {
            let v2 = 0x2::table::borrow_mut<address, Profile>(&mut arg0.profiles, v0);
            v2.image_url = arg1;
            v2.username = arg2;
        } else {
            0x2::table::add<address, Profile>(&mut arg0.profiles, v0, v1);
        };
    }

    fun check_version_ProfileTable(arg0: &ProfileTable) {
        assert!(arg0.version == 1, 1);
    }

    public(friend) fun get_trophies(arg0: &ProfileTable, arg1: address) : u64 {
        view_profile(arg0, arg1).trophies
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ProfileTable{
            id       : 0x2::object::new(arg0),
            profiles : 0x2::table::new<address, Profile>(arg0),
            version  : 1,
        };
        0x2::transfer::share_object<ProfileTable>(v0);
    }

    public fun subtract_not_under_zero(arg0: u64, arg1: u64) : u64 {
        if (arg0 >= arg1) {
            return arg0 - arg1
        };
        0
    }

    public(friend) fun update_both_trophies_after_win(arg0: &mut ProfileTable, arg1: u64, arg2: address, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        check_version_ProfileTable(arg0);
        let v0 = view_profile(arg0, arg2).trophies;
        let v1 = view_profile(arg0, arg3).trophies;
        assert!(arg1 != 0, 1);
        if (arg1 == 1) {
            let v2 = 5;
            if (v0 < v1) {
                v2 = 0x1::u64::min(0x1::u64::divide_and_round_up(v1 - v0, 2), 25);
            };
            update_trophies(arg0, v2, true, arg2, arg4);
            update_trophies(arg0, v2, false, arg3, arg4);
        } else {
            let v3 = 5;
            if (v1 < v0) {
                v3 = 0x1::u64::min(0x1::u64::divide_and_round_up(v0 - v1, 2), 25);
            };
            update_trophies(arg0, v3, true, arg3, arg4);
            update_trophies(arg0, v3, false, arg2, arg4);
        };
    }

    public(friend) entry fun update_trophies(arg0: &mut ProfileTable, arg1: u64, arg2: bool, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<address, Profile>(&arg0.profiles, arg3), 0);
        let v0 = 0x2::table::borrow_mut<address, Profile>(&mut arg0.profiles, arg3);
        if (arg2) {
            v0.trophies = v0.trophies + arg1;
        } else {
            v0.trophies = subtract_not_under_zero(v0.trophies, arg1);
        };
    }

    public entry fun update_version(arg0: &0x8f872e7ee6d62402fa934a908bb238931778fe11513e0a8ecc72487b93aae294::FFIO::FindFourAdminCap, arg1: &mut ProfileTable) {
        arg1.version = 1;
    }

    public(friend) fun view_profile(arg0: &ProfileTable, arg1: address) : &Profile {
        assert!(0x2::table::contains<address, Profile>(&arg0.profiles, arg1), 0);
        0x2::table::borrow<address, Profile>(&arg0.profiles, arg1)
    }

    // decompiled from Move bytecode v6
}

