module 0x8adba6bdbe026bbcf9bbc00d602d45673f32af4e0350365465b91c33086be2e8::market {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Market has store, key {
        id: 0x2::object::UID,
        question: 0x1::string::String,
        description: 0x1::string::String,
        deadline: u64,
        outcome: 0x1::option::Option<bool>,
        yes_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        no_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        prize_pool: 0x2::balance::Balance<0x2::sui::SUI>,
        total_yes_shares: u64,
        total_no_shares: u64,
    }

    struct Bet has store, key {
        id: 0x2::object::UID,
        market_id: 0x2::object::ID,
        outcome: bool,
        amount: u64,
        claimed: bool,
    }

    struct MarketCreated has copy, drop {
        id: 0x2::object::ID,
        question: 0x1::string::String,
        deadline: u64,
    }

    struct MarketResolved has copy, drop {
        id: 0x2::object::ID,
        outcome: bool,
    }

    struct BetPlaced has copy, drop {
        market_id: 0x2::object::ID,
        better: address,
        outcome: bool,
        amount: u64,
    }

    public entry fun bet(arg0: &mut Market, arg1: bool, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_none<bool>(&arg0.outcome), 0);
        assert!(0x2::clock::timestamp_ms(arg3) < arg0.deadline, 3);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v0 > 0, 7);
        if (arg1) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.yes_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
            arg0.total_yes_shares = arg0.total_yes_shares + v0;
        } else {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.no_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
            arg0.total_no_shares = arg0.total_no_shares + v0;
        };
        let v1 = Bet{
            id        : 0x2::object::new(arg4),
            market_id : 0x2::object::id<Market>(arg0),
            outcome   : arg1,
            amount    : v0,
            claimed   : false,
        };
        let v2 = BetPlaced{
            market_id : 0x2::object::id<Market>(arg0),
            better    : 0x2::tx_context::sender(arg4),
            outcome   : arg1,
            amount    : v0,
        };
        0x2::event::emit<BetPlaced>(v2);
        0x2::transfer::transfer<Bet>(v1, 0x2::tx_context::sender(arg4));
    }

    public entry fun claim(arg0: &mut Market, arg1: &mut Bet, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<bool>(&arg0.outcome), 1);
        assert!(!arg1.claimed, 6);
        assert!(arg1.market_id == 0x2::object::id<Market>(arg0), 2);
        let v0 = *0x1::option::borrow<bool>(&arg0.outcome);
        assert!(arg1.outcome == v0, 4);
        arg1.claimed = true;
        let v1 = if (v0) {
            (((arg1.amount as u128) * (0x2::balance::value<0x2::sui::SUI>(&arg0.prize_pool) as u128) / (arg0.total_yes_shares as u128)) as u64)
        } else {
            (((arg1.amount as u128) * (0x2::balance::value<0x2::sui::SUI>(&arg0.prize_pool) as u128) / (arg0.total_no_shares as u128)) as u64)
        };
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.prize_pool, v1), arg2), 0x2::tx_context::sender(arg2));
        };
    }

    public entry fun create_market(arg0: &AdminCap, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Market{
            id               : 0x2::object::new(arg4),
            question         : 0x1::string::utf8(arg1),
            description      : 0x1::string::utf8(arg2),
            deadline         : arg3,
            outcome          : 0x1::option::none<bool>(),
            yes_balance      : 0x2::balance::zero<0x2::sui::SUI>(),
            no_balance       : 0x2::balance::zero<0x2::sui::SUI>(),
            prize_pool       : 0x2::balance::zero<0x2::sui::SUI>(),
            total_yes_shares : 0,
            total_no_shares  : 0,
        };
        let v1 = MarketCreated{
            id       : 0x2::object::id<Market>(&v0),
            question : v0.question,
            deadline : arg3,
        };
        0x2::event::emit<MarketCreated>(v1);
        0x2::transfer::share_object<Market>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun resolve(arg0: &AdminCap, arg1: &mut Market, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_none<bool>(&arg1.outcome), 0);
        arg1.outcome = 0x1::option::some<bool>(arg2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.prize_pool, 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg1.yes_balance));
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.prize_pool, 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg1.no_balance));
        let v0 = MarketResolved{
            id      : 0x2::object::id<Market>(arg1),
            outcome : arg2,
        };
        0x2::event::emit<MarketResolved>(v0);
    }

    // decompiled from Move bytecode v6
}

