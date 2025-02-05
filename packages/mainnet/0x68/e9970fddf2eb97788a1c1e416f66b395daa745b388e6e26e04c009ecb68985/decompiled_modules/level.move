module 0x997a2db9d4e6352f3776011dc010c5858e28f2741cf1c8fe11e301482d6106f9::level {
    struct UserLevels has store {
        inner: 0x2::table::Table<address, UserLevel>,
    }

    struct UserLevel has store, key {
        id: 0x2::object::UID,
        level: u64,
        level_up_timestamps: vector<u64>,
    }

    struct Levels has store {
        configs: vector<LevelConfig>,
    }

    struct LevelConfig has store, key {
        id: 0x2::object::UID,
        days: u64,
        posts: u64,
        upvotes: u64,
        referrals: u64,
        points_reward: u64,
        nfts_metadata: vector<NFTMetadata>,
    }

    struct NFTMetadata has copy, drop, store {
        name: 0x1::string::String,
        description: 0x1::string::String,
        uri: 0x1::string::String,
    }

    struct LevelNFTTemplate<phantom T0: store + key> has key {
        id: 0x2::object::UID,
        recipient: address,
        level: u64,
        name: 0x1::string::String,
        description: 0x1::string::String,
        uri: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct LevelCompletionEvent has copy, drop {
        user: address,
        level: u64,
        timestamp_ms: u64,
    }

    public fun new(arg0: &0x997a2db9d4e6352f3776011dc010c5858e28f2741cf1c8fe11e301482d6106f9::app::AdminCap, arg1: &mut 0x2::tx_context::TxContext) : (UserLevels, Levels) {
        let v0 = UserLevels{inner: 0x2::table::new<address, UserLevel>(arg1)};
        let v1 = Levels{configs: initialize_levels(arg1)};
        (v0, v1)
    }

    public fun level<T0: store + key>(arg0: &LevelNFTTemplate<T0>) : u64 {
        arg0.level
    }

    public fun attributes<T0: store + key>(arg0: &LevelNFTTemplate<T0>) : 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        arg0.attributes
    }

    public fun can_level_up(arg0: &mut 0x997a2db9d4e6352f3776011dc010c5858e28f2741cf1c8fe11e301482d6106f9::app::GilderApp, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : bool {
        let v0 = get_or_create_user_level(arg0, arg1, arg3);
        let v1 = get_level_config(arg0, v0.level);
        let v2 = v1.posts;
        let v3 = v1.upvotes;
        let v4 = v1.referrals;
        let v5 = 0x997a2db9d4e6352f3776011dc010c5858e28f2741cf1c8fe11e301482d6106f9::stat::user_stat(arg0, arg1, arg3);
        if (0x997a2db9d4e6352f3776011dc010c5858e28f2741cf1c8fe11e301482d6106f9::user_info::has_claimed_sign_up_reward(arg0, arg1)) {
            if (0x997a2db9d4e6352f3776011dc010c5858e28f2741cf1c8fe11e301482d6106f9::stat::posts(v5) >= v2) {
                if (0x997a2db9d4e6352f3776011dc010c5858e28f2741cf1c8fe11e301482d6106f9::stat::upvotes(v5) >= v3) {
                    if (0x997a2db9d4e6352f3776011dc010c5858e28f2741cf1c8fe11e301482d6106f9::stat::referrals(v5) >= v4) {
                        0x997a2db9d4e6352f3776011dc010c5858e28f2741cf1c8fe11e301482d6106f9::point::correct_user_point_streak(arg0, arg1, 0x2::clock::timestamp_ms(arg2)) >= v1.days
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun description<T0: store + key>(arg0: &LevelNFTTemplate<T0>) : 0x1::string::String {
        arg0.description
    }

    public fun drop_after_minting<T0: store + key>(arg0: LevelNFTTemplate<T0>, arg1: &T0) {
        let LevelNFTTemplate {
            id          : v0,
            recipient   : _,
            level       : _,
            name        : _,
            description : _,
            uri         : _,
            attributes  : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun edit_level_add_nft_metadata(arg0: LevelConfig, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String) : LevelConfig {
        let v0 = NFTMetadata{
            name        : arg2,
            description : arg1,
            uri         : arg3,
        };
        0x1::vector::push_back<NFTMetadata>(&mut arg0.nfts_metadata, v0);
        arg0
    }

    public fun edit_level_clear_nfts_metadata(arg0: LevelConfig) : LevelConfig {
        arg0.nfts_metadata = 0x1::vector::empty<NFTMetadata>();
        arg0
    }

    public fun edit_level_days(arg0: LevelConfig, arg1: u64) : LevelConfig {
        arg0.days = arg1;
        arg0
    }

    public fun edit_level_edit_nft_metadata(arg0: LevelConfig, arg1: u64, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String) : LevelConfig {
        let v0 = NFTMetadata{
            name        : arg3,
            description : arg2,
            uri         : arg4,
        };
        *0x1::vector::borrow_mut<NFTMetadata>(&mut arg0.nfts_metadata, arg1) = v0;
        arg0
    }

    public fun edit_level_points_reward(arg0: LevelConfig, arg1: u64) : LevelConfig {
        arg0.points_reward = arg1;
        arg0
    }

    public fun edit_level_posts(arg0: LevelConfig, arg1: u64) : LevelConfig {
        arg0.posts = arg1;
        arg0
    }

    public fun edit_level_referrals(arg0: LevelConfig, arg1: u64) : LevelConfig {
        arg0.referrals = arg1;
        arg0
    }

    public fun edit_level_remove_nft_metadata(arg0: LevelConfig, arg1: u64) : LevelConfig {
        0x1::vector::remove<NFTMetadata>(&mut arg0.nfts_metadata, arg1);
        arg0
    }

    public fun edit_level_upvotes(arg0: LevelConfig, arg1: u64) : LevelConfig {
        arg0.upvotes = arg1;
        arg0
    }

    public fun get_level_config(arg0: &0x997a2db9d4e6352f3776011dc010c5858e28f2741cf1c8fe11e301482d6106f9::app::GilderApp, arg1: u64) : &LevelConfig {
        level_at(&0x997a2db9d4e6352f3776011dc010c5858e28f2741cf1c8fe11e301482d6106f9::app::object<Levels>(arg0).configs, arg1)
    }

    fun get_or_create_user_level(arg0: &mut 0x997a2db9d4e6352f3776011dc010c5858e28f2741cf1c8fe11e301482d6106f9::app::GilderApp, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : &UserLevel {
        let v0 = 0x997a2db9d4e6352f3776011dc010c5858e28f2741cf1c8fe11e301482d6106f9::app::app_object_mut<0x997a2db9d4e6352f3776011dc010c5858e28f2741cf1c8fe11e301482d6106f9::version::LevelV2, UserLevels>(arg0);
        if (!0x2::table::contains<address, UserLevel>(&v0.inner, arg1)) {
            let v1 = UserLevel{
                id                  : 0x2::object::new(arg2),
                level               : 0,
                level_up_timestamps : vector[],
            };
            0x2::table::add<address, UserLevel>(&mut v0.inner, arg1, v1);
        };
        0x2::table::borrow<address, UserLevel>(&v0.inner, arg1)
    }

    fun get_or_create_user_level_mut(arg0: &mut 0x997a2db9d4e6352f3776011dc010c5858e28f2741cf1c8fe11e301482d6106f9::app::GilderApp, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : &mut UserLevel {
        let v0 = 0x997a2db9d4e6352f3776011dc010c5858e28f2741cf1c8fe11e301482d6106f9::app::app_object_mut<0x997a2db9d4e6352f3776011dc010c5858e28f2741cf1c8fe11e301482d6106f9::version::LevelV2, UserLevels>(arg0);
        if (!0x2::table::contains<address, UserLevel>(&v0.inner, arg1)) {
            let v1 = UserLevel{
                id                  : 0x2::object::new(arg2),
                level               : 0,
                level_up_timestamps : vector[],
            };
            0x2::table::add<address, UserLevel>(&mut v0.inner, arg1, v1);
        };
        0x2::table::borrow_mut<address, UserLevel>(&mut v0.inner, arg1)
    }

    fun get_random_nft(arg0: &0x2::random::Random, arg1: &mut 0x2::tx_context::TxContext, arg2: u64) : u64 {
        let v0 = 0x2::random::new_generator(arg0, arg1);
        0x2::random::generate_u64(&mut v0) % arg2
    }

    public fun get_user_level(arg0: &mut 0x997a2db9d4e6352f3776011dc010c5858e28f2741cf1c8fe11e301482d6106f9::app::GilderApp, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : &UserLevel {
        get_or_create_user_level(arg0, arg1, arg2)
    }

    fun initialize_levels(arg0: &mut 0x2::tx_context::TxContext) : vector<LevelConfig> {
        let v0 = 0x1::vector::empty<NFTMetadata>();
        let v1 = LevelConfig{
            id            : 0x2::object::new(arg0),
            days          : 7,
            posts         : 1,
            upvotes       : 0,
            referrals     : 1,
            points_reward : 50000,
            nfts_metadata : v0,
        };
        let v2 = LevelConfig{
            id            : 0x2::object::new(arg0),
            days          : 14,
            posts         : 5,
            upvotes       : 10,
            referrals     : 4,
            points_reward : 100000,
            nfts_metadata : v0,
        };
        let v3 = LevelConfig{
            id            : 0x2::object::new(arg0),
            days          : 21,
            posts         : 15,
            upvotes       : 30,
            referrals     : 9,
            points_reward : 250000,
            nfts_metadata : v0,
        };
        let v4 = LevelConfig{
            id            : 0x2::object::new(arg0),
            days          : 28,
            posts         : 30,
            upvotes       : 70,
            referrals     : 16,
            points_reward : 500000,
            nfts_metadata : v0,
        };
        let v5 = LevelConfig{
            id            : 0x2::object::new(arg0),
            days          : 35,
            posts         : 50,
            upvotes       : 150,
            referrals     : 26,
            points_reward : 1000000,
            nfts_metadata : v0,
        };
        let v6 = LevelConfig{
            id            : 0x2::object::new(arg0),
            days          : 42,
            posts         : 80,
            upvotes       : 270,
            referrals     : 38,
            points_reward : 1500000,
            nfts_metadata : v0,
        };
        let v7 = 0x1::vector::empty<LevelConfig>();
        let v8 = &mut v7;
        0x1::vector::push_back<LevelConfig>(v8, v1);
        0x1::vector::push_back<LevelConfig>(v8, v2);
        0x1::vector::push_back<LevelConfig>(v8, v3);
        0x1::vector::push_back<LevelConfig>(v8, v4);
        0x1::vector::push_back<LevelConfig>(v8, v5);
        0x1::vector::push_back<LevelConfig>(v8, v6);
        v7
    }

    fun level_at(arg0: &vector<LevelConfig>, arg1: u64) : &LevelConfig {
        assert!(arg1 < 0x1::vector::length<LevelConfig>(arg0), 1);
        0x1::vector::borrow<LevelConfig>(arg0, arg1)
    }

    entry fun level_up<T0: store + key>(arg0: &mut 0x997a2db9d4e6352f3776011dc010c5858e28f2741cf1c8fe11e301482d6106f9::app::GilderApp, arg1: &0x2::random::Random, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x997a2db9d4e6352f3776011dc010c5858e28f2741cf1c8fe11e301482d6106f9::app::assert_app_is_authorized<0x997a2db9d4e6352f3776011dc010c5858e28f2741cf1c8fe11e301482d6106f9::version::LevelV2>(arg0);
        let v0 = 0x2::tx_context::sender(arg3);
        0x997a2db9d4e6352f3776011dc010c5858e28f2741cf1c8fe11e301482d6106f9::blacklist::assert_not_banned(arg0, v0);
        let v1 = get_user_level(arg0, v0, arg3);
        let v2 = 0x1::vector::length<NFTMetadata>(&get_level_config(arg0, user_level(v1)).nfts_metadata);
        assert!(v2 > 0, 3);
        let v3 = get_random_nft(arg1, arg3, v2);
        0x2::transfer::transfer<LevelNFTTemplate<T0>>(level_up_with_nft<T0>(arg0, v0, v3, arg2, arg3), v0);
    }

    fun level_up_with_nft<T0: store + key>(arg0: &mut 0x997a2db9d4e6352f3776011dc010c5858e28f2741cf1c8fe11e301482d6106f9::app::GilderApp, arg1: address, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : LevelNFTTemplate<T0> {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = get_user_level(arg0, arg1, arg4);
        let v2 = user_level(v1);
        validate_level_requirements(arg0, arg1, v2, v0, arg4);
        update_level_stat(arg0, arg1, v2 + 1, v0, arg4);
        let v3 = get_level_config(arg0, v2);
        let v4 = v3.nfts_metadata;
        let v5 = nft_metadata_at(&v4, arg2);
        0x997a2db9d4e6352f3776011dc010c5858e28f2741cf1c8fe11e301482d6106f9::point::mint_points_for_level_up(arg0, arg1, v3.points_reward, arg4);
        let v6 = LevelCompletionEvent{
            user         : arg1,
            level        : v2,
            timestamp_ms : v0,
        };
        0x2::event::emit<LevelCompletionEvent>(v6);
        LevelNFTTemplate<T0>{
            id          : 0x2::object::new(arg4),
            recipient   : arg1,
            level       : v2,
            name        : v5.name,
            description : v5.description,
            uri         : v5.uri,
            attributes  : 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>(),
        }
    }

    public fun name<T0: store + key>(arg0: &LevelNFTTemplate<T0>) : 0x1::string::String {
        arg0.name
    }

    public fun new_level(arg0: &0x997a2db9d4e6352f3776011dc010c5858e28f2741cf1c8fe11e301482d6106f9::app::AdminCap, arg1: &mut 0x2::tx_context::TxContext) : 0x2::borrow::Referent<LevelConfig> {
        let v0 = LevelConfig{
            id            : 0x2::object::new(arg1),
            days          : 0,
            posts         : 0,
            upvotes       : 0,
            referrals     : 0,
            points_reward : 0,
            nfts_metadata : 0x1::vector::empty<NFTMetadata>(),
        };
        0x2::borrow::new<LevelConfig>(v0, arg1)
    }

    fun nft_metadata_at(arg0: &vector<NFTMetadata>, arg1: u64) : &NFTMetadata {
        assert!(arg1 < 0x1::vector::length<NFTMetadata>(arg0), 2);
        0x1::vector::borrow<NFTMetadata>(arg0, arg1)
    }

    public fun recipient<T0: store + key>(arg0: &LevelNFTTemplate<T0>) : address {
        arg0.recipient
    }

    public fun remove_level(arg0: 0x2::borrow::Referent<LevelConfig>) {
        let LevelConfig {
            id            : v0,
            days          : _,
            posts         : _,
            upvotes       : _,
            referrals     : _,
            points_reward : _,
            nfts_metadata : _,
        } = 0x2::borrow::destroy<LevelConfig>(arg0);
        0x2::object::delete(v0);
    }

    public fun save_level(arg0: &mut 0x997a2db9d4e6352f3776011dc010c5858e28f2741cf1c8fe11e301482d6106f9::app::GilderApp, arg1: 0x2::borrow::Referent<LevelConfig>, arg2: 0x1::option::Option<u64>) {
        let v0 = 0x997a2db9d4e6352f3776011dc010c5858e28f2741cf1c8fe11e301482d6106f9::app::app_object_mut<0x997a2db9d4e6352f3776011dc010c5858e28f2741cf1c8fe11e301482d6106f9::version::LevelV2, Levels>(arg0);
        0x1::vector::insert<LevelConfig>(&mut v0.configs, 0x2::borrow::destroy<LevelConfig>(arg1), 0x1::option::get_with_default<u64>(&arg2, 0x1::vector::length<LevelConfig>(&v0.configs)));
    }

    public fun take_level(arg0: &0x997a2db9d4e6352f3776011dc010c5858e28f2741cf1c8fe11e301482d6106f9::app::AdminCap, arg1: &mut 0x997a2db9d4e6352f3776011dc010c5858e28f2741cf1c8fe11e301482d6106f9::app::GilderApp, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::borrow::Referent<LevelConfig> {
        0x2::borrow::new<LevelConfig>(0x1::vector::remove<LevelConfig>(&mut 0x997a2db9d4e6352f3776011dc010c5858e28f2741cf1c8fe11e301482d6106f9::app::app_object_mut<0x997a2db9d4e6352f3776011dc010c5858e28f2741cf1c8fe11e301482d6106f9::version::LevelV2, Levels>(arg1).configs, arg2), arg3)
    }

    fun update_level_stat(arg0: &mut 0x997a2db9d4e6352f3776011dc010c5858e28f2741cf1c8fe11e301482d6106f9::app::GilderApp, arg1: address, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = get_or_create_user_level_mut(arg0, arg1, arg4);
        v0.level = arg2;
        0x1::vector::push_back<u64>(&mut v0.level_up_timestamps, arg3);
    }

    public fun uri<T0: store + key>(arg0: &LevelNFTTemplate<T0>) : 0x1::string::String {
        arg0.uri
    }

    public(friend) fun user_level(arg0: &UserLevel) : u64 {
        arg0.level
    }

    public(friend) fun user_level_up_timestamps(arg0: &UserLevel) : vector<u64> {
        arg0.level_up_timestamps
    }

    fun validate_level_requirements(arg0: &mut 0x997a2db9d4e6352f3776011dc010c5858e28f2741cf1c8fe11e301482d6106f9::app::GilderApp, arg1: address, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 < 0x1::vector::length<LevelConfig>(&0x997a2db9d4e6352f3776011dc010c5858e28f2741cf1c8fe11e301482d6106f9::app::object<Levels>(arg0).configs), 1);
        if (arg2 == 0) {
            assert!(0x997a2db9d4e6352f3776011dc010c5858e28f2741cf1c8fe11e301482d6106f9::user_info::has_claimed_sign_up_reward(arg0, arg1), 14);
        };
        let v0 = 0x997a2db9d4e6352f3776011dc010c5858e28f2741cf1c8fe11e301482d6106f9::stat::user_stat(arg0, arg1, arg4);
        let v1 = get_level_config(arg0, arg2);
        assert!(0x997a2db9d4e6352f3776011dc010c5858e28f2741cf1c8fe11e301482d6106f9::stat::posts(v0) >= v1.posts, 10);
        assert!(0x997a2db9d4e6352f3776011dc010c5858e28f2741cf1c8fe11e301482d6106f9::stat::upvotes(v0) >= v1.upvotes, 11);
        assert!(0x997a2db9d4e6352f3776011dc010c5858e28f2741cf1c8fe11e301482d6106f9::stat::referrals(v0) >= v1.referrals, 13);
        assert!(0x997a2db9d4e6352f3776011dc010c5858e28f2741cf1c8fe11e301482d6106f9::point::correct_user_point_streak(arg0, arg1, arg3) >= get_level_config(arg0, arg2).days, 12);
    }

    // decompiled from Move bytecode v6
}

