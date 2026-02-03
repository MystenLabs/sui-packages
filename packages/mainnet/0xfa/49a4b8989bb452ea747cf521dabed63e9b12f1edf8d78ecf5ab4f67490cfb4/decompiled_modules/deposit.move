module 0xfa49a4b8989bb452ea747cf521dabed63e9b12f1edf8d78ecf5ab4f67490cfb4::deposit {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct UserAccount has store {
        balance: u64,
        last_updated: u64,
    }

    struct Bank has key {
        id: 0x2::object::UID,
        pool: 0x2::balance::Balance<0xb696b148be1f7d358a2540081ce7052c13c68b7b917895282de4b987e6467e17::puimon::PUIMON>,
        total_principal: u64,
        balances: 0x2::table::Table<address, UserAccount>,
        interest_rate: u64,
    }

    entry fun deposit(arg0: &mut Bank, arg1: 0x2::coin::Coin<0xb696b148be1f7d358a2540081ce7052c13c68b7b917895282de4b987e6467e17::puimon::PUIMON>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0xb696b148be1f7d358a2540081ce7052c13c68b7b917895282de4b987e6467e17::puimon::PUIMON>(&arg1);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 > 0, 1);
        0x2::balance::join<0xb696b148be1f7d358a2540081ce7052c13c68b7b917895282de4b987e6467e17::puimon::PUIMON>(&mut arg0.pool, 0x2::coin::into_balance<0xb696b148be1f7d358a2540081ce7052c13c68b7b917895282de4b987e6467e17::puimon::PUIMON>(arg1));
        arg0.total_principal = arg0.total_principal + v0;
        if (0x2::table::contains<address, UserAccount>(&arg0.balances, v1)) {
            let v3 = 0x2::table::borrow_mut<address, UserAccount>(&mut arg0.balances, v1);
            v3.balance = v3.balance + calculate_interest(v3.balance, v3.last_updated, v2, arg0.interest_rate) + v0;
            v3.last_updated = v2;
        } else {
            let v4 = UserAccount{
                balance      : v0,
                last_updated : v2,
            };
            0x2::table::add<address, UserAccount>(&mut arg0.balances, v1, v4);
        };
    }

    fun calculate_interest(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        if (arg2 <= arg1) {
            return 0
        };
        arg0 * arg3 * (arg2 - arg1) / 1000 / 10000 * 31536000
    }

    entry fun fund_bank(arg0: &mut Bank, arg1: 0x2::coin::Coin<0xb696b148be1f7d358a2540081ce7052c13c68b7b917895282de4b987e6467e17::puimon::PUIMON>) {
        0x2::balance::join<0xb696b148be1f7d358a2540081ce7052c13c68b7b917895282de4b987e6467e17::puimon::PUIMON>(&mut arg0.pool, 0x2::coin::into_balance<0xb696b148be1f7d358a2540081ce7052c13c68b7b917895282de4b987e6467e17::puimon::PUIMON>(arg1));
    }

    public fun get_balance(arg0: &Bank, arg1: address, arg2: &0x2::clock::Clock) : u64 {
        if (!0x2::table::contains<address, UserAccount>(&arg0.balances, arg1)) {
            return 0
        };
        let v0 = 0x2::table::borrow<address, UserAccount>(&arg0.balances, arg1);
        v0.balance + calculate_interest(v0.balance, v0.last_updated, 0x2::clock::timestamp_ms(arg2), arg0.interest_rate)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Bank{
            id              : 0x2::object::new(arg0),
            pool            : 0x2::balance::zero<0xb696b148be1f7d358a2540081ce7052c13c68b7b917895282de4b987e6467e17::puimon::PUIMON>(),
            total_principal : 0,
            balances        : 0x2::table::new<address, UserAccount>(arg0),
            interest_rate   : 1500,
        };
        0x2::transfer::share_object<Bank>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    entry fun set_rate(arg0: &AdminCap, arg1: &mut Bank, arg2: u64) {
        assert!(arg2 <= 10000, 2);
        arg1.interest_rate = arg2;
    }

    entry fun withdraw(arg0: &mut Bank, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = 0x2::table::borrow_mut<address, UserAccount>(&mut arg0.balances, v0);
        v2.balance = v2.balance + calculate_interest(v2.balance, v2.last_updated, v1, arg0.interest_rate);
        v2.last_updated = v1;
        assert!(v2.balance >= arg1, 0);
        v2.balance = v2.balance - arg1;
        arg0.total_principal = arg0.total_principal - arg1;
        0x2::transfer::public_transfer<0x2::coin::Coin<0xb696b148be1f7d358a2540081ce7052c13c68b7b917895282de4b987e6467e17::puimon::PUIMON>>(0x2::coin::take<0xb696b148be1f7d358a2540081ce7052c13c68b7b917895282de4b987e6467e17::puimon::PUIMON>(&mut arg0.pool, arg1, arg3), v0);
    }

    // decompiled from Move bytecode v6
}

