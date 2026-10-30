module 0xd77ce80f79ba3b3723931e6a5e6f6901105b23555a9f3c641dfda3c0123d210d::record {
    struct Record has store, key {
        id: 0x2::object::UID,
        release_id: 0x2::object::ID,
        pressing_id: 0x2::object::ID,
        edition: u16,
        number: u32,
        purchase_currency: 0x1::type_name::TypeName,
        purchase_price: u64,
        purchased_at_ms: u64,
    }

    struct RecordKey has copy, drop, store {
        pos0: u32,
    }

    struct RecordPurchasedEvent<phantom T0, phantom T1> has copy, drop {
        record_id: 0x2::object::ID,
        pressing_id: 0x2::object::ID,
        release_id: 0x2::object::ID,
        edition: u16,
        number: u32,
        purchase_price: u64,
        purchased_at_ms: u64,
    }

    struct RecordDestroyedEvent has copy, drop {
        record_id: 0x2::object::ID,
    }

    public fun derive_address(arg0: &0xd77ce80f79ba3b3723931e6a5e6f6901105b23555a9f3c641dfda3c0123d210d::pressing::Pressing, arg1: u32) : address {
        let v0 = RecordKey{pos0: arg1};
        0x2::derived_object::derive_address<RecordKey>(0x2::object::id<0xd77ce80f79ba3b3723931e6a5e6f6901105b23555a9f3c641dfda3c0123d210d::pressing::Pressing>(arg0), v0)
    }

    public fun edition(arg0: &Record) : u16 {
        arg0.edition
    }

    public fun release_id(arg0: &Record) : 0x2::object::ID {
        arg0.release_id
    }

    public fun destroy(arg0: Record) {
        let Record {
            id                : v0,
            release_id        : _,
            pressing_id       : _,
            edition           : _,
            number            : _,
            purchase_currency : _,
            purchase_price    : _,
            purchased_at_ms   : _,
        } = arg0;
        0x2::object::delete(v0);
        let v8 = RecordDestroyedEvent{record_id: 0x2::object::id<Record>(&arg0)};
        0x2::event::emit<RecordDestroyedEvent>(v8);
    }

    public fun number(arg0: &Record) : u32 {
        arg0.number
    }

    public fun press<T0: drop, T1>(arg0: &mut 0xd77ce80f79ba3b3723931e6a5e6f6901105b23555a9f3c641dfda3c0123d210d::pressing::Pressing, arg1: T0, arg2: u64, arg3: &0x2::clock::Clock) : Record {
        let v0 = 0xd77ce80f79ba3b3723931e6a5e6f6901105b23555a9f3c641dfda3c0123d210d::pressing::issue_number<T0>(arg0);
        let v1 = 0x2::object::id<0xd77ce80f79ba3b3723931e6a5e6f6901105b23555a9f3c641dfda3c0123d210d::pressing::Pressing>(arg0);
        let v2 = 0xd77ce80f79ba3b3723931e6a5e6f6901105b23555a9f3c641dfda3c0123d210d::pressing::release_id(arg0);
        let v3 = 0xd77ce80f79ba3b3723931e6a5e6f6901105b23555a9f3c641dfda3c0123d210d::pressing::edition(arg0);
        let v4 = RecordKey{pos0: v0};
        let v5 = Record{
            id                : 0x2::derived_object::claim<RecordKey>(0xd77ce80f79ba3b3723931e6a5e6f6901105b23555a9f3c641dfda3c0123d210d::pressing::package_uid_mut(arg0), v4),
            release_id        : v2,
            pressing_id       : v1,
            edition           : v3,
            number            : v0,
            purchase_currency : 0x1::type_name::with_defining_ids<T1>(),
            purchase_price    : arg2,
            purchased_at_ms   : 0x2::clock::timestamp_ms(arg3),
        };
        let v6 = RecordPurchasedEvent<T0, T1>{
            record_id       : 0x2::object::id<Record>(&v5),
            pressing_id     : v1,
            release_id      : v2,
            edition         : v3,
            number          : v0,
            purchase_price  : arg2,
            purchased_at_ms : v5.purchased_at_ms,
        };
        0x2::event::emit<RecordPurchasedEvent<T0, T1>>(v6);
        v5
    }

    public fun pressing_id(arg0: &Record) : 0x2::object::ID {
        arg0.pressing_id
    }

    public fun purchase_currency(arg0: &Record) : 0x1::type_name::TypeName {
        arg0.purchase_currency
    }

    public fun purchase_price(arg0: &Record) : u64 {
        arg0.purchase_price
    }

    public fun purchased_at_ms(arg0: &Record) : u64 {
        arg0.purchased_at_ms
    }

    public fun uid(arg0: &Record) : &0x2::object::UID {
        &arg0.id
    }

    public fun uid_mut(arg0: &mut Record) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    // decompiled from Move bytecode v7
}

