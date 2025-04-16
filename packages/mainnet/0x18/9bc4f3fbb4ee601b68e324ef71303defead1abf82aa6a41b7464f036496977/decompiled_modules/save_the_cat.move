module 0x189bc4f3fbb4ee601b68e324ef71303defead1abf82aa6a41b7464f036496977::save_the_cat {
    struct DeadCat has copy, drop, store {
        cat_id: u64,
        name: vector<u8>,
        time_alive: u64,
        cause_of_death: vector<u8>,
        last_feeder: address,
    }

    struct SavedCat has copy, drop, store {
        cat_id: u64,
        adopter: address,
        time_alive: u64,
        total_feedings: u64,
        mood_at_rescue: vector<u8>,
    }

    struct CatNFT has store, key {
        id: 0x2::object::UID,
        cat_id: u64,
        name: 0x1::string::String,
        time_alive: u64,
        total_feedings: u64,
        mood: 0x1::string::String,
        died: bool,
        murdered: bool,
        birth_timestamp: u64,
        death_timestamp: u64,
    }

    struct CatGame has key {
        id: 0x2::object::UID,
        cat_id: u64,
        pot: 0x2::balance::Balance<0x2::sui::SUI>,
        pot_size: u64,
        current_time_remaining: u64,
        last_feed_timestamp: u64,
        last_hurt_timestamp: u64,
        last_feeder: address,
        last_hurter: address,
        last_action: u8,
        birth_timestamp: u64,
        death_timestamp: u64,
        total_feedings: u64,
        total_unique_feeders: u64,
        cats_saved: u64,
        cats_lost: u64,
        creator_address: address,
        graveyard: vector<DeadCat>,
        saved_cats: vector<SavedCat>,
        feeders: vector<address>,
        hurters: vector<address>,
        total_hurts: u64,
        total_unique_hurters: u64,
        longest_survived: u64,
    }

    struct CatFed has copy, drop {
        feeder: address,
        amount_paid: u64,
        new_time_remaining: u64,
        new_pot_size: u64,
    }

    struct CatDied has copy, drop {
        cat_id: u64,
        time_alive: u64,
        last_feeder: address,
        last_hurter: address,
        pot_amount: u64,
    }

    struct CatRescued has copy, drop {
        cat_id: u64,
        rescuer: address,
        time_alive: u64,
        pot_amount: u64,
    }

    struct CatKilled has copy, drop {
        cat_id: u64,
        killer: address,
        time_alive: u64,
        pot_amount: u64,
    }

    struct CatHurt has copy, drop {
        hurter: address,
        amount_paid: u64,
        new_time_remaining: u64,
        new_pot_size: u64,
    }

    struct SAVE_THE_CAT has drop {
        dummy_field: bool,
    }

    public entry fun claim_dead_cat(arg0: &mut CatGame, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(time_remaining(arg0, arg2) == 0, 2);
        if (arg0.death_timestamp == 0) {
            if (arg0.last_feed_timestamp == 0) {
                arg0.death_timestamp = arg0.birth_timestamp + 86400 * 1000;
            } else {
                arg0.death_timestamp = arg0.last_feed_timestamp + arg0.current_time_remaining * 1000;
            };
        };
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= 5000000000, 0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.pot, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        arg0.pot_size = 0x2::balance::value<0x2::sui::SUI>(&arg0.pot);
        let v0 = if (arg0.last_feed_timestamp > 0) {
            86400 - arg0.current_time_remaining
        } else {
            86400
        };
        if (v0 > arg0.longest_survived) {
            arg0.longest_survived = v0;
        };
        let v1 = DeadCat{
            cat_id         : arg0.cat_id,
            name           : b"Unnamed Cat",
            time_alive     : v0,
            cause_of_death : b"Starvation",
            last_feeder    : arg0.last_feeder,
        };
        0x1::vector::push_back<DeadCat>(&mut arg0.graveyard, v1);
        arg0.cats_lost = arg0.cats_lost + 1;
        let v2 = 0x2::balance::value<0x2::sui::SUI>(&arg0.pot);
        if (v2 > 0) {
            if (arg0.last_feeder != @0x0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.pot, v2 / 2), arg3), arg0.last_feeder);
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.pot), arg3), arg0.creator_address);
            arg0.pot_size = 0;
        };
        let v3 = CatDied{
            cat_id      : arg0.cat_id,
            time_alive  : v0,
            last_feeder : arg0.last_feeder,
            last_hurter : arg0.last_hurter,
            pot_amount  : v2,
        };
        0x2::event::emit<CatDied>(v3);
        reset_cat(arg0, arg2);
    }

    public entry fun feed_cat(arg0: &mut CatGame, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = time_remaining(arg0, arg2);
        assert!(v1 > 0, 1);
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.pot, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        arg0.pot_size = 0x2::balance::value<0x2::sui::SUI>(&arg0.pot);
        let v3 = v1 + v2 / 1000000000 * 600;
        let v4 = v3;
        if (v3 > 216000) {
            v4 = 216000;
        };
        arg0.current_time_remaining = v4;
        arg0.last_feed_timestamp = v0;
        arg0.last_feeder = 0x2::tx_context::sender(arg3);
        arg0.last_action = 0;
        arg0.total_feedings = arg0.total_feedings + 1;
        let v5 = 0x2::tx_context::sender(arg3);
        let v6 = true;
        let v7 = 0;
        while (v7 < 0x1::vector::length<address>(&arg0.feeders)) {
            if (*0x1::vector::borrow<address>(&arg0.feeders, v7) == v5) {
                v6 = false;
                break
            };
            v7 = v7 + 1;
        };
        if (v6) {
            0x1::vector::push_back<address>(&mut arg0.feeders, v5);
            arg0.total_unique_feeders = arg0.total_unique_feeders + 1;
        };
        if (arg0.total_feedings == 1) {
            if (arg0.birth_timestamp == 0) {
                arg0.birth_timestamp = v0;
            };
            let v8 = v0 / 1000 - arg0.last_feed_timestamp / 1000;
            if (v8 < arg0.current_time_remaining) {
                arg0.current_time_remaining = arg0.current_time_remaining - v8;
            } else {
                arg0.current_time_remaining = 0;
            };
        };
        let v9 = CatFed{
            feeder             : arg0.last_feeder,
            amount_paid        : v2,
            new_time_remaining : v4,
            new_pot_size       : 0x2::balance::value<0x2::sui::SUI>(&arg0.pot),
        };
        0x2::event::emit<CatFed>(v9);
    }

    public fun get_birth_timestamp(arg0: &CatGame) : u64 {
        arg0.birth_timestamp
    }

    public fun get_cat_id(arg0: &CatGame) : u64 {
        arg0.cat_id
    }

    public fun get_cat_info(arg0: &CatGame, arg1: &0x2::clock::Clock) : (u64, bool, bool, u64, u64, u64, u64, u64, u64, u64, u64, u64, address, address, u64, u64, u64, u64, u64, u64, u64, u64, u8, u64) {
        let v0 = time_remaining(arg0, arg1);
        let v1 = get_death_timestamp(arg0, arg1);
        let v2 = if (arg0.birth_timestamp > 0) {
            if (v1 > 0) {
                (v1 - arg0.birth_timestamp) / 1000
            } else {
                (0x2::clock::timestamp_ms(arg1) - arg0.birth_timestamp) / 1000
            }
        } else {
            0
        };
        (arg0.cat_id, v0 > 0, v0 == 0, v0, v2, arg0.birth_timestamp, v1, arg0.last_feed_timestamp, arg0.last_hurt_timestamp, arg0.pot_size, arg0.total_feedings, arg0.total_unique_feeders, arg0.last_feeder, arg0.last_hurter, arg0.total_hurts, arg0.total_unique_hurters, arg0.cats_saved, arg0.cats_lost, 60, 600, 999999000000000, 999999000000000, arg0.last_action, arg0.longest_survived)
    }

    public fun get_cats_lost(arg0: &CatGame) : u64 {
        arg0.cats_lost
    }

    public fun get_cats_saved(arg0: &CatGame) : u64 {
        arg0.cats_saved
    }

    public fun get_death_timestamp(arg0: &CatGame, arg1: &0x2::clock::Clock) : u64 {
        if (arg0.death_timestamp != 0) {
            arg0.death_timestamp
        } else if (time_remaining(arg0, arg1) > 0) {
            0
        } else if (arg0.last_feed_timestamp == 0) {
            arg0.birth_timestamp + 86400 * 1000
        } else {
            arg0.last_feed_timestamp + arg0.current_time_remaining * 1000
        }
    }

    public fun get_last_feed_timestamp(arg0: &CatGame) : u64 {
        arg0.last_feed_timestamp
    }

    public fun get_last_feeder(arg0: &CatGame) : address {
        arg0.last_feeder
    }

    public fun get_last_hurter(arg0: &CatGame) : address {
        arg0.last_hurter
    }

    public fun get_pot_size(arg0: &CatGame) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.pot)
    }

    public fun get_time_remaining(arg0: &CatGame, arg1: &0x2::clock::Clock) : u64 {
        time_remaining(arg0, arg1)
    }

    public fun get_total_feedings(arg0: &CatGame) : u64 {
        arg0.total_feedings
    }

    public fun get_total_unique_feeders(arg0: &CatGame) : u64 {
        arg0.total_unique_feeders
    }

    public entry fun hurt_cat(arg0: &mut CatGame, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = time_remaining(arg0, arg2);
        assert!(v1 > 0, 1);
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v2 >= 1000000000, 0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.pot, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        arg0.pot_size = 0x2::balance::value<0x2::sui::SUI>(&arg0.pot);
        let v3 = v2 / 1000000000 * 60;
        let v4 = if (v3 >= v1) {
            0
        } else {
            v1 - v3
        };
        arg0.current_time_remaining = v4;
        arg0.last_feed_timestamp = v0;
        arg0.last_hurt_timestamp = v0;
        arg0.last_hurter = 0x2::tx_context::sender(arg3);
        arg0.last_action = 1;
        arg0.total_hurts = arg0.total_hurts + 1;
        let v5 = 0x2::tx_context::sender(arg3);
        let v6 = true;
        let v7 = 0;
        while (v7 < 0x1::vector::length<address>(&arg0.hurters)) {
            if (*0x1::vector::borrow<address>(&arg0.hurters, v7) == v5) {
                v6 = false;
                break
            };
            v7 = v7 + 1;
        };
        if (v6) {
            0x1::vector::push_back<address>(&mut arg0.hurters, v5);
            arg0.total_unique_hurters = arg0.total_unique_hurters + 1;
        };
        let v8 = CatHurt{
            hurter             : 0x2::tx_context::sender(arg3),
            amount_paid        : v2,
            new_time_remaining : v4,
            new_pot_size       : 0x2::balance::value<0x2::sui::SUI>(&arg0.pot),
        };
        0x2::event::emit<CatHurt>(v8);
    }

    fun init(arg0: SAVE_THE_CAT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = CatGame{
            id                     : 0x2::object::new(arg1),
            cat_id                 : 1,
            pot                    : 0x2::balance::zero<0x2::sui::SUI>(),
            pot_size               : 0,
            current_time_remaining : 86400,
            last_feed_timestamp    : 0,
            last_hurt_timestamp    : 0,
            last_feeder            : @0x0,
            last_hurter            : @0x0,
            last_action            : 0,
            birth_timestamp        : 0x2::tx_context::epoch_timestamp_ms(arg1),
            death_timestamp        : 0,
            total_feedings         : 0,
            total_unique_feeders   : 0,
            cats_saved             : 0,
            cats_lost              : 0,
            creator_address        : @0x63180848bfc1156b113880f0d3ee3feb9e2b137b1ef0c80670f850f70c4783ad,
            graveyard              : 0x1::vector::empty<DeadCat>(),
            saved_cats             : 0x1::vector::empty<SavedCat>(),
            feeders                : 0x1::vector::empty<address>(),
            hurters                : 0x1::vector::empty<address>(),
            total_hurts            : 0,
            total_unique_hurters   : 0,
            longest_survived       : 0,
        };
        0x2::transfer::share_object<CatGame>(v0);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"died"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"A cat that lived for {time_alive} seconds with {total_feedings} feedings. Current mood: {mood}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://savethecat.net/images/cats/cat-{cat_id}-{died}.png"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://savethecat.net/cat/{id}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://savethecat.net"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"moral.capital"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{died}"));
        let v5 = 0x2::package::claim<SAVE_THE_CAT>(arg0, arg1);
        let v6 = 0x2::display::new_with_fields<CatNFT>(&v5, v1, v3, arg1);
        0x2::display::update_version<CatNFT>(&mut v6);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<CatNFT>>(v6, 0x2::tx_context::sender(arg1));
    }

    public fun is_cat_alive(arg0: &CatGame, arg1: &0x2::clock::Clock) : bool {
        time_remaining(arg0, arg1) > 0
    }

    public fun is_cat_dead(arg0: &CatGame, arg1: &0x2::clock::Clock) : bool {
        time_remaining(arg0, arg1) <= 0
    }

    public entry fun kill_cat(arg0: &mut CatGame, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0x2::tx_context::sender(arg3);
        assert!(time_remaining(arg0, arg2) > 0, 1);
        arg0.death_timestamp = v0;
        if (v1 != arg0.creator_address) {
            assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= 999999000000000, 0);
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.pot, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        arg0.pot_size = 0x2::balance::value<0x2::sui::SUI>(&arg0.pot);
        let v2 = if (arg0.birth_timestamp > 0) {
            (v0 - arg0.birth_timestamp) / 1000
        } else {
            0
        };
        let v3 = CatNFT{
            id              : 0x2::object::new(arg3),
            cat_id          : arg0.cat_id,
            name            : 0x1::string::utf8(b"Unnamed Cat"),
            time_alive      : v2,
            total_feedings  : arg0.total_feedings,
            mood            : 0x1::string::utf8(b"Dead"),
            died            : true,
            murdered        : true,
            birth_timestamp : arg0.birth_timestamp,
            death_timestamp : v0,
        };
        0x2::transfer::transfer<CatNFT>(v3, v1);
        let v4 = DeadCat{
            cat_id         : arg0.cat_id,
            name           : b"Unnamed Cat",
            time_alive     : v2,
            cause_of_death : b"Murdered",
            last_feeder    : arg0.last_feeder,
        };
        0x1::vector::push_back<DeadCat>(&mut arg0.graveyard, v4);
        let v5 = CatKilled{
            cat_id     : arg0.cat_id,
            killer     : v1,
            time_alive : v2,
            pot_amount : 0x2::balance::value<0x2::sui::SUI>(&arg0.pot),
        };
        0x2::event::emit<CatKilled>(v5);
        arg0.current_time_remaining = 0;
        arg0.last_feed_timestamp = v0;
    }

    public entry fun rescue_cat(arg0: &mut CatGame, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::clock::timestamp_ms(arg2);
        let v0 = time_remaining(arg0, arg2);
        assert!(v0 > 0, 1);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= 999999000000000, 0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.pot, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        arg0.pot_size = 0x2::balance::value<0x2::sui::SUI>(&arg0.pot);
        arg0.cats_saved = arg0.cats_saved + 1;
        let v1 = 86400 - v0;
        let v2 = if (v0 > 216000 / 2) {
            0x1::string::utf8(b"Happy")
        } else if (v0 > 216000 / 4) {
            0x1::string::utf8(b"Content")
        } else {
            0x1::string::utf8(b"Hungry")
        };
        let v3 = if (v0 > 216000 / 2) {
            b"Happy"
        } else if (v0 > 216000 / 4) {
            b"Content"
        } else {
            b"Hungry"
        };
        let v4 = CatNFT{
            id              : 0x2::object::new(arg3),
            cat_id          : arg0.cat_id,
            name            : 0x1::string::utf8(b"Unnamed Cat"),
            time_alive      : v1,
            total_feedings  : arg0.total_feedings,
            mood            : v2,
            died            : false,
            murdered        : false,
            birth_timestamp : arg0.birth_timestamp,
            death_timestamp : 0,
        };
        0x2::transfer::transfer<CatNFT>(v4, 0x2::tx_context::sender(arg3));
        let v5 = SavedCat{
            cat_id         : arg0.cat_id,
            adopter        : 0x2::tx_context::sender(arg3),
            time_alive     : v1,
            total_feedings : arg0.total_feedings,
            mood_at_rescue : v3,
        };
        0x1::vector::push_back<SavedCat>(&mut arg0.saved_cats, v5);
        let v6 = 0x2::balance::value<0x2::sui::SUI>(&arg0.pot);
        if (v6 > 0) {
            if (arg0.last_feeder != @0x0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.pot, v6 / 2), arg3), arg0.last_feeder);
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.pot), arg3), arg0.creator_address);
        };
        let v7 = CatRescued{
            cat_id     : arg0.cat_id,
            rescuer    : 0x2::tx_context::sender(arg3),
            time_alive : v1,
            pot_amount : v6,
        };
        0x2::event::emit<CatRescued>(v7);
        reset_cat(arg0, arg2);
    }

    fun reset_cat(arg0: &mut CatGame, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        arg0.cat_id = arg0.cat_id + 1;
        arg0.current_time_remaining = 86400;
        arg0.last_feed_timestamp = v0;
        arg0.last_hurt_timestamp = 0;
        arg0.birth_timestamp = v0;
        arg0.death_timestamp = 0;
        arg0.last_feeder = @0x0;
        arg0.last_hurter = @0x0;
        arg0.last_action = 0;
        arg0.total_feedings = 0;
        arg0.total_unique_feeders = 0;
        arg0.feeders = 0x1::vector::empty<address>();
        arg0.hurters = 0x1::vector::empty<address>();
        arg0.total_hurts = 0;
        arg0.total_unique_hurters = 0;
        arg0.pot_size = 0;
    }

    public fun time_remaining(arg0: &CatGame, arg1: &0x2::clock::Clock) : u64 {
        if (arg0.last_feed_timestamp == 0) {
            return arg0.current_time_remaining
        };
        let v0 = 0x2::clock::timestamp_ms(arg1) / 1000 - arg0.last_feed_timestamp / 1000;
        if (v0 >= arg0.current_time_remaining) {
            0
        } else {
            arg0.current_time_remaining - v0
        }
    }

    // decompiled from Move bytecode v6
}

