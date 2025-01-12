module 0xd683b01fe412e8a50e2bf6087caa55a676af341f87e2c1c5a9681fe680ee7fb5::ticket {
    struct Ticket has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        round: u64,
        price: u64,
        price_unit: 0x1::ascii::String,
        pool_type: 0x1::ascii::String,
        pool_end_time: u64,
        ticket_number: vector<u8>,
        buyer: address,
        buy_time: u64,
        lucky_number: 0x1::option::Option<vector<u8>>,
        drawn_time: 0x1::option::Option<u64>,
        prize_level: 0x1::option::Option<u8>,
        prize_bonus: 0x1::option::Option<u64>,
        claimed_by: 0x1::option::Option<address>,
        claimed_time: 0x1::option::Option<u64>,
    }

    struct TicketInfo has copy, drop, store {
        ticket_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        round: u64,
        price: u64,
        price_unit: 0x1::ascii::String,
        pool_type: 0x1::ascii::String,
        pool_end_time: u64,
        ticket_number: vector<u8>,
        buyer: address,
        buy_time: u64,
        lucky_number: 0x1::option::Option<vector<u8>>,
        drawn_time: 0x1::option::Option<u64>,
        prize_level: 0x1::option::Option<u8>,
        prize_bonus: 0x1::option::Option<u64>,
        claimed_by: 0x1::option::Option<address>,
        claimed_time: 0x1::option::Option<u64>,
    }

    struct TicketTransferred has copy, drop {
        ticket_id: 0x2::object::ID,
        from: address,
        to: address,
        transferred_time_ms: u64,
    }

    public(friend) fun add_claimed_info(arg0: &mut TicketInfo, arg1: u8, arg2: u64, arg3: address, arg4: u64) {
        assert!(is_unclaimed(arg0), 0);
        arg0.prize_level = 0x1::option::some<u8>(arg1);
        arg0.prize_bonus = 0x1::option::some<u64>(arg2);
        arg0.claimed_time = 0x1::option::some<u64>(arg4);
        arg0.claimed_by = 0x1::option::some<address>(arg3);
    }

    public(friend) fun add_lucky_number(arg0: &mut TicketInfo, arg1: vector<u8>) {
        assert!(is_undrawn(arg0), 0);
        arg0.lucky_number = 0x1::option::some<vector<u8>>(arg1);
    }

    public(friend) fun add_lucky_numbers(arg0: &mut 0x2::vec_map::VecMap<0x2::object::ID, TicketInfo>, arg1: vector<u8>, arg2: 0xd683b01fe412e8a50e2bf6087caa55a676af341f87e2c1c5a9681fe680ee7fb5::prize::PrizeLevelDistribution, arg3: u64) {
        let v0 = 0;
        while (v0 < 0x2::vec_map::size<0x2::object::ID, TicketInfo>(arg0)) {
            let (_, v2) = 0x2::vec_map::get_entry_by_idx_mut<0x2::object::ID, TicketInfo>(arg0, v0);
            let v3 = info_ticket_number(v2);
            let v4 = 0xd683b01fe412e8a50e2bf6087caa55a676af341f87e2c1c5a9681fe680ee7fb5::helper::calc_prize_level(&arg1, &v3);
            v2.lucky_number = 0x1::option::some<vector<u8>>(arg1);
            v2.prize_level = 0x1::option::some<u8>(v4);
            v2.prize_bonus = 0x1::option::some<u64>(0xd683b01fe412e8a50e2bf6087caa55a676af341f87e2c1c5a9681fe680ee7fb5::prize::get_prize_level_amount(&arg2, v4));
            v2.drawn_time = 0x1::option::some<u64>(arg3);
            v0 = v0 + 1;
        };
    }

    public fun as_info(arg0: &Ticket) : TicketInfo {
        TicketInfo{
            ticket_id     : 0x2::object::id<Ticket>(arg0),
            pool_id       : arg0.pool_id,
            round         : arg0.round,
            price         : arg0.price,
            price_unit    : arg0.price_unit,
            pool_type     : arg0.pool_type,
            pool_end_time : arg0.pool_end_time,
            ticket_number : arg0.ticket_number,
            buyer         : arg0.buyer,
            buy_time      : arg0.buy_time,
            lucky_number  : arg0.lucky_number,
            drawn_time    : arg0.drawn_time,
            prize_level   : arg0.prize_level,
            prize_bonus   : arg0.prize_bonus,
            claimed_by    : arg0.claimed_by,
            claimed_time  : arg0.claimed_time,
        }
    }

    public fun create_ticket(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: 0x1::ascii::String, arg4: 0x1::ascii::String, arg5: u64, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) : Ticket {
        Ticket{
            id            : 0x2::object::new(arg7),
            pool_id       : arg0,
            round         : arg1,
            price         : arg2,
            price_unit    : arg3,
            pool_type     : arg4,
            pool_end_time : arg5,
            ticket_number : arg6,
            buyer         : 0x2::tx_context::sender(arg7),
            buy_time      : 0x2::tx_context::epoch_timestamp_ms(arg7),
            lucky_number  : 0x1::option::none<vector<u8>>(),
            drawn_time    : 0x1::option::none<u64>(),
            prize_level   : 0x1::option::none<u8>(),
            prize_bonus   : 0x1::option::none<u64>(),
            claimed_by    : 0x1::option::none<address>(),
            claimed_time  : 0x1::option::none<u64>(),
        }
    }

    public fun emit_ticket_generated_event(arg0: &Ticket) {
        0x2::event::emit<TicketInfo>(as_info(arg0));
    }

    public fun emit_ticket_transferred_event(arg0: 0x2::object::ID, arg1: address, arg2: address, arg3: u64) {
        let v0 = TicketTransferred{
            ticket_id           : arg0,
            from                : arg1,
            to                  : arg2,
            transferred_time_ms : arg3,
        };
        0x2::event::emit<TicketTransferred>(v0);
    }

    public(friend) fun generate_a_ticket_number(arg0: &0x2::random::Random, arg1: &mut 0x2::tx_context::TxContext) : u8 {
        0xd683b01fe412e8a50e2bf6087caa55a676af341f87e2c1c5a9681fe680ee7fb5::helper::generate_u8(arg0, arg1, 0, 9)
    }

    public(friend) fun generate_ticket(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: 0x1::ascii::String, arg4: 0x1::ascii::String, arg5: u64, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) : Ticket {
        create_ticket(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    public(friend) fun generate_ticket_number(arg0: &0x2::random::Random, arg1: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = 0;
        let v1 = 0x1::vector::empty<u8>();
        while (v0 < 6) {
            0x1::vector::push_back<u8>(&mut v1, generate_a_ticket_number(arg0, arg1));
            v0 = v0 + 1;
        };
        v1
    }

    public(friend) fun generate_tickets(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: 0x1::ascii::String, arg4: 0x1::ascii::String, arg5: u64, arg6: vector<vector<u8>>, arg7: &mut 0x2::tx_context::TxContext) : vector<TicketInfo> {
        let v0 = 0x1::vector::empty<TicketInfo>();
        0x1::vector::reverse<vector<u8>>(&mut arg6);
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(&arg6)) {
            let v2 = generate_ticket(arg0, arg1, arg2, arg3, arg4, arg5, 0x1::vector::pop_back<vector<u8>>(&mut arg6), arg7);
            emit_ticket_generated_event(&v2);
            0x2::transfer::public_transfer<Ticket>(v2, 0x2::tx_context::sender(arg7));
            0x1::vector::push_back<TicketInfo>(&mut v0, as_info(&v2));
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<vector<u8>>(arg6);
        v0
    }

    public fun get_pool_id(arg0: &Ticket) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun get_price(arg0: &Ticket) : u64 {
        arg0.price
    }

    public fun get_round(arg0: &Ticket) : u64 {
        arg0.round
    }

    public fun get_ticket_id(arg0: &Ticket) : 0x2::object::ID {
        0x2::object::id<Ticket>(arg0)
    }

    public fun get_ticket_number(arg0: &Ticket) : vector<u8> {
        arg0.ticket_number
    }

    public fun info_claim_by(arg0: &TicketInfo) : 0x1::option::Option<address> {
        arg0.claimed_by
    }

    public fun info_pool_id(arg0: &TicketInfo) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun info_round(arg0: &TicketInfo) : u64 {
        arg0.round
    }

    public fun info_ticket_id(arg0: &TicketInfo) : 0x2::object::ID {
        arg0.ticket_id
    }

    public fun info_ticket_number(arg0: &TicketInfo) : vector<u8> {
        arg0.ticket_number
    }

    public fun is_claimed(arg0: &Ticket) : bool {
        0x1::option::is_some<u64>(&arg0.claimed_time)
    }

    public fun is_unclaimed(arg0: &TicketInfo) : bool {
        0x1::option::is_none<address>(&arg0.claimed_by) && 0x1::option::is_none<u64>(&arg0.claimed_time)
    }

    public fun is_undrawn(arg0: &TicketInfo) : bool {
        0x1::option::is_none<vector<u8>>(&arg0.lucky_number)
    }

    public fun split_prize_level_by_lucky_number(arg0: vector<TicketInfo>, arg1: vector<u8>) : 0x2::vec_map::VecMap<u8, vector<0x2::object::ID>> {
        let v0 = 0x2::vec_map::empty<u8, vector<0x2::object::ID>>();
        0x1::vector::reverse<TicketInfo>(&mut arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<TicketInfo>(&arg0)) {
            let v2 = 0x1::vector::pop_back<TicketInfo>(&mut arg0);
            let v3 = 0xd683b01fe412e8a50e2bf6087caa55a676af341f87e2c1c5a9681fe680ee7fb5::helper::calc_prize_level(&arg1, &v2.ticket_number);
            if (0x2::vec_map::contains<u8, vector<0x2::object::ID>>(&v0, &v3)) {
                0x1::vector::push_back<0x2::object::ID>(0x2::vec_map::get_mut<u8, vector<0x2::object::ID>>(&mut v0, &v3), info_ticket_id(&v2));
            } else {
                let v4 = 0x1::vector::empty<0x2::object::ID>();
                0x1::vector::push_back<0x2::object::ID>(&mut v4, info_ticket_id(&v2));
                0x2::vec_map::insert<u8, vector<0x2::object::ID>>(&mut v0, v3, v4);
            };
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<TicketInfo>(arg0);
        v0
    }

    public(friend) fun update_claimed_info(arg0: &mut Ticket, arg1: vector<u8>, arg2: u8, arg3: u64, arg4: address, arg5: u64, arg6: 0x1::option::Option<u64>) {
        assert!(0x1::option::is_none<u64>(&arg0.claimed_time), 0);
        arg0.lucky_number = 0x1::option::some<vector<u8>>(arg1);
        arg0.prize_level = 0x1::option::some<u8>(arg2);
        arg0.prize_bonus = 0x1::option::some<u64>(arg3);
        arg0.claimed_time = 0x1::option::some<u64>(arg5);
        arg0.claimed_by = 0x1::option::some<address>(arg4);
        arg0.drawn_time = arg6;
    }

    public fun validate_ticket_numbers(arg0: vector<vector<u8>>) {
        0x1::vector::reverse<vector<u8>>(&mut arg0);
        let v0 = 0;
        /* label 1 */
        while (v0 < 0x1::vector::length<vector<u8>>(&arg0)) {
            let v1 = 0x1::vector::pop_back<vector<u8>>(&mut arg0);
            if ((0x1::vector::length<u8>(&v1) as u8) == 6) {
                let v2 = &v1;
                let v3 = 0;
                let v4;
                while (v3 < 0x1::vector::length<u8>(v2)) {
                    let v5 = 0x1::vector::borrow<u8>(v2, v3);
                    let v6 = *v5 >= 0 && *v5 <= 9;
                    if (!v6) {
                        v4 = false;
                        /* label 13 */
                        /* label 14 */
                        assert!(v4, 3);
                        v0 = v0 + 1;
                        /* goto 1 */
                        continue
                    };
                    v3 = v3 + 1;
                };
                v4 = true;
                /* goto 13 */
            } else {
                /* goto 14 */
            };
        };
        0x1::vector::destroy_empty<vector<u8>>(arg0);
    }

    // decompiled from Move bytecode v6
}

