module 0x298f714144788755ad494a2238c6972189bf610c03794d4ee964dceef7a51d2b::kiai_vault {
    struct OperatorCap has store, key {
        id: 0x2::object::UID,
    }

    struct KIAIVaultRegistry has store, key {
        id: 0x2::object::UID,
        operator: address,
        fee_rate_bps: u64,
        accumulated_fees: u64,
    }

    struct Market<phantom T0> has key {
        id: 0x2::object::UID,
        market_id_bytes: vector<u8>,
        status: u8,
        winning_outcome_id: vector<u8>,
        total_winning_shares: u64,
        total_collateral_snapshot: u64,
        collateral: 0x2::balance::Balance<T0>,
        positions: 0x2::object_table::ObjectTable<address, Position>,
    }

    struct Position has store, key {
        id: 0x2::object::UID,
        usdc_deposited: u64,
        shares: u64,
        outcome_id: vector<u8>,
        claimed: bool,
    }

    struct MarketCreatedEvent has copy, drop {
        market_id_bytes: vector<u8>,
    }

    struct MarketClosedEvent has copy, drop {
        market_id_bytes: vector<u8>,
    }

    struct MarketResolvedEvent has copy, drop {
        market_id_bytes: vector<u8>,
        winning_outcome_id: vector<u8>,
        winning_outcome_slug: vector<u8>,
    }

    struct MarketCancelledEvent has copy, drop {
        market_id_bytes: vector<u8>,
    }

    struct PositionOpenedEvent has copy, drop {
        market_id_bytes: vector<u8>,
        user: address,
        outcome_id: vector<u8>,
        outcome_slug: vector<u8>,
        usdc_deposited: u64,
        shares: u64,
    }

    struct WingsClaimedEvent has copy, drop {
        market_id_bytes: vector<u8>,
        user: address,
        usdc_claimed: u64,
    }

    struct RefundedEvent has copy, drop {
        market_id_bytes: vector<u8>,
        user: address,
        usdc_refunded: u64,
    }

    public fun cancel_market<T0>(arg0: &OperatorCap, arg1: &mut Market<T0>) {
        assert!(arg1.status == 0 || arg1.status == 1, 1);
        arg1.status = 3;
        let v0 = MarketCancelledEvent{market_id_bytes: arg1.market_id_bytes};
        0x2::event::emit<MarketCancelledEvent>(v0);
    }

    public fun claim_winnings<T0>(arg0: &mut Market<T0>, arg1: &mut KIAIVaultRegistry, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.status == 2, 3);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::object_table::contains<address, Position>(&arg0.positions, v0), 7);
        let v1 = 0x2::object_table::borrow_mut<address, Position>(&mut arg0.positions, v0);
        assert!(!v1.claimed, 6);
        assert!(v1.outcome_id == arg0.winning_outcome_id, 5);
        v1.claimed = true;
        let v2 = (((v1.shares as u128) * (arg0.total_collateral_snapshot as u128) / (arg0.total_winning_shares as u128)) as u64);
        let v3 = v2 * arg1.fee_rate_bps / 10000;
        let v4 = v2 - v3;
        arg1.accumulated_fees = arg1.accumulated_fees + v3;
        let v5 = WingsClaimedEvent{
            market_id_bytes : arg0.market_id_bytes,
            user            : v0,
            usdc_claimed    : v4,
        };
        0x2::event::emit<WingsClaimedEvent>(v5);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.collateral, v4), arg2)
    }

    public fun close_market<T0>(arg0: &OperatorCap, arg1: &mut Market<T0>) {
        assert!(arg1.status == 0, 1);
        arg1.status = 1;
        let v0 = MarketClosedEvent{market_id_bytes: arg1.market_id_bytes};
        0x2::event::emit<MarketClosedEvent>(v0);
    }

    public fun create_market<T0>(arg0: &OperatorCap, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Market<T0>{
            id                        : 0x2::object::new(arg2),
            market_id_bytes           : arg1,
            status                    : 0,
            winning_outcome_id        : b"",
            total_winning_shares      : 0,
            total_collateral_snapshot : 0,
            collateral                : 0x2::balance::zero<T0>(),
            positions                 : 0x2::object_table::new<address, Position>(arg2),
        };
        let v1 = MarketCreatedEvent{market_id_bytes: v0.market_id_bytes};
        0x2::event::emit<MarketCreatedEvent>(v1);
        0x2::transfer::share_object<Market<T0>>(v0);
    }

    public fun deposit<T0>(arg0: &mut Market<T0>, arg1: vector<u8>, arg2: vector<u8>, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0, 1);
        let v0 = 0x2::coin::value<T0>(&arg3);
        assert!(v0 > 0, 8);
        assert!(arg4 > 0, 9);
        assert!(!0x1::vector::is_empty<u8>(&arg1), 8);
        let v1 = 0x2::tx_context::sender(arg5);
        0x2::balance::join<T0>(&mut arg0.collateral, 0x2::coin::into_balance<T0>(arg3));
        if (0x2::object_table::contains<address, Position>(&arg0.positions, v1)) {
            let v2 = 0x2::object_table::borrow_mut<address, Position>(&mut arg0.positions, v1);
            assert!(!v2.claimed, 6);
            assert!(v2.outcome_id == arg1, 11);
            v2.usdc_deposited = v2.usdc_deposited + v0;
            v2.shares = v2.shares + arg4;
        } else {
            let v3 = Position{
                id             : 0x2::object::new(arg5),
                usdc_deposited : v0,
                shares         : arg4,
                outcome_id     : arg1,
                claimed        : false,
            };
            0x2::object_table::add<address, Position>(&mut arg0.positions, v1, v3);
        };
        let v4 = PositionOpenedEvent{
            market_id_bytes : arg0.market_id_bytes,
            user            : v1,
            outcome_id      : arg1,
            outcome_slug    : arg2,
            usdc_deposited  : v0,
            shares          : arg4,
        };
        0x2::event::emit<PositionOpenedEvent>(v4);
    }

    public fun get_market_status<T0>(arg0: &Market<T0>) : u8 {
        arg0.status
    }

    public fun get_position_deposited<T0>(arg0: &Market<T0>, arg1: address) : u64 {
        if (!0x2::object_table::contains<address, Position>(&arg0.positions, arg1)) {
            return 0
        };
        0x2::object_table::borrow<address, Position>(&arg0.positions, arg1).usdc_deposited
    }

    public fun get_position_shares<T0>(arg0: &Market<T0>, arg1: address) : u64 {
        if (!0x2::object_table::contains<address, Position>(&arg0.positions, arg1)) {
            return 0
        };
        0x2::object_table::borrow<address, Position>(&arg0.positions, arg1).shares
    }

    public fun get_total_collateral<T0>(arg0: &Market<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.collateral)
    }

    public fun get_winning_outcome<T0>(arg0: &Market<T0>) : vector<u8> {
        arg0.winning_outcome_id
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OperatorCap{id: 0x2::object::new(arg0)};
        let v1 = KIAIVaultRegistry{
            id               : 0x2::object::new(arg0),
            operator         : 0x2::tx_context::sender(arg0),
            fee_rate_bps     : 0,
            accumulated_fees : 0,
        };
        0x2::transfer::transfer<OperatorCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<KIAIVaultRegistry>(v1);
    }

    public fun is_claimed<T0>(arg0: &Market<T0>, arg1: address) : bool {
        if (!0x2::object_table::contains<address, Position>(&arg0.positions, arg1)) {
            return false
        };
        0x2::object_table::borrow<address, Position>(&arg0.positions, arg1).claimed
    }

    public fun refund<T0>(arg0: &mut Market<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.status == 3, 4);
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::object_table::contains<address, Position>(&arg0.positions, v0), 7);
        let v1 = 0x2::object_table::borrow_mut<address, Position>(&mut arg0.positions, v0);
        assert!(!v1.claimed, 6);
        assert!(v1.usdc_deposited > 0, 7);
        v1.claimed = true;
        let v2 = v1.usdc_deposited;
        let v3 = RefundedEvent{
            market_id_bytes : arg0.market_id_bytes,
            user            : v0,
            usdc_refunded   : v2,
        };
        0x2::event::emit<RefundedEvent>(v3);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.collateral, v2), arg1)
    }

    public fun resolve_market<T0>(arg0: &OperatorCap, arg1: &mut Market<T0>, arg2: vector<u8>, arg3: vector<u8>, arg4: u64) {
        assert!(arg1.status == 0 || arg1.status == 1, 12);
        assert!(!0x1::vector::is_empty<u8>(&arg2), 12);
        assert!(arg4 > 0, 9);
        arg1.status = 2;
        arg1.winning_outcome_id = arg2;
        arg1.total_winning_shares = arg4;
        arg1.total_collateral_snapshot = 0x2::balance::value<T0>(&arg1.collateral);
        let v0 = MarketResolvedEvent{
            market_id_bytes      : arg1.market_id_bytes,
            winning_outcome_id   : arg1.winning_outcome_id,
            winning_outcome_slug : arg3,
        };
        0x2::event::emit<MarketResolvedEvent>(v0);
    }

    public fun set_fee_rate(arg0: &OperatorCap, arg1: &mut KIAIVaultRegistry, arg2: u64) {
        assert!(arg2 <= 500, 0);
        arg1.fee_rate_bps = arg2;
    }

    public fun withdraw_fees<T0>(arg0: &OperatorCap, arg1: &mut KIAIVaultRegistry, arg2: &mut Market<T0>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
    }

    // decompiled from Move bytecode v7
}

