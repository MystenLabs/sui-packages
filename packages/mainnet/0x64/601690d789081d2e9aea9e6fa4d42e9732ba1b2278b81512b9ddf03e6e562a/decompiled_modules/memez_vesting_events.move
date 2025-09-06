module 0x1a184ecf7d0652f8f1285a3b0b2e644bf86ae1742317fcdaa9b11a7f3a30bd70::memez_vesting_events {
    struct Event<T0: copy + drop> has copy, drop {
        pos0: T0,
    }

    struct New has copy, drop {
        memez_vesting: address,
        owner: address,
        amount: u64,
        start: u64,
        duration: u64,
        coinType: 0x1::ascii::String,
    }

    struct Claimed has copy, drop {
        memez_vesting: address,
        amount: u64,
        coinType: 0x1::ascii::String,
    }

    struct Destroyed has copy, drop {
        memez_vesting: address,
        coinType: 0x1::ascii::String,
    }

    public(friend) fun claimed<T0>(arg0: address, arg1: u64) {
        let v0 = Claimed{
            memez_vesting : arg0,
            amount        : arg1,
            coinType      : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
        };
        let v1 = Event<Claimed>{pos0: v0};
        0x2::event::emit<Event<Claimed>>(v1);
    }

    public(friend) fun destroyed<T0>(arg0: address) {
        let v0 = Destroyed{
            memez_vesting : arg0,
            coinType      : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
        };
        let v1 = Event<Destroyed>{pos0: v0};
        0x2::event::emit<Event<Destroyed>>(v1);
    }

    public(friend) fun new<T0>(arg0: address, arg1: address, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = New{
            memez_vesting : arg0,
            owner         : arg1,
            amount        : arg2,
            start         : arg3,
            duration      : arg4,
            coinType      : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
        };
        let v1 = Event<New>{pos0: v0};
        0x2::event::emit<Event<New>>(v1);
    }

    // decompiled from Move bytecode v6
}

