module 0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::nft {
    struct NFT has drop {
        dummy_field: bool,
    }

    struct MintedByUser has drop, store {
        user_minted: bool,
    }

    struct City has key {
        id: 0x2::object::UID,
        index: u64,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        balance: 0x2::balance::Balance<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>,
        buildings: vector<u64>,
        last_claimed: u64,
        last_daily_bonus: u64,
        last_accumulated: u64,
        population: u64,
        use_check: vector<bool>,
        last_war: u64,
        extra_data: vector<u64>,
        extra_nested_data: vector<vector<u64>>,
        wallet: 0x2::object::ID,
    }

    struct Wallet has key {
        id: 0x2::object::UID,
        owner: address,
        balance: 0x2::balance::Balance<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>,
        ref_addresses: vector<address>,
        last_attacked: u64,
        last_attacker: address,
        last_steal: u64,
        extra_data: vector<u64>,
        extra_nested_data: vector<vector<u64>>,
    }

    struct GameData has key {
        id: 0x2::object::UID,
        version: u64,
        minted: u64,
        speed: u64,
        cost_multiplier: u64,
        base_name: 0x1::string::String,
        base_url: 0x1::string::String,
        base_image_url: 0x1::string::String,
        description: 0x1::string::String,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        pool: 0x2::balance::Balance<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>,
        secure_pool: 0x2::balance::Balance<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>,
        publisher: address,
        accumulation_speeds: vector<u64>,
        building_sui_costs: vector<vector<u64>>,
        building_sity_costs: vector<vector<u64>>,
        factory_bonuses: vector<u64>,
        minted_users: 0x2::table::Table<address, MintedByUser>,
        banned_users: 0x2::table::Table<address, bool>,
        public_key: vector<u8>,
        ref_reward: u64,
        extra_sui_costs: vector<u64>,
        extra_sity_costs: vector<u64>,
        bank_powers: vector<u64>,
        castle_powers: vector<u64>,
        castle_requirements: vector<u64>,
        extra_data: vector<u64>,
        extra_nested_data: vector<vector<u64>>,
        paused: bool,
        active_buildings: u64,
        nonces: 0x2::table::Table<address, u64>,
    }

    struct RefPool has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        ref_mappings: 0x2::table::Table<u64, 0x2::object::ID>,
        spin_weights: vector<u64>,
        initial_spin_weights: vector<u64>,
        sity_rewards: vector<u64>,
        sity_weights: vector<u64>,
        sui_rewards: vector<u64>,
        sui_weights: vector<u64>,
        daily_rewards: vector<u64>,
        extra_data: vector<u64>,
        extra_nested_data: vector<vector<u64>>,
    }

    struct SITYClaimed has copy, drop {
        nft_id: 0x2::object::ID,
        amount: u64,
        claimer: address,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    struct BonusClaimed has copy, drop {
        object_id: 0x2::object::ID,
        amount: u64,
    }

    struct RewardClaimed has copy, drop {
        claimer: address,
        amount: u64,
    }

    struct NFTUpgraded has copy, drop {
        object_id: 0x2::object::ID,
        building_type: u64,
        new_level: u64,
    }

    struct RefBonusClaimed has copy, drop {
        nft_id: 0x2::object::ID,
        claimer: address,
        ref_owner: address,
    }

    struct SingleplayerWarResult has copy, drop {
        nft_id: 0x2::object::ID,
        user: address,
        result: 0x1::string::String,
        reward: u64,
    }

    struct SpinOutcome has copy, drop {
        user: address,
        result: 0x1::string::String,
        reward: u64,
    }

    struct DailyRewardClaimed has copy, drop {
        user: address,
        day: u64,
        amount: u64,
    }

    struct SocialMediaReward has copy, drop {
        user: address,
        task: u64,
        reward: u64,
    }

    struct GiftSent has copy, drop {
        sender: address,
        recipient: address,
        amount: u64,
    }

    struct SityFlipResult has copy, drop {
        user: address,
        amount: u64,
        result: 0x1::string::String,
        reward: u64,
    }

    public fun url(arg0: &City) : &0x2::url::Url {
        &arg0.url
    }

    public entry fun accumulate_sity(arg0: &mut City, arg1: &mut GameData, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 2);
        assert!(!0x2::table::contains<address, bool>(&arg1.banned_users, 0x2::tx_context::sender(arg3)), 14);
        assert!(!arg1.paused, 12);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = calculate_max_accumulation(arg1, arg0);
        let v2 = if (v0 - arg0.last_claimed <= v1) {
            v0 - arg0.last_accumulated
        } else {
            let v3 = arg0.last_accumulated - arg0.last_claimed;
            if (v3 >= v1) {
                0
            } else if (v3 >= 0) {
                v1 - v3
            } else {
                v1
            }
        };
        0x2::balance::join<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(&mut arg0.balance, 0x2::coin::into_balance<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(0x2::coin::take<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(&mut arg1.pool, v2 * *0x1::vector::borrow<u64>(&arg1.accumulation_speeds, *0x1::vector::borrow<u64>(&arg0.buildings, 0)) * arg1.speed / 3600000, arg3)));
        arg0.last_accumulated = v0;
    }

    public entry fun accumulate_sity_updated(arg0: &mut City, arg1: &mut GameData, arg2: &Wallet, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 2);
        assert!(!0x2::table::contains<address, bool>(&arg1.banned_users, 0x2::tx_context::sender(arg4)), 14);
        assert!(!arg1.paused, 12);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = calculate_max_accumulation(arg1, arg0);
        let v2 = if (v0 - arg0.last_claimed <= v1) {
            v0 - arg0.last_accumulated
        } else {
            let v3 = arg0.last_accumulated - arg0.last_claimed;
            if (v3 >= v1) {
                0
            } else if (v3 >= 0) {
                v1 - v3
            } else {
                v1
            }
        };
        0x2::balance::join<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(&mut arg0.balance, 0x2::coin::into_balance<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(0x2::coin::take<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(&mut arg1.pool, v2 * *0x1::vector::borrow<u64>(&arg1.accumulation_speeds, *0x1::vector::borrow<u64>(&arg0.buildings, 0)) * arg1.speed / 3600000, arg4)));
        arg0.last_accumulated = v0;
        arg0.population = calculate_population_updated(arg0, arg2);
    }

    public fun add_spin_to_user(arg0: &mut GameData, arg1: &mut Wallet, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.publisher, 0);
        assert!(arg0.version == 1, 2);
        let v0 = 0x1::vector::borrow_mut<u64>(&mut arg1.extra_data, 0);
        *v0 = *v0 + arg2;
    }

    public fun add_sui_to_refpool(arg0: &mut RefPool, arg1: &GameData, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg1.publisher, 0);
        assert!(arg1.version == 1, 2);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) > 0, 4);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
    }

    public fun add_to_pool(arg0: &mut GameData, arg1: &mut 0x2::coin::TreasuryCap<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.publisher, 0);
        assert!(arg0.version == 1, 2);
        0x2::balance::join<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(&mut arg0.pool, 0x2::coin::into_balance<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::create(arg1, arg2, arg3)));
    }

    public entry fun admin_build_city(arg0: &mut GameData, arg1: 0x1::string::String, arg2: u64, arg3: 0x1::string::String, arg4: vector<u64>, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: address, arg11: u64, arg12: bool, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg13) == arg0.publisher, 0);
        assert!(arg0.version == 1, 2);
        let v0 = MintedByUser{user_minted: true};
        0x2::table::add<address, MintedByUser>(&mut arg0.minted_users, arg10, v0);
        if (0x2::table::contains<address, u64>(&arg0.nonces, arg10)) {
            *0x2::table::borrow_mut<address, u64>(&mut arg0.nonces, arg10) = 1;
        } else {
            0x2::table::add<address, u64>(&mut arg0.nonces, arg10, 1);
        };
        let v1 = 0x1::vector::empty<bool>();
        let v2 = &mut v1;
        0x1::vector::push_back<bool>(v2, arg12);
        0x1::vector::push_back<bool>(v2, false);
        0x1::vector::push_back<bool>(v2, false);
        0x1::vector::push_back<bool>(v2, false);
        0x1::vector::push_back<bool>(v2, false);
        0x1::vector::push_back<bool>(v2, false);
        0x1::vector::push_back<bool>(v2, false);
        0x1::vector::push_back<bool>(v2, false);
        let v3 = 0x2::balance::zero<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>();
        0x2::balance::join<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(&mut v3, 0x2::coin::into_balance<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(0x2::coin::take<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(&mut arg0.pool, arg9, arg13)));
        let v4 = 0x2::balance::zero<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>();
        0x2::balance::join<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(&mut v4, 0x2::coin::into_balance<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(0x2::coin::take<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(&mut arg0.pool, arg11, arg13)));
        let v5 = Wallet{
            id                : 0x2::object::new(arg13),
            owner             : arg10,
            balance           : v4,
            ref_addresses     : vector[],
            last_attacked     : 0,
            last_attacker     : arg10,
            last_steal        : 0,
            extra_data        : vector[0, 0, 0, 0, 0],
            extra_nested_data : vector[vector[0, 0, 0]],
        };
        let v6 = City{
            id                : 0x2::object::new(arg13),
            index             : arg2,
            name              : arg1,
            description       : arg3,
            url               : 0x2::url::new_unsafe_from_bytes(0x1::string::into_bytes(generate_image_url(arg4, arg0))),
            balance           : v3,
            buildings         : arg4,
            last_claimed      : arg5,
            last_daily_bonus  : arg6,
            last_accumulated  : arg7,
            population        : arg8,
            use_check         : v1,
            last_war          : 0,
            extra_data        : vector[0, 0, 0, 0, 0],
            extra_nested_data : vector[vector[0, 0, 0]],
            wallet            : 0x2::object::id<Wallet>(&v5),
        };
        let v7 = NFTMinted{
            object_id : 0x2::object::id<City>(&v6),
            creator   : arg10,
            name      : v6.name,
        };
        0x2::event::emit<NFTMinted>(v7);
        0x2::transfer::transfer<City>(v6, arg10);
        0x2::transfer::share_object<Wallet>(v5);
        arg0.minted = arg0.minted + 1;
    }

    public fun ban_user(arg0: &mut GameData, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.publisher, 0);
        assert!(arg0.version == 1, 2);
        0x2::table::add<address, bool>(&mut arg0.banned_users, arg1, true);
    }

    public entry fun build_city(arg0: &mut GameData, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(!0x2::table::contains<address, bool>(&arg0.banned_users, 0x2::tx_context::sender(arg2)), 14);
        assert!(!arg0.paused, 12);
        let v0 = 0x2::tx_context::sender(arg2);
        if (0x2::table::contains<address, u64>(&arg0.nonces, v0)) {
            *0x2::table::borrow_mut<address, u64>(&mut arg0.nonces, v0) = 1;
        } else {
            0x2::table::add<address, u64>(&mut arg0.nonces, v0, 0);
        };
        assert!(!0x2::table::contains<address, MintedByUser>(&arg0.minted_users, v0), 3);
        let v1 = arg0.base_name;
        0x1::string::append(&mut v1, 0x1::string::utf8(0x1::vector::singleton<u8>(32)));
        0x1::string::append(&mut v1, 0x1::string::utf8(0x1::vector::singleton<u8>(35)));
        0x1::string::append(&mut v1, u64_to_string(arg0.minted + 1));
        let v2 = arg0.base_image_url;
        0x1::string::append(&mut v2, 0x1::string::utf8(0x1::vector::singleton<u8>(48)));
        0x1::string::append(&mut v2, 0x1::string::utf8(0x1::vector::singleton<u8>(48)));
        0x1::string::append(&mut v2, 0x1::string::utf8(0x1::vector::singleton<u8>(48)));
        0x1::string::append(&mut v2, 0x1::string::utf8(0x1::vector::singleton<u8>(48)));
        0x1::string::append(&mut v2, 0x1::string::utf8(0x1::vector::singleton<u8>(48)));
        let v3 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v3, 46);
        0x1::vector::push_back<u8>(&mut v3, 119);
        0x1::vector::push_back<u8>(&mut v3, 101);
        0x1::vector::push_back<u8>(&mut v3, 98);
        0x1::vector::push_back<u8>(&mut v3, 112);
        0x1::string::append(&mut v2, 0x1::string::utf8(v3));
        let v4 = MintedByUser{user_minted: true};
        0x2::table::add<address, MintedByUser>(&mut arg0.minted_users, v0, v4);
        let v5 = Wallet{
            id                : 0x2::object::new(arg2),
            owner             : v0,
            balance           : 0x2::balance::zero<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(),
            ref_addresses     : vector[],
            last_attacked     : 0x2::clock::timestamp_ms(arg1) - 86400000,
            last_attacker     : v0,
            last_steal        : 0,
            extra_data        : vector[0, 0, 0, 0, 0],
            extra_nested_data : vector[vector[0, 0, 0]],
        };
        let v6 = City{
            id                : 0x2::object::new(arg2),
            index             : arg0.minted + 1,
            name              : v1,
            description       : arg0.description,
            url               : 0x2::url::new_unsafe_from_bytes(0x1::string::into_bytes(v2)),
            balance           : 0x2::balance::zero<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(),
            buildings         : vector[0, 0, 0, 0, 0, 0, 0, 0],
            last_claimed      : 0x2::clock::timestamp_ms(arg1),
            last_daily_bonus  : 0x2::clock::timestamp_ms(arg1) - 86400000,
            last_accumulated  : 0x2::clock::timestamp_ms(arg1),
            population        : 100000,
            use_check         : vector[false, false, false, false, false, false, false, false],
            last_war          : 0x2::clock::timestamp_ms(arg1),
            extra_data        : vector[0, 0, 0, 0, 0],
            extra_nested_data : vector[vector[0, 0, 0]],
            wallet            : 0x2::object::id<Wallet>(&v5),
        };
        0x2::transfer::share_object<Wallet>(v5);
        let v7 = NFTMinted{
            object_id : 0x2::object::id<City>(&v6),
            creator   : v0,
            name      : v6.name,
        };
        0x2::event::emit<NFTMinted>(v7);
        0x2::transfer::transfer<City>(v6, v0);
        arg0.minted = arg0.minted + 1;
    }

    public entry fun build_city_with_ref(arg0: &mut GameData, arg1: &mut Wallet, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(!arg0.paused, 12);
        assert!(!0x2::table::contains<address, bool>(&arg0.banned_users, 0x2::tx_context::sender(arg5)), 14);
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(0x2::ed25519::ed25519_verify(&arg2, &arg0.public_key, &arg3), 5);
        let (v1, v2) = split_on_delimiter(arg3, 58);
        let v3 = v1;
        let v4 = vector_subrange(&v3, 2, 66);
        assert!(v0 == 0x2::address::from_ascii_bytes(&v4), 16);
        let v5 = if (0x2::table::contains<address, u64>(&arg0.nonces, v0)) {
            *0x2::table::borrow<address, u64>(&arg0.nonces, v0)
        } else {
            0
        };
        assert!(vector_u8_to_u64(v2) == v5, 19);
        if (0x2::table::contains<address, u64>(&arg0.nonces, v0)) {
            *0x2::table::borrow_mut<address, u64>(&mut arg0.nonces, v0) = v5 + 1;
        } else {
            0x2::table::add<address, u64>(&mut arg0.nonces, v0, v5 + 1);
        };
        assert!(!0x2::table::contains<address, MintedByUser>(&arg0.minted_users, v0), 3);
        let v6 = arg0.base_name;
        0x1::string::append(&mut v6, 0x1::string::utf8(0x1::vector::singleton<u8>(32)));
        0x1::string::append(&mut v6, 0x1::string::utf8(0x1::vector::singleton<u8>(35)));
        0x1::string::append(&mut v6, u64_to_string(arg0.minted + 1));
        let v7 = arg0.base_image_url;
        0x1::string::append(&mut v7, 0x1::string::utf8(0x1::vector::singleton<u8>(48)));
        0x1::string::append(&mut v7, 0x1::string::utf8(0x1::vector::singleton<u8>(48)));
        0x1::string::append(&mut v7, 0x1::string::utf8(0x1::vector::singleton<u8>(48)));
        0x1::string::append(&mut v7, 0x1::string::utf8(0x1::vector::singleton<u8>(48)));
        0x1::string::append(&mut v7, 0x1::string::utf8(0x1::vector::singleton<u8>(48)));
        let v8 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v8, 46);
        0x1::vector::push_back<u8>(&mut v8, 119);
        0x1::vector::push_back<u8>(&mut v8, 101);
        0x1::vector::push_back<u8>(&mut v8, 98);
        0x1::vector::push_back<u8>(&mut v8, 112);
        0x1::string::append(&mut v7, 0x1::string::utf8(v8));
        let v9 = MintedByUser{user_minted: true};
        0x2::table::add<address, MintedByUser>(&mut arg0.minted_users, v0, v9);
        let v10 = Wallet{
            id                : 0x2::object::new(arg5),
            owner             : v0,
            balance           : 0x2::balance::zero<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(),
            ref_addresses     : vector[],
            last_attacked     : 0x2::clock::timestamp_ms(arg4) - 86400000,
            last_attacker     : v0,
            last_steal        : 0,
            extra_data        : vector[1, 0, 0, 0, 0],
            extra_nested_data : vector[vector[0, 0, 0]],
        };
        let v11 = City{
            id                : 0x2::object::new(arg5),
            index             : arg0.minted + 1,
            name              : v6,
            description       : arg0.description,
            url               : 0x2::url::new_unsafe_from_bytes(0x1::string::into_bytes(v7)),
            balance           : 0x2::balance::zero<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(),
            buildings         : vector[0, 0, 0, 0, 0, 0, 0, 0],
            last_claimed      : 0x2::clock::timestamp_ms(arg4),
            last_daily_bonus  : 0x2::clock::timestamp_ms(arg4) - 86400000,
            last_accumulated  : 0x2::clock::timestamp_ms(arg4),
            population        : 100000,
            use_check         : vector[false, false, false, false, false, false, false, false],
            last_war          : 0x2::clock::timestamp_ms(arg4) - 86400000,
            extra_data        : vector[0, 0, 0, 0, 0],
            extra_nested_data : vector[vector[0, 0, 0]],
            wallet            : 0x2::object::id<Wallet>(&v10),
        };
        let v12 = 0x1::vector::borrow_mut<u64>(&mut arg1.extra_data, 0);
        *v12 = *v12 + 1;
        0x1::vector::insert<address>(&mut arg1.ref_addresses, v0, 0);
        0x2::transfer::share_object<Wallet>(v10);
        let v13 = NFTMinted{
            object_id : 0x2::object::id<City>(&v11),
            creator   : v0,
            name      : v11.name,
        };
        0x2::event::emit<NFTMinted>(v13);
        0x2::transfer::transfer<City>(v11, v0);
        arg0.minted = arg0.minted + 1;
    }

    public entry fun burn(arg0: City, arg1: &mut 0x2::tx_context::TxContext) {
        let City {
            id                : v0,
            index             : _,
            name              : _,
            description       : _,
            url               : _,
            balance           : v5,
            buildings         : _,
            last_claimed      : _,
            last_daily_bonus  : _,
            last_accumulated  : _,
            population        : _,
            use_check         : _,
            last_war          : _,
            extra_data        : _,
            extra_nested_data : _,
            wallet            : _,
        } = arg0;
        0x2::balance::destroy_zero<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(v5);
        0x2::object::delete(v0);
    }

    fun calculate_factory_bonus(arg0: &City, arg1: &GameData) : u64 {
        0x2::balance::value<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(&arg0.balance) * *0x1::vector::borrow<u64>(&arg1.factory_bonuses, *0x1::vector::borrow<u64>(&arg0.buildings, 1)) / 100
    }

    fun calculate_max_accumulation(arg0: &GameData, arg1: &City) : u64 {
        let v0 = *0x1::vector::borrow<u64>(&arg1.buildings, 2) + *0x1::vector::borrow<u64>(&arg1.buildings, 3);
        if (v0 == 0) {
            return 10800000 / arg0.speed
        };
        if (v0 <= 7) {
            return (3 + v0) * 3600 * 1000 / arg0.speed
        };
        (10 + 2 * (v0 - 7)) * 3600 * 1000 / arg0.speed
    }

    public fun calculate_population(arg0: &City) : u64 {
        let v0 = 20000;
        let v1 = 0;
        while (v1 < *0x1::vector::borrow<u64>(&arg0.buildings, 0)) {
            let v2 = v0 * 18;
            v0 = v2 / 10;
            v1 = v1 + 1;
        };
        let v3 = 20000;
        let v4 = 0;
        while (v4 < *0x1::vector::borrow<u64>(&arg0.buildings, 1)) {
            let v5 = v3 * 18;
            v3 = v5 / 10;
            v4 = v4 + 1;
        };
        let v6 = 20000;
        let v7 = 0;
        while (v7 < *0x1::vector::borrow<u64>(&arg0.buildings, 2)) {
            let v8 = v6 * 18;
            v6 = v8 / 10;
            v7 = v7 + 1;
        };
        let v9 = 20000;
        let v10 = 0;
        while (v10 < *0x1::vector::borrow<u64>(&arg0.buildings, 3)) {
            let v11 = v9 * 18;
            v9 = v11 / 10;
            v10 = v10 + 1;
        };
        let v12 = 20000;
        let v13 = 0;
        while (v13 < *0x1::vector::borrow<u64>(&arg0.buildings, 4)) {
            let v14 = v12 * 18;
            v12 = v14 / 10;
            v13 = v13 + 1;
        };
        v0 + v3 + v6 + v9 + v12 + 0x2::balance::value<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(&arg0.balance)
    }

    public fun calculate_population_updated(arg0: &City, arg1: &Wallet) : u64 {
        let v0 = 20000;
        let v1 = 0;
        while (v1 < *0x1::vector::borrow<u64>(&arg0.buildings, 0)) {
            let v2 = v0 * 18;
            v0 = v2 / 10;
            v1 = v1 + 1;
        };
        let v3 = 20000;
        let v4 = 0;
        while (v4 < *0x1::vector::borrow<u64>(&arg0.buildings, 1)) {
            let v5 = v3 * 18;
            v3 = v5 / 10;
            v4 = v4 + 1;
        };
        let v6 = 20000;
        let v7 = 0;
        while (v7 < *0x1::vector::borrow<u64>(&arg0.buildings, 2)) {
            let v8 = v6 * 18;
            v6 = v8 / 10;
            v7 = v7 + 1;
        };
        let v9 = 20000;
        let v10 = 0;
        while (v10 < *0x1::vector::borrow<u64>(&arg0.buildings, 3)) {
            let v11 = v9 * 18;
            v9 = v11 / 10;
            v10 = v10 + 1;
        };
        let v12 = 20000;
        let v13 = 0;
        while (v13 < *0x1::vector::borrow<u64>(&arg0.buildings, 4)) {
            let v14 = v12 * 18;
            v12 = v14 / 10;
            v13 = v13 + 1;
        };
        v0 + v3 + v6 + v9 + v12 + (0x2::balance::value<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(&arg0.balance) + 0x2::balance::value<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(&arg1.balance)) / 1000
    }

    public entry fun change_name_with_sity(arg0: &mut City, arg1: &mut GameData, arg2: 0x2::coin::Coin<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::ed25519::ed25519_verify(&arg3, &arg1.public_key, &arg4), 5);
        assert!(!0x2::table::contains<address, bool>(&arg1.banned_users, 0x2::tx_context::sender(arg5)), 14);
        assert!(!arg1.paused, 12);
        assert!(arg1.version == 1, 2);
        let v0 = *0x1::vector::borrow<u64>(&arg1.extra_sity_costs, 0) * arg1.cost_multiplier;
        assert!(v0 != 0, 6);
        assert!(0x2::coin::value<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(&arg2) >= v0 / 100, 4);
        0x2::balance::join<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(&mut arg1.pool, 0x2::coin::into_balance<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(arg2));
        let (v1, v2) = split_on_delimiter(arg4, 58);
        let (v3, v4) = split_on_delimiter(v2, 58);
        let v5 = v3;
        let v6 = vector_subrange(&v5, 2, 0x1::vector::length<u8>(&v5));
        let v7 = 0x2::tx_context::sender(arg5);
        assert!(v7 == 0x2::address::from_ascii_bytes(&v6), 5);
        let v8 = 0x2::table::borrow<address, u64>(&arg1.nonces, v7);
        assert!(vector_u8_to_u64(v4) == *v8, 19);
        arg0.name = 0x1::string::utf8(v1);
        if (0x2::table::contains<address, u64>(&arg1.nonces, v7)) {
            *0x2::table::borrow_mut<address, u64>(&mut arg1.nonces, v7) = *v8 + 1;
        } else {
            0x2::table::add<address, u64>(&mut arg1.nonces, v7, *v8 + 1);
        };
    }

    public entry fun change_name_with_sity_updated(arg0: &mut City, arg1: &mut GameData, arg2: &mut Wallet, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::ed25519::ed25519_verify(&arg3, &arg1.public_key, &arg4), 5);
        assert!(!0x2::table::contains<address, bool>(&arg1.banned_users, 0x2::tx_context::sender(arg5)), 14);
        assert!(!arg1.paused, 12);
        assert!(arg1.version == 1, 2);
        let v0 = *0x1::vector::borrow<u64>(&arg1.extra_sity_costs, 0) * arg1.cost_multiplier;
        let v1 = v0 / 100;
        assert!(v0 != 0, 6);
        assert!(0x2::balance::value<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(&arg2.balance) >= v1, 4);
        0x2::balance::join<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(&mut arg1.pool, 0x2::coin::into_balance<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(0x2::coin::take<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(&mut arg2.balance, v1, arg5)));
        let (v2, v3) = split_on_delimiter(arg4, 58);
        let (v4, v5) = split_on_delimiter(v3, 58);
        let v6 = v4;
        let v7 = vector_subrange(&v6, 2, 0x1::vector::length<u8>(&v6));
        let v8 = 0x2::tx_context::sender(arg5);
        assert!(v8 == 0x2::address::from_ascii_bytes(&v7), 5);
        let v9 = 0x2::table::borrow<address, u64>(&arg1.nonces, v8);
        assert!(vector_u8_to_u64(v5) == *v9, 19);
        arg0.name = 0x1::string::utf8(v2);
        *0x1::vector::borrow_mut<u64>(&mut arg0.extra_data, 0) = *0x1::vector::borrow<u64>(&arg0.extra_data, 0) + 1;
        if (0x2::table::contains<address, u64>(&arg1.nonces, v8)) {
            *0x2::table::borrow_mut<address, u64>(&mut arg1.nonces, v8) = *v9 + 1;
        } else {
            0x2::table::add<address, u64>(&mut arg1.nonces, v8, *v9 + 1);
        };
    }

    public entry fun change_name_with_sui(arg0: &mut City, arg1: &mut GameData, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = *0x1::vector::borrow<u64>(&arg1.extra_sui_costs, 0) * arg1.cost_multiplier;
        assert!(v0 != 0, 6);
        assert!(arg1.version == 1, 2);
        assert!(!arg1.paused, 12);
        assert!(!0x2::table::contains<address, bool>(&arg1.banned_users, 0x2::tx_context::sender(arg4)), 14);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= v0 / 100, 4);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        arg0.name = arg3;
    }

    public entry fun claim_daily_reward(arg0: &mut GameData, arg1: &RefPool, arg2: &mut Wallet, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(!arg0.paused, 12);
        assert!(!0x2::table::contains<address, bool>(&arg0.banned_users, 0x2::tx_context::sender(arg4)), 14);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = v0 - *0x1::vector::borrow<u64>(&arg2.extra_data, 1);
        assert!(v1 >= 86400000 / arg0.speed, 8);
        assert!(*0x1::vector::borrow<u64>(&arg2.extra_data, 2) <= 7, 18);
        let v2 = if (*0x1::vector::borrow<u64>(&arg2.extra_data, 2) == 7 || v1 >= 172800000 / arg0.speed) {
            1
        } else {
            *0x1::vector::borrow<u64>(&arg2.extra_data, 2) + 1
        };
        let v3 = *0x1::vector::borrow<u64>(&arg1.daily_rewards, v2 - 1);
        0x2::balance::join<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(&mut arg2.balance, 0x2::coin::into_balance<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(0x2::coin::take<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(&mut arg0.pool, v3, arg4)));
        *0x1::vector::borrow_mut<u64>(&mut arg2.extra_data, 1) = v0;
        *0x1::vector::borrow_mut<u64>(&mut arg2.extra_data, 2) = v2;
        let v4 = DailyRewardClaimed{
            user   : 0x2::tx_context::sender(arg4),
            day    : v2,
            amount : v3,
        };
        0x2::event::emit<DailyRewardClaimed>(v4);
    }

    public entry fun claim_factory_bonus(arg0: &mut City, arg1: &mut GameData, arg2: &mut Wallet, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        accumulate_sity_updated(arg0, arg1, arg2, arg3, arg4);
        assert!(!0x2::table::contains<address, bool>(&arg1.banned_users, 0x2::tx_context::sender(arg4)), 14);
        assert!(!arg1.paused, 12);
        assert!(arg1.version == 1, 2);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 - arg0.last_daily_bonus >= 86400000 / arg1.speed, 8);
        let v1 = calculate_factory_bonus(arg0, arg1);
        arg0.last_daily_bonus = v0;
        0x2::balance::join<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(&mut arg2.balance, 0x2::coin::into_balance<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(0x2::coin::take<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(&mut arg1.pool, v1, arg4)));
        let v2 = BonusClaimed{
            object_id : 0x2::object::id<City>(arg0),
            amount    : v1,
        };
        0x2::event::emit<BonusClaimed>(v2);
    }

    public entry fun claim_reference(arg0: &mut GameData, arg1: &mut City, arg2: &mut Wallet, arg3: &mut Wallet, arg4: address, arg5: vector<u8>, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::table::contains<address, bool>(&arg0.banned_users, 0x2::tx_context::sender(arg7)), 14);
        assert!(*0x1::vector::borrow<u64>(&arg1.buildings, 0) + *0x1::vector::borrow<u64>(&arg1.buildings, 1) + *0x1::vector::borrow<u64>(&arg1.buildings, 2) + *0x1::vector::borrow<u64>(&arg1.buildings, 3) + *0x1::vector::borrow<u64>(&arg1.buildings, 4) + *0x1::vector::borrow<u64>(&arg1.buildings, 5) + *0x1::vector::borrow<u64>(&arg1.buildings, 6) + *0x1::vector::borrow<u64>(&arg1.buildings, 7) >= 3, 9);
        assert!(arg0.version == 1, 2);
        assert!(!arg0.paused, 12);
        assert!(!0x2::table::contains<address, bool>(&arg0.banned_users, 0x2::tx_context::sender(arg7)), 14);
        assert!(*0x1::vector::borrow<bool>(&arg1.use_check, 0) == false, 10);
        let v0 = 0x2::tx_context::sender(arg7);
        let (v1, v2) = split_on_delimiter(arg6, 58);
        let v3 = v1;
        let (v4, v5) = split_on_delimiter(v2, 58);
        let v6 = v4;
        let v7 = vector_subrange(&v3, 2, 66);
        let v8 = vector_subrange(&v6, 2, 66);
        let v9 = 0x2::address::from_ascii_bytes(&v7);
        let v10 = 0x2::address::from_ascii_bytes(&v8);
        let v11 = if (0x2::table::contains<address, u64>(&arg0.nonces, v0)) {
            *0x2::table::borrow<address, u64>(&arg0.nonces, v0)
        } else {
            0
        };
        assert!(vector_u8_to_u64(v5) == v11, 19);
        assert!(0x2::ed25519::ed25519_verify(&arg5, &arg0.public_key, &arg6), 5);
        assert!(v9 == v0, 5);
        assert!(v10 == arg4, 5);
        let v12 = arg0.ref_reward;
        assert!(0x2::balance::value<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(&arg0.pool) >= 2 * v12, 11);
        0x2::balance::join<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(&mut arg2.balance, 0x2::coin::into_balance<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(0x2::coin::take<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(&mut arg0.pool, v12, arg7)));
        0x2::balance::join<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(&mut arg3.balance, 0x2::coin::into_balance<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(0x2::coin::take<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(&mut arg0.pool, v12, arg7)));
        *0x1::vector::borrow_mut<bool>(&mut arg1.use_check, 0) = true;
        if (0x2::table::contains<address, u64>(&arg0.nonces, v0)) {
            *0x2::table::borrow_mut<address, u64>(&mut arg0.nonces, v0) = v11 + 1;
        } else {
            0x2::table::add<address, u64>(&mut arg0.nonces, v0, v11 + 1);
        };
        let v13 = RefBonusClaimed{
            nft_id    : 0x2::object::uid_to_inner(&arg1.id),
            claimer   : v9,
            ref_owner : v10,
        };
        0x2::event::emit<RefBonusClaimed>(v13);
    }

    public entry fun claim_reward(arg0: &mut GameData, arg1: &mut Wallet, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::ed25519::ed25519_verify(&arg2, &arg0.public_key, &arg3), 5);
        assert!(arg0.version == 1, 2);
        assert!(!arg0.paused, 12);
        assert!(!0x2::table::contains<address, bool>(&arg0.banned_users, 0x2::tx_context::sender(arg4)), 14);
        let (v0, v1) = split_on_delimiter(arg3, 58);
        let (v2, v3) = split_on_delimiter(v1, 58);
        let v4 = v2;
        let v5 = vector_u8_to_u64(v0);
        let v6 = vector_subrange(&v4, 2, 66);
        let v7 = 0x2::tx_context::sender(arg4);
        assert!(v7 == 0x2::address::from_ascii_bytes(&v6), 16);
        let v8 = if (0x2::table::contains<address, u64>(&arg0.nonces, v7)) {
            *0x2::table::borrow<address, u64>(&arg0.nonces, v7)
        } else {
            0
        };
        assert!(vector_u8_to_u64(v3) == v8, 19);
        assert!(0x2::balance::value<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(&arg0.pool) >= v5, 11);
        0x2::balance::join<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(&mut arg1.balance, 0x2::coin::into_balance<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(0x2::coin::take<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(&mut arg0.pool, v5, arg4)));
        if (0x2::table::contains<address, u64>(&arg0.nonces, v7)) {
            *0x2::table::borrow_mut<address, u64>(&mut arg0.nonces, v7) = v8 + 1;
        } else {
            0x2::table::add<address, u64>(&mut arg0.nonces, v7, v8 + 1);
        };
        let v9 = RewardClaimed{
            claimer : v7,
            amount  : v5,
        };
        0x2::event::emit<RewardClaimed>(v9);
    }

    public entry fun claim_sity(arg0: &mut City, arg1: &mut GameData, arg2: &mut Wallet, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        accumulate_sity_updated(arg0, arg1, arg2, arg3, arg4);
        assert!(!0x2::table::contains<address, bool>(&arg1.banned_users, 0x2::tx_context::sender(arg4)), 14);
        assert!(!arg1.paused, 12);
        assert!(arg1.version == 1, 2);
        let v0 = 0x2::balance::value<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(&arg0.balance);
        assert!(v0 > 0, 7);
        0x2::balance::join<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(&mut arg2.balance, 0x2::coin::into_balance<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(0x2::coin::take<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(&mut arg0.balance, v0, arg4)));
        let v1 = SITYClaimed{
            nft_id  : 0x2::object::uid_to_inner(&arg0.id),
            amount  : v0,
            claimer : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<SITYClaimed>(v1);
        arg0.last_claimed = 0x2::clock::timestamp_ms(arg3);
    }

    public fun count_letters_before_apostrophe(arg0: 0x1::string::String) : u64 {
        let v0 = 0x1::string::into_bytes(arg0);
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(&v0)) {
            if (*0x1::vector::borrow<u8>(&v0, v2) == 39) {
                return v1
            };
            v1 = v1 + 1;
            v2 = v2 + 1;
        };
        0
    }

    public fun create_pool(arg0: &mut GameData, arg1: &mut 0x2::coin::TreasuryCap<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.publisher, 0);
        assert!(0x2::tx_context::sender(arg2) == arg0.publisher, 0);
        0x2::balance::join<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(&mut arg0.pool, 0x2::coin::into_balance<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::create(arg1, 150000000000, arg2)));
    }

    public entry fun create_refpool(arg0: &GameData, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.publisher, 0);
        assert!(arg0.version == 1, 2);
        let v0 = RefPool{
            id                   : 0x2::object::new(arg1),
            balance              : 0x2::balance::zero<0x2::sui::SUI>(),
            ref_mappings         : 0x2::table::new<u64, 0x2::object::ID>(arg1),
            spin_weights         : vector[70, 20, 10],
            initial_spin_weights : vector[65, 40, 0],
            sity_rewards         : vector[1000000, 5000000, 50000000, 100000000],
            sity_weights         : vector[50, 35, 10, 5],
            sui_rewards          : vector[100000000, 500000000, 1000000000, 5000000000, 10000000000],
            sui_weights          : vector[900, 90, 7, 2, 1],
            daily_rewards        : vector[150000, 300000, 500000, 1000000, 2000000, 5000000, 10000000],
            extra_data           : vector[0, 0, 0],
            extra_nested_data    : vector[vector[0, 0, 0], vector[0, 0, 0]],
        };
        0x2::transfer::share_object<RefPool>(v0);
    }

    public fun description(arg0: &City) : &0x1::string::String {
        &arg0.description
    }

    public entry fun do_sity_payment(arg0: &mut GameData, arg1: &mut Wallet, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(!arg0.paused, 12);
        assert!(!0x2::table::contains<address, bool>(&arg0.banned_users, 0x2::tx_context::sender(arg3)), 14);
        assert!(0x2::balance::value<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(&arg1.balance) >= arg2, 4);
        0x2::balance::join<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(&mut arg0.pool, 0x2::coin::into_balance<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(0x2::coin::take<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(&mut arg1.balance, arg2, arg3)));
    }

    fun generate_image_url(arg0: vector<u64>, arg1: &GameData) : 0x1::string::String {
        let v0 = arg1.base_image_url;
        let v1 = 0;
        while (v1 < arg1.active_buildings) {
            0x1::string::append(&mut v0, u64_to_string(*0x1::vector::borrow<u64>(&arg0, v1)));
            v1 = v1 + 1;
        };
        let v2 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v2, 46);
        0x1::vector::push_back<u8>(&mut v2, 119);
        0x1::vector::push_back<u8>(&mut v2, 101);
        0x1::vector::push_back<u8>(&mut v2, 98);
        0x1::vector::push_back<u8>(&mut v2, 112);
        0x1::string::append(&mut v0, 0x1::string::utf8(v2));
        v0
    }

    public fun generate_reference(arg0: &mut RefPool, arg1: &City, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::table::contains<u64, 0x2::object::ID>(&arg0.ref_mappings, arg1.index), 3);
        0x2::table::add<u64, 0x2::object::ID>(&mut arg0.ref_mappings, arg1.index, arg1.wallet);
    }

    public fun get_nonce(arg0: &GameData, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.nonces, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.nonces, arg1)
        } else {
            0
        }
    }

    fun init(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = GameData{
            id                  : 0x2::object::new(arg1),
            version             : 1,
            minted              : 0,
            speed               : 1,
            cost_multiplier     : 100,
            base_name           : 0x1::string::utf8(b"SuiCity"),
            base_url            : 0x1::string::utf8(b"https://suicityp2e.com"),
            base_image_url      : 0x1::string::utf8(b"https://bafybeieyfgsnte6466mbxsbg2tizwrpuyxfe7beibsrcwp6pwtmsywyo7m.ipfs.w3s.link/"),
            description         : 0x1::string::utf8(x"467265654d696e7420796f7572205375694369747920616e64207374617274206275696c64696e672026206561726e696e6720796f757220245349545920f09f8f99efb88f20546865206669727374206f6e636861696e20506c61793241697264726f702067616d6520776869636820706f776572656420627920644e465473"),
            balance             : 0x2::balance::zero<0x2::sui::SUI>(),
            pool                : 0x2::balance::zero<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(),
            secure_pool         : 0x2::balance::zero<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(),
            publisher           : 0x2::tx_context::sender(arg1),
            accumulation_speeds : vector[100000, 180000, 310000, 550000, 960000, 1700000, 3000000, 5125000],
            building_sui_costs  : vector[vector[800000000, 0, 4000000000, 0, 20000000000, 0, 75000000000], vector[0, 0, 0, 9500000000, 0, 35000000000, 0], vector[800000000, 0, 4000000000, 0, 20000000000, 0, 75000000000], vector[0, 1800000000, 0, 9500000000, 0, 35000000000, 0], vector[1000000000, 2000000000, 4000000000, 800000000, 16000000000, 32000000000, 64000000000]],
            building_sity_costs : vector[vector[0, 620000, 0, 2900000, 0, 9400000, 0], vector[200000, 620000, 1400000, 0, 6200000, 0, 20000000], vector[0, 620000, 0, 2900000, 0, 9400000, 0], vector[200000, 0, 1400000, 0, 6200000, 0, 20000000], vector[5000000, 12500000, 32000000, 80000000, 200000000, 500000000, 1250000000]],
            factory_bonuses     : vector[30, 55, 80, 105, 130, 150, 170, 200],
            minted_users        : 0x2::table::new<address, MintedByUser>(arg1),
            banned_users        : 0x2::table::new<address, bool>(arg1),
            public_key          : x"5a567940437464ff7e491acb6dc17595ada001a1241fc34a3620f9df2382d2e2",
            ref_reward          : 2000000,
            extra_sui_costs     : vector[10000000000],
            extra_sity_costs    : vector[1000000],
            bank_powers         : vector[0, 0, 0, 0, 0, 0, 0, 0],
            castle_powers       : vector[10, 25, 62, 150, 375, 950, 2400, 6000],
            castle_requirements : vector[2, 4, 6, 8, 10, 12, 13, 14],
            extra_data          : vector[0, 0, 0, 0, 0, 0, 0, 0],
            extra_nested_data   : vector[vector[0, 0, 0, 0, 0, 0, 0, 0], vector[0, 0, 0, 0, 0, 0, 0, 0], vector[0, 0, 0, 0, 0, 0, 0, 0], vector[0, 0, 0, 0, 0, 0, 0, 0], vector[0, 0, 0, 0, 0, 0, 0, 0], vector[0, 0, 0, 0, 0, 0, 0, 0], vector[0, 0, 0, 0, 0, 0, 0, 0], vector[0, 0, 0, 0, 0, 0, 0, 0]],
            paused              : false,
            active_buildings    : 5,
            nonces              : 0x2::table::new<address, u64>(arg1),
        };
        0x2::transfer::share_object<GameData>(v0);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"creator"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(x"467265654d696e7420796f7572205375694369747920616e64207374617274206275696c64696e672026206561726e696e6720796f757220245349545920f09f8f99efb88f20546865206669727374206f6e636861696e20506c61793241697264726f702067616d6520776869636820706f776572656420627920644e465473"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://suicityp2e.com"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"zeedC"));
        let v5 = 0x2::package::claim<NFT>(arg0, arg1);
        let v6 = 0x2::display::new_with_fields<City>(&v5, v1, v3, arg1);
        0x2::display::update_version<City>(&mut v6);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<City>>(v6, 0x2::tx_context::sender(arg1));
    }

    entry fun migrate(arg0: &mut GameData, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.publisher, 0);
        assert!(arg0.version < 1, 1);
        arg0.version = 1;
    }

    public fun mint_sitizen_with_sity(arg0: &mut 0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sitizens::Sale, arg1: &0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sitizens::Collection, arg2: &0x2::transfer_policy::TransferPolicy<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sitizens::Sitizen>, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: &mut Wallet, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sitizens::mint_with_sity(arg0, arg1, arg2, arg3, arg4, 0x2::coin::take<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(&mut arg5.balance, arg6, arg9), arg7, arg8, arg9);
    }

    public fun modify_accumulation_speeds(arg0: &mut GameData, arg1: vector<u64>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(0x2::tx_context::sender(arg2) == arg0.publisher, 0);
        arg0.accumulation_speeds = arg1;
    }

    public fun modify_active_buildings(arg0: &mut GameData, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(0x2::tx_context::sender(arg2) == arg0.publisher, 0);
        arg0.active_buildings = arg1;
    }

    public fun modify_bank_powers(arg0: &mut GameData, arg1: vector<u64>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(0x2::tx_context::sender(arg2) == arg0.publisher, 0);
        arg0.bank_powers = arg1;
    }

    public fun modify_base_image_url(arg0: &mut GameData, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(0x2::tx_context::sender(arg2) == arg0.publisher, 0);
        arg0.base_image_url = arg1;
    }

    public fun modify_base_name(arg0: &mut GameData, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(0x2::tx_context::sender(arg2) == arg0.publisher, 0);
        arg0.base_name = arg1;
    }

    public fun modify_base_url(arg0: &mut GameData, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(0x2::tx_context::sender(arg2) == arg0.publisher, 0);
        arg0.base_url = arg1;
    }

    public entry fun modify_battle_rewards(arg0: &mut GameData, arg1: vector<u64>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.publisher, 0);
        assert!(arg0.version == 1, 2);
        *0x1::vector::borrow_mut<vector<u64>>(&mut arg0.extra_nested_data, 1) = arg1;
    }

    public entry fun modify_bot_powers(arg0: &mut GameData, arg1: vector<u64>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.publisher, 0);
        assert!(arg0.version == 1, 2);
        *0x1::vector::borrow_mut<vector<u64>>(&mut arg0.extra_nested_data, 0) = arg1;
    }

    public fun modify_building_sity_costs(arg0: &mut GameData, arg1: vector<vector<u64>>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(0x2::tx_context::sender(arg2) == arg0.publisher, 0);
        arg0.building_sity_costs = arg1;
    }

    public fun modify_building_sui_costs(arg0: &mut GameData, arg1: vector<vector<u64>>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(0x2::tx_context::sender(arg2) == arg0.publisher, 0);
        arg0.building_sui_costs = arg1;
    }

    public fun modify_castle_powers(arg0: &mut GameData, arg1: vector<u64>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(0x2::tx_context::sender(arg2) == arg0.publisher, 0);
        arg0.castle_powers = arg1;
    }

    public fun modify_castle_requirements(arg0: &mut GameData, arg1: vector<u64>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(0x2::tx_context::sender(arg2) == arg0.publisher, 0);
        arg0.castle_requirements = arg1;
    }

    public fun modify_cost_multiplier(arg0: &mut GameData, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(0x2::tx_context::sender(arg2) == arg0.publisher, 0);
        arg0.cost_multiplier = arg1;
    }

    public entry fun modify_daily_rewards(arg0: &mut RefPool, arg1: &GameData, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg1.publisher, 0);
        assert!(arg1.version == 1, 2);
        arg0.daily_rewards = arg2;
    }

    public fun modify_description(arg0: &mut GameData, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(0x2::tx_context::sender(arg2) == arg0.publisher, 0);
        arg0.description = arg1;
    }

    public fun modify_extra_data(arg0: &mut GameData, arg1: vector<u64>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(0x2::tx_context::sender(arg2) == arg0.publisher, 0);
        arg0.extra_data = arg1;
    }

    public fun modify_extra_nested_data(arg0: &mut GameData, arg1: vector<vector<u64>>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(0x2::tx_context::sender(arg2) == arg0.publisher, 0);
        arg0.extra_nested_data = arg1;
    }

    public fun modify_extra_sity_costs(arg0: &mut GameData, arg1: vector<u64>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(0x2::tx_context::sender(arg2) == arg0.publisher, 0);
        arg0.extra_sity_costs = arg1;
    }

    public fun modify_extra_sui_costs(arg0: &mut GameData, arg1: vector<u64>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(0x2::tx_context::sender(arg2) == arg0.publisher, 0);
        arg0.extra_sui_costs = arg1;
    }

    public fun modify_factory_bonuses(arg0: &mut GameData, arg1: vector<u64>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(0x2::tx_context::sender(arg2) == arg0.publisher, 0);
        arg0.factory_bonuses = arg1;
    }

    public entry fun modify_initial_spin_weights(arg0: &mut RefPool, arg1: &GameData, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg1.publisher, 0);
        assert!(arg1.version == 1, 2);
        arg0.initial_spin_weights = arg2;
    }

    public fun modify_paused(arg0: &mut GameData, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(0x2::tx_context::sender(arg2) == arg0.publisher, 0);
        arg0.paused = arg1;
    }

    public fun modify_public_key(arg0: &mut GameData, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(0x2::tx_context::sender(arg2) == arg0.publisher, 0);
        arg0.public_key = arg1;
    }

    public fun modify_publisher(arg0: &mut GameData, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(0x2::tx_context::sender(arg2) == arg0.publisher, 0);
        arg0.publisher = arg1;
    }

    public fun modify_ref_reward(arg0: &mut GameData, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(0x2::tx_context::sender(arg2) == arg0.publisher, 0);
        arg0.ref_reward = arg1;
    }

    public entry fun modify_refpool_extra_data(arg0: &mut RefPool, arg1: &GameData, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg1.publisher, 0);
        assert!(arg1.version == 1, 2);
        arg0.extra_data = arg2;
    }

    public entry fun modify_refpool_extra_nested_data(arg0: &mut RefPool, arg1: &GameData, arg2: vector<vector<u64>>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg1.publisher, 0);
        assert!(arg1.version == 1, 2);
        arg0.extra_nested_data = arg2;
    }

    public entry fun modify_sity_flip_amounts(arg0: &mut GameData, arg1: vector<u64>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.publisher, 0);
        assert!(arg0.version == 1, 2);
        if (0x1::vector::length<vector<u64>>(&arg0.extra_nested_data) < 3) {
            0x1::vector::push_back<vector<u64>>(&mut arg0.extra_nested_data, arg1);
        } else {
            *0x1::vector::borrow_mut<vector<u64>>(&mut arg0.extra_nested_data, 2) = arg1;
        };
    }

    public entry fun modify_sity_rewards(arg0: &mut RefPool, arg1: &GameData, arg2: vector<u64>, arg3: vector<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg1.publisher, 0);
        assert!(arg1.version == 1, 2);
        arg0.sity_rewards = arg2;
        arg0.sity_weights = arg3;
    }

    public fun modify_speed(arg0: &mut GameData, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(0x2::tx_context::sender(arg2) == arg0.publisher, 0);
        arg0.speed = arg1;
    }

    public entry fun modify_spin_weights(arg0: &mut RefPool, arg1: &GameData, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg1.publisher, 0);
        assert!(arg1.version == 1, 2);
        arg0.spin_weights = arg2;
    }

    public entry fun modify_sui_rewards(arg0: &mut RefPool, arg1: &GameData, arg2: vector<u64>, arg3: vector<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg1.publisher, 0);
        assert!(arg1.version == 1, 2);
        arg0.sui_rewards = arg2;
        arg0.sui_weights = arg3;
    }

    public fun name(arg0: &City) : &0x1::string::String {
        &arg0.name
    }

    public entry fun refresh_image_url(arg0: &mut City, arg1: &GameData, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 2);
        assert!(!arg1.paused, 12);
        assert!(!0x2::table::contains<address, bool>(&arg1.banned_users, 0x2::tx_context::sender(arg2)), 14);
        arg0.url = 0x2::url::new_unsafe_from_bytes(0x1::string::into_bytes(generate_image_url(arg0.buildings, arg1)));
    }

    public fun reward_user(arg0: &mut GameData, arg1: &mut Wallet, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.publisher, 0);
        assert!(arg0.version == 1, 2);
        0x2::balance::join<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(&mut arg1.balance, 0x2::coin::into_balance<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(0x2::coin::take<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(&mut arg0.pool, arg2, arg3)));
    }

    fun select_spin_option(arg0: &vector<u64>, arg1: u64) : u64 {
        let v0 = 0;
        let v1 = 0x1::vector::length<u64>(arg0);
        let v2 = 0;
        while (v2 < v1) {
            let v3 = v0 + *0x1::vector::borrow<u64>(arg0, v2);
            v0 = v3;
            if (arg1 < v3) {
                return v2
            };
            v2 = v2 + 1;
        };
        assert!(v1 > 0, 18);
        v1 - 1
    }

    public entry fun send_gift(arg0: &mut City, arg1: &mut GameData, arg2: &mut Wallet, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 2);
        assert!(!arg1.paused, 12);
        assert!(!0x2::table::contains<address, bool>(&arg1.banned_users, 0x2::tx_context::sender(arg5)), 14);
        assert!(arg3 <= 100000000, 25);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(v0 - *0x1::vector::borrow<u64>(&arg0.extra_data, 1) >= 86400000 / arg1.speed, 24);
        assert!(0x2::balance::value<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(&arg1.pool) >= arg3, 11);
        0x2::balance::join<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(&mut arg2.balance, 0x2::coin::into_balance<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(0x2::coin::take<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(&mut arg1.pool, arg3, arg5)));
        *0x1::vector::borrow_mut<u64>(&mut arg0.extra_data, 1) = v0;
        let v1 = GiftSent{
            sender    : 0x2::tx_context::sender(arg5),
            recipient : arg2.owner,
            amount    : arg3,
        };
        0x2::event::emit<GiftSent>(v1);
    }

    entry fun simulate_singleplayer_war(arg0: &0x2::random::Random, arg1: &mut City, arg2: &0x2::clock::Clock, arg3: &mut GameData, arg4: &mut Wallet, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg3.version == 1, 2);
        assert!(arg3.paused == false, 12);
        assert!(!0x2::table::contains<address, bool>(&arg3.banned_users, 0x2::tx_context::sender(arg6)), 14);
        assert!(0x1::vector::contains<u64>(0x1::vector::borrow<vector<u64>>(&arg3.extra_nested_data, 0), &arg5), 21);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 - arg1.last_war >= *0x1::vector::borrow<u64>(&arg3.extra_data, 0) * 3600 * 1000 / arg3.speed, 8);
        let v1 = *0x1::vector::borrow<u64>(&arg3.castle_powers, *0x1::vector::borrow<u64>(&arg1.buildings, 4));
        let v2 = 0x2::random::new_generator(arg0, arg6);
        arg1.last_war = v0;
        if (0x2::random::generate_u64_in_range(&mut v2, 0, v1 + arg5) <= v1) {
            let (_, v4) = 0x1::vector::index_of<u64>(0x1::vector::borrow<vector<u64>>(&arg3.extra_nested_data, 0), &arg5);
            let v5 = *0x1::vector::borrow<u64>(0x1::vector::borrow<vector<u64>>(&arg3.extra_nested_data, 1), v4);
            0x2::balance::join<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(&mut arg4.balance, 0x2::coin::into_balance<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(0x2::coin::take<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(&mut arg3.pool, v5, arg6)));
            let v6 = SingleplayerWarResult{
                nft_id : 0x2::object::uid_to_inner(&arg1.id),
                user   : 0x2::tx_context::sender(arg6),
                result : 0x1::string::utf8(b"Win"),
                reward : v5,
            };
            0x2::event::emit<SingleplayerWarResult>(v6);
        } else {
            let v7 = SingleplayerWarResult{
                nft_id : 0x2::object::uid_to_inner(&arg1.id),
                user   : 0x2::tx_context::sender(arg6),
                result : 0x1::string::utf8(b"Lose"),
                reward : 0,
            };
            0x2::event::emit<SingleplayerWarResult>(v7);
        };
    }

    entry fun simulate_singleplayer_war_with_sui(arg0: &0x2::random::Random, arg1: &mut City, arg2: &0x2::clock::Clock, arg3: &mut GameData, arg4: &mut Wallet, arg5: u64, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg3.version == 1, 2);
        assert!(arg3.paused == false, 12);
        assert!(!0x2::table::contains<address, bool>(&arg3.banned_users, 0x2::tx_context::sender(arg7)), 14);
        assert!(0x1::vector::contains<u64>(0x1::vector::borrow<vector<u64>>(&arg3.extra_nested_data, 0), &arg5), 21);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 - arg1.last_war >= *0x1::vector::borrow<u64>(&arg3.extra_data, 0) * 3600 * 1000 / arg3.speed, 8);
        let v1 = *0x1::vector::borrow<u64>(&arg3.castle_powers, *0x1::vector::borrow<u64>(&arg1.buildings, 4)) * *0x1::vector::borrow<u64>(&arg3.extra_data, 1) / 100;
        let v2 = 0x2::random::new_generator(arg0, arg7);
        arg1.last_war = v0;
        let v3 = *0x1::vector::borrow<u64>(&arg3.extra_sui_costs, 1) * arg3.cost_multiplier;
        assert!(v3 != 0, 6);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg6) >= v3 / 100, 4);
        0x2::balance::join<0x2::sui::SUI>(&mut arg3.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg6));
        if (0x2::random::generate_u64_in_range(&mut v2, 0, v1 + arg5) <= v1) {
            let (_, v5) = 0x1::vector::index_of<u64>(0x1::vector::borrow<vector<u64>>(&arg3.extra_nested_data, 0), &arg5);
            let v6 = *0x1::vector::borrow<u64>(0x1::vector::borrow<vector<u64>>(&arg3.extra_nested_data, 1), v5);
            0x2::balance::join<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(&mut arg4.balance, 0x2::coin::into_balance<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(0x2::coin::take<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(&mut arg3.pool, v6, arg7)));
            let v7 = SingleplayerWarResult{
                nft_id : 0x2::object::uid_to_inner(&arg1.id),
                user   : 0x2::tx_context::sender(arg7),
                result : 0x1::string::utf8(b"Win"),
                reward : v6,
            };
            0x2::event::emit<SingleplayerWarResult>(v7);
        } else {
            let v8 = SingleplayerWarResult{
                nft_id : 0x2::object::uid_to_inner(&arg1.id),
                user   : 0x2::tx_context::sender(arg7),
                result : 0x1::string::utf8(b"Lose"),
                reward : 0,
            };
            0x2::event::emit<SingleplayerWarResult>(v8);
        };
    }

    entry fun sity_flip(arg0: &0x2::random::Random, arg1: &mut GameData, arg2: &mut Wallet, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 2);
        assert!(!arg1.paused, 12);
        assert!(!0x2::table::contains<address, bool>(&arg1.banned_users, 0x2::tx_context::sender(arg4)), 14);
        let v0 = 0x1::vector::borrow<vector<u64>>(&arg1.extra_nested_data, 2);
        assert!(arg3 < 0x1::vector::length<u64>(v0), 18);
        let v1 = *0x1::vector::borrow<u64>(v0, arg3);
        assert!(0x2::balance::value<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(&arg2.balance) >= v1, 4);
        assert!(0x2::balance::value<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(&arg1.pool) >= v1, 11);
        0x2::balance::join<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(&mut arg1.pool, 0x2::coin::into_balance<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(0x2::coin::take<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(&mut arg2.balance, v1, arg4)));
        let v2 = 0x2::random::new_generator(arg0, arg4);
        if (0x2::random::generate_u64_in_range(&mut v2, 0, 1) == 1) {
            let v3 = v1 * 2;
            0x2::balance::join<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(&mut arg2.balance, 0x2::coin::into_balance<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(0x2::coin::take<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(&mut arg1.pool, v3, arg4)));
            let v4 = SityFlipResult{
                user   : 0x2::tx_context::sender(arg4),
                amount : v1,
                result : 0x1::string::utf8(b"Win"),
                reward : v3,
            };
            0x2::event::emit<SityFlipResult>(v4);
        } else {
            let v5 = SityFlipResult{
                user   : 0x2::tx_context::sender(arg4),
                amount : v1,
                result : 0x1::string::utf8(b"Lose"),
                reward : 0,
            };
            0x2::event::emit<SityFlipResult>(v5);
        };
    }

    public entry fun social_task(arg0: &mut City, arg1: &mut GameData, arg2: &mut Wallet, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::ed25519::ed25519_verify(&arg3, &arg1.public_key, &arg4), 5);
        assert!(arg1.version == 1, 2);
        assert!(!arg1.paused, 12);
        assert!(!0x2::table::contains<address, bool>(&arg1.banned_users, 0x2::tx_context::sender(arg5)), 14);
        let (v0, v1) = split_on_delimiter(arg4, 58);
        let (v2, v3) = split_on_delimiter(v1, 58);
        let v4 = v2;
        let (v5, v6) = split_on_delimiter(v3, 58);
        let v7 = vector_u8_to_u64(v0);
        let v8 = vector_u8_to_u64(v6);
        while (0x1::vector::length<u64>(0x1::vector::borrow<vector<u64>>(&arg0.extra_nested_data, 0)) <= v8) {
            0x1::vector::push_back<u64>(0x1::vector::borrow_mut<vector<u64>>(&mut arg0.extra_nested_data, 0), 0);
        };
        assert!(*0x1::vector::borrow<u64>(0x1::vector::borrow<vector<u64>>(&arg0.extra_nested_data, 0), v8) == 0, 22);
        let v9 = vector_subrange(&v4, 2, 66);
        let v10 = 0x2::tx_context::sender(arg5);
        assert!(v10 == 0x2::address::from_ascii_bytes(&v9), 16);
        let v11 = if (0x2::table::contains<address, u64>(&arg1.nonces, v10)) {
            *0x2::table::borrow<address, u64>(&arg1.nonces, v10)
        } else {
            0
        };
        assert!(vector_u8_to_u64(v5) == v11, 19);
        assert!(0x2::balance::value<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(&arg1.pool) >= v7, 11);
        0x2::balance::join<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(&mut arg2.balance, 0x2::coin::into_balance<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(0x2::coin::take<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(&mut arg1.pool, v7, arg5)));
        if (0x2::table::contains<address, u64>(&arg1.nonces, v10)) {
            *0x2::table::borrow_mut<address, u64>(&mut arg1.nonces, v10) = v11 + 1;
        } else {
            0x2::table::add<address, u64>(&mut arg1.nonces, v10, v11 + 1);
        };
        *0x1::vector::borrow_mut<u64>(0x1::vector::borrow_mut<vector<u64>>(&mut arg0.extra_nested_data, 0), v8) = 1;
        let v12 = SocialMediaReward{
            user   : v10,
            task   : v8,
            reward : v7,
        };
        0x2::event::emit<SocialMediaReward>(v12);
    }

    entry fun spin_wheel(arg0: &mut RefPool, arg1: &mut Wallet, arg2: &mut GameData, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.version == 1, 2);
        assert!(!arg2.paused, 12);
        assert!(!0x2::table::contains<address, bool>(&arg2.banned_users, 0x2::tx_context::sender(arg4)), 14);
        assert!(*0x1::vector::borrow<u64>(&arg1.extra_data, 0) > 0, 23);
        let v0 = 0x2::random::new_generator(arg3, arg4);
        let v1 = if (*0x1::vector::borrow<u64>(&arg1.extra_data, 3) < 3) {
            select_spin_option(&arg0.initial_spin_weights, 0x2::random::generate_u64_in_range(&mut v0, 0, vector_sum(&arg0.initial_spin_weights)))
        } else {
            select_spin_option(&arg0.spin_weights, 0x2::random::generate_u64_in_range(&mut v0, 0, vector_sum(&arg0.spin_weights)))
        };
        if (v1 == 0) {
            let v2 = *0x1::vector::borrow<u64>(&arg0.sity_rewards, select_spin_option(&arg0.sity_weights, 0x2::random::generate_u64_in_range(&mut v0, 0, vector_sum(&arg0.sity_weights))));
            0x2::balance::join<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(&mut arg1.balance, 0x2::coin::into_balance<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(0x2::coin::take<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(&mut arg2.pool, v2, arg4)));
            let v3 = SpinOutcome{
                user   : 0x2::tx_context::sender(arg4),
                result : 0x1::string::utf8(b"SITY Reward"),
                reward : v2,
            };
            0x2::event::emit<SpinOutcome>(v3);
        } else if (v1 == 1) {
            let v4 = *0x1::vector::borrow<u64>(&arg0.sui_rewards, select_spin_option(&arg0.sui_weights, 0x2::random::generate_u64_in_range(&mut v0, 0, vector_sum(&arg0.sui_weights))));
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, v4, arg4), 0x2::tx_context::sender(arg4));
            let v5 = SpinOutcome{
                user   : 0x2::tx_context::sender(arg4),
                result : 0x1::string::utf8(b"SUI Reward"),
                reward : v4,
            };
            0x2::event::emit<SpinOutcome>(v5);
        } else {
            let v6 = SpinOutcome{
                user   : 0x2::tx_context::sender(arg4),
                result : 0x1::string::utf8(b"No Reward"),
                reward : 0,
            };
            0x2::event::emit<SpinOutcome>(v6);
        };
        let v7 = 0x1::vector::borrow_mut<u64>(&mut arg1.extra_data, 0);
        *v7 = *v7 - 1;
        let v8 = 0x1::vector::borrow_mut<u64>(&mut arg1.extra_data, 3);
        *v8 = *v8 + 1;
        let v9 = 0x1::vector::borrow_mut<u64>(&mut arg0.extra_data, 0);
        *v9 = *v9 + 1;
    }

    public fun split_on_delimiter(arg0: vector<u8>, arg1: u8) : (vector<u8>, vector<u8>) {
        let v0 = 0x1::vector::length<u8>(&arg0);
        let v1 = v0;
        let v2 = 0;
        while (v2 < v0) {
            if (*0x1::vector::borrow<u8>(&arg0, v2) == arg1) {
                v1 = v2;
                break
            };
            v2 = v2 + 1;
        };
        if (v1 == v0) {
            return (arg0, 0x1::vector::empty<u8>())
        };
        let v3 = 0x1::vector::empty<u8>();
        let v4 = 0;
        while (v4 < v1) {
            0x1::vector::push_back<u8>(&mut v3, *0x1::vector::borrow<u8>(&arg0, v4));
            v4 = v4 + 1;
        };
        let v5 = 0x1::vector::empty<u8>();
        let v6 = v1 + 1;
        while (v6 < v0) {
            0x1::vector::push_back<u8>(&mut v5, *0x1::vector::borrow<u8>(&arg0, v6));
            v6 = v6 + 1;
        };
        (v3, v5)
    }

    fun u64_to_string(arg0: u64) : 0x1::string::String {
        let v0 = 0x1::vector::empty<u8>();
        if (arg0 == 0) {
            0x1::vector::push_back<u8>(&mut v0, 48);
        } else {
            while (arg0 > 0) {
                0x1::vector::push_back<u8>(&mut v0, ((arg0 % 10) as u8) + 48);
                arg0 = arg0 / 10;
            };
            0x1::vector::reverse<u8>(&mut v0);
        };
        0x1::string::utf8(v0)
    }

    public fun unban_user(arg0: &mut GameData, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.publisher, 0);
        assert!(arg0.version == 1, 2);
        0x2::table::remove<address, bool>(&mut arg0.banned_users, arg1);
    }

    public fun upgrade_building_with_sity(arg0: &mut City, arg1: &mut GameData, arg2: &mut Wallet, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        accumulate_sity_updated(arg0, arg1, arg2, arg4, arg5);
        assert!(arg1.version == 1, 2);
        assert!(!arg1.paused, 12);
        assert!(!0x2::table::contains<address, bool>(&arg1.banned_users, 0x2::tx_context::sender(arg5)), 14);
        let v0 = *0x1::vector::borrow<u64>(&arg0.buildings, arg3);
        assert!(arg3 < arg1.active_buildings, 17);
        if (arg3 == 4) {
            assert!(*0x1::vector::borrow<u64>(&arg0.buildings, 0) + *0x1::vector::borrow<u64>(&arg0.buildings, 1) + *0x1::vector::borrow<u64>(&arg0.buildings, 2) + *0x1::vector::borrow<u64>(&arg0.buildings, 3) + *0x1::vector::borrow<u64>(&arg0.buildings, 5) + *0x1::vector::borrow<u64>(&arg0.buildings, 6) + *0x1::vector::borrow<u64>(&arg0.buildings, 7) >= *0x1::vector::borrow<u64>(&arg1.castle_requirements, v0), 20);
        };
        let v1 = *0x1::vector::borrow<u64>(0x1::vector::borrow<vector<u64>>(&arg1.building_sity_costs, arg3), v0) * arg1.cost_multiplier;
        assert!(v1 != 0, 6);
        let v2 = v1 / 100;
        assert!(0x2::balance::value<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(&arg2.balance) >= v2, 4);
        0x2::balance::join<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(&mut arg1.pool, 0x2::coin::into_balance<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(0x2::coin::take<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(&mut arg2.balance, v2, arg5)));
        *0x1::vector::borrow_mut<u64>(&mut arg0.buildings, (arg3 as u64)) = v0 + 1;
        arg0.population = calculate_population(arg0);
        arg0.url = 0x2::url::new_unsafe_from_bytes(0x1::string::into_bytes(generate_image_url(arg0.buildings, arg1)));
        let v3 = NFTUpgraded{
            object_id     : 0x2::object::uid_to_inner(&arg0.id),
            building_type : arg3,
            new_level     : v0 + 1,
        };
        0x2::event::emit<NFTUpgraded>(v3);
    }

    public fun upgrade_building_with_sui(arg0: &mut City, arg1: &mut GameData, arg2: u64, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 2);
        assert!(!arg1.paused, 12);
        assert!(!0x2::table::contains<address, bool>(&arg1.banned_users, 0x2::tx_context::sender(arg5)), 14);
        let v0 = *0x1::vector::borrow<u64>(&arg0.buildings, arg2);
        assert!(arg2 < arg1.active_buildings, 17);
        if (arg2 == 4) {
            assert!(*0x1::vector::borrow<u64>(&arg0.buildings, 0) + *0x1::vector::borrow<u64>(&arg0.buildings, 1) + *0x1::vector::borrow<u64>(&arg0.buildings, 2) + *0x1::vector::borrow<u64>(&arg0.buildings, 3) + *0x1::vector::borrow<u64>(&arg0.buildings, 5) + *0x1::vector::borrow<u64>(&arg0.buildings, 6) + *0x1::vector::borrow<u64>(&arg0.buildings, 7) >= *0x1::vector::borrow<u64>(&arg1.castle_requirements, v0), 20);
        };
        let v1 = *0x1::vector::borrow<u64>(0x1::vector::borrow<vector<u64>>(&arg1.building_sui_costs, arg2), v0) * arg1.cost_multiplier;
        assert!(v1 != 0, 6);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= v1 / 100, 4);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg3));
        *0x1::vector::borrow_mut<u64>(&mut arg0.buildings, (arg2 as u64)) = v0 + 1;
        arg0.population = calculate_population(arg0);
        arg0.url = 0x2::url::new_unsafe_from_bytes(0x1::string::into_bytes(generate_image_url(arg0.buildings, arg1)));
        let v2 = NFTUpgraded{
            object_id     : 0x2::object::uid_to_inner(&arg0.id),
            building_type : arg2,
            new_level     : v0 + 1,
        };
        0x2::event::emit<NFTUpgraded>(v2);
    }

    fun vector_subrange(arg0: &vector<u8>, arg1: u64, arg2: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0x1::vector::length<u8>(arg0);
        assert!(arg1 <= v1, 18);
        assert!(arg2 <= v1, 18);
        assert!(arg1 <= arg2, 18);
        while (arg1 < arg2) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, arg1));
            arg1 = arg1 + 1;
        };
        v0
    }

    fun vector_sum(arg0: &vector<u64>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(arg0)) {
            v0 = v0 + *0x1::vector::borrow<u64>(arg0, v1);
            v1 = v1 + 1;
        };
        v0
    }

    fun vector_u8_to_u64(arg0: vector<u8>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(&arg0)) {
            let v2 = *0x1::vector::borrow<u8>(&arg0, v1);
            if (v2 >= 48 && v2 <= 57) {
                let v3 = v0 * 10;
                v0 = v3 + ((v2 - 48) as u64);
            };
            v1 = v1 + 1;
        };
        v0
    }

    public entry fun withdraw_custom_funds(arg0: &mut GameData, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.publisher, 0);
        assert!(arg0.version == 1, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun withdraw_from_pool(arg0: &mut GameData, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.publisher, 0);
        assert!(arg0.version == 1, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>>(0x2::coin::take<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(&mut arg0.pool, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public fun withdraw_from_user(arg0: &mut GameData, arg1: &mut Wallet, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.publisher, 0);
        assert!(arg0.version == 1, 2);
        0x2::balance::join<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(&mut arg0.pool, 0x2::coin::into_balance<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(0x2::coin::take<0xa926d72fc948d2df6c3468159be532a619f8b5dfc93a426fed89e493fc07a4d6::sity::SITY>(&mut arg1.balance, arg2, arg3)));
    }

    public entry fun withdraw_funds(arg0: &mut GameData, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.publisher, 0);
        assert!(arg0.version == 1, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, 0x2::balance::value<0x2::sui::SUI>(&arg0.balance), arg1), 0x2::tx_context::sender(arg1));
    }

    public fun withdraw_sui_from_refpool(arg0: &mut RefPool, arg1: &GameData, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg1.publisher, 0);
        assert!(arg1.version == 1, 2);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.balance) >= arg2, 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

