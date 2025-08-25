module 0xfc1922ae0f9021550924b4b353bb595ec3e78a72a4fe6da351dd9af376dd1614::dig {
    struct Hole has store, key {
        id: 0x2::object::UID,
        distance: u64,
        progress: u64,
        users: 0x2::table::Table<address, u64>,
    }

    public fun new(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : Hole {
        assert!(arg0 > 0, 1000);
        Hole{
            id       : 0x2::object::new(arg1),
            distance : arg0,
            progress : 0,
            users    : 0x2::table::new<address, u64>(arg1),
        }
    }

    entry fun dig(arg0: &mut Hole, arg1: &0x2::random::Random, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.progress < arg0.distance, 1001);
        arg0.progress = arg0.progress + 1;
        let v0 = 0x2::tx_context::sender(arg2);
        if (!0x2::table::contains<address, u64>(&arg0.users, v0)) {
            0x2::table::add<address, u64>(&mut arg0.users, v0, 1);
        } else {
            let v1 = 0x2::table::borrow_mut<address, u64>(&mut arg0.users, v0);
            *v1 = *v1 + 1;
        };
    }

    public fun distance(arg0: &Hole) : u64 {
        arg0.distance
    }

    public fun id(arg0: &Hole) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun is_complete(arg0: &Hole) : bool {
        arg0.progress == arg0.distance
    }

    public fun progress(arg0: &Hole) : u64 {
        arg0.progress
    }

    public fun user_digs(arg0: &Hole, arg1: address) : u64 {
        if (!0x2::table::contains<address, u64>(&arg0.users, arg1)) {
            0
        } else {
            *0x2::table::borrow<address, u64>(&arg0.users, arg1)
        }
    }

    public fun users(arg0: &Hole) : &0x2::table::Table<address, u64> {
        &arg0.users
    }

    // decompiled from Move bytecode v6
}

