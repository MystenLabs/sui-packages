module 0x7c9387bfd10831ba375c8897765b4809776d31c4f0ef1ceda187de3b26fd815b::subscription {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Subscription has store, key {
        id: 0x2::object::UID,
        subscriber: address,
        expires_at: u64,
    }

    struct Treasury has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    public fun expires_at(arg0: &Subscription) : u64 {
        arg0.expires_at
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Treasury{
            id      : 0x2::object::new(arg0),
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<Treasury>(v1);
    }

    public fun is_active(arg0: &Subscription, arg1: &0x2::clock::Clock) : bool {
        arg0.expires_at > 0x2::clock::timestamp_ms(arg1)
    }

    public fun seal_approve(arg0: vector<u8>, arg1: &Subscription, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.subscriber == 0x2::tx_context::sender(arg3), 3);
        assert!(arg1.expires_at > 0x2::clock::timestamp_ms(arg2), 2);
    }

    public fun subscribe(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut Treasury, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) >= 100000000, 1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg0));
        let v0 = Subscription{
            id         : 0x2::object::new(arg3),
            subscriber : 0x2::tx_context::sender(arg3),
            expires_at : 0x2::clock::timestamp_ms(arg2) + 2592000000,
        };
        0x2::transfer::transfer<Subscription>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun treasury_balance(arg0: &Treasury) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public fun withdraw(arg0: &AdminCap, arg1: &mut Treasury, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.balance, 0x2::balance::value<0x2::sui::SUI>(&arg1.balance)), arg2)
    }

    // decompiled from Move bytecode v6
}

