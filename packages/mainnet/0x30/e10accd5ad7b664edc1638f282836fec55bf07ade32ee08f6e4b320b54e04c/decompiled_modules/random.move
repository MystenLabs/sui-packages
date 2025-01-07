module 0x30e10accd5ad7b664edc1638f282836fec55bf07ade32ee08f6e4b320b54e04c::random {
    struct LuckyClub has key {
        id: 0x2::object::UID,
        user_list: vector<address>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct EventJoin has copy, drop {
        sender: address,
        user_length: u64,
    }

    struct EventRandomUserPickedByClock has copy, drop {
        user: address,
        random_index: u64,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = LuckyClub{
            id        : 0x2::object::new(arg0),
            user_list : 0x1::vector::empty<address>(),
        };
        0x2::transfer::share_object<LuckyClub>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun join(arg0: &mut LuckyClub, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(!0x1::vector::contains<address>(&arg0.user_list, &v0), 1);
        0x1::vector::push_back<address>(&mut arg0.user_list, v0);
        let v1 = EventJoin{
            sender      : v0,
            user_length : 0x1::vector::length<address>(&arg0.user_list),
        };
        0x2::event::emit<EventJoin>(v1);
    }

    public entry fun pickRandomUserByClock(arg0: &AdminCap, arg1: &LuckyClub, arg2: &0x2::clock::Clock) {
        let v0 = 0x1::vector::length<address>(&arg1.user_list);
        assert!(v0 > 0, 2);
        let v1 = 0x2::clock::timestamp_ms(arg2) % v0;
        let v2 = EventRandomUserPickedByClock{
            user         : *0x1::vector::borrow<address>(&arg1.user_list, v1),
            random_index : v1,
        };
        0x2::event::emit<EventRandomUserPickedByClock>(v2);
    }

    // decompiled from Move bytecode v6
}

