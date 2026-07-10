module 0xae6593b753c5cfb342e6f6e8de7eca7ac3ff99efe2ef08ceb2afeb00b67e9fe3::surf {
    struct SURF has drop {
        dummy_field: bool,
    }

    struct SurfNFT has store, key {
        id: 0x2::object::UID,
        season: u64,
    }

    struct MintConfig has key {
        id: 0x2::object::UID,
        version: u64,
        live: bool,
        season: u64,
        season_start_ts: u64,
        threshold: u64,
        mint_cost: u64,
        weekly_cap: u64,
        minted: 0x2::table::Table<address, WeekCount>,
    }

    struct WeekCount has copy, drop, store {
        season: u64,
        week: u64,
        count: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Minted has copy, drop {
        user: address,
        season: u64,
        week: u64,
        cost: u64,
        nft_id: 0x2::object::ID,
    }

    fun bump_weekly(arg0: &mut MintConfig, arg1: address, arg2: u64) {
        let v0 = arg0.season;
        if (0x2::table::contains<address, WeekCount>(&arg0.minted, arg1)) {
            let v1 = 0x2::table::borrow_mut<address, WeekCount>(&mut arg0.minted, arg1);
            if (v1.season == v0 && v1.week == arg2) {
                v1.count = v1.count + 1;
            } else {
                v1.season = v0;
                v1.week = arg2;
                v1.count = 1;
            };
        } else {
            let v2 = WeekCount{
                season : v0,
                week   : arg2,
                count  : 1,
            };
            0x2::table::add<address, WeekCount>(&mut arg0.minted, arg1, v2);
        };
    }

    public(friend) fun burn(arg0: SurfNFT) {
        let SurfNFT {
            id     : v0,
            season : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun current_week(arg0: &MintConfig, arg1: &0x2::clock::Clock) : u64 {
        if (arg0.season == 0) {
            return 0
        };
        let v0 = now_s(arg1);
        if (v0 <= arg0.season_start_ts) {
            1
        } else {
            (v0 - arg0.season_start_ts) / 604800 + 1
        }
    }

    fun init(arg0: SURF, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = MintConfig{
            id              : 0x2::object::new(arg1),
            version         : 1,
            live            : false,
            season          : 0,
            season_start_ts : 0,
            threshold       : 0,
            mint_cost       : 0,
            weekly_cap      : 0,
            minted          : 0x2::table::new<address, WeekCount>(arg1),
        };
        0x2::transfer::share_object<MintConfig>(v1);
        let v2 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v2, v0);
        let v3 = 0x2::package::claim<SURF>(arg0, arg1);
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"project_url"));
        let v6 = 0x1::vector::empty<0x1::string::String>();
        let v7 = &mut v6;
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"Surf NFT - Season {season}"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"A Current point NFT minted from earned points. Stake it to mine rewards."));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b""));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"https://www.current.finance/"));
        let v8 = 0x2::display::new_with_fields<SurfNFT>(&v3, v4, v6, arg1);
        0x2::display::update_version<SurfNFT>(&mut v8);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v3, v0);
        0x2::transfer::public_transfer<0x2::display::Display<SurfNFT>>(v8, v0);
    }

    public fun is_live(arg0: &MintConfig) : bool {
        arg0.live
    }

    public fun migrate(arg0: &mut MintConfig, arg1: &AdminCap) {
        assert!(arg0.version < 1, 0xae6593b753c5cfb342e6f6e8de7eca7ac3ff99efe2ef08ceb2afeb00b67e9fe3::errors::wrong_version());
        arg0.version = 1;
    }

    public fun mint(arg0: &mut MintConfig, arg1: &mut 0xae6593b753c5cfb342e6f6e8de7eca7ac3ff99efe2ef08ceb2afeb00b67e9fe3::recorder::Recorder, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : SurfNFT {
        assert!(arg0.version == 1, 0xae6593b753c5cfb342e6f6e8de7eca7ac3ff99efe2ef08ceb2afeb00b67e9fe3::errors::wrong_version());
        let v0 = if (arg0.live) {
            if (arg0.season >= 1) {
                arg0.mint_cost > 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 0xae6593b753c5cfb342e6f6e8de7eca7ac3ff99efe2ef08ceb2afeb00b67e9fe3::errors::not_configured());
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = current_week(arg0, arg2);
        assert!(0xae6593b753c5cfb342e6f6e8de7eca7ac3ff99efe2ef08ceb2afeb00b67e9fe3::recorder::points_of(arg1, v1) >= arg0.threshold, 0xae6593b753c5cfb342e6f6e8de7eca7ac3ff99efe2ef08ceb2afeb00b67e9fe3::errors::below_threshold());
        if (v2 >= 2 && arg0.weekly_cap > 0) {
            assert!(weekly_minted(arg0, v1, v2) < arg0.weekly_cap, 0xae6593b753c5cfb342e6f6e8de7eca7ac3ff99efe2ef08ceb2afeb00b67e9fe3::errors::weekly_cap_reached());
        };
        0xae6593b753c5cfb342e6f6e8de7eca7ac3ff99efe2ef08ceb2afeb00b67e9fe3::recorder::add_spent(arg1, v1, arg0.mint_cost);
        bump_weekly(arg0, v1, v2);
        let v3 = SurfNFT{
            id     : 0x2::object::new(arg3),
            season : arg0.season,
        };
        let v4 = Minted{
            user   : v1,
            season : arg0.season,
            week   : v2,
            cost   : arg0.mint_cost,
            nft_id : 0x2::object::id<SurfNFT>(&v3),
        };
        0x2::event::emit<Minted>(v4);
        v3
    }

    public fun mint_cost(arg0: &MintConfig) : u64 {
        arg0.mint_cost
    }

    public fun next_season(arg0: &mut MintConfig, arg1: &AdminCap, arg2: &0x2::clock::Clock) {
        assert!(arg0.version == 1, 0xae6593b753c5cfb342e6f6e8de7eca7ac3ff99efe2ef08ceb2afeb00b67e9fe3::errors::wrong_version());
        arg0.season = arg0.season + 1;
        arg0.season_start_ts = now_s(arg2);
    }

    public fun nft_season(arg0: &SurfNFT) : u64 {
        arg0.season
    }

    fun now_s(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 1000
    }

    public fun season(arg0: &MintConfig) : u64 {
        arg0.season
    }

    public fun set_live(arg0: &mut MintConfig, arg1: &AdminCap, arg2: bool) {
        assert!(arg0.version == 1, 0xae6593b753c5cfb342e6f6e8de7eca7ac3ff99efe2ef08ceb2afeb00b67e9fe3::errors::wrong_version());
        arg0.live = arg2;
    }

    public fun set_mint_cost(arg0: &mut MintConfig, arg1: &AdminCap, arg2: u64) {
        assert!(arg0.version == 1, 0xae6593b753c5cfb342e6f6e8de7eca7ac3ff99efe2ef08ceb2afeb00b67e9fe3::errors::wrong_version());
        arg0.mint_cost = arg2;
    }

    public fun set_threshold(arg0: &mut MintConfig, arg1: &AdminCap, arg2: u64) {
        assert!(arg0.version == 1, 0xae6593b753c5cfb342e6f6e8de7eca7ac3ff99efe2ef08ceb2afeb00b67e9fe3::errors::wrong_version());
        arg0.threshold = arg2;
    }

    public fun set_weekly_cap(arg0: &mut MintConfig, arg1: &AdminCap, arg2: u64) {
        assert!(arg0.version == 1, 0xae6593b753c5cfb342e6f6e8de7eca7ac3ff99efe2ef08ceb2afeb00b67e9fe3::errors::wrong_version());
        arg0.weekly_cap = arg2;
    }

    public fun threshold(arg0: &MintConfig) : u64 {
        arg0.threshold
    }

    public fun weekly_cap(arg0: &MintConfig) : u64 {
        arg0.weekly_cap
    }

    fun weekly_minted(arg0: &MintConfig, arg1: address, arg2: u64) : u64 {
        if (0x2::table::contains<address, WeekCount>(&arg0.minted, arg1)) {
            let v1 = 0x2::table::borrow<address, WeekCount>(&arg0.minted, arg1);
            if (v1.season == arg0.season && v1.week == arg2) {
                v1.count
            } else {
                0
            }
        } else {
            0
        }
    }

    public fun weekly_minted_of(arg0: &MintConfig, arg1: address, arg2: &0x2::clock::Clock) : u64 {
        weekly_minted(arg0, arg1, current_week(arg0, arg2))
    }

    // decompiled from Move bytecode v7
}

