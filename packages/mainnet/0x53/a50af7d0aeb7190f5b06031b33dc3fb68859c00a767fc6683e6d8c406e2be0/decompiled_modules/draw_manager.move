module 0x53a50af7d0aeb7190f5b06031b33dc3fb68859c00a767fc6683e6d8c406e2be0::draw_manager {
    struct DrawState has key {
        id: 0x2::object::UID,
        admin: address,
        next_spark_ms: u64,
        next_pulse_ms: u64,
        next_surge_ms: u64,
        spark_tickets: vector<address>,
        pulse_tickets: vector<address>,
        surge_tickets: vector<address>,
        spark_draw_count: u64,
        pulse_draw_count: u64,
        surge_draw_count: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct DrawTriggered has copy, drop {
        draw_type: u8,
        draw_index: u64,
        winner_count: u64,
    }

    struct TicketsRegistered has copy, drop {
        draw_type: u8,
        staker: address,
        ticket_count: u64,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = DrawState{
            id               : 0x2::object::new(arg0),
            admin            : v0,
            next_spark_ms    : 1747317600000,
            next_pulse_ms    : 0,
            next_surge_ms    : 0,
            spark_tickets    : vector[],
            pulse_tickets    : vector[],
            surge_tickets    : vector[],
            spark_draw_count : 0,
            pulse_draw_count : 0,
            surge_draw_count : 0,
        };
        0x2::transfer::share_object<DrawState>(v1);
        let v2 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v2, v0);
    }

    public fun next_pulse_ms(arg0: &DrawState) : u64 {
        arg0.next_pulse_ms
    }

    public fun next_spark_ms(arg0: &DrawState) : u64 {
        arg0.next_spark_ms
    }

    public fun next_surge_ms(arg0: &DrawState) : u64 {
        arg0.next_surge_ms
    }

    public fun pulse_ticket_count(arg0: &DrawState) : u64 {
        0x1::vector::length<address>(&arg0.pulse_tickets)
    }

    entry fun register_pulse_tickets(arg0: &mut DrawState, arg1: address, arg2: u64, arg3: &AdminCap, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < arg2) {
            0x1::vector::push_back<address>(&mut arg0.pulse_tickets, arg1);
            v0 = v0 + 1;
        };
        let v1 = TicketsRegistered{
            draw_type    : 1,
            staker       : arg1,
            ticket_count : arg2,
        };
        0x2::event::emit<TicketsRegistered>(v1);
    }

    entry fun register_spark_tickets(arg0: &mut DrawState, arg1: address, arg2: u64, arg3: &AdminCap, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < arg2) {
            0x1::vector::push_back<address>(&mut arg0.spark_tickets, arg1);
            v0 = v0 + 1;
        };
        let v1 = TicketsRegistered{
            draw_type    : 0,
            staker       : arg1,
            ticket_count : arg2,
        };
        0x2::event::emit<TicketsRegistered>(v1);
    }

    entry fun register_surge_tickets(arg0: &mut DrawState, arg1: address, arg2: u64, arg3: &AdminCap, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < arg2) {
            0x1::vector::push_back<address>(&mut arg0.surge_tickets, arg1);
            v0 = v0 + 1;
        };
        let v1 = TicketsRegistered{
            draw_type    : 2,
            staker       : arg1,
            ticket_count : arg2,
        };
        0x2::event::emit<TicketsRegistered>(v1);
    }

    public fun spark_ticket_count(arg0: &DrawState) : u64 {
        0x1::vector::length<address>(&arg0.spark_tickets)
    }

    public fun surge_ticket_count(arg0: &DrawState) : u64 {
        0x1::vector::length<address>(&arg0.surge_tickets)
    }

    entry fun trigger_pulse(arg0: &mut DrawState, arg1: &mut 0x53a50af7d0aeb7190f5b06031b33dc3fb68859c00a767fc6683e6d8c406e2be0::reward_pool::RewardPool, arg2: &0x53a50af7d0aeb7190f5b06031b33dc3fb68859c00a767fc6683e6d8c406e2be0::reward_pool::PoolAdminCap, arg3: &0x2::random::Random, arg4: &0x2::clock::Clock, arg5: &AdminCap, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(v0 >= arg0.next_pulse_ms, 1);
        let v1 = 0x1::vector::length<address>(&arg0.pulse_tickets);
        assert!(v1 > 0, 2);
        let v2 = 0x2::random::new_generator(arg3, arg6);
        let v3 = 0;
        while (v3 < 4) {
            0x53a50af7d0aeb7190f5b06031b33dc3fb68859c00a767fc6683e6d8c406e2be0::reward_pool::award_pulse(arg1, 0x53a50af7d0aeb7190f5b06031b33dc3fb68859c00a767fc6683e6d8c406e2be0::reward_pool::pulse_balance(arg1) / 4, *0x1::vector::borrow<address>(&arg0.pulse_tickets, 0x2::random::generate_u64_in_range(&mut v2, 0, v1 - 1)), arg2, arg6);
            v3 = v3 + 1;
        };
        arg0.pulse_draw_count = arg0.pulse_draw_count + 1;
        arg0.next_pulse_ms = v0 + 604800000;
        arg0.pulse_tickets = vector[];
        let v4 = DrawTriggered{
            draw_type    : 1,
            draw_index   : arg0.pulse_draw_count,
            winner_count : 4,
        };
        0x2::event::emit<DrawTriggered>(v4);
    }

    entry fun trigger_spark(arg0: &mut DrawState, arg1: &mut 0x53a50af7d0aeb7190f5b06031b33dc3fb68859c00a767fc6683e6d8c406e2be0::reward_pool::RewardPool, arg2: &0x53a50af7d0aeb7190f5b06031b33dc3fb68859c00a767fc6683e6d8c406e2be0::reward_pool::PoolAdminCap, arg3: &0x2::random::Random, arg4: &0x2::clock::Clock, arg5: &AdminCap, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(v0 >= arg0.next_spark_ms, 1);
        let v1 = 0x1::vector::length<address>(&arg0.spark_tickets);
        assert!(v1 > 0, 2);
        let v2 = 0x2::random::new_generator(arg3, arg6);
        let v3 = 0;
        while (v3 < 3) {
            0x53a50af7d0aeb7190f5b06031b33dc3fb68859c00a767fc6683e6d8c406e2be0::reward_pool::award_spark(arg1, 0x53a50af7d0aeb7190f5b06031b33dc3fb68859c00a767fc6683e6d8c406e2be0::reward_pool::spark_balance(arg1) / 3, *0x1::vector::borrow<address>(&arg0.spark_tickets, 0x2::random::generate_u64_in_range(&mut v2, 0, v1 - 1)), arg2, arg6);
            v3 = v3 + 1;
        };
        arg0.spark_draw_count = arg0.spark_draw_count + 1;
        arg0.next_spark_ms = v0 + 21600000;
        arg0.spark_tickets = vector[];
        let v4 = DrawTriggered{
            draw_type    : 0,
            draw_index   : arg0.spark_draw_count,
            winner_count : 3,
        };
        0x2::event::emit<DrawTriggered>(v4);
    }

    entry fun trigger_surge(arg0: &mut DrawState, arg1: &mut 0x53a50af7d0aeb7190f5b06031b33dc3fb68859c00a767fc6683e6d8c406e2be0::reward_pool::RewardPool, arg2: &0x53a50af7d0aeb7190f5b06031b33dc3fb68859c00a767fc6683e6d8c406e2be0::reward_pool::PoolAdminCap, arg3: &0x2::random::Random, arg4: &0x2::clock::Clock, arg5: &AdminCap, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(v0 >= arg0.next_surge_ms, 1);
        let v1 = 0x1::vector::length<address>(&arg0.surge_tickets);
        assert!(v1 > 0, 2);
        let v2 = 0x2::random::new_generator(arg3, arg6);
        0x53a50af7d0aeb7190f5b06031b33dc3fb68859c00a767fc6683e6d8c406e2be0::reward_pool::award_surge(arg1, 0x53a50af7d0aeb7190f5b06031b33dc3fb68859c00a767fc6683e6d8c406e2be0::reward_pool::surge_balance(arg1), *0x1::vector::borrow<address>(&arg0.surge_tickets, 0x2::random::generate_u64_in_range(&mut v2, 0, v1 - 1)), arg2, arg6);
        arg0.surge_draw_count = arg0.surge_draw_count + 1;
        arg0.next_surge_ms = v0 + 2592000000;
        arg0.surge_tickets = vector[];
        let v3 = DrawTriggered{
            draw_type    : 2,
            draw_index   : arg0.surge_draw_count,
            winner_count : 1,
        };
        0x2::event::emit<DrawTriggered>(v3);
    }

    // decompiled from Move bytecode v7
}

