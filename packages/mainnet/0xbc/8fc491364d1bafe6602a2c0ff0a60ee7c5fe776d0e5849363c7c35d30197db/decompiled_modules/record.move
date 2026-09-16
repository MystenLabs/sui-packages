module 0xbc8fc491364d1bafe6602a2c0ff0a60ee7c5fe776d0e5849363c7c35d30197db::record {
    struct Record has store, key {
        id: 0x2::object::UID,
        release_id: 0x2::object::ID,
        pressing_id: 0x2::object::ID,
        edition: u16,
        number: u32,
        purchase_currency: 0x1::type_name::TypeName,
        purchase_price: u64,
        purchased_by: address,
        purchased_timestamp_ms: u64,
    }

    struct RecordKey has copy, drop, store {
        pos0: u32,
    }

    struct RecordDestroyedEvent has copy, drop {
        record_id: address,
        release_id: address,
        pressing_id: address,
        edition: u16,
        number: u32,
    }

    public fun derive_address(arg0: 0x2::object::ID, arg1: u32) : address {
        let v0 = RecordKey{pos0: arg1};
        0x2::derived_object::derive_address<RecordKey>(arg0, v0)
    }

    public fun destroy(arg0: Record) {
        let v0 = 0x2::object::id<Record>(&arg0);
        let Record {
            id                     : v1,
            release_id             : v2,
            pressing_id            : v3,
            edition                : v4,
            number                 : v5,
            purchase_currency      : _,
            purchase_price         : _,
            purchased_by           : _,
            purchased_timestamp_ms : _,
        } = arg0;
        let v10 = v3;
        let v11 = v2;
        0x2::object::delete(v1);
        let v12 = RecordDestroyedEvent{
            record_id   : 0x2::object::id_to_address(&v0),
            release_id  : 0x2::object::id_to_address(&v11),
            pressing_id : 0x2::object::id_to_address(&v10),
            edition     : v4,
            number      : v5,
        };
        0x2::event::emit<RecordDestroyedEvent>(v12);
    }

    public fun edition(arg0: &Record) : u16 {
        arg0.edition
    }

    public(friend) fun new<T0>(arg0: &mut 0x2::object::UID, arg1: 0x2::object::ID, arg2: u16, arg3: u32, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) : Record {
        let v0 = RecordKey{pos0: arg3};
        Record{
            id                     : 0x2::derived_object::claim<RecordKey>(arg0, v0),
            release_id             : arg1,
            pressing_id            : 0x2::object::uid_to_inner(arg0),
            edition                : arg2,
            number                 : arg3,
            purchase_currency      : 0x1::type_name::with_defining_ids<T0>(),
            purchase_price         : arg4,
            purchased_by           : 0x2::tx_context::sender(arg6),
            purchased_timestamp_ms : 0x2::clock::timestamp_ms(arg5),
        }
    }

    public fun number(arg0: &Record) : u32 {
        arg0.number
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

    public fun purchased_by(arg0: &Record) : address {
        arg0.purchased_by
    }

    public fun purchased_timestamp_ms(arg0: &Record) : u64 {
        arg0.purchased_timestamp_ms
    }

    public fun release_id(arg0: &Record) : 0x2::object::ID {
        arg0.release_id
    }

    public fun uid(arg0: &Record) : &0x2::object::UID {
        &arg0.id
    }

    public fun uid_mut(arg0: &mut Record) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    // decompiled from Move bytecode v7
}

