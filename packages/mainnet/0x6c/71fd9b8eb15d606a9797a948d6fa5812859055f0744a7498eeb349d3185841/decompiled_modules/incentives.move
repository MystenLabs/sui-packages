module 0xdd948da2ecf515c3403ec64a4a4c9aacf7ac5b27481b731d5eb54d065bf84c7b::incentives {
    struct Reserve has store {
        balances: 0x2::bag::Bag,
        budgets: 0x2::bag::Bag,
    }

    struct Asset<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct Period<phantom T0> has copy, drop, store {
        epoch: u64,
    }

    struct Funded<phantom T0> has copy, drop {
        pool: 0x2::object::ID,
        amount: u64,
    }

    struct BudgetChanged<phantom T0> has copy, drop {
        pool: 0x2::object::ID,
        epoch: u64,
        amount: u64,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : Reserve {
        Reserve{
            balances : 0x2::bag::new(arg0),
            budgets  : 0x2::bag::new(arg0),
        }
    }

    public fun available<T0>(arg0: &Reserve) : u64 {
        let v0 = Asset<T0>{dummy_field: false};
        if (!0x2::bag::contains<Asset<T0>>(&arg0.balances, v0)) {
            return 0
        };
        0x2::balance::value<T0>(0x2::bag::borrow<Asset<T0>, 0x2::balance::Balance<T0>>(&arg0.balances, v0))
    }

    public fun budget<T0>(arg0: &Reserve, arg1: u64) : u64 {
        let v0 = Period<T0>{epoch: arg1};
        if (!0x2::bag::contains<Period<T0>>(&arg0.budgets, v0)) {
            return 0
        };
        *0x2::bag::borrow<Period<T0>, u64>(&arg0.budgets, v0)
    }

    public(friend) fun configure<T0>(arg0: &mut Reserve, arg1: 0x2::object::ID, arg2: u64, arg3: u64) {
        let v0 = Period<T0>{epoch: arg2};
        if (0x2::bag::contains<Period<T0>>(&arg0.budgets, v0)) {
            *0x2::bag::borrow_mut<Period<T0>, u64>(&mut arg0.budgets, v0) = arg3;
        } else {
            0x2::bag::add<Period<T0>, u64>(&mut arg0.budgets, v0, arg3);
        };
        let v1 = BudgetChanged<T0>{
            pool   : arg1,
            epoch  : arg2,
            amount : arg3,
        };
        0x2::event::emit<BudgetChanged<T0>>(v1);
    }

    public(friend) fun deposit<T0>(arg0: &mut Reserve, arg1: 0x2::object::ID, arg2: 0x2::balance::Balance<T0>) {
        let v0 = Asset<T0>{dummy_field: false};
        if (!0x2::bag::contains<Asset<T0>>(&arg0.balances, v0)) {
            0x2::bag::add<Asset<T0>, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0, 0x2::balance::zero<T0>());
        };
        0x2::balance::join<T0>(0x2::bag::borrow_mut<Asset<T0>, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0), arg2);
        let v1 = Funded<T0>{
            pool   : arg1,
            amount : 0x2::balance::value<T0>(&arg2),
        };
        0x2::event::emit<Funded<T0>>(v1);
    }

    public(friend) fun draw<T0>(arg0: &mut Reserve, arg1: u64, arg2: u64) : 0x2::balance::Balance<T0> {
        assert!(arg2 > 0 && arg2 <= budget<T0>(arg0, arg1), 0);
        let v0 = Asset<T0>{dummy_field: false};
        0x2::balance::split<T0>(0x2::bag::borrow_mut<Asset<T0>, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0), arg2)
    }

    // decompiled from Move bytecode v7
}

