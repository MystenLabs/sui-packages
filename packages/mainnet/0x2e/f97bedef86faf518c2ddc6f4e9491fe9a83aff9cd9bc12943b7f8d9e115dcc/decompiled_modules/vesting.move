module 0x2ef97bedef86faf518c2ddc6f4e9491fe9a83aff9cd9bc12943b7f8d9e115dcc::vesting {
    struct Lock<phantom T0> has key {
        id: 0x2::object::UID,
        creator: address,
        recipient: address,
        unlock_ms: u64,
        total: u64,
        title: 0x1::string::String,
        claimed: bool,
        balance: 0x2::balance::Balance<T0>,
    }

    struct LockCreated has copy, drop {
        lock_id: 0x2::object::ID,
        creator: address,
        recipient: address,
        coin_type: 0x1::ascii::String,
        unlock_ms: u64,
        amount: u64,
        title: 0x1::string::String,
    }

    struct Claimed has copy, drop {
        lock_id: 0x2::object::ID,
        recipient: address,
        amount: u64,
    }

    public entry fun claim<T0>(arg0: &mut Lock<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.recipient, 0);
        assert!(!arg0.claimed, 2);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.unlock_ms, 1);
        arg0.claimed = true;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.balance), arg2), arg0.recipient);
        let v0 = Claimed{
            lock_id   : 0x2::object::uid_to_inner(&arg0.id),
            recipient : arg0.recipient,
            amount    : 0x2::balance::value<T0>(&arg0.balance),
        };
        0x2::event::emit<Claimed>(v0);
    }

    public fun claimed<T0>(arg0: &Lock<T0>) : bool {
        arg0.claimed
    }

    public entry fun lock<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: u64, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        let v1 = 0x2::object::new(arg4);
        let v2 = 0x2::tx_context::sender(arg4);
        let v3 = Lock<T0>{
            id        : v1,
            creator   : v2,
            recipient : arg1,
            unlock_ms : arg2,
            total     : v0,
            title     : arg3,
            claimed   : false,
            balance   : 0x2::coin::into_balance<T0>(arg0),
        };
        let v4 = LockCreated{
            lock_id   : 0x2::object::uid_to_inner(&v1),
            creator   : v2,
            recipient : arg1,
            coin_type : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            unlock_ms : arg2,
            amount    : v0,
            title     : v3.title,
        };
        0x2::event::emit<LockCreated>(v4);
        0x2::transfer::share_object<Lock<T0>>(v3);
    }

    public fun recipient<T0>(arg0: &Lock<T0>) : address {
        arg0.recipient
    }

    public fun remaining<T0>(arg0: &Lock<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun total<T0>(arg0: &Lock<T0>) : u64 {
        arg0.total
    }

    public fun unlock_ms<T0>(arg0: &Lock<T0>) : u64 {
        arg0.unlock_ms
    }

    // decompiled from Move bytecode v6
}

