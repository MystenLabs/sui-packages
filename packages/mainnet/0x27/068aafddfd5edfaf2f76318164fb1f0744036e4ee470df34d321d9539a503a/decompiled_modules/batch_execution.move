module 0x27068aafddfd5edfaf2f76318164fb1f0744036e4ee470df34d321d9539a503a::batch_execution {
    struct Request has store, key {
        id: 0x2::object::UID,
        sender: address,
        timestamp_ms: u64,
        execution_timestamp_ms: u64,
        status: u64,
    }

    struct RequestCreatedEvent has copy, drop {
        request_addr: address,
        sender: address,
        timestamp_ms: u64,
        execution_timestamp_ms: u64,
    }

    struct RequestExecutedEvent has copy, drop {
        request_addr: address,
        sender: address,
        timestamp_ms: u64,
    }

    public fun create_request(arg0: &0x2::clock::Clock, arg1: &mut 0x2::tx_context::TxContext) : Request {
        let v0 = 0x2::clock::timestamp_ms(arg0);
        let v1 = v0 + 5000;
        let v2 = 0x2::object::new(arg1);
        let v3 = Request{
            id                     : v2,
            sender                 : 0x2::tx_context::sender(arg1),
            timestamp_ms           : v0,
            execution_timestamp_ms : v1,
            status                 : 0,
        };
        let v4 = RequestCreatedEvent{
            request_addr           : 0x2::object::uid_to_address(&v2),
            sender                 : 0x2::tx_context::sender(arg1),
            timestamp_ms           : v0,
            execution_timestamp_ms : v1,
        };
        0x2::event::emit<RequestCreatedEvent>(v4);
        v3
    }

    public fun execute_request(arg0: &mut Request, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(arg0.status == 0, 400);
        assert!(arg0.execution_timestamp_ms <= v0, 401);
        arg0.status = 1;
        let v1 = RequestExecutedEvent{
            request_addr : 0x2::object::id_address<Request>(arg0),
            sender       : 0x2::tx_context::sender(arg2),
            timestamp_ms : v0,
        };
        0x2::event::emit<RequestExecutedEvent>(v1);
    }

    public fun share_request(arg0: Request) {
        0x2::transfer::share_object<Request>(arg0);
    }

    // decompiled from Move bytecode v6
}

