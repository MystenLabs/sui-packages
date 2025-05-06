module 0x372db155a445bc92cc59941eff95f272c71eb180032973ad154f895d13e51f2c::prediction_market {
    struct OutcomeToken has store, key {
        id: 0x2::object::UID,
        market_id: 0x2::object::ID,
        outcome: u8,
    }

    struct Market has store, key {
        id: 0x2::object::UID,
        creator: address,
        description: vector<u8>,
        collateral: 0x2::balance::Balance<0x2::sui::SUI>,
        outcome_yes: u64,
        outcome_no: u64,
        resolved: bool,
        winning_outcome: 0x1::option::Option<u8>,
        deadline: u64,
    }

    public fun buy_shares(arg0: &mut Market, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u8) {
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.collateral, arg1);
        if (arg2 == 0) {
            arg0.outcome_no = arg0.outcome_no + 0x2::coin::value<0x2::sui::SUI>(&arg1);
        } else {
            arg0.outcome_yes = arg0.outcome_yes + 0x2::coin::value<0x2::sui::SUI>(&arg1);
        };
    }

    public fun create_market(arg0: vector<u8>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : Market {
        Market{
            id              : 0x2::object::new(arg2),
            creator         : 0x2::tx_context::sender(arg2),
            description     : arg0,
            collateral      : 0x2::balance::zero<0x2::sui::SUI>(),
            outcome_yes     : 0,
            outcome_no      : 0,
            resolved        : false,
            winning_outcome : 0x1::option::none<u8>(),
            deadline        : arg1,
        }
    }

    public fun redeem(arg0: &mut Market, arg1: u64, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(arg0.resolved, 3);
        assert!(*0x1::option::borrow<u8>(&arg0.winning_outcome) == arg2, 4);
        let v0 = if (arg2 == 0) {
            arg0.outcome_no
        } else {
            arg0.outcome_yes
        };
        0x2::coin::take<0x2::sui::SUI>(&mut arg0.collateral, arg1 * 0x2::balance::value<0x2::sui::SUI>(&arg0.collateral) / v0, arg3)
    }

    public fun resolve_market(arg0: &mut Market, arg1: u8, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 1);
        assert!(arg0.resolved == false, 2);
        arg0.resolved = true;
        arg0.winning_outcome = 0x1::option::some<u8>(arg1);
    }

    // decompiled from Move bytecode v6
}

