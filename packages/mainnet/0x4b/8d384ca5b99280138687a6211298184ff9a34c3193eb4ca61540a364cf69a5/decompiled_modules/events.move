module 0x4b8d384ca5b99280138687a6211298184ff9a34c3193eb4ca61540a364cf69a5::events {
    struct TrophyUnlocked has copy, drop {
        trophy: 0x2::object::ID,
        game: 0x2::object::ID,
        trophy_id: u64,
        player: address,
        tier: u8,
        points: u64,
        source: u8,
        number: u64,
        unlocked_at_ms: u64,
    }

    struct ProfileCreated has copy, drop {
        profile: 0x2::object::ID,
        player: address,
    }

    struct GameCreated has copy, drop {
        game: 0x2::object::ID,
        slug: 0x1::string::String,
        name: 0x1::string::String,
        platform: 0x1::string::String,
        cap: 0x2::object::ID,
        attested: bool,
        studio: bool,
        creator: address,
    }

    struct GameUpdated has copy, drop {
        game: 0x2::object::ID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        attested: bool,
        paused: bool,
    }

    struct GameCapIssued has copy, drop {
        game: 0x2::object::ID,
        cap: 0x2::object::ID,
    }

    struct TrophyDefined has copy, drop {
        game: 0x2::object::ID,
        trophy_id: u64,
        key: 0x1::string::String,
        name: 0x1::string::String,
        tier: u8,
        points: u64,
        hidden: bool,
    }

    struct PlatinumSet has copy, drop {
        game: 0x2::object::ID,
        trophy_id: u64,
        set: vector<u64>,
    }

    struct GameIssuerSet has copy, drop {
        game: 0x2::object::ID,
        public_key: vector<u8>,
    }

    struct IssuerKeySet has copy, drop {
        registry: 0x2::object::ID,
        public_key: vector<u8>,
    }

    struct RegistryPaused has copy, drop {
        registry: 0x2::object::ID,
        paused: bool,
    }

    public(friend) fun game_cap_issued(arg0: 0x2::object::ID, arg1: 0x2::object::ID) {
        let v0 = GameCapIssued{
            game : arg0,
            cap  : arg1,
        };
        0x2::event::emit<GameCapIssued>(v0);
    }

    public(friend) fun game_created(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x2::object::ID, arg5: bool, arg6: bool, arg7: address) {
        let v0 = GameCreated{
            game     : arg0,
            slug     : arg1,
            name     : arg2,
            platform : arg3,
            cap      : arg4,
            attested : arg5,
            studio   : arg6,
            creator  : arg7,
        };
        0x2::event::emit<GameCreated>(v0);
    }

    public(friend) fun game_issuer_set(arg0: 0x2::object::ID, arg1: vector<u8>) {
        let v0 = GameIssuerSet{
            game       : arg0,
            public_key : arg1,
        };
        0x2::event::emit<GameIssuerSet>(v0);
    }

    public(friend) fun game_updated(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: bool, arg4: bool) {
        let v0 = GameUpdated{
            game      : arg0,
            name      : arg1,
            image_url : arg2,
            attested  : arg3,
            paused    : arg4,
        };
        0x2::event::emit<GameUpdated>(v0);
    }

    public(friend) fun issuer_key_set(arg0: 0x2::object::ID, arg1: vector<u8>) {
        let v0 = IssuerKeySet{
            registry   : arg0,
            public_key : arg1,
        };
        0x2::event::emit<IssuerKeySet>(v0);
    }

    public(friend) fun platinum_set(arg0: 0x2::object::ID, arg1: u64, arg2: vector<u64>) {
        let v0 = PlatinumSet{
            game      : arg0,
            trophy_id : arg1,
            set       : arg2,
        };
        0x2::event::emit<PlatinumSet>(v0);
    }

    public(friend) fun profile_created(arg0: 0x2::object::ID, arg1: address) {
        let v0 = ProfileCreated{
            profile : arg0,
            player  : arg1,
        };
        0x2::event::emit<ProfileCreated>(v0);
    }

    public(friend) fun registry_paused(arg0: 0x2::object::ID, arg1: bool) {
        let v0 = RegistryPaused{
            registry : arg0,
            paused   : arg1,
        };
        0x2::event::emit<RegistryPaused>(v0);
    }

    public(friend) fun trophy_defined(arg0: 0x2::object::ID, arg1: u64, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u8, arg5: u64, arg6: bool) {
        let v0 = TrophyDefined{
            game      : arg0,
            trophy_id : arg1,
            key       : arg2,
            name      : arg3,
            tier      : arg4,
            points    : arg5,
            hidden    : arg6,
        };
        0x2::event::emit<TrophyDefined>(v0);
    }

    public(friend) fun trophy_unlocked(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: address, arg4: u8, arg5: u64, arg6: u8, arg7: u64, arg8: u64) {
        let v0 = TrophyUnlocked{
            trophy         : arg0,
            game           : arg1,
            trophy_id      : arg2,
            player         : arg3,
            tier           : arg4,
            points         : arg5,
            source         : arg6,
            number         : arg7,
            unlocked_at_ms : arg8,
        };
        0x2::event::emit<TrophyUnlocked>(v0);
    }

    // decompiled from Move bytecode v7
}

