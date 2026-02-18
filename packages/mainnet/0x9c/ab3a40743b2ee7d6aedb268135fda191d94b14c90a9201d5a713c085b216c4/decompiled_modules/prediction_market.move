module 0x9cab3a40743b2ee7d6aedb268135fda191d94b14c90a9201d5a713c085b216c4::prediction_market {
    struct Market has key {
        id: 0x2::object::UID,
        question: 0x1::string::String,
        oracle: address,
        resolved: bool,
        outcome: bool,
        total_yes_stake: u64,
        total_no_stake: u64,
        pot: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct BetReceipt has store, key {
        id: 0x2::object::UID,
        market_id: 0x2::object::ID,
        prediction: bool,
        amount: u64,
    }

    struct MarketCreated has copy, drop {
        id: 0x2::object::ID,
        question: 0x1::string::String,
    }

    struct BetPlaced has copy, drop {
        market_id: 0x2::object::ID,
        user: address,
        prediction: bool,
        amount: u64,
    }

    struct MarketResolved has copy, drop {
        id: 0x2::object::ID,
        outcome: bool,
    }

    struct WinningsClaimed has copy, drop {
        market_id: 0x2::object::ID,
        user: address,
        amount: u64,
    }

    public fun claim_winnings(arg0: &mut Market, arg1: BetReceipt, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(arg0.resolved, 1);
        let BetReceipt {
            id         : v0,
            market_id  : v1,
            prediction : v2,
            amount     : v3,
        } = arg1;
        0x2::object::delete(v0);
        assert!(v1 == 0x2::object::uid_to_inner(&arg0.id), 3);
        assert!(v2 == arg0.outcome, 3);
        let v4 = if (arg0.outcome) {
            arg0.total_yes_stake
        } else {
            arg0.total_no_stake
        };
        assert!(v4 > 0, 3);
        let v5 = (((v3 as u128) * (0x2::balance::value<0x2::sui::SUI>(&arg0.pot) as u128) / (v4 as u128)) as u64);
        let v6 = WinningsClaimed{
            market_id : v1,
            user      : 0x2::tx_context::sender(arg2),
            amount    : v5,
        };
        0x2::event::emit<WinningsClaimed>(v6);
        0x2::coin::take<0x2::sui::SUI>(&mut arg0.pot, v5, arg2)
    }

    public fun create_market(arg0: vector<u8>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Market{
            id              : 0x2::object::new(arg2),
            question        : 0x1::string::utf8(arg0),
            oracle          : arg1,
            resolved        : false,
            outcome         : false,
            total_yes_stake : 0,
            total_no_stake  : 0,
            pot             : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        let v1 = MarketCreated{
            id       : 0x2::object::uid_to_inner(&v0.id),
            question : v0.question,
        };
        0x2::event::emit<MarketCreated>(v1);
        0x2::transfer::share_object<Market>(v0);
    }

    public fun place_bet(arg0: &mut Market, arg1: bool, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) : BetReceipt {
        assert!(!arg0.resolved, 0);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.pot, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        if (arg1) {
            arg0.total_yes_stake = arg0.total_yes_stake + v0;
        } else {
            arg0.total_no_stake = arg0.total_no_stake + v0;
        };
        let v1 = BetPlaced{
            market_id  : 0x2::object::uid_to_inner(&arg0.id),
            user       : 0x2::tx_context::sender(arg3),
            prediction : arg1,
            amount     : v0,
        };
        0x2::event::emit<BetPlaced>(v1);
        BetReceipt{
            id         : 0x2::object::new(arg3),
            market_id  : 0x2::object::uid_to_inner(&arg0.id),
            prediction : arg1,
            amount     : v0,
        }
    }

    public fun resolve_market(arg0: &mut Market, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.oracle, 2);
        assert!(!arg0.resolved, 0);
        arg0.resolved = true;
        arg0.outcome = arg1;
        let v0 = MarketResolved{
            id      : 0x2::object::uid_to_inner(&arg0.id),
            outcome : arg1,
        };
        0x2::event::emit<MarketResolved>(v0);
    }

    // decompiled from Move bytecode v6
}

