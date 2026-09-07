module 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_market {
    struct CLOBMarket has key {
        id: 0x2::object::UID,
        version: u64,
        market_id: u64,
        creator: address,
        state: u8,
        winning_outcome: u8,
        collateral_vault: 0x2::balance::Balance<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>,
        total_yes_shares: u64,
        total_no_shares: u64,
        invalid_settlement_price: u64,
    }

    struct CLOBMarketCreated has copy, drop {
        market_id: u64,
        market_object_id: 0x2::object::ID,
        creator: address,
    }

    struct Split has copy, drop {
        market_id: u64,
        user: address,
        amount: u64,
    }

    struct Merged has copy, drop {
        market_id: u64,
        user: address,
        amount: u64,
    }

    struct MarketPaused has copy, drop {
        market_id: u64,
    }

    struct MarketUnpaused has copy, drop {
        market_id: u64,
    }

    struct MarketResolved has copy, drop {
        market_id: u64,
        outcome: u8,
    }

    struct MarketCanceled has copy, drop {
        market_id: u64,
    }

    struct WinningsClaimed has copy, drop {
        market_id: u64,
        user: address,
        outcome: u8,
        amount: u64,
    }

    struct InvalidProceedsClaimed has copy, drop {
        market_id: u64,
        user: address,
        outcome: u8,
        shares_burned: u64,
        amount_out: u64,
    }

    public fun split(arg0: &mut CLOBMarket, arg1: 0x2::coin::Coin<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>, arg2: &mut 0x2::tx_context::TxContext) : (0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::outcome_share::OutcomeShare, 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::outcome_share::OutcomeShare) {
        assert_version(arg0);
        assert!(arg0.state == 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::state_trading(), 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::e_invalid_state());
        let v0 = 0x2::coin::value<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&arg1);
        assert!(v0 > 0, 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::e_zero_amount());
        0x2::balance::join<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&mut arg0.collateral_vault, 0x2::coin::into_balance<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(arg1));
        arg0.total_yes_shares = arg0.total_yes_shares + v0;
        arg0.total_no_shares = arg0.total_no_shares + v0;
        let v1 = 0x2::object::id<CLOBMarket>(arg0);
        let v2 = Split{
            market_id : arg0.market_id,
            user      : 0x2::tx_context::sender(arg2),
            amount    : v0,
        };
        0x2::event::emit<Split>(v2);
        (0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::outcome_share::mint(arg0.market_id, v1, 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::outcome_yes(), v0, arg2), 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::outcome_share::mint(arg0.market_id, v1, 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::outcome_no(), v0, arg2))
    }

    public fun id(arg0: &CLOBMarket) : 0x2::object::ID {
        assert_version(arg0);
        0x2::object::id<CLOBMarket>(arg0)
    }

    fun assert_version(arg0: &CLOBMarket) {
        assert!(arg0.version == 1, 100);
    }

    public(friend) fun cancel(arg0: &mut CLOBMarket) {
        settle(arg0, 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::outcome_invalid());
        let v0 = MarketCanceled{market_id: arg0.market_id};
        0x2::event::emit<MarketCanceled>(v0);
    }

    public(friend) fun claim_invalid_amount(arg0: &mut CLOBMarket, arg1: u8, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD> {
        assert_version(arg0);
        assert!(arg0.state == 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::state_resolved(), 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::e_invalid_state());
        assert!(arg0.winning_outcome == 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::outcome_invalid(), 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::e_invalid_outcome());
        assert!(arg0.invalid_settlement_price > 0, 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::e_invalid_state());
        0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::assert_binary_outcome(arg1);
        assert!(arg2 > 0, 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::e_zero_amount());
        let v0 = invalid_refund_amount(arg0, arg2);
        assert!(v0 > 0, 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::e_zero_amount());
        assert!(0x2::balance::value<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&arg0.collateral_vault) >= v0, 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::e_insufficient_balance());
        decrease_outstanding_shares(arg0, arg1, arg2);
        let v1 = InvalidProceedsClaimed{
            market_id     : arg0.market_id,
            user          : 0x2::tx_context::sender(arg3),
            outcome       : arg1,
            shares_burned : arg2,
            amount_out    : v0,
        };
        0x2::event::emit<InvalidProceedsClaimed>(v1);
        0x2::coin::from_balance<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(0x2::balance::split<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&mut arg0.collateral_vault, v0), arg3)
    }

    public fun claim_invalid_proceeds(arg0: &mut CLOBMarket, arg1: 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::outcome_share::OutcomeShare, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD> {
        assert_version(arg0);
        assert!(arg0.state == 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::state_resolved(), 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::e_invalid_state());
        assert!(arg0.winning_outcome == 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::outcome_invalid(), 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::e_invalid_outcome());
        assert!(arg0.invalid_settlement_price > 0, 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::e_invalid_state());
        let (v0, v1, v2, v3) = 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::outcome_share::burn(arg1);
        assert!(v0 == arg0.market_id, 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::e_invalid_outcome());
        assert!(v1 == 0x2::object::id<CLOBMarket>(arg0), 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::e_invalid_outcome());
        0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::assert_binary_outcome(v2);
        assert!(v3 > 0, 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::e_zero_amount());
        let v4 = (((v3 as u128) * (arg0.invalid_settlement_price as u128) / (0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::price_scale() as u128)) as u64);
        assert!(v4 > 0, 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::e_zero_amount());
        assert!(0x2::balance::value<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&arg0.collateral_vault) >= v4, 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::e_insufficient_balance());
        if (v2 == 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::outcome_yes()) {
            arg0.total_yes_shares = arg0.total_yes_shares - v3;
        } else {
            arg0.total_no_shares = arg0.total_no_shares - v3;
        };
        let v5 = InvalidProceedsClaimed{
            market_id     : arg0.market_id,
            user          : 0x2::tx_context::sender(arg2),
            outcome       : v2,
            shares_burned : v3,
            amount_out    : v4,
        };
        0x2::event::emit<InvalidProceedsClaimed>(v5);
        0x2::coin::from_balance<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(0x2::balance::split<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&mut arg0.collateral_vault, v4), arg2)
    }

    public fun collateral_balance(arg0: &CLOBMarket) : u64 {
        assert_version(arg0);
        0x2::balance::value<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&arg0.collateral_vault)
    }

    public fun creator(arg0: &CLOBMarket) : address {
        assert_version(arg0);
        arg0.creator
    }

    fun decrease_outstanding_shares(arg0: &mut CLOBMarket, arg1: u8, arg2: u64) {
        if (arg1 == 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::outcome_yes()) {
            arg0.total_yes_shares = arg0.total_yes_shares - arg2;
        } else {
            arg0.total_no_shares = arg0.total_no_shares - arg2;
        };
    }

    public(friend) fun emit_created(arg0: &CLOBMarket) {
        assert_version(arg0);
        let v0 = CLOBMarketCreated{
            market_id        : arg0.market_id,
            market_object_id : 0x2::object::id<CLOBMarket>(arg0),
            creator          : arg0.creator,
        };
        0x2::event::emit<CLOBMarketCreated>(v0);
    }

    fun invalid_refund_amount(arg0: &CLOBMarket, arg1: u64) : u64 {
        (((arg1 as u128) * (arg0.invalid_settlement_price as u128) / (0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::price_scale() as u128)) as u64)
    }

    public fun invalid_settlement_price(arg0: &CLOBMarket) : u64 {
        assert_version(arg0);
        arg0.invalid_settlement_price
    }

    public fun market_id(arg0: &CLOBMarket) : u64 {
        assert_version(arg0);
        arg0.market_id
    }

    public fun merge(arg0: &mut CLOBMarket, arg1: 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::outcome_share::OutcomeShare, arg2: 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::outcome_share::OutcomeShare, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD> {
        assert_version(arg0);
        assert!(arg0.state == 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::state_trading() || arg0.state == 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::state_paused(), 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::e_invalid_state());
        let v0 = 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::outcome_share::burn_expected(arg1, arg0.market_id, 0x2::object::id<CLOBMarket>(arg0), 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::outcome_yes());
        let v1 = 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::outcome_share::burn_expected(arg2, arg0.market_id, 0x2::object::id<CLOBMarket>(arg0), 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::outcome_no());
        assert!(v0 == v1, 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::e_invalid_outcome());
        assert!(0x2::balance::value<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&arg0.collateral_vault) >= v0, 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::e_insufficient_balance());
        arg0.total_yes_shares = arg0.total_yes_shares - v0;
        arg0.total_no_shares = arg0.total_no_shares - v1;
        let v2 = Merged{
            market_id : arg0.market_id,
            user      : 0x2::tx_context::sender(arg3),
            amount    : v0,
        };
        0x2::event::emit<Merged>(v2);
        0x2::coin::from_balance<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(0x2::balance::split<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&mut arg0.collateral_vault, v0), arg3)
    }

    public(friend) fun new_market(arg0: u64, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : CLOBMarket {
        CLOBMarket{
            id                       : 0x2::object::new(arg2),
            version                  : 1,
            market_id                : arg0,
            creator                  : arg1,
            state                    : 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::state_trading(),
            winning_outcome          : 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::outcome_unresolved(),
            collateral_vault         : 0x2::balance::zero<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(),
            total_yes_shares         : 0,
            total_no_shares          : 0,
            invalid_settlement_price : 0,
        }
    }

    public(friend) fun pause(arg0: &mut CLOBMarket) {
        assert_version(arg0);
        assert!(arg0.state == 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::state_trading(), 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::e_invalid_state());
        arg0.state = 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::state_paused();
        let v0 = MarketPaused{market_id: arg0.market_id};
        0x2::event::emit<MarketPaused>(v0);
    }

    public fun redeem(arg0: &mut CLOBMarket, arg1: 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::outcome_share::OutcomeShare, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD> {
        assert_version(arg0);
        assert!(arg0.state == 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::state_resolved(), 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::e_invalid_state());
        assert!(arg0.winning_outcome == 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::outcome_yes() || arg0.winning_outcome == 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::outcome_no(), 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::e_invalid_outcome());
        let v0 = 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::outcome_share::burn_expected(arg1, arg0.market_id, 0x2::object::id<CLOBMarket>(arg0), arg0.winning_outcome);
        assert!(v0 > 0, 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::e_zero_amount());
        assert!(0x2::balance::value<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&arg0.collateral_vault) >= v0, 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::e_insufficient_balance());
        if (arg0.winning_outcome == 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::outcome_yes()) {
            arg0.total_yes_shares = arg0.total_yes_shares - v0;
        } else {
            arg0.total_no_shares = arg0.total_no_shares - v0;
        };
        let v1 = WinningsClaimed{
            market_id : arg0.market_id,
            user      : 0x2::tx_context::sender(arg2),
            outcome   : arg0.winning_outcome,
            amount    : v0,
        };
        0x2::event::emit<WinningsClaimed>(v1);
        0x2::coin::from_balance<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(0x2::balance::split<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&mut arg0.collateral_vault, v0), arg2)
    }

    public(friend) fun redeem_amount(arg0: &mut CLOBMarket, arg1: u8, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD> {
        assert_version(arg0);
        assert!(arg0.state == 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::state_resolved(), 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::e_invalid_state());
        assert!(arg0.winning_outcome == 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::outcome_yes() || arg0.winning_outcome == 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::outcome_no(), 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::e_invalid_outcome());
        assert!(arg1 == arg0.winning_outcome, 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::e_invalid_outcome());
        assert!(arg2 > 0, 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::e_zero_amount());
        assert!(0x2::balance::value<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&arg0.collateral_vault) >= arg2, 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::e_insufficient_balance());
        decrease_outstanding_shares(arg0, arg1, arg2);
        let v0 = WinningsClaimed{
            market_id : arg0.market_id,
            user      : 0x2::tx_context::sender(arg3),
            outcome   : arg1,
            amount    : arg2,
        };
        0x2::event::emit<WinningsClaimed>(v0);
        0x2::coin::from_balance<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(0x2::balance::split<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&mut arg0.collateral_vault, arg2), arg3)
    }

    public(friend) fun settle(arg0: &mut CLOBMarket, arg1: u8) {
        assert_version(arg0);
        assert!(arg0.state == 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::state_trading() || arg0.state == 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::state_paused(), 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::e_invalid_state());
        0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::assert_resolution_outcome(arg1);
        arg0.winning_outcome = arg1;
        arg0.state = 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::state_resolved();
        if (arg1 == 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::outcome_invalid()) {
            settle_invalid(arg0);
        };
        let v0 = MarketResolved{
            market_id : arg0.market_id,
            outcome   : arg1,
        };
        0x2::event::emit<MarketResolved>(v0);
    }

    fun settle_invalid(arg0: &mut CLOBMarket) {
        let v0 = (arg0.total_yes_shares as u128) + (arg0.total_no_shares as u128);
        if (v0 == 0) {
            arg0.invalid_settlement_price = 0;
        } else {
            arg0.invalid_settlement_price = (((0x2::balance::value<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&arg0.collateral_vault) as u128) * (0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::price_scale() as u128) / v0) as u64);
        };
    }

    public(friend) fun share(arg0: CLOBMarket) {
        0x2::transfer::share_object<CLOBMarket>(arg0);
    }

    public fun state(arg0: &CLOBMarket) : u8 {
        assert_version(arg0);
        arg0.state
    }

    public fun total_no_shares(arg0: &CLOBMarket) : u64 {
        assert_version(arg0);
        arg0.total_no_shares
    }

    public fun total_yes_shares(arg0: &CLOBMarket) : u64 {
        assert_version(arg0);
        arg0.total_yes_shares
    }

    public(friend) fun unpause(arg0: &mut CLOBMarket) {
        assert_version(arg0);
        assert!(arg0.state == 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::state_paused(), 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::e_invalid_state());
        arg0.state = 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::state_trading();
        let v0 = MarketUnpaused{market_id: arg0.market_id};
        0x2::event::emit<MarketUnpaused>(v0);
    }

    public fun winning_outcome(arg0: &CLOBMarket) : u8 {
        assert_version(arg0);
        arg0.winning_outcome
    }

    // decompiled from Move bytecode v7
}

