module 0xec8159f9edca64a8788e17e8bddbf54aa4c980bfa23f32bda3589e0212347024::record {
    struct Record has store, key {
        id: 0x2::object::UID,
        release_id: 0x2::object::ID,
        pressing_id: 0x2::object::ID,
        edition: u16,
        number: u32,
    }

    struct RecordKey has copy, drop, store {
        pos0: u32,
    }

    struct RecordCreatedEvent<phantom T0> has copy, drop {
        record_id: 0x2::object::ID,
        pressing_id: 0x2::object::ID,
        release_id: 0x2::object::ID,
        edition: u16,
        number: u32,
    }

    struct RecordDestroyedEvent has copy, drop {
        record_id: 0x2::object::ID,
    }

    public fun derive_address(arg0: &0xec8159f9edca64a8788e17e8bddbf54aa4c980bfa23f32bda3589e0212347024::pressing::Pressing, arg1: u32) : address {
        let v0 = RecordKey{pos0: arg1};
        0x2::derived_object::derive_address<RecordKey>(0x2::object::id<0xec8159f9edca64a8788e17e8bddbf54aa4c980bfa23f32bda3589e0212347024::pressing::Pressing>(arg0), v0)
    }

    public fun edition(arg0: &Record) : u16 {
        arg0.edition
    }

    public fun release_id(arg0: &Record) : 0x2::object::ID {
        arg0.release_id
    }

    public fun destroy(arg0: Record) {
        let Record {
            id          : v0,
            release_id  : _,
            pressing_id : _,
            edition     : _,
            number      : _,
        } = arg0;
        0x2::object::delete(v0);
        let v5 = RecordDestroyedEvent{record_id: 0x2::object::id<Record>(&arg0)};
        0x2::event::emit<RecordDestroyedEvent>(v5);
    }

    public fun new<T0: drop>(arg0: &mut 0xec8159f9edca64a8788e17e8bddbf54aa4c980bfa23f32bda3589e0212347024::pressing::Pressing, arg1: T0) : Record {
        let v0 = 0xec8159f9edca64a8788e17e8bddbf54aa4c980bfa23f32bda3589e0212347024::pressing::issue_number<T0>(arg0);
        let v1 = 0x2::object::id<0xec8159f9edca64a8788e17e8bddbf54aa4c980bfa23f32bda3589e0212347024::pressing::Pressing>(arg0);
        let v2 = 0xec8159f9edca64a8788e17e8bddbf54aa4c980bfa23f32bda3589e0212347024::pressing::release_id(arg0);
        let v3 = 0xec8159f9edca64a8788e17e8bddbf54aa4c980bfa23f32bda3589e0212347024::pressing::edition(arg0);
        let v4 = RecordKey{pos0: v0};
        let v5 = Record{
            id          : 0x2::derived_object::claim<RecordKey>(0xec8159f9edca64a8788e17e8bddbf54aa4c980bfa23f32bda3589e0212347024::pressing::package_uid_mut(arg0), v4),
            release_id  : v2,
            pressing_id : v1,
            edition     : v3,
            number      : v0,
        };
        let v6 = RecordCreatedEvent<T0>{
            record_id   : 0x2::object::id<Record>(&v5),
            pressing_id : v1,
            release_id  : v2,
            edition     : v3,
            number      : v0,
        };
        0x2::event::emit<RecordCreatedEvent<T0>>(v6);
        v5
    }

    public fun number(arg0: &Record) : u32 {
        arg0.number
    }

    public fun pressing_id(arg0: &Record) : 0x2::object::ID {
        arg0.pressing_id
    }

    public fun uid(arg0: &Record) : &0x2::object::UID {
        &arg0.id
    }

    public fun uid_mut(arg0: &mut Record) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    // decompiled from Move bytecode v7
}

