module 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_state {
    struct IDCap has store, key {
        id: 0x2::object::UID,
        xcall_id: 0x2::object::ID,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ConnCap has store, key {
        id: 0x2::object::UID,
        xcall_id: 0x2::object::ID,
        connection_id: 0x1::string::String,
    }

    struct PendingReqResKey has copy, drop, store {
        data_hash: vector<u8>,
        caller: 0x1::string::String,
    }

    struct Storage has key {
        id: 0x2::object::UID,
        version: u64,
        net_id: 0x1::string::String,
        admin: 0x2::object::ID,
        requests: 0x2::linked_table::LinkedTable<u128, vector<u8>>,
        sequence_no: u128,
        protocol_fee: u64,
        protocol_fee_handler: address,
        connection_states: 0x2::bag::Bag,
        rollbacks: 0x2::table::Table<u128, 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::rollback_data::RollbackData>,
        connections: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        pending_responses: 0x2::vec_map::VecMap<PendingReqResKey, bool>,
        pending_requests: 0x2::vec_map::VecMap<PendingReqResKey, bool>,
        successful_responses: 0x2::vec_map::VecMap<u128, bool>,
        request_id: u128,
        proxy_requests: 0x2::table::Table<u128, 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::message_request::CSMessageRequest>,
        reply_state: 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::message_request::CSMessageRequest,
        call_reply: vector<u8>,
    }

    public(friend) fun add_proxy_request(arg0: &mut Storage, arg1: u128, arg2: 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::message_request::CSMessageRequest) {
        0x2::table::add<u128, 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::message_request::CSMessageRequest>(&mut arg0.proxy_requests, arg1, arg2);
    }

    public(friend) fun add_rollback(arg0: &mut Storage, arg1: u128, arg2: 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::rollback_data::RollbackData) {
        0x2::table::add<u128, 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::rollback_data::RollbackData>(&mut arg0.rollbacks, arg1, arg2);
    }

    public(friend) fun check_pending_requests(arg0: &mut Storage, arg1: vector<u8>, arg2: vector<0x1::string::String>) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::string::String>(&arg2)) {
            let v1 = PendingReqResKey{
                data_hash : arg1,
                caller    : *0x1::vector::borrow<0x1::string::String>(&arg2, v0),
            };
            if (!0x2::vec_map::contains<PendingReqResKey, bool>(&arg0.pending_requests, &v1)) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    public(friend) fun check_pending_responses(arg0: &mut Storage, arg1: vector<u8>, arg2: vector<0x1::string::String>) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::string::String>(&arg2)) {
            let v1 = PendingReqResKey{
                data_hash : arg1,
                caller    : *0x1::vector::borrow<0x1::string::String>(&arg2, v0),
            };
            if (!0x2::vec_map::contains<PendingReqResKey, bool>(&arg0.pending_responses, &v1)) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    public fun connection_id(arg0: &ConnCap) : 0x1::string::String {
        arg0.connection_id
    }

    public(friend) fun create_admin_cap(arg0: &mut 0x2::tx_context::TxContext) : AdminCap {
        AdminCap{id: 0x2::object::new(arg0)}
    }

    public(friend) fun create_id_cap(arg0: &Storage, arg1: &mut 0x2::tx_context::TxContext) : IDCap {
        IDCap{
            id       : 0x2::object::new(arg1),
            xcall_id : 0x2::object::id<Storage>(arg0),
        }
    }

    public(friend) fun create_storage(arg0: u64, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) : Storage {
        Storage{
            id                   : 0x2::object::new(arg2),
            version              : arg0,
            net_id               : 0x1::string::utf8(b""),
            admin                : 0x2::object::id<AdminCap>(arg1),
            requests             : 0x2::linked_table::new<u128, vector<u8>>(arg2),
            sequence_no          : 0,
            protocol_fee         : 0,
            protocol_fee_handler : 0x2::tx_context::sender(arg2),
            connection_states    : 0x2::bag::new(arg2),
            rollbacks            : 0x2::table::new<u128, 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::rollback_data::RollbackData>(arg2),
            connections          : 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>(),
            pending_responses    : 0x2::vec_map::empty<PendingReqResKey, bool>(),
            pending_requests     : 0x2::vec_map::empty<PendingReqResKey, bool>(),
            successful_responses : 0x2::vec_map::empty<u128, bool>(),
            request_id           : 0,
            proxy_requests       : 0x2::table::new<u128, 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::message_request::CSMessageRequest>(arg2),
            reply_state          : 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::message_request::default(),
            call_reply           : 0x1::vector::empty<u8>(),
        }
    }

    public(friend) fun enforce_version(arg0: &mut Storage, arg1: u64) {
        assert!(arg0.version == arg1, 1);
    }

    public fun get_admin(arg0: &Storage) : 0x2::object::ID {
        arg0.admin
    }

    public fun get_call_reply(arg0: &Storage) : vector<u8> {
        arg0.call_reply
    }

    public fun get_connection(arg0: &Storage, arg1: 0x1::string::String) : 0x1::string::String {
        *0x2::vec_map::get<0x1::string::String, 0x1::string::String>(&arg0.connections, &arg1)
    }

    public fun get_connection_states(arg0: &Storage) : &0x2::bag::Bag {
        &arg0.connection_states
    }

    public(friend) fun get_connection_states_mut(arg0: &mut Storage) : &mut 0x2::bag::Bag {
        &mut arg0.connection_states
    }

    public(friend) fun get_id(arg0: &Storage) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun get_id_cap_id(arg0: &IDCap) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun get_id_cap_xcall(arg0: &IDCap) : 0x2::object::ID {
        arg0.xcall_id
    }

    public(friend) fun get_mut_rollback(arg0: &mut Storage, arg1: u128) : &mut 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::rollback_data::RollbackData {
        0x2::table::borrow_mut<u128, 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::rollback_data::RollbackData>(&mut arg0.rollbacks, arg1)
    }

    public(friend) fun get_net_id(arg0: &mut Storage) : 0x1::string::String {
        arg0.net_id
    }

    public(friend) fun get_next_request_id(arg0: &mut Storage) : u128 {
        let v0 = arg0.request_id + 1;
        arg0.request_id = v0;
        v0
    }

    public(friend) fun get_next_sequence(arg0: &mut Storage) : u128 {
        let v0 = arg0.sequence_no + 1;
        arg0.sequence_no = v0;
        v0
    }

    public(friend) fun get_pending_requests(arg0: &mut Storage, arg1: vector<u8>, arg2: 0x1::string::String) : bool {
        let v0 = PendingReqResKey{
            data_hash : arg1,
            caller    : arg2,
        };
        0x2::vec_map::contains<PendingReqResKey, bool>(&arg0.pending_requests, &v0)
    }

    public(friend) fun get_pending_response(arg0: &mut Storage, arg1: vector<u8>, arg2: 0x1::string::String) : bool {
        let v0 = PendingReqResKey{
            data_hash : arg1,
            caller    : arg2,
        };
        0x2::vec_map::contains<PendingReqResKey, bool>(&arg0.pending_responses, &v0)
    }

    public fun get_protocol_fee(arg0: &Storage) : u64 {
        arg0.protocol_fee
    }

    public fun get_protocol_fee_handler(arg0: &Storage) : address {
        arg0.protocol_fee_handler
    }

    public(friend) fun get_proxy_request(arg0: &mut Storage, arg1: u128) : &0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::message_request::CSMessageRequest {
        0x2::table::borrow<u128, 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::message_request::CSMessageRequest>(&arg0.proxy_requests, arg1)
    }

    public fun get_proxy_requests_size(arg0: &Storage) : u64 {
        0x2::table::length<u128, 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::message_request::CSMessageRequest>(&arg0.proxy_requests)
    }

    public fun get_reply_state(arg0: &Storage) : 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::message_request::CSMessageRequest {
        arg0.reply_state
    }

    public fun get_rollback(arg0: &Storage, arg1: u128) : 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::rollback_data::RollbackData {
        *0x2::table::borrow<u128, 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::rollback_data::RollbackData>(&arg0.rollbacks, arg1)
    }

    public(friend) fun get_successful_responses(arg0: &mut Storage, arg1: u128) : bool {
        0x2::vec_map::contains<u128, bool>(&arg0.successful_responses, &arg1)
    }

    public fun get_version(arg0: &Storage) : u64 {
        arg0.version
    }

    public fun has_rollback(arg0: &Storage, arg1: u128) : bool {
        0x2::table::contains<u128, 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::rollback_data::RollbackData>(&arg0.rollbacks, arg1)
    }

    public(friend) fun new_conn_cap(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) : ConnCap {
        ConnCap{
            id            : 0x2::object::new(arg2),
            xcall_id      : arg0,
            connection_id : arg1,
        }
    }

    public fun pending_requests(arg0: &Storage) : &0x2::vec_map::VecMap<PendingReqResKey, bool> {
        &arg0.pending_requests
    }

    public fun pending_responses(arg0: &Storage) : &0x2::vec_map::VecMap<PendingReqResKey, bool> {
        &arg0.pending_responses
    }

    public fun proxy_requests(arg0: &Storage) : &0x2::table::Table<u128, 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::message_request::CSMessageRequest> {
        &arg0.proxy_requests
    }

    public(friend) fun remove_call_reply(arg0: &mut Storage) {
        arg0.call_reply = 0x1::vector::empty<u8>();
    }

    public(friend) fun remove_pending_requests(arg0: &mut Storage, arg1: vector<u8>, arg2: vector<0x1::string::String>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::string::String>(&arg2)) {
            let v1 = PendingReqResKey{
                data_hash : arg1,
                caller    : *0x1::vector::borrow<0x1::string::String>(&arg2, v0),
            };
            let (_, _) = 0x2::vec_map::remove<PendingReqResKey, bool>(&mut arg0.pending_requests, &v1);
            v0 = v0 + 1;
        };
    }

    public(friend) fun remove_pending_responses(arg0: &mut Storage, arg1: vector<u8>, arg2: vector<0x1::string::String>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::string::String>(&arg2)) {
            let v1 = PendingReqResKey{
                data_hash : arg1,
                caller    : *0x1::vector::borrow<0x1::string::String>(&arg2, v0),
            };
            let (_, _) = 0x2::vec_map::remove<PendingReqResKey, bool>(&mut arg0.pending_responses, &v1);
            v0 = v0 + 1;
        };
    }

    public(friend) fun remove_proxy_request(arg0: &mut Storage, arg1: u128) {
        0x2::table::remove<u128, 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::message_request::CSMessageRequest>(&mut arg0.proxy_requests, arg1);
    }

    public(friend) fun remove_reply_state(arg0: &mut Storage) {
        arg0.reply_state = 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::message_request::default();
    }

    public(friend) fun remove_rollback(arg0: &mut Storage, arg1: u128) {
        0x2::table::remove<u128, 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::rollback_data::RollbackData>(&mut arg0.rollbacks, arg1);
    }

    public(friend) fun save_pending_requests(arg0: &mut Storage, arg1: vector<u8>, arg2: 0x1::string::String) {
        let v0 = PendingReqResKey{
            data_hash : arg1,
            caller    : arg2,
        };
        0x2::vec_map::insert<PendingReqResKey, bool>(&mut arg0.pending_requests, v0, true);
    }

    public(friend) fun save_pending_responses(arg0: &mut Storage, arg1: vector<u8>, arg2: 0x1::string::String) {
        let v0 = PendingReqResKey{
            data_hash : arg1,
            caller    : arg2,
        };
        0x2::vec_map::insert<PendingReqResKey, bool>(&mut arg0.pending_responses, v0, true);
    }

    public(friend) fun set_call_reply(arg0: &mut Storage, arg1: vector<u8>) {
        arg0.call_reply = arg1;
    }

    public(friend) fun set_connection(arg0: &mut Storage, arg1: 0x1::string::String, arg2: 0x1::string::String) {
        if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&arg0.connections, &arg1)) {
            let (_, _) = 0x2::vec_map::remove<0x1::string::String, 0x1::string::String>(&mut arg0.connections, &arg1);
        };
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut arg0.connections, arg1, arg2);
    }

    public(friend) fun set_net_id(arg0: &mut Storage, arg1: 0x1::string::String) {
        arg0.net_id = arg1;
    }

    public(friend) fun set_protocol_fee(arg0: &mut Storage, arg1: u64) {
        arg0.protocol_fee = arg1;
    }

    public(friend) fun set_protocol_fee_handler(arg0: &mut Storage, arg1: address) {
        arg0.protocol_fee_handler = arg1;
    }

    public(friend) fun set_reply_state(arg0: &mut Storage, arg1: 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::message_request::CSMessageRequest) {
        arg0.reply_state = arg1;
    }

    public(friend) fun set_successful_responses(arg0: &mut Storage, arg1: u128) {
        0x2::vec_map::insert<u128, bool>(&mut arg0.successful_responses, arg1, true);
    }

    public(friend) fun set_version(arg0: &mut Storage, arg1: u64) {
        arg0.version = arg1;
    }

    public(friend) fun share(arg0: Storage) {
        0x2::transfer::share_object<Storage>(arg0);
    }

    public(friend) fun transfer_admin_cap(arg0: AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<AdminCap>(arg0, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun transfer_conn_cap(arg0: ConnCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<ConnCap>(arg0, arg1);
    }

    public fun xcall_id(arg0: &ConnCap) : 0x2::object::ID {
        arg0.xcall_id
    }

    // decompiled from Move bytecode v6
}

