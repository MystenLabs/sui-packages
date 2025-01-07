module 0xd67366f03dbfe7f00e0da76be69fd910d50ba83a25e837b16bc3ce8639dcc063::core {
    struct Core has store, key {
        id: 0x2::object::UID,
        stats: Stats,
    }

    struct Stats has store {
        color: u8,
    }

    struct DropAdded<phantom T0> has copy, drop {
        core_id: 0x2::object::ID,
        drop_id: 0x2::object::ID,
    }

    public fun add_drop<T0: store + key>(arg0: &mut Core, arg1: T0) {
        let v0 = DropAdded<T0>{
            core_id : 0x2::object::id<Core>(arg0),
            drop_id : 0x2::object::id<T0>(&arg1),
        };
        0x2::event::emit<DropAdded<T0>>(v0);
        0x2::dynamic_object_field::add<0x2::object::ID, T0>(&mut arg0.id, 0x2::object::id<T0>(&arg1), arg1);
    }

    public entry fun create_core(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Stats{color: 255};
        let v1 = Core{
            id    : 0x2::object::new(arg0),
            stats : v0,
        };
        0x2::transfer::transfer<Core>(v1, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

