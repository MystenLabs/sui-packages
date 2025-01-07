module 0x6cc3c2b9f33461479ec785c5f6ea759e0f118a96bde35cc15325c7b853e7fe66::nft {
    struct NFT has drop {
        dummy_field: bool,
    }

    struct City has key {
        id: 0x2::object::UID,
        index: u64,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        balance: 0x2::balance::Balance<0x6cc3c2b9f33461479ec785c5f6ea759e0f118a96bde35cc15325c7b853e7fe66::sity::SITY>,
        buildings: vector<u64>,
        last_claimed: u64,
        last_daily_bonus: u64,
        last_accumulated: u64,
        population: u64,
        ref_used: bool,
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
        pool: 0x2::balance::Balance<0x6cc3c2b9f33461479ec785c5f6ea759e0f118a96bde35cc15325c7b853e7fe66::sity::SITY>,
        publisher: address,
        accumulation_speeds: vector<u64>,
        building_sui_costs: vector<vector<u64>>,
        building_sity_costs: vector<vector<u64>>,
        factory_bonuses: vector<u64>,
        minted_users: 0x2::table::Table<address, MintedByUser>,
        public_key: vector<u8>,
        ref_reward: u64,
        extra_sui_costs: vector<u64>,
        extra_sity_costs: vector<u64>,
    }

    struct MintedByUser has drop, store {
        user_minted: bool,
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
        building_type: u8,
        new_level: u64,
    }

    struct RefBonusClaimed has copy, drop {
        nft_id: 0x2::object::ID,
        claimer: address,
        ref_owner: address,
    }

    public fun url(arg0: &City) : &0x2::url::Url {
        &arg0.url
    }

    public entry fun accumulate_sity(arg0: &mut City, arg1: &mut GameData, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 5, 2);
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
        0x2::balance::join<0x6cc3c2b9f33461479ec785c5f6ea759e0f118a96bde35cc15325c7b853e7fe66::sity::SITY>(&mut arg0.balance, 0x2::coin::into_balance<0x6cc3c2b9f33461479ec785c5f6ea759e0f118a96bde35cc15325c7b853e7fe66::sity::SITY>(0x2::coin::take<0x6cc3c2b9f33461479ec785c5f6ea759e0f118a96bde35cc15325c7b853e7fe66::sity::SITY>(&mut arg1.pool, v2 * *0x1::vector::borrow<u64>(&arg1.accumulation_speeds, *0x1::vector::borrow<u64>(&arg0.buildings, 0)) * arg1.speed / 3600000, arg3)));
        arg0.last_accumulated = v0;
    }

    public entry fun build_city(arg0: &mut GameData, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 5, 2);
        let v0 = 0x2::tx_context::sender(arg2);
        if (0x2::table::contains<address, MintedByUser>(&arg0.minted_users, v0)) {
            abort 3
        };
        let v1 = arg0.base_name;
        0x1::string::append(&mut v1, 0x1::string::utf8(0x1::vector::singleton<u8>(32)));
        0x1::string::append(&mut v1, 0x1::string::utf8(0x1::vector::singleton<u8>(35)));
        0x1::string::append(&mut v1, u64_to_string(arg0.minted + 1));
        let v2 = arg0.base_image_url;
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
        let v5 = City{
            id               : 0x2::object::new(arg2),
            index            : arg0.minted + 1,
            name             : v1,
            description      : arg0.description,
            url              : 0x2::url::new_unsafe_from_bytes(0x1::string::into_bytes(v2)),
            balance          : 0x2::balance::zero<0x6cc3c2b9f33461479ec785c5f6ea759e0f118a96bde35cc15325c7b853e7fe66::sity::SITY>(),
            buildings        : vector[0, 0, 0, 0, 0, 0, 0, 0],
            last_claimed     : 0x2::clock::timestamp_ms(arg1),
            last_daily_bonus : 0x2::clock::timestamp_ms(arg1) - 86400000,
            last_accumulated : 0x2::clock::timestamp_ms(arg1),
            population       : 40000,
            ref_used         : false,
        };
        let v6 = NFTMinted{
            object_id : 0x2::object::id<City>(&v5),
            creator   : v0,
            name      : v5.name,
        };
        0x2::event::emit<NFTMinted>(v6);
        0x2::transfer::transfer<City>(v5, v0);
        arg0.minted = arg0.minted + 1;
    }

    public entry fun burn(arg0: City, arg1: &mut 0x2::tx_context::TxContext) {
        let City {
            id               : v0,
            index            : _,
            name             : _,
            description      : _,
            url              : _,
            balance          : v5,
            buildings        : _,
            last_claimed     : _,
            last_daily_bonus : _,
            last_accumulated : _,
            population       : _,
            ref_used         : _,
        } = arg0;
        0x2::balance::destroy_zero<0x6cc3c2b9f33461479ec785c5f6ea759e0f118a96bde35cc15325c7b853e7fe66::sity::SITY>(v5);
        0x2::object::delete(v0);
    }

    fun calculate_factory_bonus(arg0: &City, arg1: &GameData) : u64 {
        0x2::balance::value<0x6cc3c2b9f33461479ec785c5f6ea759e0f118a96bde35cc15325c7b853e7fe66::sity::SITY>(&arg0.balance) * *0x1::vector::borrow<u64>(&arg1.factory_bonuses, *0x1::vector::borrow<u64>(&arg0.buildings, 1)) / 100
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
        let v0 = 10000;
        let v1 = 0;
        while (v1 < *0x1::vector::borrow<u64>(&arg0.buildings, 0)) {
            let v2 = v0 * 14;
            v0 = v2 / 10;
            v1 = v1 + 1;
        };
        let v3 = 10000;
        let v4 = 0;
        while (v4 < *0x1::vector::borrow<u64>(&arg0.buildings, 1)) {
            let v5 = v3 * 14;
            v3 = v5 / 10;
            v4 = v4 + 1;
        };
        let v6 = 10000;
        let v7 = 0;
        while (v7 < *0x1::vector::borrow<u64>(&arg0.buildings, 2)) {
            let v8 = v6 * 14;
            v6 = v8 / 10;
            v7 = v7 + 1;
        };
        let v9 = 10000;
        let v10 = 0;
        while (v10 < *0x1::vector::borrow<u64>(&arg0.buildings, 3)) {
            let v11 = v9 * 14;
            v9 = v11 / 10;
            v10 = v10 + 1;
        };
        v0 + v3 + v6 + v9 + 0x2::balance::value<0x6cc3c2b9f33461479ec785c5f6ea759e0f118a96bde35cc15325c7b853e7fe66::sity::SITY>(&arg0.balance)
    }

    public entry fun change_name_with_sity(arg0: &mut City, arg1: &mut GameData, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::ed25519::ed25519_verify(&arg3, &arg1.public_key, &arg4), 5);
        let v0 = *0x1::vector::borrow<u64>(&arg1.extra_sity_costs, 0) * arg1.cost_multiplier;
        assert!(v0 != 0, 6);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= v0 / 100, 4);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        arg0.name = 0x1::string::utf8(arg4);
    }

    public entry fun change_name_with_sui(arg0: &mut City, arg1: &mut GameData, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = *0x1::vector::borrow<u64>(&arg1.extra_sui_costs, 0) * arg1.cost_multiplier;
        assert!(v0 != 0, 6);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= v0 / 100, 4);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        arg0.name = arg3;
    }

    public entry fun claim_factory_bonus(arg0: &mut City, arg1: &mut GameData, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        accumulate_sity(arg0, arg1, arg2, arg3);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 - arg0.last_daily_bonus >= 86400000 / arg1.speed, 8);
        let v1 = calculate_factory_bonus(arg0, arg1);
        arg0.last_daily_bonus = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x6cc3c2b9f33461479ec785c5f6ea759e0f118a96bde35cc15325c7b853e7fe66::sity::SITY>>(0x2::coin::take<0x6cc3c2b9f33461479ec785c5f6ea759e0f118a96bde35cc15325c7b853e7fe66::sity::SITY>(&mut arg1.pool, v1, arg3), 0x2::tx_context::sender(arg3));
        let v2 = BonusClaimed{
            object_id : 0x2::object::id<City>(arg0),
            amount    : v1,
        };
        0x2::event::emit<BonusClaimed>(v2);
    }

    public entry fun claim_reference(arg0: &mut GameData, arg1: &mut City, arg2: address, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(*0x1::vector::borrow<u64>(&arg1.buildings, 0) + *0x1::vector::borrow<u64>(&arg1.buildings, 1) + *0x1::vector::borrow<u64>(&arg1.buildings, 2) + *0x1::vector::borrow<u64>(&arg1.buildings, 3) >= 3, 9);
        assert!(arg0.version == 5, 2);
        assert!(arg1.ref_used == false, 10);
        assert!(0x2::ed25519::ed25519_verify(&arg3, &arg0.public_key, &arg4), 5);
        let v0 = arg0.ref_reward;
        assert!(0x2::balance::value<0x6cc3c2b9f33461479ec785c5f6ea759e0f118a96bde35cc15325c7b853e7fe66::sity::SITY>(&arg0.pool) >= 2 * v0, 11);
        let v1 = 0x2::tx_context::sender(arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x6cc3c2b9f33461479ec785c5f6ea759e0f118a96bde35cc15325c7b853e7fe66::sity::SITY>>(0x2::coin::take<0x6cc3c2b9f33461479ec785c5f6ea759e0f118a96bde35cc15325c7b853e7fe66::sity::SITY>(&mut arg0.pool, v0, arg5), v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x6cc3c2b9f33461479ec785c5f6ea759e0f118a96bde35cc15325c7b853e7fe66::sity::SITY>>(0x2::coin::take<0x6cc3c2b9f33461479ec785c5f6ea759e0f118a96bde35cc15325c7b853e7fe66::sity::SITY>(&mut arg0.pool, v0, arg5), arg2);
        arg1.ref_used = true;
        let v2 = RefBonusClaimed{
            nft_id    : 0x2::object::uid_to_inner(&arg1.id),
            claimer   : v1,
            ref_owner : arg2,
        };
        0x2::event::emit<RefBonusClaimed>(v2);
    }

    public entry fun claim_reward(arg0: &mut GameData, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::ed25519::ed25519_verify(&arg1, &arg0.public_key, &arg2), 5);
        assert!(arg0.version == 5, 2);
        assert!(arg3 > 0, 12);
        assert!(arg3 < 10000000, 13);
        if (0x2::table::contains<address, MintedByUser>(&arg0.minted_users, 0x2::tx_context::sender(arg4))) {
            abort 3
        };
        assert!(0x2::balance::value<0x6cc3c2b9f33461479ec785c5f6ea759e0f118a96bde35cc15325c7b853e7fe66::sity::SITY>(&arg0.pool) >= arg3, 11);
        let v0 = 0x2::tx_context::sender(arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x6cc3c2b9f33461479ec785c5f6ea759e0f118a96bde35cc15325c7b853e7fe66::sity::SITY>>(0x2::coin::take<0x6cc3c2b9f33461479ec785c5f6ea759e0f118a96bde35cc15325c7b853e7fe66::sity::SITY>(&mut arg0.pool, arg3, arg4), v0);
        let v1 = RewardClaimed{
            claimer : v0,
            amount  : arg3,
        };
        0x2::event::emit<RewardClaimed>(v1);
    }

    public entry fun claim_sity(arg0: &mut City, arg1: &mut GameData, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        accumulate_sity(arg0, arg1, arg2, arg3);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::balance::value<0x6cc3c2b9f33461479ec785c5f6ea759e0f118a96bde35cc15325c7b853e7fe66::sity::SITY>(&arg0.balance);
        assert!(v1 > 0, 7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x6cc3c2b9f33461479ec785c5f6ea759e0f118a96bde35cc15325c7b853e7fe66::sity::SITY>>(0x2::coin::take<0x6cc3c2b9f33461479ec785c5f6ea759e0f118a96bde35cc15325c7b853e7fe66::sity::SITY>(&mut arg0.balance, v1, arg3), v0);
        let v2 = SITYClaimed{
            nft_id  : 0x2::object::uid_to_inner(&arg0.id),
            amount  : v1,
            claimer : v0,
        };
        0x2::event::emit<SITYClaimed>(v2);
        arg0.last_claimed = 0x2::clock::timestamp_ms(arg2);
    }

    public fun create_pool(arg0: &mut GameData, arg1: &mut 0x2::coin::TreasuryCap<0x6cc3c2b9f33461479ec785c5f6ea759e0f118a96bde35cc15325c7b853e7fe66::sity::SITY>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.publisher, 0);
        0x2::balance::join<0x6cc3c2b9f33461479ec785c5f6ea759e0f118a96bde35cc15325c7b853e7fe66::sity::SITY>(&mut arg0.pool, 0x2::coin::into_balance<0x6cc3c2b9f33461479ec785c5f6ea759e0f118a96bde35cc15325c7b853e7fe66::sity::SITY>(0x6cc3c2b9f33461479ec785c5f6ea759e0f118a96bde35cc15325c7b853e7fe66::sity::create(arg1, 10000000000, arg2)));
    }

    public fun description(arg0: &City) : &0x1::string::String {
        &arg0.description
    }

    fun generate_image_url(arg0: &0x1::string::String, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : 0x1::string::String {
        let v0 = *arg0;
        0x1::string::append(&mut v0, u64_to_string(arg1));
        0x1::string::append(&mut v0, u64_to_string(arg2));
        0x1::string::append(&mut v0, u64_to_string(arg3));
        0x1::string::append(&mut v0, u64_to_string(arg4));
        let v1 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v1, 46);
        0x1::vector::push_back<u8>(&mut v1, 119);
        0x1::vector::push_back<u8>(&mut v1, 101);
        0x1::vector::push_back<u8>(&mut v1, 98);
        0x1::vector::push_back<u8>(&mut v1, 112);
        0x1::string::append(&mut v0, 0x1::string::utf8(v1));
        v0
    }

    fun init(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = GameData{
            id                  : 0x2::object::new(arg1),
            version             : 5,
            minted              : 0,
            speed               : 1,
            cost_multiplier     : 1,
            base_name           : 0x1::string::utf8(b"SuiCity"),
            base_url            : 0x1::string::utf8(b"https://suicityp2e.com"),
            base_image_url      : 0x1::string::utf8(b"https://bafybeifbd7bkfgj2urg43i2qwkbsc6pmh3v6cllifxw6z2xiqzfgkryhd4.ipfs.w3s.link/"),
            description         : 0x1::string::utf8(x"467265654d696e7420796f7572205375694369747920616e64207374617274206275696c64696e672026206561726e696e6720796f757220245349545920f09f8f99efb88f20546865206669727374206f6e636861696e20506c61793241697264726f702067616d6520776869636820706f776572656420627920644e465473"),
            balance             : 0x2::balance::zero<0x2::sui::SUI>(),
            pool                : 0x2::balance::zero<0x6cc3c2b9f33461479ec785c5f6ea759e0f118a96bde35cc15325c7b853e7fe66::sity::SITY>(),
            publisher           : 0x2::tx_context::sender(arg1),
            accumulation_speeds : vector[100000, 180000, 310000, 550000, 960000, 1700000, 3000000, 5125000],
            building_sui_costs  : vector[vector[800000000, 0, 4000000000, 0, 20000000000, 0, 75000000000], vector[0, 0, 0, 9500000000, 0, 35000000000, 0], vector[800000000, 0, 4000000000, 0, 20000000000, 0, 75000000000], vector[0, 1800000000, 0, 9500000000, 0, 35000000000, 0]],
            building_sity_costs : vector[vector[0, 620000, 0, 2900000, 0, 9400000, 0], vector[200000, 620000, 1400000, 0, 6200000, 0, 20000000], vector[0, 620000, 0, 2900000, 0, 9400000, 0], vector[200000, 0, 1400000, 0, 6200000, 0, 20000000]],
            factory_bonuses     : vector[30, 55, 80, 105, 130, 150, 170, 200],
            minted_users        : 0x2::table::new<address, MintedByUser>(arg1),
            public_key          : x"5a567940437464ff7e491acb6dc17595ada001a1241fc34a3620f9df2382d2e2",
            ref_reward          : 500000,
            extra_sui_costs     : vector[10000000000],
            extra_sity_costs    : vector[1000000],
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
        assert!(arg0.version < 5, 1);
        arg0.version = 5;
    }

    public fun modify_cost_multiplier(arg0: &mut GameData, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.publisher, 0);
        arg0.cost_multiplier = arg1;
    }

    public fun modify_game_data(arg0: &mut GameData, arg1: u64, arg2: u64, arg3: vector<u64>, arg4: vector<vector<u64>>, arg5: vector<vector<u64>>, arg6: vector<u64>, arg7: u64, arg8: vector<u64>, arg9: vector<u64>, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg10) == arg0.publisher, 0);
        arg0.accumulation_speeds = arg3;
        arg0.speed = arg1;
        arg0.cost_multiplier = arg2;
        arg0.building_sui_costs = arg4;
        arg0.building_sity_costs = arg5;
        arg0.factory_bonuses = arg6;
        arg0.ref_reward = arg7;
        arg0.extra_sui_costs = arg8;
        arg0.extra_sity_costs = arg9;
    }

    public fun name(arg0: &City) : &0x1::string::String {
        &arg0.name
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

    public fun upgrade_building_with_sity(arg0: &mut City, arg1: &mut GameData, arg2: u8, arg3: 0x2::coin::Coin<0x6cc3c2b9f33461479ec785c5f6ea759e0f118a96bde35cc15325c7b853e7fe66::sity::SITY>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        accumulate_sity(arg0, arg1, arg4, arg5);
        let v0 = *0x1::vector::borrow<u64>(&arg0.buildings, (arg2 as u64));
        let v1 = *0x1::vector::borrow<u64>(0x1::vector::borrow<vector<u64>>(&arg1.building_sity_costs, (arg2 as u64)), v0) * arg1.cost_multiplier;
        assert!(v1 != 0, 6);
        assert!(0x2::coin::value<0x6cc3c2b9f33461479ec785c5f6ea759e0f118a96bde35cc15325c7b853e7fe66::sity::SITY>(&arg3) >= v1 / 100, 4);
        0x2::balance::join<0x6cc3c2b9f33461479ec785c5f6ea759e0f118a96bde35cc15325c7b853e7fe66::sity::SITY>(&mut arg1.pool, 0x2::coin::into_balance<0x6cc3c2b9f33461479ec785c5f6ea759e0f118a96bde35cc15325c7b853e7fe66::sity::SITY>(arg3));
        *0x1::vector::borrow_mut<u64>(&mut arg0.buildings, (arg2 as u64)) = v0 + 1;
        arg0.population = calculate_population(arg0);
        arg0.url = 0x2::url::new_unsafe_from_bytes(0x1::string::into_bytes(generate_image_url(&arg1.base_image_url, *0x1::vector::borrow<u64>(&arg0.buildings, 0), *0x1::vector::borrow<u64>(&arg0.buildings, 1), *0x1::vector::borrow<u64>(&arg0.buildings, 2), *0x1::vector::borrow<u64>(&arg0.buildings, 3))));
        let v2 = NFTUpgraded{
            object_id     : 0x2::object::uid_to_inner(&arg0.id),
            building_type : arg2,
            new_level     : v0 + 1,
        };
        0x2::event::emit<NFTUpgraded>(v2);
    }

    public fun upgrade_building_with_sui(arg0: &mut City, arg1: &mut GameData, arg2: u8, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        accumulate_sity(arg0, arg1, arg4, arg5);
        let v0 = *0x1::vector::borrow<u64>(&arg0.buildings, (arg2 as u64));
        let v1 = *0x1::vector::borrow<u64>(0x1::vector::borrow<vector<u64>>(&arg1.building_sui_costs, (arg2 as u64)), v0) * arg1.cost_multiplier;
        assert!(v1 != 0, 6);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= v1 / 100, 4);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg3));
        *0x1::vector::borrow_mut<u64>(&mut arg0.buildings, (arg2 as u64)) = v0 + 1;
        arg0.population = calculate_population(arg0);
        arg0.url = 0x2::url::new_unsafe_from_bytes(0x1::string::into_bytes(generate_image_url(&arg1.base_image_url, *0x1::vector::borrow<u64>(&arg0.buildings, 0), *0x1::vector::borrow<u64>(&arg0.buildings, 1), *0x1::vector::borrow<u64>(&arg0.buildings, 2), *0x1::vector::borrow<u64>(&arg0.buildings, 3))));
        let v2 = NFTUpgraded{
            object_id     : 0x2::object::uid_to_inner(&arg0.id),
            building_type : arg2,
            new_level     : v0 + 1,
        };
        0x2::event::emit<NFTUpgraded>(v2);
    }

    public entry fun withdraw_funds(arg0: &mut GameData, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.publisher, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, 0x2::balance::value<0x2::sui::SUI>(&arg0.balance), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

