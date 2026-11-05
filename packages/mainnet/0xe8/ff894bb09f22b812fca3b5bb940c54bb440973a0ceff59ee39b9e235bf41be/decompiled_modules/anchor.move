module 0xe8ff894bb09f22b812fca3b5bb940c54bb440973a0ceff59ee39b9e235bf41be::anchor {
    struct HeadAnchor has key {
        id: 0x2::object::UID,
        shop_id: vector<u8>,
        last_day: vector<u8>,
        head_hash: vector<u8>,
        day_count: u64,
        updated_ms: u64,
    }

    struct AnchorCap has store, key {
        id: 0x2::object::UID,
        anchor_id: 0x2::object::ID,
    }

    public fun create(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) : AnchorCap {
        let v0 = HeadAnchor{
            id         : 0x2::object::new(arg1),
            shop_id    : arg0,
            last_day   : b"",
            head_hash  : b"",
            day_count  : 0,
            updated_ms : 0,
        };
        let v1 = AnchorCap{
            id        : 0x2::object::new(arg1),
            anchor_id : 0x2::object::id<HeadAnchor>(&v0),
        };
        0x2::transfer::share_object<HeadAnchor>(v0);
        v1
    }

    public fun update(arg0: &mut HeadAnchor, arg1: &AnchorCap, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: &0x2::clock::Clock) {
        assert!(arg1.anchor_id == 0x2::object::id<HeadAnchor>(arg0), 0);
        assert!(arg4 > arg0.day_count, 1);
        arg0.last_day = arg2;
        arg0.head_hash = arg3;
        arg0.day_count = arg4;
        arg0.updated_ms = 0x2::clock::timestamp_ms(arg5);
    }

    // decompiled from Move bytecode v7
}

