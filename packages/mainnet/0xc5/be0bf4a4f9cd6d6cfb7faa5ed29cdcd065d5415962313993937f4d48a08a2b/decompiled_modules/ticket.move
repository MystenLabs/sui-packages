module 0xc5be0bf4a4f9cd6d6cfb7faa5ed29cdcd065d5415962313993937f4d48a08a2b::ticket {
    struct Ticket has drop, store {
        picks: 0xc5be0bf4a4f9cd6d6cfb7faa5ed29cdcd065d5415962313993937f4d48a08a2b::picks::Picks,
        owner: 0x1::string::String,
        round_id: u64,
        lottery_id: 0x2::object::ID,
        chain_id: 0x1::string::String,
        app_id: 0x1::string::String,
        ref_id: 0x1::string::String,
        ticket_cost: u64,
        idempotency_id: 0x1::string::String,
    }

    struct NewTicketEvent has copy, drop {
        owner: 0x1::string::String,
        normal_numbers: vector<u8>,
        special_numbers: vector<u8>,
        lottery_id: 0x2::object::ID,
        round_id: u64,
        chain_id: 0x1::string::String,
        app_id: 0x1::string::String,
        ref_id: 0x1::string::String,
        idempotency_id: 0x1::string::String,
        ticket_cost: u64,
    }

    struct WinningTicketEvent has copy, drop {
        round_id: u64,
        lottery_id: 0x2::object::ID,
        picks: 0xc5be0bf4a4f9cd6d6cfb7faa5ed29cdcd065d5415962313993937f4d48a08a2b::picks::Picks,
        combination: 0xc5be0bf4a4f9cd6d6cfb7faa5ed29cdcd065d5415962313993937f4d48a08a2b::combination::Combination,
        owner: 0x1::string::String,
        chain_id: 0x1::string::String,
        app_id: 0x1::string::String,
        ref_id: 0x1::string::String,
        ticket_cost: u64,
        idempotency_id: 0x1::string::String,
        is_jackpot: bool,
        coin_type: 0x1::string::String,
        reward_amount: u64,
    }

    public(friend) fun new(arg0: 0xc5be0bf4a4f9cd6d6cfb7faa5ed29cdcd065d5415962313993937f4d48a08a2b::picks::Picks, arg1: 0x2::object::ID, arg2: u64, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: u64) : Ticket {
        Ticket{
            picks          : arg0,
            owner          : arg3,
            round_id       : arg2,
            lottery_id     : arg1,
            chain_id       : arg4,
            app_id         : arg5,
            ref_id         : arg6,
            ticket_cost    : arg8,
            idempotency_id : arg7,
        }
    }

    public(friend) fun emit_new_ticket(arg0: &Ticket, arg1: 0x2::object::ID, arg2: u64) {
        let v0 = NewTicketEvent{
            owner           : arg0.owner,
            normal_numbers  : *0x2::vec_set::keys<u8>(0xc5be0bf4a4f9cd6d6cfb7faa5ed29cdcd065d5415962313993937f4d48a08a2b::picks::normal_numbers(&arg0.picks)),
            special_numbers : *0x2::vec_set::keys<u8>(0xc5be0bf4a4f9cd6d6cfb7faa5ed29cdcd065d5415962313993937f4d48a08a2b::picks::special_numbers(&arg0.picks)),
            lottery_id      : arg1,
            round_id        : arg2,
            chain_id        : arg0.chain_id,
            app_id          : arg0.app_id,
            ref_id          : arg0.ref_id,
            idempotency_id  : arg0.idempotency_id,
            ticket_cost     : arg0.ticket_cost,
        };
        0x2::event::emit<NewTicketEvent>(v0);
    }

    public(friend) fun emit_winning_event<T0>(arg0: Ticket, arg1: 0xc5be0bf4a4f9cd6d6cfb7faa5ed29cdcd065d5415962313993937f4d48a08a2b::combination::Combination, arg2: u64, arg3: bool) {
        let Ticket {
            picks          : v0,
            owner          : v1,
            round_id       : v2,
            lottery_id     : v3,
            chain_id       : v4,
            app_id         : v5,
            ref_id         : v6,
            ticket_cost    : v7,
            idempotency_id : v8,
        } = arg0;
        let v9 = WinningTicketEvent{
            round_id       : v2,
            lottery_id     : v3,
            picks          : v0,
            combination    : arg1,
            owner          : v1,
            chain_id       : v4,
            app_id         : v5,
            ref_id         : v6,
            ticket_cost    : v7,
            idempotency_id : v8,
            is_jackpot     : arg3,
            coin_type      : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())),
            reward_amount  : arg2,
        };
        0x2::event::emit<WinningTicketEvent>(v9);
    }

    public fun get_combination(arg0: &Ticket, arg1: &0xc5be0bf4a4f9cd6d6cfb7faa5ed29cdcd065d5415962313993937f4d48a08a2b::draw::DrawResult) : 0xc5be0bf4a4f9cd6d6cfb7faa5ed29cdcd065d5415962313993937f4d48a08a2b::combination::Combination {
        0xc5be0bf4a4f9cd6d6cfb7faa5ed29cdcd065d5415962313993937f4d48a08a2b::combination::new(0xc5be0bf4a4f9cd6d6cfb7faa5ed29cdcd065d5415962313993937f4d48a08a2b::picks::get_normal_hits(&arg0.picks, 0xc5be0bf4a4f9cd6d6cfb7faa5ed29cdcd065d5415962313993937f4d48a08a2b::draw::normal_numbers(arg1)), 0xc5be0bf4a4f9cd6d6cfb7faa5ed29cdcd065d5415962313993937f4d48a08a2b::picks::get_special_hits(&arg0.picks, 0xc5be0bf4a4f9cd6d6cfb7faa5ed29cdcd065d5415962313993937f4d48a08a2b::draw::special_numbers(arg1)))
    }

    // decompiled from Move bytecode v6
}

