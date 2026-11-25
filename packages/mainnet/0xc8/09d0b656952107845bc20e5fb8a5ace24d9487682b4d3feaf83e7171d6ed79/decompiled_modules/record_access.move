module 0xc809d0b656952107845bc20e5fb8a5ace24d9487682b4d3feaf83e7171d6ed79::record_access {
    struct RecordAccess has key {
        id: 0x2::object::UID,
        release_id: 0x2::object::ID,
        edition: u16,
        number: u32,
        owner: address,
    }

    struct RecordAccessKey has copy, drop, store {
        dummy_field: bool,
    }

    struct RecordAccessCreatedEvent has copy, drop {
        record_access_id: 0x2::object::ID,
        record_id: 0x2::object::ID,
        release_id: 0x2::object::ID,
        edition: u16,
        number: u32,
        owner: address,
    }

    struct RecordAccessClaimedEvent has copy, drop {
        record_access_id: 0x2::object::ID,
        record_id: 0x2::object::ID,
        owner: address,
    }

    public fun claim(arg0: &mut RecordAccess, arg1: 0x428736685cb8dc84f9564f8293fc2868a4ab98c5d7222fde16b41e24587b0eb7::record::Record, arg2: &mut 0x2::tx_context::TxContext) : 0x428736685cb8dc84f9564f8293fc2868a4ab98c5d7222fde16b41e24587b0eb7::record::Record {
        let v0 = 0x2::object::id<0x428736685cb8dc84f9564f8293fc2868a4ab98c5d7222fde16b41e24587b0eb7::record::Record>(&arg1);
        let v1 = 0x2::object::id<RecordAccess>(arg0);
        assert!(0x2::object::id_to_address(&v1) == derive_address(v0), 0);
        let v2 = 0x2::tx_context::sender(arg2);
        if (arg0.owner != v2) {
            arg0.owner = v2;
            let v3 = RecordAccessClaimedEvent{
                record_access_id : 0x2::object::id<RecordAccess>(arg0),
                record_id        : v0,
                owner            : v2,
            };
            0x2::event::emit<RecordAccessClaimedEvent>(v3);
        };
        arg1
    }

    public fun derive_address(arg0: 0x2::object::ID) : address {
        let v0 = RecordAccessKey{dummy_field: false};
        0x2::derived_object::derive_address<RecordAccessKey>(arg0, v0)
    }

    public fun edition(arg0: &RecordAccess) : u16 {
        arg0.edition
    }

    public fun number(arg0: &RecordAccess) : u32 {
        arg0.number
    }

    public fun release_id(arg0: &RecordAccess) : 0x2::object::ID {
        arg0.release_id
    }

    public fun new(arg0: 0x428736685cb8dc84f9564f8293fc2868a4ab98c5d7222fde16b41e24587b0eb7::record::Record, arg1: &mut 0x2::tx_context::TxContext) : 0x428736685cb8dc84f9564f8293fc2868a4ab98c5d7222fde16b41e24587b0eb7::record::Record {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = RecordAccessKey{dummy_field: false};
        let v2 = RecordAccess{
            id         : 0x2::derived_object::claim<RecordAccessKey>(0x428736685cb8dc84f9564f8293fc2868a4ab98c5d7222fde16b41e24587b0eb7::record::uid_mut(&mut arg0), v1),
            release_id : 0x428736685cb8dc84f9564f8293fc2868a4ab98c5d7222fde16b41e24587b0eb7::record::release_id(&arg0),
            edition    : 0x428736685cb8dc84f9564f8293fc2868a4ab98c5d7222fde16b41e24587b0eb7::record::edition(&arg0),
            number     : 0x428736685cb8dc84f9564f8293fc2868a4ab98c5d7222fde16b41e24587b0eb7::record::number(&arg0),
            owner      : v0,
        };
        let v3 = RecordAccessCreatedEvent{
            record_access_id : 0x2::object::id<RecordAccess>(&v2),
            record_id        : 0x2::object::id<0x428736685cb8dc84f9564f8293fc2868a4ab98c5d7222fde16b41e24587b0eb7::record::Record>(&arg0),
            release_id       : v2.release_id,
            edition          : v2.edition,
            number           : v2.number,
            owner            : v0,
        };
        0x2::event::emit<RecordAccessCreatedEvent>(v3);
        0x2::transfer::share_object<RecordAccess>(v2);
        arg0
    }

    public fun owner(arg0: &RecordAccess) : address {
        arg0.owner
    }

    // decompiled from Move bytecode v7
}

