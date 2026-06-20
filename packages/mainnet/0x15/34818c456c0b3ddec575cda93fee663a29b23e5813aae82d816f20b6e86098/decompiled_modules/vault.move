module 0x1534818c456c0b3ddec575cda93fee663a29b23e5813aae82d816f20b6e86098::vault {
    struct StakeKey has copy, drop, store {
        outcome: u64,
        bettor: address,
    }

    struct Market<phantom T0> has key {
        id: 0x2::object::UID,
        outcome_count: u64,
        fee_bps: u64,
        deadline_ms: u64,
        escrow: 0x2::balance::Balance<T0>,
        net_pool: u64,
        fee_accrued: u64,
        participant_count: u64,
        outcome_pool: 0x2::table::Table<u64, u64>,
        stake_of: 0x2::table::Table<StakeKey, u64>,
        gross_of: 0x2::table::Table<address, u64>,
        claimed: 0x2::table::Table<address, bool>,
        resolved: 0x1::option::Option<u64>,
        resolved_at_ms: u64,
        evidence_hash: vector<u8>,
        treasury: address,
        treasury_swept: bool,
    }

    struct OperatorCap has store, key {
        id: 0x2::object::UID,
    }

    struct MarketCreated has copy, drop {
        market: 0x2::object::ID,
        outcome_count: u64,
        fee_bps: u64,
        deadline_ms: u64,
    }

    struct BetPlaced has copy, drop {
        market: 0x2::object::ID,
        bettor: address,
        outcome: u64,
        gross: u64,
        net: u64,
        fee: u64,
    }

    struct MarketResolved has copy, drop {
        market: 0x2::object::ID,
        winning_outcome: u64,
        evidence_hash: vector<u8>,
    }

    struct Claimed has copy, drop {
        market: 0x2::object::ID,
        bettor: address,
        amount: u64,
        refund: bool,
    }

    struct TreasurySwept has copy, drop {
        market: 0x2::object::ID,
        amount: u64,
    }

    struct ResidualSwept has copy, drop {
        market: 0x2::object::ID,
        amount: u64,
    }

    fun add_stake(arg0: &mut 0x2::table::Table<StakeKey, u64>, arg1: StakeKey, arg2: u64) {
        if (0x2::table::contains<StakeKey, u64>(arg0, arg1)) {
            let v0 = 0x2::table::borrow_mut<StakeKey, u64>(arg0, arg1);
            *v0 = *v0 + arg2;
        } else {
            0x2::table::add<StakeKey, u64>(arg0, arg1, arg2);
        };
    }

    fun add_u64(arg0: &mut 0x2::table::Table<u64, u64>, arg1: u64, arg2: u64) {
        if (0x2::table::contains<u64, u64>(arg0, arg1)) {
            let v0 = 0x2::table::borrow_mut<u64, u64>(arg0, arg1);
            *v0 = *v0 + arg2;
        } else {
            0x2::table::add<u64, u64>(arg0, arg1, arg2);
        };
    }

    public fun bet<T0>(arg0: &mut Market<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_none<u64>(&arg0.resolved), 1);
        assert!(0x2::clock::timestamp_ms(arg3) < arg0.deadline_ms, 2);
        assert!(arg2 < arg0.outcome_count, 3);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 >= 500000 && v0 <= 10000000, 4);
        let v1 = v0 * arg0.fee_bps / 10000;
        let v2 = v0 - v1;
        let v3 = 0x2::tx_context::sender(arg4);
        0x2::balance::join<T0>(&mut arg0.escrow, 0x2::coin::into_balance<T0>(arg1));
        arg0.net_pool = arg0.net_pool + v2;
        arg0.fee_accrued = arg0.fee_accrued + v1;
        let v4 = &mut arg0.outcome_pool;
        add_u64(v4, arg2, v2);
        let v5 = &mut arg0.stake_of;
        let v6 = StakeKey{
            outcome : arg2,
            bettor  : v3,
        };
        add_stake(v5, v6, v2);
        if (0x2::table::contains<address, u64>(&arg0.gross_of, v3)) {
            let v7 = 0x2::table::borrow_mut<address, u64>(&mut arg0.gross_of, v3);
            *v7 = *v7 + v0;
        } else {
            0x2::table::add<address, u64>(&mut arg0.gross_of, v3, v0);
            arg0.participant_count = arg0.participant_count + 1;
        };
        let v8 = BetPlaced{
            market  : 0x2::object::id<Market<T0>>(arg0),
            bettor  : v3,
            outcome : arg2,
            gross   : v0,
            net     : v2,
            fee     : v1,
        };
        0x2::event::emit<BetPlaced>(v8);
    }

    public fun claim<T0>(arg0: &mut Market<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        claim_internal<T0>(arg0, v0, arg1);
    }

    public fun claim_for<T0>(arg0: &mut Market<T0>, arg1: &OperatorCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        claim_internal<T0>(arg0, arg2, arg3);
    }

    fun claim_internal<T0>(arg0: &mut Market<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<u64>(&arg0.resolved), 7);
        assert!(!is_claimed<T0>(arg0, arg1), 5);
        let v0 = payout_of<T0>(arg0, arg1);
        assert!(v0 > 0, 6);
        0x2::table::add<address, bool>(&mut arg0.claimed, arg1, true);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.escrow, v0, arg2), arg1);
        let v1 = Claimed{
            market : 0x2::object::id<Market<T0>>(arg0),
            bettor : arg1,
            amount : v0,
            refund : arg0.participant_count == 1,
        };
        0x2::event::emit<Claimed>(v1);
    }

    public fun create_market<T0>(arg0: &OperatorCap, arg1: u64, arg2: u64, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 >= 2, 9);
        assert!(arg2 < 10000, 9);
        let v0 = Market<T0>{
            id                : 0x2::object::new(arg5),
            outcome_count     : arg1,
            fee_bps           : arg2,
            deadline_ms       : arg3,
            escrow            : 0x2::balance::zero<T0>(),
            net_pool          : 0,
            fee_accrued       : 0,
            participant_count : 0,
            outcome_pool      : 0x2::table::new<u64, u64>(arg5),
            stake_of          : 0x2::table::new<StakeKey, u64>(arg5),
            gross_of          : 0x2::table::new<address, u64>(arg5),
            claimed           : 0x2::table::new<address, bool>(arg5),
            resolved          : 0x1::option::none<u64>(),
            resolved_at_ms    : 0,
            evidence_hash     : b"",
            treasury          : arg4,
            treasury_swept    : false,
        };
        let v1 = MarketCreated{
            market        : 0x2::object::id<Market<T0>>(&v0),
            outcome_count : arg1,
            fee_bps       : arg2,
            deadline_ms   : arg3,
        };
        0x2::event::emit<MarketCreated>(v1);
        0x2::transfer::share_object<Market<T0>>(v0);
    }

    public fun deadline_ms<T0>(arg0: &Market<T0>) : u64 {
        arg0.deadline_ms
    }

    public fun escrow_value<T0>(arg0: &Market<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.escrow)
    }

    public fun evidence_hash<T0>(arg0: &Market<T0>) : vector<u8> {
        arg0.evidence_hash
    }

    public fun fee_accrued<T0>(arg0: &Market<T0>) : u64 {
        arg0.fee_accrued
    }

    public fun fee_bps<T0>(arg0: &Market<T0>) : u64 {
        arg0.fee_bps
    }

    public fun gross_of_bettor<T0>(arg0: &Market<T0>, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.gross_of, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.gross_of, arg1)
        } else {
            0
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OperatorCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<OperatorCap>(v0, 0x2::tx_context::sender(arg0));
    }

    fun is_claimed<T0>(arg0: &Market<T0>, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.claimed, arg1) && *0x2::table::borrow<address, bool>(&arg0.claimed, arg1)
    }

    public fun is_resolved<T0>(arg0: &Market<T0>) : bool {
        0x1::option::is_some<u64>(&arg0.resolved)
    }

    public fun net_pool<T0>(arg0: &Market<T0>) : u64 {
        arg0.net_pool
    }

    public fun outcome_count<T0>(arg0: &Market<T0>) : u64 {
        arg0.outcome_count
    }

    public fun outcome_pool_of<T0>(arg0: &Market<T0>, arg1: u64) : u64 {
        if (0x2::table::contains<u64, u64>(&arg0.outcome_pool, arg1)) {
            *0x2::table::borrow<u64, u64>(&arg0.outcome_pool, arg1)
        } else {
            0
        }
    }

    public fun participant_count<T0>(arg0: &Market<T0>) : u64 {
        arg0.participant_count
    }

    public fun payout_of<T0>(arg0: &Market<T0>, arg1: address) : u64 {
        if (0x1::option::is_none<u64>(&arg0.resolved)) {
            return 0
        };
        if (is_claimed<T0>(arg0, arg1)) {
            return 0
        };
        if (arg0.participant_count == 1) {
            return gross_of_bettor<T0>(arg0, arg1)
        };
        let v0 = *0x1::option::borrow<u64>(&arg0.resolved);
        let v1 = outcome_pool_of<T0>(arg0, v0);
        if (v1 == 0) {
            return 0
        };
        let v2 = stake_of_outcome<T0>(arg0, v0, arg1);
        if (v2 == 0) {
            return 0
        };
        (((arg0.net_pool as u128) * (v2 as u128) / (v1 as u128)) as u64)
    }

    public fun residual_grace_ms() : u64 {
        31536000000
    }

    public fun resolve<T0>(arg0: &mut Market<T0>, arg1: &OperatorCap, arg2: u64, arg3: vector<u8>, arg4: &0x2::tx_context::TxContext) {
        assert!(0x1::option::is_none<u64>(&arg0.resolved), 1);
        assert!(arg2 < arg0.outcome_count, 3);
        arg0.resolved = 0x1::option::some<u64>(arg2);
        arg0.resolved_at_ms = 0x2::tx_context::epoch_timestamp_ms(arg4);
        arg0.evidence_hash = arg3;
        let v0 = MarketResolved{
            market          : 0x2::object::id<Market<T0>>(arg0),
            winning_outcome : arg2,
            evidence_hash   : arg3,
        };
        0x2::event::emit<MarketResolved>(v0);
    }

    public fun resolved_at_ms<T0>(arg0: &Market<T0>) : u64 {
        arg0.resolved_at_ms
    }

    public fun stake_of_outcome<T0>(arg0: &Market<T0>, arg1: u64, arg2: address) : u64 {
        let v0 = StakeKey{
            outcome : arg1,
            bettor  : arg2,
        };
        if (0x2::table::contains<StakeKey, u64>(&arg0.stake_of, v0)) {
            *0x2::table::borrow<StakeKey, u64>(&arg0.stake_of, v0)
        } else {
            0
        }
    }

    public fun sweep_residual<T0>(arg0: &mut Market<T0>, arg1: &OperatorCap, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<u64>(&arg0.resolved), 7);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg0.resolved_at_ms + 31536000000, 10);
        let v0 = 0x2::balance::value<T0>(&arg0.escrow);
        assert!(v0 > 0, 6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.escrow, v0, arg3), arg0.treasury);
        let v1 = ResidualSwept{
            market : 0x2::object::id<Market<T0>>(arg0),
            amount : v0,
        };
        0x2::event::emit<ResidualSwept>(v1);
    }

    public fun sweep_treasury<T0>(arg0: &mut Market<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<u64>(&arg0.resolved), 7);
        assert!(!arg0.treasury_swept, 8);
        assert!(arg0.participant_count > 1, 6);
        let v0 = arg0.fee_accrued;
        let v1 = v0;
        if (outcome_pool_of<T0>(arg0, *0x1::option::borrow<u64>(&arg0.resolved)) == 0) {
            v1 = v0 + arg0.net_pool;
        };
        assert!(v1 > 0, 6);
        arg0.treasury_swept = true;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.escrow, v1, arg1), arg0.treasury);
        let v2 = TreasurySwept{
            market : 0x2::object::id<Market<T0>>(arg0),
            amount : v1,
        };
        0x2::event::emit<TreasurySwept>(v2);
    }

    public fun treasury<T0>(arg0: &Market<T0>) : address {
        arg0.treasury
    }

    public fun winning_outcome<T0>(arg0: &Market<T0>) : u64 {
        assert!(0x1::option::is_some<u64>(&arg0.resolved), 7);
        *0x1::option::borrow<u64>(&arg0.resolved)
    }

    // decompiled from Move bytecode v7
}

