module 0x346c31a4c87f2b1a6a86400efbe81832fa82857996d15c2d58dafca306288c26::vault {
    struct Vault has key {
        id: 0x2::object::UID,
        total_deposits: 0x2::balance::Balance<0x2::sui::SUI>,
        user_balances: 0x2::vec_map::VecMap<address, u64>,
        owner: address,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct DepositEvent has copy, drop {
        user: address,
        amount: u64,
    }

    struct WithdrawalEvent has copy, drop {
        user: address,
        amount: u64,
    }

    struct BetProcessedEvent has copy, drop {
        user: address,
        bet_amount: u64,
        payout: u64,
        won: bool,
    }

    public entry fun deposit(arg0: &mut Vault, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.total_deposits, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        if (0x2::vec_map::contains<address, u64>(&arg0.user_balances, &v0)) {
            let (_, _) = 0x2::vec_map::remove<address, u64>(&mut arg0.user_balances, &v0);
            0x2::vec_map::insert<address, u64>(&mut arg0.user_balances, v0, *0x2::vec_map::get<address, u64>(&arg0.user_balances, &v0) + v1);
        } else {
            0x2::vec_map::insert<address, u64>(&mut arg0.user_balances, v0, v1);
        };
        let v4 = DepositEvent{
            user   : v0,
            amount : v1,
        };
        0x2::event::emit<DepositEvent>(v4);
    }

    public fun get_balance(arg0: &Vault, arg1: address) : u64 {
        if (0x2::vec_map::contains<address, u64>(&arg0.user_balances, &arg1)) {
            *0x2::vec_map::get<address, u64>(&arg0.user_balances, &arg1)
        } else {
            0
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = Vault{
            id             : 0x2::object::new(arg0),
            total_deposits : 0x2::balance::zero<0x2::sui::SUI>(),
            user_balances  : 0x2::vec_map::empty<address, u64>(),
            owner          : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<Vault>(v1);
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun process_bet(arg0: &mut Vault, arg1: &AdminCap, arg2: address, arg3: u64, arg4: u64, arg5: bool) {
        assert!(0x2::vec_map::contains<address, u64>(&arg0.user_balances, &arg2), 0);
        let v0 = *0x2::vec_map::get<address, u64>(&arg0.user_balances, &arg2);
        assert!(v0 >= arg3, 0);
        let v1 = if (arg5) {
            v0 - arg3 + arg4
        } else {
            v0 - arg3
        };
        let (_, _) = 0x2::vec_map::remove<address, u64>(&mut arg0.user_balances, &arg2);
        0x2::vec_map::insert<address, u64>(&mut arg0.user_balances, arg2, v1);
        let v4 = BetProcessedEvent{
            user       : arg2,
            bet_amount : arg3,
            payout     : arg4,
            won        : arg5,
        };
        0x2::event::emit<BetProcessedEvent>(v4);
    }

    public fun withdraw(arg0: &mut Vault, arg1: &AdminCap, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::vec_map::contains<address, u64>(&arg0.user_balances, &arg2), 0);
        let v0 = *0x2::vec_map::get<address, u64>(&arg0.user_balances, &arg2);
        assert!(v0 >= arg3, 0);
        let (_, _) = 0x2::vec_map::remove<address, u64>(&mut arg0.user_balances, &arg2);
        0x2::vec_map::insert<address, u64>(&mut arg0.user_balances, arg2, v0 - arg3);
        let v3 = WithdrawalEvent{
            user   : arg2,
            amount : arg3,
        };
        0x2::event::emit<WithdrawalEvent>(v3);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.total_deposits, arg3), arg4)
    }

    // decompiled from Move bytecode v6
}

