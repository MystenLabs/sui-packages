module 0xdfe3063a3e1b7f9469abeeca4aae8ab30ffd729654f18dc3cdd37742fdcb8833::mandate {
    struct FeeVault has key {
        id: 0x2::object::UID,
        version: u64,
        fee_bps: u64,
        recipients: vector<address>,
        shares_bps: vector<u64>,
        pending: 0x2::balance::Balance<0x2::sui::SUI>,
        total_collected: u64,
        total_distributed: u64,
        frozen: bool,
    }

    struct FeeAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Mandate has key {
        id: 0x2::object::UID,
        version: u64,
        owner: address,
        operator: address,
        cash: 0x2::balance::Balance<0x2::sui::SUI>,
        positions: 0x2::bag::Bag,
        position_types: vector<0x1::type_name::TypeName>,
        cost_basis: 0x2::table::Table<0x1::type_name::TypeName, u64>,
        deployed: u64,
        paused: bool,
        open_ticket: bool,
        fee_owed: 0x2::balance::Balance<0x2::sui::SUI>,
        limits: Limits,
        budgets: Budgets,
        strategy: Strategy,
        stats: Stats,
        label: 0x1::string::String,
    }

    struct Limits has copy, drop, store {
        max_per_trade: u64,
        max_per_token: u64,
        max_deployed: u64,
        max_positions: u64,
        max_per_period: u64,
        period_ms: u64,
        expires_ms: u64,
        max_loss_bps: u64,
        max_loss_per_period: u64,
        max_sell_per_period: u64,
    }

    struct Budgets has copy, drop, store {
        spent_recent: u64,
        spent_at_ms: u64,
        loss_recent: u64,
        loss_at_ms: u64,
        sold_recent: u64,
        sold_at_ms: u64,
    }

    struct Strategy has copy, drop, store {
        follow: 0x2::vec_set::VecSet<address>,
        consensus: u64,
        per_token_sui: u64,
        stop_loss_bps: u64,
        take_profit_bps: u64,
        trail_bps: u64,
        max_slippage_bps: u64,
        allow_signals: bool,
    }

    struct Stats has copy, drop, store {
        trades: u64,
        realized_gain: u64,
        realized_loss: u64,
        fees_paid: u64,
    }

    struct BuyTicket {
        mandate: 0x2::object::ID,
        token: 0x1::type_name::TypeName,
        sui_in: u64,
        min_out: u64,
    }

    struct SellTicket {
        mandate: 0x2::object::ID,
        token: 0x1::type_name::TypeName,
        tokens_out: u64,
        cost_removed: u64,
        min_out: u64,
    }

    struct MandateCreated has copy, drop {
        mandate: 0x2::object::ID,
        owner: address,
        operator: address,
        label: 0x1::string::String,
    }

    struct Deposited has copy, drop {
        mandate: 0x2::object::ID,
        amount: u64,
        by: address,
    }

    struct Withdrawn has copy, drop {
        mandate: 0x2::object::ID,
        amount: u64,
    }

    struct PositionWithdrawn has copy, drop {
        mandate: 0x2::object::ID,
        token: 0x1::type_name::TypeName,
        amount: u64,
        cost_removed: u64,
    }

    struct Bought has copy, drop {
        mandate: 0x2::object::ID,
        token: 0x1::type_name::TypeName,
        sui_in: u64,
        tokens_out: u64,
        cost_basis: u64,
    }

    struct Sold has copy, drop {
        mandate: 0x2::object::ID,
        token: 0x1::type_name::TypeName,
        tokens_in: u64,
        sui_out: u64,
        cost_removed: u64,
        gain: u64,
        loss: u64,
        closed: bool,
    }

    struct StrategyUpdated has copy, drop {
        mandate: 0x2::object::ID,
    }

    struct LimitsUpdated has copy, drop {
        mandate: 0x2::object::ID,
    }

    struct OperatorChanged has copy, drop {
        mandate: 0x2::object::ID,
        operator: address,
    }

    struct PausedChanged has copy, drop {
        mandate: 0x2::object::ID,
        paused: bool,
    }

    struct Closed has copy, drop {
        mandate: 0x2::object::ID,
        returned: u64,
    }

    struct FeeCharged has copy, drop {
        mandate: 0x2::object::ID,
        buy: bool,
        amount: u64,
    }

    struct FeesDistributed has copy, drop {
        amount: u64,
        recipients: vector<address>,
        amounts: vector<u64>,
    }

    struct FeeConfigChanged has copy, drop {
        fee_bps: u64,
        recipients: vector<address>,
        shares_bps: vector<u64>,
        frozen: bool,
    }

    struct FeesSwept has copy, drop {
        mandate: 0x2::object::ID,
        amount: u64,
    }

    public fun withdraw_all(arg0: &mut Mandate, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.cash);
        if (v0 > 0) {
            withdraw(arg0, v0, arg1);
        } else {
            assert!(0x2::tx_context::sender(arg1) == arg0.owner, 0);
        };
    }

    public fun allows_signals(arg0: &Mandate) : bool {
        arg0.strategy.allow_signals
    }

    public fun begin_buy<T0>(arg0: &mut Mandate, arg1: &FeeVault, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, BuyTicket) {
        assert!(arg0.version == 1 && arg1.version == 1, 30);
        assert!(0x2::tx_context::sender(arg5) == arg0.operator, 1);
        assert!(!arg0.paused, 2);
        assert!(arg0.limits.expires_ms == 0 || 0x2::clock::timestamp_ms(arg4) < arg0.limits.expires_ms, 3);
        assert!(arg2 > 0, 4);
        assert!(arg2 <= arg0.limits.max_per_trade, 5);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(v0 != 0x1::type_name::with_defining_ids<0x2::sui::SUI>(), 21);
        let v1 = if (0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.cost_basis, v0)) {
            *0x2::table::borrow<0x1::type_name::TypeName, u64>(&arg0.cost_basis, v0)
        } else {
            0
        };
        assert!(v1 + arg2 <= arg0.limits.max_per_token, 6);
        assert!(arg0.deployed + arg2 <= arg0.limits.max_deployed, 7);
        assert!(!arg0.open_ticket, 23);
        let (v2, v3) = decay(arg0.budgets.spent_recent, arg0.budgets.spent_at_ms, arg0.limits.max_per_period, arg0.limits.period_ms, 0x2::clock::timestamp_ms(arg4));
        assert!(v2 + arg2 <= arg0.limits.max_per_period, 8);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.cash) >= arg2, 10);
        if (0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.cost_basis, v0)) {
            let v4 = 0x2::table::borrow_mut<0x1::type_name::TypeName, u64>(&mut arg0.cost_basis, v0);
            *v4 = *v4 + arg2;
        } else {
            assert!(0x1::vector::length<0x1::type_name::TypeName>(&arg0.position_types) < arg0.limits.max_positions, 9);
            0x2::table::add<0x1::type_name::TypeName, u64>(&mut arg0.cost_basis, v0, arg2);
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg0.position_types, v0);
        };
        arg0.deployed = arg0.deployed + arg2;
        arg0.budgets.spent_recent = v2 + arg2;
        arg0.budgets.spent_at_ms = v3;
        arg0.open_ticket = true;
        let v5 = 0x2::balance::split<0x2::sui::SUI>(&mut arg0.cash, arg2);
        let v6 = fee_of(arg1, arg2);
        if (v6 > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.fee_owed, 0x2::balance::split<0x2::sui::SUI>(&mut v5, v6));
            arg0.stats.fees_paid = arg0.stats.fees_paid + v6;
            let v7 = FeeCharged{
                mandate : 0x2::object::id<Mandate>(arg0),
                buy     : true,
                amount  : v6,
            };
            0x2::event::emit<FeeCharged>(v7);
        };
        let v8 = BuyTicket{
            mandate : 0x2::object::id<Mandate>(arg0),
            token   : v0,
            sui_in  : arg2,
            min_out : arg3,
        };
        (0x2::coin::from_balance<0x2::sui::SUI>(v5, arg5), v8)
    }

    public fun begin_sell<T0>(arg0: &mut Mandate, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, SellTicket) {
        assert!(arg0.version == 1, 30);
        assert!(0x2::tx_context::sender(arg3) == arg0.operator, 1);
        assert!(!arg0.paused, 2);
        assert!(!arg0.open_ticket, 23);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.positions, v0), 15);
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.positions, v0);
        let v2 = 0x2::balance::value<T0>(v1);
        let v3 = if (arg1 == 0) {
            v2
        } else {
            arg1
        };
        assert!(v3 > 0, 4);
        assert!(v3 <= v2, 22);
        let v4 = *0x2::table::borrow<0x1::type_name::TypeName, u64>(&arg0.cost_basis, v0);
        let v5 = if (v3 == v2) {
            v4
        } else {
            let v6 = ((((v4 as u128) * (v3 as u128) + (v2 as u128) - 1) / (v2 as u128)) as u64);
            if (v6 >= v4) {
                if (v4 > 0) {
                    v4 - 1
                } else {
                    0
                }
            } else {
                v6
            }
        };
        let v7 = 0x2::table::borrow_mut<0x1::type_name::TypeName, u64>(&mut arg0.cost_basis, v0);
        *v7 = *v7 - v5;
        arg0.deployed = arg0.deployed - v5;
        arg0.open_ticket = true;
        let v8 = SellTicket{
            mandate      : 0x2::object::id<Mandate>(arg0),
            token        : v0,
            tokens_out   : v3,
            cost_removed : v5,
            min_out      : arg2,
        };
        (0x2::coin::take<T0>(v1, v3, arg3), v8)
    }

    public fun can_buy<T0>(arg0: &Mandate, arg1: &0x2::clock::Clock) : u64 {
        let v0 = if (arg0.paused) {
            true
        } else if (arg0.operator == @0x0) {
            true
        } else if (arg0.open_ticket) {
            true
        } else {
            arg0.version != 1
        };
        if (v0) {
            return 0
        };
        if (0x1::type_name::with_defining_ids<T0>() == 0x1::type_name::with_defining_ids<0x2::sui::SUI>()) {
            return 0
        };
        if (arg0.limits.expires_ms != 0 && 0x2::clock::timestamp_ms(arg1) >= arg0.limits.expires_ms) {
            return 0
        };
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.positions, v1) && 0x1::vector::length<0x1::type_name::TypeName>(&arg0.position_types) >= arg0.limits.max_positions) {
            return 0
        };
        let v2 = if (0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.cost_basis, v1)) {
            *0x2::table::borrow<0x1::type_name::TypeName, u64>(&arg0.cost_basis, v1)
        } else {
            0
        };
        min(min(min(min(arg0.limits.max_per_trade, arg0.limits.max_per_token - min(arg0.limits.max_per_token, v2)), arg0.limits.max_deployed - min(arg0.limits.max_deployed, arg0.deployed)), remaining_in_period(arg0, arg1)), 0x2::balance::value<0x2::sui::SUI>(&arg0.cash))
    }

    public fun cash(arg0: &Mandate) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.cash)
    }

    fun check_limits(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = if (arg0 > 0) {
            if (arg1 >= arg0) {
                arg2 >= arg1
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 11);
        assert!(arg3 > 0 && arg3 <= 50, 11);
        assert!(arg4 >= arg0, 11);
        assert!(arg5 >= 60000 && arg5 <= 31536000000, 12);
    }

    public fun close(arg0: Mandate, arg1: &mut FeeVault, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 0);
        assert!(0x1::vector::length<0x1::type_name::TypeName>(&arg0.position_types) == 0, 19);
        let Mandate {
            id             : v0,
            version        : _,
            owner          : v2,
            operator       : _,
            cash           : v4,
            positions      : v5,
            position_types : _,
            cost_basis     : v7,
            deployed       : _,
            paused         : _,
            open_ticket    : _,
            fee_owed       : v11,
            limits         : _,
            budgets        : _,
            strategy       : _,
            stats          : _,
            label          : _,
        } = arg0;
        let v17 = v11;
        let v18 = v4;
        let v19 = v0;
        let v20 = 0x2::balance::value<0x2::sui::SUI>(&v17);
        if (v20 > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg1.pending, v17);
            arg1.total_collected = arg1.total_collected + v20;
            let v21 = FeesSwept{
                mandate : 0x2::object::uid_to_inner(&v19),
                amount  : v20,
            };
            0x2::event::emit<FeesSwept>(v21);
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v17);
        };
        let v22 = 0x2::balance::value<0x2::sui::SUI>(&v18);
        let v23 = Closed{
            mandate  : 0x2::object::uid_to_inner(&v19),
            returned : v22,
        };
        0x2::event::emit<Closed>(v23);
        if (v22 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v18, arg2), v2);
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v18);
        };
        0x2::bag::destroy_empty(v5);
        0x2::table::drop<0x1::type_name::TypeName, u64>(v7);
        0x2::object::delete(v19);
    }

    fun close_if_empty<T0>(arg0: &mut Mandate, arg1: 0x1::type_name::TypeName) : bool {
        if (0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.positions, arg1)) > 0) {
            return false
        };
        0x2::balance::destroy_zero<T0>(0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.positions, arg1));
        0x2::table::remove<0x1::type_name::TypeName, u64>(&mut arg0.cost_basis, arg1);
        let (v0, v1) = 0x1::vector::index_of<0x1::type_name::TypeName>(&arg0.position_types, &arg1);
        if (v0) {
            0x1::vector::swap_remove<0x1::type_name::TypeName>(&mut arg0.position_types, v1);
        };
        true
    }

    public fun cost_basis<T0>(arg0: &Mandate) : u64 {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.cost_basis, v0)) {
            *0x2::table::borrow<0x1::type_name::TypeName, u64>(&arg0.cost_basis, v0)
        } else {
            0
        }
    }

    public fun create(arg0: address, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: 0x1::string::String, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        check_limits(arg1, arg2, arg3, arg4, arg5, arg6);
        assert!(arg7 == 0 || arg7 > 0x2::clock::timestamp_ms(arg9), 13);
        assert!(0x1::string::length(&arg8) <= 64, 20);
        let v0 = 0x2::clock::timestamp_ms(arg9);
        let v1 = Limits{
            max_per_trade       : arg1,
            max_per_token       : arg2,
            max_deployed        : arg3,
            max_positions       : arg4,
            max_per_period      : arg5,
            period_ms           : arg6,
            expires_ms          : arg7,
            max_loss_bps        : 5000,
            max_loss_per_period : max(arg5 / 2, 1),
            max_sell_per_period : arg5,
        };
        let v2 = Budgets{
            spent_recent : 0,
            spent_at_ms  : v0,
            loss_recent  : 0,
            loss_at_ms   : v0,
            sold_recent  : 0,
            sold_at_ms   : v0,
        };
        let v3 = Strategy{
            follow           : 0x2::vec_set::empty<address>(),
            consensus        : 1,
            per_token_sui    : arg1,
            stop_loss_bps    : 0,
            take_profit_bps  : 0,
            trail_bps        : 0,
            max_slippage_bps : 300,
            allow_signals    : false,
        };
        let v4 = Stats{
            trades        : 0,
            realized_gain : 0,
            realized_loss : 0,
            fees_paid     : 0,
        };
        let v5 = Mandate{
            id             : 0x2::object::new(arg10),
            version        : 1,
            owner          : 0x2::tx_context::sender(arg10),
            operator       : arg0,
            cash           : 0x2::balance::zero<0x2::sui::SUI>(),
            positions      : 0x2::bag::new(arg10),
            position_types : 0x1::vector::empty<0x1::type_name::TypeName>(),
            cost_basis     : 0x2::table::new<0x1::type_name::TypeName, u64>(arg10),
            deployed       : 0,
            paused         : false,
            open_ticket    : false,
            fee_owed       : 0x2::balance::zero<0x2::sui::SUI>(),
            limits         : v1,
            budgets        : v2,
            strategy       : v3,
            stats          : v4,
            label          : arg8,
        };
        let v6 = MandateCreated{
            mandate  : 0x2::object::id<Mandate>(&v5),
            owner    : v5.owner,
            operator : arg0,
            label    : v5.label,
        };
        0x2::event::emit<MandateCreated>(v6);
        0x2::transfer::share_object<Mandate>(v5);
    }

    fun decay(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : (u64, u64) {
        if (arg0 == 0 || arg4 <= arg1) {
            let v0 = if (arg4 > arg1) {
                arg4
            } else {
                arg1
            };
            return (arg0, v0)
        };
        let v1 = ((arg4 - arg1) as u128) * (arg2 as u128) / (arg3 as u128);
        if (v1 >= (arg0 as u128)) {
            return (0, arg4)
        };
        let v2 = (((v1 * (arg3 as u128) + (arg2 as u128) - 1) / (arg2 as u128)) as u64);
        let v3 = if (arg1 + v2 > arg4) {
            arg4 - arg1
        } else {
            v2
        };
        (arg0 - (v1 as u64), arg1 + v3)
    }

    fun decayed(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        let (v0, _) = decay(arg0, arg1, arg2, arg3, arg4);
        v0
    }

    public fun deployed(arg0: &Mandate) : u64 {
        arg0.deployed
    }

    public fun deposit(arg0: &mut Mandate, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 > 0, 4);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.cash, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v1 = Deposited{
            mandate : 0x2::object::id<Mandate>(arg0),
            amount  : v0,
            by      : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<Deposited>(v1);
    }

    public fun distribute(arg0: &mut FeeVault, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 30);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.pending) > 0, 28);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.pending) >= 10000000, 33);
        do_distribute(arg0, arg1);
    }

    fun do_distribute(arg0: &mut FeeVault, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.pending);
        if (v0 == 0) {
            return
        };
        let v1 = 0x1::vector::length<address>(&arg0.recipients);
        let v2 = vector[];
        let v3 = 0;
        while (v3 < v1) {
            let v4 = if (v3 + 1 == v1) {
                0x2::balance::value<0x2::sui::SUI>(&arg0.pending)
            } else {
                (((v0 as u128) * (*0x1::vector::borrow<u64>(&arg0.shares_bps, v3) as u128) / (10000 as u128)) as u64)
            };
            if (v4 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.pending, v4, arg1), *0x1::vector::borrow<address>(&arg0.recipients, v3));
            };
            0x1::vector::push_back<u64>(&mut v2, v4);
            v3 = v3 + 1;
        };
        arg0.total_distributed = arg0.total_distributed + v0;
        let v5 = FeesDistributed{
            amount     : v0,
            recipients : arg0.recipients,
            amounts    : v2,
        };
        0x2::event::emit<FeesDistributed>(v5);
    }

    fun emit_fee_config(arg0: &FeeVault) {
        let v0 = FeeConfigChanged{
            fee_bps    : arg0.fee_bps,
            recipients : arg0.recipients,
            shares_bps : arg0.shares_bps,
            frozen     : arg0.frozen,
        };
        0x2::event::emit<FeeConfigChanged>(v0);
    }

    public fun expires_ms(arg0: &Mandate) : u64 {
        arg0.limits.expires_ms
    }

    public fun fee_bps(arg0: &FeeVault) : u64 {
        arg0.fee_bps
    }

    fun fee_of(arg0: &FeeVault, arg1: u64) : u64 {
        (((arg1 as u128) * (arg0.fee_bps as u128) / (10000 as u128)) as u64)
    }

    public fun fee_owed(arg0: &Mandate) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.fee_owed)
    }

    public fun fee_split(arg0: &FeeVault) : (vector<address>, vector<u64>, bool) {
        (arg0.recipients, arg0.shares_bps, arg0.frozen)
    }

    public fun fee_totals(arg0: &FeeVault) : (u64, u64, u64) {
        (0x2::balance::value<0x2::sui::SUI>(&arg0.pending), arg0.total_collected, arg0.total_distributed)
    }

    public fun fees_paid(arg0: &Mandate) : u64 {
        arg0.stats.fees_paid
    }

    public fun finish_buy<T0>(arg0: &mut Mandate, arg1: BuyTicket, arg2: 0x2::coin::Coin<T0>) {
        let BuyTicket {
            mandate : v0,
            token   : v1,
            sui_in  : v2,
            min_out : v3,
        } = arg1;
        assert!(v0 == 0x2::object::id<Mandate>(arg0), 16);
        assert!(v1 == 0x1::type_name::with_defining_ids<T0>(), 16);
        let v4 = 0x2::coin::value<T0>(&arg2);
        assert!(v4 > 0 && v4 >= v3, 14);
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.positions, v1)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.positions, v1), 0x2::coin::into_balance<T0>(arg2));
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.positions, v1, 0x2::coin::into_balance<T0>(arg2));
        };
        arg0.open_ticket = false;
        arg0.stats.trades = arg0.stats.trades + 1;
        let v5 = Bought{
            mandate    : v0,
            token      : v1,
            sui_in     : v2,
            tokens_out : v4,
            cost_basis : *0x2::table::borrow<0x1::type_name::TypeName, u64>(&arg0.cost_basis, v1),
        };
        0x2::event::emit<Bought>(v5);
    }

    public fun finish_sell<T0>(arg0: &mut Mandate, arg1: &FeeVault, arg2: SellTicket, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::clock::Clock) {
        let SellTicket {
            mandate      : v0,
            token        : v1,
            tokens_out   : v2,
            cost_removed : v3,
            min_out      : v4,
        } = arg2;
        assert!(v0 == 0x2::object::id<Mandate>(arg0), 16);
        assert!(v1 == 0x1::type_name::with_defining_ids<T0>(), 16);
        let v5 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        assert!(v5 > 0 && v5 >= v4, 14);
        assert!((v5 as u128) * (10000 as u128) >= (v3 as u128) * ((10000 - arg0.limits.max_loss_bps) as u128), 24);
        let v6 = 0x2::clock::timestamp_ms(arg4);
        let (v7, v8) = decay(arg0.budgets.sold_recent, arg0.budgets.sold_at_ms, arg0.limits.max_sell_per_period, arg0.limits.period_ms, v6);
        assert!(v7 + v3 <= arg0.limits.max_sell_per_period, 35);
        arg0.budgets.sold_recent = v7 + v3;
        arg0.budgets.sold_at_ms = v8;
        if (v5 < v3) {
            let (v9, v10) = decay(arg0.budgets.loss_recent, arg0.budgets.loss_at_ms, arg0.limits.max_loss_per_period, arg0.limits.period_ms, v6);
            let v11 = v3 - v5;
            assert!(v9 + v11 <= arg0.limits.max_loss_per_period, 32);
            arg0.budgets.loss_recent = v9 + v11;
            arg0.budgets.loss_at_ms = v10;
        };
        let v12 = 0x2::coin::into_balance<0x2::sui::SUI>(arg3);
        let v13 = fee_of(arg1, v5);
        if (v13 > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.fee_owed, 0x2::balance::split<0x2::sui::SUI>(&mut v12, v13));
            arg0.stats.fees_paid = arg0.stats.fees_paid + v13;
            let v14 = FeeCharged{
                mandate : v0,
                buy     : false,
                amount  : v13,
            };
            0x2::event::emit<FeeCharged>(v14);
        };
        let v15 = 0x2::balance::value<0x2::sui::SUI>(&v12);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.cash, v12);
        arg0.open_ticket = false;
        let (v16, v17) = if (v15 >= v3) {
            (v15 - v3, 0)
        } else {
            (0, v3 - v15)
        };
        arg0.stats.realized_gain = arg0.stats.realized_gain + v16;
        arg0.stats.realized_loss = arg0.stats.realized_loss + v17;
        arg0.stats.trades = arg0.stats.trades + 1;
        let v18 = Sold{
            mandate      : v0,
            token        : v1,
            tokens_in    : v2,
            sui_out      : v15,
            cost_removed : v3,
            gain         : v16,
            loss         : v17,
            closed       : close_if_empty<T0>(arg0, v1),
        };
        0x2::event::emit<Sold>(v18);
    }

    public fun has_position<T0>(arg0: &Mandate) : bool {
        0x2::bag::contains<0x1::type_name::TypeName>(&arg0.positions, 0x1::type_name::with_defining_ids<T0>())
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v0, 0x2::tx_context::sender(arg0));
        let v1 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v1, 10000);
        let v2 = FeeVault{
            id                : 0x2::object::new(arg0),
            version           : 1,
            fee_bps           : 100,
            recipients        : v0,
            shares_bps        : v1,
            pending           : 0x2::balance::zero<0x2::sui::SUI>(),
            total_collected   : 0,
            total_distributed : 0,
            frozen            : false,
        };
        0x2::transfer::share_object<FeeVault>(v2);
        let v3 = FeeAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<FeeAdminCap>(v3, 0x2::tx_context::sender(arg0));
    }

    public fun is_paused(arg0: &Mandate) : bool {
        arg0.paused
    }

    public fun limits(arg0: &Mandate) : (u64, u64, u64, u64, u64, u64) {
        (arg0.limits.max_per_trade, arg0.limits.max_per_token, arg0.limits.max_deployed, arg0.limits.max_positions, arg0.limits.max_per_period, arg0.limits.period_ms)
    }

    public fun lock_config(arg0: &FeeAdminCap, arg1: &mut FeeVault, arg2: u64, arg3: vector<address>, arg4: vector<u64>) {
        assert!(arg1.version == 1, 30);
        assert!(!arg1.frozen, 27);
        let v0 = if (arg1.fee_bps == arg2) {
            if (arg1.recipients == arg3) {
                arg1.shares_bps == arg4
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 31);
        arg1.frozen = true;
        emit_fee_config(arg1);
    }

    public fun loss_room(arg0: &Mandate, arg1: &0x2::clock::Clock) : u64 {
        arg0.limits.max_loss_per_period - min(arg0.limits.max_loss_per_period, decayed(arg0.budgets.loss_recent, arg0.budgets.loss_at_ms, arg0.limits.max_loss_per_period, arg0.limits.period_ms, 0x2::clock::timestamp_ms(arg1)))
    }

    fun max(arg0: u64, arg1: u64) : u64 {
        if (arg0 > arg1) {
            arg0
        } else {
            arg1
        }
    }

    public fun max_loss_bps(arg0: &Mandate) : u64 {
        arg0.limits.max_loss_bps
    }

    public fun max_loss_per_period(arg0: &Mandate) : u64 {
        arg0.limits.max_loss_per_period
    }

    public fun max_sell_per_period(arg0: &Mandate) : u64 {
        arg0.limits.max_sell_per_period
    }

    public fun migrate(arg0: &mut Mandate, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 0);
        assert!(arg0.version < 1, 34);
        arg0.version = 1;
    }

    public fun migrate_vault(arg0: &FeeAdminCap, arg1: &mut FeeVault) {
        assert!(arg1.version < 1, 34);
        arg1.version = 1;
    }

    fun min(arg0: u64, arg1: u64) : u64 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    public fun operator(arg0: &Mandate) : address {
        arg0.operator
    }

    public fun owner(arg0: &Mandate) : address {
        arg0.owner
    }

    public fun pause(arg0: &mut Mandate, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 0);
        arg0.paused = true;
        let v0 = PausedChanged{
            mandate : 0x2::object::id<Mandate>(arg0),
            paused  : true,
        };
        0x2::event::emit<PausedChanged>(v0);
    }

    public fun position<T0>(arg0: &Mandate) : u64 {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.positions, v0)) {
            0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.positions, v0))
        } else {
            0
        }
    }

    public fun position_types(arg0: &Mandate) : vector<0x1::type_name::TypeName> {
        arg0.position_types
    }

    public fun remaining_in_period(arg0: &Mandate, arg1: &0x2::clock::Clock) : u64 {
        arg0.limits.max_per_period - min(arg0.limits.max_per_period, decayed(arg0.budgets.spent_recent, arg0.budgets.spent_at_ms, arg0.limits.max_per_period, arg0.limits.period_ms, 0x2::clock::timestamp_ms(arg1)))
    }

    public fun resume(arg0: &mut Mandate, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 30);
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 0);
        arg0.paused = false;
        let v0 = PausedChanged{
            mandate : 0x2::object::id<Mandate>(arg0),
            paused  : false,
        };
        0x2::event::emit<PausedChanged>(v0);
    }

    public fun sell_room(arg0: &Mandate, arg1: &0x2::clock::Clock) : u64 {
        arg0.limits.max_sell_per_period - min(arg0.limits.max_sell_per_period, decayed(arg0.budgets.sold_recent, arg0.budgets.sold_at_ms, arg0.limits.max_sell_per_period, arg0.limits.period_ms, 0x2::clock::timestamp_ms(arg1)))
    }

    public fun set_exit_limits(arg0: &mut Mandate, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 30);
        assert!(0x2::tx_context::sender(arg4) == arg0.owner, 0);
        let v0 = if (arg1 < 10000) {
            if (arg2 > 0) {
                arg3 > 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 11);
        arg0.limits.max_loss_bps = arg1;
        arg0.limits.max_loss_per_period = arg2;
        arg0.limits.max_sell_per_period = arg3;
        let v1 = LimitsUpdated{mandate: 0x2::object::id<Mandate>(arg0)};
        0x2::event::emit<LimitsUpdated>(v1);
    }

    public fun set_expiry(arg0: &mut Mandate, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 30);
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 0);
        assert!(arg1 == 0 || arg1 > 0x2::clock::timestamp_ms(arg2), 13);
        arg0.limits.expires_ms = arg1;
        let v0 = LimitsUpdated{mandate: 0x2::object::id<Mandate>(arg0)};
        0x2::event::emit<LimitsUpdated>(v0);
    }

    public fun set_fee_bps(arg0: &FeeAdminCap, arg1: &mut FeeVault, arg2: u64) {
        assert!(arg1.version == 1, 30);
        assert!(!arg1.frozen, 27);
        assert!(arg2 <= 100, 25);
        arg1.fee_bps = arg2;
        emit_fee_config(arg1);
    }

    public fun set_limits(arg0: &mut Mandate, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 30);
        assert!(0x2::tx_context::sender(arg7) == arg0.owner, 0);
        check_limits(arg1, arg2, arg3, arg4, arg5, arg6);
        arg0.limits.max_per_trade = arg1;
        arg0.limits.max_per_token = arg2;
        arg0.limits.max_deployed = arg3;
        arg0.limits.max_positions = arg4;
        arg0.limits.max_per_period = arg5;
        arg0.limits.period_ms = arg6;
        if (arg0.strategy.per_token_sui > arg1) {
            arg0.strategy.per_token_sui = arg1;
        };
        let v0 = LimitsUpdated{mandate: 0x2::object::id<Mandate>(arg0)};
        0x2::event::emit<LimitsUpdated>(v0);
    }

    public fun set_operator(arg0: &mut Mandate, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 0);
        arg0.operator = arg1;
        let v0 = OperatorChanged{
            mandate  : 0x2::object::id<Mandate>(arg0),
            operator : arg1,
        };
        0x2::event::emit<OperatorChanged>(v0);
    }

    public fun set_signals(arg0: &mut Mandate, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 30);
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 0);
        arg0.strategy.allow_signals = arg1;
        let v0 = StrategyUpdated{mandate: 0x2::object::id<Mandate>(arg0)};
        0x2::event::emit<StrategyUpdated>(v0);
    }

    public fun set_split(arg0: &FeeAdminCap, arg1: &mut FeeVault, arg2: vector<address>, arg3: vector<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 30);
        assert!(!arg1.frozen, 27);
        let v0 = 0x1::vector::length<address>(&arg2);
        let v1 = if (v0 > 0) {
            if (v0 <= 8) {
                v0 == 0x1::vector::length<u64>(&arg3)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 26);
        let v2 = 0;
        let v3 = 0;
        while (v3 < v0) {
            assert!(*0x1::vector::borrow<u64>(&arg3, v3) > 0 && *0x1::vector::borrow<address>(&arg2, v3) != @0x0, 26);
            v2 = v2 + *0x1::vector::borrow<u64>(&arg3, v3);
            v3 = v3 + 1;
        };
        assert!(v2 == 10000, 26);
        do_distribute(arg1, arg4);
        arg1.recipients = arg2;
        arg1.shares_bps = arg3;
        emit_fee_config(arg1);
    }

    public fun set_strategy(arg0: &mut Mandate, arg1: vector<address>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 30);
        assert!(0x2::tx_context::sender(arg8) == arg0.owner, 0);
        assert!(0x1::vector::length<address>(&arg1) <= 32, 17);
        assert!(arg2 >= 1 && (0x1::vector::length<address>(&arg1) == 0 || arg2 <= 0x1::vector::length<address>(&arg1)), 18);
        assert!(arg3 > 0 && arg3 <= arg0.limits.max_per_trade, 18);
        let v0 = if (arg4 < 10000) {
            if (arg6 < 10000) {
                arg7 < 10000
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 18);
        let v1 = 0x2::vec_set::empty<address>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&arg1)) {
            assert!(!0x2::vec_set::contains<address>(&v1, 0x1::vector::borrow<address>(&arg1, v2)), 18);
            0x2::vec_set::insert<address>(&mut v1, *0x1::vector::borrow<address>(&arg1, v2));
            v2 = v2 + 1;
        };
        arg0.strategy.follow = v1;
        arg0.strategy.consensus = arg2;
        arg0.strategy.per_token_sui = arg3;
        arg0.strategy.stop_loss_bps = arg4;
        arg0.strategy.take_profit_bps = arg5;
        arg0.strategy.trail_bps = arg6;
        arg0.strategy.max_slippage_bps = arg7;
        let v3 = StrategyUpdated{mandate: 0x2::object::id<Mandate>(arg0)};
        0x2::event::emit<StrategyUpdated>(v3);
    }

    public fun stats(arg0: &Mandate) : (u64, u64, u64) {
        (arg0.stats.trades, arg0.stats.realized_gain, arg0.stats.realized_loss)
    }

    public fun strategy(arg0: &Mandate) : (vector<address>, u64, u64, u64, u64, u64, u64) {
        (0x2::vec_set::into_keys<address>(arg0.strategy.follow), arg0.strategy.consensus, arg0.strategy.per_token_sui, arg0.strategy.stop_loss_bps, arg0.strategy.take_profit_bps, arg0.strategy.trail_bps, arg0.strategy.max_slippage_bps)
    }

    public fun sweep(arg0: &mut Mandate, arg1: &mut FeeVault) {
        assert!(arg1.version == 1, 30);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.fee_owed);
        assert!(v0 >= 10000000, 33);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.pending, 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.fee_owed));
        arg1.total_collected = arg1.total_collected + v0;
        let v1 = FeesSwept{
            mandate : 0x2::object::id<Mandate>(arg0),
            amount  : v0,
        };
        0x2::event::emit<FeesSwept>(v1);
    }

    public fun version(arg0: &Mandate) : u64 {
        arg0.version
    }

    public fun withdraw(arg0: &mut Mandate, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 0);
        assert!(arg1 > 0 && arg1 <= 0x2::balance::value<0x2::sui::SUI>(&arg0.cash), 10);
        let v0 = Withdrawn{
            mandate : 0x2::object::id<Mandate>(arg0),
            amount  : arg1,
        };
        0x2::event::emit<Withdrawn>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.cash, arg1, arg2), arg0.owner);
    }

    public fun withdraw_position<T0>(arg0: &mut Mandate, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 0);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.positions, v0), 15);
        let v1 = 0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.positions, v0);
        let v2 = 0x2::table::remove<0x1::type_name::TypeName, u64>(&mut arg0.cost_basis, v0);
        arg0.deployed = arg0.deployed - v2;
        let (v3, v4) = 0x1::vector::index_of<0x1::type_name::TypeName>(&arg0.position_types, &v0);
        if (v3) {
            0x1::vector::swap_remove<0x1::type_name::TypeName>(&mut arg0.position_types, v4);
        };
        let v5 = PositionWithdrawn{
            mandate      : 0x2::object::id<Mandate>(arg0),
            token        : v0,
            amount       : 0x2::balance::value<T0>(&v1),
            cost_removed : v2,
        };
        0x2::event::emit<PositionWithdrawn>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v1, arg1), arg0.owner);
    }

    // decompiled from Move bytecode v7
}

