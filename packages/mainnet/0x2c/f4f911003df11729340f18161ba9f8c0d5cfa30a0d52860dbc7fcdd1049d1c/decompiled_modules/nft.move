module 0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::nft {
    struct NFT has drop {
        dummy_field: bool,
    }

    struct TestNFT has store, key {
        id: 0x2::object::UID,
        tier: u8,
        name: 0x1::string::String,
        description: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        image_url: 0x1::string::String,
    }

    struct Attributes has store {
        media_type: 0x1::string::String,
        edition_number: u16,
        total_editions: u16,
        edition: 0x1::string::String,
        art_style: 0x1::string::String,
        rarity_class: u8,
        theme: 0x1::string::String,
        character_type: 0x1::string::String,
    }

    struct Config has store, key {
        id: 0x2::object::UID,
        tier_details: 0x2::vec_map::VecMap<u8, SampleMetadata>,
        upgrade_cost: 0x2::vec_map::VecMap<u8, u64>,
        total_supply: u64,
        current_supply: u64,
        base_tire: u8,
        max_tire: u8,
        pause_free_mint: bool,
        pause_exclusive_mint: bool,
        admin: address,
    }

    struct SampleMetadata has store {
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    struct TireNFTRewards has store {
        gangsters: 0x2::vec_map::VecMap<0x1::string::String, u8>,
        game_resources: 0x2::vec_map::VecMap<0x1::string::String, u64>,
        perks: 0x2::vec_map::VecMap<0x1::string::String, u8>,
        hq_aesthetics: 0x1::string::String,
        is_claimed: bool,
    }

    struct GiftMetadata has store {
        gift_id: 0x2::object::ID,
        message: 0x1::string::String,
        sender: address,
        receiver: address,
        claimed: bool,
        dvd: 0x2::bag::Bag,
    }

    struct GiftRegistry has key {
        id: 0x2::object::UID,
        gift_map: 0x2::table::Table<address, vector<GiftMetadata>>,
    }

    public fun add_player(arg0: &mut TestNFT, arg1: 0x2::object::ID) {
        0x2::dynamic_field::add<0x1::string::String, 0x2::object::ID>(&mut arg0.id, 0x1::string::utf8(b"player"), arg1);
    }

    public(friend) fun add_spin_reward(arg0: &mut TestNFT, arg1: &0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::rewards::RewardRegistry, arg2: &0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::version::Version, arg3: u8, arg4: u8) {
        let v0 = 0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::rewards::borrow_tier_reward(arg1, arg2, arg3);
        let v1 = TireNFTRewards{
            gangsters      : 0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::rewards::borrow_gangsters_reward(v0),
            game_resources : 0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::rewards::borrow_game_resources_reward(v0),
            perks          : 0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::rewards::borrow_perks_reward(v0),
            hq_aesthetics  : 0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::rewards::borrow_hq_aesthetics_reward(v0),
            is_claimed     : false,
        };
        0x2::dynamic_field::add<u8, TireNFTRewards>(&mut arg0.id, arg3, v1);
    }

    public fun add_tier_config(arg0: &0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::authority::OperatorCap, arg1: &0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::version::Version, arg2: &mut Config, arg3: u8, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String) {
        0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::version::validate_version(arg1, 1);
        assert!(0x2::vec_map::contains<u8, u64>(&arg2.upgrade_cost, &arg3), 7);
        let v0 = SampleMetadata{
            name        : arg4,
            description : arg5,
            image_url   : arg6,
        };
        0x2::vec_map::insert<u8, SampleMetadata>(&mut arg2.tier_details, arg3, v0);
    }

    public fun add_upgrade_cost(arg0: &0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::authority::OperatorCap, arg1: &0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::version::Version, arg2: &mut Config, arg3: u8, arg4: u64) {
        0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::version::validate_version(arg1, 1);
        assert!(!0x2::vec_map::contains<u8, u64>(&arg2.upgrade_cost, &arg3), 0);
        0x2::vec_map::insert<u8, u64>(&mut arg2.upgrade_cost, arg3, arg4);
    }

    entry fun buy_special_edition_dvd(arg0: &mut Config, arg1: &0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::version::Version, arg2: &0x2::random::Random, arg3: &0x2::transfer_policy::TransferPolicy<TestNFT>, arg4: &0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::rewards::RewardRegistry, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.current_supply <= arg0.total_supply, 8);
        assert!(!arg0.pause_exclusive_mint, 14);
        0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::version::validate_version(arg1, 1);
        let v0 = 1;
        let v1 = 0x2::vec_map::get<u8, SampleMetadata>(&arg0.tier_details, &v0);
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&arg5);
        let v3 = 1;
        assert!(&v2 == 0x2::vec_map::get<u8, u64>(&arg0.upgrade_cost, &v3), 4);
        calculate_rarity(arg2, arg6);
        let v4 = TestNFT{
            id          : 0x2::object::new(arg6),
            tier        : 1,
            name        : v1.name,
            description : v1.description,
            attributes  : 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>(),
            image_url   : v1.image_url,
        };
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v4.attributes, 0x1::string::utf8(b"media_type"), 0x1::string::utf8(b"Vintage DVD"));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v4.attributes, 0x1::string::utf8(b"rarity"), 0x1::string::utf8(b"Legendry"));
        let v5 = 0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::rewards::borrow_tier_reward(arg4, arg1, 1);
        let v6 = TireNFTRewards{
            gangsters      : 0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::rewards::borrow_gangsters_reward(v5),
            game_resources : 0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::rewards::borrow_game_resources_reward(v5),
            perks          : 0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::rewards::borrow_perks_reward(v5),
            hq_aesthetics  : 0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::rewards::borrow_hq_aesthetics_reward(v5),
            is_claimed     : false,
        };
        0x2::dynamic_field::add<u64, TireNFTRewards>(&mut v4.id, 1, v6);
        0x2::dynamic_field::add<0x1::string::String, u64>(&mut v4.id, 0x1::string::utf8(b"spin_count"), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg5, arg0.admin);
        arg0.current_supply = arg0.current_supply + 1;
        let (v7, v8) = 0x2::kiosk::new(arg6);
        let v9 = v8;
        let v10 = v7;
        0x2::kiosk::lock<TestNFT>(&mut v10, &v9, arg3, v4);
        0x2::kiosk::set_owner(&mut v10, &v9, arg6);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v9, 0x2::tx_context::sender(arg6));
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v10);
    }

    fun calculate_rarity(arg0: &0x2::random::Random, arg1: &mut 0x2::tx_context::TxContext) : u8 {
        let v0 = 0x2::random::new_generator(arg0, arg1);
        let v1 = 0x2::random::generate_u8_in_range(&mut v0, 1, 100) % 100;
        if (v1 < 7) {
            1
        } else if (v1 < 14) {
            2
        } else if (v1 < 21) {
            3
        } else if (v1 < 35) {
            4
        } else {
            5
        }
    }

    public fun claim_nft_gift(arg0: &0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::version::Version, arg1: &0x2::transfer_policy::TransferPolicy<TestNFT>, arg2: &mut GiftRegistry, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::version::validate_version(arg0, 1);
        assert!(0x2::table::contains<address, vector<GiftMetadata>>(&arg2.gift_map, 0x2::tx_context::sender(arg4)), 12);
        let v0 = 0x2::table::borrow_mut<address, vector<GiftMetadata>>(&mut arg2.gift_map, 0x2::tx_context::sender(arg4));
        assert!(arg3 + 1 <= 0x1::vector::length<GiftMetadata>(v0), 11);
        let v1 = 0x1::vector::borrow_mut<GiftMetadata>(v0, arg3);
        v1.claimed = true;
        let (v2, v3) = 0x2::kiosk::new(arg4);
        let v4 = v3;
        let v5 = v2;
        0x2::kiosk::lock<TestNFT>(&mut v5, &v4, arg1, 0x2::bag::remove<0x2::object::ID, TestNFT>(&mut v1.dvd, v1.gift_id));
        0x2::kiosk::set_owner(&mut v5, &v4, arg4);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v4, 0x2::tx_context::sender(arg4));
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v5);
    }

    public fun free_mint(arg0: &0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::version::Version, arg1: &Config, arg2: &mut 0x2::tx_context::TxContext) : TestNFT {
        0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::version::validate_version(arg0, 1);
        assert!(!arg1.pause_free_mint, 14);
        TestNFT{
            id          : 0x2::object::new(arg2),
            tier        : 0,
            name        : 0x1::string::utf8(b"The Free test NFT"),
            description : 0x1::string::utf8(b"The test description"),
            attributes  : 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>(),
            image_url   : 0x1::string::utf8(b"The image url"),
        }
    }

    entry fun gift_special_edition_nft(arg0: &mut Config, arg1: &0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::version::Version, arg2: &0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::rewards::RewardRegistry, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut GiftRegistry, arg5: address, arg6: 0x1::string::String, arg7: &0x2::random::Random, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.current_supply <= arg0.total_supply, 8);
        0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::version::validate_version(arg1, 1);
        assert!(!arg0.pause_exclusive_mint, 14);
        let v0 = 1;
        let v1 = 0x2::vec_map::get<u8, SampleMetadata>(&arg0.tier_details, &v0);
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        let v3 = 1;
        assert!(&v2 == 0x2::vec_map::get<u8, u64>(&arg0.upgrade_cost, &v3), 4);
        calculate_rarity(arg7, arg8);
        let v4 = TestNFT{
            id          : 0x2::object::new(arg8),
            tier        : 1,
            name        : v1.name,
            description : v1.description,
            attributes  : 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>(),
            image_url   : v1.image_url,
        };
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v4.attributes, 0x1::string::utf8(b"media_type"), 0x1::string::utf8(b"Vintage DVD"));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v4.attributes, 0x1::string::utf8(b"rarity"), 0x1::string::utf8(b"Legendry"));
        let v5 = 0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::rewards::borrow_tier_reward(arg2, arg1, 1);
        let v6 = TireNFTRewards{
            gangsters      : 0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::rewards::borrow_gangsters_reward(v5),
            game_resources : 0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::rewards::borrow_game_resources_reward(v5),
            perks          : 0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::rewards::borrow_perks_reward(v5),
            hq_aesthetics  : 0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::rewards::borrow_hq_aesthetics_reward(v5),
            is_claimed     : false,
        };
        0x2::dynamic_field::add<u64, TireNFTRewards>(&mut v4.id, 1, v6);
        0x2::dynamic_field::add<0x1::string::String, u64>(&mut v4.id, 0x1::string::utf8(b"spin_count"), 1);
        if (0x2::table::contains<address, vector<GiftMetadata>>(&arg4.gift_map, arg5)) {
            let v7 = GiftMetadata{
                gift_id  : 0x2::object::id<TestNFT>(&v4),
                message  : arg6,
                sender   : 0x2::tx_context::sender(arg8),
                receiver : arg5,
                claimed  : false,
                dvd      : 0x2::bag::new(arg8),
            };
            0x2::bag::add<0x2::object::ID, TestNFT>(&mut v7.dvd, 0x2::object::id<TestNFT>(&v4), v4);
            0x1::vector::push_back<GiftMetadata>(0x2::table::borrow_mut<address, vector<GiftMetadata>>(&mut arg4.gift_map, arg5), v7);
        } else {
            let v8 = GiftMetadata{
                gift_id  : 0x2::object::id<TestNFT>(&v4),
                message  : arg6,
                sender   : 0x2::tx_context::sender(arg8),
                receiver : arg5,
                claimed  : false,
                dvd      : 0x2::bag::new(arg8),
            };
            0x2::bag::add<0x2::object::ID, TestNFT>(&mut v8.dvd, 0x2::object::id<TestNFT>(&v4), v4);
            let v9 = 0x1::vector::empty<GiftMetadata>();
            0x1::vector::push_back<GiftMetadata>(&mut v9, v8);
            0x2::table::add<address, vector<GiftMetadata>>(&mut arg4.gift_map, arg5, v9);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, arg0.admin);
        arg0.current_supply = arg0.current_supply + 1;
    }

    fun init(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<NFT>(arg0, arg1);
        let (v1, v2) = 0x2::transfer_policy::new<TestNFT>(&v0, arg1);
        let v3 = Config{
            id                   : 0x2::object::new(arg1),
            tier_details         : 0x2::vec_map::empty<u8, SampleMetadata>(),
            upgrade_cost         : 0x2::vec_map::empty<u8, u64>(),
            total_supply         : 10000,
            current_supply       : 0,
            base_tire            : 1,
            max_tire             : 6,
            pause_free_mint      : true,
            pause_exclusive_mint : true,
            admin                : 0x2::tx_context::sender(arg1),
        };
        let v4 = GiftRegistry{
            id       : 0x2::object::new(arg1),
            gift_map : 0x2::table::new<address, vector<GiftMetadata>>(arg1),
        };
        let v5 = 0x2::display::new<TestNFT>(&v0, arg1);
        0x2::display::add<TestNFT>(&mut v5, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"NFT #{number}"));
        0x2::display::add<TestNFT>(&mut v5, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"The awesome Monkey NFT."));
        0x2::display::add<TestNFT>(&mut v5, 0x1::string::utf8(b"number"), 0x1::string::utf8(b"{number}"));
        0x2::display::add<TestNFT>(&mut v5, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://cdn.pixabay.com/photo/2012/04/18/15/49/monkey-37394_1280.png"));
        0x2::display::update_version<TestNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::display::Display<TestNFT>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<GiftRegistry>(v4);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<TestNFT>>(v1);
        0x2::transfer::public_share_object<Config>(v3);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<TestNFT>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun is_valid_player(arg0: &TestNFT, arg1: 0x2::object::ID) {
        assert!(arg1 == *0x2::dynamic_field::borrow<0x1::string::String, 0x2::object::ID>(&arg0.id, 0x1::string::utf8(b"player")), 1);
    }

    fun new_attribute(arg0: u16, arg1: u8) : Attributes {
        Attributes{
            media_type     : 0x1::string::utf8(b"JPEG"),
            edition_number : arg0,
            total_editions : 1000,
            edition        : 0x1::string::utf8(b"vintage"),
            art_style      : 0x1::string::utf8(b"Comics"),
            rarity_class   : arg1,
            theme          : 0x1::string::utf8(b"Black and white"),
            character_type : 0x1::string::utf8(b"Awesome character"),
        }
    }

    public fun pause_exclusive_mint(arg0: &0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::authority::OperatorCap, arg1: &0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::version::Version, arg2: &mut Config) {
        0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::version::validate_version(arg1, 1);
        arg2.pause_exclusive_mint = true;
    }

    public fun pause_free_mint(arg0: &0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::authority::OperatorCap, arg1: &0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::version::Version, arg2: &mut Config) {
        0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::version::validate_version(arg1, 1);
        arg2.pause_free_mint = true;
    }

    public fun unpause_exclusive_mint(arg0: &0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::authority::OperatorCap, arg1: &0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::version::Version, arg2: &mut Config) {
        0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::version::validate_version(arg1, 1);
        arg2.pause_exclusive_mint = false;
    }

    public fun unpause_pause_free_mint(arg0: &0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::authority::OperatorCap, arg1: &0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::version::Version, arg2: &mut Config) {
        0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::version::validate_version(arg1, 1);
        arg2.pause_free_mint = false;
    }

    public fun update_dvd_supply(arg0: &0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::authority::OperatorCap, arg1: &mut Config, arg2: u64) {
        arg1.total_supply = arg2;
    }

    public(friend) fun update_spin_count(arg0: &mut TestNFT, arg1: u16) {
        let v0 = 0x2::dynamic_field::borrow_mut<0x1::string::String, u16>(&mut arg0.id, 0x1::string::utf8(b"spin_count"));
        *v0 = *v0 - arg1;
    }

    public fun update_upgrade_cost(arg0: &0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::authority::OperatorCap, arg1: &0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::version::Version, arg2: &mut Config, arg3: u8, arg4: u64) {
        0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::version::validate_version(arg1, 1);
        assert!(0x2::vec_map::contains<u8, u64>(&arg2.upgrade_cost, &arg3), 2);
        *0x2::vec_map::get_mut<u8, u64>(&mut arg2.upgrade_cost, &arg3) = arg4;
    }

    public fun upgrade_nft(arg0: &mut TestNFT, arg1: &0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::version::Version, arg2: &0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::rewards::RewardRegistry, arg3: &Config, arg4: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::version::validate_version(arg1, 1);
        assert!(arg0.tier != 0, 10);
        let v0 = arg0.tier + 1;
        assert!(v0 >= arg3.base_tire && v0 <= arg3.max_tire, 3);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg4);
        assert!(&v1 == 0x2::vec_map::get<u8, u64>(&arg3.upgrade_cost, &v0), 4);
        arg0.tier = v0;
        let v2 = 0x2::vec_map::get<u8, SampleMetadata>(&arg3.tier_details, &v0);
        arg0.name = v2.name;
        arg0.description = v2.description;
        arg0.image_url = v2.image_url;
        let v3 = 0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::rewards::borrow_tier_reward(arg2, arg1, v0);
        let v4 = TireNFTRewards{
            gangsters      : 0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::rewards::borrow_gangsters_reward(v3),
            game_resources : 0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::rewards::borrow_game_resources_reward(v3),
            perks          : 0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::rewards::borrow_perks_reward(v3),
            hq_aesthetics  : 0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::rewards::borrow_hq_aesthetics_reward(v3),
            is_claimed     : false,
        };
        0x2::dynamic_field::add<u8, TireNFTRewards>(&mut arg0.id, v0, v4);
        let v5 = 0x2::dynamic_field::borrow_mut<0x1::string::String, u64>(&mut arg0.id, 0x1::string::utf8(b"spin_count"));
        *v5 = *v5 + (0x2cf4f911003df11729340f18161ba9f8c0d5cfa30a0d52860dbc7fcdd1049d1c::rewards::borrow_spin_reward(v3) as u64);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg4, arg3.admin);
    }

    public(friend) fun validate_spin_reward(arg0: &TestNFT, arg1: &Config, arg2: u8) : bool {
        assert!(arg2 >= arg1.base_tire && arg2 <= arg1.max_tire, 3);
        *0x2::dynamic_field::borrow<0x1::string::String, u16>(&arg0.id, 0x1::string::utf8(b"spin_count")) >= 1
    }

    // decompiled from Move bytecode v6
}

