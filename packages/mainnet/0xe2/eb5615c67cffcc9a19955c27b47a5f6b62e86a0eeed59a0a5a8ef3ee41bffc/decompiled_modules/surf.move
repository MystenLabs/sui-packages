module 0xe2eb5615c67cffcc9a19955c27b47a5f6b62e86a0eeed59a0a5a8ef3ee41bffc::surf {
    struct SURF has drop {
        dummy_field: bool,
    }

    struct SurfNFT has store, key {
        id: 0x2::object::UID,
        season: u64,
    }

    struct MintConfig has key {
        id: 0x2::object::UID,
        season_start_ts: u64,
        threshold: u64,
        mint_cost: u64,
        weekly_cap: u64,
        minted: 0x2::table::Table<address, WeekCount>,
    }

    struct WeekCount has copy, drop, store {
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

    public(friend) fun burn(arg0: SurfNFT) {
        let SurfNFT {
            id     : v0,
            season : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun current_week(arg0: &MintConfig, arg1: &0x2::clock::Clock) : u64 {
        ensure_started(arg0);
        let v0 = now_s(arg1);
        assert!(v0 >= arg0.season_start_ts, 0xe2eb5615c67cffcc9a19955c27b47a5f6b62e86a0eeed59a0a5a8ef3ee41bffc::errors::not_started());
        (v0 - arg0.season_start_ts) / 604800 + 1
    }

    fun ensure_started(arg0: &MintConfig) {
        assert!(arg0.season_start_ts != 0, 0xe2eb5615c67cffcc9a19955c27b47a5f6b62e86a0eeed59a0a5a8ef3ee41bffc::errors::not_started());
    }

    fun init(arg0: SURF, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = MintConfig{
            id              : 0x2::object::new(arg1),
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
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"Current Surf Board - Season {season}"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"A Current NFT minted from Current Point earned during Season 2. Stake it to mine rewards."));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"https://metadata.current.finance/nft1.png"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"https://www.current.finance/"));
        let v8 = 0x2::display::new_with_fields<SurfNFT>(&v3, v4, v6, arg1);
        0x2::display::update_version<SurfNFT>(&mut v8);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v3, v0);
        0x2::transfer::public_transfer<0x2::display::Display<SurfNFT>>(v8, v0);
    }

    public fun is_live(arg0: &MintConfig) : bool {
        if (arg0.weekly_cap != 0) {
            if (arg0.season_start_ts != 0) {
                arg0.threshold != 18446744073709551615
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun mint(arg0: &mut MintConfig, arg1: &mut 0xe2eb5615c67cffcc9a19955c27b47a5f6b62e86a0eeed59a0a5a8ef3ee41bffc::recorder::Recorder, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : SurfNFT {
        0xe2eb5615c67cffcc9a19955c27b47a5f6b62e86a0eeed59a0a5a8ef3ee41bffc::recorder::ensure_version_matches(arg1);
        ensure_started(arg0);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = current_week(arg0, arg2);
        assert!(0xe2eb5615c67cffcc9a19955c27b47a5f6b62e86a0eeed59a0a5a8ef3ee41bffc::recorder::points_of(arg1, v0) >= arg0.threshold, 0xe2eb5615c67cffcc9a19955c27b47a5f6b62e86a0eeed59a0a5a8ef3ee41bffc::errors::below_threshold());
        let v2 = arg0.weekly_cap;
        let v3 = refresh_or_create_user_weekly_data(arg0, v0, v1);
        v3.count = v3.count + 1;
        if (v1 >= 2) {
            assert!(v3.count <= v2, 0xe2eb5615c67cffcc9a19955c27b47a5f6b62e86a0eeed59a0a5a8ef3ee41bffc::errors::weekly_cap_reached());
        };
        0xe2eb5615c67cffcc9a19955c27b47a5f6b62e86a0eeed59a0a5a8ef3ee41bffc::recorder::add_spent(arg1, v0, arg0.mint_cost);
        let v4 = SurfNFT{
            id     : 0x2::object::new(arg3),
            season : 2,
        };
        let v5 = Minted{
            user   : v0,
            season : 2,
            week   : v1,
            cost   : arg0.mint_cost,
            nft_id : 0x2::object::id<SurfNFT>(&v4),
        };
        0x2::event::emit<Minted>(v5);
        v4
    }

    public fun mint_cost(arg0: &MintConfig) : u64 {
        arg0.mint_cost
    }

    public fun nft_season(arg0: &SurfNFT) : u64 {
        arg0.season
    }

    fun now_s(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 1000
    }

    fun refresh_or_create_user_weekly_data(arg0: &mut MintConfig, arg1: address, arg2: u64) : &mut WeekCount {
        if (!0x2::table::contains<address, WeekCount>(&arg0.minted, arg1)) {
            let v0 = WeekCount{
                week  : arg2,
                count : 0,
            };
            0x2::table::add<address, WeekCount>(&mut arg0.minted, arg1, v0);
            return 0x2::table::borrow_mut<address, WeekCount>(&mut arg0.minted, arg1)
        };
        let v1 = 0x2::table::borrow_mut<address, WeekCount>(&mut arg0.minted, arg1);
        if (v1.week != arg2) {
            v1.count = 0;
            v1.week = arg2;
        };
        v1
    }

    public fun season() : u64 {
        2
    }

    public fun set_mint_cost(arg0: &mut MintConfig, arg1: &AdminCap, arg2: u64) {
        assert!(arg2 != 0, 0xe2eb5615c67cffcc9a19955c27b47a5f6b62e86a0eeed59a0a5a8ef3ee41bffc::errors::invalid_config());
        arg0.mint_cost = arg2;
    }

    public fun set_threshold(arg0: &mut MintConfig, arg1: &AdminCap, arg2: u64) {
        arg0.threshold = arg2;
    }

    public fun set_weekly_cap(arg0: &mut MintConfig, arg1: &AdminCap, arg2: u64) {
        arg0.weekly_cap = arg2;
    }

    public fun start_season(arg0: &mut MintConfig, arg1: &AdminCap, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) {
        assert!(arg0.season_start_ts == 0, 0xe2eb5615c67cffcc9a19955c27b47a5f6b62e86a0eeed59a0a5a8ef3ee41bffc::errors::already_started());
        arg0.season_start_ts = now_s(arg5);
        set_mint_cost(arg0, arg1, arg4);
        set_weekly_cap(arg0, arg1, arg3);
        set_threshold(arg0, arg1, arg2);
    }

    public fun threshold(arg0: &MintConfig) : u64 {
        arg0.threshold
    }

    public fun weekly_cap(arg0: &MintConfig) : u64 {
        arg0.weekly_cap
    }

    public fun weekly_minted_of(arg0: &MintConfig, arg1: address, arg2: &0x2::clock::Clock) : u64 {
        if (!0x2::table::contains<address, WeekCount>(&arg0.minted, arg1)) {
            return 0
        };
        let v0 = *0x2::table::borrow<address, WeekCount>(&arg0.minted, arg1);
        if (v0.week == current_week(arg0, arg2)) {
            v0.count
        } else {
            0
        }
    }

    // decompiled from Move bytecode v7
}

