module 0x3a35f12152047ef6174981642699f46ade6f83b700297abd6686286c479e4254::access_policy {
    struct Session has key {
        id: 0x2::object::UID,
        payer: address,
        tier: u8,
        paid_at_ms: u64,
        completed: bool,
        blob_id: vector<u8>,
    }

    public fun create_session(arg0: u8, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Session{
            id         : 0x2::object::new(arg3),
            payer      : 0x2::tx_context::sender(arg3),
            tier       : arg0,
            paid_at_ms : 0x2::clock::timestamp_ms(arg2),
            completed  : false,
            blob_id    : arg1,
        };
        0x2::transfer::share_object<Session>(v0);
    }

    fun is_prefix(arg0: &vector<u8>, arg1: &vector<u8>) : bool {
        let v0 = 0x1::vector::length<u8>(arg0);
        if (0x1::vector::length<u8>(arg1) < v0) {
            return false
        };
        let v1 = 0;
        while (v1 < v0) {
            if (*0x1::vector::borrow<u8>(arg0, v1) != *0x1::vector::borrow<u8>(arg1, v1)) {
                return false
            };
            v1 = v1 + 1;
        };
        true
    }

    public fun mark_completed(arg0: &mut Session, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.payer, 2);
        arg0.completed = true;
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: &Session, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<Session>(arg1);
        let v1 = 0x2::object::id_to_bytes(&v0);
        assert!(is_prefix(&v1, &arg0), 1);
        assert!(0x2::tx_context::sender(arg3) == arg1.payer, 2);
        assert!(0x2::clock::timestamp_ms(arg2) <= arg1.paid_at_ms + 2764800000, 3);
    }

    // decompiled from Move bytecode v7
}

