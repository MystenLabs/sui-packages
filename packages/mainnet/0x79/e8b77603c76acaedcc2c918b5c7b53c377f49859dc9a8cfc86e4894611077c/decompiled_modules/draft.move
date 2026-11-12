module 0x79e8b77603c76acaedcc2c918b5c7b53c377f49859dc9a8cfc86e4894611077c::draft {
    fun check_draft_policy(arg0: vector<u8>, arg1: &0x682d456a9b6c051c9b70e2f67bcee9602b1244278b898e70348b8c6214c214ab::journey::Session, arg2: &0x682d456a9b6c051c9b70e2f67bcee9602b1244278b898e70348b8c6214c214ab::journey::Journey, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : bool {
        if (0x2::tx_context::sender(arg4) != 0x682d456a9b6c051c9b70e2f67bcee9602b1244278b898e70348b8c6214c214ab::journey::buyer(arg1)) {
            return false
        };
        if (0x682d456a9b6c051c9b70e2f67bcee9602b1244278b898e70348b8c6214c214ab::journey::journey_id(arg1) != 0x2::object::id<0x682d456a9b6c051c9b70e2f67bcee9602b1244278b898e70348b8c6214c214ab::journey::Journey>(arg2)) {
            return false
        };
        if (0x2::clock::timestamp_ms(arg3) >= draft_until_ms(arg1, arg2)) {
            return false
        };
        arg0 == draft_id(arg1)
    }

    public fun draft_id(arg0: &0x682d456a9b6c051c9b70e2f67bcee9602b1244278b898e70348b8c6214c214ab::journey::Session) : vector<u8> {
        let v0 = 0x2::object::id<0x682d456a9b6c051c9b70e2f67bcee9602b1244278b898e70348b8c6214c214ab::journey::Session>(arg0);
        let v1 = 0x2::object::id_to_bytes(&v0);
        0x1::vector::append<u8>(&mut v1, b"draft");
        v1
    }

    public fun draft_until_ms(arg0: &0x682d456a9b6c051c9b70e2f67bcee9602b1244278b898e70348b8c6214c214ab::journey::Session, arg1: &0x682d456a9b6c051c9b70e2f67bcee9602b1244278b898e70348b8c6214c214ab::journey::Journey) : u64 {
        purchase_ms(arg0, arg1) + 2592000000
    }

    public fun draft_window_ms() : u64 {
        2592000000
    }

    public fun purchase_ms(arg0: &0x682d456a9b6c051c9b70e2f67bcee9602b1244278b898e70348b8c6214c214ab::journey::Session, arg1: &0x682d456a9b6c051c9b70e2f67bcee9602b1244278b898e70348b8c6214c214ab::journey::Journey) : u64 {
        0x682d456a9b6c051c9b70e2f67bcee9602b1244278b898e70348b8c6214c214ab::journey::expiry_ms(arg0) - 0x682d456a9b6c051c9b70e2f67bcee9602b1244278b898e70348b8c6214c214ab::journey::window_ms(arg1)
    }

    entry fun seal_approve_draft(arg0: vector<u8>, arg1: &0x682d456a9b6c051c9b70e2f67bcee9602b1244278b898e70348b8c6214c214ab::journey::Session, arg2: &0x682d456a9b6c051c9b70e2f67bcee9602b1244278b898e70348b8c6214c214ab::journey::Journey, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(check_draft_policy(arg0, arg1, arg2, arg3, arg4), 1);
    }

    // decompiled from Move bytecode v7
}

