module 0xd4b2f75f1103462b2a1c1ff7969b4c3addad400e8bc166915f48242b3cac091f::ticket {
    struct Ticket has drop, store {
        buyer: 0x1::option::Option<address>,
        picks: 0xd4b2f75f1103462b2a1c1ff7969b4c3addad400e8bc166915f48242b3cac091f::picks::Picks,
        round_id: u64,
        lottery_id: 0x2::object::ID,
        owner: 0x1::option::Option<0x1::ascii::String>,
        chain_id: 0x1::option::Option<0x1::ascii::String>,
        app_id: 0x1::option::Option<0x1::ascii::String>,
        ref_id: 0x1::option::Option<0x1::ascii::String>,
    }

    struct WinningTicket has copy, drop {
        round_id: u64,
        lottery_id: 0x2::object::ID,
        picks: 0xd4b2f75f1103462b2a1c1ff7969b4c3addad400e8bc166915f48242b3cac091f::picks::Picks,
        combination: 0xd4b2f75f1103462b2a1c1ff7969b4c3addad400e8bc166915f48242b3cac091f::combination::Combination,
        buyer: 0x1::option::Option<address>,
        owner: 0x1::option::Option<0x1::ascii::String>,
        chain_id: 0x1::option::Option<0x1::ascii::String>,
        app_id: 0x1::option::Option<0x1::ascii::String>,
        ref_id: 0x1::option::Option<0x1::ascii::String>,
        coin_type: 0x1::ascii::String,
        reward_amount: u64,
    }

    public(friend) fun new(arg0: 0x1::option::Option<address>, arg1: 0xd4b2f75f1103462b2a1c1ff7969b4c3addad400e8bc166915f48242b3cac091f::picks::Picks, arg2: 0x2::object::ID, arg3: u64, arg4: 0x1::option::Option<0x1::ascii::String>, arg5: 0x1::option::Option<0x1::ascii::String>, arg6: 0x1::option::Option<0x1::ascii::String>, arg7: 0x1::option::Option<0x1::ascii::String>) : Ticket {
        Ticket{
            buyer      : arg0,
            picks      : arg1,
            round_id   : arg3,
            lottery_id : arg2,
            owner      : arg4,
            chain_id   : arg5,
            app_id     : arg6,
            ref_id     : arg7,
        }
    }

    public fun buyer(arg0: &Ticket) : 0x1::option::Option<address> {
        arg0.buyer
    }

    public(friend) fun emit_winning_event<T0>(arg0: Ticket, arg1: 0xd4b2f75f1103462b2a1c1ff7969b4c3addad400e8bc166915f48242b3cac091f::combination::Combination, arg2: u64) : WinningTicket {
        let Ticket {
            buyer      : v0,
            picks      : v1,
            round_id   : v2,
            lottery_id : v3,
            owner      : v4,
            chain_id   : v5,
            app_id     : v6,
            ref_id     : v7,
        } = arg0;
        WinningTicket{
            round_id      : v2,
            lottery_id    : v3,
            picks         : v1,
            combination   : arg1,
            buyer         : v0,
            owner         : v4,
            chain_id      : v5,
            app_id        : v6,
            ref_id        : v7,
            coin_type     : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            reward_amount : arg2,
        }
    }

    public fun get_combination(arg0: &Ticket, arg1: &0xd4b2f75f1103462b2a1c1ff7969b4c3addad400e8bc166915f48242b3cac091f::draw::DrawResult) : 0xd4b2f75f1103462b2a1c1ff7969b4c3addad400e8bc166915f48242b3cac091f::combination::Combination {
        0xd4b2f75f1103462b2a1c1ff7969b4c3addad400e8bc166915f48242b3cac091f::combination::new(0xd4b2f75f1103462b2a1c1ff7969b4c3addad400e8bc166915f48242b3cac091f::picks::get_normal_hits(&arg0.picks, 0xd4b2f75f1103462b2a1c1ff7969b4c3addad400e8bc166915f48242b3cac091f::draw::normal_numbers(arg1)), 0xd4b2f75f1103462b2a1c1ff7969b4c3addad400e8bc166915f48242b3cac091f::picks::get_special_hits(&arg0.picks, 0xd4b2f75f1103462b2a1c1ff7969b4c3addad400e8bc166915f48242b3cac091f::draw::special_numbers(arg1)))
    }

    // decompiled from Move bytecode v6
}

