module 0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::iplayer {
    struct GangstersSummary has store {
        total_capacity: u64,
        current_gangster_count: u64,
        gangster_types: 0x2::vec_map::VecMap<0x1::string::String, u64>,
        recruit_count: u64,
    }

    struct PenaltyReceipt {
        total_to_pay: u64,
        total_paid: u64,
        skip: bool,
    }

    struct Player has key {
        id: 0x2::object::UID,
        dvd_id: 0x2::object::ID,
        image_blob: 0x1::string::String,
        player_address: address,
        player_name: 0x1::string::String,
        headquarter_tile: 0x2::object::ID,
        owned_location: vector<0x2::object::ID>,
        is_inactive: bool,
        created_ts: u64,
        perks: 0x2::vec_map::VecMap<0x1::string::String, u64>,
        timers: 0x2::vec_map::VecMap<0x1::string::String, u64>,
        gangsters: GangstersSummary,
        attack: 0x2::object::ID,
        blackmail: 0x2::object::ID,
        player_report: 0x2::object::ID,
        swap_points: 0x2::object::ID,
        daily_steaks: 0x2::object::ID,
        mission_info: 0x2::object::ID,
    }

    struct InitialPlayerResources has store {
        cash: u64,
        weapon: u64,
        scouts: u64,
        headquarter_garrison_limit: u64,
        initial_recruits: u64,
    }

    struct PlayersRegistry has store, key {
        id: 0x2::object::UID,
        newbie_protection_duration: u64,
        players: 0x2::table_vec::TableVec<0x2::object::ID>,
        initial_resources: InitialPlayerResources,
    }

    struct FeedRegistry has key {
        id: 0x2::object::UID,
        feed_interval_days_ms: u64,
        base_v_cost: u64,
        cash_scaling_factor: u64,
        cash_scaling_divisor: u64,
        base_recruit_cost: u64,
        operation_scaling: u128,
        gang_size_scaling: u64,
        max_cost_multiplier: u64,
        xp_per_recruit: u64,
        loyalty_decay_rate: u64,
    }

    public(friend) fun new(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x2::object::ID, arg4: vector<0x2::object::ID>, arg5: u64, arg6: 0x2::object::ID, arg7: 0x2::object::ID, arg8: 0x2::object::ID, arg9: 0x2::object::ID, arg10: 0x2::object::ID, arg11: 0x2::object::ID, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : Player {
        let v0 = GangstersSummary{
            total_capacity         : arg5,
            current_gangster_count : 0,
            gangster_types         : 0x2::vec_map::empty<0x1::string::String, u64>(),
            recruit_count          : 5,
        };
        Player{
            id               : 0x2::object::new(arg13),
            dvd_id           : arg0,
            image_blob       : arg1,
            player_address   : 0x2::tx_context::sender(arg13),
            player_name      : arg2,
            headquarter_tile : arg3,
            owned_location   : arg4,
            is_inactive      : false,
            created_ts       : 0x2::clock::timestamp_ms(arg12),
            perks            : 0x2::vec_map::empty<0x1::string::String, u64>(),
            timers           : 0x2::vec_map::empty<0x1::string::String, u64>(),
            gangsters        : v0,
            attack           : arg6,
            blackmail        : arg7,
            player_report    : arg10,
            swap_points      : arg8,
            daily_steaks     : arg11,
            mission_info     : arg9,
        }
    }

    public(friend) fun add_gangster_in_summary(arg0: &mut Player, arg1: 0x1::string::String, arg2: u64) {
        if (!gangster_type_exists(arg0, arg1)) {
            0x2::vec_map::insert<0x1::string::String, u64>(&mut arg0.gangsters.gangster_types, arg1, arg2);
        } else {
            let v0 = 0x2::vec_map::get_mut<0x1::string::String, u64>(&mut arg0.gangsters.gangster_types, &arg1);
            *v0 = *v0 + arg2;
        };
        arg0.gangsters.current_gangster_count = arg0.gangsters.current_gangster_count + arg2;
    }

    public(friend) fun add_new_perk_type(arg0: &mut Player, arg1: 0x1::string::String, arg2: u64) {
        0x2::vec_map::insert<0x1::string::String, u64>(&mut arg0.perks, arg1, arg2);
    }

    public(friend) fun add_player_df<T0: store>(arg0: &mut Player, arg1: 0x1::string::String, arg2: T0) {
        0x2::dynamic_field::add<0x1::string::String, T0>(&mut arg0.id, arg1, arg2);
    }

    public fun borrow_feed_registry_values(arg0: &FeedRegistry) : vector<u64> {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = &mut v0;
        0x1::vector::push_back<u64>(v1, arg0.cash_scaling_factor);
        0x1::vector::push_back<u64>(v1, arg0.cash_scaling_divisor);
        0x1::vector::push_back<u64>(v1, arg0.feed_interval_days_ms);
        0x1::vector::push_back<u64>(v1, arg0.base_v_cost);
        0x1::vector::push_back<u64>(v1, arg0.gang_size_scaling);
        0x1::vector::push_back<u64>(v1, arg0.base_recruit_cost);
        v0
    }

    public(friend) fun borrow_gangster_capacity(arg0: &Player) : u64 {
        arg0.gangsters.total_capacity
    }

    public(friend) fun borrow_gangster_current_count(arg0: &Player) : u64 {
        arg0.gangsters.current_gangster_count
    }

    public fun borrow_initial_cash(arg0: &PlayersRegistry) : u128 {
        (arg0.initial_resources.cash as u128)
    }

    public fun borrow_initial_hq_garrison_limit(arg0: &PlayersRegistry) : u64 {
        arg0.initial_resources.headquarter_garrison_limit
    }

    public fun borrow_initial_scouts(arg0: &PlayersRegistry) : u64 {
        arg0.initial_resources.scouts
    }

    public fun borrow_initial_weapon(arg0: &PlayersRegistry) : u128 {
        (arg0.initial_resources.weapon as u128)
    }

    public fun borrow_mission_info(arg0: &Player) : 0x2::object::ID {
        arg0.mission_info
    }

    public(friend) fun borrow_mut_player_df<T0: store>(arg0: &mut Player, arg1: 0x1::string::String) : &mut T0 {
        0x2::dynamic_field::borrow_mut<0x1::string::String, T0>(&mut arg0.id, arg1)
    }

    public fun borrow_mut_player_owned_location(arg0: &mut Player) : &mut vector<0x2::object::ID> {
        &mut arg0.owned_location
    }

    public fun borrow_mut_player_perks(arg0: &mut Player) : &mut 0x2::vec_map::VecMap<0x1::string::String, u64> {
        &mut arg0.perks
    }

    public fun borrow_mut_player_timers(arg0: &mut Player) : &mut 0x2::vec_map::VecMap<0x1::string::String, u64> {
        &mut arg0.timers
    }

    public fun borrow_newbie_protection_duration(arg0: &PlayersRegistry) : u64 {
        arg0.newbie_protection_duration
    }

    public fun borrow_operation_scaling(arg0: &FeedRegistry) : u128 {
        arg0.operation_scaling
    }

    public fun borrow_player_attack_stats(arg0: &Player) : 0x2::object::ID {
        arg0.attack
    }

    public fun borrow_player_battle_stats_id(arg0: &Player) : 0x2::object::ID {
        arg0.attack
    }

    public(friend) fun borrow_player_blackmail(arg0: &Player) : 0x2::object::ID {
        arg0.blackmail
    }

    public fun borrow_player_daily_checkin_id(arg0: &Player) : 0x2::object::ID {
        arg0.daily_steaks
    }

    public(friend) fun borrow_player_df<T0: store>(arg0: &Player, arg1: 0x1::string::String) : &T0 {
        0x2::dynamic_field::borrow<0x1::string::String, T0>(&arg0.id, arg1)
    }

    public fun borrow_player_dvd_id(arg0: &Player) : 0x2::object::ID {
        arg0.dvd_id
    }

    public fun borrow_player_headquarter(arg0: &Player) : 0x2::object::ID {
        arg0.headquarter_tile
    }

    public(friend) fun borrow_player_id(arg0: &PlayersRegistry, arg1: u64) : 0x2::object::ID {
        *0x2::table_vec::borrow<0x2::object::ID>(&arg0.players, arg1)
    }

    public fun borrow_player_name(arg0: &Player) : 0x1::string::String {
        arg0.player_name
    }

    public fun borrow_player_owned_location(arg0: &Player) : vector<0x2::object::ID> {
        arg0.owned_location
    }

    public fun borrow_player_perks(arg0: &Player) : &0x2::vec_map::VecMap<0x1::string::String, u64> {
        &arg0.perks
    }

    public fun borrow_player_status(arg0: &Player) : bool {
        arg0.is_inactive
    }

    public fun borrow_player_timers(arg0: &Player) : &0x2::vec_map::VecMap<0x1::string::String, u64> {
        &arg0.timers
    }

    public(friend) fun borrow_player_weekly_report(arg0: &Player) : 0x2::object::ID {
        arg0.player_report
    }

    public fun borrow_recruit_count(arg0: &Player) : u64 {
        arg0.gangsters.recruit_count
    }

    public fun borrow_total_owned_turf_count(arg0: &Player) : u64 {
        0x1::vector::length<0x2::object::ID>(&arg0.owned_location)
    }

    public(friend) fun borrow_total_paid(arg0: &PenaltyReceipt) : u64 {
        arg0.total_paid
    }

    public(friend) fun borrow_total_to_pay(arg0: &PenaltyReceipt) : u64 {
        arg0.total_to_pay
    }

    public(friend) fun can_assign_headquarter(arg0: &Player) : bool {
        if (arg0.headquarter_tile == 0x2::object::id_from_address(@0x0)) {
            true
        } else if (arg0.headquarter_tile == 0x2::object::id_from_address(@0x1)) {
            true
        } else {
            arg0.headquarter_tile == 0x2::object::id_from_address(@0x2)
        }
    }

    public(friend) fun can_skip(arg0: &PenaltyReceipt) : bool {
        arg0.skip
    }

    public(friend) fun check_key_exist_accolade(arg0: &Player, arg1: 0x1::string::String) : bool {
        let (v0, _) = 0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::iaccolades::get_accolade(0x2::dynamic_field::borrow<0x1::string::String, 0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::iaccolades::Accolade>(&arg0.id, 0x1::string::utf8(b"accolade")));
        0x2::vec_map::contains<0x1::string::String, u128>(v0, &arg1)
    }

    public(friend) fun consume_receipt(arg0: PenaltyReceipt) {
        let PenaltyReceipt {
            total_to_pay : _,
            total_paid   : _,
            skip         : _,
        } = arg0;
    }

    public(friend) fun decrease_gangster_capacity(arg0: &mut Player, arg1: u64) {
        arg0.gangsters.total_capacity = arg0.gangsters.total_capacity - arg1;
    }

    public(friend) fun decrease_recruit_count(arg0: &mut Player, arg1: u64) {
        arg0.gangsters.recruit_count = arg0.gangsters.recruit_count - arg1;
    }

    public fun gangster_type_exists(arg0: &Player, arg1: 0x1::string::String) : bool {
        0x2::vec_map::contains<0x1::string::String, u64>(&arg0.gangsters.gangster_types, &arg1)
    }

    public(friend) fun generate_penalty_receipt(arg0: u64, arg1: bool) : PenaltyReceipt {
        PenaltyReceipt{
            total_to_pay : arg0,
            total_paid   : 0,
            skip         : arg1,
        }
    }

    public(friend) fun get_accolade_value(arg0: &Player, arg1: 0x1::string::String) : u128 {
        let (v0, _) = 0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::iaccolades::get_accolade(0x2::dynamic_field::borrow<0x1::string::String, 0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::iaccolades::Accolade>(&arg0.id, 0x1::string::utf8(b"accolade")));
        *0x2::vec_map::get<0x1::string::String, u128>(v0, &arg1)
    }

    public(friend) fun get_claimed_rewards(arg0: &Player) : &0x2::vec_map::VecMap<0x1::string::String, vector<u128>> {
        let (_, v1) = 0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::iaccolades::get_accolade(0x2::dynamic_field::borrow<0x1::string::String, 0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::iaccolades::Accolade>(&arg0.id, 0x1::string::utf8(b"accolade")));
        v1
    }

    public(friend) fun get_claimed_rewards_value(arg0: &Player, arg1: 0x1::string::String) : vector<u128> {
        let (_, v1) = 0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::iaccolades::get_accolade(0x2::dynamic_field::borrow<0x1::string::String, 0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::iaccolades::Accolade>(&arg0.id, 0x1::string::utf8(b"accolade")));
        *0x2::vec_map::get<0x1::string::String, vector<u128>>(v1, &arg1)
    }

    public fun has_enough_recruit_count(arg0: &Player, arg1: u64) : bool {
        arg0.gangsters.recruit_count >= arg1
    }

    public fun has_enough_recruit_limit(arg0: &Player, arg1: u64) : bool {
        arg0.gangsters.recruit_count + arg1 < arg0.gangsters.total_capacity
    }

    public(friend) fun has_perk_type(arg0: &Player, arg1: 0x1::string::String) : bool {
        0x2::vec_map::contains<0x1::string::String, u64>(&arg0.perks, &arg1)
    }

    public(friend) fun increase_gangster_capacity(arg0: &mut Player, arg1: u64) {
        arg0.gangsters.total_capacity = arg0.gangsters.total_capacity + arg1;
    }

    public(friend) fun increase_recruit_count(arg0: &mut Player, arg1: u64) {
        arg0.gangsters.recruit_count = arg0.gangsters.recruit_count + arg1;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = InitialPlayerResources{
            cash                       : 0,
            weapon                     : 0,
            scouts                     : 0,
            headquarter_garrison_limit : 0,
            initial_recruits           : 10,
        };
        let v1 = PlayersRegistry{
            id                         : 0x2::object::new(arg0),
            newbie_protection_duration : 0,
            players                    : 0x2::table_vec::empty<0x2::object::ID>(arg0),
            initial_resources          : v0,
        };
        let v2 = FeedRegistry{
            id                    : 0x2::object::new(arg0),
            feed_interval_days_ms : 259200000,
            base_v_cost           : 15000000000,
            cash_scaling_factor   : 200,
            cash_scaling_divisor  : 100,
            base_recruit_cost     : 50,
            operation_scaling     : 5,
            gang_size_scaling     : 400,
            max_cost_multiplier   : 2,
            xp_per_recruit        : 1,
            loyalty_decay_rate    : 25,
        };
        0x2::transfer::share_object<FeedRegistry>(v2);
        0x2::transfer::public_share_object<PlayersRegistry>(v1);
    }

    public(friend) fun initialize_player_timers(arg0: &mut Player, arg1: &mut PlayersRegistry, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) {
        0x2::table_vec::push_back<0x2::object::ID>(&mut arg1.players, 0x2::object::id<Player>(arg0));
        arg0.attack = arg2;
        arg0.gangsters.recruit_count = arg1.initial_resources.initial_recruits;
        0x2::vec_map::insert<0x1::string::String, u64>(&mut arg0.timers, 0x1::string::utf8(b"feed_people"), 0x2::clock::timestamp_ms(arg3) + 259200000);
        0x2::vec_map::insert<0x1::string::String, u64>(&mut arg0.timers, 0x1::string::utf8(b"blackmail_attack_cooldown"), 0x2::clock::timestamp_ms(arg3));
        0x2::vec_map::insert<0x1::string::String, u64>(&mut arg0.timers, 0x1::string::utf8(b"blackmail_looted_cooldown"), 0x2::clock::timestamp_ms(arg3));
        0x2::vec_map::insert<0x1::string::String, u64>(&mut arg0.timers, 0x1::string::utf8(b"attack_protection"), 0x2::clock::timestamp_ms(arg3) + 300000);
        0x2::vec_map::insert<0x1::string::String, u64>(&mut arg0.timers, 0x1::string::utf8(b"newbie_protection"), 0);
        0x2::vec_map::insert<0x1::string::String, u64>(&mut arg0.timers, 0x1::string::utf8(b"raid_cooldown"), 0x2::clock::timestamp_ms(arg3));
        0x2::vec_map::insert<0x1::string::String, u64>(&mut arg0.timers, 0x1::string::utf8(b"mission_cooldown"), 0x2::clock::timestamp_ms(arg3));
        0x2::vec_map::insert<0x1::string::String, u64>(&mut arg0.timers, 0x1::string::utf8(b"safe_cooldown"), 0x2::clock::timestamp_ms(arg3));
        0x2::vec_map::insert<0x1::string::String, u64>(&mut arg0.timers, 0x1::string::utf8(b"hire_scouts_cooldown"), 0x2::clock::timestamp_ms(arg3));
    }

    public(friend) fun insert_claimed_rewards(arg0: &mut Player, arg1: 0x1::string::String, arg2: vector<u128>) {
        0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::iaccolades::insert_accolade_claimed_rewards(0x2::dynamic_field::borrow_mut<0x1::string::String, 0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::iaccolades::Accolade>(&mut arg0.id, 0x1::string::utf8(b"accolade")), arg1, arg2);
    }

    public(friend) fun push_back_claimed_rewards(arg0: &mut Player, arg1: 0x1::string::String, arg2: u128) {
        0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::iaccolades::push_back_accolade_claimed_rewards(0x2::dynamic_field::borrow_mut<0x1::string::String, 0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::iaccolades::Accolade>(&mut arg0.id, 0x1::string::utf8(b"accolade")), arg1, arg2);
    }

    public(friend) fun remove_gangster_from_summary(arg0: &mut Player, arg1: 0x1::string::String, arg2: u64) {
        if (0x2::vec_map::contains<0x1::string::String, u64>(&arg0.gangsters.gangster_types, &arg1)) {
            let v0 = 0x2::vec_map::get_mut<0x1::string::String, u64>(&mut arg0.gangsters.gangster_types, &arg1);
            *v0 = *v0 - arg2;
            arg0.gangsters.current_gangster_count = arg0.gangsters.current_gangster_count - arg2;
        };
    }

    public(friend) fun remove_player_df<T0: drop + store>(arg0: &mut Player, arg1: 0x1::string::String) : T0 {
        0x2::dynamic_field::remove<0x1::string::String, T0>(&mut arg0.id, arg1)
    }

    public(friend) fun reset_gangsters(arg0: &mut Player, arg1: &PlayersRegistry) {
        arg0.gangsters.current_gangster_count = 0;
        arg0.gangsters.gangster_types = 0x2::vec_map::empty<0x1::string::String, u64>();
        arg0.gangsters.recruit_count = 0;
        arg0.gangsters.total_capacity = arg1.initial_resources.headquarter_garrison_limit;
    }

    public(friend) fun reset_player_perks_and_locations(arg0: &mut Player) {
        arg0.perks = 0x2::vec_map::empty<0x1::string::String, u64>();
        arg0.owned_location = 0x1::vector::empty<0x2::object::ID>();
    }

    public(friend) fun reset_player_status(arg0: &mut Player, arg1: bool) {
        arg0.is_inactive = arg1;
    }

    public(friend) fun set_feed_registry(arg0: &mut FeedRegistry, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u128, arg7: u64, arg8: u64, arg9: u64, arg10: u64) {
        arg0.feed_interval_days_ms = arg1;
        arg0.base_v_cost = arg2;
        arg0.cash_scaling_factor = arg3;
        arg0.cash_scaling_divisor = arg4;
        arg0.base_recruit_cost = arg5;
        arg0.operation_scaling = arg6;
        arg0.gang_size_scaling = arg7;
        arg0.max_cost_multiplier = arg8;
        arg0.xp_per_recruit = arg9;
        arg0.loyalty_decay_rate = arg10;
    }

    public(friend) fun set_headquarter(arg0: &mut Player, arg1: 0x2::object::ID) {
        arg0.headquarter_tile = arg1;
    }

    public(friend) fun set_owned_turf(arg0: &mut Player, arg1: 0x2::object::ID) {
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.owned_location, arg1);
    }

    public(friend) fun set_player_registry(arg0: &mut PlayersRegistry, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        arg0.newbie_protection_duration = arg1;
        arg0.initial_resources.cash = arg2;
        arg0.initial_resources.scouts = arg4;
        arg0.initial_resources.weapon = arg3;
        arg0.initial_resources.headquarter_garrison_limit = arg5;
    }

    public(friend) fun set_profile_name(arg0: &mut Player, arg1: 0x1::string::String) {
        arg0.player_name = arg1;
    }

    public(friend) fun set_profile_picture(arg0: &mut Player, arg1: 0x1::string::String) {
        arg0.image_blob = arg1;
    }

    public(friend) fun set_total_paid(arg0: &mut PenaltyReceipt, arg1: u64) {
        arg0.total_paid = arg0.total_paid + arg1;
    }

    public(friend) fun set_total_to_pay(arg0: &mut PenaltyReceipt, arg1: u64) {
        arg0.total_to_pay = arg1;
    }

    public(friend) fun share_player(arg0: Player) {
        0x2::transfer::share_object<Player>(arg0);
    }

    public(friend) fun total_player_len(arg0: &PlayersRegistry) : u64 {
        0x2::table_vec::length<0x2::object::ID>(&arg0.players)
    }

    public(friend) fun update_accolade_value(arg0: &mut Player, arg1: 0x1::string::String, arg2: u128, arg3: u8) {
        if (arg3 == 0) {
            0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::iaccolades::update_accolade_data(0x2::dynamic_field::borrow_mut<0x1::string::String, 0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::iaccolades::Accolade>(&mut arg0.id, 0x1::string::utf8(b"accolade")), arg1, arg2);
        } else {
            0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::iaccolades::insert_accolade_data(0x2::dynamic_field::borrow_mut<0x1::string::String, 0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::iaccolades::Accolade>(&mut arg0.id, 0x1::string::utf8(b"accolade")), arg1, arg2);
        };
    }

    public(friend) fun update_player_stats(arg0: &mut Player, arg1: 0x1::string::String, arg2: u128) {
        let (v0, _) = 0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::iaccolades::get_accolade(0x2::dynamic_field::borrow_mut<0x1::string::String, 0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::iaccolades::Accolade>(&mut arg0.id, 0x1::string::utf8(b"accolade")));
        if (0x2::vec_map::contains<0x1::string::String, u128>(v0, &arg1) == true) {
            update_accolade_value(arg0, arg1, arg2, 0);
        } else {
            update_accolade_value(arg0, arg1, arg2, 1);
        };
    }

    // decompiled from Move bytecode v6
}

