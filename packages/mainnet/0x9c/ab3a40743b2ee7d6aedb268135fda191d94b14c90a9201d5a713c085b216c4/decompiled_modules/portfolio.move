module 0x9cab3a40743b2ee7d6aedb268135fda191d94b14c90a9201d5a713c085b216c4::portfolio {
    struct ManagerCap has store, key {
        id: 0x2::object::UID,
    }

    struct Portfolio has key {
        id: 0x2::object::UID,
        owner: address,
        sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct PortfolioCreated has copy, drop {
        id: 0x2::object::ID,
        owner: address,
    }

    struct Deposit has copy, drop {
        portfolio_id: 0x2::object::ID,
        amount: u64,
    }

    struct Withdrawal has copy, drop {
        portfolio_id: 0x2::object::ID,
        amount: u64,
    }

    struct Rebalanced has copy, drop {
        portfolio_id: 0x2::object::ID,
        strategy: 0x1::string::String,
    }

    public fun create_portfolio(arg0: &mut 0x2::tx_context::TxContext) : ManagerCap {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = 0x2::object::new(arg0);
        let v2 = PortfolioCreated{
            id    : 0x2::object::uid_to_inner(&v1),
            owner : v0,
        };
        0x2::event::emit<PortfolioCreated>(v2);
        let v3 = Portfolio{
            id          : v1,
            owner       : v0,
            sui_balance : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<Portfolio>(v3);
        ManagerCap{id: 0x2::object::new(arg0)}
    }

    public fun deposit(arg0: &mut Portfolio, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v0 = Deposit{
            portfolio_id : 0x2::object::uid_to_inner(&arg0.id),
            amount       : 0x2::coin::value<0x2::sui::SUI>(&arg1),
        };
        0x2::event::emit<Deposit>(v0);
    }

    public fun execute_strategy(arg0: &ManagerCap, arg1: &mut Portfolio, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.sui_balance) > 0, 2);
        let v0 = Rebalanced{
            portfolio_id : 0x2::object::uid_to_inner(&arg1.id),
            strategy     : arg2,
        };
        0x2::event::emit<Rebalanced>(v0);
    }

    public fun withdraw(arg0: &mut Portfolio, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 0);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance) >= arg1, 2);
        let v0 = Withdrawal{
            portfolio_id : 0x2::object::uid_to_inner(&arg0.id),
            amount       : arg1,
        };
        0x2::event::emit<Withdrawal>(v0);
        0x2::coin::take<0x2::sui::SUI>(&mut arg0.sui_balance, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

