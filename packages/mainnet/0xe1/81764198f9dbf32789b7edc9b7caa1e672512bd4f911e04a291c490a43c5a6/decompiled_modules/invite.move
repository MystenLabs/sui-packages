module 0x674059ed3589517488541ad12cfee1af169d1b59a2c3840372deadb16784ee2b::invite {
    struct UserPool has store {
        pool_size: u64,
        root: address,
        inviters: 0x2::table::Table<address, address>,
    }

    public(friend) fun bind_inviter(arg0: &mut UserPool, arg1: address, arg2: address) : u64 {
        assert!(valid_inviter(arg0, arg2), 1);
        assert!(!valid_user(arg0, arg1), 2);
        let v0 = arg0.pool_size + 1;
        arg0.pool_size = v0;
        0x2::table::add<address, address>(&mut arg0.inviters, arg1, arg2);
        v0
    }

    public(friend) fun create_user_pool(arg0: address, arg1: &mut 0x2::tx_context::TxContext) : UserPool {
        UserPool{
            pool_size : 1,
            root      : arg0,
            inviters  : 0x2::table::new<address, address>(arg1),
        }
    }

    public fun find_inviter(arg0: &UserPool, arg1: address) : address {
        if (0x2::table::contains<address, address>(&arg0.inviters, arg1)) {
            *0x2::table::borrow<address, address>(&arg0.inviters, arg1)
        } else {
            @0x0
        }
    }

    public fun root(arg0: &UserPool) : address {
        arg0.root
    }

    public fun valid_inviter(arg0: &UserPool, arg1: address) : bool {
        arg1 == arg0.root || 0x2::table::contains<address, address>(&arg0.inviters, arg1)
    }

    public fun valid_user(arg0: &UserPool, arg1: address) : bool {
        arg1 == arg0.root || 0x2::table::contains<address, address>(&arg0.inviters, arg1)
    }

    // decompiled from Move bytecode v6
}

