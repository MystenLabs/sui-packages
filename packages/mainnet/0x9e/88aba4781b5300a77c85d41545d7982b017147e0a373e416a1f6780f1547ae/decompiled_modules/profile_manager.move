module 0x9e88aba4781b5300a77c85d41545d7982b017147e0a373e416a1f6780f1547ae::profile_manager {
    struct NewProfile<phantom T0> has copy, drop {
        player: address,
        senior: 0x1::option::Option<address>,
        rank: u64,
        is_from_open: bool,
    }

    struct ProfileManager has key {
        id: 0x2::object::UID,
        map: 0x2::table::Table<address, Profile>,
    }

    struct Profile has store {
        senior: 0x1::option::Option<address>,
        juniors: 0xad70e60e8631f45b6c528bdf054a733c57d6e979bc601b2b8d1c10ce12d39866::big_vector::BigVector<address>,
        team_size: u64,
        rank: u64,
        score: u64,
    }

    struct SELF has drop {
        dummy_field: bool,
    }

    fun add_score_recursively(arg0: &mut 0x2::table::Table<address, Profile>, arg1: 0x1::option::Option<address>, arg2: u64) {
        let v0 = 0;
        while (0x1::option::is_some<address>(&arg1) && v0 < arg2) {
            let v1 = 0x2::table::borrow_mut<address, Profile>(arg0, *0x1::option::borrow<address>(&arg1));
            v1.score = v1.score + 1;
            arg1 = v1.senior;
            v0 = v0 + 1;
        };
    }

    public(friend) fun create_profile<T0>(arg0: &mut ProfileManager, arg1: address, arg2: 0x1::option::Option<address>, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg0.map;
        if (0x2::table::contains<address, Profile>(v0, arg1)) {
            return
        };
        let v1 = if (0x1::option::is_some<address>(&arg2)) {
            let v2 = *0x1::option::borrow<address>(&arg2);
            if (arg1 == v2) {
                err_self_recruited();
            };
            if (!0x2::table::contains<address, Profile>(v0, v2)) {
                err_exceed_team_size();
            };
            let v3 = 0x2::table::borrow_mut<address, Profile>(v0, v2);
            let v4 = v3.rank;
            0xad70e60e8631f45b6c528bdf054a733c57d6e979bc601b2b8d1c10ce12d39866::big_vector::push_back<address>(&mut v3.juniors, arg1);
            if (0xad70e60e8631f45b6c528bdf054a733c57d6e979bc601b2b8d1c10ce12d39866::big_vector::length<address>(&v3.juniors) > v3.team_size) {
                err_exceed_team_size();
            };
            let v5 = Profile{
                senior    : 0x1::option::some<address>(v2),
                juniors   : 0xad70e60e8631f45b6c528bdf054a733c57d6e979bc601b2b8d1c10ce12d39866::big_vector::new<address>(1000, arg4),
                team_size : 0,
                rank      : v4 + 1,
                score     : 0,
            };
            0x2::table::add<address, Profile>(v0, arg1, v5);
            add_score_recursively(v0, arg2, 0x9e88aba4781b5300a77c85d41545d7982b017147e0a373e416a1f6780f1547ae::config::max_referral_depth());
            v4 + 1
        } else {
            let v6 = Profile{
                senior    : arg2,
                juniors   : 0xad70e60e8631f45b6c528bdf054a733c57d6e979bc601b2b8d1c10ce12d39866::big_vector::new<address>(1000, arg4),
                team_size : 0,
                rank      : 0,
                score     : 0,
            };
            0x2::table::add<address, Profile>(v0, arg1, v6);
            0
        };
        let v7 = NewProfile<T0>{
            player       : arg1,
            senior       : arg2,
            rank         : v1,
            is_from_open : arg3,
        };
        0x2::event::emit<NewProfile<T0>>(v7);
    }

    fun err_exceed_team_size() {
        abort 1
    }

    fun err_self_recruited() {
        abort 0
    }

    public(friend) fun extend_team_size(arg0: &mut ProfileManager, arg1: address, arg2: u64) {
        if (0x2::table::contains<address, Profile>(&arg0.map, arg1)) {
            let v0 = 0x2::table::borrow_mut<address, Profile>(&mut arg0.map, arg1);
            if (v0.team_size == 0x9e88aba4781b5300a77c85d41545d7982b017147e0a373e416a1f6780f1547ae::math::max_u64()) {
                return
            };
            v0.team_size = v0.team_size + 3 * arg2;
            if (v0.team_size >= 30) {
                v0.team_size = 0x9e88aba4781b5300a77c85d41545d7982b017147e0a373e416a1f6780f1547ae::math::max_u64();
            };
        };
    }

    fun get_direct_senior(arg0: &0x2::table::Table<address, Profile>, arg1: address) : 0x1::option::Option<address> {
        if (0x2::table::contains<address, Profile>(arg0, arg1)) {
            0x2::table::borrow<address, Profile>(arg0, arg1).senior
        } else {
            0x1::option::none<address>()
        }
    }

    public fun get_score(arg0: &ProfileManager, arg1: address) : u64 {
        let v0 = &arg0.map;
        if (0x2::table::contains<address, Profile>(v0, arg1)) {
            0x2::table::borrow<address, Profile>(v0, arg1).score
        } else {
            0
        }
    }

    public fun get_seniors(arg0: &ProfileManager, arg1: address) : (0x1::option::Option<address>, vector<address>) {
        let v0 = &arg0.map;
        if (!0x2::table::contains<address, Profile>(v0, arg1)) {
            return (0x1::option::none<address>(), vector[])
        };
        let v1 = 0x2::table::borrow<address, Profile>(v0, arg1);
        if (0x1::option::is_none<address>(&v1.senior)) {
            return (v1.senior, vector[])
        };
        let v2 = vector[];
        let v3 = 0;
        let v4 = get_direct_senior(v0, *0x1::option::borrow<address>(&v1.senior));
        while (0x1::option::is_some<address>(&v4) && v3 < 0x9e88aba4781b5300a77c85d41545d7982b017147e0a373e416a1f6780f1547ae::config::max_referral_depth()) {
            0x1::vector::push_back<address>(&mut v2, *0x1::option::borrow<address>(&v4));
            v3 = v3 + 1;
        };
        (v1.senior, v2)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ProfileManager{
            id  : 0x2::object::new(arg0),
            map : 0x2::table::new<address, Profile>(arg0),
        };
        0x2::transfer::share_object<ProfileManager>(v0);
    }

    public fun set_referrer(arg0: &mut ProfileManager, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        create_profile<SELF>(arg0, v0, 0x1::option::some<address>(arg1), false, arg2);
    }

    // decompiled from Move bytecode v6
}

