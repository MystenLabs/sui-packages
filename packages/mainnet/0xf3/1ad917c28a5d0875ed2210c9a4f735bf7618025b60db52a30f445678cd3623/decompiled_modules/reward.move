module 0xf31ad917c28a5d0875ed2210c9a4f735bf7618025b60db52a30f445678cd3623::reward {
    struct TicketType has copy, drop, store {
        community_id: 0x2::object::ID,
        ticket_name: 0x1::string::String,
    }

    struct TicketTypeKey<phantom T0: copy + drop + store> has copy, drop, store {
        community_id: 0x2::object::ID,
        ticket_name: 0x1::string::String,
    }

    struct Ticket has store {
        name: 0x1::string::String,
        value: u64,
    }

    public(friend) fun add_ticket_value(arg0: &mut Ticket, arg1: u64) {
        arg0.value = arg0.value + arg1;
    }

    public fun check_ticket_type(arg0: &mut 0xf31ad917c28a5d0875ed2210c9a4f735bf7618025b60db52a30f445678cd3623::community::Community, arg1: 0x1::string::String) : bool {
        let v0 = TicketTypeKey<TicketType>{
            community_id : 0x2::object::id<0xf31ad917c28a5d0875ed2210c9a4f735bf7618025b60db52a30f445678cd3623::community::Community>(arg0),
            ticket_name  : arg1,
        };
        0x2::dynamic_field::exists_<TicketTypeKey<TicketType>>(0xf31ad917c28a5d0875ed2210c9a4f735bf7618025b60db52a30f445678cd3623::community::get_mut_uid(arg0), v0)
    }

    public(friend) fun new_ticket(arg0: 0x1::string::String, arg1: u64) : Ticket {
        Ticket{
            name  : arg0,
            value : arg1,
        }
    }

    public fun new_ticket_type(arg0: &mut 0xf31ad917c28a5d0875ed2210c9a4f735bf7618025b60db52a30f445678cd3623::community::Community, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0xf31ad917c28a5d0875ed2210c9a4f735bf7618025b60db52a30f445678cd3623::community::Community>(arg0);
        assert!(0xf31ad917c28a5d0875ed2210c9a4f735bf7618025b60db52a30f445678cd3623::community::has_permission<0xf31ad917c28a5d0875ed2210c9a4f735bf7618025b60db52a30f445678cd3623::community::MarketManager>(arg0, 0x2::tx_context::sender(arg2)), 1);
        let v1 = TicketTypeKey<TicketType>{
            community_id : v0,
            ticket_name  : arg1,
        };
        assert!(!0x2::dynamic_field::exists_<TicketTypeKey<TicketType>>(0xf31ad917c28a5d0875ed2210c9a4f735bf7618025b60db52a30f445678cd3623::community::get_mut_uid(arg0), v1), 13906834294602465279);
        let v2 = TicketTypeKey<TicketType>{
            community_id : v0,
            ticket_name  : arg1,
        };
        let v3 = TicketType{
            community_id : v0,
            ticket_name  : arg1,
        };
        0x2::dynamic_field::add<TicketTypeKey<TicketType>, TicketType>(0xf31ad917c28a5d0875ed2210c9a4f735bf7618025b60db52a30f445678cd3623::community::get_mut_uid(arg0), v2, v3);
    }

    // decompiled from Move bytecode v6
}

