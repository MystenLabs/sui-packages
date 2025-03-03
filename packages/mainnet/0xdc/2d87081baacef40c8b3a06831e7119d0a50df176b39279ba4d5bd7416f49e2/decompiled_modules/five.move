module 0xdc2d87081baacef40c8b3a06831e7119d0a50df176b39279ba4d5bd7416f49e2::five {
    struct Raise has key {
        id: 0x2::object::UID,
        owner: address,
        raised: 0x2::balance::Balance<0x2::sui::SUI>,
        deposits: 0x2::table::Table<address, u64>,
        active: bool,
    }

    struct DepositEvent has copy, drop {
        user: address,
        amount: u64,
    }

    struct EmergencyWithdrawEvent has copy, drop {
        user: address,
        amount: u64,
        slashed: u64,
    }

    public fun create(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Raise{
            id       : 0x2::object::new(arg0),
            owner    : 0x2::tx_context::sender(arg0),
            raised   : 0x2::balance::zero<0x2::sui::SUI>(),
            deposits : 0x2::table::new<address, u64>(arg0),
            active   : false,
        };
        0x2::transfer::share_object<Raise>(v0);
    }

    public fun deposit(arg0: &mut Raise, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.active, 3);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
        let v2 = 0x2::balance::value<0x2::sui::SUI>(&v1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.raised, v1);
        if (0x2::table::contains<address, u64>(&arg0.deposits, v0)) {
            let v3 = 0x2::table::borrow_mut<address, u64>(&mut arg0.deposits, v0);
            *v3 = *v3 + v2;
        } else {
            0x2::table::add<address, u64>(&mut arg0.deposits, v0, v2);
        };
        let v4 = DepositEvent{
            user   : v0,
            amount : v2,
        };
        0x2::event::emit<DepositEvent>(v4);
    }

    public entry fun emergency_withdraw(arg0: &mut Raise, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::table::contains<address, u64>(&arg0.deposits, v0), 1);
        let v1 = 0x2::table::remove<address, u64>(&mut arg0.deposits, v0);
        let v2 = v1 / 2;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.raised, v2), arg1), v0);
        let v3 = EmergencyWithdrawEvent{
            user    : v0,
            amount  : v2,
            slashed : v1 - v2,
        };
        0x2::event::emit<EmergencyWithdrawEvent>(v3);
    }

    public entry fun end_event(arg0: &mut Raise, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 2);
        arg0.active = false;
    }

    public fun get_total_raised(arg0: &Raise) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.raised)
    }

    public fun get_user_deposit(arg0: &Raise, arg1: address) : u64 {
        if (!0x2::table::contains<address, u64>(&arg0.deposits, arg1)) {
            return 0
        };
        *0x2::table::borrow<address, u64>(&arg0.deposits, arg1)
    }

    public fun is_event_active(arg0: &Raise) : bool {
        arg0.active
    }

    public entry fun start_event(arg0: &mut Raise, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 2);
        arg0.active = true;
    }

    public entry fun withdraw(arg0: &mut Raise, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.raised), arg1), arg0.owner);
    }

    // decompiled from Move bytecode v6
}

