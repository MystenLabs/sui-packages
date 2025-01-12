module 0xd683b01fe412e8a50e2bf6087caa55a676af341f87e2c1c5a9681fe680ee7fb5::lottery {
    struct LotteryPool<phantom T0> has store, key {
        id: 0x2::object::UID,
        round: u64,
        epoch: u64,
        price_in_sui: u64,
        created_at: u64,
        pool_type: 0x1::ascii::String,
        lucky_number: vector<u8>,
        start_time: u64,
        end_time: u64,
        is_active: bool,
        balance: 0x2::balance::Balance<T0>,
        total_ticket_counter: u64,
        prize_level_total: 0xd683b01fe412e8a50e2bf6087caa55a676af341f87e2c1c5a9681fe680ee7fb5::prize::PrizeLevelDistribution,
        prize_level_each: 0xd683b01fe412e8a50e2bf6087caa55a676af341f87e2c1c5a9681fe680ee7fb5::prize::PrizeLevelDistribution,
        ticket_numbers: 0x2::vec_map::VecMap<vector<u8>, 0x2::vec_set::VecSet<0x2::object::ID>>,
        prizes: 0x2::vec_map::VecMap<u8, vector<0x2::object::ID>>,
        ticket_infos: 0x2::vec_map::VecMap<0x2::object::ID, 0xd683b01fe412e8a50e2bf6087caa55a676af341f87e2c1c5a9681fe680ee7fb5::ticket::TicketInfo>,
        drawn_time: 0x1::option::Option<u64>,
    }

    struct LotteryPoolCreated has copy, drop {
        pool_id: 0x2::object::ID,
        epoch: u64,
        created_at: u64,
        pool_type: 0x1::ascii::String,
        start_time: u64,
        end_time: u64,
    }

    struct LotteryPoolDrawn has copy, drop {
        pool_id: 0x2::object::ID,
        lucky_number: vector<u8>,
        drawn_time_ms: u64,
    }

    struct LotteryPoolClaimed has copy, drop {
        pool_id: 0x2::object::ID,
        ticket_id: 0x2::object::ID,
        ticket_number: vector<u8>,
        claimed_by: address,
        prize_amount: u64,
        claimed_time_ms: u64,
    }

    struct TicketBought has copy, drop {
        ticket_infos: vector<0xd683b01fe412e8a50e2bf6087caa55a676af341f87e2c1c5a9681fe680ee7fb5::ticket::TicketInfo>,
    }

    fun add_ticket_infos<T0>(arg0: &mut LotteryPool<T0>, arg1: vector<0xd683b01fe412e8a50e2bf6087caa55a676af341f87e2c1c5a9681fe680ee7fb5::ticket::TicketInfo>) {
        0x1::vector::reverse<0xd683b01fe412e8a50e2bf6087caa55a676af341f87e2c1c5a9681fe680ee7fb5::ticket::TicketInfo>(&mut arg1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0xd683b01fe412e8a50e2bf6087caa55a676af341f87e2c1c5a9681fe680ee7fb5::ticket::TicketInfo>(&arg1)) {
            let v1 = 0x1::vector::pop_back<0xd683b01fe412e8a50e2bf6087caa55a676af341f87e2c1c5a9681fe680ee7fb5::ticket::TicketInfo>(&mut arg1);
            let v2 = 0xd683b01fe412e8a50e2bf6087caa55a676af341f87e2c1c5a9681fe680ee7fb5::ticket::info_ticket_id(&v1);
            let v3 = 0xd683b01fe412e8a50e2bf6087caa55a676af341f87e2c1c5a9681fe680ee7fb5::ticket::info_ticket_number(&v1);
            0x2::vec_map::insert<0x2::object::ID, 0xd683b01fe412e8a50e2bf6087caa55a676af341f87e2c1c5a9681fe680ee7fb5::ticket::TicketInfo>(&mut arg0.ticket_infos, v2, v1);
            if (0x2::vec_map::contains<vector<u8>, 0x2::vec_set::VecSet<0x2::object::ID>>(&arg0.ticket_numbers, &v3)) {
                0x2::vec_set::insert<0x2::object::ID>(0x2::vec_map::get_mut<vector<u8>, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut arg0.ticket_numbers, &v3), v2);
            } else {
                let v4 = 0x2::vec_set::empty<0x2::object::ID>();
                0x2::vec_set::insert<0x2::object::ID>(&mut v4, v2);
                0x2::vec_map::insert<vector<u8>, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut arg0.ticket_numbers, v3, v4);
            };
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<0xd683b01fe412e8a50e2bf6087caa55a676af341f87e2c1c5a9681fe680ee7fb5::ticket::TicketInfo>(arg1);
    }

    public(friend) fun append_prizes<T0>(arg0: &mut LotteryPool<T0>, arg1: u8, arg2: vector<0x2::object::ID>) {
        if (0x2::vec_map::contains<u8, vector<0x2::object::ID>>(&arg0.prizes, &arg1)) {
            0x1::vector::append<0x2::object::ID>(0x2::vec_map::get_mut<u8, vector<0x2::object::ID>>(&mut arg0.prizes, &arg1), arg2);
        } else {
            0x2::vec_map::insert<u8, vector<0x2::object::ID>>(&mut arg0.prizes, arg1, arg2);
        };
    }

    public(friend) fun buy_tickets<T0>(arg0: &mut LotteryPool<T0>, arg1: vector<vector<u8>>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : vector<0xd683b01fe412e8a50e2bf6087caa55a676af341f87e2c1c5a9681fe680ee7fb5::ticket::TicketInfo> {
        validate_ticket_numbers_length(&arg1);
        0xd683b01fe412e8a50e2bf6087caa55a676af341f87e2c1c5a9681fe680ee7fb5::ticket::validate_ticket_numbers(arg1);
        assert!(arg3 <= get_end_time<T0>(arg0), 7);
        assert!(is_active<T0>(arg0), 4);
        let v0 = 0xd683b01fe412e8a50e2bf6087caa55a676af341f87e2c1c5a9681fe680ee7fb5::ticket::generate_tickets(get_pool_id<T0>(arg0), get_pool_round<T0>(arg0), get_price<T0>(arg0), 0x1::type_name::into_string(0x1::type_name::get<T0>()), get_pool_type<T0>(arg0), get_end_time<T0>(arg0), arg1, arg4);
        update_ticket_info<T0>(arg0, v0, arg2);
        emit_ticket_bought_event(v0);
        v0
    }

    fun calc_and_update_prize_level_total<T0>(arg0: &mut LotteryPool<T0>) {
        arg0.prize_level_total = calc_prize_level_total_before_draw<T0>(arg0);
    }

    public fun calc_prize_level_total_before_draw<T0>(arg0: &LotteryPool<T0>) : 0xd683b01fe412e8a50e2bf6087caa55a676af341f87e2c1c5a9681fe680ee7fb5::prize::PrizeLevelDistribution {
        0xd683b01fe412e8a50e2bf6087caa55a676af341f87e2c1c5a9681fe680ee7fb5::prize::create_prize_level_distribution(get_prize_level_total_amount<T0>(arg0, 1), get_prize_level_total_amount<T0>(arg0, 2), get_prize_level_total_amount<T0>(arg0, 3), get_prize_level_total_amount<T0>(arg0, 4), get_prize_level_total_amount<T0>(arg0, 5), get_prize_level_total_amount<T0>(arg0, 6))
    }

    public(friend) fun claim_pool<T0>(arg0: &mut LotteryPool<T0>, arg1: &mut 0xd683b01fe412e8a50e2bf6087caa55a676af341f87e2c1c5a9681fe680ee7fb5::ticket::Ticket, arg2: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0xd683b01fe412e8a50e2bf6087caa55a676af341f87e2c1c5a9681fe680ee7fb5::ticket::get_ticket_id(arg1);
        assert!(!0xd683b01fe412e8a50e2bf6087caa55a676af341f87e2c1c5a9681fe680ee7fb5::ticket::is_claimed(arg1), 0);
        let v1 = 0xd683b01fe412e8a50e2bf6087caa55a676af341f87e2c1c5a9681fe680ee7fb5::ticket::get_ticket_number(arg1);
        let v2 = get_prize_level<T0>(arg0, &v1);
        assert!(v2 > 0, 3);
        let v3 = get_prize_level_each_amount<T0>(arg0, v2);
        let v4 = get_pool_id<T0>(arg0);
        let v5 = 0x2::vec_map::get_mut<0x2::object::ID, 0xd683b01fe412e8a50e2bf6087caa55a676af341f87e2c1c5a9681fe680ee7fb5::ticket::TicketInfo>(&mut arg0.ticket_infos, &v0);
        let v6 = 0x2::tx_context::sender(arg2);
        let v7 = 0x2::tx_context::epoch_timestamp_ms(arg2);
        update_claimed_info(v5, v2, v3, v6, v7);
        0xd683b01fe412e8a50e2bf6087caa55a676af341f87e2c1c5a9681fe680ee7fb5::ticket::update_claimed_info(arg1, get_pool_lucky_number<T0>(arg0), v2, v3, v6, v7, get_drawn_time<T0>(arg0));
        emit_pool_claimed_event(v4, v0, v1, v6, v3, v7);
        distribute_bonus<T0>(arg0, v3)
    }

    public(friend) fun create_lottery_pool<T0>(arg0: u64, arg1: u64, arg2: 0x1::ascii::String, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : LotteryPool<T0> {
        assert!(0xd683b01fe412e8a50e2bf6087caa55a676af341f87e2c1c5a9681fe680ee7fb5::helper::validate_pool_type(&arg2), 6);
        assert!(validate_pool_end_time(0x2::tx_context::epoch_timestamp_ms(arg5), arg4), 8);
        let v0 = LotteryPool<T0>{
            id                   : 0x2::object::new(arg5),
            round                : arg1,
            epoch                : 0x2::tx_context::epoch(arg5),
            price_in_sui         : arg0,
            created_at           : 0x2::tx_context::epoch_timestamp_ms(arg5),
            pool_type            : arg2,
            lucky_number         : 0x1::vector::empty<u8>(),
            start_time           : arg3,
            end_time             : arg4,
            is_active            : true,
            balance              : 0x2::balance::zero<T0>(),
            total_ticket_counter : 0,
            prize_level_total    : zero_prize_distribution(),
            prize_level_each     : zero_prize_distribution(),
            ticket_numbers       : 0x2::vec_map::empty<vector<u8>, 0x2::vec_set::VecSet<0x2::object::ID>>(),
            prizes               : 0x2::vec_map::empty<u8, vector<0x2::object::ID>>(),
            ticket_infos         : 0x2::vec_map::empty<0x2::object::ID, 0xd683b01fe412e8a50e2bf6087caa55a676af341f87e2c1c5a9681fe680ee7fb5::ticket::TicketInfo>(),
            drawn_time           : 0x1::option::none<u64>(),
        };
        emit_pool_created_event<T0>(&v0);
        v0
    }

    fun deposit_balance<T0>(arg0: &mut LotteryPool<T0>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(&mut arg0.balance, arg1);
    }

    fun distribute_bonus<T0>(arg0: &mut LotteryPool<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(&mut arg0.balance, arg1)
    }

    public(friend) fun draw_lottery<T0>(arg0: &mut LotteryPool<T0>, arg1: &mut 0xd683b01fe412e8a50e2bf6087caa55a676af341f87e2c1c5a9681fe680ee7fb5::vault::Vault<T0>, arg2: vector<u8>, arg3: u64) {
        assert!(arg3 >= get_end_time<T0>(arg0), 9);
        assert!(arg0.is_active, 4);
        set_lucky_number<T0>(arg0, arg2);
        set_active<T0>(arg0, false);
        set_drawn_time<T0>(arg0, arg3);
        let v0 = get_pool_type<T0>(arg0);
        let v1 = withdraw_by_pool_type_from_vault<T0>(arg1, &v0);
        deposit_balance<T0>(arg0, v1);
        calc_and_update_prize_level_total<T0>(arg0);
        update_prizes<T0>(arg0);
        let v2 = update_prize_level_each<T0>(arg0);
        update_lucky_nubmer_for_ticket_infos<T0>(arg0, arg2, v2, arg3);
        migrate_balance_to_vault<T0>(arg0, arg1);
        emit_pool_drawm_event(get_pool_id<T0>(arg0), arg2, arg3);
    }

    public(friend) fun emit_pool_claimed_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: vector<u8>, arg3: address, arg4: u64, arg5: u64) {
        let v0 = LotteryPoolClaimed{
            pool_id         : arg0,
            ticket_id       : arg1,
            ticket_number   : arg2,
            claimed_by      : arg3,
            prize_amount    : arg4,
            claimed_time_ms : arg5,
        };
        0x2::event::emit<LotteryPoolClaimed>(v0);
    }

    public fun emit_pool_created_event<T0>(arg0: &LotteryPool<T0>) {
        let v0 = LotteryPoolCreated{
            pool_id    : 0x2::object::id<LotteryPool<T0>>(arg0),
            epoch      : arg0.epoch,
            created_at : arg0.created_at,
            pool_type  : arg0.pool_type,
            start_time : arg0.start_time,
            end_time   : arg0.end_time,
        };
        0x2::event::emit<LotteryPoolCreated>(v0);
    }

    fun emit_pool_drawm_event(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: u64) {
        let v0 = LotteryPoolDrawn{
            pool_id       : arg0,
            lucky_number  : arg1,
            drawn_time_ms : arg2,
        };
        0x2::event::emit<LotteryPoolDrawn>(v0);
    }

    public(friend) fun emit_ticket_bought_event(arg0: vector<0xd683b01fe412e8a50e2bf6087caa55a676af341f87e2c1c5a9681fe680ee7fb5::ticket::TicketInfo>) {
        let v0 = TicketBought{ticket_infos: arg0};
        0x2::event::emit<TicketBought>(v0);
    }

    public fun get_drawn_time<T0>(arg0: &LotteryPool<T0>) : 0x1::option::Option<u64> {
        arg0.drawn_time
    }

    public fun get_end_time<T0>(arg0: &LotteryPool<T0>) : u64 {
        arg0.end_time
    }

    public fun get_lottery_price<T0>(arg0: &LotteryPool<T0>) : u64 {
        arg0.price_in_sui
    }

    public fun get_pool_balance<T0>(arg0: &LotteryPool<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun get_pool_created_at<T0>(arg0: &LotteryPool<T0>) : u64 {
        arg0.created_at
    }

    public fun get_pool_id<T0>(arg0: &LotteryPool<T0>) : 0x2::object::ID {
        0x2::object::id<LotteryPool<T0>>(arg0)
    }

    public fun get_pool_lucky_number<T0>(arg0: &LotteryPool<T0>) : vector<u8> {
        arg0.lucky_number
    }

    public fun get_pool_round<T0>(arg0: &LotteryPool<T0>) : u64 {
        arg0.round
    }

    public fun get_pool_type<T0>(arg0: &LotteryPool<T0>) : 0x1::ascii::String {
        arg0.pool_type
    }

    public fun get_price<T0>(arg0: &LotteryPool<T0>) : u64 {
        arg0.price_in_sui
    }

    public fun get_prize_amount<T0>(arg0: &LotteryPool<T0>, arg1: &vector<u8>) : u64 {
        let v0 = arg0.prize_level_total;
        0xd683b01fe412e8a50e2bf6087caa55a676af341f87e2c1c5a9681fe680ee7fb5::prize::get_prize_level_amount(&v0, get_prize_level<T0>(arg0, arg1))
    }

    public fun get_prize_level<T0>(arg0: &LotteryPool<T0>, arg1: &vector<u8>) : u8 {
        let v0 = get_pool_lucky_number<T0>(arg0);
        0xd683b01fe412e8a50e2bf6087caa55a676af341f87e2c1c5a9681fe680ee7fb5::helper::calc_prize_level(&v0, arg1)
    }

    public fun get_prize_level_each<T0>(arg0: &LotteryPool<T0>) : 0xd683b01fe412e8a50e2bf6087caa55a676af341f87e2c1c5a9681fe680ee7fb5::prize::PrizeLevelDistribution {
        arg0.prize_level_each
    }

    public fun get_prize_level_each_amount<T0>(arg0: &LotteryPool<T0>, arg1: u8) : u64 {
        let v0 = get_prize_level_total<T0>(arg0);
        let v1 = 0x2::vec_map::try_get<u8, vector<0x2::object::ID>>(&arg0.prizes, &arg1);
        let v2 = &v1;
        let v3 = if (0x1::option::is_some<vector<0x2::object::ID>>(v2)) {
            0x1::option::some<u64>(0x1::vector::length<0x2::object::ID>(0x1::option::borrow<vector<0x2::object::ID>>(v2)))
        } else {
            0x1::option::none<u64>()
        };
        let v4 = v3;
        let v5 = 0x1::option::get_with_default<u64>(&v4, 0);
        if (v5 > 0) {
            0xd683b01fe412e8a50e2bf6087caa55a676af341f87e2c1c5a9681fe680ee7fb5::prize::get_prize_level_amount(&v0, arg1) / v5
        } else {
            0
        }
    }

    public fun get_prize_level_total<T0>(arg0: &LotteryPool<T0>) : 0xd683b01fe412e8a50e2bf6087caa55a676af341f87e2c1c5a9681fe680ee7fb5::prize::PrizeLevelDistribution {
        arg0.prize_level_total
    }

    public fun get_prize_level_total_amount<T0>(arg0: &LotteryPool<T0>, arg1: u8) : u64 {
        let v0 = &arg1;
        let v1 = if (*v0 == 1) {
            2
        } else if (*v0 == 2) {
            3
        } else if (*v0 == 3) {
            5
        } else if (*v0 == 4) {
            10
        } else if (*v0 == 5) {
            20
        } else {
            assert!(*v0 == 6, 1);
            40
        };
        get_pool_balance<T0>(arg0) / 100 * (v1 as u64)
    }

    public fun get_prizes<T0>(arg0: &LotteryPool<T0>) : 0x2::vec_map::VecMap<u8, vector<0x2::object::ID>> {
        arg0.prizes
    }

    public fun get_ticket_count<T0>(arg0: &LotteryPool<T0>) : u64 {
        arg0.total_ticket_counter
    }

    public fun get_ticket_info<T0>(arg0: &LotteryPool<T0>, arg1: &0x2::object::ID) : 0x1::option::Option<0xd683b01fe412e8a50e2bf6087caa55a676af341f87e2c1c5a9681fe680ee7fb5::ticket::TicketInfo> {
        0x2::vec_map::try_get<0x2::object::ID, 0xd683b01fe412e8a50e2bf6087caa55a676af341f87e2c1c5a9681fe680ee7fb5::ticket::TicketInfo>(&arg0.ticket_infos, arg1)
    }

    public fun get_ticket_infos<T0>(arg0: &LotteryPool<T0>, arg1: vector<0x2::object::ID>) : vector<0xd683b01fe412e8a50e2bf6087caa55a676af341f87e2c1c5a9681fe680ee7fb5::ticket::TicketInfo> {
        let v0 = 0x1::vector::empty<0xd683b01fe412e8a50e2bf6087caa55a676af341f87e2c1c5a9681fe680ee7fb5::ticket::TicketInfo>();
        let v1 = &arg1;
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x2::object::ID>(v1)) {
            let v3 = get_ticket_info<T0>(arg0, 0x1::vector::borrow<0x2::object::ID>(v1, v2));
            if (0x1::option::is_some<0xd683b01fe412e8a50e2bf6087caa55a676af341f87e2c1c5a9681fe680ee7fb5::ticket::TicketInfo>(&v3)) {
                0x1::vector::push_back<0xd683b01fe412e8a50e2bf6087caa55a676af341f87e2c1c5a9681fe680ee7fb5::ticket::TicketInfo>(&mut v0, 0x1::option::extract<0xd683b01fe412e8a50e2bf6087caa55a676af341f87e2c1c5a9681fe680ee7fb5::ticket::TicketInfo>(&mut v3));
            };
            v2 = v2 + 1;
        };
        v0
    }

    public fun get_ticket_lists_of_prize_level<T0>(arg0: &LotteryPool<T0>, arg1: u8) : vector<0x2::object::ID> {
        let v0 = 0x2::vec_map::try_get<u8, vector<0x2::object::ID>>(&arg0.prizes, &arg1);
        0x1::option::get_with_default<vector<0x2::object::ID>>(&v0, 0x1::vector::empty<0x2::object::ID>())
    }

    public(friend) fun increment_ticket_counter<T0>(arg0: &mut LotteryPool<T0>, arg1: u64) {
        arg0.total_ticket_counter = arg0.total_ticket_counter + arg1;
    }

    public fun is_active<T0>(arg0: &LotteryPool<T0>) : bool {
        arg0.is_active
    }

    public fun join_balance_to_vault_by_pool_type<T0>(arg0: &mut 0xd683b01fe412e8a50e2bf6087caa55a676af341f87e2c1c5a9681fe680ee7fb5::vault::Vault<T0>, arg1: 0x2::balance::Balance<T0>, arg2: &0x1::ascii::String) : u64 {
        let v0 = 0x1::ascii::into_bytes(0x1::ascii::to_lowercase(arg2));
        let v1 = &v0;
        if (*v1 == b"daily") {
            0xd683b01fe412e8a50e2bf6087caa55a676af341f87e2c1c5a9681fe680ee7fb5::vault::join_daily<T0>(arg0, arg1)
        } else if (*v1 == b"monthly") {
            0xd683b01fe412e8a50e2bf6087caa55a676af341f87e2c1c5a9681fe680ee7fb5::vault::join_monthly<T0>(arg0, arg1)
        } else if (*v1 == b"weekly") {
            0xd683b01fe412e8a50e2bf6087caa55a676af341f87e2c1c5a9681fe680ee7fb5::vault::join_weekly<T0>(arg0, arg1)
        } else {
            assert!(*v1 == b"yearly", 6);
            0xd683b01fe412e8a50e2bf6087caa55a676af341f87e2c1c5a9681fe680ee7fb5::vault::join_yearly<T0>(arg0, arg1)
        }
    }

    public(friend) fun migrate_balance_to_vault<T0>(arg0: &mut LotteryPool<T0>, arg1: &mut 0xd683b01fe412e8a50e2bf6087caa55a676af341f87e2c1c5a9681fe680ee7fb5::vault::Vault<T0>) {
        let v0 = get_pool_balance<T0>(arg0);
        let v1 = 0x1::ascii::string(b"monthly");
        join_balance_to_vault_by_pool_type<T0>(arg1, 0x2::balance::split<T0>(&mut arg0.balance, v0 * 10 / 100), &v1);
        let v2 = 0x1::ascii::string(b"yearly");
        join_balance_to_vault_by_pool_type<T0>(arg1, 0x2::balance::split<T0>(&mut arg0.balance, v0 * 10 / 100), &v2);
        let v3 = get_prize_level_total<T0>(arg0);
        let v4 = get_prize_level_each<T0>(arg0);
        let v5 = get_pool_type<T0>(arg0);
        if (0xd683b01fe412e8a50e2bf6087caa55a676af341f87e2c1c5a9681fe680ee7fb5::prize::get_first_level(&v4) == 0) {
            join_balance_to_vault_by_pool_type<T0>(arg1, 0x2::balance::split<T0>(&mut arg0.balance, 0xd683b01fe412e8a50e2bf6087caa55a676af341f87e2c1c5a9681fe680ee7fb5::prize::get_first_level(&v3)), &v5);
        };
        if (0xd683b01fe412e8a50e2bf6087caa55a676af341f87e2c1c5a9681fe680ee7fb5::prize::get_second_level(&v4) == 0) {
            join_balance_to_vault_by_pool_type<T0>(arg1, 0x2::balance::split<T0>(&mut arg0.balance, 0xd683b01fe412e8a50e2bf6087caa55a676af341f87e2c1c5a9681fe680ee7fb5::prize::get_second_level(&v3)), &v5);
        };
        if (0xd683b01fe412e8a50e2bf6087caa55a676af341f87e2c1c5a9681fe680ee7fb5::prize::get_third_level(&v4) == 0) {
            join_balance_to_vault_by_pool_type<T0>(arg1, 0x2::balance::split<T0>(&mut arg0.balance, 0xd683b01fe412e8a50e2bf6087caa55a676af341f87e2c1c5a9681fe680ee7fb5::prize::get_third_level(&v3)), &v5);
        };
        if (0xd683b01fe412e8a50e2bf6087caa55a676af341f87e2c1c5a9681fe680ee7fb5::prize::get_fourth_level(&v4) == 0) {
            join_balance_to_vault_by_pool_type<T0>(arg1, 0x2::balance::split<T0>(&mut arg0.balance, 0xd683b01fe412e8a50e2bf6087caa55a676af341f87e2c1c5a9681fe680ee7fb5::prize::get_fourth_level(&v3)), &v5);
        };
        if (0xd683b01fe412e8a50e2bf6087caa55a676af341f87e2c1c5a9681fe680ee7fb5::prize::get_fifth_level(&v4) == 0) {
            join_balance_to_vault_by_pool_type<T0>(arg1, 0x2::balance::split<T0>(&mut arg0.balance, 0xd683b01fe412e8a50e2bf6087caa55a676af341f87e2c1c5a9681fe680ee7fb5::prize::get_fifth_level(&v3)), &v5);
        };
        if (0xd683b01fe412e8a50e2bf6087caa55a676af341f87e2c1c5a9681fe680ee7fb5::prize::get_sixth_level(&v4) == 0) {
            join_balance_to_vault_by_pool_type<T0>(arg1, 0x2::balance::split<T0>(&mut arg0.balance, 0xd683b01fe412e8a50e2bf6087caa55a676af341f87e2c1c5a9681fe680ee7fb5::prize::get_sixth_level(&v3)), &v5);
        };
    }

    public(friend) fun set_active<T0>(arg0: &mut LotteryPool<T0>, arg1: bool) {
        arg0.is_active = arg1;
    }

    public(friend) fun set_drawn_time<T0>(arg0: &mut LotteryPool<T0>, arg1: u64) {
        arg0.drawn_time = 0x1::option::some<u64>(arg1);
    }

    public(friend) fun set_lottery_price<T0>(arg0: &mut LotteryPool<T0>, arg1: u64) {
        arg0.price_in_sui = arg1;
    }

    public(friend) fun set_lucky_number<T0>(arg0: &mut LotteryPool<T0>, arg1: vector<u8>) {
        arg0.lucky_number = arg1;
    }

    fun update_claimed_info(arg0: &mut 0xd683b01fe412e8a50e2bf6087caa55a676af341f87e2c1c5a9681fe680ee7fb5::ticket::TicketInfo, arg1: u8, arg2: u64, arg3: address, arg4: u64) {
        0xd683b01fe412e8a50e2bf6087caa55a676af341f87e2c1c5a9681fe680ee7fb5::ticket::add_claimed_info(arg0, arg1, arg2, arg3, arg4);
    }

    fun update_lucky_nubmer_for_ticket_infos<T0>(arg0: &mut LotteryPool<T0>, arg1: vector<u8>, arg2: 0xd683b01fe412e8a50e2bf6087caa55a676af341f87e2c1c5a9681fe680ee7fb5::prize::PrizeLevelDistribution, arg3: u64) {
        0xd683b01fe412e8a50e2bf6087caa55a676af341f87e2c1c5a9681fe680ee7fb5::ticket::add_lucky_numbers(&mut arg0.ticket_infos, arg1, arg2, arg3);
    }

    public fun update_prize_level_each<T0>(arg0: &mut LotteryPool<T0>) : 0xd683b01fe412e8a50e2bf6087caa55a676af341f87e2c1c5a9681fe680ee7fb5::prize::PrizeLevelDistribution {
        let v0 = 0xd683b01fe412e8a50e2bf6087caa55a676af341f87e2c1c5a9681fe680ee7fb5::prize::create_prize_level_distribution(get_prize_level_each_amount<T0>(arg0, 1), get_prize_level_each_amount<T0>(arg0, 2), get_prize_level_each_amount<T0>(arg0, 3), get_prize_level_each_amount<T0>(arg0, 4), get_prize_level_each_amount<T0>(arg0, 5), get_prize_level_each_amount<T0>(arg0, 6));
        arg0.prize_level_each = v0;
        v0
    }

    fun update_prizes<T0>(arg0: &mut LotteryPool<T0>) {
        let v0 = 0x2::vec_map::keys<vector<u8>, 0x2::vec_set::VecSet<0x2::object::ID>>(&arg0.ticket_numbers);
        let v1 = &v0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<vector<u8>>(v1)) {
            let v3 = 0x1::vector::borrow<vector<u8>>(v1, v2);
            let v4 = get_pool_lucky_number<T0>(arg0);
            let v5 = 0xd683b01fe412e8a50e2bf6087caa55a676af341f87e2c1c5a9681fe680ee7fb5::helper::calc_prize_level(&v4, v3);
            if (v5 > 0) {
                let v6 = *0x2::vec_set::keys<0x2::object::ID>(0x2::vec_map::get<vector<u8>, 0x2::vec_set::VecSet<0x2::object::ID>>(&arg0.ticket_numbers, v3));
                append_prizes<T0>(arg0, v5, v6);
            };
            v2 = v2 + 1;
        };
    }

    fun update_ticket_info<T0>(arg0: &mut LotteryPool<T0>, arg1: vector<0xd683b01fe412e8a50e2bf6087caa55a676af341f87e2c1c5a9681fe680ee7fb5::ticket::TicketInfo>, arg2: 0x2::coin::Coin<T0>) {
        add_ticket_infos<T0>(arg0, arg1);
        increment_ticket_counter<T0>(arg0, 0x1::vector::length<0xd683b01fe412e8a50e2bf6087caa55a676af341f87e2c1c5a9681fe680ee7fb5::ticket::TicketInfo>(&arg1));
        deposit_balance<T0>(arg0, 0x2::coin::into_balance<T0>(arg2));
        calc_and_update_prize_level_total<T0>(arg0);
    }

    fun validate_pool_end_time(arg0: u64, arg1: u64) : bool {
        arg0 < arg1
    }

    fun validate_ticket_numbers_length(arg0: &vector<vector<u8>>) {
        let v0 = 0x1::vector::length<vector<u8>>(arg0);
        assert!(v0 > 0, 2);
        assert!(v0 <= 100, 5);
    }

    public(friend) fun withdraw_by_pool_type_from_vault<T0>(arg0: &mut 0xd683b01fe412e8a50e2bf6087caa55a676af341f87e2c1c5a9681fe680ee7fb5::vault::Vault<T0>, arg1: &0x1::ascii::String) : 0x2::balance::Balance<T0> {
        0xd683b01fe412e8a50e2bf6087caa55a676af341f87e2c1c5a9681fe680ee7fb5::vault::withdraw_by_pool_type<T0>(arg0, arg1)
    }

    public fun zero_prize_distribution() : 0xd683b01fe412e8a50e2bf6087caa55a676af341f87e2c1c5a9681fe680ee7fb5::prize::PrizeLevelDistribution {
        0xd683b01fe412e8a50e2bf6087caa55a676af341f87e2c1c5a9681fe680ee7fb5::prize::create_prize_level_distribution(0, 0, 0, 0, 0, 0)
    }

    // decompiled from Move bytecode v6
}

