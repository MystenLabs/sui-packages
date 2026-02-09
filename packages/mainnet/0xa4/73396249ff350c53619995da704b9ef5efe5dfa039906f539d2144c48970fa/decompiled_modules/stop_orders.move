module 0xa473396249ff350c53619995da704b9ef5efe5dfa039906f539d2144c48970fa::stop_orders {
    struct StopOrderTicket<phantom T0> has store, key {
        id: 0x2::object::UID,
        executors: vector<address>,
        gas: 0x2::balance::Balance<0x2::sui::SUI>,
        account_id: u64,
        stop_order_type: u64,
        encrypted_details: vector<u8>,
    }

    public fun assert_valid_ticket_account_id<T0>(arg0: &StopOrderTicket<T0>, arg1: u64) {
        assert!(arg0.account_id == arg1, 0xa473396249ff350c53619995da704b9ef5efe5dfa039906f539d2144c48970fa::errors::invalid_account_for_stop_order());
    }

    public fun assert_valid_ticket_executor<T0>(arg0: &StopOrderTicket<T0>, arg1: address) {
        assert!(0x1::vector::contains<address>(&arg0.executors, &arg1), 0xa473396249ff350c53619995da704b9ef5efe5dfa039906f539d2144c48970fa::errors::invalid_executor_for_stop_order());
    }

    public(friend) fun create_stop_order_ticket<T0>(arg0: u64, arg1: vector<address>, arg2: 0x2::balance::Balance<0x2::sui::SUI>, arg3: u64, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) : StopOrderTicket<T0> {
        let v0 = StopOrderTicket<T0>{
            id                : 0x2::object::new(arg5),
            executors         : arg1,
            gas               : arg2,
            account_id        : arg0,
            stop_order_type   : arg3,
            encrypted_details : arg4,
        };
        0xa473396249ff350c53619995da704b9ef5efe5dfa039906f539d2144c48970fa::events::emit_created_stop_order_ticket<T0>(0x2::object::uid_to_inner(&v0.id), arg0, arg1, 0x2::balance::value<0x2::sui::SUI>(&arg2), arg3, v0.encrypted_details);
        v0
    }

    public(friend) fun delete_stop_order_ticket<T0>(arg0: StopOrderTicket<T0>, arg1: bool, arg2: address) : (0x2::balance::Balance<0x2::sui::SUI>, u64, vector<u8>) {
        let StopOrderTicket {
            id                : v0,
            executors         : _,
            gas               : v2,
            account_id        : v3,
            stop_order_type   : v4,
            encrypted_details : v5,
        } = arg0;
        let v6 = v0;
        if (arg1) {
            0xa473396249ff350c53619995da704b9ef5efe5dfa039906f539d2144c48970fa::events::emit_executed_stop_order_ticket<T0>(0x2::object::uid_to_inner(&v6), v3, arg2);
        } else {
            0xa473396249ff350c53619995da704b9ef5efe5dfa039906f539d2144c48970fa::events::emit_deleted_stop_order_ticket<T0>(0x2::object::uid_to_inner(&v6), v3, arg2);
        };
        0x2::object::delete(v6);
        (v2, v4, v5)
    }

    public(friend) fun edit_stop_order_ticket_details<T0>(arg0: &mut StopOrderTicket<T0>, arg1: vector<u8>) {
        arg0.encrypted_details = arg1;
        0xa473396249ff350c53619995da704b9ef5efe5dfa039906f539d2144c48970fa::events::emit_edited_stop_order_ticket_details<T0>(0x2::object::id<StopOrderTicket<T0>>(arg0), arg0.account_id, arg1);
    }

    public(friend) fun edit_stop_order_ticket_executor<T0>(arg0: &mut StopOrderTicket<T0>, arg1: vector<address>) {
        arg0.executors = arg1;
        0xa473396249ff350c53619995da704b9ef5efe5dfa039906f539d2144c48970fa::events::emit_edited_stop_order_ticket_executors<T0>(0x2::object::id<StopOrderTicket<T0>>(arg0), arg0.account_id, arg1);
    }

    public fun get_account_id<T0>(arg0: &StopOrderTicket<T0>) : u64 {
        arg0.account_id
    }

    public fun get_executors<T0>(arg0: &StopOrderTicket<T0>) : vector<address> {
        arg0.executors
    }

    // decompiled from Move bytecode v6
}

