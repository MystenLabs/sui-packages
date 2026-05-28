module 0x8f6221a353c4ea356ea386893d1b9816a9392bf84c0b750ceb6c976eeaa598c8::example_consumer {
    struct GuardedLendingPool has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        max_risk_tolerance: u64,
        max_oracle_staleness_ms: u64,
        total_deposits: u64,
        total_borrows: u64,
    }

    struct GuardedDeposit has copy, drop {
        pool_id: address,
        amount: u64,
        risk_score: u64,
    }

    struct DepositBlocked has copy, drop {
        pool_id: address,
        amount: u64,
        risk_score: u64,
        max_tolerance: u64,
    }

    public fun borrow(arg0: &mut GuardedLendingPool, arg1: &0x8f6221a353c4ea356ea386893d1b9816a9392bf84c0b750ceb6c976eeaa598c8::risk_guardian::RiskScore, arg2: &0x8f6221a353c4ea356ea386893d1b9816a9392bf84c0b750ceb6c976eeaa598c8::risk_guardian::RiskPolicy, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x8f6221a353c4ea356ea386893d1b9816a9392bf84c0b750ceb6c976eeaa598c8::risk_guardian::assert_operational(arg1, arg2, arg0.max_risk_tolerance);
        0x8f6221a353c4ea356ea386893d1b9816a9392bf84c0b750ceb6c976eeaa598c8::risk_guardian::assert_fresh(arg1, arg3, arg0.max_oracle_staleness_ms);
        arg0.total_borrows = arg0.total_borrows + arg4;
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, arg4), arg5)
    }

    public fun can_operate(arg0: &GuardedLendingPool, arg1: &0x8f6221a353c4ea356ea386893d1b9816a9392bf84c0b750ceb6c976eeaa598c8::risk_guardian::RiskScore, arg2: &0x8f6221a353c4ea356ea386893d1b9816a9392bf84c0b750ceb6c976eeaa598c8::risk_guardian::RiskPolicy) : bool {
        0x8f6221a353c4ea356ea386893d1b9816a9392bf84c0b750ceb6c976eeaa598c8::risk_guardian::is_operational(arg1, arg2, arg0.max_risk_tolerance)
    }

    public fun create_pool(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = GuardedLendingPool{
            id                      : 0x2::object::new(arg2),
            balance                 : 0x2::balance::zero<0x2::sui::SUI>(),
            max_risk_tolerance      : arg0,
            max_oracle_staleness_ms : arg1,
            total_deposits          : 0,
            total_borrows           : 0,
        };
        0x2::transfer::share_object<GuardedLendingPool>(v0);
    }

    public fun deposit(arg0: &mut GuardedLendingPool, arg1: &0x8f6221a353c4ea356ea386893d1b9816a9392bf84c0b750ceb6c976eeaa598c8::risk_guardian::RiskScore, arg2: &0x8f6221a353c4ea356ea386893d1b9816a9392bf84c0b750ceb6c976eeaa598c8::risk_guardian::RiskPolicy, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x8f6221a353c4ea356ea386893d1b9816a9392bf84c0b750ceb6c976eeaa598c8::risk_guardian::assert_operational(arg1, arg2, arg0.max_risk_tolerance);
        0x8f6221a353c4ea356ea386893d1b9816a9392bf84c0b750ceb6c976eeaa598c8::risk_guardian::assert_fresh(arg1, arg3, arg0.max_oracle_staleness_ms);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg4);
        arg0.total_deposits = arg0.total_deposits + v0;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg4));
        let v1 = GuardedDeposit{
            pool_id    : 0x2::object::uid_to_address(&arg0.id),
            amount     : v0,
            risk_score : 0x8f6221a353c4ea356ea386893d1b9816a9392bf84c0b750ceb6c976eeaa598c8::risk_guardian::get_score(arg1),
        };
        0x2::event::emit<GuardedDeposit>(v1);
    }

    public fun max_tolerance(arg0: &GuardedLendingPool) : u64 {
        arg0.max_risk_tolerance
    }

    public fun total_borrows(arg0: &GuardedLendingPool) : u64 {
        arg0.total_borrows
    }

    public fun total_deposits(arg0: &GuardedLendingPool) : u64 {
        arg0.total_deposits
    }

    // decompiled from Move bytecode v7
}

