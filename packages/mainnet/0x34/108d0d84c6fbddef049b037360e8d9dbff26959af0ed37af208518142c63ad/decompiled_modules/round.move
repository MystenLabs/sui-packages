module 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::round {
    struct RoundKey<phantom T0> has copy, drop, store {
        epoch: u64,
    }

    struct RoundInfo<phantom T0> has store, key {
        id: 0x2::object::UID,
        epoch: u64,
        start_timestamp: u64,
        lock_timestamp: u64,
        close_timestamp: u64,
        init_prize_pool: u64,
        ticket_price: u64,
        reward_breakdown: vector<u64>,
        winning_number: vector<u8>,
        drand_signature: vector<u8>,
        drand_round_id: u64,
        tickets: 0x2::table::Table<0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::ticket::TicketKey<T0>, 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::ticket::TicketValue<T0>>,
        users: 0x2::table::Table<address, vector<u64>>,
        reward_ticket_per_level: vector<u64>,
        reward_per_level: vector<u64>,
        is_finished: bool,
        error_code: u64,
    }

    struct StartRoundEvent has copy, drop {
        round_id: 0x2::object::ID,
        epoch: u64,
        pool: 0x1::string::String,
        start_timestamp: u64,
        lock_timestamp: u64,
        close_timestamp: u64,
        init_prize_pool: u64,
        ticket_price: u64,
        reward_breakdown: vector<u64>,
    }

    struct EndRoundEvent has copy, drop {
        round_id: 0x2::object::ID,
        epoch: u64,
        pool: 0x1::string::String,
        start_timestamp: u64,
        lock_timestamp: u64,
        close_timestamp: u64,
        init_prize_pool: u64,
        ticket_price: u64,
        reward_breakdown: vector<u64>,
        winning_number: vector<u8>,
        drand_signature: vector<u8>,
        drand_round_id: u64,
        total_tickets: u64,
        total_users: u64,
        reward_ticket_per_level: vector<u64>,
        reward_per_level: vector<u64>,
        is_finished: bool,
        error_code: u64,
    }

    public(friend) fun add_ticket<T0>(arg0: &mut RoundInfo<T0>, arg1: 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::ticket::TicketKey<T0>, arg2: 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::ticket::TicketValue<T0>) {
        0x2::table::add<0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::ticket::TicketKey<T0>, 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::ticket::TicketValue<T0>>(&mut arg0.tickets, arg1, arg2);
    }

    public(friend) fun add_user_tickets<T0>(arg0: &mut RoundInfo<T0>, arg1: address, arg2: vector<u64>) {
        if (!0x2::table::contains<address, vector<u64>>(&arg0.users, arg1)) {
            0x2::table::add<address, vector<u64>>(&mut arg0.users, arg1, 0x1::vector::empty<u64>());
        };
        let v0 = 0x2::table::borrow_mut<address, vector<u64>>(&mut arg0.users, arg1);
        let v1 = 0;
        loop {
            if (v1 >= 0x1::vector::length<u64>(&arg2)) {
                break
            };
            0x1::vector::push_back<u64>(v0, *0x1::vector::borrow<u64>(&arg2, v1));
            v1 = v1 + 1;
        };
    }

    public fun buyable<T0>(arg0: &RoundInfo<T0>, arg1: u64) : bool {
        arg0.start_timestamp != 0 && arg0.lock_timestamp != 0 && arg1 > arg0.start_timestamp && arg1 < arg0.lock_timestamp
    }

    public(friend) fun calculate_rewards<T0>(arg0: &0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::configuration::Configuration<T0>, arg1: &RoundInfo<T0>, arg2: vector<u8>) : (u64, u64, u64, u64, vector<u64>, vector<u64>) {
        let v0 = 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::configuration::get_reward_breakdown<T0>(arg0);
        let v1 = 0x1::vector::length<u64>(&v0);
        assert!(v1 == 0x1::vector::length<u8>(&arg2), 401);
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0x1::vector::empty<u64>();
        let v4 = 0x2::table::length<0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::ticket::TicketKey<T0>, 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::ticket::TicketValue<T0>>(&arg1.tickets);
        let v5 = v4 * arg1.ticket_price;
        let v6 = arg1.init_prize_pool + v5;
        let v7 = 0;
        let v8 = 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::utils::get_value_with_rate(arg1.init_prize_pool, 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::configuration::get_treasury_reserve_rate<T0>(arg0));
        let v9 = 0;
        loop {
            if (v9 >= v1) {
                break
            };
            0x1::vector::push_back<u64>(&mut v2, 0);
            v9 = v9 + 1;
        };
        let v10 = 1;
        loop {
            if (v10 > v4) {
                break
            };
            let v11 = 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::utils::get_reward_level(arg2, 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::ticket::get_lottery_number_value<T0>(0x2::table::borrow<0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::ticket::TicketKey<T0>, 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::ticket::TicketValue<T0>>(&arg1.tickets, 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::ticket::new_ticket_key<T0>(arg1.epoch, v10))));
            if (v11 > 0) {
                *0x1::vector::borrow_mut<u64>(&mut v2, v11 - 1) = *0x1::vector::borrow_mut<u64>(&mut v2, v11 - 1) + 1;
            };
            v10 = v10 + 1;
        };
        v9 = 0;
        loop {
            if (v9 >= v1) {
                break
            };
            let v12 = *0x1::vector::borrow<u64>(&v2, v9);
            let v13 = 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::utils::get_value_with_rate(v6, *0x1::vector::borrow<u64>(&v0, v9));
            let v14 = if (v12 == 0) {
                v8 = v8 + v13;
                0
            } else {
                let v15 = 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::utils::get_value_with_rate(v13, 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::configuration::get_treasury_fee_rate<T0>(arg0));
                v7 = v7 + v15;
                (v13 - v15) / v12
            };
            0x1::vector::push_back<u64>(&mut v3, v14);
            v9 = v9 + 1;
        };
        (v6, v7, 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::utils::get_value_with_rate(v5, 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::configuration::get_treasury_reserve_rate<T0>(arg0)), v8, v2, v3)
    }

    public(friend) fun end_round<T0>(arg0: &0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::configuration::Configuration<T0>, arg1: &mut RoundInfo<T0>, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: vector<u64>, arg6: vector<u64>) {
        arg1.winning_number = arg2;
        arg1.drand_signature = arg3;
        arg1.drand_round_id = arg4;
        arg1.reward_ticket_per_level = arg5;
        arg1.reward_per_level = arg6;
        arg1.is_finished = true;
        let v0 = EndRoundEvent{
            round_id                : 0x2::object::uid_to_inner(&arg1.id),
            epoch                   : arg1.epoch,
            pool                    : 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::configuration::get_pool<T0>(arg0),
            start_timestamp         : arg1.start_timestamp,
            lock_timestamp          : arg1.lock_timestamp,
            close_timestamp         : arg1.close_timestamp,
            init_prize_pool         : arg1.init_prize_pool,
            ticket_price            : arg1.ticket_price,
            reward_breakdown        : arg1.reward_breakdown,
            winning_number          : arg1.winning_number,
            drand_signature         : arg1.drand_signature,
            drand_round_id          : arg1.drand_round_id,
            total_tickets           : 0x2::table::length<0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::ticket::TicketKey<T0>, 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::ticket::TicketValue<T0>>(&arg1.tickets),
            total_users             : 0x2::table::length<address, vector<u64>>(&arg1.users),
            reward_ticket_per_level : arg1.reward_ticket_per_level,
            reward_per_level        : arg1.reward_per_level,
            is_finished             : arg1.is_finished,
            error_code              : arg1.error_code,
        };
        0x2::event::emit<EndRoundEvent>(v0);
    }

    public fun get_close_timestamp<T0>(arg0: &RoundInfo<T0>) : u64 {
        arg0.close_timestamp
    }

    public fun get_epoch<T0>(arg0: &RoundInfo<T0>) : u64 {
        arg0.epoch
    }

    public fun get_init_prize_pool<T0>(arg0: &RoundInfo<T0>) : u64 {
        arg0.init_prize_pool
    }

    public fun get_lock_timestamp<T0>(arg0: &RoundInfo<T0>) : u64 {
        arg0.lock_timestamp
    }

    public fun get_reward_by_level<T0>(arg0: &RoundInfo<T0>, arg1: u64) : u64 {
        assert!(arg1 > 0 && arg1 <= 0x1::vector::length<u64>(&arg0.reward_per_level), 402);
        *0x1::vector::borrow<u64>(&arg0.reward_per_level, arg1 - 1)
    }

    public fun get_ticket_price<T0>(arg0: &RoundInfo<T0>) : u64 {
        arg0.ticket_price
    }

    public fun get_total_tickets<T0>(arg0: &RoundInfo<T0>) : u64 {
        0x2::table::length<0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::ticket::TicketKey<T0>, 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::ticket::TicketValue<T0>>(&arg0.tickets)
    }

    public fun get_winning_number<T0>(arg0: &RoundInfo<T0>) : vector<u8> {
        arg0.winning_number
    }

    public fun is_error<T0>(arg0: &RoundInfo<T0>) : bool {
        arg0.is_finished && arg0.error_code > 0
    }

    public fun is_finished<T0>(arg0: &RoundInfo<T0>) : bool {
        arg0.is_finished
    }

    public(friend) fun new_round_key<T0>(arg0: u64) : RoundKey<T0> {
        RoundKey<T0>{epoch: arg0}
    }

    public(friend) fun start_round<T0>(arg0: &0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::configuration::Configuration<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : RoundInfo<T0> {
        let v0 = RoundInfo<T0>{
            id                      : 0x2::object::new(arg7),
            epoch                   : arg1,
            start_timestamp         : arg2,
            lock_timestamp          : arg3,
            close_timestamp         : arg4,
            init_prize_pool         : arg5,
            ticket_price            : arg6,
            reward_breakdown        : 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::configuration::get_reward_breakdown<T0>(arg0),
            winning_number          : 0x1::vector::empty<u8>(),
            drand_signature         : 0x1::vector::empty<u8>(),
            drand_round_id          : 0,
            tickets                 : 0x2::table::new<0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::ticket::TicketKey<T0>, 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::ticket::TicketValue<T0>>(arg7),
            users                   : 0x2::table::new<address, vector<u64>>(arg7),
            reward_ticket_per_level : 0x1::vector::empty<u64>(),
            reward_per_level        : 0x1::vector::empty<u64>(),
            is_finished             : false,
            error_code              : 0,
        };
        let v1 = StartRoundEvent{
            round_id         : 0x2::object::uid_to_inner(&v0.id),
            epoch            : arg1,
            pool             : 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::configuration::get_pool<T0>(arg0),
            start_timestamp  : v0.start_timestamp,
            lock_timestamp   : v0.lock_timestamp,
            close_timestamp  : v0.close_timestamp,
            init_prize_pool  : arg5,
            ticket_price     : v0.ticket_price,
            reward_breakdown : v0.reward_breakdown,
        };
        0x2::event::emit<StartRoundEvent>(v1);
        v0
    }

    public(friend) fun stop_round<T0>(arg0: &0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::configuration::Configuration<T0>, arg1: &mut RoundInfo<T0>, arg2: u64) {
        arg1.is_finished = true;
        arg1.error_code = arg2;
        let v0 = EndRoundEvent{
            round_id                : 0x2::object::uid_to_inner(&arg1.id),
            epoch                   : arg1.epoch,
            pool                    : 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::configuration::get_pool<T0>(arg0),
            start_timestamp         : arg1.start_timestamp,
            lock_timestamp          : arg1.lock_timestamp,
            close_timestamp         : arg1.close_timestamp,
            init_prize_pool         : arg1.init_prize_pool,
            ticket_price            : arg1.ticket_price,
            reward_breakdown        : arg1.reward_breakdown,
            winning_number          : arg1.winning_number,
            drand_signature         : arg1.drand_signature,
            drand_round_id          : arg1.drand_round_id,
            total_tickets           : 0x2::table::length<0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::ticket::TicketKey<T0>, 0x34108d0d84c6fbddef049b037360e8d9dbff26959af0ed37af208518142c63ad::ticket::TicketValue<T0>>(&arg1.tickets),
            total_users             : 0x2::table::length<address, vector<u64>>(&arg1.users),
            reward_ticket_per_level : arg1.reward_ticket_per_level,
            reward_per_level        : arg1.reward_per_level,
            is_finished             : arg1.is_finished,
            error_code              : arg1.error_code,
        };
        0x2::event::emit<EndRoundEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

