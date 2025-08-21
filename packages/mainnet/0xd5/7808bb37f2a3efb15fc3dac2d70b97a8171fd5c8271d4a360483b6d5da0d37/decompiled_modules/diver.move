module 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::diver {
    struct Diver has store, key {
        id: 0x2::object::UID,
        level: u64,
        rarity: u8,
        total_dive_times: u64,
        total_fishes_obtained: u64,
        nitrogen_saturation: u64,
        nitrogen_decay_base_time: u64,
        dividend_state: DiverDividendState,
        name: 0x1::option::Option<0x1::string::String>,
        nationality: u8,
    }

    struct DivingTank has key {
        id: 0x2::object::UID,
    }

    struct DiverDividendState has store {
        last_claimed_epoch: u64,
    }

    struct WhitelistRegistry has key {
        id: 0x2::object::UID,
        whitelist: 0x2::table::Table<address, u64>,
        total_allocated: u64,
    }

    struct DiverRecruitEvent has copy, drop {
        diver_id: 0x2::object::ID,
        rarity: u8,
        phase: u8,
    }

    struct DiverClaimDividendEvent has copy, drop {
        diver_id: 0x2::object::ID,
        epoch: u64,
        dive_token_amount: u64,
    }

    entry fun batch_recruit(arg0: &0x2::random::Random, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u8, arg3: u64, arg4: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::GlobalState, arg5: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::user::User, arg6: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::leaderboard::GlobalLeaderboard, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::utils::assert_valid_version(arg4);
        assert!(arg3 + 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::global_state_diver_total_recruit(arg4) <= 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::config::total_divers_supply(), 17);
        assert!(arg3 > 0, 7);
        assert!(arg3 <= 100, 3);
        assert!(arg2 == 1 || arg2 == 2, 8);
        let v0 = if (arg2 == 1) {
            0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::config::phase_1_divers_supply()
        } else {
            0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::config::phase_2_divers_supply()
        };
        let v1 = if (arg2 == 1) {
            0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::field_index_diver_recruit_stats_phase_1()
        } else {
            0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::field_index_diver_recruit_stats_phase_2()
        };
        assert!(arg3 + 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::get_global_state_diver_recruit_stats(arg4, v1) <= v0, 9);
        let v2 = if (arg2 == 1) {
            0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::config::recruit_cost_in_sui_phase_1() * arg3
        } else {
            0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::config::recruit_cost_in_sui_phase_2() * arg3
        };
        let v3 = v2;
        let v4 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(&v4 == &v3, 2);
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::allocate_to_treasure_pool(arg4, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::config::recruit_treasure_pool_distribution_amount() * arg3, arg8)));
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::allocate_to_liquidity_pool_treasury(arg4, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::config::recruit_liquidity_pool_distribution_amount() * arg3, arg8)));
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::allocate_to_divers_treasury(arg4, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v5 = 0x2::random::new_generator(arg0, arg8);
        let v6 = 0;
        while (v6 < arg3) {
            let v7 = 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::utils::generate_rarity(&mut v5);
            0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::update_global_state_divers_rarity_distribution(arg4, v7, true);
            let v8 = 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::user::user_inviter(arg5);
            if (0x1::option::is_some<address>(&v8)) {
                let v9 = mint_diving_tank(arg8);
                0x2::transfer::transfer<DivingTank>(v9, *0x1::option::borrow<address>(&v8));
                let v10 = mint_diving_tank(arg8);
                0x2::transfer::transfer<DivingTank>(v10, 0x2::tx_context::sender(arg8));
            };
            mint_diving_tank_for_purchase_diver(arg8);
            let v11 = DiverDividendState{last_claimed_epoch: 0};
            let v12 = Diver{
                id                       : 0x2::object::new(arg8),
                level                    : 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::config::diver_min_level(),
                rarity                   : v7,
                total_dive_times         : 0,
                total_fishes_obtained    : 0,
                nitrogen_saturation      : 0,
                nitrogen_decay_base_time : 0x2::clock::timestamp_ms(arg7),
                dividend_state           : v11,
                name                     : 0x1::option::none<0x1::string::String>(),
                nationality              : 0,
            };
            0x2::transfer::public_transfer<Diver>(v12, 0x2::tx_context::sender(arg8));
            let v13 = DiverRecruitEvent{
                diver_id : 0x2::object::id<Diver>(&v12),
                rarity   : v7,
                phase    : arg2,
            };
            0x2::event::emit<DiverRecruitEvent>(v13);
            v6 = v6 + 1;
        };
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::user::purchase_divers(arg5, arg6, arg3);
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::increment_diver_nationality_distribution(arg4, 0, arg3);
        let v14 = if (arg2 == 1) {
            0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::field_index_diver_recruit_stats_phase_1()
        } else {
            0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::field_index_diver_recruit_stats_phase_2()
        };
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::update_global_state_diver_recruit_stats(arg4, v14, arg3);
    }

    public fun check_user_whitelist_amount(arg0: &WhitelistRegistry, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.whitelist, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.whitelist, arg1)
        } else {
            0
        }
    }

    public fun claim_dividend_for_diver(arg0: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::dividend_pool::DividendPool, arg1: &mut Diver, arg2: &0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::GlobalState, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::dive_token::DIVE_TOKEN> {
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::utils::assert_valid_version(arg2);
        assert!(0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::dividend_pool::is_dividend_pool_active(arg0), 20);
        let v0 = 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::dividend_pool::dividend_pool_current_epoch(arg0);
        assert!(v0 > 0, 11);
        let v1 = v0 - 1;
        assert!(0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::dividend_pool::is_current_epoch_claimable(arg0, v1), 13);
        if (v1 > 0) {
            assert!(diver_dividend_last_claimed_epoch(arg1) < v1, 12);
        };
        update_diver_dividend_last_claimed_epoch(arg1, v1);
        let v2 = 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::dividend_pool::distribute_dive_token(arg0, v1, arg3);
        let v3 = DiverClaimDividendEvent{
            diver_id          : 0x2::object::id<Diver>(arg1),
            epoch             : v1,
            dive_token_amount : 0x2::coin::value<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::dive_token::DIVE_TOKEN>(&v2),
        };
        0x2::event::emit<DiverClaimDividendEvent>(v3);
        v2
    }

    public fun diver_dividend_last_claimed_epoch(arg0: &Diver) : u64 {
        arg0.dividend_state.last_claimed_epoch
    }

    public fun diver_level(arg0: &Diver) : u64 {
        arg0.level
    }

    public fun diver_nitrogen_saturation(arg0: &Diver) : u64 {
        arg0.nitrogen_saturation
    }

    public fun diver_rarity(arg0: &Diver) : u8 {
        arg0.rarity
    }

    public(friend) fun downgrade_diver(arg0: &mut Diver, arg1: u64) {
        assert!(arg0.level - arg1 >= 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::config::diver_min_level(), 1);
        arg0.level = arg0.level - arg1;
    }

    public fun gen_diver_props(arg0: &Diver, arg1: vector<u64>) : vector<u64> {
        let v0 = vector[];
        let v1 = 0;
        let v2 = 0x2::object::id_bytes<Diver>(arg0);
        while (v1 < 16) {
            0x1::vector::push_back<u64>(&mut v0, 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::utils::generate_uniform_random(&v2, v1, *0x1::vector::borrow<u64>(&arg1, v1)));
            v1 = v1 + 1;
        };
        v0
    }

    public(friend) fun get_training_cost_growth_rate_by_rarity(arg0: u8) : u64 {
        assert!(arg0 <= 4, 19);
        let v0 = 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::config::training_cost_growth_rate();
        *0x1::vector::borrow<u64>(&v0, (arg0 as u64))
    }

    public(friend) fun increase_nitrogen(arg0: &mut Diver, arg1: &0x2::clock::Clock) {
        assert!(arg0.nitrogen_saturation < 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::config::max_nitrogen_saturation(), 18);
        if (arg0.nitrogen_saturation == 0) {
            arg0.nitrogen_decay_base_time = 0x2::clock::timestamp_ms(arg1);
        };
        arg0.nitrogen_saturation = arg0.nitrogen_saturation + 1;
    }

    public(friend) fun increase_total_dive_times(arg0: &mut Diver, arg1: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::leaderboard::GlobalLeaderboard) {
        arg0.total_dive_times = arg0.total_dive_times + 1;
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::leaderboard::update_leaderboard_with_limit(arg1, 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::leaderboard::get_enum_divers_dive_times(), arg0.total_dive_times, arg0.total_dive_times, 0x2::object::id<Diver>(arg0));
    }

    public(friend) fun increase_total_fishes_obtained(arg0: &mut Diver, arg1: u64) {
        arg0.total_fishes_obtained = arg0.total_fishes_obtained + arg1;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = WhitelistRegistry{
            id              : 0x2::object::new(arg0),
            whitelist       : 0x2::table::new<address, u64>(arg0),
            total_allocated : 0,
        };
        0x2::transfer::share_object<WhitelistRegistry>(v0);
    }

    public(friend) fun mint_diving_tank(arg0: &mut 0x2::tx_context::TxContext) : DivingTank {
        DivingTank{id: 0x2::object::new(arg0)}
    }

    public(friend) fun mint_diving_tank_for_fish_encyclopedia_reward(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < arg0) {
            let v1 = mint_diving_tank(arg1);
            0x2::transfer::transfer<DivingTank>(v1, 0x2::tx_context::sender(arg1));
            v0 = v0 + 1;
        };
    }

    public(friend) fun mint_diving_tank_for_purchase_diver(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = mint_diving_tank(arg0);
        0x2::transfer::transfer<DivingTank>(v0, 0x2::tx_context::sender(arg0));
    }

    public(friend) fun mint_diving_tank_for_reef_plant_diver(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 > 0 && arg0 <= 2, 7);
        let v0 = 0;
        while (v0 < arg0) {
            let v1 = mint_diving_tank(arg1);
            0x2::transfer::transfer<DivingTank>(v1, 0x2::tx_context::sender(arg1));
            v0 = v0 + 1;
        };
    }

    public fun remove_whitelist(arg0: address, arg1: u64, arg2: &0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::GlobalState, arg3: &0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::GlobalAdminCap, arg4: &mut WhitelistRegistry) {
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::utils::assert_valid_version(arg2);
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::check_is_admin(arg2, arg3);
        let v0 = 0x2::table::contains<address, u64>(&arg4.whitelist, arg0);
        assert!(v0, 22);
        if (v0) {
            let v1 = 0x2::table::borrow_mut<address, u64>(&mut arg4.whitelist, arg0);
            assert!(*v1 >= arg1, 7);
            *v1 = *v1 - arg1;
        };
        arg4.total_allocated = arg4.total_allocated - arg1;
    }

    public fun set_whitelist_registry(arg0: address, arg1: u64, arg2: &0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::GlobalState, arg3: &0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::GlobalAdminCap, arg4: &mut WhitelistRegistry) {
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::utils::assert_valid_version(arg2);
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::check_is_admin(arg2, arg3);
        assert!(arg1 > 0 && arg1 <= 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::config::whitelist_divers_supply(), 7);
        assert!(arg4.total_allocated + arg1 <= 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::config::whitelist_divers_supply(), 5);
        if (0x2::table::contains<address, u64>(&arg4.whitelist, arg0)) {
            let v0 = 0x2::table::borrow_mut<address, u64>(&mut arg4.whitelist, arg0);
            *v0 = *v0 + arg1;
        } else {
            0x2::table::add<address, u64>(&mut arg4.whitelist, arg0, arg1);
        };
        arg4.total_allocated = arg4.total_allocated + arg1;
    }

    public(friend) fun update_diver_dividend_last_claimed_epoch(arg0: &mut Diver, arg1: u64) {
        arg0.dividend_state.last_claimed_epoch = arg1;
    }

    entry fun update_diver_name(arg0: &mut Diver, arg1: 0x2::coin::Coin<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::dive_token::DIVE_TOKEN>, arg2: 0x1::option::Option<0x1::string::String>, arg3: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::user::User, arg4: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::GlobalState, arg5: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::dive_token::DIVETokenTreasuryCap, arg6: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::dividend_pool::DividendPool, arg7: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::leaderboard::GlobalLeaderboard, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::utils::assert_valid_version(arg4);
        assert!(0x1::option::is_some<0x1::string::String>(&arg2), 14);
        let v0 = 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::config::update_name_cost_in_dive_token();
        assert!(0x2::coin::value<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::dive_token::DIVE_TOKEN>(&arg1) == v0, 10);
        assert!(0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::utils::is_valid_diver_name(0x1::option::borrow<0x1::string::String>(&arg2)), 14);
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::dividend_pool::burn_and_add_to_dividend_pool(arg6, arg1, arg5, arg4, 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::field_index_total_dive_token_burned_edit_diver_name(), arg8, arg9);
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::user::add_dive_token_burned(arg3, v0, arg7);
        arg0.name = arg2;
    }

    entry fun update_diver_nationality(arg0: &mut Diver, arg1: 0x2::coin::Coin<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::dive_token::DIVE_TOKEN>, arg2: u8, arg3: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::user::User, arg4: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::GlobalState, arg5: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::dive_token::DIVETokenTreasuryCap, arg6: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::dividend_pool::DividendPool, arg7: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::leaderboard::GlobalLeaderboard, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::utils::assert_valid_version(arg4);
        assert!(arg2 != arg0.nationality, 15);
        assert!(arg2 >= 1 && arg2 <= 249, 15);
        let v0 = 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::config::update_nationality_cost_in_dive_token();
        assert!(0x2::coin::value<0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::dive_token::DIVE_TOKEN>(&arg1) == v0, 10);
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::dividend_pool::burn_and_add_to_dividend_pool(arg6, arg1, arg5, arg4, 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::field_index_total_dive_token_burned_edit_diver_nationality(), arg8, arg9);
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::user::add_dive_token_burned(arg3, v0, arg7);
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::update_global_state_diver_nationality_distribution(arg4, arg0.nationality, arg2);
        arg0.nationality = arg2;
    }

    public(friend) fun update_nitrogen(arg0: &mut Diver, arg1: &0x2::clock::Clock) {
        if (arg0.nitrogen_saturation == 0) {
            return
        };
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 >= arg0.nitrogen_decay_base_time, 16);
        let v1 = (v0 - arg0.nitrogen_decay_base_time) / 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::config::nitrogen_decay_period_ms();
        if (v1 > 0) {
            arg0.nitrogen_decay_base_time = arg0.nitrogen_decay_base_time + v1 * 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::config::nitrogen_decay_period_ms();
            if (arg0.nitrogen_saturation <= v1) {
                arg0.nitrogen_saturation = 0;
            } else {
                arg0.nitrogen_saturation = arg0.nitrogen_saturation - v1;
            };
        };
    }

    public(friend) fun upgrade_diver(arg0: &mut Diver, arg1: u64) {
        assert!(arg0.level + arg1 <= 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::config::diver_max_level(), 0);
        arg0.level = arg0.level + arg1;
    }

    public(friend) fun use_diving_tank(arg0: DivingTank) {
        let DivingTank { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    entry fun whitelist_batch_recruit(arg0: &0x2::random::Random, arg1: u64, arg2: &mut 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::GlobalState, arg3: &mut WhitelistRegistry, arg4: &0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::user::User, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::utils::assert_valid_version(arg2);
        assert!(0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::user::user_address(arg4) == 0x2::tx_context::sender(arg6), 21);
        assert!(arg1 > 0, 7);
        assert!(arg1 + 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::global_state_diver_total_recruit(arg2) <= 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::config::total_divers_supply(), 17);
        assert!(arg1 <= 100, 3);
        assert!(arg1 + 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::get_global_state_diver_recruit_stats(arg2, 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::field_index_diver_recruit_stats_whitelist()) <= 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::config::whitelist_divers_supply(), 5);
        assert!(0x2::table::contains<address, u64>(&arg3.whitelist, 0x2::tx_context::sender(arg6)), 6);
        let v0 = 0x2::table::borrow_mut<address, u64>(&mut arg3.whitelist, 0x2::tx_context::sender(arg6));
        assert!(arg1 <= *v0, 4);
        let v1 = 0x2::random::new_generator(arg0, arg6);
        let v2 = 0;
        while (v2 < arg1) {
            let v3 = 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::utils::generate_rarity(&mut v1);
            0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::update_global_state_divers_rarity_distribution(arg2, v3, true);
            mint_diving_tank_for_purchase_diver(arg6);
            let v4 = DiverDividendState{last_claimed_epoch: 0};
            let v5 = Diver{
                id                       : 0x2::object::new(arg6),
                level                    : 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::config::diver_min_level(),
                rarity                   : v3,
                total_dive_times         : 0,
                total_fishes_obtained    : 0,
                nitrogen_saturation      : 0,
                nitrogen_decay_base_time : 0x2::clock::timestamp_ms(arg5),
                dividend_state           : v4,
                name                     : 0x1::option::none<0x1::string::String>(),
                nationality              : 0,
            };
            0x2::transfer::public_transfer<Diver>(v5, 0x2::tx_context::sender(arg6));
            let v6 = DiverRecruitEvent{
                diver_id : 0x2::object::id<Diver>(&v5),
                rarity   : v3,
                phase    : 0,
            };
            0x2::event::emit<DiverRecruitEvent>(v6);
            v2 = v2 + 1;
        };
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::increment_diver_nationality_distribution(arg2, 0, arg1);
        *v0 = *v0 - arg1;
        0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::update_global_state_diver_recruit_stats(arg2, 0x9bd711b9067f57b07743de2d1f67fd2be75a2e03370ea256f07b5c0ed88016cc::global::field_index_diver_recruit_stats_whitelist(), arg1);
    }

    // decompiled from Move bytecode v6
}

