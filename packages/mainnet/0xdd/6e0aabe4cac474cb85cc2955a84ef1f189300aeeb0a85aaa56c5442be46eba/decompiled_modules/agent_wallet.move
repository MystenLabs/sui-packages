module 0xdd6e0aabe4cac474cb85cc2955a84ef1f189300aeeb0a85aaa56c5442be46eba::agent_wallet {
    struct AgentWalletCreated has copy, drop {
        wallet_id: 0x2::object::ID,
        admin: address,
        agent_id: address,
        daily_limit: u64,
    }

    struct ActionExecuted has copy, drop {
        wallet_id: 0x2::object::ID,
        amount: u64,
        remaining_budget: u64,
        recipient: address,
        epoch: u64,
    }

    struct BudgetRefilled has copy, drop {
        wallet_id: 0x2::object::ID,
        new_budget: u64,
        epoch: u64,
    }

    struct EmergencyHaltToggled has copy, drop {
        wallet_id: 0x2::object::ID,
        is_halted: bool,
    }

    struct SpendingLimitUpdated has copy, drop {
        wallet_id: 0x2::object::ID,
        old_limit: u64,
        new_limit: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        wallet_id: 0x2::object::ID,
    }

    struct AgentCap has store, key {
        id: 0x2::object::UID,
        wallet_id: 0x2::object::ID,
    }

    struct AgentWallet<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        daily_limit: u64,
        spent_this_epoch: u64,
        last_refill_epoch: u64,
        is_halted: bool,
    }

    public fun admin_withdraw<T0>(arg0: &mut AgentWallet<T0>, arg1: &AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1.wallet_id == 0x2::object::id<AgentWallet<T0>>(arg0), 3);
        assert!(0x2::balance::value<T0>(&arg0.balance) >= arg2, 4);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg2), arg3)
    }

    public fun balance_value<T0>(arg0: &AgentWallet<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun create_wallet<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg3);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = 0x2::tx_context::sender(arg3);
        let v3 = AgentWallet<T0>{
            id                : v0,
            balance           : 0x2::coin::into_balance<T0>(arg0),
            daily_limit       : arg1,
            spent_this_epoch  : 0,
            last_refill_epoch : 0x2::tx_context::epoch(arg3),
            is_halted         : false,
        };
        let v4 = AdminCap{
            id        : 0x2::object::new(arg3),
            wallet_id : v1,
        };
        let v5 = AgentCap{
            id        : 0x2::object::new(arg3),
            wallet_id : v1,
        };
        let v6 = AgentWalletCreated{
            wallet_id   : v1,
            admin       : v2,
            agent_id    : arg2,
            daily_limit : arg1,
        };
        0x2::event::emit<AgentWalletCreated>(v6);
        0x2::transfer::public_transfer<AdminCap>(v4, v2);
        0x2::transfer::public_transfer<AgentCap>(v5, arg2);
        0x2::transfer::share_object<AgentWallet<T0>>(v3);
    }

    public fun daily_limit<T0>(arg0: &AgentWallet<T0>) : u64 {
        arg0.daily_limit
    }

    public fun deposit<T0>(arg0: &mut AgentWallet<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::put<T0>(&mut arg0.balance, arg1);
    }

    public fun is_halted<T0>(arg0: &AgentWallet<T0>) : bool {
        arg0.is_halted
    }

    public fun remaining_budget<T0>(arg0: &AgentWallet<T0>) : u64 {
        if (arg0.daily_limit >= arg0.spent_this_epoch) {
            arg0.daily_limit - arg0.spent_this_epoch
        } else {
            0
        }
    }

    public fun set_daily_limit<T0>(arg0: &mut AgentWallet<T0>, arg1: &AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.wallet_id == 0x2::object::id<AgentWallet<T0>>(arg0), 3);
        arg0.daily_limit = arg2;
        let v0 = SpendingLimitUpdated{
            wallet_id : 0x2::object::id<AgentWallet<T0>>(arg0),
            old_limit : arg0.daily_limit,
            new_limit : arg2,
        };
        0x2::event::emit<SpendingLimitUpdated>(v0);
    }

    public fun spend<T0>(arg0: &mut AgentWallet<T0>, arg1: &AgentCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(!arg0.is_halted, 2);
        assert!(arg1.wallet_id == 0x2::object::id<AgentWallet<T0>>(arg0), 3);
        assert!(arg2 > 0, 5);
        let v0 = 0x2::tx_context::epoch(arg3);
        if (v0 > arg0.last_refill_epoch) {
            arg0.spent_this_epoch = 0;
            arg0.last_refill_epoch = v0;
            let v1 = BudgetRefilled{
                wallet_id  : 0x2::object::id<AgentWallet<T0>>(arg0),
                new_budget : arg0.daily_limit,
                epoch      : v0,
            };
            0x2::event::emit<BudgetRefilled>(v1);
        };
        assert!(arg0.spent_this_epoch + arg2 <= arg0.daily_limit, 1);
        assert!(0x2::balance::value<T0>(&arg0.balance) >= arg2, 4);
        arg0.spent_this_epoch = arg0.spent_this_epoch + arg2;
        let v2 = ActionExecuted{
            wallet_id        : 0x2::object::id<AgentWallet<T0>>(arg0),
            amount           : arg2,
            remaining_budget : arg0.daily_limit - arg0.spent_this_epoch,
            recipient        : 0x2::tx_context::sender(arg3),
            epoch            : v0,
        };
        0x2::event::emit<ActionExecuted>(v2);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg2), arg3)
    }

    public fun toggle_emergency_halt<T0>(arg0: &mut AgentWallet<T0>, arg1: &AdminCap, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.wallet_id == 0x2::object::id<AgentWallet<T0>>(arg0), 3);
        arg0.is_halted = arg2;
        let v0 = EmergencyHaltToggled{
            wallet_id : 0x2::object::id<AgentWallet<T0>>(arg0),
            is_halted : arg2,
        };
        0x2::event::emit<EmergencyHaltToggled>(v0);
    }

    // decompiled from Move bytecode v7
}

