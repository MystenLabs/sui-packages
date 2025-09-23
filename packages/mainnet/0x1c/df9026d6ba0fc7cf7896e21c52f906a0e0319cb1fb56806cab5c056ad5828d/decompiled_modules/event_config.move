module 0x1cdf9026d6ba0fc7cf7896e21c52f906a0e0319cb1fb56806cab5c056ad5828d::event_config {
    struct EventAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct EventConfig has store, key {
        id: 0x2::object::UID,
        create_event_tax: u64,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    public(friend) fun collect_tax(arg0: &mut EventConfig, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) == arg0.create_event_tax, 1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public fun get_create_event_tax(arg0: &EventConfig) : u64 {
        arg0.create_event_tax
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = EventAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<EventAdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = EventConfig{
            id               : 0x2::object::new(arg0),
            create_event_tax : 1000000000,
            balance          : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<EventConfig>(v1);
    }

    public entry fun set_create_event_tax(arg0: &EventAdminCap, arg1: &mut EventConfig, arg2: u64) {
        arg1.create_event_tax = arg2;
    }

    public entry fun withdraw_balance(arg0: &EventAdminCap, arg1: &mut EventConfig, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1.balance);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.balance, v0), arg2), 0x2::tx_context::sender(arg2));
        };
    }

    // decompiled from Move bytecode v6
}

