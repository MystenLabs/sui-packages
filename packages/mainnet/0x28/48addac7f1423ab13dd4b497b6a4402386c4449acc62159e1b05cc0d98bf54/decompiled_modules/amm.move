module 0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::amm {
    struct CoinParamsKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct CoinParams has copy, drop, store {
        min_seed: u64,
        creation_fee: u64,
        min_trade: u64,
        dispute_bond: u64,
        enabled: bool,
    }

    struct AmmRegistryKey has copy, drop, store {
        dummy_field: bool,
    }

    struct AmmRegistry has store {
        markets: 0x2::table::Table<u64, 0x2::object::ID>,
        count: u64,
    }

    struct SeatQuotaKey has copy, drop, store {
        dummy_field: bool,
    }

    struct Quota has copy, drop, store {
        day: u64,
        count: u64,
    }

    struct AdminUserKey has copy, drop, store {
        pos0: address,
    }

    struct AdminSeatKey has copy, drop, store {
        dummy_field: bool,
    }

    struct CoinBucketKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct FeeRampKey has copy, drop, store {
        dummy_field: bool,
    }

    struct FeeRampDefaults has copy, drop, store {
        max_ppm: u64,
        window_ms: u64,
    }

    struct CoinBucket<phantom T0> has store {
        pool: 0x2::balance::Balance<T0>,
        owed: 0x2::table::Table<0x2::object::ID, u64>,
    }

    struct Schedule has copy, drop, store {
        created_ms: u64,
        close_ms: u64,
        resolve_by_ms: u64,
        void_at_ms: u64,
        dispute_window_ms: u64,
    }

    struct Council has copy, drop, store {
        committee: vector<0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Seat>,
        creator_seat: 0x1::option::Option<0x2::object::ID>,
        threshold: u64,
        votes: vector<u8>,
        outcome: u8,
        resolved_ms: u64,
        dispute_used: bool,
        status: u8,
    }

    struct Pool<phantom T0> has store {
        collateral: 0x2::balance::Balance<T0>,
        sets: u64,
        ry: u64,
        rn: u64,
        lp_total: u64,
        acc_fee_per_share: u128,
        min_trade: u64,
    }

    struct Fees<phantom T0> has store {
        lp_fees: 0x2::balance::Balance<T0>,
        council_fees: 0x2::balance::Balance<T0>,
        treasury_fees: 0x2::balance::Balance<T0>,
        settled: bool,
        ramp: FeeRamp,
    }

    struct FeeRamp has copy, drop, store {
        max_ppm: u64,
        window_ms: u64,
        end_ms: u64,
    }

    struct Appeal<phantom T0> has store {
        bond_required: u64,
        proposed: u8,
        proposed_ms: u64,
        proposer: address,
        disputed_ms: u64,
        disputer: address,
        bond: 0x2::balance::Balance<T0>,
        verdict: u8,
        admin_seat: 0x1::option::Option<0x2::object::ID>,
        withdrawn: bool,
    }

    struct AmmMarket<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        config_id: 0x2::object::ID,
        index: u64,
        question: 0x1::string::String,
        details: 0x1::string::String,
        source: 0x1::string::String,
        treasury: address,
        creator: address,
        reviewed: bool,
        creation_fee: u64,
        schedule: Schedule,
        council: Council,
        pool: Pool<T0>,
        fees: Fees<T0>,
        appeal: Appeal<T0>,
        payout_price: u64,
        positions_open: u64,
        lp_open: u64,
    }

    struct Position<phantom T0> has key {
        id: 0x2::object::UID,
        market_id: 0x2::object::ID,
        owner: address,
        yes: u64,
        no: u64,
        locked_until_ms: u64,
    }

    struct LpPosition<phantom T0> has key {
        id: 0x2::object::UID,
        market_id: 0x2::object::ID,
        owner: address,
        shares: u64,
        fee_debt: u128,
        locked_until_ms: u64,
    }

    struct FeeRampSet has copy, drop {
        max_ppm: u64,
        window_ms: u64,
        by: address,
        ts: u64,
    }

    struct CoinParamsSet has copy, drop {
        coin_type: 0x1::ascii::String,
        min_seed: u64,
        creation_fee: u64,
        min_trade: u64,
        dispute_bond: u64,
        enabled: bool,
        by: address,
        ts: u64,
    }

    struct AdminUserRecorded has copy, drop {
        who: address,
        ts: u64,
    }

    struct AdminSeatSet has copy, drop {
        seat_cap_id: 0x2::object::ID,
        previous: 0x1::option::Option<0x2::object::ID>,
        by: address,
        ts: u64,
    }

    struct AmmMarketCreated has copy, drop {
        market_id: 0x2::object::ID,
        index: u64,
        coin_type: 0x1::ascii::String,
        question: 0x1::string::String,
        close_ms: u64,
        resolve_by_ms: u64,
        void_at_ms: u64,
        committee: vector<address>,
        council_caps: vector<0x2::object::ID>,
        creator_seat: 0x1::option::Option<0x2::object::ID>,
        threshold: u64,
        dispute_window_ms: u64,
        dispute_bond: u64,
        max_fee_ppm: u64,
        ramp_window_ms: u64,
        treasury: address,
        creator: address,
        creation_fee: u64,
        seed: u64,
        p0_bps: u64,
        ry: u64,
        rn: u64,
        lp_id: 0x2::object::ID,
        seed_position_id: 0x1::option::Option<0x2::object::ID>,
        seed_left_yes: u64,
        seed_left_no: u64,
        reviewed: bool,
        by: address,
        ts: u64,
    }

    struct Traded has copy, drop {
        market_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        trader: address,
        kind: u8,
        side: u8,
        gross: u64,
        shares: u64,
        fee_ppm: u64,
        fee: u64,
        lp_fee: u64,
        council_fee: u64,
        treasury_fee: u64,
        net: u64,
        ry: u64,
        rn: u64,
        sets: u64,
        price: u64,
        ts: u64,
    }

    struct LiquidityAdded has copy, drop {
        market_id: 0x2::object::ID,
        lp_id: 0x2::object::ID,
        provider: address,
        amount: u64,
        shares: u64,
        position_id: 0x1::option::Option<0x2::object::ID>,
        leftover_yes: u64,
        leftover_no: u64,
        ry: u64,
        rn: u64,
        lp_total: u64,
        ts: u64,
    }

    struct LiquidityRemoved has copy, drop {
        market_id: 0x2::object::ID,
        lp_id: 0x2::object::ID,
        provider: address,
        shares: u64,
        take_yes: u64,
        take_no: u64,
        merged: u64,
        fees: u64,
        position_id: 0x1::option::Option<0x2::object::ID>,
        ry: u64,
        rn: u64,
        lp_total: u64,
        ts: u64,
    }

    struct PositionsMerged has copy, drop {
        market_id: 0x2::object::ID,
        into_id: 0x2::object::ID,
        from_id: 0x2::object::ID,
        owner: address,
        moved_yes: u64,
        moved_no: u64,
        yes: u64,
        no: u64,
        ts: u64,
    }

    struct PositionSplit has copy, drop {
        market_id: 0x2::object::ID,
        from_id: 0x2::object::ID,
        new_id: 0x2::object::ID,
        owner: address,
        moved_yes: u64,
        moved_no: u64,
        yes: u64,
        no: u64,
        ts: u64,
    }

    struct LpMerged has copy, drop {
        market_id: 0x2::object::ID,
        into_id: 0x2::object::ID,
        from_id: 0x2::object::ID,
        owner: address,
        moved_shares: u64,
        shares: u64,
        fees: u64,
        ts: u64,
    }

    struct LpSplit has copy, drop {
        market_id: 0x2::object::ID,
        from_id: 0x2::object::ID,
        new_id: 0x2::object::ID,
        owner: address,
        moved_shares: u64,
        shares: u64,
        fees: u64,
        ts: u64,
    }

    struct TradingClosed has copy, drop {
        market_id: 0x2::object::ID,
        scheduled_close_ms: u64,
        close_ms: u64,
        by: address,
        ts: u64,
    }

    struct AmmReviewed has copy, drop {
        market_id: 0x2::object::ID,
        by: address,
        ts: u64,
    }

    struct AmmProposed has copy, drop {
        market_id: 0x2::object::ID,
        outcome: u8,
        by: address,
        ts: u64,
        challenge_ends_ms: u64,
    }

    struct AmmProposalDisputed has copy, drop {
        market_id: 0x2::object::ID,
        disputer: address,
        proof_id: 0x2::object::ID,
        proof_is_lp: bool,
        proposed: u8,
        bond: u64,
        ts: u64,
        council_deadline_ms: u64,
    }

    struct AmmProposalWithdrawn has copy, drop {
        market_id: 0x2::object::ID,
        proposed: u8,
        proposer: address,
        disputer: address,
        proof_id: 0x2::object::ID,
        proof_is_lp: bool,
        usable: u64,
        threshold: u64,
        ts: u64,
        resolve_by_ms: u64,
        void_at_ms: u64,
    }

    struct AmmVoteCast has copy, drop {
        market_id: 0x2::object::ID,
        member: address,
        cap_id: 0x2::object::ID,
        outcome: u8,
        appeal: bool,
        ts: u64,
    }

    struct AmmResolved has copy, drop {
        market_id: 0x2::object::ID,
        outcome: u8,
        by: address,
        cap_id: 0x2::object::ID,
        resolved_ms: u64,
        finalizes_at_ms: u64,
    }

    struct AmmAppealDecided has copy, drop {
        market_id: 0x2::object::ID,
        outcome: u8,
        proposed: u8,
        overturned: bool,
        by: address,
        cap_id: 0x2::object::ID,
        ts: u64,
    }

    struct AmmAppealLapsed has copy, drop {
        market_id: 0x2::object::ID,
        proposed: u8,
        disputer: address,
        bond: u64,
        by: address,
        ts: u64,
    }

    struct AmmDisputed has copy, drop {
        market_id: 0x2::object::ID,
        member: address,
        cap_id: 0x2::object::ID,
        ts: u64,
        void_at_ms: u64,
    }

    struct AmmFinalized has copy, drop {
        market_id: 0x2::object::ID,
        outcome: u8,
        payout_price: u64,
        by: address,
        ts: u64,
    }

    struct AmmVoided has copy, drop {
        market_id: 0x2::object::ID,
        cause: u8,
        payout_price: u64,
        by: address,
        ts: u64,
    }

    struct AmmRevoked has copy, drop {
        market_id: 0x2::object::ID,
        reason: 0x1::string::String,
        stage: u8,
        payout_price: u64,
        by: address,
        ts: u64,
    }

    struct AmmFeesSettled has copy, drop {
        market_id: 0x2::object::ID,
        council_fees: u64,
        per_seat: u64,
        seats: vector<0x2::object::ID>,
        credited: u64,
        treasury_paid: u64,
        by: address,
        ts: u64,
    }

    struct AmmBondSettled has copy, drop {
        market_id: 0x2::object::ID,
        disputer: address,
        verdict: u8,
        bond: u64,
        reward: u64,
        to_disputer: u64,
        to_treasury: u64,
        ts: u64,
    }

    struct Redeemed has copy, drop {
        market_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        owner: address,
        yes: u64,
        no: u64,
        refund: bool,
        payout_price: u64,
        payout: u64,
        ts: u64,
    }

    struct LpWithdrawn has copy, drop {
        market_id: 0x2::object::ID,
        lp_id: 0x2::object::ID,
        owner: address,
        shares: u64,
        take_yes: u64,
        take_no: u64,
        refund: bool,
        value: u64,
        fees: u64,
        payout_price: u64,
        ts: u64,
    }

    struct DustSwept has copy, drop {
        market_id: 0x2::object::ID,
        collateral: u64,
        lp_fees: u64,
        to: address,
        by: address,
        ts: u64,
    }

    struct AmmMarketDestroyed has copy, drop {
        market_id: 0x2::object::ID,
        by: address,
    }

    struct SeatQuotaPruned has copy, drop {
        cap_id: 0x2::object::ID,
        by: address,
    }

    struct CouncilCoinFeesClaimed has copy, drop {
        cap_id: 0x2::object::ID,
        holder: address,
        coin_type: 0x1::ascii::String,
        amount: u64,
        ts: u64,
    }

    public fun acc_fee_per_share<T0>(arg0: &AmmMarket<T0>) : u128 {
        arg0.pool.acc_fee_per_share
    }

    public fun add_amounts(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : (u64, u64, u64) {
        let v0 = if (arg0 > arg1) {
            arg0
        } else {
            arg1
        };
        (mul_div(arg3, arg2, v0), mul_div(arg3, arg0, v0), mul_div(arg3, arg1, v0))
    }

    public fun add_liquidity<T0>(arg0: &mut AmmMarket<T0>, arg1: &0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Config, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (LpPosition<T0>, 0x1::option::Option<Position<T0>>) {
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = 0x2::tx_context::sender(arg5);
        assert_can_trade<T0>(arg1, arg0, v0, v1);
        assert!(arg3 > 0, 13869406072689655889);
        let v2 = 0x2::coin::value<T0>(&arg2);
        assert!(v2 >= arg0.pool.min_trade, 13868843131325907021);
        let (v3, v4, v5) = add_amounts(arg0.pool.ry, arg0.pool.rn, arg0.pool.lp_total, v2);
        assert!(v3 > 0, 13871657889684258913);
        assert!(v3 >= arg3, 13869687569141334099);
        arg0.pool.ry = arg0.pool.ry + v4;
        arg0.pool.rn = arg0.pool.rn + v5;
        arg0.pool.sets = arg0.pool.sets + v2;
        arg0.pool.lp_total = arg0.pool.lp_total + v3;
        0x2::balance::join<T0>(&mut arg0.pool.collateral, 0x2::coin::into_balance<T0>(arg2));
        assert_solvent<T0>(arg0);
        let v6 = 0x2::object::id<AmmMarket<T0>>(arg0);
        let v7 = LpPosition<T0>{
            id              : 0x2::object::new(arg5),
            market_id       : v6,
            owner           : v1,
            shares          : v3,
            fee_debt        : debt_of(v3, arg0.pool.acc_fee_per_share),
            locked_until_ms : 0,
        };
        arg0.lp_open = arg0.lp_open + 1;
        let v8 = v2 - v4;
        let v9 = v2 - v5;
        let v10 = 0x1::option::none<0x2::object::ID>();
        let v11 = 0x1::option::none<Position<T0>>();
        if (v8 > 0 || v9 > 0) {
            let v12 = Position<T0>{
                id              : 0x2::object::new(arg5),
                market_id       : v6,
                owner           : v1,
                yes             : v8,
                no              : v9,
                locked_until_ms : arg0.schedule.close_ms,
            };
            v10 = 0x1::option::some<0x2::object::ID>(0x2::object::id<Position<T0>>(&v12));
            arg0.positions_open = arg0.positions_open + 1;
            0x1::option::fill<Position<T0>>(&mut v11, v12);
        };
        let v13 = LiquidityAdded{
            market_id    : v6,
            lp_id        : 0x2::object::id<LpPosition<T0>>(&v7),
            provider     : v1,
            amount       : v2,
            shares       : v3,
            position_id  : v10,
            leftover_yes : v8,
            leftover_no  : v9,
            ry           : arg0.pool.ry,
            rn           : arg0.pool.rn,
            lp_total     : arg0.pool.lp_total,
            ts           : v0,
        };
        0x2::event::emit<LiquidityAdded>(v13);
        (v7, v11)
    }

    entry fun add_liquidity_and_keep<T0>(arg0: &mut AmmMarket<T0>, arg1: &0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Config, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = add_liquidity<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
        keep_lp<T0>(v0, arg5);
        keep_option<T0>(v1, arg5);
    }

    fun admin_entry(arg0: &0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::PredictAdminCap, arg1: &mut 0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Config, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert_v2(arg1);
        0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::assert_admin(arg1, arg0);
        record_admin_user(arg1, 0x2::tx_context::sender(arg3), arg2);
    }

    public fun admin_seat(arg0: &0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Config) : 0x1::option::Option<0x2::object::ID> {
        let v0 = 0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::config_uid(arg0);
        let v1 = AdminSeatKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<AdminSeatKey>(v0, v1)) {
            return 0x1::option::none<0x2::object::ID>()
        };
        let v2 = AdminSeatKey{dummy_field: false};
        0x1::option::some<0x2::object::ID>(*0x2::dynamic_field::borrow<AdminSeatKey, 0x2::object::ID>(v0, v2))
    }

    public fun amm_market_at(arg0: &0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Config, arg1: u64) : 0x2::object::ID {
        let v0 = AmmRegistryKey{dummy_field: false};
        *0x2::table::borrow<u64, 0x2::object::ID>(&0x2::dynamic_field::borrow<AmmRegistryKey, AmmRegistry>(0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::config_uid(arg0), v0).markets, arg1)
    }

    public fun amm_market_count(arg0: &0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Config) : u64 {
        let v0 = 0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::config_uid(arg0);
        let v1 = AmmRegistryKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<AmmRegistryKey>(v0, v1)) {
            return 0
        };
        let v2 = AmmRegistryKey{dummy_field: false};
        0x2::dynamic_field::borrow<AmmRegistryKey, AmmRegistry>(v0, v2).count
    }

    public fun amm_version() : u64 {
        2
    }

    public fun appeal_admin_seat<T0>(arg0: &AmmMarket<T0>) : 0x1::option::Option<0x2::object::ID> {
        arg0.appeal.admin_seat
    }

    fun appeal_seat<T0>(arg0: &0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Config, arg1: &AmmMarket<T0>, arg2: &0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Seat) : bool {
        let v0 = 0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::seat_cap_id(arg2);
        if (!0x1::option::contains<0x2::object::ID>(&arg1.council.creator_seat, &v0)) {
            if (!0x1::option::contains<0x2::object::ID>(&arg1.appeal.admin_seat, &v0)) {
                let v2 = 0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::is_revoked(arg0, v0) && 0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::seat_holder(arg2) == arg1.appeal.proposer;
                !v2
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun appeal_seat_counts<T0>(arg0: &AmmMarket<T0>, arg1: &0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Config, arg2: &0x2::clock::Clock) : (u64, u64, u64, u64) {
        if (arg0.council.status == 7 || is_terminal<T0>(arg0) && arg0.appeal.disputed_ms > 0) {
            seat_counts_at<T0>(arg1, arg0, arg0.appeal.disputed_ms + 259200000, true)
        } else {
            seat_counts_at<T0>(arg1, arg0, 0x2::clock::timestamp_ms(arg2), false)
        }
    }

    public fun appeal_usable_seats<T0>(arg0: &AmmMarket<T0>, arg1: &0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Config) : u64 {
        usable_seats<T0>(arg1, arg0)
    }

    public fun appeal_window_ms() : u64 {
        259200000
    }

    fun assert_can_trade<T0>(arg0: &0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Config, arg1: &AmmMarket<T0>, arg2: u64, arg3: address) {
        assert_v2(arg0);
        check_market<T0>(arg0, arg1);
        assert!(arg1.council.status == 0, 13871944552981594211);
        assert!(arg2 < arg1.schedule.close_ms, 13868285382577619017);
        assert_not_banned<T0>(arg0, arg1, arg3);
    }

    fun assert_k(arg0: u64, arg1: u64, arg2: u64, arg3: u64) {
        assert!((arg2 as u128) * (arg3 as u128) >= (arg0 as u128) * (arg1 as u128), 13870255857739366487);
    }

    fun assert_not_banned<T0>(arg0: &0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Config, arg1: &AmmMarket<T0>, arg2: address) {
        assert!(!0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::seats_hold(&arg1.council.committee, arg2), 13869129760263503951);
        assert!(!0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::is_council_holder(arg0, arg2), 13869129764558471247);
        assert!(arg2 != arg1.treasury && arg2 != 0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::treasury(arg0), 13878981393042768019);
        assert!(!is_admin_user(arg0, arg2), 13878699922360893585);
    }

    fun assert_solvent<T0>(arg0: &AmmMarket<T0>) {
        let v0 = arg0.pool.sets;
        assert!(0x2::balance::value<T0>(&arg0.pool.collateral) == v0, 13877292762225049735);
        assert!(arg0.pool.ry <= v0 && arg0.pool.rn <= v0, 13877292766520017031);
    }

    fun assert_v2(arg0: &0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Config) {
        assert!(0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::version(arg0) == 2, 13863218695555514405);
    }

    public fun base_fee_ppm() : u64 {
        20000
    }

    public fun bond_forfeit() : u8 {
        3
    }

    public fun bond_refund() : u8 {
        1
    }

    public fun bond_required<T0>(arg0: &AmmMarket<T0>) : u64 {
        arg0.appeal.bond_required
    }

    public fun bond_reward() : u8 {
        2
    }

    public fun bond_value<T0>(arg0: &AmmMarket<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.appeal.bond)
    }

    public fun bond_verdict<T0>(arg0: &AmmMarket<T0>) : u8 {
        arg0.appeal.verdict
    }

    public fun buy<T0>(arg0: &mut AmmMarket<T0>, arg1: &0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Config, arg2: 0x2::coin::Coin<T0>, arg3: u8, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : Position<T0> {
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = 0x2::tx_context::sender(arg6);
        assert_can_trade<T0>(arg1, arg0, v0, v1);
        assert!(arg3 == 1 || arg3 == 2, 13868560848895213643);
        assert!(arg4 > 0, 13869405278120706129);
        let v2 = 0x2::coin::value<T0>(&arg2);
        assert!(v2 >= arg0.pool.min_trade, 13868842336756957261);
        let (v3, v4) = side_reserves<T0>(arg0, arg3);
        let v5 = rate_now<T0>(arg0, v0);
        let (v6, v7, v8, v9) = quote_buy(v3, v4, v2, v5);
        assert!(v6 >= arg4, 13869686778867351635);
        assert_k(v3, v4, v7, v8);
        let v10 = v2 - v9;
        set_side_reserves<T0>(arg0, arg3, v7, v8);
        arg0.pool.sets = arg0.pool.sets + v10;
        let v11 = 0x2::coin::into_balance<T0>(arg2);
        0x2::balance::join<T0>(&mut arg0.pool.collateral, v11);
        let (v12, v13, v14) = take_fee<T0>(arg0, 0x2::balance::split<T0>(&mut v11, v9), fee_of(v2));
        assert_solvent<T0>(arg0);
        let v15 = 0x2::object::id<AmmMarket<T0>>(arg0);
        let (v16, v17) = if (arg3 == 1) {
            (v6, 0)
        } else {
            (0, v6)
        };
        let v18 = Position<T0>{
            id              : 0x2::object::new(arg6),
            market_id       : v15,
            owner           : v1,
            yes             : v16,
            no              : v17,
            locked_until_ms : 0,
        };
        arg0.positions_open = arg0.positions_open + 1;
        let v19 = Traded{
            market_id    : v15,
            position_id  : 0x2::object::id<Position<T0>>(&v18),
            trader       : v1,
            kind         : 1,
            side         : arg3,
            gross        : v2,
            shares       : v6,
            fee_ppm      : v5,
            fee          : v9,
            lp_fee       : v12,
            council_fee  : v13,
            treasury_fee : v14,
            net          : v10,
            ry           : arg0.pool.ry,
            rn           : arg0.pool.rn,
            sets         : arg0.pool.sets,
            price        : spot_price(arg0.pool.ry, arg0.pool.rn),
            ts           : v0,
        };
        0x2::event::emit<Traded>(v19);
        v18
    }

    entry fun buy_and_keep<T0>(arg0: &mut AmmMarket<T0>, arg1: &0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Config, arg2: 0x2::coin::Coin<T0>, arg3: u8, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = buy<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        keep<T0>(v0, arg6);
    }

    fun caps_of(arg0: &vector<0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Seat>) : vector<0x2::object::ID> {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Seat>(arg0)) {
            0x1::vector::push_back<0x2::object::ID>(&mut v0, 0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::seat_cap_id(0x1::vector::borrow<0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Seat>(arg0, v1)));
            v1 = v1 + 1;
        };
        v0
    }

    public fun ceil_sqrt_u256(arg0: u256) : u256 {
        let v0 = isqrt_u256(arg0);
        if (v0 * v0 == arg0) {
            v0
        } else {
            v0 + 1
        }
    }

    public fun challenge_window_ms() : u64 {
        21600000
    }

    fun check_lp<T0>(arg0: &AmmMarket<T0>, arg1: &LpPosition<T0>, arg2: address) {
        assert!(arg1.market_id == 0x2::object::id<AmmMarket<T0>>(arg0), 13870537225342025817);
        assert!(arg1.owner == arg2, 13870818704613834843);
    }

    fun check_market<T0>(arg0: &0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Config, arg1: &AmmMarket<T0>) {
        assert!(0x2::object::id<0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Config>(arg0) == arg1.config_id, 13863500226366930983);
        assert!(arg1.version == 2, 13881233154202796195);
    }

    fun check_position<T0>(arg0: &AmmMarket<T0>, arg1: &Position<T0>, arg2: address) {
        assert!(arg1.market_id == 0x2::object::id<AmmMarket<T0>>(arg0), 13870537203867189337);
        assert!(arg1.owner == arg2, 13870818683138998363);
    }

    public fun claim_council_fees_coin<T0>(arg0: &mut 0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::CouncilFees, arg1: &0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::CouncilCap, arg2: &0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Config, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_v2(arg2);
        0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::check_fees(arg2, arg0);
        let v0 = 0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::cap_holder(arg1);
        assert!(0x2::tx_context::sender(arg4) == v0, 13865186421938192435);
        let v1 = 0x2::object::id<0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::CouncilCap>(arg1);
        let v2 = 0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::fees_uid_mut(arg0);
        let v3 = CoinBucketKey<T0>{dummy_field: false};
        assert!(0x2::dynamic_field::exists<CoinBucketKey<T0>>(v2, v3), 13876445433896763523);
        let v4 = CoinBucketKey<T0>{dummy_field: false};
        let v5 = 0x2::dynamic_field::borrow_mut<CoinBucketKey<T0>, CoinBucket<T0>>(v2, v4);
        assert!(0x2::table::contains<0x2::object::ID, u64>(&v5.owed, v1), 13876445442486698115);
        let v6 = 0x2::table::remove<0x2::object::ID, u64>(&mut v5.owed, v1);
        assert!(v6 > 0, 13876445451076632707);
        let v7 = CouncilCoinFeesClaimed{
            cap_id    : v1,
            holder    : v0,
            coin_type : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            amount    : v6,
            ts        : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<CouncilCoinFeesClaimed>(v7);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v5.pool, v6), arg4)
    }

    entry fun claim_council_fees_coin_and_keep<T0>(arg0: &mut 0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::CouncilFees, arg1: &0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::CouncilCap, arg2: &0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Config, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = claim_council_fees_coin<T0>(arg0, arg1, arg2, arg3, arg4);
        keep_coin<T0>(v0, arg4);
    }

    public fun close_ms<T0>(arg0: &AmmMarket<T0>) : u64 {
        arg0.schedule.close_ms
    }

    public fun close_trading<T0>(arg0: &mut AmmMarket<T0>, arg1: &0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::PredictAdminCap, arg2: &mut 0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Config, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        admin_entry(arg1, arg2, v0, arg4);
        check_market<T0>(arg2, arg0);
        assert!(arg0.council.status == 0, 13871936607292096611);
        assert!(v0 < arg0.schedule.close_ms, 13868277436888121417);
        arg0.schedule.close_ms = v0;
        let v1 = TradingClosed{
            market_id          : 0x2::object::id<AmmMarket<T0>>(arg0),
            scheduled_close_ms : arg0.schedule.close_ms,
            close_ms           : v0,
            by                 : 0x2::tx_context::sender(arg4),
            ts                 : v0,
        };
        0x2::event::emit<TradingClosed>(v1);
    }

    fun coin_params<T0>(arg0: &0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Config) : CoinParams {
        let v0 = 0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::config_uid(arg0);
        let v1 = CoinParamsKey<T0>{dummy_field: false};
        assert!(0x2::dynamic_field::exists<CoinParamsKey<T0>>(v0, v1), 13863784140885196841);
        let v2 = CoinParamsKey<T0>{dummy_field: false};
        *0x2::dynamic_field::borrow<CoinParamsKey<T0>, CoinParams>(v0, v2)
    }

    public fun coin_params_of<T0>(arg0: &0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Config) : (bool, u64, u64, u64, u64, bool) {
        let v0 = 0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::config_uid(arg0);
        let v1 = CoinParamsKey<T0>{dummy_field: false};
        if (!0x2::dynamic_field::exists<CoinParamsKey<T0>>(v0, v1)) {
            return (false, 0, 0, 0, 0, false)
        };
        let v2 = CoinParamsKey<T0>{dummy_field: false};
        let v3 = 0x2::dynamic_field::borrow<CoinParamsKey<T0>, CoinParams>(v0, v2);
        (true, v3.min_seed, v3.creation_fee, v3.min_trade, v3.dispute_bond, v3.enabled)
    }

    public fun collateral_value<T0>(arg0: &AmmMarket<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.pool.collateral)
    }

    fun conclude<T0>(arg0: &mut AmmMarket<T0>, arg1: u8, arg2: u64, arg3: address) {
        arg0.council.outcome = arg1;
        if (arg1 == 3) {
            enter_refund<T0>(arg0, 4);
            emit_voided<T0>(arg0, 1, arg2, arg3);
        } else {
            let v0 = if (arg1 == 1) {
                1000000000
            } else {
                0
            };
            arg0.payout_price = v0;
            arg0.council.status = 2;
            let v1 = AmmFinalized{
                market_id    : 0x2::object::id<AmmMarket<T0>>(arg0),
                outcome      : arg1,
                payout_price : v0,
                by           : arg3,
                ts           : arg2,
            };
            0x2::event::emit<AmmFinalized>(v1);
        };
    }

    public fun council_daily_quota() : u64 {
        3
    }

    public fun council_fees_value<T0>(arg0: &AmmMarket<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.fees.council_fees)
    }

    public fun council_owed_coin<T0>(arg0: &0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::CouncilFees, arg1: 0x2::object::ID) : u64 {
        let v0 = 0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::fees_uid(arg0);
        let v1 = CoinBucketKey<T0>{dummy_field: false};
        if (!0x2::dynamic_field::exists<CoinBucketKey<T0>>(v0, v1)) {
            return 0
        };
        let v2 = CoinBucketKey<T0>{dummy_field: false};
        let v3 = 0x2::dynamic_field::borrow<CoinBucketKey<T0>, CoinBucket<T0>>(v0, v2);
        if (0x2::table::contains<0x2::object::ID, u64>(&v3.owed, arg1)) {
            *0x2::table::borrow<0x2::object::ID, u64>(&v3.owed, arg1)
        } else {
            0
        }
    }

    public fun council_pool_coin<T0>(arg0: &0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::CouncilFees) : u64 {
        let v0 = 0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::fees_uid(arg0);
        let v1 = CoinBucketKey<T0>{dummy_field: false};
        if (!0x2::dynamic_field::exists<CoinBucketKey<T0>>(v0, v1)) {
            return 0
        };
        let v2 = CoinBucketKey<T0>{dummy_field: false};
        0x2::balance::value<T0>(&0x2::dynamic_field::borrow<CoinBucketKey<T0>, CoinBucket<T0>>(v0, v2).pool)
    }

    fun count_votes<T0>(arg0: &0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Config, arg1: &AmmMarket<T0>, arg2: u8) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(&arg1.council.votes)) {
            if (*0x1::vector::borrow<u8>(&arg1.council.votes, v1) == arg2 && !0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::is_revoked(arg0, 0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::seat_cap_id(0x1::vector::borrow<0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Seat>(&arg1.council.committee, v1)))) {
                v0 = v0 + 1;
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun create_amm_market<T0>(arg0: &mut 0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Config, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T0>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (LpPosition<T0>, 0x1::option::Option<Position<T0>>) {
        assert_v2(arg0);
        let v0 = coin_params<T0>(arg0);
        assert!(v0.enabled, 13863774704842047529);
        let v1 = 0x2::coin::value<T0>(&arg1);
        assert!(v1 == v0.creation_fee, 13864619138362507311);
        let v2 = 0x2::tx_context::sender(arg10);
        assert!(!0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::is_council_holder(arg0, v2), 13864900621929283633);
        assert!(!is_admin_user(arg0, v2), 13878692900089364625);
        assert!(v2 != 0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::treasury(arg0), 13878974379361173651);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::treasury(arg0));
        new_amm_market<T0>(arg0, arg3, arg4, arg5, arg6, arg7, 86400000, arg8, arg2, false, 0x1::option::none<0x2::object::ID>(), v1, arg9, arg10)
    }

    public fun create_amm_market_admin<T0>(arg0: &mut 0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Config, arg1: &0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::PredictAdminCap, arg2: 0x2::coin::Coin<T0>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (LpPosition<T0>, 0x1::option::Option<Position<T0>>) {
        admin_entry(arg1, arg0, 0x2::clock::timestamp_ms(arg10), arg11);
        let v0 = 0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::active_seat_of(arg0, 0x2::tx_context::sender(arg11));
        new_amm_market<T0>(arg0, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg2, true, v0, 0, arg10, arg11)
    }

    entry fun create_amm_market_admin_and_keep<T0>(arg0: &mut 0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Config, arg1: &0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::PredictAdminCap, arg2: 0x2::coin::Coin<T0>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = create_amm_market_admin<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
        keep_lp<T0>(v0, arg11);
        keep_option<T0>(v1, arg11);
    }

    entry fun create_amm_market_and_keep<T0>(arg0: &mut 0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Config, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T0>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = create_amm_market<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        keep_lp<T0>(v0, arg10);
        keep_option<T0>(v1, arg10);
    }

    public fun create_amm_market_council<T0>(arg0: &mut 0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Config, arg1: &0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::CouncilCap, arg2: 0x2::coin::Coin<T0>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (LpPosition<T0>, 0x1::option::Option<Position<T0>>) {
        assert_v2(arg0);
        assert!(0x2::tx_context::sender(arg10) == 0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::cap_holder(arg1), 13865182217165209651);
        let v0 = 0x2::object::id<0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::CouncilCap>(arg1);
        assert!(!0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::is_revoked(arg0, v0), 13865745175708827703);
        assert!(0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::is_active_seat(arg0, v0), 13865463705026953269);
        take_quota(arg0, v0, 0x2::clock::timestamp_ms(arg9), arg10);
        new_amm_market<T0>(arg0, arg3, arg4, arg5, arg6, arg7, 86400000, arg8, arg2, false, 0x1::option::some<0x2::object::ID>(v0), 0, arg9, arg10)
    }

    entry fun create_amm_market_council_and_keep<T0>(arg0: &mut 0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Config, arg1: &0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::CouncilCap, arg2: 0x2::coin::Coin<T0>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = create_amm_market_council<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        keep_lp<T0>(v0, arg10);
        keep_option<T0>(v1, arg10);
    }

    public fun created_ms<T0>(arg0: &AmmMarket<T0>) : u64 {
        arg0.schedule.created_ms
    }

    public fun creator_seat<T0>(arg0: &AmmMarket<T0>) : 0x1::option::Option<0x2::object::ID> {
        arg0.council.creator_seat
    }

    fun debt_of(arg0: u64, arg1: u128) : u128 {
        ((((arg0 as u256) * (arg1 as u256) + 1000000000000000000 - 1) / 1000000000000000000) as u128)
    }

    public fun destroy_empty_market<T0>(arg0: AmmMarket<T0>, arg1: &0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Config, arg2: &0x2::tx_context::TxContext) {
        assert_v2(arg1);
        check_market<T0>(arg1, &arg0);
        assert!(is_terminal<T0>(&arg0) && arg0.fees.settled, 13881512576185270437);
        assert!(arg0.positions_open == 0 && arg0.lp_open == 0, 13881512580480237733);
        let AmmMarket {
            id             : v0,
            version        : _,
            config_id      : _,
            index          : _,
            question       : _,
            details        : _,
            source         : _,
            treasury       : _,
            creator        : _,
            reviewed       : _,
            creation_fee   : _,
            schedule       : _,
            council        : _,
            pool           : v13,
            fees           : v14,
            appeal         : v15,
            payout_price   : _,
            positions_open : _,
            lp_open        : _,
        } = arg0;
        let Pool {
            collateral        : v19,
            sets              : _,
            ry                : _,
            rn                : _,
            lp_total          : _,
            acc_fee_per_share : _,
            min_trade         : _,
        } = v13;
        let Fees {
            lp_fees       : v26,
            council_fees  : v27,
            treasury_fees : v28,
            settled       : _,
            ramp          : _,
        } = v14;
        let Appeal {
            bond_required : _,
            proposed      : _,
            proposed_ms   : _,
            proposer      : _,
            disputed_ms   : _,
            disputer      : _,
            bond          : v37,
            verdict       : _,
            admin_seat    : _,
            withdrawn     : _,
        } = v15;
        0x2::balance::destroy_zero<T0>(v19);
        0x2::balance::destroy_zero<T0>(v26);
        0x2::balance::destroy_zero<T0>(v27);
        0x2::balance::destroy_zero<T0>(v28);
        0x2::balance::destroy_zero<T0>(v37);
        0x2::object::delete(v0);
        let v41 = AmmMarketDestroyed{
            market_id : 0x2::object::id<AmmMarket<T0>>(&arg0),
            by        : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<AmmMarketDestroyed>(v41);
    }

    public fun dispute<T0>(arg0: &mut AmmMarket<T0>, arg1: &0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::CouncilCap, arg2: &0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Config, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_v2(arg2);
        check_market<T0>(arg2, arg0);
        assert!(arg0.council.status == 1, 13873911755378262129);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(v0 == 0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::cap_holder(arg1), 13865186039686103091);
        let v1 = 0x2::object::id<0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::CouncilCap>(arg1);
        let (v2, v3) = 0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::seats_index(&arg0.council.committee, v1);
        assert!(v2, 13872785876945731689);
        assert!(!0x1::option::contains<0x2::object::ID>(&arg0.council.creator_seat, &v1), 13873630306171224175);
        assert!(*0x1::vector::borrow<u8>(&arg0.council.votes, v3) != arg0.council.outcome, 13874193260419874931);
        assert!(!0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::is_revoked(arg2, v1), 13865749015409590327);
        assert!(!arg0.council.dispute_used, 13874474743986651253);
        let v4 = 0x2::clock::timestamp_ms(arg3);
        assert!(v4 < arg0.council.resolved_ms + arg0.schedule.dispute_window_ms, 13874756227553427575);
        arg0.council.dispute_used = true;
        arg0.council.votes = zero_votes(0x1::vector::length<u8>(&arg0.council.votes));
        arg0.council.outcome = 0;
        arg0.council.resolved_ms = 0;
        arg0.council.status = 0;
        let v5 = v4 + 86400000;
        if (v5 > arg0.schedule.void_at_ms) {
            arg0.schedule.void_at_ms = v5;
        };
        let v6 = AmmDisputed{
            market_id  : 0x2::object::id<AmmMarket<T0>>(arg0),
            member     : v0,
            cap_id     : v1,
            ts         : v4,
            void_at_ms : arg0.schedule.void_at_ms,
        };
        0x2::event::emit<AmmDisputed>(v6);
    }

    public fun dispute_proposal<T0>(arg0: &mut AmmMarket<T0>, arg1: &0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Config, arg2: &Position<T0>, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::tx_context::sender(arg5);
        check_position<T0>(arg0, arg2, v0);
        assert!(arg2.yes > 0 || arg2.no > 0, 13878414624863158415);
        open_dispute<T0>(arg1, arg0, 0x2::object::id<Position<T0>>(arg2), false, arg3, 0x2::clock::timestamp_ms(arg4), v0, arg5)
    }

    entry fun dispute_proposal_and_keep<T0>(arg0: &mut AmmMarket<T0>, arg1: &0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Config, arg2: &Position<T0>, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = dispute_proposal<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
        keep_coin<T0>(v0, arg5);
    }

    public fun dispute_proposal_lp<T0>(arg0: &mut AmmMarket<T0>, arg1: &0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Config, arg2: &LpPosition<T0>, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::tx_context::sender(arg5);
        check_lp<T0>(arg0, arg2, v0);
        assert!(arg2.shares > 0, 13878414693582635151);
        open_dispute<T0>(arg1, arg0, 0x2::object::id<LpPosition<T0>>(arg2), true, arg3, 0x2::clock::timestamp_ms(arg4), v0, arg5)
    }

    entry fun dispute_proposal_lp_and_keep<T0>(arg0: &mut AmmMarket<T0>, arg1: &0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Config, arg2: &LpPosition<T0>, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = dispute_proposal_lp<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
        keep_coin<T0>(v0, arg5);
    }

    public fun dispute_used<T0>(arg0: &AmmMarket<T0>) : bool {
        arg0.council.dispute_used
    }

    public fun dispute_window_ms<T0>(arg0: &AmmMarket<T0>) : u64 {
        arg0.schedule.dispute_window_ms
    }

    public fun disputed_ms<T0>(arg0: &AmmMarket<T0>) : u64 {
        arg0.appeal.disputed_ms
    }

    public fun disputer<T0>(arg0: &AmmMarket<T0>) : address {
        arg0.appeal.disputer
    }

    fun div_ceil_u128(arg0: u128, arg1: u128) : u128 {
        if (arg0 == 0) {
            0
        } else {
            (arg0 - 1) / arg1 + 1
        }
    }

    fun do_settle<T0>(arg0: &0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Config, arg1: &mut AmmMarket<T0>, arg2: &mut 0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::CouncilFees, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T0>(&arg1.fees.council_fees);
        let v1 = v0 / 0x1::vector::length<0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Seat>(&arg1.council.committee);
        let v2 = 0x1::vector::empty<0x2::object::ID>();
        if (v1 > 0) {
            let v3 = &arg1.council.committee;
            let v4 = 0;
            while (v4 < 0x1::vector::length<0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Seat>(v3)) {
                let v5 = 0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::seat_cap_id(0x1::vector::borrow<0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Seat>(v3, v4));
                if (!0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::is_revoked(arg0, v5) && !0x1::option::contains<0x2::object::ID>(&arg1.council.creator_seat, &v5)) {
                    0x1::vector::push_back<0x2::object::ID>(&mut v2, v5);
                };
                v4 = v4 + 1;
            };
        };
        let v6 = v1 * 0x1::vector::length<0x2::object::ID>(&v2);
        if (v6 > 0) {
            let v7 = 0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::fees_uid_mut(arg2);
            let v8 = CoinBucketKey<T0>{dummy_field: false};
            if (!0x2::dynamic_field::exists<CoinBucketKey<T0>>(v7, v8)) {
                let v9 = CoinBucketKey<T0>{dummy_field: false};
                let v10 = CoinBucket<T0>{
                    pool : 0x2::balance::zero<T0>(),
                    owed : 0x2::table::new<0x2::object::ID, u64>(arg4),
                };
                0x2::dynamic_field::add<CoinBucketKey<T0>, CoinBucket<T0>>(v7, v9, v10);
            };
            let v11 = CoinBucketKey<T0>{dummy_field: false};
            let v12 = 0x2::dynamic_field::borrow_mut<CoinBucketKey<T0>, CoinBucket<T0>>(v7, v11);
            0x2::balance::join<T0>(&mut v12.pool, 0x2::balance::split<T0>(&mut arg1.fees.council_fees, v6));
            let v13 = &v2;
            let v14 = 0;
            while (v14 < 0x1::vector::length<0x2::object::ID>(v13)) {
                let v15 = *0x1::vector::borrow<0x2::object::ID>(v13, v14);
                if (0x2::table::contains<0x2::object::ID, u64>(&v12.owed, v15)) {
                    let v16 = 0x2::table::borrow_mut<0x2::object::ID, u64>(&mut v12.owed, v15);
                    *v16 = *v16 + v1;
                } else {
                    0x2::table::add<0x2::object::ID, u64>(&mut v12.owed, v15, v1);
                };
                v14 = v14 + 1;
            };
        };
        let v17 = 0x2::balance::value<T0>(&arg1.appeal.bond);
        let v18 = 0x2::balance::zero<T0>();
        if (v17 > 0) {
            let v19 = arg1.appeal.verdict;
            let v20 = arg1.appeal.disputer;
            let v21 = 0x2::balance::withdraw_all<T0>(&mut arg1.appeal.bond);
            let v22 = 0;
            let v23 = 0;
            let v24 = 0;
            if (v19 == 3) {
                v24 = v17;
                0x2::balance::join<T0>(&mut v18, v21);
            } else {
                if (v19 == 2) {
                    let v25 = 0x2::balance::value<T0>(&arg1.fees.treasury_fees);
                    let v26 = if (v17 < v25) {
                        v17
                    } else {
                        v25
                    };
                    v22 = v26;
                    0x2::balance::join<T0>(&mut v21, 0x2::balance::split<T0>(&mut arg1.fees.treasury_fees, v26));
                };
                v23 = 0x2::balance::value<T0>(&v21);
                pay_balance<T0>(v21, v20, arg4);
            };
            let v27 = AmmBondSettled{
                market_id   : 0x2::object::id<AmmMarket<T0>>(arg1),
                disputer    : v20,
                verdict     : v19,
                bond        : v17,
                reward      : v22,
                to_disputer : v23,
                to_treasury : v24,
                ts          : arg3,
            };
            0x2::event::emit<AmmBondSettled>(v27);
        };
        let v28 = 0x2::balance::withdraw_all<T0>(&mut arg1.fees.council_fees);
        0x2::balance::join<T0>(&mut v28, 0x2::balance::withdraw_all<T0>(&mut arg1.fees.treasury_fees));
        0x2::balance::join<T0>(&mut v28, v18);
        arg1.fees.settled = true;
        let v29 = AmmFeesSettled{
            market_id     : 0x2::object::id<AmmMarket<T0>>(arg1),
            council_fees  : v0,
            per_seat      : v1,
            seats         : v2,
            credited      : v6,
            treasury_paid : 0x2::balance::value<T0>(&v28),
            by            : 0x2::tx_context::sender(arg4),
            ts            : arg3,
        };
        0x2::event::emit<AmmFeesSettled>(v29);
        pay_balance<T0>(v28, arg1.treasury, arg4);
    }

    fun emit_voided<T0>(arg0: &AmmMarket<T0>, arg1: u8, arg2: u64, arg3: address) {
        let v0 = AmmVoided{
            market_id    : 0x2::object::id<AmmMarket<T0>>(arg0),
            cause        : arg1,
            payout_price : arg0.payout_price,
            by           : arg3,
            ts           : arg2,
        };
        0x2::event::emit<AmmVoided>(v0);
    }

    fun enter_refund<T0>(arg0: &mut AmmMarket<T0>, arg1: u8) {
        arg0.payout_price = 500000000;
        arg0.council.status = arg1;
    }

    fun enter_terminal<T0>(arg0: &0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Config, arg1: &mut AmmMarket<T0>, arg2: &mut 0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::CouncilFees, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert_v2(arg0);
        check_market<T0>(arg0, arg1);
        0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::check_fees(arg0, arg2);
        try_terminal<T0>(arg0, arg1, arg3, 0x2::tx_context::sender(arg4));
        assert!(is_terminal<T0>(arg1), 13875886224859594879);
        if (!arg1.fees.settled) {
            do_settle<T0>(arg0, arg1, arg2, arg3, arg4);
        };
    }

    public fun fee_at(arg0: u64, arg1: u64) : u64 {
        arg0 - (((arg0 as u128) * ((1000000 - arg1) as u128) / (1000000 as u128)) as u64)
    }

    public fun fee_of(arg0: u64) : u64 {
        arg0 - mul_div(arg0, 9800, 10000)
    }

    public fun fee_parts(arg0: u64, arg1: u64) : (u64, u64, u64, u64) {
        let v0 = fee_at(arg0, arg1);
        let v1 = fee_of(arg0);
        let (v2, v3, v4) = fee_split(v1);
        (v0, v2 + v0 - v1, v3, v4)
    }

    public fun fee_ppm<T0>(arg0: &AmmMarket<T0>, arg1: &0x2::clock::Clock) : u64 {
        rate_now<T0>(arg0, 0x2::clock::timestamp_ms(arg1))
    }

    public fun fee_ramp<T0>(arg0: &AmmMarket<T0>) : (u64, u64, u64) {
        (arg0.fees.ramp.max_ppm, arg0.fees.ramp.window_ms, arg0.fees.ramp.end_ms)
    }

    public fun fee_ramp_defaults(arg0: &0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Config) : (u64, u64) {
        let v0 = fee_ramp_of(arg0);
        (v0.max_ppm, v0.window_ms)
    }

    fun fee_ramp_of(arg0: &0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Config) : FeeRampDefaults {
        let v0 = 0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::config_uid(arg0);
        let v1 = FeeRampKey{dummy_field: false};
        if (0x2::dynamic_field::exists<FeeRampKey>(v0, v1)) {
            let v3 = FeeRampKey{dummy_field: false};
            *0x2::dynamic_field::borrow<FeeRampKey, FeeRampDefaults>(v0, v3)
        } else {
            FeeRampDefaults{max_ppm: 50000, window_ms: 21600000}
        }
    }

    public fun fee_split(arg0: u64) : (u64, u64, u64) {
        let v0 = mul_div(arg0, 5000, 10000);
        let v1 = mul_div(arg0, 2500, 10000);
        (v0, v1, arg0 - v0 - v1)
    }

    public fun fees_settled<T0>(arg0: &AmmMarket<T0>) : bool {
        arg0.fees.settled
    }

    public fun finalize<T0>(arg0: &mut AmmMarket<T0>, arg1: &0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Config, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert_v2(arg1);
        check_market<T0>(arg1, arg0);
        assert!(try_finalize<T0>(arg1, arg0, 0x2::clock::timestamp_ms(arg2), 0x2::tx_context::sender(arg3)), 13875037848559157369);
    }

    fun finish_sell<T0>(arg0: &mut AmmMarket<T0>, arg1: Position<T0>, arg2: u8, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u8, arg13: u64, arg14: address, arg15: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x1::option::Option<Position<T0>>) {
        assert!(arg5 > 0, 13871657593331515489);
        assert!(arg4 == arg5 + arg6, 13877005622186344581);
        assert_k(arg8, arg9, arg10, arg11);
        set_side_reserves<T0>(arg0, arg2, arg10, arg11);
        arg0.pool.sets = arg0.pool.sets - arg4;
        let v0 = 0x2::balance::split<T0>(&mut arg0.pool.collateral, arg4);
        let (v1, v2, v3) = take_fee<T0>(arg0, 0x2::balance::split<T0>(&mut v0, arg6), fee_of(arg4));
        assert_solvent<T0>(arg0);
        if (arg2 == 1) {
            arg1.yes = arg1.yes - arg3;
        } else {
            arg1.no = arg1.no - arg3;
        };
        let v4 = if (arg1.yes == 0 && arg1.no == 0) {
            let Position {
                id              : v5,
                market_id       : _,
                owner           : _,
                yes             : _,
                no              : _,
                locked_until_ms : _,
            } = arg1;
            0x2::object::delete(v5);
            arg0.positions_open = arg0.positions_open - 1;
            0x1::option::none<Position<T0>>()
        } else {
            0x1::option::some<Position<T0>>(arg1)
        };
        let v11 = Traded{
            market_id    : 0x2::object::id<AmmMarket<T0>>(arg0),
            position_id  : 0x2::object::id<Position<T0>>(&arg1),
            trader       : arg14,
            kind         : arg12,
            side         : arg2,
            gross        : arg4,
            shares       : arg3,
            fee_ppm      : arg7,
            fee          : arg6,
            lp_fee       : v1,
            council_fee  : v2,
            treasury_fee : v3,
            net          : arg5,
            ry           : arg0.pool.ry,
            rn           : arg0.pool.rn,
            sets         : arg0.pool.sets,
            price        : spot_price(arg0.pool.ry, arg0.pool.rn),
            ts           : arg13,
        };
        0x2::event::emit<Traded>(v11);
        (0x2::coin::from_balance<T0>(v0, arg15), v4)
    }

    fun holders_of(arg0: &vector<0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Seat>) : vector<address> {
        let v0 = vector[];
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Seat>(arg0)) {
            0x1::vector::push_back<address>(&mut v0, 0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::seat_holder(0x1::vector::borrow<0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Seat>(arg0, v1)));
            v1 = v1 + 1;
        };
        v0
    }

    public fun is_admin_user(arg0: &0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Config, arg1: address) : bool {
        let v0 = AdminUserKey{pos0: arg1};
        0x2::dynamic_field::exists<AdminUserKey>(0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::config_uid(arg0), v0)
    }

    fun is_refund<T0>(arg0: &AmmMarket<T0>) : bool {
        let v0 = arg0.council.status;
        v0 == 4 || v0 == 5
    }

    public fun is_refund_ending<T0>(arg0: &AmmMarket<T0>) : bool {
        is_refund<T0>(arg0)
    }

    fun is_terminal<T0>(arg0: &AmmMarket<T0>) : bool {
        let v0 = arg0.council.status;
        if (v0 == 2) {
            true
        } else if (v0 == 4) {
            true
        } else {
            v0 == 5
        }
    }

    public fun isqrt_u256(arg0: u256) : u256 {
        if (arg0 < 2) {
            return arg0
        };
        let v0 = 0;
        while (arg0 > 0) {
            arg0 = arg0 >> 1;
            v0 = v0 + 1;
        };
        let v1 = 1 << (((v0 + 1) / 2) as u8);
        loop {
            let v2 = (v1 + arg0 / v1) / 2;
            if (v2 >= v1) {
                break
            };
            v1 = v2;
        };
        v1
    }

    public fun keep<T0>(arg0: Position<T0>, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 13870816703159074907);
        0x2::transfer::transfer<Position<T0>>(arg0, arg0.owner);
    }

    fun keep_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
        };
    }

    public fun keep_lp<T0>(arg0: LpPosition<T0>, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 13870816733223845979);
        0x2::transfer::transfer<LpPosition<T0>>(arg0, arg0.owner);
    }

    public fun keep_option<T0>(arg0: 0x1::option::Option<Position<T0>>, arg1: &0x2::tx_context::TxContext) {
        if (0x1::option::is_some<Position<T0>>(&arg0)) {
            keep<T0>(0x1::option::destroy_some<Position<T0>>(arg0), arg1);
        } else {
            0x1::option::destroy_none<Position<T0>>(arg0);
        };
    }

    fun lapse_revoked_dissent<T0>(arg0: &0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Config, arg1: &AmmMarket<T0>, arg2: u64) : (u64, u64) {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        while (v4 < 0x1::vector::length<0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Seat>(&arg1.council.committee)) {
            let v5 = 0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::seat_cap_id(0x1::vector::borrow<0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Seat>(&arg1.council.committee, v4));
            if (appeal_seat<T0>(arg0, arg1, 0x1::vector::borrow<0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Seat>(&arg1.council.committee, v4))) {
                let v6 = 0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::revoked_at_ms(arg0, v5);
                let v7 = 0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::is_revoked(arg0, v5) && (0x1::option::is_none<u64>(&v6) || *0x1::option::borrow<u64>(&v6) < arg2);
                if (v7 && (0x1::option::is_none<u64>(&v6) || *0x1::option::borrow<u64>(&v6) >= arg1.schedule.created_ms)) {
                    v0 = v0 + 1;
                };
                let v8 = *0x1::vector::borrow<u8>(&arg1.council.votes, v4);
                let v9 = if (!v7) {
                    if (v8 != 0) {
                        v8 != arg1.appeal.proposed
                    } else {
                        false
                    }
                } else {
                    false
                };
                if (v9) {
                    if (v8 == 1) {
                        v1 = v1 + 1;
                    } else if (v8 == 2) {
                        v2 = v2 + 1;
                    } else {
                        v3 = v3 + 1;
                    };
                };
            };
            v4 = v4 + 1;
        };
        let v10 = v1;
        if (v2 > v1) {
            v10 = v2;
        };
        if (v3 > v10) {
            v10 = v3;
        };
        (v0, v10)
    }

    public fun lp_fee_debt<T0>(arg0: &LpPosition<T0>) : u128 {
        arg0.fee_debt
    }

    public fun lp_fees_value<T0>(arg0: &AmmMarket<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.fees.lp_fees)
    }

    public fun lp_locked_until_ms<T0>(arg0: &LpPosition<T0>) : u64 {
        arg0.locked_until_ms
    }

    public fun lp_market<T0>(arg0: &LpPosition<T0>) : 0x2::object::ID {
        arg0.market_id
    }

    public fun lp_open<T0>(arg0: &AmmMarket<T0>) : u64 {
        arg0.lp_open
    }

    public fun lp_owner<T0>(arg0: &LpPosition<T0>) : address {
        arg0.owner
    }

    public fun lp_shares<T0>(arg0: &LpPosition<T0>) : u64 {
        arg0.shares
    }

    public fun lp_total<T0>(arg0: &AmmMarket<T0>) : u64 {
        arg0.pool.lp_total
    }

    public fun mark_amm_reviewed<T0>(arg0: &mut AmmMarket<T0>, arg1: &0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::PredictAdminCap, arg2: &mut 0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Config, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        admin_entry(arg1, arg2, v0, arg4);
        check_market<T0>(arg2, arg0);
        assert!(!arg0.reviewed, 13878129159861698701);
        arg0.reviewed = true;
        let v1 = AmmReviewed{
            market_id : 0x2::object::id<AmmMarket<T0>>(arg0),
            by        : 0x2::tx_context::sender(arg4),
            ts        : v0,
        };
        0x2::event::emit<AmmReviewed>(v1);
    }

    public fun market_committee<T0>(arg0: &AmmMarket<T0>) : vector<address> {
        holders_of(&arg0.council.committee)
    }

    public fun market_config_id<T0>(arg0: &AmmMarket<T0>) : 0x2::object::ID {
        arg0.config_id
    }

    public fun market_council_caps<T0>(arg0: &AmmMarket<T0>) : vector<0x2::object::ID> {
        caps_of(&arg0.council.committee)
    }

    public fun market_creation_fee<T0>(arg0: &AmmMarket<T0>) : u64 {
        arg0.creation_fee
    }

    public fun market_creator<T0>(arg0: &AmmMarket<T0>) : address {
        arg0.creator
    }

    public fun market_index<T0>(arg0: &AmmMarket<T0>) : u64 {
        arg0.index
    }

    public fun market_treasury<T0>(arg0: &AmmMarket<T0>) : address {
        arg0.treasury
    }

    public fun market_version<T0>(arg0: &AmmMarket<T0>) : u64 {
        arg0.version
    }

    public fun max_fee_ppm_cap() : u64 {
        100000
    }

    public fun max_odds_bps() : u64 {
        9500
    }

    public fun max_ramp_window_ms() : u64 {
        172800000
    }

    fun maybe_sweep<T0>(arg0: &mut AmmMarket<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg0.positions_open == 0 && arg0.lp_open == 0) {
            sweep<T0>(arg0, arg1, arg2, arg3);
        };
    }

    public fun merge_lp_positions<T0>(arg0: &mut AmmMarket<T0>, arg1: &0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Config, arg2: &mut LpPosition<T0>, arg3: LpPosition<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_v2(arg1);
        check_market<T0>(arg1, arg0);
        let v0 = 0x2::tx_context::sender(arg5);
        check_lp<T0>(arg0, arg2, v0);
        check_lp<T0>(arg0, &arg3, v0);
        let v1 = arg0.pool.acc_fee_per_share;
        let LpPosition {
            id              : v2,
            market_id       : _,
            owner           : _,
            shares          : v5,
            fee_debt        : v6,
            locked_until_ms : v7,
        } = arg3;
        0x2::object::delete(v2);
        let v8 = pending_of(arg2.shares, arg2.fee_debt, v1) + pending_of(v5, v6, v1);
        arg2.shares = arg2.shares + v5;
        arg2.fee_debt = debt_of(arg2.shares, v1);
        if (v7 > arg2.locked_until_ms) {
            arg2.locked_until_ms = v7;
        };
        arg0.lp_open = arg0.lp_open - 1;
        let v9 = LpMerged{
            market_id    : 0x2::object::id<AmmMarket<T0>>(arg0),
            into_id      : 0x2::object::id<LpPosition<T0>>(arg2),
            from_id      : 0x2::object::id<LpPosition<T0>>(&arg3),
            owner        : v0,
            moved_shares : v5,
            shares       : arg2.shares,
            fees         : v8,
            ts           : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<LpMerged>(v9);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.fees.lp_fees, v8), arg5)
    }

    entry fun merge_lp_positions_and_keep<T0>(arg0: &mut AmmMarket<T0>, arg1: &0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Config, arg2: &mut LpPosition<T0>, arg3: LpPosition<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = merge_lp_positions<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
        keep_coin<T0>(v0, arg5);
    }

    public fun merge_positions<T0>(arg0: &mut AmmMarket<T0>, arg1: &0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Config, arg2: &mut Position<T0>, arg3: Position<T0>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert_v2(arg1);
        check_market<T0>(arg1, arg0);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        check_position<T0>(arg0, arg2, v0);
        check_position<T0>(arg0, &arg3, v0);
        assert!(v1 >= arg3.locked_until_ms || arg2.locked_until_ms >= arg3.locked_until_ms, 13879258285289504917);
        let Position {
            id              : v2,
            market_id       : _,
            owner           : _,
            yes             : v5,
            no              : v6,
            locked_until_ms : v7,
        } = arg3;
        0x2::object::delete(v2);
        arg2.yes = arg2.yes + v5;
        arg2.no = arg2.no + v6;
        if (v7 > arg2.locked_until_ms) {
            arg2.locked_until_ms = v7;
        };
        arg0.positions_open = arg0.positions_open - 1;
        let v8 = PositionsMerged{
            market_id : 0x2::object::id<AmmMarket<T0>>(arg0),
            into_id   : 0x2::object::id<Position<T0>>(arg2),
            from_id   : 0x2::object::id<Position<T0>>(&arg3),
            owner     : v0,
            moved_yes : v5,
            moved_no  : v6,
            yes       : arg2.yes,
            no        : arg2.no,
            ts        : v1,
        };
        0x2::event::emit<PositionsMerged>(v8);
    }

    public fun min_odds_bps() : u64 {
        500
    }

    public fun min_trade<T0>(arg0: &AmmMarket<T0>) : u64 {
        arg0.pool.min_trade
    }

    fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    fun new_amm_market<T0>(arg0: &mut 0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Config, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: 0x2::coin::Coin<T0>, arg9: bool, arg10: 0x1::option::Option<0x2::object::ID>, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : (LpPosition<T0>, 0x1::option::Option<Position<T0>>) {
        let v0 = coin_params<T0>(arg0);
        assert!(v0.enabled, 13863775069914267689);
        let v1 = 0x2::coin::value<T0>(&arg8);
        assert!(v1 >= v0.min_seed, 13864056553481044011);
        assert!(arg7 >= 500 && arg7 <= 9500, 13864338032752853037);
        let v2 = 0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::council(arg0);
        assert!(0x1::vector::length<0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Seat>(&v2) == 0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::committee_size(), 13866308366180679739);
        assert!(0x1::vector::length<u8>(&arg1) > 0 && 0x1::vector::length<u8>(&arg3) > 0, 13866589845452488765);
        assert!(0x1::vector::length<u8>(&arg1) <= 200, 13866871324724297791);
        assert!(0x1::vector::length<u8>(&arg2) <= 1000, 13866871329019265087);
        assert!(0x1::vector::length<u8>(&arg3) <= 300, 13866871333314232383);
        let v3 = 0x2::clock::timestamp_ms(arg12);
        assert!(arg4 > v3, 13867152816881008705);
        assert!(arg5 > arg4, 13867434296152817731);
        assert!(arg5 - v3 <= 31622400000, 13867715775424626757);
        assert!(arg6 >= 3600000 && arg6 <= 604800000, 13867997263286370375);
        let (v4, v5) = seed_reserves(v1, arg7);
        assert!(v4 > 0 && v5 > 0, 13869967601009164373);
        let v6 = fee_ramp_of(arg0);
        let v7 = 0x2::object::new(arg13);
        let v8 = 0x2::object::uid_to_inner(&v7);
        let v9 = register(arg0, v8, arg13);
        let v10 = 0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::treasury(arg0);
        let v11 = 0x2::tx_context::sender(arg13);
        let v12 = arg5 + 86400000;
        let v13 = 0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::resolve_threshold();
        let v14 = v1 - v4;
        let v15 = v1 - v5;
        let v16 = v14 > 0 || v15 > 0;
        let v17 = Schedule{
            created_ms        : v3,
            close_ms          : arg4,
            resolve_by_ms     : arg5,
            void_at_ms        : v12,
            dispute_window_ms : arg6,
        };
        let v18 = Council{
            committee    : v2,
            creator_seat : arg10,
            threshold    : v13,
            votes        : zero_votes(0x1::vector::length<0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Seat>(&v2)),
            outcome      : 0,
            resolved_ms  : 0,
            dispute_used : false,
            status       : 0,
        };
        let v19 = Pool<T0>{
            collateral        : 0x2::coin::into_balance<T0>(arg8),
            sets              : v1,
            ry                : v4,
            rn                : v5,
            lp_total          : v1,
            acc_fee_per_share : 0,
            min_trade         : v0.min_trade,
        };
        let v20 = FeeRamp{
            max_ppm   : v6.max_ppm,
            window_ms : v6.window_ms,
            end_ms    : arg4,
        };
        let v21 = Fees<T0>{
            lp_fees       : 0x2::balance::zero<T0>(),
            council_fees  : 0x2::balance::zero<T0>(),
            treasury_fees : 0x2::balance::zero<T0>(),
            settled       : false,
            ramp          : v20,
        };
        let v22 = Appeal<T0>{
            bond_required : v0.dispute_bond,
            proposed      : 0,
            proposed_ms   : 0,
            proposer      : @0x0,
            disputed_ms   : 0,
            disputer      : @0x0,
            bond          : 0x2::balance::zero<T0>(),
            verdict       : 0,
            admin_seat    : 0x1::option::none<0x2::object::ID>(),
            withdrawn     : false,
        };
        let v23 = if (v16) {
            1
        } else {
            0
        };
        let v24 = AmmMarket<T0>{
            id             : v7,
            version        : 2,
            config_id      : 0x2::object::id<0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Config>(arg0),
            index          : v9,
            question       : 0x1::string::utf8(arg1),
            details        : 0x1::string::utf8(arg2),
            source         : 0x1::string::utf8(arg3),
            treasury       : v10,
            creator        : v11,
            reviewed       : arg9,
            creation_fee   : arg11,
            schedule       : v17,
            council        : v18,
            pool           : v19,
            fees           : v21,
            appeal         : v22,
            payout_price   : 0,
            positions_open : v23,
            lp_open        : 1,
        };
        let v25 = LpPosition<T0>{
            id              : 0x2::object::new(arg13),
            market_id       : v8,
            owner           : v11,
            shares          : v1,
            fee_debt        : 0,
            locked_until_ms : arg4,
        };
        let v26 = 0x1::option::none<0x2::object::ID>();
        let v27 = 0x1::option::none<Position<T0>>();
        if (v16) {
            let v28 = Position<T0>{
                id              : 0x2::object::new(arg13),
                market_id       : v8,
                owner           : v11,
                yes             : v14,
                no              : v15,
                locked_until_ms : arg4,
            };
            v26 = 0x1::option::some<0x2::object::ID>(0x2::object::id<Position<T0>>(&v28));
            0x1::option::fill<Position<T0>>(&mut v27, v28);
        };
        assert_solvent<T0>(&v24);
        let v29 = AmmMarketCreated{
            market_id         : v8,
            index             : v9,
            coin_type         : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            question          : v24.question,
            close_ms          : arg4,
            resolve_by_ms     : arg5,
            void_at_ms        : v12,
            committee         : holders_of(&v24.council.committee),
            council_caps      : caps_of(&v24.council.committee),
            creator_seat      : arg10,
            threshold         : v13,
            dispute_window_ms : arg6,
            dispute_bond      : v0.dispute_bond,
            max_fee_ppm       : v6.max_ppm,
            ramp_window_ms    : v6.window_ms,
            treasury          : v10,
            creator           : v11,
            creation_fee      : arg11,
            seed              : v1,
            p0_bps            : arg7,
            ry                : v4,
            rn                : v5,
            lp_id             : 0x2::object::id<LpPosition<T0>>(&v25),
            seed_position_id  : v26,
            seed_left_yes     : v14,
            seed_left_no      : v15,
            reviewed          : arg9,
            by                : v11,
            ts                : v3,
        };
        0x2::event::emit<AmmMarketCreated>(v29);
        0x2::transfer::share_object<AmmMarket<T0>>(v24);
        (v25, v27)
    }

    fun open_dispute<T0>(arg0: &0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Config, arg1: &mut AmmMarket<T0>, arg2: 0x2::object::ID, arg3: bool, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: address, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_v2(arg0);
        check_market<T0>(arg0, arg1);
        let v0 = arg1.council.status;
        assert!(v0 != 7, 13874474116921426037);
        assert!(v0 == 6, 13880103620753096859);
        assert!(arg5 < arg1.appeal.proposed_ms + 21600000, 13874755609078136951);
        assert_not_banned<T0>(arg0, arg1, arg6);
        let (v1, _, _, v4) = seat_counts<T0>(arg0, arg1, arg5);
        let v5 = arg1.council.threshold;
        assert!(v1 >= v5 && v1 - v4 >= v5, 13882636925609443501);
        assert!(0x2::coin::value<T0>(&arg4) == arg1.appeal.bond_required, 13880385130089676957);
        let v6 = usable_seats<T0>(arg0, arg1);
        if (v6 < v5) {
            arg1.appeal.proposed = 0;
            arg1.appeal.proposed_ms = 0;
            arg1.appeal.proposer = @0x0;
            arg1.appeal.admin_seat = 0x1::option::none<0x2::object::ID>();
            arg1.appeal.withdrawn = true;
            arg1.council.votes = zero_votes(0x1::vector::length<u8>(&arg1.council.votes));
            arg1.council.status = 0;
            let v7 = AmmProposalWithdrawn{
                market_id     : 0x2::object::id<AmmMarket<T0>>(arg1),
                proposed      : arg1.appeal.proposed,
                proposer      : arg1.appeal.proposer,
                disputer      : arg6,
                proof_id      : arg2,
                proof_is_lp   : arg3,
                usable        : v6,
                threshold     : v5,
                ts            : arg5,
                resolve_by_ms : arg1.schedule.resolve_by_ms,
                void_at_ms    : arg1.schedule.void_at_ms,
            };
            0x2::event::emit<AmmProposalWithdrawn>(v7);
            return arg4
        };
        0x2::balance::join<T0>(&mut arg1.appeal.bond, 0x2::coin::into_balance<T0>(arg4));
        arg1.appeal.disputed_ms = arg5;
        arg1.appeal.disputer = arg6;
        arg1.council.votes = zero_votes(0x1::vector::length<u8>(&arg1.council.votes));
        arg1.council.status = 7;
        let v8 = AmmProposalDisputed{
            market_id           : 0x2::object::id<AmmMarket<T0>>(arg1),
            disputer            : arg6,
            proof_id            : arg2,
            proof_is_lp         : arg3,
            proposed            : arg1.appeal.proposed,
            bond                : 0x2::balance::value<T0>(&arg1.appeal.bond),
            ts                  : arg5,
            council_deadline_ms : arg5 + 259200000,
        };
        0x2::event::emit<AmmProposalDisputed>(v8);
        0x2::coin::zero<T0>(arg7)
    }

    public fun outcome<T0>(arg0: &AmmMarket<T0>) : u8 {
        arg0.council.outcome
    }

    fun pay_balance<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) == 0) {
            0x2::balance::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg2), arg1);
        };
    }

    public fun payout_price<T0>(arg0: &AmmMarket<T0>) : u64 {
        arg0.payout_price
    }

    public fun payout_value(arg0: u64, arg1: u64, arg2: u64) : u64 {
        mul_div(arg0, arg2, 1000000000) + mul_div(arg1, 1000000000 - arg2, 1000000000)
    }

    public fun pending_fees<T0>(arg0: &AmmMarket<T0>, arg1: &LpPosition<T0>) : u64 {
        pending_of(arg1.shares, arg1.fee_debt, arg0.pool.acc_fee_per_share)
    }

    fun pending_of(arg0: u64, arg1: u128, arg2: u128) : u64 {
        let v0 = (arg0 as u256) * (arg2 as u256) / 1000000000000000000;
        let v1 = (arg1 as u256);
        if (v0 > v1) {
            ((v0 - v1) as u64)
        } else {
            0
        }
    }

    public fun position_locked_until_ms<T0>(arg0: &Position<T0>) : u64 {
        arg0.locked_until_ms
    }

    public fun position_market<T0>(arg0: &Position<T0>) : 0x2::object::ID {
        arg0.market_id
    }

    public fun position_no<T0>(arg0: &Position<T0>) : u64 {
        arg0.no
    }

    public fun position_owner<T0>(arg0: &Position<T0>) : address {
        arg0.owner
    }

    public fun position_yes<T0>(arg0: &Position<T0>) : u64 {
        arg0.yes
    }

    public fun positions_open<T0>(arg0: &AmmMarket<T0>) : u64 {
        arg0.positions_open
    }

    public fun price<T0>(arg0: &AmmMarket<T0>) : u64 {
        spot_price(arg0.pool.ry, arg0.pool.rn)
    }

    public fun price_scale() : u64 {
        1000000000
    }

    public fun proposal_withdrawn<T0>(arg0: &AmmMarket<T0>) : bool {
        arg0.appeal.withdrawn
    }

    public fun propose_outcome<T0>(arg0: &mut AmmMarket<T0>, arg1: &0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::PredictAdminCap, arg2: &mut 0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Config, arg3: u8, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg4);
        admin_entry(arg1, arg2, v0, arg5);
        check_market<T0>(arg2, arg0);
        assert!(!arg0.appeal.withdrawn, 13883758925686505653);
        assert!(arg0.appeal.proposed == 0, 13879536805328846999);
        assert!(arg0.council.status == 0, 13871936985249218659);
        let v1 = if (arg3 == 1) {
            true
        } else if (arg3 == 2) {
            true
        } else {
            arg3 == 3
        };
        assert!(v1, 13873344364428394605);
        assert!(v0 >= arg0.schedule.close_ms && v0 < arg0.schedule.resolve_by_ms, 13879818293190590617);
        let v2 = admin_seat(arg2);
        assert!(0x1::option::is_some<0x2::object::ID>(&v2), 13883196001502625969);
        let v3 = 0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::active_seat_of(arg2, 0x2::tx_context::sender(arg5));
        assert!(0x1::option::contains<0x2::object::ID>(&v3, 0x1::option::borrow<0x2::object::ID>(&v2)), 13883477497954304179);
        arg0.appeal.admin_seat = v2;
        assert!(usable_seats<T0>(arg2, arg0) >= arg0.council.threshold, 13882633124563386541);
        arg0.appeal.proposed = arg3;
        arg0.appeal.proposed_ms = v0;
        arg0.appeal.proposer = 0x2::tx_context::sender(arg5);
        arg0.council.status = 6;
        let v4 = AmmProposed{
            market_id         : 0x2::object::id<AmmMarket<T0>>(arg0),
            outcome           : arg3,
            by                : 0x2::tx_context::sender(arg5),
            ts                : v0,
            challenge_ends_ms : v0 + 21600000,
        };
        0x2::event::emit<AmmProposed>(v4);
    }

    public fun proposed<T0>(arg0: &AmmMarket<T0>) : u8 {
        arg0.appeal.proposed
    }

    public fun proposed_ms<T0>(arg0: &AmmMarket<T0>) : u64 {
        arg0.appeal.proposed_ms
    }

    public fun proposer<T0>(arg0: &AmmMarket<T0>) : address {
        arg0.appeal.proposer
    }

    public fun prune_seat_quota(arg0: &mut 0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Config, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) {
        assert_v2(arg0);
        assert!(0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::is_revoked(arg0, arg1), 13881794141356425383);
        let v0 = 0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::config_uid_mut(arg0);
        let v1 = SeatQuotaKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<SeatQuotaKey>(v0, v1), 13882075624923332779);
        let v2 = SeatQuotaKey{dummy_field: false};
        let v3 = 0x2::dynamic_field::borrow_mut<SeatQuotaKey, 0x2::table::Table<0x2::object::ID, Quota>>(v0, v2);
        assert!(0x2::table::contains<0x2::object::ID, Quota>(v3, arg1), 13882075633513267371);
        0x2::table::remove<0x2::object::ID, Quota>(v3, arg1);
        let v4 = SeatQuotaPruned{
            cap_id : arg1,
            by     : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<SeatQuotaPruned>(v4);
    }

    public fun question<T0>(arg0: &AmmMarket<T0>) : 0x1::string::String {
        arg0.question
    }

    public fun quote_buy(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : (u64, u64, u64, u64) {
        let v0 = fee_at(arg2, arg3);
        let v1 = arg2 - v0;
        assert!(v1 > 0, 13871662515364036705);
        let v2 = (arg1 as u128) + (v1 as u128);
        let v3 = div_ceil_u128((arg0 as u128) * (arg1 as u128), v2);
        assert!(v3 >= 1, 13869973682682855509);
        let v4 = (arg0 as u128) + (v1 as u128) - v3;
        assert!(v4 > 0, 13871662541133840481);
        ((v4 as u64), (v3 as u64), (v2 as u64), v0)
    }

    public fun quote_fee<T0>(arg0: &AmmMarket<T0>, arg1: u64, arg2: &0x2::clock::Clock) : (u64, u64, u64, u64, u64) {
        let v0 = rate_now<T0>(arg0, 0x2::clock::timestamp_ms(arg2));
        let (v1, v2, v3, v4) = fee_parts(arg1, v0);
        (v0, v1, v2, v3, v4)
    }

    public fun quote_sell_collateral(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : (u64, u64, u64, u64, u64) {
        let v0 = div_ceil_u128((arg2 as u128) * (1000000 as u128), ((1000000 - arg3) as u128));
        assert!(v0 < (arg1 as u128), 13869973738517430357);
        let v1 = (v0 as u64);
        let v2 = fee_at(v1, arg3);
        assert!(v1 - v2 == arg2, 13877010625823244421);
        let v3 = arg1 - v1;
        let v4 = div_ceil_u128((arg0 as u128) * (arg1 as u128), (v3 as u128));
        (((v4 + (v1 as u128) - (arg0 as u128)) as u64), v1, v2, (v4 as u64), v3)
    }

    public fun quote_sell_shares(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : (u64, u64, u64, u64, u64) {
        let v0 = (arg0 as u256);
        let v1 = (arg1 as u256);
        let v2 = (arg2 as u256);
        let v3 = v0 + v2 + v1;
        let v4 = 2 * v2 * v1 / (v3 + ceil_sqrt_u256(v3 * v3 - 4 * v2 * v1));
        while (v4 > 0 && (v0 + v2 - v4) * (v1 - v4) < v0 * v1) {
            v4 = v4 - 1;
        };
        assert!(v4 > 0, 13871662691457695841);
        let v5 = (v4 as u64);
        let v6 = fee_at(v5, arg3);
        (v5, v5 - v6, v6, arg0 + arg2 - v5, arg1 - v5)
    }

    public fun ramp_ppm(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        let v0 = if (arg3 > arg2) {
            arg3 - arg2
        } else {
            0
        };
        let v1 = if (arg1 < v0) {
            arg1
        } else {
            v0
        };
        if (v1 == 0) {
            return 20000
        };
        if (arg4 >= arg3) {
            return arg0
        };
        let v2 = arg3 - v1;
        if (arg4 <= v2) {
            return 20000
        };
        let v3 = (v1 as u128);
        20000 + (((((arg0 - 20000) as u128) * ((arg4 - v2) as u128) + v3 - 1) / v3) as u64)
    }

    fun rate_now<T0>(arg0: &AmmMarket<T0>, arg1: u64) : u64 {
        let v0 = &arg0.fees.ramp;
        ramp_ppm(v0.max_ppm, v0.window_ms, arg0.schedule.created_ms, v0.end_ms, arg1)
    }

    public(friend) fun record_admin_user(arg0: &mut 0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Config, arg1: address, arg2: u64) {
        let v0 = 0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::config_uid_mut(arg0);
        let v1 = AdminUserKey{pos0: arg1};
        if (!0x2::dynamic_field::exists<AdminUserKey>(v0, v1)) {
            let v2 = AdminUserKey{pos0: arg1};
            0x2::dynamic_field::add<AdminUserKey, bool>(v0, v2, true);
            let v3 = AdminUserRecorded{
                who : arg1,
                ts  : arg2,
            };
            0x2::event::emit<AdminUserRecorded>(v3);
        };
    }

    public fun redeem<T0>(arg0: &mut AmmMarket<T0>, arg1: &0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Config, arg2: &mut 0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::CouncilFees, arg3: Position<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = 0x2::tx_context::sender(arg5);
        enter_terminal<T0>(arg1, arg0, arg2, v0, arg5);
        check_position<T0>(arg0, &arg3, v1);
        let Position {
            id              : v2,
            market_id       : _,
            owner           : _,
            yes             : v5,
            no              : v6,
            locked_until_ms : _,
        } = arg3;
        0x2::object::delete(v2);
        arg0.positions_open = arg0.positions_open - 1;
        let v8 = arg0.payout_price;
        let v9 = payout_value(v5, v6, v8);
        let v10 = 0x2::balance::split<T0>(&mut arg0.pool.collateral, v9);
        let v11 = Redeemed{
            market_id    : 0x2::object::id<AmmMarket<T0>>(arg0),
            position_id  : 0x2::object::id<Position<T0>>(&arg3),
            owner        : v1,
            yes          : v5,
            no           : v6,
            refund       : is_refund<T0>(arg0),
            payout_price : v8,
            payout       : v9,
            ts           : v0,
        };
        0x2::event::emit<Redeemed>(v11);
        maybe_sweep<T0>(arg0, v0, v1, arg5);
        0x2::coin::from_balance<T0>(v10, arg5)
    }

    entry fun redeem_and_keep<T0>(arg0: &mut AmmMarket<T0>, arg1: &0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Config, arg2: &mut 0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::CouncilFees, arg3: Position<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = redeem<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
        keep_coin<T0>(v0, arg5);
    }

    public fun refund_price() : u64 {
        500000000
    }

    fun register(arg0: &mut 0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Config, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::config_uid_mut(arg0);
        let v1 = AmmRegistryKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<AmmRegistryKey>(v0, v1)) {
            let v2 = AmmRegistryKey{dummy_field: false};
            let v3 = AmmRegistry{
                markets : 0x2::table::new<u64, 0x2::object::ID>(arg2),
                count   : 0,
            };
            0x2::dynamic_field::add<AmmRegistryKey, AmmRegistry>(v0, v2, v3);
        };
        let v4 = AmmRegistryKey{dummy_field: false};
        let v5 = 0x2::dynamic_field::borrow_mut<AmmRegistryKey, AmmRegistry>(v0, v4);
        let v6 = v5.count;
        0x2::table::add<u64, 0x2::object::ID>(&mut v5.markets, v6, arg1);
        v5.count = v6 + 1;
        v6
    }

    public fun remove_liquidity<T0>(arg0: &mut AmmMarket<T0>, arg1: &0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Config, arg2: LpPosition<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x1::option::Option<Position<T0>>) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = 0x2::tx_context::sender(arg4);
        assert_can_trade<T0>(arg1, arg0, v0, v1);
        check_lp<T0>(arg0, &arg2, v1);
        assert!(v0 >= arg2.locked_until_ms, 13871376698175258719);
        let LpPosition {
            id              : v2,
            market_id       : _,
            owner           : _,
            shares          : v5,
            fee_debt        : v6,
            locked_until_ms : _,
        } = arg2;
        0x2::object::delete(v2);
        let v8 = pending_of(v5, v6, arg0.pool.acc_fee_per_share);
        let v9 = arg0.pool.lp_total;
        let v10 = mul_div(arg0.pool.ry, v5, v9);
        let v11 = mul_div(arg0.pool.rn, v5, v9);
        assert!(arg0.pool.ry - v10 > 0 && arg0.pool.rn - v11 > 0, 13869969357650788437);
        arg0.pool.ry = arg0.pool.ry - v10;
        arg0.pool.rn = arg0.pool.rn - v11;
        arg0.pool.lp_total = v9 - v5;
        arg0.lp_open = arg0.lp_open - 1;
        let v12 = if (v10 < v11) {
            v10
        } else {
            v11
        };
        arg0.pool.sets = arg0.pool.sets - v12;
        let v13 = 0x2::balance::split<T0>(&mut arg0.pool.collateral, v12);
        0x2::balance::join<T0>(&mut v13, 0x2::balance::split<T0>(&mut arg0.fees.lp_fees, v8));
        assert_solvent<T0>(arg0);
        let v14 = 0x2::object::id<AmmMarket<T0>>(arg0);
        let v15 = v10 - v12;
        let v16 = v11 - v12;
        let v17 = 0x1::option::none<0x2::object::ID>();
        let v18 = 0x1::option::none<Position<T0>>();
        if (v15 > 0 || v16 > 0) {
            let v19 = Position<T0>{
                id              : 0x2::object::new(arg4),
                market_id       : v14,
                owner           : v1,
                yes             : v15,
                no              : v16,
                locked_until_ms : 0,
            };
            v17 = 0x1::option::some<0x2::object::ID>(0x2::object::id<Position<T0>>(&v19));
            arg0.positions_open = arg0.positions_open + 1;
            0x1::option::fill<Position<T0>>(&mut v18, v19);
        };
        let v20 = LiquidityRemoved{
            market_id   : v14,
            lp_id       : 0x2::object::id<LpPosition<T0>>(&arg2),
            provider    : v1,
            shares      : v5,
            take_yes    : v10,
            take_no     : v11,
            merged      : v12,
            fees        : v8,
            position_id : v17,
            ry          : arg0.pool.ry,
            rn          : arg0.pool.rn,
            lp_total    : arg0.pool.lp_total,
            ts          : v0,
        };
        0x2::event::emit<LiquidityRemoved>(v20);
        (0x2::coin::from_balance<T0>(v13, arg4), v18)
    }

    entry fun remove_liquidity_and_keep<T0>(arg0: &mut AmmMarket<T0>, arg1: &0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Config, arg2: LpPosition<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = remove_liquidity<T0>(arg0, arg1, arg2, arg3, arg4);
        keep_coin<T0>(v0, arg4);
        keep_option<T0>(v1, arg4);
    }

    public fun resolve_by_ms<T0>(arg0: &AmmMarket<T0>) : u64 {
        arg0.schedule.resolve_by_ms
    }

    public fun resolved_ms<T0>(arg0: &AmmMarket<T0>) : u64 {
        arg0.council.resolved_ms
    }

    public fun reviewed<T0>(arg0: &AmmMarket<T0>) : bool {
        arg0.reviewed
    }

    public fun revoke_amm_market<T0>(arg0: &mut AmmMarket<T0>, arg1: &0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::PredictAdminCap, arg2: &mut 0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Config, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg4);
        admin_entry(arg1, arg2, v0, arg5);
        check_market<T0>(arg2, arg0);
        let v1 = arg0.council.status;
        let v2 = if (v1 == 0 && v0 < arg0.schedule.void_at_ms) {
            true
        } else if (v1 == 1 && v0 < arg0.council.resolved_ms + arg0.schedule.dispute_window_ms) {
            true
        } else if (v1 == 6 && v0 < arg0.appeal.proposed_ms + 21600000) {
            true
        } else {
            v1 == 7 && v0 < arg0.appeal.disputed_ms + 259200000
        };
        assert!(v2, 13875596421941166205);
        assert!(0x1::vector::length<u8>(&arg3) > 0, 13866589226977198141);
        assert!(0x1::vector::length<u8>(&arg3) <= 300, 13866870706249007167);
        let v3 = if (v1 == 1) {
            2
        } else if (v1 == 6) {
            4
        } else if (v1 == 7) {
            5
        } else if (arg0.council.dispute_used) {
            3
        } else if (v0 < arg0.schedule.close_ms) {
            0
        } else {
            1
        };
        if (v1 == 7) {
            arg0.appeal.verdict = 1;
        };
        enter_refund<T0>(arg0, 5);
        arg0.council.outcome = 0;
        arg0.council.resolved_ms = 0;
        let v4 = AmmRevoked{
            market_id    : 0x2::object::id<AmmMarket<T0>>(arg0),
            reason       : 0x1::string::utf8(arg3),
            stage        : v3,
            payout_price : arg0.payout_price,
            by           : 0x2::tx_context::sender(arg5),
            ts           : v0,
        };
        0x2::event::emit<AmmRevoked>(v4);
    }

    public fun rn<T0>(arg0: &AmmMarket<T0>) : u64 {
        arg0.pool.rn
    }

    public fun ry<T0>(arg0: &AmmMarket<T0>) : u64 {
        arg0.pool.ry
    }

    fun seat_counts<T0>(arg0: &0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Config, arg1: &AmmMarket<T0>, arg2: u64) : (u64, u64, u64, u64) {
        seat_counts_at<T0>(arg0, arg1, arg2, arg1.council.status == 7)
    }

    fun seat_counts_at<T0>(arg0: &0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Config, arg1: &AmmMarket<T0>, arg2: u64, arg3: bool) : (u64, u64, u64, u64) {
        let v0 = if (arg3) {
            arg1.appeal.disputed_ms
        } else {
            arg2
        };
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        while (v5 < 0x1::vector::length<0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Seat>(&arg1.council.committee)) {
            let v6 = 0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::seat_cap_id(0x1::vector::borrow<0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Seat>(&arg1.council.committee, v5));
            if (appeal_seat<T0>(arg0, arg1, 0x1::vector::borrow<0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Seat>(&arg1.council.committee, v5))) {
                v1 = v1 + 1;
                if (0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::is_revoked(arg0, v6)) {
                    let v7 = 0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::revoked_at_ms(arg0, v6);
                    let v8 = arg3 && *0x1::vector::borrow<u8>(&arg1.council.votes, v5) != 0;
                    if (0x1::option::is_none<u64>(&v7)) {
                        v2 = v2 + 1;
                        v3 = v3 + 1;
                    } else if (*0x1::option::borrow<u64>(&v7) < arg2) {
                        v2 = v2 + 1;
                        if (v8 || *0x1::option::borrow<u64>(&v7) >= v0) {
                            v3 = v3 + 1;
                        } else if (*0x1::option::borrow<u64>(&v7) < arg1.schedule.created_ms) {
                            v4 = v4 + 1;
                        };
                    };
                };
            };
            v5 = v5 + 1;
        };
        (v1, v1 - v2, v3, v4)
    }

    public fun seat_quota(arg0: &0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Config, arg1: 0x2::object::ID) : (u64, u64) {
        let v0 = 0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::config_uid(arg0);
        let v1 = SeatQuotaKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<SeatQuotaKey>(v0, v1)) {
            return (0, 0)
        };
        let v2 = SeatQuotaKey{dummy_field: false};
        let v3 = 0x2::dynamic_field::borrow<SeatQuotaKey, 0x2::table::Table<0x2::object::ID, Quota>>(v0, v2);
        if (!0x2::table::contains<0x2::object::ID, Quota>(v3, arg1)) {
            return (0, 0)
        };
        let v4 = 0x2::table::borrow<0x2::object::ID, Quota>(v3, arg1);
        (v4.day, v4.count)
    }

    public fun seed_reserves(arg0: u64, arg1: u64) : (u64, u64) {
        if (arg1 >= 10000 / 2) {
            (mul_div(arg0, 10000 - arg1, arg1), arg0)
        } else {
            (arg0, mul_div(arg0, arg1, 10000 - arg1))
        }
    }

    public fun sell_exact_shares<T0>(arg0: &mut AmmMarket<T0>, arg1: &0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Config, arg2: Position<T0>, arg3: u8, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x1::option::Option<Position<T0>>) {
        let v0 = 0x2::clock::timestamp_ms(arg6);
        let v1 = 0x2::tx_context::sender(arg7);
        assert_can_trade<T0>(arg1, arg0, v0, v1);
        assert!(arg3 == 1 || arg3 == 2, 13868561119478153291);
        assert!(arg5 > 0, 13869405548703645777);
        check_position<T0>(arg0, &arg2, v1);
        assert!(v0 >= arg2.locked_until_ms, 13879257181482909845);
        assert!(arg4 > 0 && arg4 <= side_balance<T0>(&arg2, arg3), 13871094411449598045);
        let (v2, v3) = side_reserves<T0>(arg0, arg3);
        let v4 = rate_now<T0>(arg0, v0);
        let (v5, v6, v7, v8, v9) = quote_sell_shares(v2, v3, arg4, v4);
        assert!(v6 >= arg5, 13869687053745258579);
        finish_sell<T0>(arg0, arg2, arg3, arg4, v5, v6, v7, v4, v2, v3, v8, v9, 2, v0, v1, arg7)
    }

    entry fun sell_exact_shares_and_keep<T0>(arg0: &mut AmmMarket<T0>, arg1: &0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Config, arg2: Position<T0>, arg3: u8, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = sell_exact_shares<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        keep_coin<T0>(v0, arg7);
        keep_option<T0>(v1, arg7);
    }

    public fun sell_for_collateral<T0>(arg0: &mut AmmMarket<T0>, arg1: &0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Config, arg2: Position<T0>, arg3: u8, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x1::option::Option<Position<T0>>) {
        let v0 = 0x2::clock::timestamp_ms(arg6);
        let v1 = 0x2::tx_context::sender(arg7);
        assert_can_trade<T0>(arg1, arg0, v0, v1);
        assert!(arg3 == 1 || arg3 == 2, 13868561235442270283);
        assert!(arg5 > 0, 13869405664667762769);
        assert!(arg4 > 0, 13871657468777463905);
        check_position<T0>(arg0, &arg2, v1);
        assert!(v0 >= arg2.locked_until_ms, 13879257301741994133);
        let (v2, v3) = side_reserves<T0>(arg0, arg3);
        let v4 = rate_now<T0>(arg0, v0);
        let (v5, v6, v7, v8, v9) = quote_sell_collateral(v2, v3, arg4, v4);
        assert!(v5 <= arg5, 13869687169709375571);
        assert!(v5 <= side_balance<T0>(&arg2, arg3), 13871094548888551517);
        finish_sell<T0>(arg0, arg2, arg3, v5, v6, arg4, v7, v4, v2, v3, v8, v9, 3, v0, v1, arg7)
    }

    entry fun sell_for_collateral_and_keep<T0>(arg0: &mut AmmMarket<T0>, arg1: &0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Config, arg2: Position<T0>, arg3: u8, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = sell_for_collateral<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        keep_coin<T0>(v0, arg7);
        keep_option<T0>(v1, arg7);
    }

    public fun set_admin_seat(arg0: &mut 0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Config, arg1: &0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::PredictAdminCap, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        admin_entry(arg1, arg0, v0, arg4);
        assert!(!0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::is_revoked(arg0, arg2), 13865744372549943351);
        assert!(0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::is_active_seat(arg0, arg2), 13865462901868068917);
        let v1 = 0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::active_seat_of(arg0, 0x2::tx_context::sender(arg4));
        assert!(0x1::option::contains<0x2::object::ID>(&v1, &arg2), 13883477304680775859);
        let v2 = admin_seat(arg0);
        if (0x1::option::is_some<0x2::object::ID>(&v2)) {
            let v3 = AdminSeatKey{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<AdminSeatKey, 0x2::object::ID>(0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::config_uid_mut(arg0), v3) = arg2;
        } else {
            let v4 = AdminSeatKey{dummy_field: false};
            0x2::dynamic_field::add<AdminSeatKey, 0x2::object::ID>(0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::config_uid_mut(arg0), v4, arg2);
        };
        let v5 = AdminSeatSet{
            seat_cap_id : arg2,
            previous    : v2,
            by          : 0x2::tx_context::sender(arg4),
            ts          : v0,
        };
        0x2::event::emit<AdminSeatSet>(v5);
    }

    public fun set_coin_params<T0>(arg0: &mut 0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Config, arg1: &0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::PredictAdminCap, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: bool, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg7);
        admin_entry(arg1, arg0, v0, arg8);
        assert!(arg2 >= 10000000 && arg2 <= 100000000000000, 13877565840540827785);
        assert!(arg3 > 0 && arg3 <= 10000000000000, 13877565844835795081);
        assert!(arg4 > 0 && arg4 <= arg2, 13877565849130762377);
        assert!(arg5 >= 10000000 && arg5 <= 10000000000000, 13877565853425729673);
        assert!(arg5 <= arg2, 13877565866310631561);
        let v1 = CoinParams{
            min_seed     : arg2,
            creation_fee : arg3,
            min_trade    : arg4,
            dispute_bond : arg5,
            enabled      : arg6,
        };
        let v2 = 0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::config_uid_mut(arg0);
        let v3 = CoinParamsKey<T0>{dummy_field: false};
        if (0x2::dynamic_field::exists<CoinParamsKey<T0>>(v2, v3)) {
            let v4 = CoinParamsKey<T0>{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<CoinParamsKey<T0>, CoinParams>(v2, v4) = v1;
        } else {
            let v5 = CoinParamsKey<T0>{dummy_field: false};
            0x2::dynamic_field::add<CoinParamsKey<T0>, CoinParams>(v2, v5, v1);
        };
        let v6 = CoinParamsSet{
            coin_type    : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            min_seed     : arg2,
            creation_fee : arg3,
            min_trade    : arg4,
            dispute_bond : arg5,
            enabled      : arg6,
            by           : 0x2::tx_context::sender(arg8),
            ts           : v0,
        };
        0x2::event::emit<CoinParamsSet>(v6);
    }

    public fun set_fee_ramp(arg0: &mut 0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Config, arg1: &0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::PredictAdminCap, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg4);
        admin_entry(arg1, arg0, v0, arg5);
        assert!(arg2 >= 20000 && arg2 <= 100000, 13882351082650730665);
        assert!(arg3 <= 172800000, 13882351086945697961);
        let v1 = FeeRampDefaults{
            max_ppm   : arg2,
            window_ms : arg3,
        };
        let v2 = 0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::config_uid_mut(arg0);
        let v3 = FeeRampKey{dummy_field: false};
        if (0x2::dynamic_field::exists<FeeRampKey>(v2, v3)) {
            let v4 = FeeRampKey{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<FeeRampKey, FeeRampDefaults>(v2, v4) = v1;
        } else {
            let v5 = FeeRampKey{dummy_field: false};
            0x2::dynamic_field::add<FeeRampKey, FeeRampDefaults>(v2, v5, v1);
        };
        let v6 = FeeRampSet{
            max_ppm   : arg2,
            window_ms : arg3,
            by        : 0x2::tx_context::sender(arg5),
            ts        : v0,
        };
        0x2::event::emit<FeeRampSet>(v6);
    }

    fun set_side_reserves<T0>(arg0: &mut AmmMarket<T0>, arg1: u8, arg2: u64, arg3: u64) {
        if (arg1 == 1) {
            arg0.pool.ry = arg2;
            arg0.pool.rn = arg3;
        } else {
            arg0.pool.rn = arg2;
            arg0.pool.ry = arg3;
        };
    }

    public fun sets<T0>(arg0: &AmmMarket<T0>) : u64 {
        arg0.pool.sets
    }

    public fun settle_fees<T0>(arg0: &mut AmmMarket<T0>, arg1: &0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Config, arg2: &mut 0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::CouncilFees, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_v2(arg1);
        check_market<T0>(arg1, arg0);
        0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::check_fees(arg1, arg2);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        try_terminal<T0>(arg1, arg0, v0, 0x2::tx_context::sender(arg4));
        assert!(is_terminal<T0>(arg0), 13875882393748766847);
        assert!(!arg0.fees.settled, 13876163873020575873);
        do_settle<T0>(arg1, arg0, arg2, v0, arg4);
    }

    fun side_balance<T0>(arg0: &Position<T0>, arg1: u8) : u64 {
        if (arg1 == 1) {
            arg0.yes
        } else {
            arg0.no
        }
    }

    fun side_reserves<T0>(arg0: &AmmMarket<T0>, arg1: u8) : (u64, u64) {
        if (arg1 == 1) {
            (arg0.pool.ry, arg0.pool.rn)
        } else {
            (arg0.pool.rn, arg0.pool.ry)
        }
    }

    public fun split_lp_position<T0>(arg0: &mut AmmMarket<T0>, arg1: &0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Config, arg2: &mut LpPosition<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (LpPosition<T0>, 0x2::coin::Coin<T0>) {
        assert_v2(arg1);
        check_market<T0>(arg1, arg0);
        let v0 = 0x2::tx_context::sender(arg5);
        check_lp<T0>(arg0, arg2, v0);
        assert!(arg3 > 0 && arg3 < arg2.shares, 13871096026357301341);
        let v1 = arg0.pool.acc_fee_per_share;
        let v2 = pending_of(arg2.shares, arg2.fee_debt, v1);
        arg2.shares = arg2.shares - arg3;
        arg2.fee_debt = debt_of(arg2.shares, v1);
        let v3 = 0x2::object::id<AmmMarket<T0>>(arg0);
        let v4 = LpPosition<T0>{
            id              : 0x2::object::new(arg5),
            market_id       : v3,
            owner           : v0,
            shares          : arg3,
            fee_debt        : debt_of(arg3, v1),
            locked_until_ms : arg2.locked_until_ms,
        };
        arg0.lp_open = arg0.lp_open + 1;
        let v5 = LpSplit{
            market_id    : v3,
            from_id      : 0x2::object::id<LpPosition<T0>>(arg2),
            new_id       : 0x2::object::id<LpPosition<T0>>(&v4),
            owner        : v0,
            moved_shares : arg3,
            shares       : arg2.shares,
            fees         : v2,
            ts           : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<LpSplit>(v5);
        (v4, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.fees.lp_fees, v2), arg5))
    }

    entry fun split_lp_position_and_keep<T0>(arg0: &mut AmmMarket<T0>, arg1: &0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Config, arg2: &mut LpPosition<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = split_lp_position<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
        keep_lp<T0>(v0, arg5);
        keep_coin<T0>(v1, arg5);
    }

    public fun split_position<T0>(arg0: &mut AmmMarket<T0>, arg1: &0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Config, arg2: &mut Position<T0>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : Position<T0> {
        assert_v2(arg1);
        check_market<T0>(arg1, arg0);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::clock::timestamp_ms(arg5);
        check_position<T0>(arg0, arg2, v0);
        assert!(v1 >= arg2.locked_until_ms, 13879258444203294869);
        assert!(arg3 <= arg2.yes && arg4 <= arg2.no, 13871095674169983069);
        assert!(arg3 + arg4 > 0, 13878414027862704271);
        assert!(arg2.yes - arg3 + arg2.no - arg4 > 0, 13878414032157671567);
        arg2.yes = arg2.yes - arg3;
        arg2.no = arg2.no - arg4;
        let v2 = 0x2::object::id<AmmMarket<T0>>(arg0);
        let v3 = Position<T0>{
            id              : 0x2::object::new(arg6),
            market_id       : v2,
            owner           : v0,
            yes             : arg3,
            no              : arg4,
            locked_until_ms : arg2.locked_until_ms,
        };
        arg0.positions_open = arg0.positions_open + 1;
        let v4 = PositionSplit{
            market_id : v2,
            from_id   : 0x2::object::id<Position<T0>>(arg2),
            new_id    : 0x2::object::id<Position<T0>>(&v3),
            owner     : v0,
            moved_yes : arg3,
            moved_no  : arg4,
            yes       : arg2.yes,
            no        : arg2.no,
            ts        : v1,
        };
        0x2::event::emit<PositionSplit>(v4);
        v3
    }

    entry fun split_position_and_keep<T0>(arg0: &mut AmmMarket<T0>, arg1: &0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Config, arg2: &mut Position<T0>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = split_position<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        keep<T0>(v0, arg6);
    }

    public fun spot_price(arg0: u64, arg1: u64) : u64 {
        (((arg1 as u128) * (1000000000 as u128) / ((arg0 as u128) + (arg1 as u128))) as u64)
    }

    public fun status<T0>(arg0: &AmmMarket<T0>) : u8 {
        arg0.council.status
    }

    public fun status_active() : u8 {
        0
    }

    public fun status_disputed() : u8 {
        7
    }

    public fun status_final() : u8 {
        2
    }

    public fun status_proposed() : u8 {
        6
    }

    public fun status_resolving() : u8 {
        1
    }

    public fun status_revoked() : u8 {
        5
    }

    public fun status_void() : u8 {
        4
    }

    fun sweep<T0>(arg0: &mut AmmMarket<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::withdraw_all<T0>(&mut arg0.pool.collateral);
        let v1 = 0x2::balance::withdraw_all<T0>(&mut arg0.fees.lp_fees);
        let v2 = 0x2::balance::value<T0>(&v0);
        let v3 = 0x2::balance::value<T0>(&v1);
        let v4 = arg0.treasury;
        if (v2 > 0 || v3 > 0) {
            let v5 = DustSwept{
                market_id  : 0x2::object::id<AmmMarket<T0>>(arg0),
                collateral : v2,
                lp_fees    : v3,
                to         : v4,
                by         : arg2,
                ts         : arg1,
            };
            0x2::event::emit<DustSwept>(v5);
        };
        pay_balance<T0>(v0, v4, arg3);
        pay_balance<T0>(v1, v4, arg3);
    }

    public fun sweep_dust<T0>(arg0: &mut AmmMarket<T0>, arg1: &0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Config, arg2: &mut 0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::CouncilFees, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        enter_terminal<T0>(arg1, arg0, arg2, v0, arg4);
        assert!(arg0.positions_open == 0 && arg0.lp_open == 0, 13877853354241687691);
        let v1 = 0x2::tx_context::sender(arg4);
        sweep<T0>(arg0, v0, v1, arg4);
    }

    fun take_fee<T0>(arg0: &mut AmmMarket<T0>, arg1: 0x2::balance::Balance<T0>, arg2: u64) : (u64, u64, u64) {
        let v0 = 0x2::balance::value<T0>(&arg1);
        assert!(v0 >= arg2, 13877011330197880965);
        let (v1, v2, v3) = fee_split(arg2);
        let v4 = v1 + v0 - arg2;
        assert!(v4 + v2 + v3 == v0, 13877011343082782853);
        0x2::balance::join<T0>(&mut arg0.fees.lp_fees, 0x2::balance::split<T0>(&mut arg1, v4));
        0x2::balance::join<T0>(&mut arg0.fees.council_fees, 0x2::balance::split<T0>(&mut arg1, v2));
        assert!(0x2::balance::value<T0>(&arg1) == v3, 13877011355967684741);
        0x2::balance::join<T0>(&mut arg0.fees.treasury_fees, arg1);
        if (v4 > 0) {
            arg0.pool.acc_fee_per_share = arg0.pool.acc_fee_per_share + (((v4 as u256) * 1000000000000000000 / (arg0.pool.lp_total as u256)) as u128);
        };
        (v4, v2, v3)
    }

    fun take_quota(arg0: &mut 0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Config, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = arg2 / 86400000;
        let v1 = 0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::config_uid_mut(arg0);
        let v2 = SeatQuotaKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<SeatQuotaKey>(v1, v2)) {
            let v3 = SeatQuotaKey{dummy_field: false};
            0x2::dynamic_field::add<SeatQuotaKey, 0x2::table::Table<0x2::object::ID, Quota>>(v1, v3, 0x2::table::new<0x2::object::ID, Quota>(arg3));
        };
        let v4 = SeatQuotaKey{dummy_field: false};
        let v5 = 0x2::dynamic_field::borrow_mut<SeatQuotaKey, 0x2::table::Table<0x2::object::ID, Quota>>(v1, v4);
        if (!0x2::table::contains<0x2::object::ID, Quota>(v5, arg1)) {
            let v6 = Quota{
                day   : v0,
                count : 0,
            };
            0x2::table::add<0x2::object::ID, Quota>(v5, arg1, v6);
        };
        let v7 = 0x2::table::borrow_mut<0x2::object::ID, Quota>(v5, arg1);
        if (v7.day != v0) {
            v7.day = v0;
            v7.count = 0;
        };
        assert!(v7.count < 3, 13866036069548949561);
        v7.count = v7.count + 1;
    }

    public fun threshold<T0>(arg0: &AmmMarket<T0>) : u64 {
        arg0.council.threshold
    }

    public fun treasury_fees_value<T0>(arg0: &AmmMarket<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.fees.treasury_fees)
    }

    fun try_finalize<T0>(arg0: &0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Config, arg1: &mut AmmMarket<T0>, arg2: u64, arg3: address) : bool {
        let v0 = arg1.council.status;
        if (v0 == 1 && arg2 >= arg1.council.resolved_ms + arg1.schedule.dispute_window_ms) {
            let v1 = arg1.council.outcome;
            conclude<T0>(arg1, v1, arg2, arg3);
            return true
        };
        if (v0 == 6 && arg2 >= arg1.appeal.proposed_ms + 21600000) {
            let v2 = arg1.appeal.proposed;
            conclude<T0>(arg1, v2, arg2, arg3);
            return true
        };
        let v3 = arg1.appeal.disputed_ms + 259200000;
        if (v0 == 7 && arg2 >= v3) {
            let (_, v5, v6, _) = seat_counts<T0>(arg0, arg1, v3);
            let (v8, v9) = lapse_revoked_dissent<T0>(arg0, arg1, v3);
            let v10 = if (v6 > 0) {
                true
            } else if (v5 < arg1.council.threshold) {
                true
            } else {
                v8 > 0 && v9 + v8 >= arg1.council.threshold
            };
            if (v10) {
                arg1.appeal.verdict = 1;
                enter_refund<T0>(arg1, 4);
                emit_voided<T0>(arg1, 4, arg2, arg3);
                return true
            };
            arg1.appeal.verdict = 3;
            let v11 = arg1.appeal.proposed;
            let v12 = AmmAppealLapsed{
                market_id : 0x2::object::id<AmmMarket<T0>>(arg1),
                proposed  : v11,
                disputer  : arg1.appeal.disputer,
                bond      : 0x2::balance::value<T0>(&arg1.appeal.bond),
                by        : arg3,
                ts        : arg2,
            };
            0x2::event::emit<AmmAppealLapsed>(v12);
            conclude<T0>(arg1, v11, arg2, arg3);
            return true
        };
        false
    }

    fun try_terminal<T0>(arg0: &0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Config, arg1: &mut AmmMarket<T0>, arg2: u64, arg3: address) {
        let v0 = try_finalize<T0>(arg0, arg1, arg2, arg3);
        if (!v0) {
            try_void<T0>(arg1, arg2, arg3);
        };
    }

    fun try_void<T0>(arg0: &mut AmmMarket<T0>, arg1: u64, arg2: address) : bool {
        if (arg0.council.status == 0 && arg1 >= arg0.schedule.void_at_ms) {
            enter_refund<T0>(arg0, 4);
            emit_voided<T0>(arg0, 2, arg1, arg2);
            return true
        };
        false
    }

    fun usable_seats<T0>(arg0: &0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Config, arg1: &AmmMarket<T0>) : u64 {
        let v0 = &arg1.council.committee;
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Seat>(v0)) {
            let v3 = 0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::seat_cap_id(0x1::vector::borrow<0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Seat>(v0, v2));
            let v4 = if (!0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::is_revoked(arg0, v3)) {
                if (!0x1::option::contains<0x2::object::ID>(&arg1.council.creator_seat, &v3)) {
                    !0x1::option::contains<0x2::object::ID>(&arg1.appeal.admin_seat, &v3)
                } else {
                    false
                }
            } else {
                false
            };
            if (v4) {
                v1 = v1 + 1;
            };
            v2 = v2 + 1;
        };
        v1
    }

    public fun void_at_ms<T0>(arg0: &AmmMarket<T0>) : u64 {
        arg0.schedule.void_at_ms
    }

    public fun void_market<T0>(arg0: &mut AmmMarket<T0>, arg1: &0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Config, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert_v2(arg1);
        check_market<T0>(arg1, arg0);
        assert!(try_void<T0>(arg0, 0x2::clock::timestamp_ms(arg2), 0x2::tx_context::sender(arg3)), 13875319362190704763);
    }

    public fun vote<T0>(arg0: &mut AmmMarket<T0>, arg1: &0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::CouncilCap, arg2: &0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Config, arg3: u8, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert_v2(arg2);
        check_market<T0>(arg2, arg0);
        let v0 = arg0.council.status;
        let v1 = v0 == 7;
        assert!(v1 || v0 == 0, 13871941190022201443);
        let v2 = if (arg3 == 1) {
            true
        } else if (arg3 == 2) {
            true
        } else {
            arg3 == 3
        };
        assert!(v2, 13873348569201377389);
        let v3 = 0x2::clock::timestamp_ms(arg4);
        if (v1) {
            assert!(v3 < arg0.appeal.disputed_ms + 259200000, 13880948406460874913);
        } else {
            assert!(v3 >= arg0.schedule.close_ms, 13872222690768846949);
            assert!(v3 >= arg0.schedule.resolve_by_ms, 13880666944368935071);
            assert!(v3 < arg0.schedule.void_at_ms, 13872504174335623271);
        };
        let v4 = 0x2::tx_context::sender(arg5);
        assert!(v4 == 0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::cap_holder(arg1), 13865185837822640179);
        let v5 = 0x2::object::id<0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::CouncilCap>(arg1);
        let (v6, v7) = 0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::seats_index(&arg0.council.committee, v5);
        assert!(v6, 13872785675082268777);
        assert!(!0x1::option::contains<0x2::object::ID>(&arg0.council.creator_seat, &v5), 13873630104307761263);
        assert!(!v1 || !0x1::option::contains<0x2::object::ID>(&arg0.appeal.admin_seat, &v5), 13882918782838374575);
        assert!(*0x1::vector::borrow<u8>(&arg0.council.votes, v7) == 0, 13873067162944012395);
        assert!(!0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::is_revoked(arg2, v5), 13865748817841094711);
        *0x1::vector::borrow_mut<u8>(&mut arg0.council.votes, v7) = arg3;
        let v8 = 0x2::object::id<AmmMarket<T0>>(arg0);
        let v9 = AmmVoteCast{
            market_id : v8,
            member    : v4,
            cap_id    : v5,
            outcome   : arg3,
            appeal    : v1,
            ts        : v3,
        };
        0x2::event::emit<AmmVoteCast>(v9);
        if (count_votes<T0>(arg2, arg0, arg3) >= arg0.council.threshold) {
            if (v1) {
                let v10 = arg0.appeal.proposed;
                let v11 = arg3 != v10;
                let v12 = if (v11) {
                    2
                } else {
                    3
                };
                arg0.appeal.verdict = v12;
                let v13 = AmmAppealDecided{
                    market_id  : v8,
                    outcome    : arg3,
                    proposed   : v10,
                    overturned : v11,
                    by         : v4,
                    cap_id     : v5,
                    ts         : v3,
                };
                0x2::event::emit<AmmAppealDecided>(v13);
                conclude<T0>(arg0, arg3, v3, v4);
            } else {
                arg0.council.status = 1;
                arg0.council.outcome = arg3;
                arg0.council.resolved_ms = v3;
                let v14 = AmmResolved{
                    market_id       : v8,
                    outcome         : arg3,
                    by              : v4,
                    cap_id          : v5,
                    resolved_ms     : v3,
                    finalizes_at_ms : v3 + arg0.schedule.dispute_window_ms,
                };
                0x2::event::emit<AmmResolved>(v14);
            };
        };
    }

    public fun votes<T0>(arg0: &AmmMarket<T0>) : vector<u8> {
        arg0.council.votes
    }

    public fun withdraw_lp<T0>(arg0: &mut AmmMarket<T0>, arg1: &0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Config, arg2: &mut 0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::CouncilFees, arg3: LpPosition<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = 0x2::tx_context::sender(arg5);
        enter_terminal<T0>(arg1, arg0, arg2, v0, arg5);
        check_lp<T0>(arg0, &arg3, v1);
        let LpPosition {
            id              : v2,
            market_id       : _,
            owner           : _,
            shares          : v5,
            fee_debt        : v6,
            locked_until_ms : _,
        } = arg3;
        0x2::object::delete(v2);
        let v8 = pending_of(v5, v6, arg0.pool.acc_fee_per_share);
        let v9 = arg0.pool.lp_total;
        let v10 = mul_div(arg0.pool.ry, v5, v9);
        let v11 = mul_div(arg0.pool.rn, v5, v9);
        arg0.pool.ry = arg0.pool.ry - v10;
        arg0.pool.rn = arg0.pool.rn - v11;
        arg0.pool.lp_total = v9 - v5;
        arg0.lp_open = arg0.lp_open - 1;
        let v12 = arg0.payout_price;
        let v13 = payout_value(v10, v11, v12);
        let v14 = 0x2::balance::split<T0>(&mut arg0.pool.collateral, v13);
        0x2::balance::join<T0>(&mut v14, 0x2::balance::split<T0>(&mut arg0.fees.lp_fees, v8));
        let v15 = LpWithdrawn{
            market_id    : 0x2::object::id<AmmMarket<T0>>(arg0),
            lp_id        : 0x2::object::id<LpPosition<T0>>(&arg3),
            owner        : v1,
            shares       : v5,
            take_yes     : v10,
            take_no      : v11,
            refund       : is_refund<T0>(arg0),
            value        : v13,
            fees         : v8,
            payout_price : v12,
            ts           : v0,
        };
        0x2::event::emit<LpWithdrawn>(v15);
        if (arg0.lp_open == 0) {
            pay_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.fees.lp_fees), arg0.treasury, arg5);
        };
        maybe_sweep<T0>(arg0, v0, v1, arg5);
        0x2::coin::from_balance<T0>(v14, arg5)
    }

    entry fun withdraw_lp_and_keep<T0>(arg0: &mut AmmMarket<T0>, arg1: &0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::Config, arg2: &mut 0xa9ec5f80d0a4e04dbe1335b6ad4bcaaa0db9b3f8bc17b7428dfe7058ad5d2b0f::predict::CouncilFees, arg3: LpPosition<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = withdraw_lp<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
        keep_coin<T0>(v0, arg5);
    }

    fun zero_votes(arg0: u64) : vector<u8> {
        let v0 = b"";
        let v1 = 0;
        while (v1 < arg0) {
            0x1::vector::push_back<u8>(&mut v0, 0);
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v7
}

