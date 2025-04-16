module 0xb53b9a6bd8095b9b47d534cc0b83f8b2ff29911c16df88416e80e02f75dc3763::lottery_ticket {
    struct ManagerCap has store, key {
        id: 0x2::object::UID,
    }

    struct LOTTERY_TICKET has drop {
        dummy_field: bool,
    }

    struct Ticket has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        link: 0x1::string::String,
        image_url: 0x1::string::String,
        project_url: 0x1::string::String,
        creator: 0x1::string::String,
        ticket_number_set: vector<0x1::string::String>,
        pool_no: u64,
        is_in_pool: bool,
    }

    struct TicketPool has store, key {
        id: 0x2::object::UID,
        tickets: 0x2::table_vec::TableVec<Ticket>,
        is_live: bool,
    }

    public(friend) fun addTicketNumber(arg0: &mut Ticket, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock) {
        let v0 = 1;
        while (v0 <= arg2) {
            let v1 = 0x1::string::utf8(b"");
            0x1::string::append(&mut v1, 0x1::u64::to_string(arg1));
            0x1::string::append(&mut v1, 0x1::u64::to_string(v0));
            0x1::string::append(&mut v1, 0x1::u64::to_string(0x2::clock::timestamp_ms(arg3)));
            0x1::vector::push_back<0x1::string::String>(&mut arg0.ticket_number_set, v1);
            v0 = v0 + 1;
        };
    }

    entry fun closeTicketPool(arg0: &ManagerCap, arg1: TicketPool) {
        deleteTicketPool(arg1);
    }

    public(friend) fun createTicketPool(arg0: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = TicketPool{
            id      : 0x2::object::new(arg0),
            tickets : 0x2::table_vec::empty<Ticket>(arg0),
            is_live : true,
        };
        0x2::transfer::share_object<TicketPool>(v0);
        0x2::object::id<TicketPool>(&v0)
    }

    public(friend) fun deleteTicketPool(arg0: TicketPool) {
        let TicketPool {
            id      : v0,
            tickets : v1,
            is_live : _,
        } = arg0;
        0x2::table_vec::destroy_empty<Ticket>(v1);
        0x2::object::delete(v0);
    }

    entry fun deposit_ticket(arg0: &ManagerCap, arg1: &mut TicketPool, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = Ticket{
            id                : 0x2::object::new(arg7),
            name              : arg2,
            description       : arg3,
            link              : arg4,
            image_url         : arg5,
            project_url       : arg6,
            creator           : 0x1::string::utf8(b"LuckyOneSui"),
            ticket_number_set : 0x1::vector::empty<0x1::string::String>(),
            pool_no           : 0,
            is_in_pool        : false,
        };
        0x2::table_vec::push_back<Ticket>(&mut arg1.tickets, v0);
    }

    public(friend) fun getMutTicketNumberSet(arg0: &mut Ticket) : &mut vector<0x1::string::String> {
        &mut arg0.ticket_number_set
    }

    public(friend) fun getTicket(arg0: &mut TicketPool, arg1: u64, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) : Ticket {
        assert!(arg0.is_live, 41);
        let v0 = &mut arg0.tickets;
        assert!(!0x2::table_vec::is_empty<Ticket>(v0), 42);
        let v1 = if (0x2::table_vec::length<Ticket>(v0) == 0) {
            let v2 = 0x1::string::utf8(b"");
            0x1::string::append(&mut v2, 0x2::address::to_string(0x2::tx_context::sender(arg3)));
            0x1::string::append(&mut v2, 0x1::string::utf8(b"-lucky1sui"));
            Ticket{id: 0x2::object::new(arg3), name: v2, description: v2, link: 0x1::string::utf8(b"https://lucky1sui.waruls.site"), image_url: 0x1::string::utf8(b"https://img.picui.cn/free/2025/04/16/67ffc967ae238.png"), project_url: 0x1::string::utf8(b"https://lucky1sui.waruls.site"), creator: 0x1::string::utf8(b"LuckyOneSui"), ticket_number_set: 0x1::vector::empty<0x1::string::String>(), pool_no: 0, is_in_pool: false}
        } else if (0x2::table_vec::length<Ticket>(v0) == 1) {
            0x2::table_vec::pop_back<Ticket>(&mut arg0.tickets)
        } else {
            let v3 = 0x2::random::new_generator(arg2, arg3);
            0x2::table_vec::swap_remove<Ticket>(v0, 0x2::random::generate_u64_in_range(&mut v3, 0, 0x2::table_vec::length<Ticket>(v0) - 1))
        };
        let v4 = v1;
        v4.pool_no = arg1;
        v4.is_in_pool = true;
        v4
    }

    public(friend) fun getTicketNumberSet(arg0: &Ticket) : &vector<0x1::string::String> {
        &arg0.ticket_number_set
    }

    fun init(arg0: LOTTERY_TICKET, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://luckonesui.xyz"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://luckonesui.xyz"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"LuckyOneSui"));
        let v4 = 0x2::package::claim<LOTTERY_TICKET>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Ticket>(&v4, v0, v2, arg1);
        0x2::display::update_version<Ticket>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Ticket>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = ManagerCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<ManagerCap>(v6, 0x2::tx_context::sender(arg1));
    }

    entry fun newTicketPool(arg0: &ManagerCap, arg1: &mut 0x2::tx_context::TxContext) {
        createTicketPool(arg1);
    }

    public(friend) fun removeTicket(arg0: &mut Ticket) {
        arg0.is_in_pool = false;
    }

    public(friend) fun removeTicketNumber(arg0: &mut Ticket, arg1: 0x1::string::String) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::string::String>(&arg0.ticket_number_set)) {
            if (*0x1::vector::borrow<0x1::string::String>(&arg0.ticket_number_set, v0) == arg1) {
                0x1::vector::remove<0x1::string::String>(&mut arg0.ticket_number_set, v0);
                break
            };
            v0 = v0 + 1;
        };
    }

    public(friend) fun ticket_is_in_pool(arg0: &Ticket) : bool {
        arg0.is_in_pool
    }

    // decompiled from Move bytecode v6
}

