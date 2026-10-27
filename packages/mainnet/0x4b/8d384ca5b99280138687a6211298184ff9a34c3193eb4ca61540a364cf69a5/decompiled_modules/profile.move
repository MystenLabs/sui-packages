module 0x4b8d384ca5b99280138687a6211298184ff9a34c3193eb4ca61540a364cf69a5::profile {
    struct Profile has key {
        id: 0x2::object::UID,
        player: address,
        points: u64,
        trophies: u64,
        bronze: u64,
        silver: u64,
        gold: u64,
        platinum: u64,
        games: u64,
        self_reported: u64,
        self_reported_points: u64,
        last_unlock_ms: u64,
    }

    public fun bronze(arg0: &Profile) : u64 {
        arg0.bronze
    }

    public fun create(arg0: &mut 0x4b8d384ca5b99280138687a6211298184ff9a34c3193eb4ca61540a364cf69a5::registry::Registry, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : Profile {
        0x4b8d384ca5b99280138687a6211298184ff9a34c3193eb4ca61540a364cf69a5::registry::assert_current(arg0);
        let v0 = Profile{
            id                   : 0x2::object::new(arg2),
            player               : arg1,
            points               : 0,
            trophies             : 0,
            bronze               : 0,
            silver               : 0,
            gold                 : 0,
            platinum             : 0,
            games                : 0,
            self_reported        : 0,
            self_reported_points : 0,
            last_unlock_ms       : 0,
        };
        let v1 = 0x2::object::id<Profile>(&v0);
        0x4b8d384ca5b99280138687a6211298184ff9a34c3193eb4ca61540a364cf69a5::registry::add_profile(arg0, arg1, v1);
        0x4b8d384ca5b99280138687a6211298184ff9a34c3193eb4ca61540a364cf69a5::events::profile_created(v1, arg1);
        v0
    }

    public fun games(arg0: &Profile) : u64 {
        arg0.games
    }

    public fun gold(arg0: &Profile) : u64 {
        arg0.gold
    }

    public fun last_unlock_ms(arg0: &Profile) : u64 {
        arg0.last_unlock_ms
    }

    public fun platinum(arg0: &Profile) : u64 {
        arg0.platinum
    }

    public fun player(arg0: &Profile) : address {
        arg0.player
    }

    public fun points(arg0: &Profile) : u64 {
        arg0.points
    }

    public(friend) fun record(arg0: &mut Profile, arg1: u8, arg2: u64, arg3: u8, arg4: bool, arg5: u64) {
        arg0.points = arg0.points + arg2;
        arg0.trophies = arg0.trophies + 1;
        if (arg1 == 0x4b8d384ca5b99280138687a6211298184ff9a34c3193eb4ca61540a364cf69a5::trophy::bronze()) {
            arg0.bronze = arg0.bronze + 1;
        } else if (arg1 == 0x4b8d384ca5b99280138687a6211298184ff9a34c3193eb4ca61540a364cf69a5::trophy::silver()) {
            arg0.silver = arg0.silver + 1;
        } else if (arg1 == 0x4b8d384ca5b99280138687a6211298184ff9a34c3193eb4ca61540a364cf69a5::trophy::gold()) {
            arg0.gold = arg0.gold + 1;
        } else {
            arg0.platinum = arg0.platinum + 1;
        };
        if (arg4) {
            arg0.games = arg0.games + 1;
        };
        if (arg3 == 0x4b8d384ca5b99280138687a6211298184ff9a34c3193eb4ca61540a364cf69a5::trophy::source_attested()) {
            arg0.self_reported = arg0.self_reported + 1;
            arg0.self_reported_points = arg0.self_reported_points + arg2;
        };
        if (arg5 > arg0.last_unlock_ms) {
            arg0.last_unlock_ms = arg5;
        };
    }

    public fun self_reported(arg0: &Profile) : u64 {
        arg0.self_reported
    }

    public fun self_reported_points(arg0: &Profile) : u64 {
        arg0.self_reported_points
    }

    public fun share(arg0: Profile) {
        0x2::transfer::share_object<Profile>(arg0);
    }

    public fun silver(arg0: &Profile) : u64 {
        arg0.silver
    }

    public fun trophies(arg0: &Profile) : u64 {
        arg0.trophies
    }

    // decompiled from Move bytecode v7
}

