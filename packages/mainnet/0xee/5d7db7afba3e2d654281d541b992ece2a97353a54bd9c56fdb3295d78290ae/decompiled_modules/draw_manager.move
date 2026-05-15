module 0xee5d7db7afba3e2d654281d541b992ece2a97353a54bd9c56fdb3295d78290ae::draw_manager {
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
        vrf_seed: vector<u8>,
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
            next_spark_ms    : 0,
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

    fun next_seed(arg0: vector<u8>, arg1: u64) : vector<u8> {
        0x1::vector::push_back<u8>(&mut arg0, ((arg1 & 255) as u8));
        arg0
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

    entry fun trigger_pulse(arg0: &mut DrawState, arg1: &mut 0xee5d7db7afba3e2d654281d541b992ece2a97353a54bd9c56fdb3295d78290ae::reward_pool::RewardPool, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &AdminCap, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 >= arg0.next_pulse_ms, 1);
        let v1 = 0x1::vector::length<address>(&arg0.pulse_tickets);
        assert!(v1 > 0, 2);
        let v2 = 0;
        while (v2 < 4) {
            0xee5d7db7afba3e2d654281d541b992ece2a97353a54bd9c56fdb3295d78290ae::reward_pool::award_pulse(arg1, 0xee5d7db7afba3e2d654281d541b992ece2a97353a54bd9c56fdb3295d78290ae::reward_pool::pulse_balance(arg1) / 4, *0x1::vector::borrow<address>(&arg0.pulse_tickets, vrf_to_index(&arg2, v1)), arg5);
            arg2 = next_seed(arg2, v2);
            v2 = v2 + 1;
        };
        arg0.pulse_draw_count = arg0.pulse_draw_count + 1;
        arg0.next_pulse_ms = v0 + 604800000;
        arg0.pulse_tickets = vector[];
        let v3 = DrawTriggered{
            draw_type    : 1,
            draw_index   : arg0.pulse_draw_count,
            vrf_seed     : arg2,
            winner_count : 4,
        };
        0x2::event::emit<DrawTriggered>(v3);
    }

    entry fun trigger_spark(arg0: &mut DrawState, arg1: &mut 0xee5d7db7afba3e2d654281d541b992ece2a97353a54bd9c56fdb3295d78290ae::reward_pool::RewardPool, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &AdminCap, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 >= arg0.next_spark_ms, 1);
        let v1 = 0x1::vector::length<address>(&arg0.spark_tickets);
        assert!(v1 > 0, 2);
        let v2 = 0;
        while (v2 < 15) {
            0xee5d7db7afba3e2d654281d541b992ece2a97353a54bd9c56fdb3295d78290ae::reward_pool::award_spark(arg1, 0xee5d7db7afba3e2d654281d541b992ece2a97353a54bd9c56fdb3295d78290ae::reward_pool::spark_balance(arg1) / 15, *0x1::vector::borrow<address>(&arg0.spark_tickets, vrf_to_index(&arg2, v1)), arg5);
            arg2 = next_seed(arg2, v2);
            v2 = v2 + 1;
        };
        arg0.spark_draw_count = arg0.spark_draw_count + 1;
        arg0.next_spark_ms = v0 + 86400000;
        arg0.spark_tickets = vector[];
        let v3 = DrawTriggered{
            draw_type    : 0,
            draw_index   : arg0.spark_draw_count,
            vrf_seed     : arg2,
            winner_count : 15,
        };
        0x2::event::emit<DrawTriggered>(v3);
    }

    entry fun trigger_surge(arg0: &mut DrawState, arg1: &mut 0xee5d7db7afba3e2d654281d541b992ece2a97353a54bd9c56fdb3295d78290ae::reward_pool::RewardPool, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &AdminCap, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 >= arg0.next_surge_ms, 1);
        let v1 = 0x1::vector::length<address>(&arg0.surge_tickets);
        assert!(v1 > 0, 2);
        0xee5d7db7afba3e2d654281d541b992ece2a97353a54bd9c56fdb3295d78290ae::reward_pool::award_surge(arg1, 0xee5d7db7afba3e2d654281d541b992ece2a97353a54bd9c56fdb3295d78290ae::reward_pool::surge_balance(arg1), *0x1::vector::borrow<address>(&arg0.surge_tickets, vrf_to_index(&arg2, v1)), arg5);
        arg0.surge_draw_count = arg0.surge_draw_count + 1;
        arg0.next_surge_ms = v0 + 2592000000;
        arg0.surge_tickets = vector[];
        let v2 = DrawTriggered{
            draw_type    : 2,
            draw_index   : arg0.surge_draw_count,
            vrf_seed     : arg2,
            winner_count : 1,
        };
        0x2::event::emit<DrawTriggered>(v2);
    }

    fun vrf_to_index(arg0: &vector<u8>, arg1: u64) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 8 && v1 < 0x1::vector::length<u8>(arg0)) {
            let v2 = v0 << 8;
            v0 = v2 | (*0x1::vector::borrow<u8>(arg0, v1) as u64);
            v1 = v1 + 1;
        };
        v0 % arg1
    }

    // decompiled from Move bytecode v7
}

