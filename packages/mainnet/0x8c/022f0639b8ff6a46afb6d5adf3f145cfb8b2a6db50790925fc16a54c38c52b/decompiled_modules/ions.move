module 0x8c022f0639b8ff6a46afb6d5adf3f145cfb8b2a6db50790925fc16a54c38c52b::ions {
    struct IONS has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PointsAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct AnimaChef has key {
        id: 0x2::object::UID,
        version: u64,
        ongoing_season: u64,
        season_alloc: 0x2::linked_table::LinkedTable<u64, SeasonRewards>,
    }

    struct SeasonRewards has store {
        start_time: u64,
        end_time: u64,
        is_time_based_distribution: bool,
        rewards_allocated: u64,
        rewards_distribution_rate: u64,
        global_claim_index: u256,
        last_time: u64,
        total_points: u64,
    }

    struct RewardsHolder<phantom T0> has store, key {
        id: 0x2::object::UID,
        coin_balance: 0x2::balance::Balance<T0>,
        total_deposited: u64,
        allocated_amount: u64,
    }

    struct AnimaIONs has key {
        id: 0x2::object::UID,
        created_at: u64,
        referrer: 0x1::option::Option<address>,
        owner: address,
        ion_points: u64,
        last_active_season: u64,
        season_info: 0x2::linked_table::LinkedTable<u64, UserSeasonInfo>,
        claimable_rewards: u64,
        total_claimed_rewards: u64,
    }

    struct UserSeasonInfo has drop, store {
        points_earned: u64,
        claim_index: u256,
        claimed_amount: u64,
    }

    struct AnimaChefInitialized has copy, drop {
        chef_id: 0x2::object::ID,
    }

    struct RewardsAddedToChef has copy, drop {
        deposit_amount: u64,
        total_deposited: u64,
    }

    struct SeasonInitialized has copy, drop {
        season_number: u64,
        start_time: u64,
        end_time: u64,
        rewards_allocated: u64,
        rewards_distribution_rate: u64,
        is_time_based_distribution: bool,
    }

    struct SeasonConfigUpdated has copy, drop {
        season_number: u64,
        start_time: u64,
        end_time: u64,
    }

    struct SeasonRewardsUpdated has copy, drop {
        season_number: u64,
        rewards_distribution_rate: u64,
        rewards_allocated: u64,
    }

    struct AnimaIONsMinted has copy, drop {
        anima_ions_id: 0x2::object::ID,
        owner: address,
        referrer: 0x1::option::Option<address>,
        timestamp: u64,
        cur_season: u64,
    }

    struct IONPointsAwarded has copy, drop {
        anima_ions_id: 0x2::object::ID,
        owner: address,
        points_earned: u64,
        total_points: u64,
        cur_season: u64,
    }

    struct ClaimRewards has copy, drop {
        user: address,
        claimable_rewards: u64,
        total_claimed_rewards: u64,
    }

    public fun add_rewards_to_chef<T0>(arg0: &AdminCap, arg1: &mut AnimaChef, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        validation_check(arg1);
        if (!0x2::dynamic_object_field::exists_<vector<u8>>(&arg1.id, b"ANIMA_REWARDS_HOLDER")) {
            let v0 = RewardsHolder<T0>{
                id               : 0x2::object::new(arg4),
                coin_balance     : 0x2::balance::zero<T0>(),
                total_deposited  : 0,
                allocated_amount : 0,
            };
            0x2::dynamic_object_field::add<vector<u8>, RewardsHolder<T0>>(&mut arg1.id, b"ANIMA_REWARDS_HOLDER", v0);
        };
        let v1 = 0x2::dynamic_object_field::borrow_mut<vector<u8>, RewardsHolder<T0>>(&mut arg1.id, b"ANIMA_REWARDS_HOLDER");
        v1.total_deposited = v1.total_deposited + arg3;
        0x2::balance::join<T0>(&mut v1.coin_balance, 0x2::coin::into_balance<T0>(arg2));
        let v2 = RewardsAddedToChef{
            deposit_amount  : arg3,
            total_deposited : v1.total_deposited,
        };
        0x2::event::emit<RewardsAddedToChef>(v2);
    }

    public fun award_ion_points(arg0: &PointsAdminCap, arg1: &0x2::clock::Clock, arg2: &mut AnimaChef, arg3: &mut AnimaIONs, arg4: u64) {
        validation_check(arg2);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = arg2.ongoing_season;
        settle_last_active_season(arg2, arg3);
        let v2 = 0x2::linked_table::borrow_mut<u64, SeasonRewards>(&mut arg2.season_alloc, v1);
        let v3 = 0x2::linked_table::borrow_mut<u64, UserSeasonInfo>(&mut arg3.season_info, v1);
        let v4 = v2.end_time == 0 && false || v2.end_time < v0;
        if (!v4 && !(v2.start_time > v0)) {
            if (v2.is_time_based_distribution) {
                increment_global_claim_index(arg1, v2);
                let v5 = increment_user_claim_index(v2, v3);
                arg3.claimable_rewards = arg3.claimable_rewards + v5;
            };
            v2.total_points = v2.total_points + arg4;
            v3.points_earned = v3.points_earned + arg4;
            arg3.ion_points = arg3.ion_points + arg4;
            arg3.last_active_season = v1;
            let v6 = IONPointsAwarded{
                anima_ions_id : 0x2::object::id<AnimaIONs>(arg3),
                owner         : arg3.owner,
                points_earned : arg4,
                total_points  : arg3.ion_points,
                cur_season    : v1,
            };
            0x2::event::emit<IONPointsAwarded>(v6);
        };
    }

    public fun claim_rewards<T0>(arg0: &0x2::clock::Clock, arg1: &mut AnimaChef, arg2: &mut AnimaIONs, arg3: &mut 0x2::tx_context::TxContext) {
        validation_check(arg1);
        let v0 = 0x2::clock::timestamp_ms(arg0);
        let v1 = arg1.ongoing_season;
        let v2 = 0x2::tx_context::sender(arg3);
        assert!(0x2::dynamic_object_field::exists_<vector<u8>>(&arg1.id, b"ANIMA_REWARDS_HOLDER"), 13906836828634021902);
        settle_last_active_season(arg1, arg2);
        let v3 = 0x2::linked_table::borrow_mut<u64, SeasonRewards>(&mut arg1.season_alloc, v1);
        let v4 = 0x2::linked_table::borrow_mut<u64, UserSeasonInfo>(&mut arg2.season_info, v1);
        let v5 = v3.end_time == 0 && false || v3.end_time < v0;
        if (!v5 && !(v3.start_time > v0)) {
            if (v3.is_time_based_distribution) {
                increment_global_claim_index(arg0, v3);
                arg2.claimable_rewards = arg2.claimable_rewards + increment_user_claim_index(v3, v4);
                arg2.last_active_season = v1;
            };
        };
        let v6 = arg2.claimable_rewards;
        arg2.claimable_rewards = 0;
        arg2.total_claimed_rewards = arg2.total_claimed_rewards + v6;
        destroy_or_transfer_balance<T0>(0x2::balance::split<T0>(&mut 0x2::dynamic_object_field::borrow_mut<vector<u8>, RewardsHolder<T0>>(&mut arg1.id, b"ANIMA_REWARDS_HOLDER").coin_balance, v6), v2, arg3);
        let v7 = ClaimRewards{
            user                  : v2,
            claimable_rewards     : v6,
            total_claimed_rewards : arg2.total_claimed_rewards,
        };
        0x2::event::emit<ClaimRewards>(v7);
    }

    public fun destroy_or_transfer_balance<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) == 0) {
            0x2::balance::destroy_zero<T0>(arg0);
            return
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg2), arg1);
    }

    public fun get_anima_chef_info<T0>(arg0: &AnimaChef) : (u64, u64, u64) {
        (arg0.ongoing_season, 0x2::linked_table::length<u64, SeasonRewards>(&arg0.season_alloc), 0x2::dynamic_object_field::borrow<vector<u8>, RewardsHolder<T0>>(&arg0.id, b"ANIMA_REWARDS_HOLDER").total_deposited)
    }

    public fun get_anima_ions_info(arg0: &AnimaIONs) : (u64, 0x1::option::Option<address>, address, u64, u64, u64, u64, u64) {
        (arg0.created_at, arg0.referrer, arg0.owner, arg0.ion_points, arg0.last_active_season, 0x2::linked_table::length<u64, UserSeasonInfo>(&arg0.season_info), arg0.claimable_rewards, arg0.total_claimed_rewards)
    }

    public fun get_referrer(arg0: &AnimaIONs) : 0x1::option::Option<address> {
        arg0.referrer
    }

    public fun get_rewards_holder_info<T0>(arg0: &AnimaChef) : (u64, u64, u64) {
        if (!0x2::dynamic_object_field::exists_<vector<u8>>(&arg0.id, b"ANIMA_REWARDS_HOLDER")) {
            return (0, 0, 0)
        };
        let v0 = 0x2::dynamic_object_field::borrow<vector<u8>, RewardsHolder<T0>>(&arg0.id, b"ANIMA_REWARDS_HOLDER");
        (0x2::balance::value<T0>(&v0.coin_balance), v0.total_deposited, v0.allocated_amount)
    }

    public fun get_season_allocation_info(arg0: &AnimaChef, arg1: u64) : (u64, u64, bool, u64, u64, u256, u64, u64) {
        if (!0x2::linked_table::contains<u64, SeasonRewards>(&arg0.season_alloc, arg1)) {
            return (0, 0, false, 0, 0, 0, 0, 0)
        };
        let v0 = 0x2::linked_table::borrow<u64, SeasonRewards>(&arg0.season_alloc, arg1);
        (v0.start_time, v0.end_time, v0.is_time_based_distribution, v0.rewards_allocated, v0.rewards_distribution_rate, v0.global_claim_index, v0.last_time, v0.total_points)
    }

    public fun get_season_allocations_list(arg0: &AnimaChef, arg1: 0x1::option::Option<u64>, arg2: u64) : (vector<u64>, vector<u64>, vector<u64>, vector<bool>, vector<u64>, vector<u64>, vector<u64>, u64) {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0x1::vector::empty<bool>();
        let v4 = 0x1::vector::empty<u64>();
        let v5 = 0x1::vector::empty<u64>();
        let v6 = 0x1::vector::empty<u64>();
        let v7 = if (0x1::option::is_some<u64>(&arg1)) {
            arg1
        } else {
            *0x2::linked_table::front<u64, SeasonRewards>(&arg0.season_alloc)
        };
        let v8 = v7;
        let v9 = 0;
        while (0x1::option::is_some<u64>(&v8) && v9 < arg2) {
            let v10 = 0x1::option::borrow<u64>(&v8);
            let v11 = 0x2::linked_table::borrow<u64, SeasonRewards>(&arg0.season_alloc, *v10);
            0x1::vector::push_back<u64>(&mut v0, *v10);
            0x1::vector::push_back<u64>(&mut v1, v11.start_time);
            0x1::vector::push_back<u64>(&mut v2, v11.end_time);
            0x1::vector::push_back<bool>(&mut v3, v11.is_time_based_distribution);
            0x1::vector::push_back<u64>(&mut v4, v11.rewards_allocated);
            0x1::vector::push_back<u64>(&mut v5, v11.rewards_distribution_rate);
            0x1::vector::push_back<u64>(&mut v6, v11.total_points);
            v8 = *0x2::linked_table::next<u64, SeasonRewards>(&arg0.season_alloc, *v10);
            v9 = v9 + 1;
        };
        (v0, v1, v2, v3, v4, v5, v6, 0x2::linked_table::length<u64, SeasonRewards>(&arg0.season_alloc))
    }

    public fun get_user_season_info(arg0: &AnimaIONs, arg1: u64) : (u64, u256, u64) {
        if (!0x2::linked_table::contains<u64, UserSeasonInfo>(&arg0.season_info, arg1)) {
            return (0, 0, 0)
        };
        let v0 = 0x2::linked_table::borrow<u64, UserSeasonInfo>(&arg0.season_info, arg1);
        (v0.points_earned, v0.claim_index, v0.claimed_amount)
    }

    public fun get_user_seasons_list(arg0: &AnimaIONs, arg1: 0x1::option::Option<u64>, arg2: u64) : (vector<u64>, vector<u64>, vector<u256>, vector<u64>, u64) {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0x1::vector::empty<u256>();
        let v3 = 0x1::vector::empty<u64>();
        let v4 = if (0x1::option::is_some<u64>(&arg1)) {
            arg1
        } else {
            *0x2::linked_table::front<u64, UserSeasonInfo>(&arg0.season_info)
        };
        let v5 = v4;
        let v6 = 0;
        while (0x1::option::is_some<u64>(&v5) && v6 < arg2) {
            let v7 = 0x1::option::borrow<u64>(&v5);
            let v8 = 0x2::linked_table::borrow<u64, UserSeasonInfo>(&arg0.season_info, *v7);
            0x1::vector::push_back<u64>(&mut v0, *v7);
            0x1::vector::push_back<u64>(&mut v1, v8.points_earned);
            0x1::vector::push_back<u256>(&mut v2, v8.claim_index);
            0x1::vector::push_back<u64>(&mut v3, v8.claimed_amount);
            v5 = *0x2::linked_table::next<u64, UserSeasonInfo>(&arg0.season_info, *v7);
            v6 = v6 + 1;
        };
        (v0, v1, v2, v3, 0x2::linked_table::length<u64, UserSeasonInfo>(&arg0.season_info))
    }

    public fun has_referrer(arg0: &AnimaIONs) : bool {
        0x1::option::is_some<address>(&arg0.referrer)
    }

    fun increment_global_claim_index(arg0: &0x2::clock::Clock, arg1: &mut SeasonRewards) {
        let v0 = 0x2::clock::timestamp_ms(arg0);
        if (arg1.total_points > 0) {
            arg1.global_claim_index = arg1.global_claim_index + 0x8c022f0639b8ff6a46afb6d5adf3f145cfb8b2a6db50790925fc16a54c38c52b::math::mul_div_u256(((v0 - arg1.last_time) as u256), (arg1.rewards_distribution_rate as u256) * (1000000000 as u256), (arg1.total_points as u256));
        };
        arg1.last_time = v0;
    }

    fun increment_user_claim_index(arg0: &SeasonRewards, arg1: &mut UserSeasonInfo) : u64 {
        let v0 = (0x8c022f0639b8ff6a46afb6d5adf3f145cfb8b2a6db50790925fc16a54c38c52b::math::mul_div_u256(arg0.global_claim_index - arg1.claim_index, (arg1.points_earned as u256), (1000000000 as u256)) as u64);
        arg1.claim_index = arg0.global_claim_index;
        arg1.claimed_amount = arg1.claimed_amount + v0;
        v0
    }

    fun init(arg0: IONS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        let v1 = 0x2::package::claim<IONS>(arg0, arg1);
        let v2 = 0x2::display::new<AnimaIONs>(&v1, arg1);
        0x2::display::add<AnimaIONs>(&mut v2, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Anima IONs"));
        0x2::display::add<AnimaIONs>(&mut v2, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"Anima IONs representing your contribution to the Anima Marketplace ecosystem. Earn ION points through trading activities."));
        0x2::display::add<AnimaIONs>(&mut v2, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://anima.xyz/ion-sbt.png"));
        0x2::display::add<AnimaIONs>(&mut v2, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://anima.xyz"));
        0x2::display::add<AnimaIONs>(&mut v2, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"Anima Marketplace"));
        0x2::display::add<AnimaIONs>(&mut v2, 0x1::string::utf8(b"ion_points"), 0x1::string::utf8(b"{ion_points} IONs"));
        0x2::display::add<AnimaIONs>(&mut v2, 0x1::string::utf8(b"referrer"), 0x1::string::utf8(b"Referrer: {referrer}"));
        0x2::display::add<AnimaIONs>(&mut v2, 0x1::string::utf8(b"total_points"), 0x1::string::utf8(b"Total Points: {total_points}"));
        0x2::display::add<AnimaIONs>(&mut v2, 0x1::string::utf8(b"total_claimed_rewards"), 0x1::string::utf8(b"Total Claimed Rewards: {total_claimed_rewards}"));
        0x2::display::update_version<AnimaIONs>(&mut v2);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<AnimaIONs>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun init_anima_chef(arg0: &AdminCap, arg1: &0x2::clock::Clock, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = AnimaChef{
            id             : 0x2::object::new(arg3),
            version        : 0,
            ongoing_season : 0,
            season_alloc   : 0x2::linked_table::new<u64, SeasonRewards>(arg3),
        };
        let v1 = SeasonRewards{
            start_time                 : arg2,
            end_time                   : 0,
            is_time_based_distribution : false,
            rewards_allocated          : 0,
            rewards_distribution_rate  : 0,
            global_claim_index         : 0,
            last_time                  : 0x2::clock::timestamp_ms(arg1),
            total_points               : 0,
        };
        0x2::linked_table::push_back<u64, SeasonRewards>(&mut v0.season_alloc, 0, v1);
        let v2 = AnimaChefInitialized{chef_id: 0x2::object::id<AnimaChef>(&v0)};
        0x2::event::emit<AnimaChefInitialized>(v2);
        0x2::transfer::share_object<AnimaChef>(v0);
    }

    public fun init_new_season<T0>(arg0: &AdminCap, arg1: &mut AnimaChef, arg2: &0x2::clock::Clock, arg3: u64, arg4: u64, arg5: bool, arg6: u64, arg7: u64) {
        validation_check(arg1);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = arg1.ongoing_season + 1;
        let v2 = 0x2::dynamic_object_field::borrow_mut<vector<u8>, RewardsHolder<T0>>(&mut arg1.id, b"ANIMA_REWARDS_HOLDER");
        assert!(0x2::linked_table::borrow<u64, SeasonRewards>(&arg1.season_alloc, arg1.ongoing_season).end_time < v0, 13906835677582262278);
        assert!(arg3 > v0, 13906835690467426314);
        assert!(arg4 > v0 && arg4 > arg3, 13906835694762524684);
        let v3 = SeasonRewards{
            start_time                 : arg3,
            end_time                   : arg4,
            is_time_based_distribution : arg5,
            rewards_allocated          : arg7,
            rewards_distribution_rate  : arg6,
            global_claim_index         : 0,
            last_time                  : v0,
            total_points               : 0,
        };
        0x2::linked_table::push_back<u64, SeasonRewards>(&mut arg1.season_alloc, v1, v3);
        arg1.ongoing_season = v1;
        let v4 = if (arg5) {
            arg6 * (arg4 - arg3)
        } else {
            arg7
        };
        assert!(v2.total_deposited - v2.allocated_amount >= v4, 13906835806431150084);
        v2.allocated_amount = v2.allocated_amount + v4;
        let v5 = SeasonInitialized{
            season_number              : v1,
            start_time                 : arg3,
            end_time                   : arg4,
            rewards_allocated          : arg7,
            rewards_distribution_rate  : arg6,
            is_time_based_distribution : arg5,
        };
        0x2::event::emit<SeasonInitialized>(v5);
    }

    public fun mint_anima_ions(arg0: &0x2::clock::Clock, arg1: &mut AnimaChef, arg2: 0x1::option::Option<address>, arg3: &mut 0x2::tx_context::TxContext) {
        validation_check(arg1);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = arg1.ongoing_season;
        let v2 = if (0x1::option::is_some<address>(&arg2)) {
            assert!(*0x1::option::borrow<address>(&arg2) != v0, 13906836381957685266);
            arg2
        } else {
            0x1::option::none<address>()
        };
        let v3 = AnimaIONs{
            id                    : 0x2::object::new(arg3),
            created_at            : 0x2::clock::timestamp_ms(arg0),
            referrer              : v2,
            owner                 : v0,
            ion_points            : 0,
            last_active_season    : v1,
            season_info           : 0x2::linked_table::new<u64, UserSeasonInfo>(arg3),
            claimable_rewards     : 0,
            total_claimed_rewards : 0,
        };
        let v4 = UserSeasonInfo{
            points_earned  : 0,
            claim_index    : 0x2::linked_table::borrow<u64, SeasonRewards>(&arg1.season_alloc, v1).global_claim_index,
            claimed_amount : 0,
        };
        0x2::linked_table::push_back<u64, UserSeasonInfo>(&mut v3.season_info, v1, v4);
        let v5 = AnimaIONsMinted{
            anima_ions_id : 0x2::object::id<AnimaIONs>(&v3),
            owner         : v0,
            referrer      : v3.referrer,
            timestamp     : 0x2::clock::timestamp_ms(arg0),
            cur_season    : v1,
        };
        0x2::event::emit<AnimaIONsMinted>(v5);
        0x2::transfer::transfer<AnimaIONs>(v3, v0);
    }

    public fun mint_points_admin_cap(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = PointsAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<PointsAdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    fun settle_last_active_season(arg0: &AnimaChef, arg1: &mut AnimaIONs) {
        let v0 = arg0.ongoing_season;
        let v1 = arg1.last_active_season;
        if (v0 > 0 && v0 > v1) {
            let v2 = 0x2::linked_table::borrow<u64, SeasonRewards>(&arg0.season_alloc, v1);
            let v3 = 0x2::linked_table::borrow_mut<u64, UserSeasonInfo>(&mut arg1.season_info, v1);
            let v4 = if (!v2.is_time_based_distribution) {
                if (v2.total_points > 0) {
                    (0x8c022f0639b8ff6a46afb6d5adf3f145cfb8b2a6db50790925fc16a54c38c52b::math::mul_div_u256((v3.points_earned as u256), (v2.rewards_allocated as u256), (v2.total_points as u256)) as u64)
                } else {
                    0
                }
            } else {
                v3.claim_index = v2.global_claim_index;
                (0x8c022f0639b8ff6a46afb6d5adf3f145cfb8b2a6db50790925fc16a54c38c52b::math::mul_div_u256(v2.global_claim_index - v3.claim_index, (v3.points_earned as u256), (1000000000 as u256)) as u64)
            };
            v3.claimed_amount = v3.claimed_amount + v4;
            arg1.claimable_rewards = arg1.claimable_rewards + v4;
            arg1.ion_points = arg1.ion_points - v3.points_earned;
            arg1.last_active_season = v0;
            let v5 = UserSeasonInfo{
                points_earned  : 0,
                claim_index    : 0x2::linked_table::borrow<u64, SeasonRewards>(&arg0.season_alloc, v0).global_claim_index,
                claimed_amount : 0,
            };
            0x2::linked_table::push_back<u64, UserSeasonInfo>(&mut arg1.season_info, v0, v5);
        };
    }

    public fun simulate_claimable_rewards(arg0: &0x2::clock::Clock, arg1: &AnimaChef, arg2: &AnimaIONs) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg0);
        let v1 = arg1.ongoing_season;
        let v2 = arg2.last_active_season;
        let v3 = arg2.claimable_rewards;
        let v4 = v3;
        if (v1 > 0 && v1 > v2) {
            let v5 = 0x2::linked_table::borrow<u64, SeasonRewards>(&arg1.season_alloc, v2);
            if (0x2::linked_table::contains<u64, UserSeasonInfo>(&arg2.season_info, v2)) {
                let v6 = 0x2::linked_table::borrow<u64, UserSeasonInfo>(&arg2.season_info, v2);
                if (!v5.is_time_based_distribution) {
                    if (v5.total_points > 0) {
                        v4 = v3 + (0x8c022f0639b8ff6a46afb6d5adf3f145cfb8b2a6db50790925fc16a54c38c52b::math::mul_div_u256((v6.points_earned as u256), (v5.rewards_allocated as u256), (v5.total_points as u256)) as u64) - v6.claimed_amount;
                    };
                } else {
                    v4 = v3 + (0x8c022f0639b8ff6a46afb6d5adf3f145cfb8b2a6db50790925fc16a54c38c52b::math::mul_div_u256(v5.global_claim_index - v6.claim_index, (v6.points_earned as u256), (1000000000 as u256)) as u64);
                };
            };
        };
        if (0x2::linked_table::contains<u64, SeasonRewards>(&arg1.season_alloc, v1) && 0x2::linked_table::contains<u64, UserSeasonInfo>(&arg2.season_info, v1)) {
            let v7 = 0x2::linked_table::borrow<u64, SeasonRewards>(&arg1.season_alloc, v1);
            let v8 = 0x2::linked_table::borrow<u64, UserSeasonInfo>(&arg2.season_info, v1);
            let v9 = v7.end_time == 0 && false || v7.end_time < v0;
            if (!v9 && !(v7.start_time > v0)) {
                if (v7.is_time_based_distribution && v7.total_points > 0) {
                    v4 = v4 + (0x8c022f0639b8ff6a46afb6d5adf3f145cfb8b2a6db50790925fc16a54c38c52b::math::mul_div_u256(v7.global_claim_index + 0x8c022f0639b8ff6a46afb6d5adf3f145cfb8b2a6db50790925fc16a54c38c52b::math::mul_div_u256(((v0 - v7.last_time) as u256), (((v7.rewards_distribution_rate as u256) * 1000000000) as u256), (v7.total_points as u256)) - v8.claim_index, (v8.points_earned as u256), (1000000000 as u256)) as u64);
                };
            };
        };
        v4
    }

    public fun update_module_version(arg0: &mut AnimaChef) {
        assert!(arg0.version < 0, 13906835102057299984);
        arg0.version = 0;
    }

    public fun update_ongoing_season_rewards<T0>(arg0: &AdminCap, arg1: &mut AnimaChef, arg2: &0x2::clock::Clock, arg3: u64, arg4: u64) {
        validation_check(arg1);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0x2::linked_table::borrow_mut<u64, SeasonRewards>(&mut arg1.season_alloc, arg1.ongoing_season);
        assert!(v1.end_time > v0, 13906836064129449992);
        assert!(0x2::dynamic_object_field::exists_<vector<u8>>(&arg1.id, b"ANIMA_REWARDS_HOLDER"), 13906836077014745102);
        let v2 = 0x2::dynamic_object_field::borrow_mut<vector<u8>, RewardsHolder<T0>>(&mut arg1.id, b"ANIMA_REWARDS_HOLDER");
        let v3 = 0;
        let v4 = false;
        if (v1.is_time_based_distribution) {
            if (arg3 > 0) {
                increment_global_claim_index(arg2, v1);
                let v5 = arg3 * (v0 - v1.last_time);
                let v6 = v1.rewards_distribution_rate * (v0 - v1.last_time);
                if (v5 > v6) {
                    v4 = true;
                    v3 = v5 - v6;
                };
                v1.rewards_distribution_rate = arg3;
            };
        } else if (arg4 > 0) {
            if (arg4 > v1.rewards_allocated) {
                v4 = true;
                v3 = arg4 - v1.rewards_allocated;
            };
            v1.rewards_allocated = arg4;
        };
        if (v4) {
            assert!(v2.total_deposited - v2.allocated_amount >= v3, 13906836248812781572);
            v2.allocated_amount = v2.allocated_amount + v3;
        };
        let v7 = SeasonRewardsUpdated{
            season_number             : arg1.ongoing_season,
            rewards_distribution_rate : v1.rewards_distribution_rate,
            rewards_allocated         : v1.rewards_allocated,
        };
        0x2::event::emit<SeasonRewardsUpdated>(v7);
    }

    public fun update_ongoing_season_time(arg0: &AdminCap, arg1: &mut AnimaChef, arg2: &0x2::clock::Clock, arg3: u64, arg4: u64) {
        validation_check(arg1);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0x2::linked_table::borrow_mut<u64, SeasonRewards>(&mut arg1.season_alloc, arg1.ongoing_season);
        if (arg3 > 0) {
            assert!(v1.start_time > v0 && arg3 > v0, 13906835926690627594);
            v1.start_time = arg3;
        };
        if (arg4 > 0) {
            if (v1.end_time == 0) {
                assert!(arg4 > v0, 13906835965345464332);
            } else {
                assert!(v1.end_time > v0 && arg4 > v0, 13906835978230366220);
            };
            v1.end_time = arg4;
        };
        let v2 = SeasonConfigUpdated{
            season_number : arg1.ongoing_season,
            start_time    : v1.start_time,
            end_time      : v1.end_time,
        };
        0x2::event::emit<SeasonConfigUpdated>(v2);
    }

    public fun validation_check(arg0: &mut AnimaChef) {
        assert!(arg0.version == 0, 13906837438519509008);
    }

    // decompiled from Move bytecode v6
}

