module 0xa8c2eb313bb51642184eeb3731ef28ce0eb3823d5c6ccb3dfa54af87c0564df5::world {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct GameWorld<phantom T0> has key {
        id: 0x2::object::UID,
        total_players: u64,
        total_items_purchased: u64,
        total_bublz_burned: u64,
        total_sui_earned: u64,
        treasury: 0x2::balance::Balance<0x2::sui::SUI>,
        reward_pool: 0x2::balance::Balance<T0>,
        paused: bool,
        character_base_sui: u64,
        character_base_bublz: u64,
        username_base_sui: u64,
        username_base_bublz: u64,
        gathering_reward_base: u64,
        task_reward_easy: u64,
        task_reward_medium: u64,
        task_reward_hard: u64,
        task_reward_bonus: u64,
        characters: 0x2::table::Table<address, Character>,
        shop_items: 0x2::table::Table<u64, ShopItem>,
        shop_item_counter: u64,
        marketplace_listings: 0x2::table::Table<u64, MarketListing>,
        listing_counter: u64,
        active_auction: 0x1::option::Option<Auction>,
        quests: 0x2::table::Table<u64, QuestTemplate>,
        quest_counter: u64,
    }

    struct Character has store {
        owner: address,
        username: vector<u8>,
        level: u64,
        xp: u64,
        fishing_level: u64,
        fishing_xp: u64,
        mining_level: u64,
        mining_xp: u64,
        home_tier: u64,
        fishing_rod_tier: u64,
        mining_pick_tier: u64,
        fishing_rod_durability: u64,
        mining_pick_durability: u64,
        last_fish_time: u64,
        last_mine_time: u64,
        last_daily_claim: u64,
        daily_fish_count: u64,
        daily_mine_count: u64,
        daily_tasks_day: u64,
        items_owned: vector<u64>,
        trophies_fish: vector<u64>,
        trophies_gems: vector<u64>,
        pet_id: u64,
        total_bublz_spent: u64,
        total_sui_spent: u64,
        created_at: u64,
        completed_quests: vector<u64>,
    }

    struct ShopItem has store {
        id: u64,
        name: vector<u8>,
        category: u8,
        rarity: u8,
        base_sui_cost: u64,
        base_bublz_cost: u64,
        stock: u64,
        max_stock: u64,
        expires_at: u64,
        total_sold: u64,
    }

    struct MarketListing has store {
        item_id: u64,
        seller: address,
        sui_price: u64,
        listed_at: u64,
    }

    struct Auction has copy, drop, store {
        item_name: vector<u8>,
        item_category: u8,
        item_rarity: u8,
        highest_bidder: address,
        highest_bid: u64,
        bublz_deposit_per_bid: u64,
        ends_at: u64,
        total_bublz_burned: u64,
    }

    struct QuestTemplate has store {
        name: vector<u8>,
        description: vector<u8>,
        requirement_type: u8,
        requirement_value: u64,
        reward_xp: u64,
        reward_item_id: u64,
    }

    struct CharacterCreated has copy, drop {
        owner: address,
        player_number: u64,
        sui_cost: u64,
        bublz_burned: u64,
    }

    struct ItemPurchased has copy, drop {
        buyer: address,
        item_id: u64,
        sui_cost: u64,
        bublz_burned: u64,
    }

    struct GatheringResult has copy, drop {
        player: address,
        skill: u8,
        skill_level: u64,
        trophy_rarity: u8,
        xp_gained: u64,
        bublz_earned: u64,
    }

    struct MarketSale has copy, drop {
        seller: address,
        buyer: address,
        item_id: u64,
        sui_price: u64,
        bublz_fee_burned: u64,
        treasury_cut: u64,
    }

    struct AuctionBid has copy, drop {
        bidder: address,
        amount: u64,
        bublz_deposit_burned: u64,
    }

    struct AuctionWon has copy, drop {
        winner: address,
        item_name: vector<u8>,
        winning_bid: u64,
    }

    struct LevelUp has copy, drop {
        player: address,
        new_level: u64,
        skill: u8,
    }

    entry fun add_quest<T0>(arg0: &mut GameWorld<T0>, arg1: &AdminCap, arg2: vector<u8>, arg3: vector<u8>, arg4: u8, arg5: u64, arg6: u64, arg7: u64) {
        arg0.quest_counter = arg0.quest_counter + 1;
        let v0 = QuestTemplate{
            name              : arg2,
            description       : arg3,
            requirement_type  : arg4,
            requirement_value : arg5,
            reward_xp         : arg6,
            reward_item_id    : arg7,
        };
        0x2::table::add<u64, QuestTemplate>(&mut arg0.quests, arg0.quest_counter, v0);
    }

    entry fun add_shop_item<T0>(arg0: &mut GameWorld<T0>, arg1: &AdminCap, arg2: vector<u8>, arg3: u8, arg4: u8, arg5: u64, arg6: u64, arg7: u64, arg8: u64) {
        let v0 = arg0.shop_item_counter;
        arg0.shop_item_counter = arg0.shop_item_counter + 1;
        let v1 = ShopItem{
            id              : v0,
            name            : arg2,
            category        : arg3,
            rarity          : arg4,
            base_sui_cost   : arg5,
            base_bublz_cost : arg6,
            stock           : 0,
            max_stock       : arg7,
            expires_at      : arg8,
            total_sold      : 0,
        };
        0x2::table::add<u64, ShopItem>(&mut arg0.shop_items, v0, v1);
    }

    entry fun buy_from_marketplace<T0>(arg0: &mut GameWorld<T0>, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<u64, MarketListing>(&arg0.marketplace_listings, arg1), 11);
        let MarketListing {
            item_id   : v0,
            seller    : v1,
            sui_price : v2,
            listed_at : _,
        } = 0x2::table::remove<u64, MarketListing>(&mut arg0.marketplace_listings, arg1);
        let v4 = 0x2::tx_context::sender(arg4);
        assert!(v4 != v1, 12);
        let v5 = v2 / 10;
        let v6 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v6 >= v2, 5);
        let v7 = 0x2::coin::into_balance<0x2::sui::SUI>(arg2);
        if (v6 > v2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v7, v6 - v2), arg4), v4);
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.treasury, 0x2::balance::split<0x2::sui::SUI>(&mut v7, v5));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v7, arg4), v1);
        let v8 = v2 / 12;
        let v9 = 0x2::coin::value<T0>(&arg3);
        assert!(v9 >= v8, 5);
        let v10 = 0x2::coin::into_balance<T0>(arg3);
        if (v9 > v8) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v10, v9 - v8), arg4), v4);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v10, arg4), @0x0);
        assert!(0x2::table::contains<address, Character>(&arg0.characters, v4), 1);
        0x1::vector::push_back<u64>(&mut 0x2::table::borrow_mut<address, Character>(&mut arg0.characters, v4).items_owned, v0);
        arg0.total_bublz_burned = arg0.total_bublz_burned + v8;
        arg0.total_sui_earned = arg0.total_sui_earned + v5;
        let v11 = MarketSale{
            seller           : v1,
            buyer            : v4,
            item_id          : v0,
            sui_price        : v2,
            bublz_fee_burned : v8,
            treasury_cut     : v5,
        };
        0x2::event::emit<MarketSale>(v11);
    }

    entry fun buy_shop_item<T0>(arg0: &mut GameWorld<T0>, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 13);
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(0x2::table::contains<address, Character>(&arg0.characters, v0), 1);
        assert!(0x2::table::contains<u64, ShopItem>(&arg0.shop_items, arg1), 14);
        let v1 = 0x2::table::borrow_mut<u64, ShopItem>(&mut arg0.shop_items, arg1);
        assert!(v1.expires_at == 0 || 0x2::clock::timestamp_ms(arg4) < v1.expires_at, 15);
        assert!(v1.max_stock == 0 || v1.total_sold < v1.max_stock, 15);
        let v2 = get_price_multiplier(arg0.total_players);
        let v3 = calc_cost(v1.base_sui_cost, v2);
        let v4 = calc_cost(v1.base_bublz_cost, v2);
        let v5 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v5 >= v3, 5);
        let v6 = 0x2::coin::into_balance<0x2::sui::SUI>(arg2);
        if (v5 > v3) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v6, v5 - v3), arg5), v0);
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.treasury, v6);
        let v7 = 0x2::coin::value<T0>(&arg3);
        assert!(v7 >= v4, 5);
        let v8 = 0x2::coin::into_balance<T0>(arg3);
        if (v7 > v4) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v8, v7 - v4), arg5), v0);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v8, arg5), @0x0);
        v1.total_sold = v1.total_sold + 1;
        let v9 = 0x2::table::borrow_mut<address, Character>(&mut arg0.characters, v0);
        0x1::vector::push_back<u64>(&mut v9.items_owned, arg1);
        v9.total_bublz_spent = v9.total_bublz_spent + v4;
        v9.total_sui_spent = v9.total_sui_spent + v3;
        arg0.total_items_purchased = arg0.total_items_purchased + 1;
        arg0.total_bublz_burned = arg0.total_bublz_burned + v4;
        arg0.total_sui_earned = arg0.total_sui_earned + v3;
        let v10 = ItemPurchased{
            buyer        : v0,
            item_id      : arg1,
            sui_cost     : v3,
            bublz_burned : v4,
        };
        0x2::event::emit<ItemPurchased>(v10);
    }

    fun calc_cost(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / 100) as u64)
    }

    entry fun cancel_listing<T0>(arg0: &mut GameWorld<T0>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<u64, MarketListing>(&arg0.marketplace_listings, arg1), 11);
        let MarketListing {
            item_id   : v0,
            seller    : v1,
            sui_price : _,
            listed_at : _,
        } = 0x2::table::remove<u64, MarketListing>(&mut arg0.marketplace_listings, arg1);
        let v4 = 0x2::tx_context::sender(arg2);
        assert!(v4 == v1, 10);
        0x1::vector::push_back<u64>(&mut 0x2::table::borrow_mut<address, Character>(&mut arg0.characters, v4).items_owned, v0);
    }

    fun check_level_up(arg0: u64, arg1: u64, arg2: u64, arg3: bool) : u64 {
        let v0 = arg0;
        let v1 = if (arg2 > 0) {
            arg2
        } else {
            100
        };
        while (v0 < v1) {
            let v2 = if (arg3) {
                xp_for_skill_level(v0 + 1)
            } else {
                xp_for_character_level(v0 + 1)
            };
            if (arg1 >= v2) {
                v0 = v0 + 1;
            } else {
                break
            };
        };
        v0
    }

    entry fun create_auction<T0>(arg0: &mut GameWorld<T0>, arg1: &AdminCap, arg2: vector<u8>, arg3: u8, arg4: u8, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock) {
        assert!(0x1::option::is_none<Auction>(&arg0.active_auction), 25);
        let v0 = Auction{
            item_name             : arg2,
            item_category         : arg3,
            item_rarity           : arg4,
            highest_bidder        : @0x0,
            highest_bid           : arg5,
            bublz_deposit_per_bid : arg6,
            ends_at               : 0x2::clock::timestamp_ms(arg8) + arg7,
            total_bublz_burned    : 0,
        };
        arg0.active_auction = 0x1::option::some<Auction>(v0);
    }

    entry fun create_character<T0>(arg0: &mut GameWorld<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 13);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(!0x2::table::contains<address, Character>(&arg0.characters, v0), 0);
        let v1 = get_price_multiplier(arg0.total_players);
        let v2 = calc_cost(arg0.character_base_sui, v1);
        let v3 = calc_cost(arg0.character_base_bublz, v1);
        let v4 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v4 >= v2, 5);
        let v5 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
        if (v4 > v2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v5, v4 - v2), arg4), v0);
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.treasury, v5);
        let v6 = 0x2::coin::value<T0>(&arg2);
        assert!(v6 >= v3, 5);
        let v7 = 0x2::coin::into_balance<T0>(arg2);
        if (v6 > v3) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v7, v6 - v3), arg4), v0);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v7, arg4), @0x0);
        let v8 = Character{
            owner                  : v0,
            username               : 0x1::vector::empty<u8>(),
            level                  : 1,
            xp                     : 0,
            fishing_level          : 1,
            fishing_xp             : 0,
            mining_level           : 1,
            mining_xp              : 0,
            home_tier              : 0,
            fishing_rod_tier       : 1,
            mining_pick_tier       : 1,
            fishing_rod_durability : 100,
            mining_pick_durability : 100,
            last_fish_time         : 0,
            last_mine_time         : 0,
            last_daily_claim       : 0,
            daily_fish_count       : 0,
            daily_mine_count       : 0,
            daily_tasks_day        : 0,
            items_owned            : 0x1::vector::empty<u64>(),
            trophies_fish          : 0x1::vector::empty<u64>(),
            trophies_gems          : 0x1::vector::empty<u64>(),
            pet_id                 : 0,
            total_bublz_spent      : v3,
            total_sui_spent        : v2,
            created_at             : 0x2::clock::timestamp_ms(arg3),
            completed_quests       : 0x1::vector::empty<u64>(),
        };
        0x2::table::add<address, Character>(&mut arg0.characters, v0, v8);
        arg0.total_players = arg0.total_players + 1;
        arg0.total_bublz_burned = arg0.total_bublz_burned + v3;
        arg0.total_sui_earned = arg0.total_sui_earned + v2;
        let v9 = CharacterCreated{
            owner         : v0,
            player_number : arg0.total_players,
            sui_cost      : v2,
            bublz_burned  : v3,
        };
        0x2::event::emit<CharacterCreated>(v9);
    }

    entry fun create_world<T0>(arg0: &AdminCap, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = GameWorld<T0>{
            id                    : 0x2::object::new(arg5),
            total_players         : 0,
            total_items_purchased : 0,
            total_bublz_burned    : 0,
            total_sui_earned      : 0,
            treasury              : 0x2::balance::zero<0x2::sui::SUI>(),
            reward_pool           : 0x2::balance::zero<T0>(),
            paused                : false,
            character_base_sui    : arg1,
            character_base_bublz  : arg2,
            username_base_sui     : 1000000000,
            username_base_bublz   : 50000000000,
            gathering_reward_base : arg3,
            task_reward_easy      : 1000000000,
            task_reward_medium    : 2000000000,
            task_reward_hard      : 5000000000,
            task_reward_bonus     : 5000000000,
            characters            : 0x2::table::new<address, Character>(arg5),
            shop_items            : 0x2::table::new<u64, ShopItem>(arg5),
            shop_item_counter     : 0,
            marketplace_listings  : 0x2::table::new<u64, MarketListing>(arg5),
            listing_counter       : 0,
            active_auction        : 0x1::option::none<Auction>(),
            quests                : 0x2::table::new<u64, QuestTemplate>(arg5),
            quest_counter         : 0,
        };
        0x2::transfer::share_object<GameWorld<T0>>(v0);
    }

    entry fun emergency_withdraw<T0>(arg0: &mut GameWorld<T0>, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.paused, 13);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&arg0.treasury);
        let v2 = 0x2::balance::value<T0>(&arg0.reward_pool);
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.treasury, v1), arg2), v0);
        };
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reward_pool, v2), arg2), v0);
        };
    }

    entry fun finalize_auction<T0>(arg0: &mut GameWorld<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<Auction>(&arg0.active_auction), 25);
        let v0 = 0x1::option::extract<Auction>(&mut arg0.active_auction);
        assert!(0x2::clock::timestamp_ms(arg1) >= v0.ends_at, 23);
        if (v0.highest_bidder != @0x0) {
            let v1 = arg0.shop_item_counter;
            arg0.shop_item_counter = arg0.shop_item_counter + 1;
            let v2 = ShopItem{
                id              : v1,
                name            : v0.item_name,
                category        : v0.item_category,
                rarity          : v0.item_rarity,
                base_sui_cost   : 0,
                base_bublz_cost : 0,
                stock           : 0,
                max_stock       : 0,
                expires_at      : 0,
                total_sold      : 1,
            };
            0x2::table::add<u64, ShopItem>(&mut arg0.shop_items, v1, v2);
            if (0x2::table::contains<address, Character>(&arg0.characters, v0.highest_bidder)) {
                0x1::vector::push_back<u64>(&mut 0x2::table::borrow_mut<address, Character>(&mut arg0.characters, v0.highest_bidder).items_owned, v1);
            };
            arg0.total_sui_earned = arg0.total_sui_earned + v0.highest_bid;
            let v3 = AuctionWon{
                winner      : v0.highest_bidder,
                item_name   : v0.item_name,
                winning_bid : v0.highest_bid,
            };
            0x2::event::emit<AuctionWon>(v3);
        };
    }

    entry fun fish<T0>(arg0: &mut GameWorld<T0>, arg1: &0x2::random::Random, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 13);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::table::contains<address, Character>(&arg0.characters, v0), 1);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = 0x2::table::borrow_mut<address, Character>(&mut arg0.characters, v0);
        assert!(v1 >= v2.last_fish_time + 30000, 19);
        assert!(v2.fishing_rod_durability > 0, 17);
        let v3 = 0x2::random::new_generator(arg1, arg3);
        let v4 = get_trophy_rarity(v2.fishing_level, 0x2::random::generate_u64_in_range(&mut v3, 0, 99));
        let v5 = if (v4 == 4) {
            50
        } else if (v4 == 3) {
            30
        } else if (v4 == 2) {
            20
        } else if (v4 == 1) {
            10
        } else {
            5
        };
        let v6 = v5 * v2.fishing_rod_tier;
        v2.fishing_xp = v2.fishing_xp + v6;
        let v7 = check_level_up(v2.fishing_level, v2.fishing_xp, 99, true);
        if (v7 > v2.fishing_level) {
            v2.fishing_level = v7;
            let v8 = LevelUp{
                player    : v0,
                new_level : v7,
                skill     : 1,
            };
            0x2::event::emit<LevelUp>(v8);
        };
        v2.xp = v2.xp + v6;
        let v9 = check_level_up(v2.level, v2.xp, 100, false);
        if (v9 > v2.level) {
            v2.level = v9;
            let v10 = LevelUp{
                player    : v0,
                new_level : v9,
                skill     : 0,
            };
            0x2::event::emit<LevelUp>(v10);
        };
        0x1::vector::push_back<u64>(&mut v2.trophies_fish, (v4 as u64));
        v2.fishing_rod_durability = v2.fishing_rod_durability - 1;
        v2.last_fish_time = v1;
        let v11 = get_day_number(v1);
        if (v2.daily_tasks_day != v11) {
            v2.daily_fish_count = 0;
            v2.daily_mine_count = 0;
            v2.daily_tasks_day = v11;
        };
        v2.daily_fish_count = v2.daily_fish_count + 1;
        let v12 = 0;
        if (v2.fishing_level >= 90) {
            v12 = arg0.gathering_reward_base * 4;
        } else if (v2.fishing_level >= 60) {
            v12 = arg0.gathering_reward_base * 2;
        } else if (v2.fishing_level >= 30) {
            v12 = arg0.gathering_reward_base;
        };
        if (v12 > 0 && 0x2::balance::value<T0>(&arg0.reward_pool) >= v12) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reward_pool, v12), arg3), v0);
        } else {
            v12 = 0;
        };
        let v13 = GatheringResult{
            player        : v0,
            skill         : 1,
            skill_level   : v2.fishing_level,
            trophy_rarity : v4,
            xp_gained     : v6,
            bublz_earned  : v12,
        };
        0x2::event::emit<GatheringResult>(v13);
    }

    entry fun fund_reward_pool<T0>(arg0: &mut GameWorld<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.reward_pool, 0x2::coin::into_balance<T0>(arg1));
    }

    fun get_day_number(arg0: u64) : u64 {
        arg0 / 86400000
    }

    fun get_equipment_base_bublz(arg0: u64) : u64 {
        if (arg0 == 2) {
            50000000000
        } else if (arg0 == 3) {
            200000000000
        } else if (arg0 == 4) {
            500000000000
        } else if (arg0 == 5) {
            1000000000000
        } else if (arg0 == 6) {
            3000000000000
        } else {
            0
        }
    }

    fun get_equipment_base_sui(arg0: u64) : u64 {
        if (arg0 == 2) {
            1000000000
        } else if (arg0 == 3) {
            3000000000
        } else if (arg0 == 4) {
            8000000000
        } else if (arg0 == 5) {
            15000000000
        } else if (arg0 == 6) {
            30000000000
        } else {
            0
        }
    }

    fun get_equipment_durability(arg0: u64) : u64 {
        if (arg0 <= 1) {
            100
        } else if (arg0 == 2) {
            150
        } else if (arg0 == 3) {
            200
        } else if (arg0 == 4) {
            300
        } else if (arg0 == 5) {
            400
        } else if (arg0 == 6) {
            500
        } else {
            750
        }
    }

    fun get_home_base_bublz(arg0: u64) : u64 {
        if (arg0 == 1) {
            200000000000
        } else if (arg0 == 2) {
            500000000000
        } else if (arg0 == 3) {
            1000000000000
        } else if (arg0 == 4) {
            3000000000000
        } else if (arg0 == 5) {
            5000000000000
        } else {
            0
        }
    }

    fun get_home_base_sui(arg0: u64) : u64 {
        if (arg0 == 1) {
            10000000000
        } else if (arg0 == 2) {
            25000000000
        } else if (arg0 == 3) {
            50000000000
        } else if (arg0 == 4) {
            100000000000
        } else if (arg0 == 5) {
            200000000000
        } else {
            0
        }
    }

    public fun get_price_mult<T0>(arg0: &GameWorld<T0>) : u64 {
        get_price_multiplier(arg0.total_players)
    }

    fun get_price_multiplier(arg0: u64) : u64 {
        if (arg0 < 10) {
            100
        } else if (arg0 < 25) {
            150
        } else if (arg0 < 50) {
            200
        } else if (arg0 < 100) {
            250
        } else if (arg0 < 200) {
            300
        } else if (arg0 < 500) {
            400
        } else {
            500
        }
    }

    public fun get_total_bublz_burned<T0>(arg0: &GameWorld<T0>) : u64 {
        arg0.total_bublz_burned
    }

    public fun get_total_items_purchased<T0>(arg0: &GameWorld<T0>) : u64 {
        arg0.total_items_purchased
    }

    public fun get_total_players<T0>(arg0: &GameWorld<T0>) : u64 {
        arg0.total_players
    }

    public fun get_total_sui_earned<T0>(arg0: &GameWorld<T0>) : u64 {
        arg0.total_sui_earned
    }

    fun get_trophy_rarity(arg0: u64, arg1: u64) : u8 {
        if (arg0 >= 90 && arg1 < 5) {
            4
        } else if (arg0 >= 60 && arg1 < 15) {
            3
        } else if (arg0 >= 30 && arg1 < 30) {
            2
        } else if (arg1 < 60) {
            1
        } else {
            0
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    entry fun list_on_marketplace<T0>(arg0: &mut GameWorld<T0>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::table::contains<address, Character>(&arg0.characters, v0), 1);
        let v1 = 0x2::table::borrow_mut<address, Character>(&mut arg0.characters, v0);
        let v2 = false;
        let v3 = 0;
        while (v3 < 0x1::vector::length<u64>(&v1.items_owned)) {
            if (*0x1::vector::borrow<u64>(&v1.items_owned, v3) == arg1) {
                v2 = true;
                v3 = 0x1::vector::length<u64>(&v1.items_owned);
            };
            v3 = v3 + 1;
        };
        assert!(v2, 10);
        0x1::vector::remove<u64>(&mut v1.items_owned, 0);
        arg0.listing_counter = arg0.listing_counter + 1;
        let v4 = MarketListing{
            item_id   : arg1,
            seller    : v0,
            sui_price : arg2,
            listed_at : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::table::add<u64, MarketListing>(&mut arg0.marketplace_listings, arg0.listing_counter, v4);
    }

    entry fun mine<T0>(arg0: &mut GameWorld<T0>, arg1: &0x2::random::Random, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 13);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::table::contains<address, Character>(&arg0.characters, v0), 1);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = 0x2::table::borrow_mut<address, Character>(&mut arg0.characters, v0);
        assert!(v1 >= v2.last_mine_time + 30000, 19);
        assert!(v2.mining_pick_durability > 0, 17);
        let v3 = 0x2::random::new_generator(arg1, arg3);
        let v4 = get_trophy_rarity(v2.mining_level, 0x2::random::generate_u64_in_range(&mut v3, 0, 99));
        let v5 = if (v4 == 4) {
            50
        } else if (v4 == 3) {
            30
        } else if (v4 == 2) {
            20
        } else if (v4 == 1) {
            10
        } else {
            5
        };
        let v6 = v5 * v2.mining_pick_tier;
        v2.mining_xp = v2.mining_xp + v6;
        let v7 = check_level_up(v2.mining_level, v2.mining_xp, 99, true);
        if (v7 > v2.mining_level) {
            v2.mining_level = v7;
            let v8 = LevelUp{
                player    : v0,
                new_level : v7,
                skill     : 2,
            };
            0x2::event::emit<LevelUp>(v8);
        };
        v2.xp = v2.xp + v6;
        let v9 = check_level_up(v2.level, v2.xp, 100, false);
        if (v9 > v2.level) {
            v2.level = v9;
            let v10 = LevelUp{
                player    : v0,
                new_level : v9,
                skill     : 0,
            };
            0x2::event::emit<LevelUp>(v10);
        };
        0x1::vector::push_back<u64>(&mut v2.trophies_gems, (v4 as u64));
        v2.mining_pick_durability = v2.mining_pick_durability - 1;
        v2.last_mine_time = v1;
        let v11 = get_day_number(v1);
        if (v2.daily_tasks_day != v11) {
            v2.daily_fish_count = 0;
            v2.daily_mine_count = 0;
            v2.daily_tasks_day = v11;
        };
        v2.daily_mine_count = v2.daily_mine_count + 1;
        let v12 = 0;
        if (v2.mining_level >= 90) {
            v12 = arg0.gathering_reward_base * 4;
        } else if (v2.mining_level >= 60) {
            v12 = arg0.gathering_reward_base * 2;
        } else if (v2.mining_level >= 30) {
            v12 = arg0.gathering_reward_base;
        };
        if (v12 > 0 && 0x2::balance::value<T0>(&arg0.reward_pool) >= v12) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reward_pool, v12), arg3), v0);
        } else {
            v12 = 0;
        };
        let v13 = GatheringResult{
            player        : v0,
            skill         : 2,
            skill_level   : v2.mining_level,
            trophy_rarity : v4,
            xp_gained     : v6,
            bublz_earned  : v12,
        };
        0x2::event::emit<GatheringResult>(v13);
    }

    entry fun place_bid<T0>(arg0: &mut GameWorld<T0>, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<Auction>(&arg0.active_auction), 25);
        let v0 = 0x1::option::borrow_mut<Auction>(&mut arg0.active_auction);
        let v1 = 0x2::tx_context::sender(arg4);
        assert!(arg1 > v0.highest_bid, 24);
        if (v0.highest_bidder != @0x0) {
            let v2 = v0.highest_bid;
            if (0x2::balance::value<0x2::sui::SUI>(&arg0.treasury) >= v2) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.treasury, v2), arg4), v0.highest_bidder);
            };
        };
        let v3 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v3 >= arg1, 5);
        let v4 = 0x2::coin::into_balance<0x2::sui::SUI>(arg2);
        if (v3 > arg1) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v4, v3 - arg1), arg4), v1);
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.treasury, v4);
        let v5 = 0x2::coin::value<T0>(&arg3);
        assert!(v5 >= v0.bublz_deposit_per_bid, 5);
        let v6 = 0x2::coin::into_balance<T0>(arg3);
        if (v5 > v0.bublz_deposit_per_bid) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v6, v5 - v0.bublz_deposit_per_bid), arg4), v1);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v6, arg4), @0x0);
        v0.highest_bidder = v1;
        v0.highest_bid = arg1;
        v0.total_bublz_burned = v0.total_bublz_burned + v0.bublz_deposit_per_bid;
        arg0.total_bublz_burned = arg0.total_bublz_burned + v0.bublz_deposit_per_bid;
        let v7 = AuctionBid{
            bidder               : v1,
            amount               : arg1,
            bublz_deposit_burned : v0.bublz_deposit_per_bid,
        };
        0x2::event::emit<AuctionBid>(v7);
    }

    entry fun repair_equipment<T0>(arg0: &mut GameWorld<T0>, arg1: u8, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::table::contains<address, Character>(&arg0.characters, v0), 1);
        let v1 = if (arg1 == 1) {
            0x2::table::borrow<address, Character>(&arg0.characters, v0).fishing_rod_tier
        } else {
            0x2::table::borrow<address, Character>(&arg0.characters, v0).mining_pick_tier
        };
        let v2 = v1 * 10000000000;
        let v3 = 0x2::coin::value<T0>(&arg2);
        assert!(v3 >= v2, 5);
        let v4 = 0x2::coin::into_balance<T0>(arg2);
        if (v3 > v2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v4, v3 - v2), arg3), v0);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v4, arg3), @0x0);
        let v5 = 0x2::table::borrow_mut<address, Character>(&mut arg0.characters, v0);
        if (arg1 == 1) {
            v5.fishing_rod_durability = get_equipment_durability(v1);
        } else {
            v5.mining_pick_durability = get_equipment_durability(v1);
        };
        v5.total_bublz_spent = v5.total_bublz_spent + v2;
        arg0.total_bublz_burned = arg0.total_bublz_burned + v2;
    }

    entry fun set_character_base_bublz<T0>(arg0: &mut GameWorld<T0>, arg1: &AdminCap, arg2: u64) {
        arg0.character_base_bublz = arg2;
    }

    entry fun set_character_base_sui<T0>(arg0: &mut GameWorld<T0>, arg1: &AdminCap, arg2: u64) {
        arg0.character_base_sui = arg2;
    }

    entry fun set_gathering_reward_base<T0>(arg0: &mut GameWorld<T0>, arg1: &AdminCap, arg2: u64) {
        arg0.gathering_reward_base = arg2;
    }

    entry fun set_paused<T0>(arg0: &mut GameWorld<T0>, arg1: &AdminCap, arg2: bool) {
        arg0.paused = arg2;
    }

    entry fun set_task_rewards<T0>(arg0: &mut GameWorld<T0>, arg1: &AdminCap, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        arg0.task_reward_easy = arg2;
        arg0.task_reward_medium = arg3;
        arg0.task_reward_hard = arg4;
        arg0.task_reward_bonus = arg5;
    }

    entry fun set_username<T0>(arg0: &mut GameWorld<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x2::coin::Coin<T0>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::table::contains<address, Character>(&arg0.characters, v0), 1);
        let v1 = get_price_multiplier(arg0.total_players);
        let v2 = calc_cost(arg0.username_base_sui, v1);
        let v3 = calc_cost(arg0.username_base_bublz, v1);
        let v4 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v4 >= v2, 5);
        let v5 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
        if (v4 > v2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v5, v4 - v2), arg4), v0);
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.treasury, v5);
        let v6 = 0x2::coin::value<T0>(&arg2);
        assert!(v6 >= v3, 5);
        let v7 = 0x2::coin::into_balance<T0>(arg2);
        if (v6 > v3) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v7, v6 - v3), arg4), v0);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v7, arg4), @0x0);
        let v8 = 0x2::table::borrow_mut<address, Character>(&mut arg0.characters, v0);
        v8.username = arg3;
        v8.total_bublz_spent = v8.total_bublz_spent + v3;
        v8.total_sui_spent = v8.total_sui_spent + v2;
        arg0.total_bublz_burned = arg0.total_bublz_burned + v3;
        arg0.total_sui_earned = arg0.total_sui_earned + v2;
    }

    entry fun set_username_base_bublz<T0>(arg0: &mut GameWorld<T0>, arg1: &AdminCap, arg2: u64) {
        arg0.username_base_bublz = arg2;
    }

    entry fun set_username_base_sui<T0>(arg0: &mut GameWorld<T0>, arg1: &AdminCap, arg2: u64) {
        arg0.username_base_sui = arg2;
    }

    entry fun upgrade_equipment<T0>(arg0: &mut GameWorld<T0>, arg1: u8, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 13);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::table::contains<address, Character>(&arg0.characters, v0), 1);
        let v1 = if (arg1 == 1) {
            0x2::table::borrow<address, Character>(&arg0.characters, v0).fishing_rod_tier
        } else {
            0x2::table::borrow<address, Character>(&arg0.characters, v0).mining_pick_tier
        };
        let v2 = v1 + 1;
        assert!(v2 <= 7, 6);
        let v3 = get_price_multiplier(arg0.total_players);
        let v4 = calc_cost(get_equipment_base_sui(v2), v3);
        let v5 = calc_cost(get_equipment_base_bublz(v2), v3);
        let v6 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v6 >= v4, 5);
        let v7 = 0x2::coin::into_balance<0x2::sui::SUI>(arg2);
        if (v6 > v4) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v7, v6 - v4), arg4), v0);
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.treasury, v7);
        let v8 = 0x2::coin::value<T0>(&arg3);
        assert!(v8 >= v5, 5);
        let v9 = 0x2::coin::into_balance<T0>(arg3);
        if (v8 > v5) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v9, v8 - v5), arg4), v0);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v9, arg4), @0x0);
        let v10 = 0x2::table::borrow_mut<address, Character>(&mut arg0.characters, v0);
        if (arg1 == 1) {
            v10.fishing_rod_tier = v2;
            v10.fishing_rod_durability = get_equipment_durability(v2);
        } else {
            v10.mining_pick_tier = v2;
            v10.mining_pick_durability = get_equipment_durability(v2);
        };
        v10.total_bublz_spent = v10.total_bublz_spent + v5;
        v10.total_sui_spent = v10.total_sui_spent + v4;
        arg0.total_bublz_burned = arg0.total_bublz_burned + v5;
        arg0.total_sui_earned = arg0.total_sui_earned + v4;
    }

    entry fun upgrade_home<T0>(arg0: &mut GameWorld<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 13);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::table::contains<address, Character>(&arg0.characters, v0), 1);
        let v1 = 0x2::table::borrow<address, Character>(&arg0.characters, v0).home_tier + 1;
        assert!(v1 <= 5, 7);
        let v2 = get_price_multiplier(arg0.total_players);
        let v3 = calc_cost(get_home_base_sui(v1), v2);
        let v4 = calc_cost(get_home_base_bublz(v1), v2);
        let v5 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v5 >= v3, 5);
        let v6 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
        if (v5 > v3) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v6, v5 - v3), arg3), v0);
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.treasury, v6);
        let v7 = 0x2::coin::value<T0>(&arg2);
        assert!(v7 >= v4, 5);
        let v8 = 0x2::coin::into_balance<T0>(arg2);
        if (v7 > v4) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v8, v7 - v4), arg3), v0);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v8, arg3), @0x0);
        let v9 = 0x2::table::borrow_mut<address, Character>(&mut arg0.characters, v0);
        v9.home_tier = v1;
        v9.total_bublz_spent = v9.total_bublz_spent + v4;
        v9.total_sui_spent = v9.total_sui_spent + v3;
        arg0.total_bublz_burned = arg0.total_bublz_burned + v4;
        arg0.total_sui_earned = arg0.total_sui_earned + v3;
    }

    entry fun withdraw_treasury<T0>(arg0: &mut GameWorld<T0>, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.treasury);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.treasury, v0), arg2), 0x2::tx_context::sender(arg2));
        };
    }

    fun xp_for_character_level(arg0: u64) : u64 {
        if (arg0 <= 1) {
            0
        } else {
            let v1 = (arg0 as u128);
            ((v1 * v1 * 250 + v1 * 500) as u64)
        }
    }

    fun xp_for_skill_level(arg0: u64) : u64 {
        if (arg0 <= 1) {
            0
        } else {
            let v1 = (arg0 as u128);
            ((v1 * v1 * 200 + v1 * 300) as u64)
        }
    }

    // decompiled from Move bytecode v6
}

