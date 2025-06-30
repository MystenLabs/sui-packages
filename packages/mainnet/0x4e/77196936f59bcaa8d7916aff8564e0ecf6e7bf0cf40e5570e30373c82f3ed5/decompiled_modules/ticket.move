module 0x2f650a5162e4f7ef12b9adfbc2fadff1c30574572ebe2ed650b64a75f85b056b::ticket {
    struct TicketRegistry has store, key {
        id: 0x2::object::UID,
        seasons: 0x2::table::Table<u64, 0x2::table::Table<address, u64>>,
    }

    struct TicketReceiveEvent<T0: copy + drop> has copy, drop {
        season: u64,
        game_mode: 0x1::string::String,
        game_mode_data: T0,
        receiver: address,
        ticket_amount: u64,
    }

    struct TicketDeductEvent has copy, drop {
        season: u64,
        ticket_amount: u64,
    }

    public fun create_ticket_registry(arg0: &mut 0x2f650a5162e4f7ef12b9adfbc2fadff1c30574572ebe2ed650b64a75f85b056b::mogul::MogulCentral, arg1: &mut 0x2::tx_context::TxContext) {
        0x2f650a5162e4f7ef12b9adfbc2fadff1c30574572ebe2ed650b64a75f85b056b::mogul::assert_valid_version_package(arg0);
        0x2f650a5162e4f7ef12b9adfbc2fadff1c30574572ebe2ed650b64a75f85b056b::mogul::assert_valid_manager_package(arg0, 0x2::tx_context::sender(arg1));
        let v0 = TicketRegistry{
            id      : 0x2::object::new(arg1),
            seasons : 0x2::table::new<u64, 0x2::table::Table<address, u64>>(arg1),
        };
        0x2::transfer::public_share_object<TicketRegistry>(v0);
    }

    public fun deduct_ticket(arg0: &mut TicketRegistry, arg1: &mut 0x2f650a5162e4f7ef12b9adfbc2fadff1c30574572ebe2ed650b64a75f85b056b::mogul::MogulCentral, arg2: u64, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        0x2f650a5162e4f7ef12b9adfbc2fadff1c30574572ebe2ed650b64a75f85b056b::mogul::assert_valid_version_package(arg1);
        0x2f650a5162e4f7ef12b9adfbc2fadff1c30574572ebe2ed650b64a75f85b056b::mogul::assert_valid_manager_package(arg1, 0x2::tx_context::sender(arg5));
        let v0 = 0x2::table::borrow_mut<address, u64>(0x2::table::borrow_mut<u64, 0x2::table::Table<address, u64>>(&mut arg0.seasons, arg2), arg4);
        *v0 = *v0 - arg3;
        let v1 = TicketDeductEvent{
            season        : arg2,
            ticket_amount : arg3,
        };
        0x2::event::emit<TicketDeductEvent>(v1);
    }

    public fun give_ticket<T0: copy + drop>(arg0: &mut TicketRegistry, arg1: &mut 0x2f650a5162e4f7ef12b9adfbc2fadff1c30574572ebe2ed650b64a75f85b056b::mogul::MogulCentral, arg2: u64, arg3: 0x1::string::String, arg4: T0, arg5: u64, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        0x2f650a5162e4f7ef12b9adfbc2fadff1c30574572ebe2ed650b64a75f85b056b::mogul::assert_valid_version_package(arg1);
        0x2f650a5162e4f7ef12b9adfbc2fadff1c30574572ebe2ed650b64a75f85b056b::mogul::assert_valid_manager_package(arg1, 0x2::tx_context::sender(arg7));
        if (!0x2::table::contains<u64, 0x2::table::Table<address, u64>>(&arg0.seasons, arg2)) {
            0x2::table::add<u64, 0x2::table::Table<address, u64>>(&mut arg0.seasons, arg2, 0x2::table::new<address, u64>(arg7));
        };
        let v0 = 0x2::table::borrow_mut<u64, 0x2::table::Table<address, u64>>(&mut arg0.seasons, arg2);
        if (0x2::table::contains<address, u64>(v0, arg6)) {
            let v1 = 0x2::table::borrow_mut<address, u64>(v0, arg6);
            *v1 = *v1 + arg5;
        } else {
            0x2::table::add<address, u64>(v0, arg6, arg5);
        };
        let v2 = TicketReceiveEvent<T0>{
            season         : arg2,
            game_mode      : arg3,
            game_mode_data : arg4,
            receiver       : arg6,
            ticket_amount  : arg5,
        };
        0x2::event::emit<TicketReceiveEvent<T0>>(v2);
    }

    // decompiled from Move bytecode v6
}

