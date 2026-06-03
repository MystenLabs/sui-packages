module 0xdede703868eb28efa64cb40fa5c9a44b2b37bd26b597fd655821c667b7d8fc62::portfolio {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Position has drop, store {
        symbol: vector<u8>,
        shares: u64,
        avg_price: u64,
        opened_at: u64,
    }

    struct UserPortfolio has store, key {
        id: 0x2::object::UID,
        owner: address,
        usdc_balance: u64,
        positions: vector<Position>,
        total_deposited: u64,
        total_withdrawn: u64,
    }

    struct ManagerState has key {
        id: 0x2::object::UID,
        agent: address,
        fee_bps: u64,
        portfolios: 0x2::table::Table<address, bool>,
    }

    struct Deposited has copy, drop {
        user: address,
        amount: u64,
    }

    struct TradeExecuted has copy, drop {
        user: address,
        symbol: vector<u8>,
        trade_type: u8,
        shares: u64,
        price_cents: u64,
    }

    public fun create_portfolio(arg0: &mut 0x2::tx_context::TxContext) : UserPortfolio {
        UserPortfolio{
            id              : 0x2::object::new(arg0),
            owner           : 0x2::tx_context::sender(arg0),
            usdc_balance    : 0,
            positions       : 0x1::vector::empty<Position>(),
            total_deposited : 0,
            total_withdrawn : 0,
        }
    }

    public fun deposit<T0>(arg0: &mut UserPortfolio, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        arg0.usdc_balance = arg0.usdc_balance + v0;
        arg0.total_deposited = arg0.total_deposited + v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg2));
        let v1 = Deposited{
            user   : arg0.owner,
            amount : v0,
        };
        0x2::event::emit<Deposited>(v1);
    }

    public fun execute_buy(arg0: &ManagerState, arg1: &mut UserPortfolio, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg0.agent, 3);
        let v0 = arg3 * arg4 / 1000000;
        assert!(arg1.usdc_balance >= v0, 1);
        arg1.usdc_balance = arg1.usdc_balance - v0;
        let v1 = &mut arg1.positions;
        let v2 = 0;
        let v3 = false;
        while (v2 < 0x1::vector::length<Position>(v1)) {
            let v4 = 0x1::vector::borrow_mut<Position>(v1, v2);
            if (v4.symbol == arg2) {
                let v5 = v4.shares + arg3;
                v4.shares = v5;
                v4.avg_price = (v4.avg_price * v4.shares + arg4 * arg3) / v5;
                v3 = true;
                break
            };
            v2 = v2 + 1;
        };
        if (!v3) {
            let v6 = Position{
                symbol    : arg2,
                shares    : arg3,
                avg_price : arg4,
                opened_at : 0,
            };
            0x1::vector::push_back<Position>(v1, v6);
        };
        let v7 = TradeExecuted{
            user        : arg1.owner,
            symbol      : arg2,
            trade_type  : 0,
            shares      : arg3,
            price_cents : arg4,
        };
        0x2::event::emit<TradeExecuted>(v7);
    }

    public fun execute_sell(arg0: &ManagerState, arg1: &mut UserPortfolio, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg0.agent, 3);
        let v0 = &mut arg1.positions;
        let v1 = 0;
        while (v1 < 0x1::vector::length<Position>(v0)) {
            let v2 = 0x1::vector::borrow_mut<Position>(v0, v1);
            if (v2.symbol == arg2) {
                assert!(v2.shares >= arg3, 2);
                v2.shares = v2.shares - arg3;
                arg1.usdc_balance = arg1.usdc_balance + arg3 * arg4 / 1000000;
                if (v2.shares == 0) {
                    0x1::vector::remove<Position>(v0, v1);
                };
                let v3 = TradeExecuted{
                    user        : arg1.owner,
                    symbol      : arg2,
                    trade_type  : 1,
                    shares      : arg3,
                    price_cents : arg4,
                };
                0x2::event::emit<TradeExecuted>(v3);
                return
            };
            v1 = v1 + 1;
        };
        abort 4
    }

    public fun get_balance(arg0: &UserPortfolio) : u64 {
        arg0.usdc_balance
    }

    public fun get_position_count(arg0: &UserPortfolio) : u64 {
        0x1::vector::length<Position>(&arg0.positions)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = ManagerState{
            id         : 0x2::object::new(arg0),
            agent      : 0x2::tx_context::sender(arg0),
            fee_bps    : 30,
            portfolios : 0x2::table::new<address, bool>(arg0),
        };
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<ManagerState>(v1);
    }

    public fun set_agent(arg0: &AdminCap, arg1: &mut ManagerState, arg2: address) {
        arg1.agent = arg2;
    }

    // decompiled from Move bytecode v7
}

