module 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::predict_manager {
    struct PositionData has copy, drop, store {
        free: u64,
        locked: u64,
    }

    struct CollateralKey has copy, drop, store {
        locked_key: 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::MarketKey,
        minted_key: 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::MarketKey,
    }

    struct PredictManager has key {
        id: 0x2::object::UID,
        owner: address,
        balance_manager: 0x7294d012d99753954acb64f5d939485402938d7d343e500f10cc5400e39ee36c::balance_manager::BalanceManager,
        deposit_cap: 0x7294d012d99753954acb64f5d939485402938d7d343e500f10cc5400e39ee36c::balance_manager::DepositCap,
        withdraw_cap: 0x7294d012d99753954acb64f5d939485402938d7d343e500f10cc5400e39ee36c::balance_manager::WithdrawCap,
        trade_cap: 0x7294d012d99753954acb64f5d939485402938d7d343e500f10cc5400e39ee36c::balance_manager::TradeCap,
        positions: 0x2::table::Table<0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::MarketKey, PositionData>,
        collateral: 0x2::table::Table<CollateralKey, u64>,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = new_predict_manager(arg0);
        0x2::transfer::share_object<PredictManager>(v0);
        id(&v0)
    }

    public fun balance<T0>(arg0: &PredictManager) : u64 {
        0x7294d012d99753954acb64f5d939485402938d7d343e500f10cc5400e39ee36c::balance_manager::balance<T0>(&arg0.balance_manager)
    }

    fun add_collateral_entry(arg0: &mut PredictManager, arg1: CollateralKey) {
        if (!0x2::table::contains<CollateralKey, u64>(&arg0.collateral, arg1)) {
            0x2::table::add<CollateralKey, u64>(&mut arg0.collateral, arg1, 0);
        };
    }

    fun add_position_entry(arg0: &mut PredictManager, arg1: 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::MarketKey) {
        if (!0x2::table::contains<0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::MarketKey, PositionData>(&arg0.positions, arg1)) {
            let v0 = PositionData{
                free   : 0,
                locked : 0,
            };
            0x2::table::add<0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::MarketKey, PositionData>(&mut arg0.positions, arg1, v0);
        };
    }

    public(friend) fun decrease_position(arg0: &mut PredictManager, arg1: 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::MarketKey, arg2: u64) {
        assert!(0x2::table::contains<0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::MarketKey, PositionData>(&arg0.positions, arg1), 1);
        let v0 = 0x2::table::borrow_mut<0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::MarketKey, PositionData>(&mut arg0.positions, arg1);
        assert!(v0.free >= arg2, 2);
        v0.free = v0.free - arg2;
    }

    public fun deposit<T0>(arg0: &mut PredictManager, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 0);
        0x7294d012d99753954acb64f5d939485402938d7d343e500f10cc5400e39ee36c::balance_manager::deposit_with_cap<T0>(&mut arg0.balance_manager, &arg0.deposit_cap, arg1, arg2);
    }

    public fun id(arg0: &PredictManager) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public(friend) fun increase_position(arg0: &mut PredictManager, arg1: 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::MarketKey, arg2: u64) {
        add_position_entry(arg0, arg1);
        let v0 = 0x2::table::borrow_mut<0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::MarketKey, PositionData>(&mut arg0.positions, arg1);
        v0.free = v0.free + arg2;
    }

    public(friend) fun lock_collateral(arg0: &mut PredictManager, arg1: 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::MarketKey, arg2: 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::MarketKey, arg3: u64) {
        assert!(0x2::table::contains<0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::MarketKey, PositionData>(&arg0.positions, arg1), 1);
        let v0 = 0x2::table::borrow_mut<0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::MarketKey, PositionData>(&mut arg0.positions, arg1);
        assert!(v0.free >= arg3, 2);
        v0.free = v0.free - arg3;
        v0.locked = v0.locked + arg3;
        let v1 = CollateralKey{
            locked_key : arg1,
            minted_key : arg2,
        };
        add_collateral_entry(arg0, v1);
        let v2 = 0x2::table::borrow_mut<CollateralKey, u64>(&mut arg0.collateral, v1);
        *v2 = *v2 + arg3;
    }

    fun new_predict_manager(arg0: &mut 0x2::tx_context::TxContext) : PredictManager {
        let v0 = 0x7294d012d99753954acb64f5d939485402938d7d343e500f10cc5400e39ee36c::balance_manager::new(arg0);
        PredictManager{
            id              : 0x2::object::new(arg0),
            owner           : 0x2::tx_context::sender(arg0),
            balance_manager : v0,
            deposit_cap     : 0x7294d012d99753954acb64f5d939485402938d7d343e500f10cc5400e39ee36c::balance_manager::mint_deposit_cap(&mut v0, arg0),
            withdraw_cap    : 0x7294d012d99753954acb64f5d939485402938d7d343e500f10cc5400e39ee36c::balance_manager::mint_withdraw_cap(&mut v0, arg0),
            trade_cap       : 0x7294d012d99753954acb64f5d939485402938d7d343e500f10cc5400e39ee36c::balance_manager::mint_trade_cap(&mut v0, arg0),
            positions       : 0x2::table::new<0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::MarketKey, PositionData>(arg0),
            collateral      : 0x2::table::new<CollateralKey, u64>(arg0),
        }
    }

    public fun owner(arg0: &PredictManager) : address {
        arg0.owner
    }

    public fun position(arg0: &PredictManager, arg1: 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::MarketKey) : (u64, u64) {
        if (0x2::table::contains<0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::MarketKey, PositionData>(&arg0.positions, arg1)) {
            let v2 = *0x2::table::borrow<0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::MarketKey, PositionData>(&arg0.positions, arg1);
            (v2.free, v2.locked)
        } else {
            (0, 0)
        }
    }

    public(friend) fun release_collateral(arg0: &mut PredictManager, arg1: 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::MarketKey, arg2: 0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::MarketKey, arg3: u64) {
        let v0 = CollateralKey{
            locked_key : arg1,
            minted_key : arg2,
        };
        assert!(0x2::table::contains<CollateralKey, u64>(&arg0.collateral, v0), 3);
        let v1 = 0x2::table::borrow_mut<CollateralKey, u64>(&mut arg0.collateral, v0);
        assert!(*v1 >= arg3, 3);
        *v1 = *v1 - arg3;
        let v2 = 0x2::table::borrow_mut<0xbb1a25d314ecacbaec13a60c73c273336fcaa101f6ee307476cbc64fa359f713::market_key::MarketKey, PositionData>(&mut arg0.positions, arg1);
        v2.locked = v2.locked - arg3;
        v2.free = v2.free + arg3;
    }

    public fun withdraw<T0>(arg0: &mut PredictManager, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 0);
        0x7294d012d99753954acb64f5d939485402938d7d343e500f10cc5400e39ee36c::balance_manager::withdraw_with_cap<T0>(&mut arg0.balance_manager, &arg0.withdraw_cap, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

