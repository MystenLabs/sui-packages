module 0x24a881ecb449e2d748b127033b4c88bfa7abcfa52cc5fa83e3fba0bd5e8cc123::agent {
    struct SmartAgent has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        total_trades_executed: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        agent_id: 0x2::object::ID,
    }

    struct DelegateCap has store, key {
        id: 0x2::object::UID,
        agent_id: 0x2::object::ID,
    }

    struct TradeExecuted has copy, drop {
        agent_id: 0x2::object::ID,
        amount_used: u64,
        trade_type: u8,
    }

    public fun create_delegate(arg0: &SmartAgent, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) : DelegateCap {
        assert!(0x2::object::id<SmartAgent>(arg0) == arg1.agent_id, 0);
        DelegateCap{
            id       : 0x2::object::new(arg2),
            agent_id : 0x2::object::id<SmartAgent>(arg0),
        }
    }

    public fun deposit(arg0: &mut SmartAgent, arg1: &AdminCap, arg2: 0x2::coin::Coin<0x2::sui::SUI>) {
        assert!(0x2::object::id<SmartAgent>(arg0) == arg1.agent_id, 0);
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.balance, arg2);
    }

    public fun execute_trade(arg0: &mut SmartAgent, arg1: &DelegateCap, arg2: u64, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<SmartAgent>(arg0) == arg1.agent_id, 0);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.balance) >= arg2, 0);
        arg0.total_trades_executed = arg0.total_trades_executed + 1;
        let v0 = TradeExecuted{
            agent_id    : 0x2::object::id<SmartAgent>(arg0),
            amount_used : arg2,
            trade_type  : arg3,
        };
        0x2::event::emit<TradeExecuted>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SmartAgent{
            id                    : 0x2::object::new(arg0),
            balance               : 0x2::balance::zero<0x2::sui::SUI>(),
            total_trades_executed : 0,
        };
        let v1 = AdminCap{
            id       : 0x2::object::new(arg0),
            agent_id : 0x2::object::id<SmartAgent>(&v0),
        };
        0x2::transfer::share_object<SmartAgent>(v0);
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun withdraw(arg0: &mut SmartAgent, arg1: &AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::object::id<SmartAgent>(arg0) == arg1.agent_id, 0);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.balance) >= arg2, 0);
        0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, arg2, arg3)
    }

    // decompiled from Move bytecode v7
}

