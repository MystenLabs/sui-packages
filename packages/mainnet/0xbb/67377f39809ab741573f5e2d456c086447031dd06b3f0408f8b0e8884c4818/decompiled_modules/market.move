module 0xa6d7003f05576dc9b38bd6f03fc580017d995e8c8b0bb4ee2beab15af74078cc::market {
    struct Market<phantom T0> has key {
        id: 0x2::object::UID,
        admin: address,
        treasury: address,
        close_time_ms: u64,
        fee_bps: u64,
        resolved: bool,
        outcome_yes: bool,
        yes_pool: 0x2::balance::Balance<T0>,
        no_pool: 0x2::balance::Balance<T0>,
        payout_pool: 0x2::balance::Balance<T0>,
        fee_pool: 0x2::balance::Balance<T0>,
        total_yes_shares: u64,
        total_no_shares: u64,
    }

    struct YesToken has store, key {
        id: 0x2::object::UID,
        market_id: 0x2::object::ID,
        shares: u64,
        claimed: bool,
    }

    struct NoToken has store, key {
        id: 0x2::object::UID,
        market_id: 0x2::object::ID,
        shares: u64,
        claimed: bool,
    }

    struct MarketCreated has copy, drop {
        market_id: 0x2::object::ID,
        admin: address,
        close_time_ms: u64,
    }

    struct BetPlaced has copy, drop {
        market_id: 0x2::object::ID,
        bettor: address,
        position: bool,
        amount: u64,
        shares: u64,
    }

    struct MarketResolved has copy, drop {
        market_id: 0x2::object::ID,
        outcome_yes: bool,
    }

    struct TokenRedeemed has copy, drop {
        market_id: 0x2::object::ID,
        winner: address,
        payout: u64,
    }

    public entry fun bet_no<T0>(arg0: &mut Market<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        buy_no<T0>(arg0, arg1, arg2, arg3);
    }

    public entry fun bet_yes<T0>(arg0: &mut Market<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        buy_yes<T0>(arg0, arg1, arg2, arg3);
    }

    public entry fun buy_no<T0>(arg0: &mut Market<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg2) < arg0.close_time_ms, 1);
        assert!(!arg0.resolved, 4);
        let v0 = 0x2::coin::value<T0>(&arg1);
        0x2::coin::put<T0>(&mut arg0.no_pool, arg1);
        arg0.total_no_shares = arg0.total_no_shares + v0;
        let v1 = NoToken{
            id        : 0x2::object::new(arg3),
            market_id : 0x2::object::uid_to_inner(&arg0.id),
            shares    : v0,
            claimed   : false,
        };
        let v2 = BetPlaced{
            market_id : 0x2::object::uid_to_inner(&arg0.id),
            bettor    : 0x2::tx_context::sender(arg3),
            position  : false,
            amount    : v0,
            shares    : v0,
        };
        0x2::event::emit<BetPlaced>(v2);
        0x2::transfer::transfer<NoToken>(v1, 0x2::tx_context::sender(arg3));
    }

    public entry fun buy_yes<T0>(arg0: &mut Market<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg2) < arg0.close_time_ms, 1);
        assert!(!arg0.resolved, 4);
        let v0 = 0x2::coin::value<T0>(&arg1);
        0x2::coin::put<T0>(&mut arg0.yes_pool, arg1);
        arg0.total_yes_shares = arg0.total_yes_shares + v0;
        let v1 = YesToken{
            id        : 0x2::object::new(arg3),
            market_id : 0x2::object::uid_to_inner(&arg0.id),
            shares    : v0,
            claimed   : false,
        };
        let v2 = BetPlaced{
            market_id : 0x2::object::uid_to_inner(&arg0.id),
            bettor    : 0x2::tx_context::sender(arg3),
            position  : true,
            amount    : v0,
            shares    : v0,
        };
        0x2::event::emit<BetPlaced>(v2);
        0x2::transfer::transfer<YesToken>(v1, 0x2::tx_context::sender(arg3));
    }

    public entry fun claim_no<T0>(arg0: &mut Market<T0>, arg1: &mut NoToken, arg2: &mut 0x2::tx_context::TxContext) {
        redeem_no<T0>(arg0, arg1, arg2);
    }

    public entry fun claim_yes<T0>(arg0: &mut Market<T0>, arg1: &mut YesToken, arg2: &mut 0x2::tx_context::TxContext) {
        redeem_yes<T0>(arg0, arg1, arg2);
    }

    public entry fun create_market_fixed<T0>(arg0: address, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg4);
        let v1 = Market<T0>{
            id               : v0,
            admin            : 0x2::tx_context::sender(arg4),
            treasury         : arg0,
            close_time_ms    : arg2,
            fee_bps          : arg3,
            resolved         : false,
            outcome_yes      : false,
            yes_pool         : 0x2::balance::zero<T0>(),
            no_pool          : 0x2::balance::zero<T0>(),
            payout_pool      : 0x2::balance::zero<T0>(),
            fee_pool         : 0x2::balance::zero<T0>(),
            total_yes_shares : 0,
            total_no_shares  : 0,
        };
        let v2 = MarketCreated{
            market_id     : 0x2::object::uid_to_inner(&v0),
            admin         : 0x2::tx_context::sender(arg4),
            close_time_ms : arg2,
        };
        0x2::event::emit<MarketCreated>(v2);
        0x2::transfer::share_object<Market<T0>>(v1);
    }

    public entry fun redeem_no<T0>(arg0: &mut Market<T0>, arg1: &mut NoToken, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.resolved, 3);
        assert!(!arg0.outcome_yes, 7);
        assert!(arg1.market_id == 0x2::object::uid_to_inner(&arg0.id), 8);
        assert!(!arg1.claimed, 6);
        let v0 = arg1.shares * 0x2::balance::value<T0>(&arg0.payout_pool) / arg0.total_no_shares;
        assert!(v0 > 0, 9);
        arg1.claimed = true;
        let v1 = TokenRedeemed{
            market_id : 0x2::object::uid_to_inner(&arg0.id),
            winner    : 0x2::tx_context::sender(arg2),
            payout    : v0,
        };
        0x2::event::emit<TokenRedeemed>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.payout_pool, v0), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun redeem_yes<T0>(arg0: &mut Market<T0>, arg1: &mut YesToken, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.resolved, 3);
        assert!(arg0.outcome_yes, 7);
        assert!(arg1.market_id == 0x2::object::uid_to_inner(&arg0.id), 8);
        assert!(!arg1.claimed, 6);
        let v0 = arg1.shares * 0x2::balance::value<T0>(&arg0.payout_pool) / arg0.total_yes_shares;
        assert!(v0 > 0, 9);
        arg1.claimed = true;
        let v1 = TokenRedeemed{
            market_id : 0x2::object::uid_to_inner(&arg0.id),
            winner    : 0x2::tx_context::sender(arg2),
            payout    : v0,
        };
        0x2::event::emit<TokenRedeemed>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.payout_pool, v0), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun resolve<T0>(arg0: &mut Market<T0>, arg1: bool, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 2);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg0.close_time_ms, 5);
        assert!(!arg0.resolved, 4);
        0x2::balance::join<T0>(&mut arg0.payout_pool, 0x2::balance::withdraw_all<T0>(&mut arg0.yes_pool));
        0x2::balance::join<T0>(&mut arg0.payout_pool, 0x2::balance::withdraw_all<T0>(&mut arg0.no_pool));
        0x2::balance::join<T0>(&mut arg0.fee_pool, 0x2::balance::split<T0>(&mut arg0.payout_pool, (0x2::balance::value<T0>(&arg0.yes_pool) + 0x2::balance::value<T0>(&arg0.no_pool)) * arg0.fee_bps / 10000));
        arg0.resolved = true;
        arg0.outcome_yes = arg1;
        let v0 = MarketResolved{
            market_id   : 0x2::object::uid_to_inner(&arg0.id),
            outcome_yes : arg1,
        };
        0x2::event::emit<MarketResolved>(v0);
    }

    public entry fun withdraw_fee<T0>(arg0: &mut Market<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 2);
        0x2::balance::value<T0>(&arg0.fee_pool);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.fee_pool), arg1), arg0.treasury);
    }

    // decompiled from Move bytecode v6
}

