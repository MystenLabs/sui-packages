module 0xbe26672e7078d5323bbc9217667f6cb86c3a8abf1b4257b5a538aa956054fe25::numperps {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct KeeperCap has store, key {
        id: 0x2::object::UID,
    }

    struct MarketParams has copy, drop, store {
        max_leverage_x100: u64,
        min_size: u64,
        max_oi_long: u64,
        max_oi_short: u64,
        base_spread_bps: u64,
        vol_spread_bps: u64,
        max_spread_bps: u64,
        depth_1pct: u64,
        funding_max_bps_day: u64,
        borrow_bps_day: u64,
        open_fee_bps: u64,
        close_fee_bps: u64,
        liq_threshold_bps: u64,
        liq_reward_bps: u64,
        max_profit_bps: u64,
        max_price_age_ms: u64,
        open_delay_ms: u64,
        close_delay_ms: u64,
        max_dev_bps: u64,
        order_timeout_ms: u64,
        unlock_lp: u64,
        max_oi_share_bps: u64,
    }

    struct Market has store {
        feed: 0x2::object::ID,
        feed_key: 0x1::string::String,
        symbol: 0x1::string::String,
        status: u8,
        base: MarketParams,
        params: MarketParams,
        oi_long: u64,
        oi_short: u64,
        units_long: u256,
        units_short: u256,
        collateral: u64,
        reserved: u64,
        acc_borrow: u256,
        acc_paid_long: u256,
        acc_recv_long: u256,
        acc_paid_short: u256,
        acc_recv_short: u256,
        borrow_weighted: u256,
        last_accrue_ms: u64,
    }

    struct PosKey has copy, drop, store {
        owner: address,
        market: 0x2::object::ID,
        is_long: bool,
    }

    struct Position has copy, drop, store {
        owner: address,
        market: 0x2::object::ID,
        is_long: bool,
        size: u64,
        collateral: u64,
        units: u256,
        entry_px: u64,
        reserved: u64,
        acc_borrow: u256,
        acc_paid: u256,
        acc_recv: u256,
        tp: u64,
        sl: u64,
        tpsl_ms: u64,
        opened_ms: u64,
    }

    struct Order has copy, drop, store {
        id: u64,
        owner: address,
        market: 0x2::object::ID,
        kind: u8,
        is_long: bool,
        collateral: u64,
        leverage_x100: u64,
        size_delta: u64,
        acceptable_px: u64,
        tp: u64,
        sl: u64,
        placed_ms: u64,
        ref_px: u64,
    }

    struct Withdrawal has copy, drop, store {
        shares: u64,
        unlock_ms: u64,
    }

    struct Vault<phantom T0> has key {
        id: 0x2::object::UID,
        cash: 0x2::balance::Balance<T0>,
        oracle_registry: 0x2::object::ID,
        treasury: address,
        paused: bool,
        markets: 0x2::table::Table<0x2::object::ID, Market>,
        market_ids: vector<0x2::object::ID>,
        positions: 0x2::table::Table<PosKey, Position>,
        orders: 0x2::table::Table<u64, Order>,
        next_order: u64,
        collateral_total: u64,
        pending_total: u64,
        protocol_fees: u64,
        protocol_share_bps: u64,
        reserved_total: u64,
        util_cap_bps: u64,
        shares: 0x2::table::Table<address, u64>,
        total_shares: u64,
        withdrawals: 0x2::table::Table<address, Withdrawal>,
        cooldown_ms: u64,
        lp_fee_income: u64,
        lp_borrow_income: u64,
        boost_end_ms: u64,
        boost_assets: u64,
    }

    struct NavCheck {
        vault: 0x2::object::ID,
        next: u64,
        plus: u256,
        minus: u256,
    }

    struct VaultCreated has copy, drop {
        vault: 0x2::object::ID,
        oracle_registry: 0x2::object::ID,
        treasury: address,
    }

    struct MarketAdded has copy, drop {
        vault: 0x2::object::ID,
        market: 0x2::object::ID,
        feed_key: 0x1::string::String,
        symbol: 0x1::string::String,
    }

    struct MarketParamsSet has copy, drop {
        vault: 0x2::object::ID,
        market: 0x2::object::ID,
        params: MarketParams,
        by_keeper: bool,
    }

    struct MarketStatusSet has copy, drop {
        vault: 0x2::object::ID,
        market: 0x2::object::ID,
        status: u8,
    }

    struct OrderPlaced has copy, drop {
        vault: 0x2::object::ID,
        id: u64,
        owner: address,
        market: 0x2::object::ID,
        kind: u8,
        is_long: bool,
        collateral: u64,
        leverage_x100: u64,
        size_delta: u64,
        acceptable_px: u64,
        placed_ms: u64,
        ref_px: u64,
    }

    struct OrderFilled has copy, drop {
        vault: 0x2::object::ID,
        id: u64,
        owner: address,
        market: 0x2::object::ID,
        kind: u8,
        is_long: bool,
        px: u64,
        px_ts_ms: u64,
        exec_px: u64,
        size: u64,
        fee: u64,
    }

    struct OrderCancelled has copy, drop {
        vault: 0x2::object::ID,
        id: u64,
        owner: address,
        market: 0x2::object::ID,
        reason: u8,
        refund: u64,
    }

    struct PositionUpdated has copy, drop {
        vault: 0x2::object::ID,
        owner: address,
        market: 0x2::object::ID,
        is_long: bool,
        size: u64,
        collateral: u64,
        entry_px: u64,
        tp: u64,
        sl: u64,
    }

    struct PositionClosed has copy, drop {
        vault: 0x2::object::ID,
        owner: address,
        market: 0x2::object::ID,
        is_long: bool,
        reason: u8,
        px: u64,
        exec_px: u64,
        size: u64,
        profit: u64,
        loss: u64,
        fee: u64,
        payout: u64,
        remaining_size: u64,
    }

    struct FeesSettled has copy, drop {
        vault: 0x2::object::ID,
        owner: address,
        market: 0x2::object::ID,
        is_long: bool,
        borrow: u64,
        funding_paid: u64,
        funding_received: u64,
    }

    struct Liquidated has copy, drop {
        vault: 0x2::object::ID,
        owner: address,
        market: 0x2::object::ID,
        is_long: bool,
        px: u64,
        reward: u64,
        liquidator: address,
    }

    struct Deposited has copy, drop {
        vault: 0x2::object::ID,
        who: address,
        amount: u64,
        shares: u64,
        nav: u64,
        total_shares: u64,
    }

    struct WithdrawRequested has copy, drop {
        vault: 0x2::object::ID,
        who: address,
        shares: u64,
        unlock_ms: u64,
    }

    struct Withdrawn has copy, drop {
        vault: 0x2::object::ID,
        who: address,
        shares: u64,
        amount: u64,
        nav: u64,
        total_shares: u64,
    }

    struct ProtocolFeesClaimed has copy, drop {
        vault: 0x2::object::ID,
        amount: u64,
        to: address,
    }

    public fun is_paused<T0>(arg0: &Vault<T0>) : bool {
        arg0.paused
    }

    fun accrue(arg0: &mut Market, arg1: u64) {
        if (arg1 <= arg0.last_accrue_ms) {
            return
        };
        arg0.acc_borrow = arg0.acc_borrow + borrow_inc(&arg0.params, arg0.last_accrue_ms, arg1);
        let v0 = (arg0.oi_long as u256);
        let v1 = (arg0.oi_short as u256);
        if (v0 != v1 && arg0.params.funding_max_bps_day > 0) {
            let (v2, v3) = if (v0 > v1) {
                (v0, v1)
            } else {
                (v1, v0)
            };
            let v4 = (arg0.params.funding_max_bps_day as u256) * (v2 - v3) * ((arg1 - arg0.last_accrue_ms) as u256) * 1000000000000000000 / (v2 + v3) * (10000 as u256) * (86400000 as u256);
            let v5 = if (v3 > 0) {
                v4 * v2 / v3
            } else {
                0
            };
            if (v0 > v1) {
                arg0.acc_paid_long = arg0.acc_paid_long + v4;
                arg0.acc_recv_short = arg0.acc_recv_short + v5;
            } else {
                arg0.acc_paid_short = arg0.acc_paid_short + v4;
                arg0.acc_recv_long = arg0.acc_recv_long + v5;
            };
        };
        arg0.last_accrue_ms = arg1;
    }

    public fun add_margin<T0>(arg0: &mut Vault<T0>, arg1: 0x2::object::ID, arg2: bool, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg3);
        assert!(v0 > 0, 25);
        let v1 = PosKey{
            owner   : 0x2::tx_context::sender(arg5),
            market  : arg1,
            is_long : arg2,
        };
        assert!(0x2::table::contains<PosKey, Position>(&arg0.positions, v1), 9);
        let v2 = 0x2::table::borrow_mut<0x2::object::ID, Market>(&mut arg0.markets, arg1);
        accrue(v2, 0x2::clock::timestamp_ms(arg4));
        let v3 = 0x2::table::borrow<0x2::object::ID, Market>(&arg0.markets, arg1).params.max_profit_bps;
        0x2::balance::join<T0>(&mut arg0.cash, 0x2::coin::into_balance<T0>(arg3));
        let v4 = 0x2::table::remove<PosKey, Position>(&mut arg0.positions, v1);
        unregister<T0>(arg0, &v4);
        let v5 = settle_fees<T0>(arg0, v4);
        v5.collateral = v5.collateral + v0;
        v5.reserved = mul_div(v5.collateral, v3, 10000);
        assert!(reserve_fits<T0>(arg0, arg0.reserved_total + v5.reserved), 23);
        register<T0>(arg0, &v5);
        0x2::table::add<PosKey, Position>(&mut arg0.positions, v1, v5);
        emit_position<T0>(arg0, &v5);
    }

    public fun add_market<T0>(arg0: &AdminCap, arg1: &mut Vault<T0>, arg2: &0x2148b710eaf7a555ea1c792540509554db04bed3c34900b6d1102c3cb2321255::oracle::Feed, arg3: 0x1::string::String, arg4: MarketParams, arg5: &0x2::clock::Clock) {
        validate_params(&arg4);
        assert!(0x2148b710eaf7a555ea1c792540509554db04bed3c34900b6d1102c3cb2321255::oracle::feed_registry(arg2) == arg1.oracle_registry, 26);
        let v0 = 0x2::object::id<0x2148b710eaf7a555ea1c792540509554db04bed3c34900b6d1102c3cb2321255::oracle::Feed>(arg2);
        assert!(!0x2::table::contains<0x2::object::ID, Market>(&arg1.markets, v0), 3);
        let v1 = Market{
            feed            : v0,
            feed_key        : 0x2148b710eaf7a555ea1c792540509554db04bed3c34900b6d1102c3cb2321255::oracle::key(arg2),
            symbol          : arg3,
            status          : 0,
            base            : arg4,
            params          : arg4,
            oi_long         : 0,
            oi_short        : 0,
            units_long      : 0,
            units_short     : 0,
            collateral      : 0,
            reserved        : 0,
            acc_borrow      : 0,
            acc_paid_long   : 0,
            acc_recv_long   : 0,
            acc_paid_short  : 0,
            acc_recv_short  : 0,
            borrow_weighted : 0,
            last_accrue_ms  : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::table::add<0x2::object::ID, Market>(&mut arg1.markets, v0, v1);
        0x1::vector::push_back<0x2::object::ID>(&mut arg1.market_ids, v0);
        let v2 = 0x2::object::id<Vault<T0>>(arg1);
        let v3 = MarketAdded{
            vault    : v2,
            market   : v0,
            feed_key : 0x2148b710eaf7a555ea1c792540509554db04bed3c34900b6d1102c3cb2321255::oracle::key(arg2),
            symbol   : arg3,
        };
        0x2::event::emit<MarketAdded>(v3);
        let v4 = MarketParamsSet{
            vault     : v2,
            market    : v0,
            params    : arg4,
            by_keeper : false,
        };
        0x2::event::emit<MarketParamsSet>(v4);
    }

    fun add_order<T0>(arg0: &mut Vault<T0>, arg1: Order) : u64 {
        let v0 = arg1.id;
        arg0.next_order = v0 + 1;
        0x2::table::add<u64, Order>(&mut arg0.orders, v0, arg1);
        let v1 = OrderPlaced{
            vault         : 0x2::object::id<Vault<T0>>(arg0),
            id            : v0,
            owner         : arg1.owner,
            market        : arg1.market,
            kind          : arg1.kind,
            is_long       : arg1.is_long,
            collateral    : arg1.collateral,
            leverage_x100 : arg1.leverage_x100,
            size_delta    : arg1.size_delta,
            acceptable_px : arg1.acceptable_px,
            placed_ms     : arg1.placed_ms,
            ref_px        : arg1.ref_px,
        };
        0x2::event::emit<OrderPlaced>(v1);
        v0
    }

    fun add_shares<T0>(arg0: &mut Vault<T0>, arg1: address, arg2: u64) {
        if (0x2::table::contains<address, u64>(&arg0.shares, arg1)) {
            let v0 = 0x2::table::borrow_mut<address, u64>(&mut arg0.shares, arg1);
            *v0 = *v0 + arg2;
        } else {
            0x2::table::add<address, u64>(&mut arg0.shares, arg1, arg2);
        };
        arg0.total_shares = arg0.total_shares + arg2;
    }

    public fun admin_set_status<T0>(arg0: &AdminCap, arg1: &mut Vault<T0>, arg2: 0x2::object::ID, arg3: u8) {
        set_status_inner<T0>(arg1, arg2, arg3);
    }

    public fun boost<T0>(arg0: &Vault<T0>) : (u64, u64) {
        (arg0.boost_end_ms, arg0.boost_assets)
    }

    fun borrow_inc(arg0: &MarketParams, arg1: u64, arg2: u64) : u256 {
        if (arg2 <= arg1) {
            return 0
        };
        (arg0.borrow_bps_day as u256) * ((arg2 - arg1) as u256) * 1000000000000000000 / (10000 as u256) * (86400000 as u256)
    }

    public fun cancel_order<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: &0x2148b710eaf7a555ea1c792540509554db04bed3c34900b6d1102c3cb2321255::oracle::Feed, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<u64, Order>(&arg0.orders, arg1), 10);
        let v0 = *0x2::table::borrow<u64, Order>(&arg0.orders, arg1);
        assert!(v0.owner == 0x2::tx_context::sender(arg4), 11);
        assert!(0x2::object::id<0x2148b710eaf7a555ea1c792540509554db04bed3c34900b6d1102c3cb2321255::oracle::Feed>(arg2) == v0.market, 2);
        assert!(0x2::clock::timestamp_ms(arg3) >= v0.placed_ms + 0x2::table::borrow<0x2::object::ID, Market>(&arg0.markets, v0.market).params.order_timeout_ms, 13);
        let (v1, _, _) = first_after(arg2, v0.placed_ms + order_delay<T0>(arg0, &v0));
        assert!(!v1, 12);
        refund<T0>(arg0, arg1, 0, arg4);
    }

    public fun cancel_withdraw<T0>(arg0: &mut Vault<T0>, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::table::contains<address, Withdrawal>(&arg0.withdrawals, v0), 22);
        0x2::table::remove<address, Withdrawal>(&mut arg0.withdrawals, v0);
    }

    public fun cash_value<T0>(arg0: &Vault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.cash)
    }

    public fun claim_protocol_fees<T0>(arg0: &AdminCap, arg1: &mut Vault<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = arg1.protocol_fees;
        arg1.protocol_fees = 0;
        let v1 = arg1.treasury;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.cash, v0, arg2), v1);
        let v2 = ProtocolFeesClaimed{
            vault  : 0x2::object::id<Vault<T0>>(arg1),
            amount : v0,
            to     : v1,
        };
        0x2::event::emit<ProtocolFeesClaimed>(v2);
    }

    public fun claim_withdraw<T0>(arg0: &mut Vault<T0>, arg1: NavCheck, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = finish_nav<T0>(arg0, arg1);
        let v1 = 0x2::tx_context::sender(arg3);
        assert!(0x2::table::contains<address, Withdrawal>(&arg0.withdrawals, v1), 22);
        let v2 = 0x2::table::remove<address, Withdrawal>(&mut arg0.withdrawals, v1);
        assert!(0x2::clock::timestamp_ms(arg2) >= v2.unlock_ms, 21);
        let v3 = shares_of<T0>(arg0, v1);
        assert!(v3 >= v2.shares, 20);
        let v4 = (((v2.shares as u128) * (v0 as u128) / (arg0.total_shares as u128)) as u64);
        let v5 = lp_assets<T0>(arg0);
        assert!(v4 <= v5, 23);
        assert!((arg0.reserved_total as u128) * (10000 as u128) <= ((v5 - v4) as u128) * (arg0.util_cap_bps as u128), 23);
        if (v3 == v2.shares) {
            0x2::table::remove<address, u64>(&mut arg0.shares, v1);
        } else {
            *0x2::table::borrow_mut<address, u64>(&mut arg0.shares, v1) = v3 - v2.shares;
        };
        arg0.total_shares = arg0.total_shares - v2.shares;
        let v6 = Withdrawn{
            vault        : 0x2::object::id<Vault<T0>>(arg0),
            who          : v1,
            shares       : v2.shares,
            amount       : v4,
            nav          : v0,
            total_shares : arg0.total_shares,
        };
        0x2::event::emit<Withdrawn>(v6);
        0x2::coin::take<T0>(&mut arg0.cash, v4, arg3)
    }

    fun close_part<T0>(arg0: &mut Vault<T0>, arg1: PosKey, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u8, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::table::borrow<0x2::object::ID, Market>(&arg0.markets, arg1.market).params.max_profit_bps;
        let v1 = 0x2::table::remove<PosKey, Position>(&mut arg0.positions, arg1);
        unregister<T0>(arg0, &v1);
        let v2 = settle_fees<T0>(arg0, v1);
        let v3 = arg2 >= v2.size;
        let v4 = if (v3) {
            v2.units
        } else {
            v2.units * (arg2 as u256) / (v2.size as u256)
        };
        let v5 = if (v3) {
            v2.collateral
        } else {
            mul_div(v2.collateral, arg2, v2.size)
        };
        let v6 = if (v3) {
            v2.reserved
        } else {
            mul_div(v2.reserved, arg2, v2.size)
        };
        let v7 = v4 * (arg4 as u256) / 1000000000000000000;
        let (v8, v9) = if (arg1.is_long) {
            if (v7 >= (arg2 as u256)) {
                (((v7 - (arg2 as u256)) as u64), 0)
            } else {
                (0, (((arg2 as u256) - v7) as u64))
            }
        } else if ((arg2 as u256) >= v7) {
            ((((arg2 as u256) - v7) as u64), 0)
        } else {
            (0, ((v7 - (arg2 as u256)) as u64))
        };
        let v10 = v8;
        if (v8 > v6) {
            v10 = v6;
        };
        let v11 = (v5 as u128) + (v10 as u128);
        let v12 = if (v11 > (v9 as u128)) {
            v11 - (v9 as u128)
        } else {
            0
        };
        let v13 = min(mul_div(arg2, arg5, 10000), (v12 as u64));
        let v14 = (v12 as u64) - v13;
        take_fee<T0>(arg0, v13, arg7);
        if (!v3) {
            v2.size = v2.size - arg2;
            v2.units = v2.units - v4;
            v2.collateral = v2.collateral - v5;
            v2.reserved = mul_div(v2.collateral, v0, 10000);
            v2.entry_px = entry_of(&v2);
            register<T0>(arg0, &v2);
            0x2::table::add<PosKey, Position>(&mut arg0.positions, arg1, v2);
        };
        if (v14 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.cash, v14, arg8), arg1.owner);
        };
        let v15 = if (v3) {
            0
        } else {
            v2.size
        };
        let v16 = PositionClosed{
            vault          : 0x2::object::id<Vault<T0>>(arg0),
            owner          : arg1.owner,
            market         : arg1.market,
            is_long        : arg1.is_long,
            reason         : arg6,
            px             : arg3,
            exec_px        : arg4,
            size           : arg2,
            profit         : v10,
            loss           : v9,
            fee            : v13,
            payout         : v14,
            remaining_size : v15,
        };
        0x2::event::emit<PositionClosed>(v16);
        if (!v3) {
            emit_position<T0>(arg0, &v2);
        };
        v13
    }

    public fun cooldown_ms<T0>(arg0: &Vault<T0>) : u64 {
        arg0.cooldown_ms
    }

    public fun create_vault<T0>(arg0: &AdminCap, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg3 <= 10000) {
            if (arg4 > 0) {
                arg4 <= 10000
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 5);
        let v1 = Vault<T0>{
            id                 : 0x2::object::new(arg6),
            cash               : 0x2::balance::zero<T0>(),
            oracle_registry    : arg1,
            treasury           : arg2,
            paused             : false,
            markets            : 0x2::table::new<0x2::object::ID, Market>(arg6),
            market_ids         : 0x1::vector::empty<0x2::object::ID>(),
            positions          : 0x2::table::new<PosKey, Position>(arg6),
            orders             : 0x2::table::new<u64, Order>(arg6),
            next_order         : 1,
            collateral_total   : 0,
            pending_total      : 0,
            protocol_fees      : 0,
            protocol_share_bps : arg3,
            reserved_total     : 0,
            util_cap_bps       : arg4,
            shares             : 0x2::table::new<address, u64>(arg6),
            total_shares       : 0,
            withdrawals        : 0x2::table::new<address, Withdrawal>(arg6),
            cooldown_ms        : arg5,
            lp_fee_income      : 0,
            lp_borrow_income   : 0,
            boost_end_ms       : 0,
            boost_assets       : 0,
        };
        let v2 = VaultCreated{
            vault           : 0x2::object::id<Vault<T0>>(&v1),
            oracle_registry : arg1,
            treasury        : arg2,
        };
        0x2::event::emit<VaultCreated>(v2);
        0x2::transfer::share_object<Vault<T0>>(v1);
    }

    public fun deposit<T0>(arg0: &mut Vault<T0>, arg1: NavCheck, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 1);
        let v0 = finish_nav<T0>(arg0, arg1);
        let v1 = 0x2::coin::value<T0>(&arg2);
        assert!(v1 > 0, 25);
        let v2 = if (arg0.total_shares == 0) {
            assert!(v1 > 1000, 8);
            add_shares<T0>(arg0, @0x0, 1000);
            let v3 = v1 + v0 - 1000;
            add_shares<T0>(arg0, 0x2::tx_context::sender(arg3), v3);
            v3
        } else {
            assert!(v0 > 0, 28);
            let v4 = (((v1 as u128) * (arg0.total_shares as u128) / (v0 as u128)) as u64);
            assert!(v4 > 0, 8);
            add_shares<T0>(arg0, 0x2::tx_context::sender(arg3), v4);
            v4
        };
        0x2::balance::join<T0>(&mut arg0.cash, 0x2::coin::into_balance<T0>(arg2));
        let v5 = Deposited{
            vault        : 0x2::object::id<Vault<T0>>(arg0),
            who          : 0x2::tx_context::sender(arg3),
            amount       : v1,
            shares       : v2,
            nav          : v0,
            total_shares : arg0.total_shares,
        };
        0x2::event::emit<Deposited>(v5);
    }

    public fun donate<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.cash, 0x2::coin::into_balance<T0>(arg1));
    }

    fun emit_position<T0>(arg0: &Vault<T0>, arg1: &Position) {
        let v0 = PositionUpdated{
            vault      : 0x2::object::id<Vault<T0>>(arg0),
            owner      : arg1.owner,
            market     : arg1.market,
            is_long    : arg1.is_long,
            size       : arg1.size,
            collateral : arg1.collateral,
            entry_px   : arg1.entry_px,
            tp         : arg1.tp,
            sl         : arg1.sl,
        };
        0x2::event::emit<PositionUpdated>(v0);
    }

    fun empty_position(arg0: address, arg1: 0x2::object::ID, arg2: bool, arg3: u64) : Position {
        Position{
            owner      : arg0,
            market     : arg1,
            is_long    : arg2,
            size       : 0,
            collateral : 0,
            units      : 0,
            entry_px   : 0,
            reserved   : 0,
            acc_borrow : 0,
            acc_paid   : 0,
            acc_recv   : 0,
            tp         : 0,
            sl         : 0,
            tpsl_ms    : arg3,
            opened_ms  : arg3,
        }
    }

    fun entry_of(arg0: &Position) : u64 {
        if (arg0.units == 0) {
            0
        } else {
            (((arg0.size as u256) * 1000000000000000000 / arg0.units) as u64)
        }
    }

    fun exec_price(arg0: &Market, arg1: u64, arg2: bool, arg3: u64) : u64 {
        let v0 = &arg0.params;
        let v1 = v0.base_spread_bps + v0.vol_spread_bps + impact_bps(arg0, arg2, arg3);
        let v2 = v1;
        if (v1 > v0.max_spread_bps) {
            v2 = v0.max_spread_bps;
        };
        if (arg2) {
            mul_div_up(arg1, 10000 + v2, 10000)
        } else {
            mul_div(arg1, 10000 - v2, 10000)
        }
    }

    public fun execute_order<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: &0x2148b710eaf7a555ea1c792540509554db04bed3c34900b6d1102c3cb2321255::oracle::Feed, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<u64, Order>(&arg0.orders, arg1), 10);
        let v0 = *0x2::table::borrow<u64, Order>(&arg0.orders, arg1);
        assert!(0x2::object::id<0x2148b710eaf7a555ea1c792540509554db04bed3c34900b6d1102c3cb2321255::oracle::Feed>(arg2) == v0.market, 2);
        assert!(!0x2148b710eaf7a555ea1c792540509554db04bed3c34900b6d1102c3cb2321255::oracle::is_paused(arg2), 12);
        assert!(0x2::table::borrow<0x2::object::ID, Market>(&arg0.markets, v0.market).status != 2, 12);
        let (v1, v2, v3) = first_after(arg2, v0.placed_ms + order_delay<T0>(arg0, &v0));
        assert!(v1, 12);
        let v4 = 0x2::clock::timestamp_ms(arg3);
        let v5 = 0x2::table::borrow_mut<0x2::object::ID, Market>(&mut arg0.markets, v0.market);
        accrue(v5, v4);
        if (v0.kind == 0) {
            fill_open<T0>(arg0, v0, v2, v3, v4, arg4);
        } else {
            fill_close<T0>(arg0, v0, v2, v3, v4, arg4);
        };
    }

    public fun fees(arg0: &MarketParams) : (u64, u64, u64, u64) {
        (arg0.open_fee_bps, arg0.close_fee_bps, arg0.funding_max_bps_day, arg0.borrow_bps_day)
    }

    fun fill_close<T0>(arg0: &mut Vault<T0>, arg1: Order, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = PosKey{
            owner   : arg1.owner,
            market  : arg1.market,
            is_long : arg1.is_long,
        };
        if (!0x2::table::contains<PosKey, Position>(&arg0.positions, v0)) {
            refund<T0>(arg0, arg1.id, 8, arg5);
            return
        };
        let v1 = 0x2::table::borrow<0x2::object::ID, Market>(&arg0.markets, arg1.market);
        let v2 = v1.params;
        let v3 = 0x2::table::borrow<PosKey, Position>(&arg0.positions, v0).size;
        let v4 = if (arg1.size_delta >= v3) {
            v3
        } else {
            arg1.size_delta
        };
        let v5 = v4;
        if (v3 - v4 < v2.min_size) {
            v5 = v3;
        };
        let v6 = exec_price(v1, arg2, !arg1.is_long, v5);
        if (arg1.acceptable_px > 0 && (arg1.is_long && v6 < arg1.acceptable_px || v6 > arg1.acceptable_px)) {
            refund<T0>(arg0, arg1.id, 4, arg5);
            return
        };
        0x2::table::remove<u64, Order>(&mut arg0.orders, arg1.id);
        let v7 = close_part<T0>(arg0, v0, v5, arg2, v6, v2.close_fee_bps, 0, arg4, arg5);
        let v8 = OrderFilled{
            vault    : 0x2::object::id<Vault<T0>>(arg0),
            id       : arg1.id,
            owner    : arg1.owner,
            market   : arg1.market,
            kind     : 1,
            is_long  : arg1.is_long,
            px       : arg2,
            px_ts_ms : arg3,
            exec_px  : v6,
            size     : v5,
            fee      : v7,
        };
        0x2::event::emit<OrderFilled>(v8);
    }

    fun fill_open<T0>(arg0: &mut Vault<T0>, arg1: Order, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::table::borrow<0x2::object::ID, Market>(&arg0.markets, arg1.market);
        let v1 = v0.params;
        if (v0.status != 0) {
            refund<T0>(arg0, arg1.id, 2, arg5);
            return
        };
        let v2 = lp_assets<T0>(arg0);
        if (v2 < v1.unlock_lp) {
            refund<T0>(arg0, arg1.id, 9, arg5);
            return
        };
        if (!within(arg2, arg1.ref_px, v1.max_dev_bps)) {
            refund<T0>(arg0, arg1.id, 3, arg5);
            return
        };
        let v3 = mul_div(arg1.collateral, arg1.leverage_x100, 100);
        let v4 = mul_div(v3, v1.open_fee_bps, 10000);
        let v5 = exec_price(v0, arg2, arg1.is_long, v3);
        if (arg1.acceptable_px > 0 && (arg1.is_long && v5 > arg1.acceptable_px || v5 < arg1.acceptable_px)) {
            refund<T0>(arg0, arg1.id, 4, arg5);
            return
        };
        let v6 = if (arg1.is_long) {
            v0.oi_long
        } else {
            v0.oi_short
        };
        if (v6 + v3 > oi_cap(&v1, arg1.is_long, v2)) {
            refund<T0>(arg0, arg1.id, 5, arg5);
            return
        };
        let v7 = PosKey{
            owner   : arg1.owner,
            market  : arg1.market,
            is_long : arg1.is_long,
        };
        let v8 = 0x2::table::contains<PosKey, Position>(&arg0.positions, v7);
        let v9 = if (v8) {
            let v10 = 0x2::table::remove<PosKey, Position>(&mut arg0.positions, v7);
            unregister<T0>(arg0, &v10);
            settle_fees<T0>(arg0, v10)
        } else {
            settle_fees<T0>(arg0, empty_position(arg1.owner, arg1.market, arg1.is_long, arg4))
        };
        let v11 = v9;
        let v12 = v11.size + v3;
        let v13 = v11.collateral + arg1.collateral - v4;
        let v14 = mul_div(v13, v1.max_profit_bps, 10000);
        let v15 = (v12 as u128) * 100 <= ((v11.collateral + arg1.collateral) as u128) * (v1.max_leverage_x100 as u128);
        if (!v15 || !reserve_fits<T0>(arg0, arg0.reserved_total + v14)) {
            if (v8) {
                register<T0>(arg0, &v11);
                0x2::table::add<PosKey, Position>(&mut arg0.positions, v7, v11);
            };
            let v16 = if (!v15) {
                6
            } else {
                7
            };
            refund<T0>(arg0, arg1.id, v16, arg5);
            return
        };
        0x2::table::remove<u64, Order>(&mut arg0.orders, arg1.id);
        arg0.pending_total = arg0.pending_total - arg1.collateral;
        take_fee<T0>(arg0, v4, arg4);
        v11.size = v12;
        v11.collateral = v13;
        v11.units = v11.units + (v3 as u256) * 1000000000000000000 / (v5 as u256);
        v11.entry_px = entry_of(&v11);
        v11.reserved = v14;
        if (arg1.tp > 0 || arg1.sl > 0) {
            v11.tp = arg1.tp;
            v11.sl = arg1.sl;
            v11.tpsl_ms = arg4;
        };
        register<T0>(arg0, &v11);
        0x2::table::add<PosKey, Position>(&mut arg0.positions, v7, v11);
        let v17 = OrderFilled{
            vault    : 0x2::object::id<Vault<T0>>(arg0),
            id       : arg1.id,
            owner    : arg1.owner,
            market   : arg1.market,
            kind     : 0,
            is_long  : arg1.is_long,
            px       : arg2,
            px_ts_ms : arg3,
            exec_px  : v5,
            size     : v3,
            fee      : v4,
        };
        0x2::event::emit<OrderFilled>(v17);
        emit_position<T0>(arg0, &v11);
    }

    fun finish_nav<T0>(arg0: &Vault<T0>, arg1: NavCheck) : u64 {
        let NavCheck {
            vault : v0,
            next  : v1,
            plus  : v2,
            minus : v3,
        } = arg1;
        assert!(v0 == 0x2::object::id<Vault<T0>>(arg0), 19);
        assert!(v1 == 0x1::vector::length<0x2::object::ID>(&arg0.market_ids), 18);
        let v4 = (lp_assets<T0>(arg0) as u256) + v2;
        if (v4 > v3) {
            ((v4 - v3) as u64)
        } else {
            0
        }
    }

    fun first_after(arg0: &0x2148b710eaf7a555ea1c792540509554db04bed3c34900b6d1102c3cb2321255::oracle::Feed, arg1: u64) : (bool, u64, u64) {
        let v0 = 0;
        let v1 = false;
        let v2 = 0;
        let v3 = 0;
        while (v0 < 0x2148b710eaf7a555ea1c792540509554db04bed3c34900b6d1102c3cb2321255::oracle::history_size(arg0)) {
            let (v4, v5, _) = 0x2148b710eaf7a555ea1c792540509554db04bed3c34900b6d1102c3cb2321255::oracle::history_at(arg0, v0);
            if (v5 <= arg1) {
                break
            };
            v1 = true;
            v2 = v4;
            v3 = v5;
            v0 = v0 + 1;
        };
        (v1, v2, v3)
    }

    fun fresh_price<T0>(arg0: &Vault<T0>, arg1: &0x2148b710eaf7a555ea1c792540509554db04bed3c34900b6d1102c3cb2321255::oracle::Feed, arg2: &0x2::clock::Clock) : (u64, u64) {
        let v0 = 0x2::object::id<0x2148b710eaf7a555ea1c792540509554db04bed3c34900b6d1102c3cb2321255::oracle::Feed>(arg1);
        assert!(0x2::table::contains<0x2::object::ID, Market>(&arg0.markets, v0), 4);
        let v1 = 0x2::table::borrow<0x2::object::ID, Market>(&arg0.markets, v0);
        assert!(v1.status != 2, 12);
        assert!(!0x2148b710eaf7a555ea1c792540509554db04bed3c34900b6d1102c3cb2321255::oracle::is_paused(arg1) && 0x2148b710eaf7a555ea1c792540509554db04bed3c34900b6d1102c3cb2321255::oracle::has_value(arg1), 14);
        let (v2, _, _) = 0x2148b710eaf7a555ea1c792540509554db04bed3c34900b6d1102c3cb2321255::oracle::held(arg1);
        assert!(!v2, 15);
        let (v5, v6, _) = 0x2148b710eaf7a555ea1c792540509554db04bed3c34900b6d1102c3cb2321255::oracle::latest(arg1);
        let v8 = 0x2::clock::timestamp_ms(arg2);
        assert!(v8 <= v6 || v8 - v6 <= v1.params.max_price_age_ms, 29);
        (v5, v6)
    }

    public fun has_market<T0>(arg0: &Vault<T0>, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, Market>(&arg0.markets, arg1)
    }

    public fun has_order<T0>(arg0: &Vault<T0>, arg1: u64) : bool {
        0x2::table::contains<u64, Order>(&arg0.orders, arg1)
    }

    public fun has_position<T0>(arg0: &Vault<T0>, arg1: address, arg2: 0x2::object::ID, arg3: bool) : bool {
        let v0 = PosKey{
            owner   : arg1,
            market  : arg2,
            is_long : arg3,
        };
        0x2::table::contains<PosKey, Position>(&arg0.positions, v0)
    }

    fun impact_bps(arg0: &Market, arg1: bool, arg2: u64) : u64 {
        let v0 = arg0.params.depth_1pct;
        if (v0 == 0) {
            return 0
        };
        let (v1, v2) = if (arg1) {
            (arg0.oi_long, arg0.oi_short)
        } else {
            (arg0.oi_short, arg0.oi_long)
        };
        let v3 = (v1 as u128) + (arg2 as u128) / 2;
        let v4 = (v2 as u128);
        if (v3 <= v4) {
            return 0
        };
        let v5 = (v3 - v4) * 100 / (v0 as u128);
        if (v5 > (10000 as u128)) {
            10000
        } else {
            (v5 as u64)
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun keeper_cancel<T0>(arg0: &KeeperCap, arg1: &mut Vault<T0>, arg2: u64, arg3: &0x2148b710eaf7a555ea1c792540509554db04bed3c34900b6d1102c3cb2321255::oracle::Feed, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<u64, Order>(&arg1.orders, arg2), 10);
        let v0 = *0x2::table::borrow<u64, Order>(&arg1.orders, arg2);
        assert!(0x2::object::id<0x2148b710eaf7a555ea1c792540509554db04bed3c34900b6d1102c3cb2321255::oracle::Feed>(arg3) == v0.market, 2);
        let (v1, _, _) = first_after(arg3, v0.placed_ms + order_delay<T0>(arg1, &v0));
        assert!(!v1, 12);
        refund<T0>(arg1, arg2, 1, arg4);
    }

    public fun keeper_set_risk<T0>(arg0: &KeeperCap, arg1: &mut Vault<T0>, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock) {
        assert!(0x2::table::contains<0x2::object::ID, Market>(&arg1.markets, arg2), 4);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, Market>(&mut arg1.markets, arg2);
        let v1 = v0.base;
        assert!(arg3 >= 100 && arg3 <= v1.max_leverage_x100, 24);
        assert!(arg4 <= v1.max_oi_long && arg5 <= v1.max_oi_short, 24);
        assert!(arg6 >= v1.vol_spread_bps && v1.base_spread_bps + arg6 <= v1.max_spread_bps, 24);
        assert!(arg7 >= v1.borrow_bps_day && arg7 <= v1.borrow_bps_day * 10 + 10, 24);
        accrue(v0, 0x2::clock::timestamp_ms(arg8));
        v0.params.max_leverage_x100 = arg3;
        v0.params.max_oi_long = arg4;
        v0.params.max_oi_short = arg5;
        v0.params.vol_spread_bps = arg6;
        v0.params.borrow_bps_day = arg7;
        let v2 = MarketParamsSet{
            vault     : 0x2::object::id<Vault<T0>>(arg1),
            market    : arg2,
            params    : v0.params,
            by_keeper : true,
        };
        0x2::event::emit<MarketParamsSet>(v2);
    }

    public fun keeper_set_status<T0>(arg0: &KeeperCap, arg1: &mut Vault<T0>, arg2: 0x2::object::ID, arg3: u8) {
        set_status_inner<T0>(arg1, arg2, arg3);
    }

    public fun liquidate<T0>(arg0: &mut Vault<T0>, arg1: address, arg2: bool, arg3: &0x2148b710eaf7a555ea1c792540509554db04bed3c34900b6d1102c3cb2321255::oracle::Feed, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::object::id<0x2148b710eaf7a555ea1c792540509554db04bed3c34900b6d1102c3cb2321255::oracle::Feed>(arg3);
        let v1 = PosKey{
            owner   : arg1,
            market  : v0,
            is_long : arg2,
        };
        assert!(0x2::table::contains<PosKey, Position>(&arg0.positions, v1), 9);
        let (v2, _) = fresh_price<T0>(arg0, arg3, arg4);
        let v4 = 0x2::table::borrow_mut<0x2::object::ID, Market>(&mut arg0.markets, v0);
        accrue(v4, 0x2::clock::timestamp_ms(arg4));
        let v5 = 0x2::table::borrow<0x2::object::ID, Market>(&arg0.markets, v0).params;
        let v6 = 0x2::table::remove<PosKey, Position>(&mut arg0.positions, v1);
        unregister<T0>(arg0, &v6);
        let v7 = settle_fees<T0>(arg0, v6);
        let (v8, v9) = pnl(&v7, v2);
        let v10 = (v7.collateral as u128) + (v8 as u128);
        let v11 = (v9 as u128) + (mul_div(v7.size, v5.close_fee_bps, 10000) as u128);
        let v12 = if (v10 > v11) {
            v10 - v11
        } else {
            0
        };
        assert!(v12 <= (mul_div(v7.collateral, v5.liq_threshold_bps, 10000) as u128), 16);
        let v13 = min((v12 as u64), mul_div(v7.size, v5.liq_reward_bps, 10000));
        let v14 = 0x2::object::id<Vault<T0>>(arg0);
        let v15 = PositionClosed{
            vault          : v14,
            owner          : arg1,
            market         : v0,
            is_long        : arg2,
            reason         : 3,
            px             : v2,
            exec_px        : v2,
            size           : v7.size,
            profit         : v8,
            loss           : v9,
            fee            : 0,
            payout         : 0,
            remaining_size : 0,
        };
        0x2::event::emit<PositionClosed>(v15);
        let v16 = Liquidated{
            vault      : v14,
            owner      : arg1,
            market     : v0,
            is_long    : arg2,
            px         : v2,
            reward     : v13,
            liquidator : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<Liquidated>(v16);
        0x2::coin::take<T0>(&mut arg0.cash, v13, arg5)
    }

    fun lp_assets<T0>(arg0: &Vault<T0>) : u64 {
        let v0 = (arg0.collateral_total as u128) + (arg0.pending_total as u128) + (arg0.protocol_fees as u128);
        let v1 = (0x2::balance::value<T0>(&arg0.cash) as u128);
        if (v1 > v0) {
            ((v1 - v0) as u64)
        } else {
            0
        }
    }

    public fun lp_assets_value<T0>(arg0: &Vault<T0>) : u64 {
        lp_assets<T0>(arg0)
    }

    public fun lp_income<T0>(arg0: &Vault<T0>) : (u64, u64) {
        (arg0.lp_fee_income, arg0.lp_borrow_income)
    }

    public fun market_base_params<T0>(arg0: &Vault<T0>, arg1: 0x2::object::ID) : MarketParams {
        0x2::table::borrow<0x2::object::ID, Market>(&arg0.markets, arg1).base
    }

    public fun market_feed_key<T0>(arg0: &Vault<T0>, arg1: 0x2::object::ID) : 0x1::string::String {
        0x2::table::borrow<0x2::object::ID, Market>(&arg0.markets, arg1).feed_key
    }

    public fun market_ids<T0>(arg0: &Vault<T0>) : vector<0x2::object::ID> {
        arg0.market_ids
    }

    public fun market_params<T0>(arg0: &Vault<T0>, arg1: 0x2::object::ID) : MarketParams {
        0x2::table::borrow<0x2::object::ID, Market>(&arg0.markets, arg1).params
    }

    public fun market_rates<T0>(arg0: &Vault<T0>, arg1: 0x2::object::ID) : (bool, u64, u64) {
        let v0 = 0x2::table::borrow<0x2::object::ID, Market>(&arg0.markets, arg1);
        let v1 = (v0.oi_long as u128);
        let v2 = (v0.oi_short as u128);
        let v3 = if (v1 == v2) {
            0
        } else {
            let (v4, v5) = if (v1 > v2) {
                (v1, v2)
            } else {
                (v2, v1)
            };
            (((v0.params.funding_max_bps_day as u128) * (v4 - v5) / (v4 + v5)) as u64)
        };
        (v1 > v2, v3, v0.params.borrow_bps_day)
    }

    public fun market_state<T0>(arg0: &Vault<T0>, arg1: 0x2::object::ID) : (u8, u64, u64, u64, u64, u64) {
        let v0 = 0x2::table::borrow<0x2::object::ID, Market>(&arg0.markets, arg1);
        (v0.status, v0.oi_long, v0.oi_short, v0.collateral, v0.reserved, v0.last_accrue_ms)
    }

    public fun market_symbol<T0>(arg0: &Vault<T0>, arg1: 0x2::object::ID) : 0x1::string::String {
        0x2::table::borrow<0x2::object::ID, Market>(&arg0.markets, arg1).symbol
    }

    public fun max_leverage_x100(arg0: &MarketParams) : u64 {
        arg0.max_leverage_x100
    }

    public fun max_oi(arg0: &MarketParams) : (u64, u64) {
        (arg0.max_oi_long, arg0.max_oi_short)
    }

    public fun max_oi_share_bps(arg0: &MarketParams) : u64 {
        arg0.max_oi_share_bps
    }

    fun min(arg0: u64, arg1: u64) : u64 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    fun min256(arg0: u256, arg1: u256) : u256 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    public fun min_size(arg0: &MarketParams) : u64 {
        arg0.min_size
    }

    public fun mint_keeper_cap(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = KeeperCap{id: 0x2::object::new(arg2)};
        0x2::transfer::public_transfer<KeeperCap>(v0, arg1);
    }

    fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    fun mul_div_up(arg0: u64, arg1: u64, arg2: u64) : u64 {
        ((((arg0 as u128) * (arg1 as u128) + (arg2 as u128) - 1) / (arg2 as u128)) as u64)
    }

    public fun nav_begin<T0>(arg0: &Vault<T0>) : NavCheck {
        NavCheck{
            vault : 0x2::object::id<Vault<T0>>(arg0),
            next  : 0,
            plus  : 0,
            minus : 0,
        }
    }

    public fun nav_mark<T0>(arg0: &mut NavCheck, arg1: &Vault<T0>, arg2: &0x2148b710eaf7a555ea1c792540509554db04bed3c34900b6d1102c3cb2321255::oracle::Feed, arg3: &0x2::clock::Clock) {
        assert!(arg0.vault == 0x2::object::id<Vault<T0>>(arg1), 19);
        let v0 = *0x1::vector::borrow<0x2::object::ID>(&arg1.market_ids, arg0.next);
        assert!(0x2::object::id<0x2148b710eaf7a555ea1c792540509554db04bed3c34900b6d1102c3cb2321255::oracle::Feed>(arg2) == v0, 2);
        let v1 = 0x2::table::borrow<0x2::object::ID, Market>(&arg1.markets, v0);
        arg0.next = arg0.next + 1;
        if (v1.oi_long == 0 && v1.oi_short == 0) {
            return
        };
        let (v2, _) = fresh_price<T0>(arg1, arg2, arg3);
        let v4 = v1.units_long * (v2 as u256) / 1000000000000000000 + (v1.oi_short as u256);
        let v5 = (v1.oi_long as u256) + v1.units_short * (v2 as u256) / 1000000000000000000;
        if (v4 > v5) {
            arg0.minus = arg0.minus + min256(v4 - v5, (v1.reserved as u256));
        } else {
            arg0.plus = arg0.plus + min256(v5 - v4, (v1.collateral as u256));
        };
        let v6 = (v1.acc_borrow + borrow_inc(&v1.params, v1.last_accrue_ms, 0x2::clock::timestamp_ms(arg3))) * ((v1.oi_long as u256) + (v1.oi_short as u256));
        let v7 = if (v6 > v1.borrow_weighted) {
            (v6 - v1.borrow_weighted) / 1000000000000000000
        } else {
            0
        };
        arg0.plus = arg0.plus + min256(v7, (v1.collateral as u256));
    }

    public fun nav_progress(arg0: &NavCheck) : u64 {
        arg0.next
    }

    public fun new_params(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: u64, arg20: u64, arg21: u64) : MarketParams {
        let v0 = MarketParams{
            max_leverage_x100   : arg0,
            min_size            : arg1,
            max_oi_long         : arg2,
            max_oi_short        : arg3,
            base_spread_bps     : arg4,
            vol_spread_bps      : arg5,
            max_spread_bps      : arg6,
            depth_1pct          : arg7,
            funding_max_bps_day : arg8,
            borrow_bps_day      : arg9,
            open_fee_bps        : arg10,
            close_fee_bps       : arg11,
            liq_threshold_bps   : arg12,
            liq_reward_bps      : arg13,
            max_profit_bps      : arg14,
            max_price_age_ms    : arg15,
            open_delay_ms       : arg16,
            close_delay_ms      : arg17,
            max_dev_bps         : arg18,
            order_timeout_ms    : arg19,
            unlock_lp           : arg20,
            max_oi_share_bps    : arg21,
        };
        validate_params(&v0);
        v0
    }

    public fun next_order_id<T0>(arg0: &Vault<T0>) : u64 {
        arg0.next_order
    }

    fun oi_cap(arg0: &MarketParams, arg1: bool, arg2: u64) : u64 {
        let v0 = if (arg1) {
            arg0.max_oi_long
        } else {
            arg0.max_oi_short
        };
        if (arg0.max_oi_share_bps == 0) {
            return v0
        };
        min(v0, mul_div(arg2, arg0.max_oi_share_bps, 10000))
    }

    public fun oi_cap_now<T0>(arg0: &Vault<T0>, arg1: 0x2::object::ID, arg2: bool) : u64 {
        oi_cap(&0x2::table::borrow<0x2::object::ID, Market>(&arg0.markets, arg1).params, arg2, lp_assets<T0>(arg0))
    }

    public fun order<T0>(arg0: &Vault<T0>, arg1: u64) : (address, 0x2::object::ID, u8, bool, u64, u64, u64, u64) {
        let v0 = 0x2::table::borrow<u64, Order>(&arg0.orders, arg1);
        (v0.owner, v0.market, v0.kind, v0.is_long, v0.collateral, v0.leverage_x100, v0.size_delta, v0.placed_ms)
    }

    fun order_delay<T0>(arg0: &Vault<T0>, arg1: &Order) : u64 {
        if (arg1.kind == 0) {
            0x2::table::borrow<0x2::object::ID, Market>(&arg0.markets, arg1.market).params.open_delay_ms
        } else {
            0x2::table::borrow<0x2::object::ID, Market>(&arg0.markets, arg1.market).params.close_delay_ms
        }
    }

    public fun place_close<T0>(arg0: &mut Vault<T0>, arg1: 0x2::object::ID, arg2: bool, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = PosKey{
            owner   : v0,
            market  : arg1,
            is_long : arg2,
        };
        assert!(0x2::table::contains<PosKey, Position>(&arg0.positions, v1), 9);
        assert!(arg3 > 0, 25);
        let v2 = Order{
            id            : arg0.next_order,
            owner         : v0,
            market        : arg1,
            kind          : 1,
            is_long       : arg2,
            collateral    : 0,
            leverage_x100 : 0,
            size_delta    : arg3,
            acceptable_px : arg4,
            tp            : 0,
            sl            : 0,
            placed_ms     : 0x2::clock::timestamp_ms(arg5),
            ref_px        : 0,
        };
        add_order<T0>(arg0, v2)
    }

    public fun place_open<T0>(arg0: &mut Vault<T0>, arg1: &0x2148b710eaf7a555ea1c792540509554db04bed3c34900b6d1102c3cb2321255::oracle::Feed, arg2: bool, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(!arg0.paused, 1);
        let v0 = 0x2::object::id<0x2148b710eaf7a555ea1c792540509554db04bed3c34900b6d1102c3cb2321255::oracle::Feed>(arg1);
        assert!(0x2::table::contains<0x2::object::ID, Market>(&arg0.markets, v0), 4);
        let v1 = 0x2::table::borrow<0x2::object::ID, Market>(&arg0.markets, v0);
        assert!(v1.status == 0, 6);
        assert!(lp_assets<T0>(arg0) >= v1.params.unlock_lp, 30);
        assert!(arg4 >= 100 && arg4 <= v1.params.max_leverage_x100, 7);
        let v2 = 0x2::coin::value<T0>(&arg3);
        assert!(v2 > 0, 25);
        assert!(mul_div(v2, arg4, 100) >= v1.params.min_size, 8);
        assert!(!0x2148b710eaf7a555ea1c792540509554db04bed3c34900b6d1102c3cb2321255::oracle::is_paused(arg1) && 0x2148b710eaf7a555ea1c792540509554db04bed3c34900b6d1102c3cb2321255::oracle::has_value(arg1), 14);
        let (v3, _, _) = 0x2148b710eaf7a555ea1c792540509554db04bed3c34900b6d1102c3cb2321255::oracle::latest(arg1);
        0x2::balance::join<T0>(&mut arg0.cash, 0x2::coin::into_balance<T0>(arg3));
        arg0.pending_total = arg0.pending_total + v2;
        let v6 = Order{
            id            : arg0.next_order,
            owner         : 0x2::tx_context::sender(arg9),
            market        : v0,
            kind          : 0,
            is_long       : arg2,
            collateral    : v2,
            leverage_x100 : arg4,
            size_delta    : 0,
            acceptable_px : arg5,
            tp            : arg6,
            sl            : arg7,
            placed_ms     : 0x2::clock::timestamp_ms(arg8),
            ref_px        : v3,
        };
        add_order<T0>(arg0, v6)
    }

    fun pnl(arg0: &Position, arg1: u64) : (u64, u64) {
        let (v0, v1) = if (arg0.is_long) {
            (arg0.units * (arg1 as u256) / 1000000000000000000, (arg0.size as u256))
        } else {
            ((arg0.size as u256), arg0.units * (arg1 as u256) / 1000000000000000000)
        };
        if (v0 >= v1) {
            ((min256(v0 - v1, (arg0.reserved as u256)) as u64), 0)
        } else {
            (0, ((v1 - v0) as u64))
        }
    }

    public fun poke<T0>(arg0: &mut Vault<T0>, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) {
        assert!(0x2::table::contains<0x2::object::ID, Market>(&arg0.markets, arg1), 4);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, Market>(&mut arg0.markets, arg1);
        accrue(v0, 0x2::clock::timestamp_ms(arg2));
    }

    public fun position<T0>(arg0: &Vault<T0>, arg1: address, arg2: 0x2::object::ID, arg3: bool) : (u64, u64, u64, u64, u64, u64) {
        let v0 = PosKey{
            owner   : arg1,
            market  : arg2,
            is_long : arg3,
        };
        let v1 = 0x2::table::borrow<PosKey, Position>(&arg0.positions, v0);
        (v1.size, v1.collateral, v1.entry_px, v1.tp, v1.sl, v1.reserved)
    }

    public fun position_equity<T0>(arg0: &Vault<T0>, arg1: address, arg2: 0x2::object::ID, arg3: bool, arg4: u64, arg5: &0x2::clock::Clock) : (u64, bool) {
        let v0 = PosKey{
            owner   : arg1,
            market  : arg2,
            is_long : arg3,
        };
        let v1 = *0x2::table::borrow<PosKey, Position>(&arg0.positions, v0);
        let v2 = 0x2::table::borrow<0x2::object::ID, Market>(&arg0.markets, arg2);
        let (v3, v4) = if (arg3) {
            (v2.acc_paid_long, v2.acc_recv_long)
        } else {
            (v2.acc_paid_short, v2.acc_recv_short)
        };
        let v5 = (v1.size as u256);
        let (v6, v7) = pnl(&v1, arg4);
        let v8 = (v1.collateral as u256) + v5 * (v4 - v1.acc_recv) / 1000000000000000000 + (v6 as u256);
        let v9 = v5 * (v2.acc_borrow + borrow_inc(&v2.params, v2.last_accrue_ms, 0x2::clock::timestamp_ms(arg5)) - v1.acc_borrow) / 1000000000000000000 + v5 * (v3 - v1.acc_paid) / 1000000000000000000 + (mul_div(v1.size, v2.params.close_fee_bps, 10000) as u256) + (v7 as u256);
        let v10 = if (v8 > v9) {
            ((v8 - v9) as u64)
        } else {
            0
        };
        (v10, v10 <= mul_div(v1.collateral, v2.params.liq_threshold_bps, 10000))
    }

    public fun protocol_share_at<T0>(arg0: &Vault<T0>, arg1: &0x2::clock::Clock) : u64 {
        protocol_share_now<T0>(arg0, 0x2::clock::timestamp_ms(arg1))
    }

    fun protocol_share_now<T0>(arg0: &Vault<T0>, arg1: u64) : u64 {
        let v0 = arg0.protocol_share_bps;
        if (arg1 >= arg0.boost_end_ms || v0 == 0) {
            return v0
        };
        let v1 = lp_assets<T0>(arg0);
        if (v1 <= arg0.boost_assets) {
            return 0
        };
        mul_div(v0, v1 - arg0.boost_assets, v1)
    }

    public fun quote_price<T0>(arg0: &Vault<T0>, arg1: 0x2::object::ID, arg2: u64, arg3: bool, arg4: u64) : u64 {
        exec_price(0x2::table::borrow<0x2::object::ID, Market>(&arg0.markets, arg1), arg2, arg3, arg4)
    }

    fun refund<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::table::remove<u64, Order>(&mut arg0.orders, arg1);
        if (v0.collateral > 0) {
            arg0.pending_total = arg0.pending_total - v0.collateral;
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.cash, v0.collateral, arg3), v0.owner);
        };
        let v1 = OrderCancelled{
            vault  : 0x2::object::id<Vault<T0>>(arg0),
            id     : arg1,
            owner  : v0.owner,
            market : v0.market,
            reason : arg2,
            refund : v0.collateral,
        };
        0x2::event::emit<OrderCancelled>(v1);
    }

    fun register<T0>(arg0: &mut Vault<T0>, arg1: &Position) {
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, Market>(&mut arg0.markets, arg1.market);
        if (arg1.is_long) {
            v0.oi_long = v0.oi_long + arg1.size;
            v0.units_long = v0.units_long + arg1.units;
        } else {
            v0.oi_short = v0.oi_short + arg1.size;
            v0.units_short = v0.units_short + arg1.units;
        };
        v0.collateral = v0.collateral + arg1.collateral;
        v0.reserved = v0.reserved + arg1.reserved;
        v0.borrow_weighted = v0.borrow_weighted + (arg1.size as u256) * arg1.acc_borrow;
        arg0.collateral_total = arg0.collateral_total + arg1.collateral;
        arg0.reserved_total = arg0.reserved_total + arg1.reserved;
    }

    public fun request_withdraw<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg1 > 0, 25);
        assert!(shares_of<T0>(arg0, v0) >= arg1, 20);
        let v1 = 0x2::clock::timestamp_ms(arg2) + arg0.cooldown_ms;
        if (0x2::table::contains<address, Withdrawal>(&arg0.withdrawals, v0)) {
            0x2::table::remove<address, Withdrawal>(&mut arg0.withdrawals, v0);
        };
        let v2 = Withdrawal{
            shares    : arg1,
            unlock_ms : v1,
        };
        0x2::table::add<address, Withdrawal>(&mut arg0.withdrawals, v0, v2);
        let v3 = WithdrawRequested{
            vault     : 0x2::object::id<Vault<T0>>(arg0),
            who       : v0,
            shares    : arg1,
            unlock_ms : v1,
        };
        0x2::event::emit<WithdrawRequested>(v3);
    }

    fun reserve_fits<T0>(arg0: &Vault<T0>, arg1: u64) : bool {
        (arg1 as u128) * (10000 as u128) <= (lp_assets<T0>(arg0) as u128) * (arg0.util_cap_bps as u128)
    }

    public fun set_boost<T0>(arg0: &AdminCap, arg1: &mut Vault<T0>, arg2: u64, arg3: u64) {
        arg1.boost_end_ms = arg2;
        arg1.boost_assets = arg3;
    }

    public fun set_market_params<T0>(arg0: &AdminCap, arg1: &mut Vault<T0>, arg2: 0x2::object::ID, arg3: MarketParams, arg4: &0x2::clock::Clock) {
        validate_params(&arg3);
        assert!(0x2::table::contains<0x2::object::ID, Market>(&arg1.markets, arg2), 4);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, Market>(&mut arg1.markets, arg2);
        accrue(v0, 0x2::clock::timestamp_ms(arg4));
        v0.base = arg3;
        v0.params = arg3;
        let v1 = MarketParamsSet{
            vault     : 0x2::object::id<Vault<T0>>(arg1),
            market    : arg2,
            params    : arg3,
            by_keeper : false,
        };
        0x2::event::emit<MarketParamsSet>(v1);
    }

    public fun set_paused<T0>(arg0: &AdminCap, arg1: &mut Vault<T0>, arg2: bool) {
        arg1.paused = arg2;
    }

    fun set_status_inner<T0>(arg0: &mut Vault<T0>, arg1: 0x2::object::ID, arg2: u8) {
        assert!(arg2 <= 2, 27);
        assert!(0x2::table::contains<0x2::object::ID, Market>(&arg0.markets, arg1), 4);
        0x2::table::borrow_mut<0x2::object::ID, Market>(&mut arg0.markets, arg1).status = arg2;
        let v0 = MarketStatusSet{
            vault  : 0x2::object::id<Vault<T0>>(arg0),
            market : arg1,
            status : arg2,
        };
        0x2::event::emit<MarketStatusSet>(v0);
    }

    public fun set_tp_sl<T0>(arg0: &mut Vault<T0>, arg1: 0x2::object::ID, arg2: bool, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        let v0 = PosKey{
            owner   : 0x2::tx_context::sender(arg6),
            market  : arg1,
            is_long : arg2,
        };
        assert!(0x2::table::contains<PosKey, Position>(&arg0.positions, v0), 9);
        let v1 = 0x2::table::borrow_mut<PosKey, Position>(&mut arg0.positions, v0);
        v1.tp = arg3;
        v1.sl = arg4;
        v1.tpsl_ms = 0x2::clock::timestamp_ms(arg5);
        let v2 = *v1;
        emit_position<T0>(arg0, &v2);
    }

    public fun set_vault_config<T0>(arg0: &AdminCap, arg1: &mut Vault<T0>, arg2: address, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = if (arg3 <= 10000) {
            if (arg4 > 0) {
                arg4 <= 10000
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 5);
        arg1.treasury = arg2;
        arg1.protocol_share_bps = arg3;
        arg1.util_cap_bps = arg4;
        arg1.cooldown_ms = arg5;
    }

    fun settle_fees<T0>(arg0: &mut Vault<T0>, arg1: Position) : Position {
        let v0 = 0x2::table::borrow<0x2::object::ID, Market>(&arg0.markets, arg1.market);
        let (v1, v2) = if (arg1.is_long) {
            (v0.acc_paid_long, v0.acc_recv_long)
        } else {
            (v0.acc_paid_short, v0.acc_recv_short)
        };
        let v3 = (arg1.size as u256);
        let v4 = ((v3 * (v0.acc_borrow - arg1.acc_borrow) / 1000000000000000000) as u64);
        let v5 = ((v3 * (v1 - arg1.acc_paid) / 1000000000000000000) as u64);
        let v6 = ((v3 * (v2 - arg1.acc_recv) / 1000000000000000000) as u64);
        arg1.acc_borrow = v0.acc_borrow;
        arg1.acc_paid = v1;
        arg1.acc_recv = v2;
        let v7 = if (v4 == 0) {
            if (v5 == 0) {
                v6 == 0
            } else {
                false
            }
        } else {
            false
        };
        if (v7) {
            return arg1
        };
        let v8 = (arg1.collateral as u128) + (v6 as u128);
        let v9 = (v4 as u128) + (v5 as u128);
        let v10 = if (v8 >= v9) {
            v4
        } else {
            min(v4, (v8 as u64))
        };
        let v11 = if (v8 > v9) {
            ((v8 - v9) as u64)
        } else {
            0
        };
        arg1.collateral = v11;
        arg0.lp_borrow_income = arg0.lp_borrow_income + v10;
        let v12 = FeesSettled{
            vault            : 0x2::object::id<Vault<T0>>(arg0),
            owner            : arg1.owner,
            market           : arg1.market,
            is_long          : arg1.is_long,
            borrow           : v4,
            funding_paid     : v5,
            funding_received : v6,
        };
        0x2::event::emit<FeesSettled>(v12);
        arg1
    }

    public fun shares_of<T0>(arg0: &Vault<T0>, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.shares, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.shares, arg1)
        } else {
            0
        }
    }

    public fun spreads(arg0: &MarketParams) : (u64, u64, u64, u64) {
        (arg0.base_spread_bps, arg0.vol_spread_bps, arg0.max_spread_bps, arg0.depth_1pct)
    }

    fun take_fee<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: u64) {
        let v0 = mul_div(arg1, protocol_share_now<T0>(arg0, arg2), 10000);
        arg0.protocol_fees = arg0.protocol_fees + v0;
        arg0.lp_fee_income = arg0.lp_fee_income + arg1 - v0;
    }

    public fun total_shares<T0>(arg0: &Vault<T0>) : u64 {
        arg0.total_shares
    }

    public fun trigger_tp_sl<T0>(arg0: &mut Vault<T0>, arg1: address, arg2: bool, arg3: &0x2148b710eaf7a555ea1c792540509554db04bed3c34900b6d1102c3cb2321255::oracle::Feed, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0x2148b710eaf7a555ea1c792540509554db04bed3c34900b6d1102c3cb2321255::oracle::Feed>(arg3);
        let v1 = PosKey{
            owner   : arg1,
            market  : v0,
            is_long : arg2,
        };
        assert!(0x2::table::contains<PosKey, Position>(&arg0.positions, v1), 9);
        let (v2, v3) = fresh_price<T0>(arg0, arg3, arg4);
        let v4 = *0x2::table::borrow<PosKey, Position>(&arg0.positions, v1);
        assert!(v3 > v4.tpsl_ms, 17);
        let v5 = v4.tp > 0 && (arg2 && v2 >= v4.tp || v2 <= v4.tp);
        let v6 = v4.sl > 0 && (arg2 && v2 <= v4.sl || v2 >= v4.sl);
        assert!(v5 || v6, 17);
        let v7 = 0x2::table::borrow_mut<0x2::object::ID, Market>(&mut arg0.markets, v0);
        accrue(v7, 0x2::clock::timestamp_ms(arg4));
        let v8 = 0x2::table::borrow<0x2::object::ID, Market>(&arg0.markets, v0);
        let v9 = exec_price(v8, v2, !arg2, v4.size);
        let v10 = v9;
        let v11 = if (v6) {
            2
        } else {
            1
        };
        if (!v6) {
            if (arg2 && v9 > v4.tp) {
                v10 = v4.tp;
            };
            if (!arg2 && v10 < v4.tp) {
                v10 = v4.tp;
            };
        };
        close_part<T0>(arg0, v1, v4.size, v2, v10, v8.params.close_fee_bps, v11, 0x2::clock::timestamp_ms(arg4), arg5);
    }

    public fun unlock_lp(arg0: &MarketParams) : u64 {
        arg0.unlock_lp
    }

    fun unregister<T0>(arg0: &mut Vault<T0>, arg1: &Position) {
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, Market>(&mut arg0.markets, arg1.market);
        if (arg1.is_long) {
            v0.oi_long = v0.oi_long - arg1.size;
            v0.units_long = v0.units_long - arg1.units;
        } else {
            v0.oi_short = v0.oi_short - arg1.size;
            v0.units_short = v0.units_short - arg1.units;
        };
        v0.collateral = v0.collateral - arg1.collateral;
        v0.reserved = v0.reserved - arg1.reserved;
        v0.borrow_weighted = v0.borrow_weighted - (arg1.size as u256) * arg1.acc_borrow;
        arg0.collateral_total = arg0.collateral_total - arg1.collateral;
        arg0.reserved_total = arg0.reserved_total - arg1.reserved;
    }

    fun validate_params(arg0: &MarketParams) {
        assert!(arg0.max_leverage_x100 >= 100 && arg0.max_leverage_x100 <= 100000, 5);
        assert!(arg0.min_size > 0, 5);
        assert!(arg0.max_spread_bps < 10000 / 2, 5);
        assert!(arg0.base_spread_bps + arg0.vol_spread_bps <= arg0.max_spread_bps, 5);
        assert!(arg0.open_fee_bps <= 500 && arg0.close_fee_bps <= 500, 5);
        assert!((arg0.max_leverage_x100 as u128) * (arg0.open_fee_bps as u128) < 100 * (10000 as u128), 5);
        assert!(arg0.funding_max_bps_day <= 10000 && arg0.borrow_bps_day <= 10000, 5);
        assert!(arg0.liq_threshold_bps > 0 && arg0.liq_threshold_bps < 10000, 5);
        assert!(arg0.liq_reward_bps <= 500, 5);
        assert!(arg0.max_profit_bps > 0 && arg0.max_profit_bps <= 1000000, 5);
        let v0 = if (arg0.max_price_age_ms > 0) {
            if (arg0.max_dev_bps > 0) {
                arg0.order_timeout_ms > 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 5);
        assert!(arg0.max_oi_share_bps <= 10000, 5);
    }

    public fun vault_totals<T0>(arg0: &Vault<T0>) : (u64, u64, u64, u64, u64) {
        (arg0.collateral_total, arg0.pending_total, arg0.protocol_fees, arg0.reserved_total, arg0.util_cap_bps)
    }

    public fun withdrawal<T0>(arg0: &Vault<T0>, arg1: address) : (u64, u64) {
        if (0x2::table::contains<address, Withdrawal>(&arg0.withdrawals, arg1)) {
            let v2 = *0x2::table::borrow<address, Withdrawal>(&arg0.withdrawals, arg1);
            (v2.shares, v2.unlock_ms)
        } else {
            (0, 0)
        }
    }

    fun within(arg0: u64, arg1: u64, arg2: u64) : bool {
        let v0 = if (arg0 > arg1) {
            arg0 - arg1
        } else {
            arg1 - arg0
        };
        (v0 as u128) * (10000 as u128) <= (arg2 as u128) * (arg1 as u128)
    }

    // decompiled from Move bytecode v7
}

