module 0x737324ddac9fb96e3d7ffab524f5489c1a0b3e5b4bffa2f244303005001b4ada::betting {
    struct BETTING has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct OracleCap has store, key {
        id: 0x2::object::UID,
    }

    struct BettingPlatform has key {
        id: 0x2::object::UID,
        treasury_sui: 0x2::balance::Balance<0x2::sui::SUI>,
        total_volume_sui: u64,
        total_potential_liability_sui: u64,
        accrued_fees_sui: u64,
        treasury_sbets: 0x2::balance::Balance<0x6a4d9c0eab7ac40371a7453d1aa6c89b130950e8af6868ba975fdd81371a7285::sbets::SBETS>,
        total_volume_sbets: u64,
        total_potential_liability_sbets: u64,
        accrued_fees_sbets: u64,
        platform_fee_bps: u64,
        total_bets: u64,
        paused: bool,
        min_bet_sui: u64,
        max_bet_sui: u64,
        min_bet_sbets: u64,
        max_bet_sbets: u64,
    }

    struct Bet has store, key {
        id: 0x2::object::UID,
        bettor: address,
        event_id: vector<u8>,
        market_id: vector<u8>,
        prediction: vector<u8>,
        odds: u64,
        stake: u64,
        potential_payout: u64,
        platform_fee: u64,
        status: u8,
        placed_at: u64,
        settled_at: u64,
        walrus_blob_id: vector<u8>,
        coin_type: u8,
    }

    struct BetPlaced has copy, drop {
        bet_id: 0x2::object::ID,
        bettor: address,
        event_id: vector<u8>,
        prediction: vector<u8>,
        odds: u64,
        stake: u64,
        potential_payout: u64,
        coin_type: u8,
        timestamp: u64,
    }

    struct BetSettled has copy, drop {
        bet_id: 0x2::object::ID,
        bettor: address,
        status: u8,
        payout: u64,
        coin_type: u8,
        timestamp: u64,
    }

    struct PlatformCreated has copy, drop {
        platform_id: 0x2::object::ID,
        admin_cap_id: 0x2::object::ID,
        fee_bps: u64,
    }

    struct PlatformPaused has copy, drop {
        platform_id: 0x2::object::ID,
        paused: bool,
        timestamp: u64,
    }

    struct OracleCapMinted has copy, drop {
        oracle_cap_id: 0x2::object::ID,
        recipient: address,
        timestamp: u64,
    }

    struct OracleCapRevoked has copy, drop {
        oracle_cap_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct LiquidityDeposited has copy, drop {
        platform_id: 0x2::object::ID,
        depositor: address,
        amount: u64,
        coin_type: u8,
        timestamp: u64,
    }

    struct FeesWithdrawn has copy, drop {
        platform_id: 0x2::object::ID,
        amount: u64,
        coin_type: u8,
        timestamp: u64,
    }

    struct TreasuryWithdrawn has copy, drop {
        platform_id: 0x2::object::ID,
        amount: u64,
        coin_type: u8,
        timestamp: u64,
    }

    public entry fun deposit_liquidity(arg0: &AdminCap, arg1: &mut BettingPlatform, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.treasury_sui, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        let v0 = LiquidityDeposited{
            platform_id : 0x2::object::id<BettingPlatform>(arg1),
            depositor   : 0x2::tx_context::sender(arg4),
            amount      : 0x2::coin::value<0x2::sui::SUI>(&arg2),
            coin_type   : 0,
            timestamp   : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<LiquidityDeposited>(v0);
    }

    public entry fun deposit_liquidity_sbets(arg0: &AdminCap, arg1: &mut BettingPlatform, arg2: 0x2::coin::Coin<0x6a4d9c0eab7ac40371a7453d1aa6c89b130950e8af6868ba975fdd81371a7285::sbets::SBETS>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x6a4d9c0eab7ac40371a7453d1aa6c89b130950e8af6868ba975fdd81371a7285::sbets::SBETS>(&mut arg1.treasury_sbets, 0x2::coin::into_balance<0x6a4d9c0eab7ac40371a7453d1aa6c89b130950e8af6868ba975fdd81371a7285::sbets::SBETS>(arg2));
        let v0 = LiquidityDeposited{
            platform_id : 0x2::object::id<BettingPlatform>(arg1),
            depositor   : 0x2::tx_context::sender(arg4),
            amount      : 0x2::coin::value<0x6a4d9c0eab7ac40371a7453d1aa6c89b130950e8af6868ba975fdd81371a7285::sbets::SBETS>(&arg2),
            coin_type   : 1,
            timestamp   : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<LiquidityDeposited>(v0);
    }

    public fun get_accrued_fees(arg0: &BettingPlatform) : (u64, u64) {
        (arg0.accrued_fees_sui, arg0.accrued_fees_sbets)
    }

    public fun get_bet_event_id(arg0: &Bet) : vector<u8> {
        arg0.event_id
    }

    public fun get_bet_info(arg0: &Bet) : (address, u64, u64, u64, u8, u8) {
        (arg0.bettor, arg0.stake, arg0.odds, arg0.potential_payout, arg0.status, arg0.coin_type)
    }

    public fun get_bet_limits_sbets(arg0: &BettingPlatform) : (u64, u64) {
        (arg0.min_bet_sbets, arg0.max_bet_sbets)
    }

    public fun get_bet_limits_sui(arg0: &BettingPlatform) : (u64, u64) {
        (arg0.min_bet_sui, arg0.max_bet_sui)
    }

    public fun get_bet_market_id(arg0: &Bet) : vector<u8> {
        arg0.market_id
    }

    public fun get_bet_prediction(arg0: &Bet) : vector<u8> {
        arg0.prediction
    }

    public fun get_platform_stats(arg0: &BettingPlatform) : (u64, u64, u64, u64, u64, u64, u64, u64, bool) {
        (0x2::balance::value<0x2::sui::SUI>(&arg0.treasury_sui), 0x2::balance::value<0x6a4d9c0eab7ac40371a7453d1aa6c89b130950e8af6868ba975fdd81371a7285::sbets::SBETS>(&arg0.treasury_sbets), arg0.total_bets, arg0.total_volume_sui, arg0.total_volume_sbets, arg0.total_potential_liability_sui, arg0.total_potential_liability_sbets, arg0.platform_fee_bps, arg0.paused)
    }

    fun init(arg0: BETTING, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::types::is_one_time_witness<BETTING>(&arg0), 10);
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        let v1 = BettingPlatform{
            id                              : 0x2::object::new(arg1),
            treasury_sui                    : 0x2::balance::zero<0x2::sui::SUI>(),
            total_volume_sui                : 0,
            total_potential_liability_sui   : 0,
            accrued_fees_sui                : 0,
            treasury_sbets                  : 0x2::balance::zero<0x6a4d9c0eab7ac40371a7453d1aa6c89b130950e8af6868ba975fdd81371a7285::sbets::SBETS>(),
            total_volume_sbets              : 0,
            total_potential_liability_sbets : 0,
            accrued_fees_sbets              : 0,
            platform_fee_bps                : 100,
            total_bets                      : 0,
            paused                          : false,
            min_bet_sui                     : 50000000,
            max_bet_sui                     : 400000000000,
            min_bet_sbets                   : 1000000000000,
            max_bet_sbets                   : 50000000000000000,
        };
        let v2 = PlatformCreated{
            platform_id  : 0x2::object::id<BettingPlatform>(&v1),
            admin_cap_id : 0x2::object::id<AdminCap>(&v0),
            fee_bps      : 100,
        };
        0x2::event::emit<PlatformCreated>(v2);
        0x2::transfer::share_object<BettingPlatform>(v1);
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_oracle_cap(arg0: &AdminCap, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = OracleCap{id: 0x2::object::new(arg3)};
        let v1 = OracleCapMinted{
            oracle_cap_id : 0x2::object::id<OracleCap>(&v0),
            recipient     : arg1,
            timestamp     : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<OracleCapMinted>(v1);
        0x2::transfer::transfer<OracleCap>(v0, arg1);
    }

    public entry fun place_bet(arg0: &mut BettingPlatform, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 7);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 > 0, 6);
        assert!(v0 >= arg0.min_bet_sui, 9);
        assert!(v0 <= arg0.max_bet_sui, 8);
        assert!(arg5 >= 100, 3);
        let v1 = v0 * arg5 / 100;
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.treasury_sui) + v0 >= arg0.total_potential_liability_sui + v1, 0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.treasury_sui, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        arg0.total_bets = arg0.total_bets + 1;
        arg0.total_volume_sui = arg0.total_volume_sui + v0;
        arg0.total_potential_liability_sui = arg0.total_potential_liability_sui + v1;
        let v2 = 0x2::tx_context::sender(arg8);
        let v3 = 0x2::clock::timestamp_ms(arg7);
        let v4 = Bet{
            id               : 0x2::object::new(arg8),
            bettor           : v2,
            event_id         : arg2,
            market_id        : arg3,
            prediction       : arg4,
            odds             : arg5,
            stake            : v0,
            potential_payout : v1,
            platform_fee     : 0,
            status           : 0,
            placed_at        : v3,
            settled_at       : 0,
            walrus_blob_id   : arg6,
            coin_type        : 0,
        };
        let v5 = BetPlaced{
            bet_id           : 0x2::object::id<Bet>(&v4),
            bettor           : v2,
            event_id         : v4.event_id,
            prediction       : v4.prediction,
            odds             : arg5,
            stake            : v0,
            potential_payout : v1,
            coin_type        : 0,
            timestamp        : v3,
        };
        0x2::event::emit<BetPlaced>(v5);
        0x2::transfer::share_object<Bet>(v4);
    }

    public entry fun place_bet_sbets(arg0: &mut BettingPlatform, arg1: 0x2::coin::Coin<0x6a4d9c0eab7ac40371a7453d1aa6c89b130950e8af6868ba975fdd81371a7285::sbets::SBETS>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 7);
        let v0 = 0x2::coin::value<0x6a4d9c0eab7ac40371a7453d1aa6c89b130950e8af6868ba975fdd81371a7285::sbets::SBETS>(&arg1);
        assert!(v0 > 0, 6);
        assert!(v0 >= arg0.min_bet_sbets, 9);
        assert!(v0 <= arg0.max_bet_sbets, 8);
        assert!(arg5 >= 100, 3);
        let v1 = v0 * arg5 / 100;
        assert!(0x2::balance::value<0x6a4d9c0eab7ac40371a7453d1aa6c89b130950e8af6868ba975fdd81371a7285::sbets::SBETS>(&arg0.treasury_sbets) + v0 >= arg0.total_potential_liability_sbets + v1, 0);
        0x2::balance::join<0x6a4d9c0eab7ac40371a7453d1aa6c89b130950e8af6868ba975fdd81371a7285::sbets::SBETS>(&mut arg0.treasury_sbets, 0x2::coin::into_balance<0x6a4d9c0eab7ac40371a7453d1aa6c89b130950e8af6868ba975fdd81371a7285::sbets::SBETS>(arg1));
        arg0.total_bets = arg0.total_bets + 1;
        arg0.total_volume_sbets = arg0.total_volume_sbets + v0;
        arg0.total_potential_liability_sbets = arg0.total_potential_liability_sbets + v1;
        let v2 = 0x2::tx_context::sender(arg8);
        let v3 = 0x2::clock::timestamp_ms(arg7);
        let v4 = Bet{
            id               : 0x2::object::new(arg8),
            bettor           : v2,
            event_id         : arg2,
            market_id        : arg3,
            prediction       : arg4,
            odds             : arg5,
            stake            : v0,
            potential_payout : v1,
            platform_fee     : 0,
            status           : 0,
            placed_at        : v3,
            settled_at       : 0,
            walrus_blob_id   : arg6,
            coin_type        : 1,
        };
        let v5 = BetPlaced{
            bet_id           : 0x2::object::id<Bet>(&v4),
            bettor           : v2,
            event_id         : v4.event_id,
            prediction       : v4.prediction,
            odds             : arg5,
            stake            : v0,
            potential_payout : v1,
            coin_type        : 1,
            timestamp        : v3,
        };
        0x2::event::emit<BetPlaced>(v5);
        0x2::transfer::share_object<Bet>(v4);
    }

    public entry fun revoke_oracle_cap(arg0: &AdminCap, arg1: OracleCap, arg2: &0x2::clock::Clock) {
        let OracleCap { id: v0 } = arg1;
        0x2::object::delete(v0);
        let v1 = OracleCapRevoked{
            oracle_cap_id : 0x2::object::id<OracleCap>(&arg1),
            timestamp     : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<OracleCapRevoked>(v1);
    }

    public entry fun settle_bet(arg0: &OracleCap, arg1: &mut BettingPlatform, arg2: &mut Bet, arg3: bool, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.status == 0, 1);
        assert!(arg2.coin_type == 0, 6);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        arg2.settled_at = v0;
        arg1.total_potential_liability_sui = arg1.total_potential_liability_sui - arg2.potential_payout;
        if (arg3) {
            arg2.status = 1;
            let v1 = (arg2.potential_payout - arg2.stake) * arg1.platform_fee_bps / 10000;
            let v2 = arg2.potential_payout - v1;
            arg1.accrued_fees_sui = arg1.accrued_fees_sui + v1;
            arg2.platform_fee = v1;
            assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.treasury_sui) >= v2, 11);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.treasury_sui, v2), arg5), arg2.bettor);
            let v3 = BetSettled{
                bet_id    : 0x2::object::id<Bet>(arg2),
                bettor    : arg2.bettor,
                status    : 1,
                payout    : v2,
                coin_type : 0,
                timestamp : v0,
            };
            0x2::event::emit<BetSettled>(v3);
        } else {
            arg2.status = 2;
            arg1.accrued_fees_sui = arg1.accrued_fees_sui + arg2.stake;
            let v4 = BetSettled{
                bet_id    : 0x2::object::id<Bet>(arg2),
                bettor    : arg2.bettor,
                status    : 2,
                payout    : 0,
                coin_type : 0,
                timestamp : v0,
            };
            0x2::event::emit<BetSettled>(v4);
        };
    }

    public entry fun settle_bet_admin(arg0: &AdminCap, arg1: &mut BettingPlatform, arg2: &mut Bet, arg3: bool, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.status == 0, 1);
        assert!(arg2.coin_type == 0, 6);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        arg2.settled_at = v0;
        arg1.total_potential_liability_sui = arg1.total_potential_liability_sui - arg2.potential_payout;
        if (arg3) {
            arg2.status = 1;
            let v1 = (arg2.potential_payout - arg2.stake) * arg1.platform_fee_bps / 10000;
            let v2 = arg2.potential_payout - v1;
            arg1.accrued_fees_sui = arg1.accrued_fees_sui + v1;
            arg2.platform_fee = v1;
            assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.treasury_sui) >= v2, 11);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.treasury_sui, v2), arg5), arg2.bettor);
            let v3 = BetSettled{
                bet_id    : 0x2::object::id<Bet>(arg2),
                bettor    : arg2.bettor,
                status    : 1,
                payout    : v2,
                coin_type : 0,
                timestamp : v0,
            };
            0x2::event::emit<BetSettled>(v3);
        } else {
            arg2.status = 2;
            arg1.accrued_fees_sui = arg1.accrued_fees_sui + arg2.stake;
            let v4 = BetSettled{
                bet_id    : 0x2::object::id<Bet>(arg2),
                bettor    : arg2.bettor,
                status    : 2,
                payout    : 0,
                coin_type : 0,
                timestamp : v0,
            };
            0x2::event::emit<BetSettled>(v4);
        };
    }

    public entry fun settle_bet_sbets(arg0: &OracleCap, arg1: &mut BettingPlatform, arg2: &mut Bet, arg3: bool, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.status == 0, 1);
        assert!(arg2.coin_type == 1, 6);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        arg2.settled_at = v0;
        arg1.total_potential_liability_sbets = arg1.total_potential_liability_sbets - arg2.potential_payout;
        if (arg3) {
            arg2.status = 1;
            let v1 = (arg2.potential_payout - arg2.stake) * arg1.platform_fee_bps / 10000;
            let v2 = arg2.potential_payout - v1;
            arg1.accrued_fees_sbets = arg1.accrued_fees_sbets + v1;
            arg2.platform_fee = v1;
            assert!(0x2::balance::value<0x6a4d9c0eab7ac40371a7453d1aa6c89b130950e8af6868ba975fdd81371a7285::sbets::SBETS>(&arg1.treasury_sbets) >= v2, 11);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x6a4d9c0eab7ac40371a7453d1aa6c89b130950e8af6868ba975fdd81371a7285::sbets::SBETS>>(0x2::coin::from_balance<0x6a4d9c0eab7ac40371a7453d1aa6c89b130950e8af6868ba975fdd81371a7285::sbets::SBETS>(0x2::balance::split<0x6a4d9c0eab7ac40371a7453d1aa6c89b130950e8af6868ba975fdd81371a7285::sbets::SBETS>(&mut arg1.treasury_sbets, v2), arg5), arg2.bettor);
            let v3 = BetSettled{
                bet_id    : 0x2::object::id<Bet>(arg2),
                bettor    : arg2.bettor,
                status    : 1,
                payout    : v2,
                coin_type : 1,
                timestamp : v0,
            };
            0x2::event::emit<BetSettled>(v3);
        } else {
            arg2.status = 2;
            arg1.accrued_fees_sbets = arg1.accrued_fees_sbets + arg2.stake;
            let v4 = BetSettled{
                bet_id    : 0x2::object::id<Bet>(arg2),
                bettor    : arg2.bettor,
                status    : 2,
                payout    : 0,
                coin_type : 1,
                timestamp : v0,
            };
            0x2::event::emit<BetSettled>(v4);
        };
    }

    public entry fun settle_bet_sbets_admin(arg0: &AdminCap, arg1: &mut BettingPlatform, arg2: &mut Bet, arg3: bool, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.status == 0, 1);
        assert!(arg2.coin_type == 1, 6);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        arg2.settled_at = v0;
        arg1.total_potential_liability_sbets = arg1.total_potential_liability_sbets - arg2.potential_payout;
        if (arg3) {
            arg2.status = 1;
            let v1 = (arg2.potential_payout - arg2.stake) * arg1.platform_fee_bps / 10000;
            let v2 = arg2.potential_payout - v1;
            arg1.accrued_fees_sbets = arg1.accrued_fees_sbets + v1;
            arg2.platform_fee = v1;
            assert!(0x2::balance::value<0x6a4d9c0eab7ac40371a7453d1aa6c89b130950e8af6868ba975fdd81371a7285::sbets::SBETS>(&arg1.treasury_sbets) >= v2, 11);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x6a4d9c0eab7ac40371a7453d1aa6c89b130950e8af6868ba975fdd81371a7285::sbets::SBETS>>(0x2::coin::from_balance<0x6a4d9c0eab7ac40371a7453d1aa6c89b130950e8af6868ba975fdd81371a7285::sbets::SBETS>(0x2::balance::split<0x6a4d9c0eab7ac40371a7453d1aa6c89b130950e8af6868ba975fdd81371a7285::sbets::SBETS>(&mut arg1.treasury_sbets, v2), arg5), arg2.bettor);
            let v3 = BetSettled{
                bet_id    : 0x2::object::id<Bet>(arg2),
                bettor    : arg2.bettor,
                status    : 1,
                payout    : v2,
                coin_type : 1,
                timestamp : v0,
            };
            0x2::event::emit<BetSettled>(v3);
        } else {
            arg2.status = 2;
            arg1.accrued_fees_sbets = arg1.accrued_fees_sbets + arg2.stake;
            let v4 = BetSettled{
                bet_id    : 0x2::object::id<Bet>(arg2),
                bettor    : arg2.bettor,
                status    : 2,
                payout    : 0,
                coin_type : 1,
                timestamp : v0,
            };
            0x2::event::emit<BetSettled>(v4);
        };
    }

    public entry fun toggle_pause(arg0: &AdminCap, arg1: &mut BettingPlatform, arg2: &0x2::clock::Clock) {
        arg1.paused = !arg1.paused;
        let v0 = PlatformPaused{
            platform_id : 0x2::object::id<BettingPlatform>(arg1),
            paused      : arg1.paused,
            timestamp   : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<PlatformPaused>(v0);
    }

    public entry fun update_fee(arg0: &AdminCap, arg1: &mut BettingPlatform, arg2: u64) {
        assert!(arg2 <= 1000, 2);
        arg1.platform_fee_bps = arg2;
    }

    public entry fun update_limits_sbets(arg0: &AdminCap, arg1: &mut BettingPlatform, arg2: u64, arg3: u64) {
        arg1.min_bet_sbets = arg2;
        arg1.max_bet_sbets = arg3;
    }

    public entry fun update_limits_sui(arg0: &AdminCap, arg1: &mut BettingPlatform, arg2: u64, arg3: u64) {
        arg1.min_bet_sui = arg2;
        arg1.max_bet_sui = arg3;
    }

    public entry fun void_bet(arg0: &OracleCap, arg1: &mut BettingPlatform, arg2: &mut Bet, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.status == 0, 1);
        assert!(arg2.coin_type == 0, 6);
        arg2.status = 3;
        arg2.settled_at = 0x2::clock::timestamp_ms(arg3);
        arg1.total_potential_liability_sui = arg1.total_potential_liability_sui - arg2.potential_payout;
        let v0 = arg2.stake;
        if (0x2::balance::value<0x2::sui::SUI>(&arg1.treasury_sui) >= v0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.treasury_sui, v0), arg4), arg2.bettor);
        };
        let v1 = BetSettled{
            bet_id    : 0x2::object::id<Bet>(arg2),
            bettor    : arg2.bettor,
            status    : 3,
            payout    : v0,
            coin_type : 0,
            timestamp : arg2.settled_at,
        };
        0x2::event::emit<BetSettled>(v1);
    }

    public entry fun void_bet_admin(arg0: &AdminCap, arg1: &mut BettingPlatform, arg2: &mut Bet, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.status == 0, 1);
        assert!(arg2.coin_type == 0, 6);
        arg2.status = 3;
        arg2.settled_at = 0x2::clock::timestamp_ms(arg3);
        arg1.total_potential_liability_sui = arg1.total_potential_liability_sui - arg2.potential_payout;
        let v0 = arg2.stake;
        if (0x2::balance::value<0x2::sui::SUI>(&arg1.treasury_sui) >= v0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.treasury_sui, v0), arg4), arg2.bettor);
        };
        let v1 = BetSettled{
            bet_id    : 0x2::object::id<Bet>(arg2),
            bettor    : arg2.bettor,
            status    : 3,
            payout    : v0,
            coin_type : 0,
            timestamp : arg2.settled_at,
        };
        0x2::event::emit<BetSettled>(v1);
    }

    public entry fun void_bet_sbets(arg0: &OracleCap, arg1: &mut BettingPlatform, arg2: &mut Bet, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.status == 0, 1);
        assert!(arg2.coin_type == 1, 6);
        arg2.status = 3;
        arg2.settled_at = 0x2::clock::timestamp_ms(arg3);
        arg1.total_potential_liability_sbets = arg1.total_potential_liability_sbets - arg2.potential_payout;
        let v0 = arg2.stake;
        if (0x2::balance::value<0x6a4d9c0eab7ac40371a7453d1aa6c89b130950e8af6868ba975fdd81371a7285::sbets::SBETS>(&arg1.treasury_sbets) >= v0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x6a4d9c0eab7ac40371a7453d1aa6c89b130950e8af6868ba975fdd81371a7285::sbets::SBETS>>(0x2::coin::from_balance<0x6a4d9c0eab7ac40371a7453d1aa6c89b130950e8af6868ba975fdd81371a7285::sbets::SBETS>(0x2::balance::split<0x6a4d9c0eab7ac40371a7453d1aa6c89b130950e8af6868ba975fdd81371a7285::sbets::SBETS>(&mut arg1.treasury_sbets, v0), arg4), arg2.bettor);
        };
        let v1 = BetSettled{
            bet_id    : 0x2::object::id<Bet>(arg2),
            bettor    : arg2.bettor,
            status    : 3,
            payout    : v0,
            coin_type : 1,
            timestamp : arg2.settled_at,
        };
        0x2::event::emit<BetSettled>(v1);
    }

    public entry fun void_bet_sbets_admin(arg0: &AdminCap, arg1: &mut BettingPlatform, arg2: &mut Bet, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.status == 0, 1);
        assert!(arg2.coin_type == 1, 6);
        arg2.status = 3;
        arg2.settled_at = 0x2::clock::timestamp_ms(arg3);
        arg1.total_potential_liability_sbets = arg1.total_potential_liability_sbets - arg2.potential_payout;
        let v0 = arg2.stake;
        if (0x2::balance::value<0x6a4d9c0eab7ac40371a7453d1aa6c89b130950e8af6868ba975fdd81371a7285::sbets::SBETS>(&arg1.treasury_sbets) >= v0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x6a4d9c0eab7ac40371a7453d1aa6c89b130950e8af6868ba975fdd81371a7285::sbets::SBETS>>(0x2::coin::from_balance<0x6a4d9c0eab7ac40371a7453d1aa6c89b130950e8af6868ba975fdd81371a7285::sbets::SBETS>(0x2::balance::split<0x6a4d9c0eab7ac40371a7453d1aa6c89b130950e8af6868ba975fdd81371a7285::sbets::SBETS>(&mut arg1.treasury_sbets, v0), arg4), arg2.bettor);
        };
        let v1 = BetSettled{
            bet_id    : 0x2::object::id<Bet>(arg2),
            bettor    : arg2.bettor,
            status    : 3,
            payout    : v0,
            coin_type : 1,
            timestamp : arg2.settled_at,
        };
        0x2::event::emit<BetSettled>(v1);
    }

    public entry fun withdraw_fees(arg0: &AdminCap, arg1: &mut BettingPlatform, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= arg1.accrued_fees_sui, 0);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.treasury_sui) >= arg2, 11);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.treasury_sui, arg2), arg4), 0x2::tx_context::sender(arg4));
        arg1.accrued_fees_sui = arg1.accrued_fees_sui - arg2;
        let v0 = FeesWithdrawn{
            platform_id : 0x2::object::id<BettingPlatform>(arg1),
            amount      : arg2,
            coin_type   : 0,
            timestamp   : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<FeesWithdrawn>(v0);
    }

    public entry fun withdraw_fees_sbets(arg0: &AdminCap, arg1: &mut BettingPlatform, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= arg1.accrued_fees_sbets, 0);
        assert!(0x2::balance::value<0x6a4d9c0eab7ac40371a7453d1aa6c89b130950e8af6868ba975fdd81371a7285::sbets::SBETS>(&arg1.treasury_sbets) >= arg2, 11);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x6a4d9c0eab7ac40371a7453d1aa6c89b130950e8af6868ba975fdd81371a7285::sbets::SBETS>>(0x2::coin::from_balance<0x6a4d9c0eab7ac40371a7453d1aa6c89b130950e8af6868ba975fdd81371a7285::sbets::SBETS>(0x2::balance::split<0x6a4d9c0eab7ac40371a7453d1aa6c89b130950e8af6868ba975fdd81371a7285::sbets::SBETS>(&mut arg1.treasury_sbets, arg2), arg4), 0x2::tx_context::sender(arg4));
        arg1.accrued_fees_sbets = arg1.accrued_fees_sbets - arg2;
        let v0 = FeesWithdrawn{
            platform_id : 0x2::object::id<BettingPlatform>(arg1),
            amount      : arg2,
            coin_type   : 1,
            timestamp   : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<FeesWithdrawn>(v0);
    }

    public entry fun withdraw_treasury(arg0: &AdminCap, arg1: &mut BettingPlatform, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.treasury_sui) >= arg2, 11);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.treasury_sui, arg2), arg4), 0x2::tx_context::sender(arg4));
        let v0 = TreasuryWithdrawn{
            platform_id : 0x2::object::id<BettingPlatform>(arg1),
            amount      : arg2,
            coin_type   : 0,
            timestamp   : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<TreasuryWithdrawn>(v0);
    }

    public entry fun withdraw_treasury_sbets(arg0: &AdminCap, arg1: &mut BettingPlatform, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x6a4d9c0eab7ac40371a7453d1aa6c89b130950e8af6868ba975fdd81371a7285::sbets::SBETS>(&arg1.treasury_sbets) >= arg2, 11);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x6a4d9c0eab7ac40371a7453d1aa6c89b130950e8af6868ba975fdd81371a7285::sbets::SBETS>>(0x2::coin::from_balance<0x6a4d9c0eab7ac40371a7453d1aa6c89b130950e8af6868ba975fdd81371a7285::sbets::SBETS>(0x2::balance::split<0x6a4d9c0eab7ac40371a7453d1aa6c89b130950e8af6868ba975fdd81371a7285::sbets::SBETS>(&mut arg1.treasury_sbets, arg2), arg4), 0x2::tx_context::sender(arg4));
        let v0 = TreasuryWithdrawn{
            platform_id : 0x2::object::id<BettingPlatform>(arg1),
            amount      : arg2,
            coin_type   : 1,
            timestamp   : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<TreasuryWithdrawn>(v0);
    }

    // decompiled from Move bytecode v6
}

