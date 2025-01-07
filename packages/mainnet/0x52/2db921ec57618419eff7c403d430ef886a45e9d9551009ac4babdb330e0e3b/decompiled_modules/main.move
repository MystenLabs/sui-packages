module 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::main {
    struct CallMessageSent has copy, drop {
        from: 0x1::string::String,
        to: 0x1::string::String,
        sn: u128,
    }

    struct CallMessage has copy, drop {
        from: 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::network_address::NetworkAddress,
        to: 0x1::string::String,
        sn: u128,
        req_id: u128,
        data: vector<u8>,
    }

    struct CallExecuted has copy, drop {
        req_id: u128,
        code: u8,
        err_msg: 0x1::string::String,
    }

    struct RollbackMessage has copy, drop {
        sn: u128,
        dapp: 0x1::string::String,
        data: vector<u8>,
    }

    struct RollbackExecuted has copy, drop {
        sn: u128,
    }

    struct ResponseMessage has copy, drop {
        sn: u128,
        response_code: u8,
    }

    public entry fun get_fee(arg0: &0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::Storage, arg1: 0x1::string::String, arg2: bool, arg3: 0x1::option::Option<vector<0x1::string::String>>) : u64 {
        let v0 = 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::get_protocol_fee(arg0);
        let v1 = 0x1::option::get_with_default<vector<0x1::string::String>>(&arg3, 0x1::vector::empty<0x1::string::String>());
        if (0x1::vector::is_empty<0x1::string::String>(&v1)) {
            0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::get_connection(arg0, arg1));
        };
        if (isReply(arg0, arg1, v1) && !arg2) {
            return 0
        };
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::string::String>(&v1)) {
            v0 = v0 + get_connection_fee(arg0, *0x1::vector::borrow<0x1::string::String>(&v1, v2), arg1, arg2);
            v2 = v2 + 1;
        };
        v0
    }

    public fun admin(arg0: &mut 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::Storage) : 0x2::object::ID {
        0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::get_admin(arg0)
    }

    public entry fun configure_nid(arg0: &mut 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::Storage, arg1: &0x2::package::UpgradeCap, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        if (!(arg2 == 0x1::string::utf8(b""))) {
            0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::set_net_id(arg0, arg2);
        };
    }

    fun connection_send_message(arg0: &mut 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::Storage, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: vector<0x1::string::String>, arg3: 0x1::string::String, arg4: 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::cs_message::CSMessage, arg5: u128, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        if (0x1::vector::is_empty<0x1::string::String>(&arg2)) {
            0x1::vector::push_back<0x1::string::String>(&mut arg2, 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::get_connection(arg0, arg3));
        };
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::string::String>(&arg2)) {
            let v1 = *0x1::vector::borrow<0x1::string::String>(&arg2, v0);
            let v2 = if (arg6) {
                0
            } else {
                get_connection_fee(arg0, v1, arg3, arg5 > 0)
            };
            0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::connections::send_message(0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::get_connection_states_mut(arg0), v1, 0x2::coin::split<0x2::sui::SUI>(&mut arg1, v2, arg7), arg3, arg5, 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::cs_message::encode(&arg4), arg6, arg7);
            v0 = v0 + 1;
        };
        arg1
    }

    public fun execute_call(arg0: &mut 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::Storage, arg1: &0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::IDCap, arg2: u128, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) : 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::execute_ticket::ExecuteTicket {
        0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::enforce_version(arg0, 2);
        let v0 = 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::get_proxy_request(arg0, arg2);
        let v1 = 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::message_request::to(v0);
        0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::message_request::sn(v0);
        assert!(0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::message_request::data(v0) == 0x2::hash::keccak256(&arg3), 8);
        0x1::debug::print<0x1::string::String>(&v1);
        let v2 = 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::get_id_cap_id(arg1);
        let v3 = 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_utils::id_to_hex_string(&v2);
        0x1::debug::print<0x1::string::String>(&v3);
        let v4 = 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::get_id_cap_id(arg1);
        assert!(v1 == 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_utils::id_to_hex_string(&v4), 12);
        if (0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::message_request::msg_type(v0) == 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::call_message_rollback::msg_type()) {
            0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::set_reply_state(arg0, *v0);
        };
        0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::execute_ticket::new(0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::get_id_cap_id(arg1), arg2, 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::message_request::from(v0), 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::message_request::protocols(v0), arg3)
    }

    public fun execute_call_result(arg0: &mut 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::Storage, arg1: 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::execute_ticket::ExecuteTicket, arg2: bool, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::enforce_version(arg0, 2);
        let v0 = 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::execute_ticket::request_id(&arg1);
        let v1 = 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::get_proxy_request(arg0, v0);
        let v2 = 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::message_request::msg_type(v1);
        let v3 = 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::message_request::sn(v1);
        let v4 = 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::message_request::from(v1);
        if (v2 == 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::persistent_message::msg_type() && !arg2) {
            abort 1
        };
        0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::remove_proxy_request(arg0, v0);
        0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::remove_reply_state(arg0);
        let v5 = 0x1::vector::empty<u8>();
        let v6 = v5;
        let v7 = if (arg2) {
            1
        } else {
            0
        };
        let v8 = if (arg2) {
            0x1::string::utf8(b"success")
        } else {
            0x1::string::utf8(b"unknown error")
        };
        let v9 = if (v2 == 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::call_message_rollback::msg_type()) {
            let v10 = 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::get_call_reply(arg0);
            if (0x1::vector::length<u8>(&v10) > 0 && v7 == 1) {
                v6 = v10;
                0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::remove_call_reply(arg0);
            };
            0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::message_result::create(v3, v7, v6)
        } else {
            0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::message_result::create(v3, v7, v5)
        };
        0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::execute_ticket::consume(arg1);
        if (v2 == 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::call_message_rollback::msg_type()) {
            arg3 = connection_send_message(arg0, arg3, 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::message_request::protocols(v1), 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::network_address::net_id(&v4), 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::cs_message::from_message_result(v9), v3, true, arg4);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, 0x2::tx_context::sender(arg4));
        let v11 = CallExecuted{
            req_id  : v0,
            code    : v7,
            err_msg : v8,
        };
        0x2::event::emit<CallExecuted>(v11);
    }

    public fun execute_rollback(arg0: &mut 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::Storage, arg1: &0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::IDCap, arg2: u128, arg3: &mut 0x2::tx_context::TxContext) : 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::rollback_ticket::RollbackTicket {
        0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::enforce_version(arg0, 2);
        assert!(0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::has_rollback(arg0, arg2), 6);
        let v0 = 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::get_rollback(arg0, arg2);
        assert!(0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::rollback_data::from(&v0) == 0x2::object::id<0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::IDCap>(arg1), 12);
        assert!(0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::rollback_data::enabled(&v0), 10);
        0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::rollback_ticket::new(arg2, 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::rollback_data::rollback(&v0), 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::get_id_cap_id(arg1))
    }

    public fun execute_rollback_result(arg0: &mut 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::Storage, arg1: 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::rollback_ticket::RollbackTicket, arg2: bool) {
        0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::enforce_version(arg0, 2);
        let v0 = 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::rollback_ticket::sn(&arg1);
        if (arg2) {
            0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::remove_rollback(arg0, v0);
            let v1 = RollbackExecuted{sn: v0};
            0x2::event::emit<RollbackExecuted>(v1);
        };
        0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::rollback_ticket::consume(arg1);
    }

    fun get_connection_fee(arg0: &0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::Storage, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: bool) : u64 {
        0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::connections::get_fee(0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::get_connection_states(arg0), arg1, arg2, arg3)
    }

    public fun get_fee_handler(arg0: &mut 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::Storage) : address {
        0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::get_protocol_fee_handler(arg0)
    }

    fun get_next_req_id(arg0: &mut 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::Storage) : u128 {
        0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::get_next_request_id(arg0)
    }

    fun get_next_sequence(arg0: &mut 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::Storage) : u128 {
        0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::get_next_sequence(arg0)
    }

    public entry fun get_nid(arg0: &mut 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::Storage) : 0x1::string::String {
        0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::get_net_id(arg0)
    }

    public fun handle_message(arg0: &mut 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::Storage, arg1: &0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::ConnCap, arg2: 0x1::string::String, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::enforce_version(arg0, 2);
        assert!(arg2 != 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::get_net_id(arg0), 4);
        let v0 = 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::cs_message::decode(&arg3);
        let v1 = 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::cs_message::msg_type(&v0);
        if (v1 == 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::cs_message::request_code()) {
            handle_request(arg0, arg1, arg2, 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::cs_message::payload(&v0), arg4);
        } else {
            assert!(v1 == 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::cs_message::result_code(), 13);
            handle_result(arg0, arg1, 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::cs_message::payload(&v0), arg4);
        };
    }

    fun handle_reply(arg0: &mut 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::Storage, arg1: &0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::rollback_data::RollbackData, arg2: &0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::message_request::CSMessageRequest, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::rollback_data::to(arg1) == 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::message_request::from_nid(arg2), 7);
        let v0 = 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::message_request::from(arg2);
        let v1 = 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::message_request::to(arg2);
        let v2 = 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::message_request::data(arg2);
        let v3 = 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::message_request::sn(arg2);
        let v4 = get_next_req_id(arg0);
        0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::add_proxy_request(arg0, v4, 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::message_request::create(v0, v1, v3, 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::message_request::msg_type(arg2), 0x2::hash::keccak256(&v2), 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::rollback_data::sources(arg1)));
        let v5 = CallMessage{
            from   : v0,
            to     : v1,
            sn     : v3,
            req_id : v4,
            data   : v2,
        };
        0x2::event::emit<CallMessage>(v5);
    }

    fun handle_request(arg0: &mut 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::Storage, arg1: &0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::ConnCap, arg2: 0x1::string::String, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::message_request::decode(&arg3);
        let v1 = 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::message_request::from_nid(&v0);
        let v2 = 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::message_request::data(&v0);
        let v3 = 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::message_request::from(&v0);
        let v4 = 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::message_request::sn(&v0);
        assert!(v1 == arg2, 4);
        let v5 = 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::connection_id(arg1);
        let v6 = 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::message_request::to(&v0);
        let v7 = 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::message_request::protocols(&v0);
        assert!(is_valid_source(arg0, v1, v5, 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::message_request::protocols(&v0)), 5);
        if (0x1::vector::length<0x1::string::String>(&v7) > 1) {
            let v8 = 0x2::hash::keccak256(&arg3);
            0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::save_pending_requests(arg0, v8, v5);
            if (!0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::check_pending_requests(arg0, v8, v7)) {
                return
            };
            0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::remove_pending_requests(arg0, v8, v7);
        };
        let v9 = get_next_req_id(arg0);
        0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::add_proxy_request(arg0, v9, 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::message_request::create(v3, v6, v4, 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::message_request::msg_type(&v0), 0x2::hash::keccak256(&v2), v7));
        let v10 = CallMessage{
            from   : v3,
            to     : v6,
            sn     : v4,
            req_id : v9,
            data   : v2,
        };
        0x2::event::emit<CallMessage>(v10);
    }

    fun handle_result(arg0: &mut 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::Storage, arg1: &0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::ConnCap, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::message_result::decode(&arg2);
        let v1 = 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::message_result::sequence_no(&v0);
        let v2 = 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::message_result::response_code(&v0);
        let v3 = 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::message_result::message(&v0);
        assert!(0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::has_rollback(arg0, v1), 6);
        let v4 = 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::get_rollback(arg0, v1);
        let v5 = 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::rollback_data::sources(&v4);
        let v6 = 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::connection_id(arg1);
        assert!(is_valid_source(arg0, 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::rollback_data::to(&v4), v6, v5), 5);
        if (0x1::vector::length<0x1::string::String>(&v5) > 1) {
            let v7 = 0x2::hash::keccak256(&arg2);
            0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::save_pending_responses(arg0, v7, v6);
            if (!0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::check_pending_responses(arg0, v7, v5)) {
                return
            };
            0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::remove_pending_responses(arg0, v7, v5);
        };
        let v8 = ResponseMessage{
            sn            : v1,
            response_code : v2,
        };
        0x2::event::emit<ResponseMessage>(v8);
        if (v2 == 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::message_result::success()) {
            0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::remove_rollback(arg0, v1);
            if (0x1::vector::length<u8>(&v3) > 0) {
                let v9 = 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::message_request::decode(&v3);
                handle_reply(arg0, &v4, &v9, arg3);
            };
            0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::set_successful_responses(arg0, v1);
        } else {
            0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::rollback_data::enable_rollback(0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::get_mut_rollback(arg0, v1));
            let v10 = 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::rollback_data::from(&v4);
            let v11 = RollbackMessage{
                sn   : v1,
                dapp : 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_utils::id_to_hex_string(&v10),
                data : 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::rollback_data::rollback(&v4),
            };
            0x2::event::emit<RollbackMessage>(v11);
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::create_admin_cap(arg0);
        0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::share(0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::create_storage(2, &v0, arg0));
        0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::transfer_admin_cap(v0, arg0);
    }

    fun isReply(arg0: &0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::Storage, arg1: 0x1::string::String, arg2: vector<0x1::string::String>) : bool {
        let v0 = 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::get_reply_state(arg0);
        0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::message_request::from_nid(&v0) == arg1 && 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::message_request::protocols(&v0) == arg2
    }

    fun is_valid_source(arg0: &0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::Storage, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: vector<0x1::string::String>) : bool {
        if (0x1::vector::contains<0x1::string::String>(&arg3, &arg2)) {
            return true
        };
        if (0x1::vector::is_empty<0x1::string::String>(&arg3)) {
            return 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::get_connection(arg0, arg1) == arg2
        };
        false
    }

    entry fun migrate(arg0: &mut 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::Storage, arg1: &0x2::package::UpgradeCap) {
        assert!(0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::get_version(arg0) < 2, 2);
        0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::set_version(arg0, 2);
    }

    public entry fun register_connection_admin(arg0: &mut 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::Storage, arg1: &0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::AdminCap, arg2: 0x1::string::String, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::enforce_version(arg0, 2);
        0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::transfer_conn_cap(0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::new_conn_cap(0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::get_id(arg0), arg2, arg4), arg3, arg4);
        0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::connections::register(0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::get_connection_states_mut(arg0), arg2, arg4);
    }

    public fun register_dapp<T0: drop>(arg0: &0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::Storage, arg1: T0, arg2: &mut 0x2::tx_context::TxContext) : 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::IDCap {
        0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::create_id_cap(arg0, arg2)
    }

    public fun send_call(arg0: &mut 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::Storage, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::IDCap, arg3: 0x1::string::String, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::IDCap>(arg2);
        let v1 = 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::network_address::create(0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::get_net_id(arg0), 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_utils::id_to_hex_string(&v0));
        let v2 = send_call_inner(arg0, arg1, v1, 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::network_address::from_string(arg3), 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::envelope::decode(&arg4), arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v2, 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::get_protocol_fee(arg0), arg5), 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::get_protocol_fee_handler(arg0));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v2, 0x2::tx_context::sender(arg5));
    }

    fun send_call_inner(arg0: &mut 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::Storage, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::network_address::NetworkAddress, arg3: 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::network_address::NetworkAddress, arg4: 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::envelope::XCallEnvelope, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::enforce_version(arg0, 2);
        let v0 = get_next_sequence(arg0);
        let v1 = 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::envelope::msg_type(&arg4);
        let v2 = false;
        let v3 = if (v1 == 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::call_message::msg_type() || v1 == 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::persistent_message::msg_type()) {
            0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::envelope::message(&arg4)
        } else {
            assert!(v1 == 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::call_message_rollback::msg_type(), 9);
            let v4 = 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::envelope::message(&arg4);
            let v5 = 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::call_message_rollback::decode(&v4);
            let v6 = 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::network_address::addr(&arg2);
            0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::add_rollback(arg0, v0, 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::rollback_data::create(0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_utils::id_from_hex_string(&v6), 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::network_address::net_id(&arg3), 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::envelope::sources(&arg4), 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::call_message_rollback::rollback(&v5), false));
            v2 = true;
            0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::call_message_rollback::data(&v5)
        };
        let v7 = 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::message_request::create(arg2, 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::network_address::addr(&arg3), v0, 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::envelope::msg_type(&arg4), v3, 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::envelope::destinations(&arg4));
        let v8 = 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::message_request::encode(&v7);
        assert!(0x1::vector::length<u8>(&v8) <= 2048, 14);
        let v9 = if (isReply(arg0, 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::network_address::net_id(&arg3), 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::envelope::sources(&arg4))) {
            0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::remove_reply_state(arg0);
            0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::set_call_reply(arg0, v8);
            arg1
        } else {
            let v10 = if (v2) {
                v0
            } else {
                0
            };
            connection_send_message(arg0, arg1, 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::envelope::sources(&arg4), 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::network_address::net_id(&arg3), 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::cs_message::from_message_request(v7), v10, false, arg5)
        };
        let v11 = CallMessageSent{
            from : 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::network_address::addr(&arg2),
            to   : 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::network_address::to_string(&arg3),
            sn   : v0,
        };
        0x2::event::emit<CallMessageSent>(v11);
        v9
    }

    entry fun send_call_ua(arg0: &mut 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::Storage, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x1::string::String, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::envelope::decode(&arg3);
        if (0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::envelope::msg_type(&v0) == 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::call_message_rollback::msg_type()) {
            abort 9
        };
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::network_address::create(0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::get_net_id(arg0), 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_utils::address_to_hex_string(&v1));
        let v3 = send_call_inner(arg0, arg1, v2, 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::network_address::from_string(arg2), v0, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v3, 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::get_protocol_fee(arg0), arg4), 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::get_protocol_fee_handler(arg0));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v3, 0x2::tx_context::sender(arg4));
    }

    public entry fun set_default_connection(arg0: &mut 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::Storage, arg1: &0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::AdminCap, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::enforce_version(arg0, 2);
        if (!0x2::bag::contains<0x1::string::String>(0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::get_connection_states(arg0), arg3)) {
            abort 15
        };
        0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::set_connection(arg0, arg2, arg3);
    }

    entry fun set_protocol_fee(arg0: &mut 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::Storage, arg1: &0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::AdminCap, arg2: u64) {
        0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::enforce_version(arg0, 2);
        0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::set_protocol_fee(arg0, arg2);
    }

    entry fun set_protocol_fee_handler(arg0: &mut 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::Storage, arg1: &0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::AdminCap, arg2: address) {
        0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::enforce_version(arg0, 2);
        0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::set_protocol_fee_handler(arg0, arg2);
    }

    entry fun verify_success(arg0: &mut 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::Storage, arg1: u128, arg2: &mut 0x2::tx_context::TxContext) {
        0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::enforce_version(arg0, 2);
        0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state::get_successful_responses(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

