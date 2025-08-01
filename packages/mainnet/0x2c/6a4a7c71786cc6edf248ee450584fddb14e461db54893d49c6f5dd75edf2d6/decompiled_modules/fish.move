module 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::fish {
    struct Fish has store, key {
        id: 0x2::object::UID,
        fid: u64,
        rarity: u8,
        size: u8,
        gender: u8,
        collected_by_diver_id: 0x2::object::ID,
        collected_date: u64,
        is_encyclopedia_used: bool,
    }

    struct FishEncyclopedia has key {
        id: 0x2::object::UID,
        rarity_fish_ids: vector<vector<u64>>,
    }

    struct ReleaseFishEvent has copy, drop {
        fish_object_id: 0x2::object::ID,
        fish_id: u64,
        rarity: u8,
        size: u8,
        collected_date: u64,
        bonus_coin_amount: u64,
        is_full_bonus: bool,
    }

    struct CollectFishEvent has copy, drop {
        fish_object_id: 0x2::object::ID,
        fish_id: u64,
        rarity: u8,
        size: u8,
        collected_date: u64,
    }

    struct UserActiveFishEncyclopediaEvent has copy, drop {
        fish_object_id: 0x2::object::ID,
        fish_id: u64,
        fish_size: u8,
    }

    struct AddFishEncyclopediaEvent has copy, drop {
        rarity: u8,
        fish_id: u64,
    }

    public fun active_fish_encyclopedia(arg0: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::user::User, arg1: &mut Fish, arg2: &0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::GlobalState, arg3: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::leaderboard::GlobalLeaderboard) {
        abort 6
    }

    public fun active_fish_encyclopedia_v2(arg0: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::user::User, arg1: Fish, arg2: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::dive_token::DIVETokenTreasuryCap, arg3: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::GlobalState, arg4: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::leaderboard::GlobalLeaderboard, arg5: &mut 0x2::tx_context::TxContext) {
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::utils::assert_valid_version(arg3);
        assert!(0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::is_fish_encyclopedia_enabled(arg3), 0);
        assert!(arg1.is_encyclopedia_used == false, 1);
        let Fish {
            id                    : v0,
            fid                   : v1,
            rarity                : v2,
            size                  : v3,
            gender                : _,
            collected_by_diver_id : _,
            collected_date        : _,
            is_encyclopedia_used  : _,
        } = arg1;
        assert!(v2 < 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::config::max_fish_rarity_count(), 2);
        assert!(v3 < 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::config::max_fish_size_count(), 3);
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::update_global_state_released_fishes_rarity_distribution(arg3, v2);
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::update_global_state_fishes_rarity_distribution(arg3, v2, false);
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::user::user_active_fish_encyclopedia(arg0, v1, (v3 as u64), arg4);
        let v8 = 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::config::release_bonus();
        assert!(v2 < (0x1::vector::length<vector<u64>>(&v8) as u8), 2);
        assert!(v3 < (0x1::vector::length<u64>(0x1::vector::borrow<vector<u64>>(&v8, (v2 as u64))) as u8), 3);
        let v9 = *0x1::vector::borrow<u64>(0x1::vector::borrow<vector<u64>>(&v8, (v2 as u64)), (v3 as u64)) * 10000;
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::dive_token::mint_dive_token(arg2, v9, 0x2::tx_context::sender(arg5), 0, arg5);
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::update_global_state_total_dive_token_minted(arg3, 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::field_index_total_dive_token_minted_released(), v9);
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::user::add_fishes_released(arg0, 1, arg4);
        0x2::object::delete(v0);
        let v10 = UserActiveFishEncyclopediaEvent{
            fish_object_id : 0x2::object::id<Fish>(&arg1),
            fish_id        : v1,
            fish_size      : (v3 as u8),
        };
        0x2::event::emit<UserActiveFishEncyclopediaEvent>(v10);
    }

    public(friend) fun emit_collect_fish_event(arg0: &Fish) {
        let v0 = CollectFishEvent{
            fish_object_id : 0x2::object::id<Fish>(arg0),
            fish_id        : fish_id(arg0),
            rarity         : arg0.rarity,
            size           : arg0.size,
            collected_date : arg0.collected_date,
        };
        0x2::event::emit<CollectFishEvent>(v0);
    }

    public fun fish_encyclopedia_get_random_fish_id(arg0: &FishEncyclopedia, arg1: u8, arg2: u64) : u64 {
        assert!(arg1 < 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::config::max_fish_rarity_count(), 2);
        let v0 = 0x1::vector::borrow<vector<u64>>(&arg0.rarity_fish_ids, (arg1 as u64));
        assert!(arg2 < (0x1::vector::length<u64>(v0) as u64), 5);
        *0x1::vector::borrow<u64>(v0, arg2)
    }

    public fun fish_encyclopedia_rarity_fish_count(arg0: &FishEncyclopedia, arg1: u8) : u64 {
        assert!(arg1 < 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::config::max_fish_rarity_count(), 2);
        let v0 = *0x1::vector::borrow<vector<u64>>(&arg0.rarity_fish_ids, (arg1 as u64));
        0x1::vector::length<u64>(&v0)
    }

    public fun fish_gender(arg0: &Fish) : u8 {
        arg0.gender
    }

    public fun fish_id(arg0: &Fish) : u64 {
        arg0.fid
    }

    public fun fish_release_bonus(arg0: &Fish) : u64 {
        let v0 = 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::config::release_bonus();
        assert!(arg0.rarity < (0x1::vector::length<vector<u64>>(&v0) as u8), 2);
        assert!(arg0.size < (0x1::vector::length<u64>(0x1::vector::borrow<vector<u64>>(&v0, (arg0.rarity as u64))) as u8), 3);
        *0x1::vector::borrow<u64>(0x1::vector::borrow<vector<u64>>(&v0, (arg0.rarity as u64)), (arg0.size as u64))
    }

    public fun fish_size(arg0: &Fish) : u8 {
        arg0.size
    }

    public(friend) fun generate_fish(arg0: u64, arg1: u8, arg2: u8, arg3: u8, arg4: 0x2::object::ID, arg5: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::GlobalState, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : Fish {
        assert!(arg1 < 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::config::max_fish_rarity_count(), 2);
        assert!(arg2 < 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::config::max_fish_size_count(), 3);
        assert!(arg3 == 1 || arg3 == 2, 4);
        let v0 = Fish{
            id                    : 0x2::object::new(arg7),
            fid                   : arg0,
            rarity                : arg1,
            size                  : arg2,
            gender                : arg3,
            collected_by_diver_id : arg4,
            collected_date        : 0x2::clock::timestamp_ms(arg6),
            is_encyclopedia_used  : false,
        };
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::update_global_state_fishes_rarity_distribution(arg5, arg1, true);
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::update_global_state_collected_fishes_rarity_distribution(arg5, arg1);
        v0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = FishEncyclopedia{
            id              : 0x2::object::new(arg0),
            rarity_fish_ids : vector[vector[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13], vector[14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 27, 29, 30, 31], vector[25, 26, 28, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 56, 57, 65, 115], vector[55, 58, 59, 60, 61, 62, 63, 64, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 117], vector[88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 116]],
        };
        0x2::transfer::share_object<FishEncyclopedia>(v0);
    }

    public fun register_new_fish_to_encyclopedia(arg0: &0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::GlobalAdminCap, arg1: &mut FishEncyclopedia, arg2: u8, arg3: u64, arg4: &0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::GlobalState) {
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::utils::assert_valid_version(arg4);
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::check_is_admin(arg4, arg0);
        0x1::vector::push_back<u64>(0x1::vector::borrow_mut<vector<u64>>(&mut arg1.rarity_fish_ids, (arg2 as u64)), arg3);
        let v0 = AddFishEncyclopediaEvent{
            rarity  : arg2,
            fish_id : arg3,
        };
        0x2::event::emit<AddFishEncyclopediaEvent>(v0);
    }

    public fun release_fish(arg0: Fish, arg1: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::GlobalState, arg2: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::dive_token::DIVETokenTreasuryCap, arg3: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::user::User, arg4: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::leaderboard::GlobalLeaderboard, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::utils::assert_valid_version(arg1);
        let Fish {
            id                    : v0,
            fid                   : _,
            rarity                : v2,
            size                  : v3,
            gender                : _,
            collected_by_diver_id : _,
            collected_date        : v6,
            is_encyclopedia_used  : _,
        } = arg0;
        assert!(v2 < 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::config::max_fish_rarity_count(), 2);
        assert!(v3 < 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::config::max_fish_size_count(), 3);
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::update_global_state_released_fishes_rarity_distribution(arg1, v2);
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::update_global_state_fishes_rarity_distribution(arg1, v2, false);
        let v8 = 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::config::release_bonus();
        assert!(v2 < (0x1::vector::length<vector<u64>>(&v8) as u8), 2);
        assert!(v3 < (0x1::vector::length<u64>(0x1::vector::borrow<vector<u64>>(&v8, (v2 as u64))) as u8), 3);
        let v9 = *0x1::vector::borrow<u64>(0x1::vector::borrow<vector<u64>>(&v8, (v2 as u64)), (v3 as u64)) * 10000;
        let v10 = v9;
        let v11 = 0x2::clock::timestamp_ms(arg5) - v6 >= 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::config::fully_release_bonus_duration_ms();
        if (!v11) {
            v10 = v9 * 80 / 100;
        };
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::dive_token::mint_dive_token(arg2, v10, 0x2::tx_context::sender(arg6), 0, arg6);
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::update_global_state_total_dive_token_minted(arg1, 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::field_index_total_dive_token_minted_released(), v10);
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::user::add_fishes_released(arg3, 1, arg4);
        0x2::object::delete(v0);
        let v12 = ReleaseFishEvent{
            fish_object_id    : 0x2::object::id<Fish>(&arg0),
            fish_id           : fish_id(&arg0),
            rarity            : v2,
            size              : v3,
            collected_date    : v6,
            bonus_coin_amount : v10,
            is_full_bonus     : v11,
        };
        0x2::event::emit<ReleaseFishEvent>(v12);
    }

    // decompiled from Move bytecode v6
}

