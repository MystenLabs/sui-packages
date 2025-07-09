module 0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::vendetta_dvd {
    struct VENDETTA_DVD has drop {
        dummy_field: bool,
    }

    struct VendettaDVD has store, key {
        id: 0x2::object::UID,
        tier: u8,
        name: 0x1::string::String,
        description: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        image_url: 0x1::string::String,
        model_url: 0x1::string::String,
        number: u64,
    }

    struct FeaturePause has store {
        pause_free_mint: bool,
        pause_exclusive_mint: bool,
        pause_spin: bool,
        pause_gift: bool,
    }

    struct Config has store, key {
        id: 0x2::object::UID,
        tier_details: 0x2::vec_map::VecMap<u8, TierMetadata>,
        upgrade_cost: 0x2::vec_map::VecMap<u8, u64>,
        total_supply: u64,
        current_supply: u64,
        base_tier: u8,
        max_tier: u8,
        feature_pause: FeaturePause,
        admin: address,
    }

    struct Attributes has store {
        texture: 0x1::string::String,
        cover_art: 0x1::string::String,
        edition: 0x1::string::String,
        description: 0x1::string::String,
    }

    struct AttributesReg has key {
        id: 0x2::object::UID,
        metadata: 0x2::vec_map::VecMap<u8, Attributes>,
    }

    struct TierMetadata has store {
        name: 0x1::string::String,
        base_image_url: 0x1::string::String,
        color: 0x1::string::String,
    }

    struct Reward has store, key {
        id: 0x2::object::UID,
        rewards: 0x2::vec_map::VecMap<0x1::string::String, u64>,
    }

    struct TierDvdRewards has store {
        gangsters: 0x2::vec_map::VecMap<0x1::string::String, u8>,
        game_resources: 0x2::vec_map::VecMap<0x1::string::String, u64>,
        physical_items: vector<0x1::string::String>,
        perks: 0x2::vec_map::VecMap<0x1::string::String, u8>,
        hq_aesthetics: 0x1::string::String,
        is_claimed: bool,
    }

    struct GiftMetadata has store, key {
        id: 0x2::object::UID,
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

    struct BuyDvdEvent has copy, drop {
        nft_id: 0x2::object::ID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        price_paid: u64,
        receiver: address,
        edition: 0x1::string::String,
        texture: 0x1::string::String,
        cover_art: 0x1::string::String,
        tier: u8,
    }

    struct UpgradeDvdEvent has copy, drop {
        nft_id: 0x2::object::ID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        price_paid: u64,
        owner: address,
        edition: 0x1::string::String,
        texture: 0x1::string::String,
        cover_art: 0x1::string::String,
        tier: u8,
    }

    struct GiftDvdEvent has copy, drop {
        nft_id: 0x2::object::ID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        sender: address,
        receiver: address,
        edition: 0x1::string::String,
        texture: 0x1::string::String,
        cover_art: 0x1::string::String,
        tier: u8,
    }

    struct GiftClaimedEvent has copy, drop {
        nft_id: 0x2::object::ID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        claimed_by: address,
        edition: 0x1::string::String,
        texture: 0x1::string::String,
        cover_art: 0x1::string::String,
        tier: u8,
    }

    public(friend) fun new(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: u8, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : VendettaDVD {
        VendettaDVD{
            id          : 0x2::object::new(arg6),
            tier        : arg2,
            name        : arg0,
            description : arg1,
            attributes  : 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>(),
            image_url   : arg3,
            model_url   : arg4,
            number      : arg5,
        }
    }

    public fun add_metadata(arg0: &0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_authority::OperatorCap, arg1: &0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_authority::OperatorCapsBag, arg2: &0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_version::Version, arg3: &mut AttributesReg, arg4: u8, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: &mut 0x2::tx_context::TxContext) {
        0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_version::validate_version(arg2, 2);
        0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_authority::is_valid_operator(arg0, 0x2::tx_context::sender(arg9), arg1);
        assert!(!0x2::vec_map::contains<u8, Attributes>(&arg3.metadata, &arg4), 11);
        let v0 = Attributes{
            texture     : arg5,
            cover_art   : arg6,
            edition     : arg7,
            description : arg8,
        };
        0x2::vec_map::insert<u8, Attributes>(&mut arg3.metadata, arg4, v0);
    }

    public fun add_player(arg0: &mut VendettaDVD, arg1: &0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_version::Version, arg2: &0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_authority::DVDCap, arg3: 0x2::object::ID) {
        0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_version::validate_version(arg1, 2);
        assert!(!0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, 0x1::string::utf8(b"player")), 16);
        0x2::dynamic_field::add<0x1::string::String, 0x2::object::ID>(&mut arg0.id, 0x1::string::utf8(b"player"), arg3);
    }

    public(friend) fun add_spin_reward(arg0: &mut VendettaDVD, arg1: &0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_rewards::RewardRegistry, arg2: &0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_version::Version, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) : (0x1::string::String, u64) {
        let (v0, v1) = 0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_rewards::borrow_spin_reward_value_by_idx(0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_rewards::borrow_spin_reward(arg1, arg2, 0x1::string::utf8(b"spin_reward")), (arg3 as u64));
        let v2 = v0;
        if (0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, 0x1::string::utf8(b"accumulated_reward"))) {
            let v3 = 0x2::dynamic_field::borrow_mut<0x1::string::String, Reward>(&mut arg0.id, 0x1::string::utf8(b"accumulated_reward"));
            if (0x2::vec_map::contains<0x1::string::String, u64>(&v3.rewards, &v2)) {
                let v4 = 0x2::vec_map::get_mut<0x1::string::String, u64>(&mut v3.rewards, &v2);
                *v4 = *v4 + v1;
            } else {
                0x2::vec_map::insert<0x1::string::String, u64>(&mut v3.rewards, v2, v1);
            };
        } else {
            let v5 = Reward{
                id      : 0x2::object::new(arg4),
                rewards : 0x2::vec_map::empty<0x1::string::String, u64>(),
            };
            0x2::vec_map::insert<0x1::string::String, u64>(&mut v5.rewards, v2, v1);
            0x2::dynamic_field::add<0x1::string::String, Reward>(&mut arg0.id, 0x1::string::utf8(b"accumulated_reward"), v5);
        };
        (v2, v1)
    }

    public fun add_tier_config(arg0: &0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_authority::OperatorCap, arg1: &0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_authority::OperatorCapsBag, arg2: &0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_version::Version, arg3: &mut Config, arg4: u8, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: &0x2::tx_context::TxContext) {
        0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_version::validate_version(arg2, 2);
        0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_authority::is_valid_operator(arg0, 0x2::tx_context::sender(arg8), arg1);
        assert!(0x2::vec_map::contains<u8, u64>(&arg3.upgrade_cost, &arg4), 5);
        let v0 = TierMetadata{
            name           : arg5,
            base_image_url : arg6,
            color          : arg7,
        };
        0x2::vec_map::insert<u8, TierMetadata>(&mut arg3.tier_details, arg4, v0);
    }

    public fun add_upgrade_cost(arg0: &0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_authority::OperatorCap, arg1: &0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_authority::OperatorCapsBag, arg2: &0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_version::Version, arg3: &mut Config, arg4: u8, arg5: u64, arg6: &0x2::tx_context::TxContext) {
        0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_version::validate_version(arg2, 2);
        0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_authority::is_valid_operator(arg0, 0x2::tx_context::sender(arg6), arg1);
        assert!(!0x2::vec_map::contains<u8, u64>(&arg3.upgrade_cost, &arg4), 0);
        0x2::vec_map::insert<u8, u64>(&mut arg3.upgrade_cost, arg4, arg5);
    }

    entry fun admin_mint_special_edition_dvd(arg0: &0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_authority::GovernorCap, arg1: &mut Config, arg2: &0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_version::Version, arg3: &0x2::random::Random, arg4: &AttributesReg, arg5: &0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_rewards::RewardRegistry, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.current_supply + arg6 <= arg1.total_supply, 6);
        assert!(!arg1.feature_pause.pause_exclusive_mint, 10);
        assert!(arg6 > 0 && arg6 <= 10, 13);
        0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_version::validate_version(arg2, 2);
        let v0 = 1;
        let v1 = 0x2::vec_map::get<u8, TierMetadata>(&arg1.tier_details, &v0);
        let v2 = 1;
        while (arg6 != 0) {
            let v3 = 0x1::string::utf8(b"Vendetta Original #");
            0x1::string::append(&mut v3, 0x1::u64::to_string(arg1.current_supply + 1));
            let v4 = new(v3, 0x2::vec_map::get<u8, Attributes>(&arg4.metadata, &v2).description, 1, v1.base_image_url, v1.base_image_url, arg1.current_supply + 1, arg7);
            let v5 = &mut v4;
            let (v6, v7, v8) = new_attributes(v5, arg3, arg4, arg7);
            v4.image_url = format_new_url(v1.base_image_url, v6, 0x1::string::utf8(b".webp"), v2);
            v4.model_url = format_new_url(v1.base_image_url, v6, 0x1::string::utf8(b".glb"), v2);
            let v9 = 0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_rewards::borrow_tier_reward(arg5, arg2, 1);
            let v10 = TierDvdRewards{
                gangsters      : 0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_rewards::borrow_gangsters_reward(v9),
                game_resources : 0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_rewards::borrow_game_resources_reward(v9),
                physical_items : 0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_rewards::borrow_physical_items_reward(v9),
                perks          : 0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_rewards::borrow_perks_reward(v9),
                hq_aesthetics  : 0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_rewards::borrow_hq_aesthetics_reward(v9),
                is_claimed     : false,
            };
            0x2::dynamic_field::add<u64, TierDvdRewards>(&mut v4.id, 1, v10);
            0x2::dynamic_field::add<0x1::string::String, u64>(&mut v4.id, 0x1::string::utf8(b"spin_count"), 2);
            arg1.current_supply = arg1.current_supply + 1;
            let v11 = BuyDvdEvent{
                nft_id     : 0x2::object::id<VendettaDVD>(&v4),
                name       : v4.name,
                image_url  : v4.image_url,
                price_paid : 0,
                receiver   : 0x2::tx_context::sender(arg7),
                edition    : v6,
                texture    : v7,
                cover_art  : v8,
                tier       : v4.tier,
            };
            0x2::event::emit<BuyDvdEvent>(v11);
            0x2::transfer::transfer<VendettaDVD>(v4, 0x2::tx_context::sender(arg7));
            arg6 = arg6 - 1;
        };
    }

    public fun borrow_edition_name(arg0: &VendettaDVD) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"edition");
        *0x2::vec_map::get<0x1::string::String, 0x1::string::String>(&arg0.attributes, &v0)
    }

    entry fun buy_special_edition_dvd_batch(arg0: &mut Config, arg1: &0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_version::Version, arg2: &0x2::random::Random, arg3: &0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_rewards::RewardRegistry, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &AttributesReg, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.current_supply + arg6 <= arg0.total_supply, 6);
        assert!(!arg0.feature_pause.pause_exclusive_mint, 10);
        assert!(arg6 > 0 && arg6 <= 10, 13);
        0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_version::validate_version(arg1, 2);
        let v0 = 1;
        let v1 = 0x2::vec_map::get<u8, TierMetadata>(&arg0.tier_details, &v0);
        let v2 = 1;
        let v3 = *0x2::vec_map::get<u8, u64>(&arg0.upgrade_cost, &v2);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg4) == v3 * arg6, 4);
        let v4 = 1;
        let v5 = 1;
        while (arg6 != 0) {
            let v6 = 0x1::string::utf8(b"Vendetta Original #");
            0x1::string::append(&mut v6, 0x1::u64::to_string(arg0.current_supply + 1));
            let v7 = new(v6, 0x2::vec_map::get<u8, Attributes>(&arg5.metadata, &v4).description, 1, v1.base_image_url, v1.base_image_url, arg0.current_supply + 1, arg7);
            let v8 = &mut v7;
            let (v9, v10, v11) = new_attributes(v8, arg2, arg5, arg7);
            v7.image_url = format_new_url(v1.base_image_url, v9, 0x1::string::utf8(b".webp"), v5);
            v7.model_url = format_new_url(v1.base_image_url, v9, 0x1::string::utf8(b".glb"), v5);
            let v12 = 0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_rewards::borrow_tier_reward(arg3, arg1, 1);
            let v13 = TierDvdRewards{
                gangsters      : 0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_rewards::borrow_gangsters_reward(v12),
                game_resources : 0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_rewards::borrow_game_resources_reward(v12),
                physical_items : 0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_rewards::borrow_physical_items_reward(v12),
                perks          : 0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_rewards::borrow_perks_reward(v12),
                hq_aesthetics  : 0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_rewards::borrow_hq_aesthetics_reward(v12),
                is_claimed     : false,
            };
            0x2::dynamic_field::add<u64, TierDvdRewards>(&mut v7.id, 1, v13);
            0x2::dynamic_field::add<0x1::string::String, u64>(&mut v7.id, 0x1::string::utf8(b"spin_count"), 2);
            arg0.current_supply = arg0.current_supply + 1;
            let v14 = BuyDvdEvent{
                nft_id     : 0x2::object::id<VendettaDVD>(&v7),
                name       : v7.name,
                image_url  : v7.image_url,
                price_paid : v3,
                receiver   : 0x2::tx_context::sender(arg7),
                edition    : v9,
                texture    : v10,
                cover_art  : v11,
                tier       : v7.tier,
            };
            0x2::event::emit<BuyDvdEvent>(v14);
            0x2::transfer::transfer<VendettaDVD>(v7, 0x2::tx_context::sender(arg7));
            arg6 = arg6 - 1;
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg4, arg0.admin);
    }

    fun calculate_edition_rarity(arg0: &0x2::random::Random, arg1: &mut 0x2::tx_context::TxContext) : u8 {
        let v0 = 0x2::random::new_generator(arg0, arg1);
        let v1 = 0x2::random::generate_u8_in_range(&mut v0, 1, 100) % 100;
        if (v1 < 40) {
            1
        } else if (v1 < 65) {
            2
        } else if (v1 < 80) {
            3
        } else if (v1 < 90) {
            4
        } else if (v1 < 95) {
            5
        } else {
            6
        }
    }

    fun calculate_texture_rarity(arg0: &0x2::random::Random, arg1: &mut 0x2::tx_context::TxContext) : u8 {
        let v0 = 0x2::random::new_generator(arg0, arg1);
        let v1 = 0x2::random::generate_u8_in_range(&mut v0, 1, 100) % 100;
        if (v1 < 30) {
            1
        } else if (v1 < 50) {
            2
        } else if (v1 < 67) {
            3
        } else if (v1 < 82) {
            4
        } else if (v1 < 93) {
            5
        } else {
            6
        }
    }

    public fun claim_dvd_gift(arg0: &0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_version::Version, arg1: &mut GiftRegistry, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_version::validate_version(arg0, 2);
        assert!(0x2::table::contains<address, vector<GiftMetadata>>(&arg1.gift_map, 0x2::tx_context::sender(arg3)), 9);
        let v0 = 0x2::table::borrow_mut<address, vector<GiftMetadata>>(&mut arg1.gift_map, 0x2::tx_context::sender(arg3));
        assert!(arg2 + 1 <= 0x1::vector::length<GiftMetadata>(v0), 8);
        let v1 = 0x1::vector::borrow_mut<GiftMetadata>(v0, arg2);
        let v2 = 0x2::bag::remove<0x2::object::ID, VendettaDVD>(&mut v1.dvd, v1.gift_id);
        let v3 = 0x1::string::utf8(b"edition");
        let v4 = 0x1::string::utf8(b"texture");
        let v5 = 0x1::string::utf8(b"cover_art");
        let v6 = GiftClaimedEvent{
            nft_id     : 0x2::object::id<VendettaDVD>(&v2),
            name       : v2.name,
            image_url  : v2.image_url,
            claimed_by : 0x2::tx_context::sender(arg3),
            edition    : *0x2::vec_map::get<0x1::string::String, 0x1::string::String>(&v2.attributes, &v3),
            texture    : *0x2::vec_map::get<0x1::string::String, 0x1::string::String>(&v2.attributes, &v4),
            cover_art  : *0x2::vec_map::get<0x1::string::String, 0x1::string::String>(&v2.attributes, &v5),
            tier       : v2.tier,
        };
        0x2::event::emit<GiftClaimedEvent>(v6);
        0x2::transfer::transfer<VendettaDVD>(v2, 0x2::tx_context::sender(arg3));
        let GiftMetadata {
            id       : v7,
            gift_id  : _,
            message  : _,
            sender   : _,
            receiver : _,
            claimed  : _,
            dvd      : v13,
        } = 0x1::vector::remove<GiftMetadata>(v0, arg2);
        0x2::object::delete(v7);
        0x2::bag::destroy_empty(v13);
    }

    fun format_new_url(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u8) : 0x1::string::String {
        0x1::string::append(&mut arg0, arg1);
        0x1::string::append(&mut arg0, 0x1::string::utf8(b"/"));
        0x1::string::append(&mut arg0, 0x1::u8::to_string(arg3));
        0x1::string::append(&mut arg0, arg2);
        arg0
    }

    public fun get_game_resources(arg0: &VendettaDVD, arg1: u8) : 0x2::vec_map::VecMap<0x1::string::String, u64> {
        if (arg1 == 1) {
            assert!(0x2::dynamic_field::exists_<u64>(&arg0.id, 1), 17);
            0x2::dynamic_field::borrow<u64, TierDvdRewards>(&arg0.id, 1).game_resources
        } else {
            assert!(0x2::dynamic_field::exists_<u8>(&arg0.id, arg1), 17);
            0x2::dynamic_field::borrow<u8, TierDvdRewards>(&arg0.id, arg1).game_resources
        }
    }

    public fun get_gangster(arg0: &VendettaDVD, arg1: u8) : 0x2::vec_map::VecMap<0x1::string::String, u8> {
        if (arg1 == 1) {
            assert!(0x2::dynamic_field::exists_<u64>(&arg0.id, 1), 17);
            0x2::dynamic_field::borrow<u64, TierDvdRewards>(&arg0.id, 1).gangsters
        } else {
            assert!(0x2::dynamic_field::exists_<u8>(&arg0.id, arg1), 17);
            0x2::dynamic_field::borrow<u8, TierDvdRewards>(&arg0.id, arg1).gangsters
        }
    }

    public fun get_hq_aesthetic(arg0: &VendettaDVD, arg1: u8) : 0x1::string::String {
        if (arg1 == 1) {
            assert!(0x2::dynamic_field::exists_<u64>(&arg0.id, 1), 17);
            0x2::dynamic_field::borrow<u64, TierDvdRewards>(&arg0.id, 1).hq_aesthetics
        } else {
            assert!(0x2::dynamic_field::exists_<u8>(&arg0.id, arg1), 17);
            0x2::dynamic_field::borrow<u8, TierDvdRewards>(&arg0.id, arg1).hq_aesthetics
        }
    }

    public fun get_perks(arg0: &VendettaDVD, arg1: u8) : 0x2::vec_map::VecMap<0x1::string::String, u8> {
        if (arg1 == 1) {
            assert!(0x2::dynamic_field::exists_<u64>(&arg0.id, 1), 17);
            0x2::dynamic_field::borrow<u64, TierDvdRewards>(&arg0.id, 1).perks
        } else {
            assert!(0x2::dynamic_field::exists_<u8>(&arg0.id, arg1), 17);
            0x2::dynamic_field::borrow<u8, TierDvdRewards>(&arg0.id, arg1).perks
        }
    }

    public fun get_physical_items(arg0: &VendettaDVD, arg1: u8) : vector<0x1::string::String> {
        if (arg1 == 1) {
            assert!(0x2::dynamic_field::exists_<u64>(&arg0.id, 1), 17);
            0x2::dynamic_field::borrow<u64, TierDvdRewards>(&arg0.id, 1).physical_items
        } else {
            assert!(0x2::dynamic_field::exists_<u8>(&arg0.id, arg1), 17);
            0x2::dynamic_field::borrow<u8, TierDvdRewards>(&arg0.id, arg1).physical_items
        }
    }

    public fun get_tier(arg0: &VendettaDVD) : u8 {
        arg0.tier
    }

    public fun get_tier_reward(arg0: &VendettaDVD, arg1: u8) : &TierDvdRewards {
        if (arg1 == 1) {
            assert!(0x2::dynamic_field::exists_<u64>(&arg0.id, 1), 17);
            0x2::dynamic_field::borrow<u64, TierDvdRewards>(&arg0.id, 1)
        } else {
            assert!(0x2::dynamic_field::exists_<u8>(&arg0.id, arg1), 17);
            0x2::dynamic_field::borrow<u8, TierDvdRewards>(&arg0.id, arg1)
        }
    }

    public fun gift_special_edition_dvd(arg0: &Config, arg1: &0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_version::Version, arg2: VendettaDVD, arg3: &mut GiftRegistry, arg4: address, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_version::validate_version(arg1, 2);
        assert!(!arg0.feature_pause.pause_gift, 10);
        assert!(0x1::string::length(&arg5) < 500, 12);
        assert!(arg4 != 0x2::tx_context::sender(arg6), 14);
        let v0 = 0x1::string::utf8(b"edition");
        let v1 = 0x1::string::utf8(b"texture");
        let v2 = 0x1::string::utf8(b"cover_art");
        let v3 = GiftDvdEvent{
            nft_id    : 0x2::object::id<VendettaDVD>(&arg2),
            name      : arg2.name,
            image_url : arg2.image_url,
            sender    : 0x2::tx_context::sender(arg6),
            receiver  : arg4,
            edition   : *0x2::vec_map::get<0x1::string::String, 0x1::string::String>(&arg2.attributes, &v0),
            texture   : *0x2::vec_map::get<0x1::string::String, 0x1::string::String>(&arg2.attributes, &v1),
            cover_art : *0x2::vec_map::get<0x1::string::String, 0x1::string::String>(&arg2.attributes, &v2),
            tier      : arg2.tier,
        };
        0x2::event::emit<GiftDvdEvent>(v3);
        if (0x2::table::contains<address, vector<GiftMetadata>>(&arg3.gift_map, arg4)) {
            let v4 = GiftMetadata{
                id       : 0x2::object::new(arg6),
                gift_id  : 0x2::object::id<VendettaDVD>(&arg2),
                message  : arg5,
                sender   : 0x2::tx_context::sender(arg6),
                receiver : arg4,
                claimed  : false,
                dvd      : 0x2::bag::new(arg6),
            };
            0x2::bag::add<0x2::object::ID, VendettaDVD>(&mut v4.dvd, 0x2::object::id<VendettaDVD>(&arg2), arg2);
            0x1::vector::push_back<GiftMetadata>(0x2::table::borrow_mut<address, vector<GiftMetadata>>(&mut arg3.gift_map, arg4), v4);
        } else {
            let v5 = GiftMetadata{
                id       : 0x2::object::new(arg6),
                gift_id  : 0x2::object::id<VendettaDVD>(&arg2),
                message  : arg5,
                sender   : 0x2::tx_context::sender(arg6),
                receiver : arg4,
                claimed  : false,
                dvd      : 0x2::bag::new(arg6),
            };
            0x2::bag::add<0x2::object::ID, VendettaDVD>(&mut v5.dvd, 0x2::object::id<VendettaDVD>(&arg2), arg2);
            let v6 = 0x1::vector::empty<GiftMetadata>();
            0x1::vector::push_back<GiftMetadata>(&mut v6, v5);
            0x2::table::add<address, vector<GiftMetadata>>(&mut arg3.gift_map, arg4, v6);
        };
    }

    fun init(arg0: VENDETTA_DVD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<VENDETTA_DVD>(arg0, arg1);
        let (v1, v2) = 0x2::transfer_policy::new<VendettaDVD>(&v0, arg1);
        let v3 = FeaturePause{
            pause_free_mint      : true,
            pause_exclusive_mint : true,
            pause_spin           : true,
            pause_gift           : true,
        };
        let v4 = Config{
            id             : 0x2::object::new(arg1),
            tier_details   : 0x2::vec_map::empty<u8, TierMetadata>(),
            upgrade_cost   : 0x2::vec_map::empty<u8, u64>(),
            total_supply   : 10000,
            current_supply : 0,
            base_tier      : 1,
            max_tier       : 6,
            feature_pause  : v3,
            admin          : 0x2::tx_context::sender(arg1),
        };
        let v5 = GiftRegistry{
            id       : 0x2::object::new(arg1),
            gift_map : 0x2::table::new<address, vector<GiftMetadata>>(arg1),
        };
        let v6 = AttributesReg{
            id       : 0x2::object::new(arg1),
            metadata : 0x2::vec_map::empty<u8, Attributes>(),
        };
        let v7 = 0x2::display::new<VendettaDVD>(&v0, arg1);
        0x2::display::add<VendettaDVD>(&mut v7, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Vendetta Original #{number}"));
        0x2::display::add<VendettaDVD>(&mut v7, 0x1::string::utf8(b"description"), 0x1::string::utf8(x"41207472756520636f6c6c6563746f72e28099732067656d2c20746869732056656e6465747461204f726967696e616c204456442069732070617274206f6620746865204f472031304b20636f6c6c656374696f6e2e20497420636f6e7461696e7320706c6179657227732067616d6520737461746520616e64206578636c757369766520696e2d67616d65207065726b732e"));
        0x2::display::add<VendettaDVD>(&mut v7, 0x1::string::utf8(b"number"), 0x1::string::utf8(b"{number}"));
        0x2::display::add<VendettaDVD>(&mut v7, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::update_version<VendettaDVD>(&mut v7);
        0x2::transfer::public_transfer<0x2::display::Display<VendettaDVD>>(v7, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<GiftRegistry>(v5);
        0x2::transfer::share_object<AttributesReg>(v6);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<VendettaDVD>>(v1);
        0x2::transfer::public_share_object<Config>(v4);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<VendettaDVD>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun is_reward_claimed(arg0: &VendettaDVD, arg1: u8) : bool {
        if (arg1 == 1) {
            assert!(0x2::dynamic_field::exists_<u64>(&arg0.id, 1), 17);
            0x2::dynamic_field::borrow<u64, TierDvdRewards>(&arg0.id, 1).is_claimed
        } else {
            assert!(0x2::dynamic_field::exists_<u8>(&arg0.id, arg1), 17);
            0x2::dynamic_field::borrow<u8, TierDvdRewards>(&arg0.id, arg1).is_claimed
        }
    }

    public fun is_spin_paused(arg0: &Config) : bool {
        arg0.feature_pause.pause_spin
    }

    public fun is_valid_player(arg0: &VendettaDVD, arg1: 0x2::object::ID) {
        abort 0
    }

    public fun is_valid_players(arg0: &VendettaDVD, arg1: &0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_version::Version, arg2: 0x2::object::ID) {
        0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_version::validate_version(arg1, 2);
        assert!(arg2 == *0x2::dynamic_field::borrow<0x1::string::String, 0x2::object::ID>(&arg0.id, 0x1::string::utf8(b"player")), 1);
    }

    fun new_attributes(arg0: &mut VendettaDVD, arg1: &0x2::random::Random, arg2: &AttributesReg, arg3: &mut 0x2::tx_context::TxContext) : (0x1::string::String, 0x1::string::String, 0x1::string::String) {
        let v0 = calculate_texture_rarity(arg1, arg3);
        let v1 = 0x2::vec_map::get<u8, Attributes>(&arg2.metadata, &v0).texture;
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut arg0.attributes, 0x1::string::utf8(b"texture"), v1);
        let v2 = calculate_edition_rarity(arg1, arg3);
        let v3 = 0x2::vec_map::get<u8, Attributes>(&arg2.metadata, &v2).edition;
        let v4 = 0x2::vec_map::get<u8, Attributes>(&arg2.metadata, &v2).cover_art;
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut arg0.attributes, 0x1::string::utf8(b"edition"), v3);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut arg0.attributes, 0x1::string::utf8(b"cover_art"), v4);
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut arg0.attributes, 0x1::string::utf8(b"tier_name"), 0x1::string::utf8(b"common"));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut arg0.attributes, 0x1::string::utf8(b"color"), 0x1::string::utf8(b"dark"));
        (v3, v1, v4)
    }

    public fun pause_exclusive_mint(arg0: &0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_authority::OperatorCap, arg1: &0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_authority::OperatorCapsBag, arg2: &0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_version::Version, arg3: &mut Config, arg4: &0x2::tx_context::TxContext) {
        0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_version::validate_version(arg2, 2);
        0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_authority::is_valid_operator(arg0, 0x2::tx_context::sender(arg4), arg1);
        arg3.feature_pause.pause_exclusive_mint = true;
    }

    public fun pause_free_mint(arg0: &0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_authority::OperatorCap, arg1: &0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_authority::OperatorCapsBag, arg2: &0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_version::Version, arg3: &mut Config, arg4: &0x2::tx_context::TxContext) {
        0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_version::validate_version(arg2, 2);
        0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_authority::is_valid_operator(arg0, 0x2::tx_context::sender(arg4), arg1);
        arg3.feature_pause.pause_free_mint = true;
    }

    public fun pause_gift(arg0: &0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_authority::OperatorCap, arg1: &0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_authority::OperatorCapsBag, arg2: &0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_version::Version, arg3: &mut Config, arg4: &0x2::tx_context::TxContext) {
        0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_version::validate_version(arg2, 2);
        0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_authority::is_valid_operator(arg0, 0x2::tx_context::sender(arg4), arg1);
        arg3.feature_pause.pause_gift = true;
    }

    public fun pause_spin(arg0: &0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_authority::OperatorCap, arg1: &0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_authority::OperatorCapsBag, arg2: &0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_version::Version, arg3: &mut Config, arg4: &0x2::tx_context::TxContext) {
        0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_version::validate_version(arg2, 2);
        0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_authority::is_valid_operator(arg0, 0x2::tx_context::sender(arg4), arg1);
        arg3.feature_pause.pause_spin = true;
    }

    public fun set_admin_treasury_wallet(arg0: &0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_authority::GovernorCap, arg1: &0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_version::Version, arg2: address, arg3: &mut Config) {
        0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_version::validate_version(arg1, 2);
        arg3.admin = arg2;
    }

    public fun unpause_exclusive_mint(arg0: &0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_authority::OperatorCap, arg1: &0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_authority::OperatorCapsBag, arg2: &0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_version::Version, arg3: &mut Config, arg4: &0x2::tx_context::TxContext) {
        0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_version::validate_version(arg2, 2);
        0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_authority::is_valid_operator(arg0, 0x2::tx_context::sender(arg4), arg1);
        arg3.feature_pause.pause_exclusive_mint = false;
    }

    public fun unpause_gift(arg0: &0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_authority::OperatorCap, arg1: &0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_authority::OperatorCapsBag, arg2: &0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_version::Version, arg3: &mut Config, arg4: &0x2::tx_context::TxContext) {
        0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_version::validate_version(arg2, 2);
        0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_authority::is_valid_operator(arg0, 0x2::tx_context::sender(arg4), arg1);
        arg3.feature_pause.pause_gift = false;
    }

    public fun unpause_pause_free_mint(arg0: &0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_authority::OperatorCap, arg1: &0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_authority::OperatorCapsBag, arg2: &0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_version::Version, arg3: &mut Config, arg4: &0x2::tx_context::TxContext) {
        0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_version::validate_version(arg2, 2);
        0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_authority::is_valid_operator(arg0, 0x2::tx_context::sender(arg4), arg1);
        arg3.feature_pause.pause_free_mint = false;
    }

    public fun unpause_spin(arg0: &0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_authority::OperatorCap, arg1: &0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_authority::OperatorCapsBag, arg2: &0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_version::Version, arg3: &mut Config, arg4: &0x2::tx_context::TxContext) {
        0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_version::validate_version(arg2, 2);
        0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_authority::is_valid_operator(arg0, 0x2::tx_context::sender(arg4), arg1);
        arg3.feature_pause.pause_spin = false;
    }

    public fun update_dvd_supply(arg0: &0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_authority::OperatorCap, arg1: &0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_authority::OperatorCapsBag, arg2: &0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_version::Version, arg3: &mut Config, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_version::validate_version(arg2, 2);
        0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_authority::is_valid_operator(arg0, 0x2::tx_context::sender(arg5), arg1);
        assert!(arg3.total_supply < arg4, 15);
        arg3.total_supply = arg4;
    }

    public fun update_reward_status(arg0: &mut VendettaDVD, arg1: u8) {
        if (arg1 == 1) {
            assert!(0x2::dynamic_field::exists_<u64>(&arg0.id, 1), 17);
            0x2::dynamic_field::borrow_mut<u64, TierDvdRewards>(&mut arg0.id, 1).is_claimed = true;
        } else {
            assert!(0x2::dynamic_field::exists_<u8>(&arg0.id, arg1), 17);
            0x2::dynamic_field::borrow_mut<u8, TierDvdRewards>(&mut arg0.id, arg1).is_claimed = true;
        };
    }

    public(friend) fun update_spin_count(arg0: &mut VendettaDVD, arg1: u64) {
        let v0 = 0x2::dynamic_field::borrow_mut<0x1::string::String, u64>(&mut arg0.id, 0x1::string::utf8(b"spin_count"));
        *v0 = *v0 - arg1;
    }

    public fun update_upgrade_cost(arg0: &0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_authority::OperatorCap, arg1: &0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_authority::OperatorCapsBag, arg2: &0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_version::Version, arg3: &mut Config, arg4: u8, arg5: u64, arg6: &0x2::tx_context::TxContext) {
        0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_version::validate_version(arg2, 2);
        0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_authority::is_valid_operator(arg0, 0x2::tx_context::sender(arg6), arg1);
        assert!(0x2::vec_map::contains<u8, u64>(&arg3.upgrade_cost, &arg4), 2);
        *0x2::vec_map::get_mut<u8, u64>(&mut arg3.upgrade_cost, &arg4) = arg5;
    }

    public fun upgrade_dvd(arg0: &mut VendettaDVD, arg1: &0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_version::Version, arg2: &0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_rewards::RewardRegistry, arg3: &Config, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) {
        0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_version::validate_version(arg1, 2);
        assert!(arg0.tier != 0, 7);
        let v0 = arg0.tier + 1;
        assert!(v0 >= arg3.base_tier && v0 <= arg3.max_tier, 3);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg4);
        assert!(&v1 == 0x2::vec_map::get<u8, u64>(&arg3.upgrade_cost, &v0), 4);
        arg0.tier = v0;
        let v2 = 0x2::vec_map::get<u8, TierMetadata>(&arg3.tier_details, &v0);
        let v3 = 0x1::string::utf8(b"edition");
        let v4 = 0x2::vec_map::get_mut<0x1::string::String, 0x1::string::String>(&mut arg0.attributes, &v3);
        arg0.image_url = format_new_url(v2.base_image_url, *v4, 0x1::string::utf8(b".webp"), v0);
        arg0.model_url = format_new_url(v2.base_image_url, *v4, 0x1::string::utf8(b".glb"), v0);
        let v5 = 0x1::string::utf8(b"tier_name");
        *0x2::vec_map::get_mut<0x1::string::String, 0x1::string::String>(&mut arg0.attributes, &v5) = v2.name;
        let v6 = 0x1::string::utf8(b"color");
        *0x2::vec_map::get_mut<0x1::string::String, 0x1::string::String>(&mut arg0.attributes, &v6) = v2.color;
        let v7 = 0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_rewards::borrow_tier_reward(arg2, arg1, v0);
        let v8 = TierDvdRewards{
            gangsters      : 0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_rewards::borrow_gangsters_reward(v7),
            game_resources : 0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_rewards::borrow_game_resources_reward(v7),
            physical_items : 0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_rewards::borrow_physical_items_reward(v7),
            perks          : 0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_rewards::borrow_perks_reward(v7),
            hq_aesthetics  : 0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_rewards::borrow_hq_aesthetics_reward(v7),
            is_claimed     : false,
        };
        0x2::dynamic_field::add<u8, TierDvdRewards>(&mut arg0.id, v0, v8);
        let v9 = 0x2::dynamic_field::borrow_mut<0x1::string::String, u64>(&mut arg0.id, 0x1::string::utf8(b"spin_count"));
        *v9 = *v9 + (0x8eb9b79a821031294e6d4ab6ae1d0904a37b93f8d85da5bfc3666874d5feeceb::dvd_rewards::borrow_spin_count_reward(v7) as u64);
        let v10 = 0x1::string::utf8(b"edition");
        let v11 = 0x1::string::utf8(b"cover_art");
        let v12 = 0x1::string::utf8(b"texture");
        let v13 = UpgradeDvdEvent{
            nft_id     : 0x2::object::id<VendettaDVD>(arg0),
            name       : arg0.name,
            image_url  : arg0.image_url,
            price_paid : 0x2::coin::value<0x2::sui::SUI>(&arg4),
            owner      : 0x2::tx_context::sender(arg5),
            edition    : *0x2::vec_map::get<0x1::string::String, 0x1::string::String>(&arg0.attributes, &v10),
            texture    : *0x2::vec_map::get<0x1::string::String, 0x1::string::String>(&arg0.attributes, &v12),
            cover_art  : *0x2::vec_map::get<0x1::string::String, 0x1::string::String>(&arg0.attributes, &v11),
            tier       : arg0.tier,
        };
        0x2::event::emit<UpgradeDvdEvent>(v13);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg4, arg3.admin);
    }

    public fun validate_reward_claim(arg0: &VendettaDVD, arg1: u8) {
        assert!(!is_reward_claimed(arg0, arg1), 18);
    }

    public(friend) fun validate_spin_reward(arg0: &VendettaDVD) : bool {
        *0x2::dynamic_field::borrow<0x1::string::String, u64>(&arg0.id, 0x1::string::utf8(b"spin_count")) >= 1
    }

    // decompiled from Move bytecode v6
}

