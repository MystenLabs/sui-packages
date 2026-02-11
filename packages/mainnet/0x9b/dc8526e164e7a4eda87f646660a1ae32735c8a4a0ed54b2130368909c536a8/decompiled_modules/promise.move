module 0x9bdc8526e164e7a4eda87f646660a1ae32735c8a4a0ed54b2130368909c536a8::promise {
    struct Promise has store, key {
        id: 0x2::object::UID,
        creator: address,
        beneficiary: address,
        amount: u64,
        check_in_interval: u64,
        last_check_in: u64,
        is_claimed: bool,
    }

    struct PromiseCreated has copy, drop {
        promise_id: address,
        creator: address,
        beneficiary: address,
        amount: u64,
        check_in_interval: u64,
    }

    struct CheckedIn has copy, drop {
        promise_id: address,
        user: address,
        timestamp: u64,
    }

    struct GiftClaimed has copy, drop {
        promise_id: address,
        beneficiary: address,
        amount: u64,
        timestamp: u64,
    }

    public fun can_claim(arg0: &Promise, arg1: &0x2::clock::Clock) : bool {
        if (arg0.is_claimed) {
            return false
        };
        0x2::clock::timestamp_ms(arg1) - arg0.last_check_in >= arg0.check_in_interval * 1000
    }

    entry fun check_in(arg0: &mut Promise, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert!(!arg0.is_claimed, 0);
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 1);
        arg0.last_check_in = 0x2::clock::timestamp_ms(arg1);
        let v0 = CheckedIn{
            promise_id : 0x2::object::id_address<Promise>(arg0),
            user       : 0x2::tx_context::sender(arg2),
            timestamp  : arg0.last_check_in,
        };
        0x2::event::emit<CheckedIn>(v0);
    }

    entry fun claim_gift(arg0: &mut Promise, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(!arg0.is_claimed, 0);
        assert!(0x2::tx_context::sender(arg3) == arg0.beneficiary, 2);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 - arg0.last_check_in >= arg0.check_in_interval * 1000, 3);
        arg0.is_claimed = true;
        let v1 = GiftClaimed{
            promise_id  : 0x2::object::id_address<Promise>(arg0),
            beneficiary : 0x2::tx_context::sender(arg3),
            amount      : arg0.amount,
            timestamp   : v0,
        };
        0x2::event::emit<GiftClaimed>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, 0x2::tx_context::sender(arg3));
    }

    entry fun create_promise(arg0: address, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        let v1 = Promise{
            id                : 0x2::object::new(arg4),
            creator           : 0x2::tx_context::sender(arg4),
            beneficiary       : arg0,
            amount            : v0,
            check_in_interval : arg1,
            last_check_in     : 0x2::clock::timestamp_ms(arg3),
            is_claimed        : false,
        };
        let v2 = PromiseCreated{
            promise_id        : 0x2::object::id_address<Promise>(&v1),
            creator           : 0x2::tx_context::sender(arg4),
            beneficiary       : arg0,
            amount            : v0,
            check_in_interval : arg1,
        };
        0x2::event::emit<PromiseCreated>(v2);
        0x2::transfer::share_object<Promise>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, 0x2::tx_context::sender(arg4));
    }

    public fun get_promise_info(arg0: &Promise) : (address, address, u64, u64, u64, bool) {
        (arg0.creator, arg0.beneficiary, arg0.amount, arg0.check_in_interval, arg0.last_check_in, arg0.is_claimed)
    }

    public fun get_remaining_time(arg0: &Promise, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg1) - arg0.last_check_in;
        let v1 = arg0.check_in_interval * 1000;
        if (v0 >= v1) {
            0
        } else {
            (v1 - v0) / 1000
        }
    }

    // decompiled from Move bytecode v6
}

