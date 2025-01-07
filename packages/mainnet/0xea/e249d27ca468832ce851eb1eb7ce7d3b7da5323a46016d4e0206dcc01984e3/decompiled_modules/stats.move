module 0xeae249d27ca468832ce851eb1eb7ce7d3b7da5323a46016d4e0206dcc01984e3::stats {
    struct STATS has drop {
        dummy_field: bool,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    struct StatsMintAuth has store, key {
        id: 0x2::object::UID,
        description: 0x1::string::String,
        mint_limit: u64,
        mint_count: u64,
    }

    struct Stats has store, key {
        id: 0x2::object::UID,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        project_url: 0x2::url::Url,
    }

    struct StatsEntry has copy, drop, store {
        key: 0x1::string::String,
        value: u64,
    }

    struct StatsLeaderboard has store, key {
        id: 0x2::object::UID,
        stats: vector<StatsEntry>,
    }

    struct StatsMintedEvent has copy, drop {
        stats_id: 0x2::object::ID,
        receiver: address,
    }

    struct StatsUpdatedEvent has copy, drop {
        stats_id: 0x2::object::ID,
        leaderboard_id: vector<u8>,
        updated_keys: vector<0x1::string::String>,
        updated_values: vector<u64>,
    }

    struct LeaderboardAddedEvent has copy, drop {
        stats_id: 0x2::object::ID,
        leaderboard_id: vector<u8>,
    }

    public entry fun add_leaderboard(arg0: &mut Stats, arg1: vector<u8>, arg2: vector<0x1::string::String>, arg3: vector<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        if (0x2::dynamic_object_field::exists_<0x1::string::String>(&arg0.id, 0x1::string::utf8(arg1))) {
            abort 4
        };
        let v0 = 0x1::vector::empty<StatsEntry>();
        let v1 = 0x1::vector::length<0x1::string::String>(&arg2);
        while (v1 > 0) {
            let v2 = StatsEntry{
                key   : 0x1::vector::pop_back<0x1::string::String>(&mut arg2),
                value : 0x1::vector::pop_back<u64>(&mut arg3),
            };
            0x1::vector::push_back<StatsEntry>(&mut v0, v2);
            v1 = v1 - 1;
        };
        let v3 = StatsLeaderboard{
            id    : 0x2::object::new(arg4),
            stats : v0,
        };
        0x2::dynamic_object_field::add<0x1::string::String, StatsLeaderboard>(&mut arg0.id, 0x1::string::utf8(arg1), v3);
        let v4 = LeaderboardAddedEvent{
            stats_id       : 0x2::object::id<Stats>(arg0),
            leaderboard_id : arg1,
        };
        0x2::event::emit<LeaderboardAddedEvent>(v4);
    }

    public entry fun clear_leaderboard(arg0: &mut Stats, arg1: vector<u8>) {
        if (!0x2::dynamic_object_field::exists_<0x1::string::String>(&arg0.id, 0x1::string::utf8(arg1))) {
            abort 5
        };
        0x2::dynamic_object_field::borrow_mut<0x1::string::String, StatsLeaderboard>(&mut arg0.id, 0x1::string::utf8(arg1)).stats = 0x1::vector::empty<StatsEntry>();
        let v0 = StatsUpdatedEvent{
            stats_id       : 0x2::object::id<Stats>(arg0),
            leaderboard_id : arg1,
            updated_keys   : 0x1::vector::empty<0x1::string::String>(),
            updated_values : 0x1::vector::empty<u64>(),
        };
        0x2::event::emit<StatsUpdatedEvent>(v0);
    }

    fun get_index(arg0: &vector<StatsEntry>, arg1: &0x1::string::String) : 0x1::option::Option<u64> {
        let v0 = 0;
        while (v0 < 0x1::vector::length<StatsEntry>(arg0)) {
            if (&0x1::vector::borrow<StatsEntry>(arg0, v0).key == arg1) {
                return 0x1::option::some<u64>(v0)
            };
            v0 = v0 + 1;
        };
        0x1::option::none<u64>()
    }

    fun init(arg0: STATS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = StatsMintAuth{
            id          : 0x2::object::new(arg1),
            description : 0x1::string::utf8(b"Mint Authority for Panzerdogs Stats V2"),
            mint_limit  : 0,
            mint_count  : 0,
        };
        let v2 = 0x2::package::claim<STATS>(arg0, arg1);
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"creator"));
        let v5 = 0x1::vector::empty<0x1::string::String>();
        let v6 = &mut v5;
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{project_url}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"Lucky Kat Studios"));
        let v7 = 0x2::display::new_with_fields<Stats>(&v2, v3, v5, arg1);
        0x2::display::add<Stats>(&mut v7, 0x1::string::utf8(b"tags"), 0x1::string::utf8(b"GameAsset"));
        0x2::display::update_version<Stats>(&mut v7);
        0x2::transfer::public_transfer<StatsMintAuth>(v1, v0);
        0x2::transfer::public_transfer<0x2::display::Display<Stats>>(v7, v0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v2, v0);
    }

    public entry fun mint_auth_to_address(arg0: &0x2::package::Publisher, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<Stats>(arg0), 1);
        let v0 = StatsMintAuth{
            id          : 0x2::object::new(arg3),
            description : 0x1::string::utf8(b"Mint Authority for Panzerdogs Stats V2"),
            mint_limit  : arg1,
            mint_count  : 0,
        };
        0x2::transfer::public_transfer<StatsMintAuth>(v0, arg2);
    }

    public entry fun mint_stats_to_address(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<0x1::string::String>, arg5: vector<u64>, arg6: address, arg7: &mut StatsMintAuth, arg8: &mut 0x2::tx_context::TxContext) {
        if (arg7.mint_limit > 0) {
            assert!(arg7.mint_count > arg7.mint_limit, 3);
        };
        let v0 = Stats{
            id          : 0x2::object::new(arg8),
            description : 0x1::string::utf8(arg1),
            image_url   : 0x2::url::new_unsafe_from_bytes(arg2),
            project_url : 0x2::url::new_unsafe_from_bytes(arg3),
        };
        let v1 = 0x1::vector::empty<StatsEntry>();
        let v2 = 0x1::vector::length<0x1::string::String>(&arg4);
        while (v2 > 0) {
            let v3 = StatsEntry{
                key   : 0x1::vector::pop_back<0x1::string::String>(&mut arg4),
                value : 0x1::vector::pop_back<u64>(&mut arg5),
            };
            0x1::vector::push_back<StatsEntry>(&mut v1, v3);
            v2 = v2 - 1;
        };
        let v4 = StatsLeaderboard{
            id    : 0x2::object::new(arg8),
            stats : v1,
        };
        0x2::dynamic_object_field::add<0x1::string::String, StatsLeaderboard>(&mut v0.id, 0x1::string::utf8(arg0), v4);
        let v5 = StatsMintedEvent{
            stats_id : 0x2::object::id<Stats>(&v0),
            receiver : arg6,
        };
        0x2::event::emit<StatsMintedEvent>(v5);
        arg7.mint_count = arg7.mint_count + 1;
        0x2::transfer::public_transfer<Stats>(v0, arg6);
    }

    public entry fun update_fields(arg0: &mut Stats, arg1: 0x1::option::Option<vector<u8>>, arg2: 0x1::option::Option<vector<u8>>, arg3: 0x1::option::Option<vector<u8>>) {
        if (0x1::option::is_some<vector<u8>>(&arg1)) {
            arg0.description = 0x1::string::utf8(0x1::option::extract<vector<u8>>(&mut arg1));
        };
        if (0x1::option::is_some<vector<u8>>(&arg2)) {
            arg0.image_url = 0x2::url::new_unsafe_from_bytes(0x1::option::extract<vector<u8>>(&mut arg2));
        };
        if (0x1::option::is_some<vector<u8>>(&arg3)) {
            arg0.project_url = 0x2::url::new_unsafe_from_bytes(0x1::option::extract<vector<u8>>(&mut arg3));
        };
    }

    public entry fun update_leaderboard(arg0: &mut Stats, arg1: vector<u8>, arg2: vector<0x1::string::String>, arg3: vector<u64>) {
        if (!0x2::dynamic_object_field::exists_<0x1::string::String>(&arg0.id, 0x1::string::utf8(arg1))) {
            abort 5
        };
        let v0 = 0x1::vector::length<0x1::string::String>(&arg2);
        assert!(v0 == 0x1::vector::length<u64>(&arg3), 2);
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x1::string::String, StatsLeaderboard>(&mut arg0.id, 0x1::string::utf8(arg1));
        let v2 = v1.stats;
        while (v0 > 0) {
            let v3 = 0x1::vector::pop_back<0x1::string::String>(&mut arg2);
            let v4 = get_index(&v2, &v3);
            if (0x1::option::is_some<u64>(&v4)) {
                let v5 = 0x1::vector::borrow_mut<StatsEntry>(&mut v2, 0x1::option::extract<u64>(&mut v4));
                v5.value = v5.value + 0x1::vector::pop_back<u64>(&mut arg3);
            } else {
                let v6 = StatsEntry{
                    key   : v3,
                    value : 0x1::vector::pop_back<u64>(&mut arg3),
                };
                0x1::vector::push_back<StatsEntry>(&mut v2, v6);
            };
            v0 = v0 - 1;
        };
        v1.stats = v2;
        let v7 = StatsUpdatedEvent{
            stats_id       : 0x2::object::id<Stats>(arg0),
            leaderboard_id : arg1,
            updated_keys   : arg2,
            updated_values : arg3,
        };
        0x2::event::emit<StatsUpdatedEvent>(v7);
    }

    // decompiled from Move bytecode v6
}

