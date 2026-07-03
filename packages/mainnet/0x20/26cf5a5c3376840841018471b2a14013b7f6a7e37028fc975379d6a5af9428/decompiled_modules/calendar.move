module 0x2026cf5a5c3376840841018471b2a14013b7f6a7e37028fc975379d6a5af9428::calendar {
    struct CalendarRegistry has key {
        id: 0x2::object::UID,
        blobs: 0x2::table::Table<address, vector<u8>>,
    }

    struct CalendarBlobSet has copy, drop {
        owner: address,
        blob_id: vector<u8>,
    }

    public fun get_calendar_blob(arg0: &CalendarRegistry, arg1: address) : vector<u8> {
        if (0x2::table::contains<address, vector<u8>>(&arg0.blobs, arg1)) {
            *0x2::table::borrow<address, vector<u8>>(&arg0.blobs, arg1)
        } else {
            b""
        }
    }

    public entry fun initialize(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CalendarRegistry{
            id    : 0x2::object::new(arg0),
            blobs : 0x2::table::new<address, vector<u8>>(arg0),
        };
        0x2::transfer::share_object<CalendarRegistry>(v0);
    }

    public entry fun set_calendar_blob(arg0: &mut CalendarRegistry, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg1) > 0, 0);
        assert!(0x1::vector::length<u8>(&arg1) <= 256, 1);
        let v0 = 0x2::tx_context::sender(arg2);
        if (0x2::table::contains<address, vector<u8>>(&arg0.blobs, v0)) {
            *0x2::table::borrow_mut<address, vector<u8>>(&mut arg0.blobs, v0) = arg1;
        } else {
            0x2::table::add<address, vector<u8>>(&mut arg0.blobs, v0, arg1);
        };
        let v1 = CalendarBlobSet{
            owner   : v0,
            blob_id : arg1,
        };
        0x2::event::emit<CalendarBlobSet>(v1);
    }

    // decompiled from Move bytecode v7
}

