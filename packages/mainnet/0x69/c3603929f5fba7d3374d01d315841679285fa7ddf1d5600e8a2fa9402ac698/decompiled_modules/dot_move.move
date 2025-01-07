module 0x69c3603929f5fba7d3374d01d315841679285fa7ddf1d5600e8a2fa9402ac698::dot_move {
    struct DotMove has store, key {
        id: 0x2::object::UID,
        name: 0x69c3603929f5fba7d3374d01d315841679285fa7ddf1d5600e8a2fa9402ac698::name::Name,
        expiration_timestamp_ms: u64,
    }

    public(friend) fun new(arg0: 0x69c3603929f5fba7d3374d01d315841679285fa7ddf1d5600e8a2fa9402ac698::name::Name, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : DotMove {
        assert!(arg1 > 0x2::clock::timestamp_ms(arg2), 1);
        DotMove{
            id                      : 0x2::object::new(arg3),
            name                    : arg0,
            expiration_timestamp_ms : arg1,
        }
    }

    public(friend) fun burn(arg0: DotMove) {
        let DotMove {
            id                      : v0,
            name                    : _,
            expiration_timestamp_ms : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun has_expired(arg0: &DotMove, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) > arg0.expiration_timestamp_ms
    }

    public fun id(arg0: &DotMove) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun name(arg0: &DotMove) : 0x69c3603929f5fba7d3374d01d315841679285fa7ddf1d5600e8a2fa9402ac698::name::Name {
        arg0.name
    }

    public(friend) fun set_expiration_timestamp_ms(arg0: &mut DotMove, arg1: u64, arg2: &0x2::clock::Clock) {
        assert!(arg1 > 0x2::clock::timestamp_ms(arg2), 1);
        arg0.expiration_timestamp_ms = arg1;
    }

    // decompiled from Move bytecode v6
}

