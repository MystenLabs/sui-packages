module 0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::house {
    struct House<phantom T0> has key {
        id: 0x2::object::UID,
        paused: bool,
        fee_bps: u64,
        min_bet: u64,
        max_profit_bps: u64,
        bankroll: 0x2::balance::Balance<T0>,
        fees: 0x2::balance::Balance<T0>,
        reserved: u64,
        liabilities: u64,
        total_shares: u64,
        acc_fee_per_share: u256,
        team: 0x2::vec_set::VecSet<address>,
        positions: 0x2::table::Table<address, Position>,
        stats: 0x2::table::Table<address, PlayerStats>,
        top_all: vector<Entry>,
        top_week: vector<Entry>,
        week_id: u64,
        total_wagered: u128,
        total_paid_out: u128,
        total_bets: u64,
        total_fees: u128,
        games: vector<GameControl>,
    }

    struct GameControl has copy, drop, store {
        enabled: bool,
        max_daily_loss_bps: u64,
        day: u64,
        staked: u128,
        paid: u128,
        open: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        house: 0x2::object::ID,
    }

    struct Position has copy, drop, store {
        shares: u64,
        fee_debt: u256,
        unclaimed: u64,
        deposited: u128,
        withdrawn: u128,
        fees_claimed: u128,
    }

    struct PlayerStats has copy, drop, store {
        wagered: u128,
        paid_out: u128,
        bets: u64,
        week_id: u64,
        week_wagered: u128,
    }

    struct Entry has copy, drop, store {
        player: address,
        wagered: u128,
    }

    struct HouseCreated has copy, drop {
        house: 0x2::object::ID,
        admin_cap: 0x2::object::ID,
    }

    struct BetSettled has copy, drop {
        house: 0x2::object::ID,
        game: u8,
        player: address,
        wager: u64,
        payout: u64,
    }

    struct BetProgress has copy, drop {
        house: 0x2::object::ID,
        game: u8,
        player: address,
        wager: u64,
        liability: u64,
    }

    struct WeekFinalized has copy, drop {
        house: 0x2::object::ID,
        week_id: u64,
        top: vector<Entry>,
    }

    struct TeamDeposited has copy, drop {
        house: 0x2::object::ID,
        member: address,
        amount: u64,
        shares: u64,
    }

    struct TeamWithdrew has copy, drop {
        house: 0x2::object::ID,
        member: address,
        amount: u64,
        shares: u64,
    }

    struct FeesClaimed has copy, drop {
        house: 0x2::object::ID,
        member: address,
        amount: u64,
    }

    public fun add_team_member<T0>(arg0: &mut House<T0>, arg1: &AdminCap, arg2: address) {
        assert_cap<T0>(arg0, arg1);
        if (0x2::vec_set::contains<address>(&arg0.team, &arg2)) {
            return
        };
        assert!(0x2::vec_set::length<address>(&arg0.team) < 50, 14);
        0x2::vec_set::insert<address>(&mut arg0.team, arg2);
    }

    public(friend) fun assert_accepting<T0>(arg0: &House<T0>, arg1: u8, arg2: u64) {
        assert!(!arg0.paused, 1);
        assert!(0x1::vector::borrow<GameControl>(&arg0.games, (arg1 as u64)).enabled, 19);
        assert!(arg2 >= arg0.min_bet, 2);
        assert!(arg0.total_shares >= 1000000000, 16);
    }

    fun assert_cap<T0>(arg0: &House<T0>, arg1: &AdminCap) {
        assert!(arg1.house == 0x2::object::id<House<T0>>(arg0), 5);
    }

    public(friend) fun assert_max_profit<T0>(arg0: &House<T0>, arg1: u64, arg2: u64) {
        assert!(arg2 <= max_profit_excluding<T0>(arg0, arg1), 3);
    }

    fun assert_within_daily_loss<T0>(arg0: &mut House<T0>, arg1: u8, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg2) / 86400000;
        let v1 = 0x1::vector::borrow_mut<GameControl>(&mut arg0.games, (arg1 as u64));
        assert!(v1.enabled, 19);
        if (v1.day != v0) {
            v1.day = v0;
            v1.staked = 0;
            v1.paid = 0;
        };
        assert!(v1.paid + (v1.open as u128) <= v1.staked + (pool_value<T0>(arg0) as u128) * (v1.max_daily_loss_bps as u128) / (10000 as u128), 20);
    }

    public fun bankroll<T0>(arg0: &House<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.bankroll)
    }

    fun bump(arg0: &mut vector<Entry>, arg1: address, arg2: u128) {
        let v0 = 0x1::vector::length<Entry>(arg0);
        let v1 = v0;
        let v2 = 0;
        while (v2 < v0) {
            if (0x1::vector::borrow<Entry>(arg0, v2).player == arg1) {
                v1 = v2;
                break
            };
            v2 = v2 + 1;
        };
        if (v1 < v0) {
            0x1::vector::borrow_mut<Entry>(arg0, v1).wagered = arg2;
        } else if (v0 < 20) {
            let v3 = Entry{
                player  : arg1,
                wagered : arg2,
            };
            0x1::vector::push_back<Entry>(arg0, v3);
        } else if (0x1::vector::borrow<Entry>(arg0, v0 - 1).wagered < arg2) {
            let v4 = v0 - 1;
            v1 = v4;
            let v5 = Entry{
                player  : arg1,
                wagered : arg2,
            };
            *0x1::vector::borrow_mut<Entry>(arg0, v4) = v5;
        } else {
            return
        };
        while (v1 > 0 && 0x1::vector::borrow<Entry>(arg0, v1 - 1).wagered < 0x1::vector::borrow<Entry>(arg0, v1).wagered) {
            0x1::vector::swap<Entry>(arg0, v1 - 1, v1);
            v1 = v1 - 1;
        };
    }

    public(friend) fun checkpoint<T0>(arg0: &mut House<T0>, arg1: u8, arg2: address, arg3: u64, arg4: u64) {
        set_liability<T0>(arg0, arg4, arg4);
        let v0 = BetProgress{
            house     : 0x2::object::id<House<T0>>(arg0),
            game      : arg1,
            player    : arg2,
            wager     : arg3,
            liability : arg4,
        };
        0x2::event::emit<BetProgress>(v0);
    }

    public fun claim_fees<T0>(arg0: &mut House<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::table::contains<address, Position>(&arg0.positions, v0), 10);
        harvest<T0>(arg0, v0);
        let v1 = 0x2::table::borrow_mut<address, Position>(&mut arg0.positions, v0);
        let v2 = v1.unclaimed;
        assert!(v2 > 0, 15);
        v1.unclaimed = 0;
        v1.fees_claimed = v1.fees_claimed + (v2 as u128);
        let v3 = FeesClaimed{
            house  : 0x2::object::id<House<T0>>(arg0),
            member : v0,
            amount : v2,
        };
        0x2::event::emit<FeesClaimed>(v3);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.fees, v2), arg1)
    }

    public fun claimable_fees<T0>(arg0: &House<T0>, arg1: address) : u64 {
        if (!0x2::table::contains<address, Position>(&arg0.positions, arg1)) {
            return 0
        };
        let v0 = 0x2::table::borrow<address, Position>(&arg0.positions, arg1);
        v0.unclaimed + pending_fees(v0, arg0.acc_fee_per_share)
    }

    public fun create<T0>(arg0: &mut 0x2::tx_context::TxContext) : AdminCap {
        let v0 = 0x1::vector::empty<GameControl>();
        let v1 = 0;
        while (v1 < 6) {
            let v2 = GameControl{
                enabled            : true,
                max_daily_loss_bps : 500,
                day                : 0,
                staked             : 0,
                paid               : 0,
                open               : 0,
            };
            0x1::vector::push_back<GameControl>(&mut v0, v2);
            v1 = v1 + 1;
        };
        let v3 = House<T0>{
            id                : 0x2::object::new(arg0),
            paused            : false,
            fee_bps           : 100,
            min_bet           : 1000000,
            max_profit_bps    : 100,
            bankroll          : 0x2::balance::zero<T0>(),
            fees              : 0x2::balance::zero<T0>(),
            reserved          : 0,
            liabilities       : 0,
            total_shares      : 0,
            acc_fee_per_share : 0,
            team              : 0x2::vec_set::empty<address>(),
            positions         : 0x2::table::new<address, Position>(arg0),
            stats             : 0x2::table::new<address, PlayerStats>(arg0),
            top_all           : 0x1::vector::empty<Entry>(),
            top_week          : 0x1::vector::empty<Entry>(),
            week_id           : 0,
            total_wagered     : 0,
            total_paid_out    : 0,
            total_bets        : 0,
            total_fees        : 0,
            games             : v0,
        };
        let v4 = AdminCap{
            id    : 0x2::object::new(arg0),
            house : 0x2::object::id<House<T0>>(&v3),
        };
        let v5 = HouseCreated{
            house     : 0x2::object::id<House<T0>>(&v3),
            admin_cap : 0x2::object::id<AdminCap>(&v4),
        };
        0x2::event::emit<HouseCreated>(v5);
        0x2::transfer::share_object<House<T0>>(v3);
        v4
    }

    fun current_week(arg0: &0x2::clock::Clock) : u64 {
        (0x2::clock::timestamp_ms(arg0) + 3 * 86400000) / 604800000
    }

    public fun daily_loss<T0>(arg0: &House<T0>, arg1: u8) : u128 {
        let v0 = 0x1::vector::borrow<GameControl>(&arg0.games, (arg1 as u64));
        if (v0.paid > v0.staked) {
            v0.paid - v0.staked
        } else {
            0
        }
    }

    public fun entry_player(arg0: &Entry) : address {
        arg0.player
    }

    public fun entry_wagered(arg0: &Entry) : u128 {
        arg0.wagered
    }

    public fun fee_bps<T0>(arg0: &House<T0>) : u64 {
        arg0.fee_bps
    }

    public fun fees<T0>(arg0: &House<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.fees)
    }

    public fun game_enabled<T0>(arg0: &House<T0>, arg1: u8) : bool {
        0x1::vector::borrow<GameControl>(&arg0.games, (arg1 as u64)).enabled
    }

    fun harvest<T0>(arg0: &mut House<T0>, arg1: address) {
        let v0 = arg0.acc_fee_per_share;
        let v1 = 0x2::table::borrow_mut<address, Position>(&mut arg0.positions, arg1);
        v1.unclaimed = v1.unclaimed + pending_fees(v1, v0);
        v1.fee_debt = (v1.shares as u256) * v0;
    }

    public fun is_team_member<T0>(arg0: &House<T0>, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.team, &arg1)
    }

    public fun liabilities<T0>(arg0: &House<T0>) : u64 {
        arg0.liabilities
    }

    public fun max_profit<T0>(arg0: &House<T0>) : u64 {
        max_profit_excluding<T0>(arg0, 0)
    }

    fun max_profit_excluding<T0>(arg0: &House<T0>, arg1: u64) : u64 {
        let v0 = arg0.reserved + arg1;
        let v1 = 0x2::balance::value<T0>(&arg0.bankroll);
        let v2 = if (v1 > v0) {
            v1 - v0
        } else {
            0
        };
        mul_div(v2, arg0.max_profit_bps, 10000)
    }

    public fun min_bet<T0>(arg0: &House<T0>) : u64 {
        arg0.min_bet
    }

    public(friend) fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public fun open_exposure<T0>(arg0: &House<T0>, arg1: u8) : u64 {
        0x1::vector::borrow<GameControl>(&arg0.games, (arg1 as u64)).open
    }

    public fun paid_out_to<T0>(arg0: &House<T0>, arg1: address) : u128 {
        if (0x2::table::contains<address, PlayerStats>(&arg0.stats, arg1)) {
            0x2::table::borrow<address, PlayerStats>(&arg0.stats, arg1).paid_out
        } else {
            0
        }
    }

    fun pending_fees(arg0: &Position, arg1: u256) : u64 {
        ((((arg0.shares as u256) * arg1 - arg0.fee_debt) / 1000000000000000000000000) as u64)
    }

    public fun pool_value<T0>(arg0: &House<T0>) : u64 {
        let v0 = 0x2::balance::value<T0>(&arg0.bankroll);
        if (v0 > arg0.liabilities) {
            v0 - arg0.liabilities
        } else {
            0
        }
    }

    public fun position_value<T0>(arg0: &House<T0>, arg1: address) : u64 {
        if (arg0.total_shares == 0) {
            return 0
        };
        mul_div(shares_of<T0>(arg0, arg1), pool_value<T0>(arg0), arg0.total_shares)
    }

    public(friend) fun record_pvp_result<T0>(arg0: &mut House<T0>, arg1: u8, arg2: &vector<address>, arg3: address, arg4: u64, arg5: u64) {
        arg0.total_paid_out = arg0.total_paid_out + (arg5 as u128);
        let v0 = 0x2::table::borrow_mut<address, PlayerStats>(&mut arg0.stats, arg3);
        v0.paid_out = v0.paid_out + (arg5 as u128);
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(arg2)) {
            let v2 = *0x1::vector::borrow<address>(arg2, v1);
            let v3 = if (v2 == arg3) {
                arg5
            } else {
                0
            };
            let v4 = BetSettled{
                house  : 0x2::object::id<House<T0>>(arg0),
                game   : arg1,
                player : v2,
                wager  : arg4,
                payout : v3,
            };
            0x2::event::emit<BetSettled>(v4);
            v1 = v1 + 1;
        };
    }

    fun record_wager<T0>(arg0: &mut House<T0>, arg1: address, arg2: u64, arg3: &0x2::clock::Clock) {
        let v0 = current_week(arg3);
        if (v0 > arg0.week_id) {
            if (!0x1::vector::is_empty<Entry>(&arg0.top_week)) {
                let v1 = WeekFinalized{
                    house   : 0x2::object::id<House<T0>>(arg0),
                    week_id : arg0.week_id,
                    top     : arg0.top_week,
                };
                0x2::event::emit<WeekFinalized>(v1);
            };
            arg0.top_week = 0x1::vector::empty<Entry>();
            arg0.week_id = v0;
        };
        if (!0x2::table::contains<address, PlayerStats>(&arg0.stats, arg1)) {
            let v2 = PlayerStats{
                wagered      : 0,
                paid_out     : 0,
                bets         : 0,
                week_id      : v0,
                week_wagered : 0,
            };
            0x2::table::add<address, PlayerStats>(&mut arg0.stats, arg1, v2);
        };
        let v3 = 0x2::table::borrow_mut<address, PlayerStats>(&mut arg0.stats, arg1);
        if (v3.week_id != v0) {
            v3.week_id = v0;
            v3.week_wagered = 0;
        };
        v3.wagered = v3.wagered + (arg2 as u128);
        v3.week_wagered = v3.week_wagered + (arg2 as u128);
        v3.bets = v3.bets + 1;
        let v4 = v3.wagered;
        let v5 = v3.week_wagered;
        arg0.total_wagered = arg0.total_wagered + (arg2 as u128);
        arg0.total_bets = arg0.total_bets + 1;
        let v6 = &mut arg0.top_all;
        bump(v6, arg1, v4);
        let v7 = &mut arg0.top_week;
        bump(v7, arg1, v5);
    }

    public(friend) fun release<T0>(arg0: &mut House<T0>, arg1: u8, arg2: u64, arg3: u64) {
        arg0.reserved = arg0.reserved - arg2;
        arg0.liabilities = arg0.liabilities - arg3;
        let v0 = 0x1::vector::borrow_mut<GameControl>(&mut arg0.games, (arg1 as u64));
        v0.open = v0.open - arg2;
    }

    public fun remove_team_member<T0>(arg0: &mut House<T0>, arg1: &AdminCap, arg2: address) {
        assert_cap<T0>(arg0, arg1);
        if (0x2::vec_set::contains<address>(&arg0.team, &arg2)) {
            0x2::vec_set::remove<address>(&mut arg0.team, &arg2);
        };
    }

    public(friend) fun reserve<T0>(arg0: &mut House<T0>, arg1: u8, arg2: u64, arg3: u64) {
        arg0.reserved = arg0.reserved + arg2;
        arg0.liabilities = arg0.liabilities + arg3;
        assert!(arg0.reserved <= mul_div(0x2::balance::value<T0>(&arg0.bankroll), 5000, 10000), 18);
        let v0 = 0x1::vector::borrow_mut<GameControl>(&mut arg0.games, (arg1 as u64));
        v0.open = v0.open + arg2;
        assert!(v0.paid + (v0.open as u128) <= v0.staked + (pool_value<T0>(arg0) as u128) * (v0.max_daily_loss_bps as u128) / (10000 as u128), 20);
    }

    public fun reserved<T0>(arg0: &House<T0>) : u64 {
        arg0.reserved
    }

    public fun reset_daily_loss<T0>(arg0: &mut House<T0>, arg1: &AdminCap, arg2: u8) {
        assert_cap<T0>(arg0, arg1);
        assert!((arg2 as u64) < 6, 21);
        let v0 = 0x1::vector::borrow_mut<GameControl>(&mut arg0.games, (arg2 as u64));
        v0.staked = 0;
        v0.paid = 0;
    }

    public fun set_fee_bps<T0>(arg0: &mut House<T0>, arg1: &AdminCap, arg2: u64) {
        assert_cap<T0>(arg0, arg1);
        assert!(arg2 <= 200, 6);
        arg0.fee_bps = arg2;
    }

    public fun set_game<T0>(arg0: &mut House<T0>, arg1: &AdminCap, arg2: u8, arg3: bool, arg4: u64) {
        assert_cap<T0>(arg0, arg1);
        assert!((arg2 as u64) < 6, 21);
        assert!(arg4 > 0 && arg4 <= 5000, 6);
        let v0 = 0x1::vector::borrow_mut<GameControl>(&mut arg0.games, (arg2 as u64));
        v0.enabled = arg3;
        v0.max_daily_loss_bps = arg4;
    }

    public(friend) fun set_liability<T0>(arg0: &mut House<T0>, arg1: u64, arg2: u64) {
        arg0.liabilities = arg0.liabilities - arg1 + arg2;
    }

    public fun set_limits<T0>(arg0: &mut House<T0>, arg1: &AdminCap, arg2: u64, arg3: u64) {
        assert_cap<T0>(arg0, arg1);
        assert!(arg2 >= 10000, 6);
        assert!(arg3 > 0 && arg3 <= 500, 6);
        arg0.min_bet = arg2;
        arg0.max_profit_bps = arg3;
    }

    public fun set_paused<T0>(arg0: &mut House<T0>, arg1: &AdminCap, arg2: bool) {
        assert_cap<T0>(arg0, arg1);
        arg0.paused = arg2;
    }

    public(friend) fun settle<T0>(arg0: &mut House<T0>, arg1: u8, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::borrow_mut<GameControl>(&mut arg0.games, (arg1 as u64));
        v0.staked = v0.staked + (arg4 as u128);
        v0.paid = v0.paid + (arg5 as u128);
        if (arg5 > 0) {
            assert!(0x2::balance::value<T0>(&arg0.bankroll) >= arg5, 4);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.bankroll, arg5), arg6), arg2);
            assert!(0x2::balance::value<T0>(&arg0.bankroll) >= arg0.reserved, 4);
            arg0.total_paid_out = arg0.total_paid_out + (arg5 as u128);
            let v1 = 0x2::table::borrow_mut<address, PlayerStats>(&mut arg0.stats, arg2);
            v1.paid_out = v1.paid_out + (arg5 as u128);
        };
        let v2 = BetSettled{
            house  : 0x2::object::id<House<T0>>(arg0),
            game   : arg1,
            player : arg2,
            wager  : arg3,
            payout : arg5,
        };
        0x2::event::emit<BetSettled>(v2);
    }

    public fun shares_of<T0>(arg0: &House<T0>, arg1: address) : u64 {
        if (0x2::table::contains<address, Position>(&arg0.positions, arg1)) {
            0x2::table::borrow<address, Position>(&arg0.positions, arg1).shares
        } else {
            0
        }
    }

    public(friend) fun take_bet<T0>(arg0: &mut House<T0>, arg1: u8, arg2: 0x2::coin::Coin<T0>, arg3: address, arg4: &0x2::clock::Clock) : u64 {
        assert!(!arg0.paused, 1);
        assert_within_daily_loss<T0>(arg0, arg1, arg4);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 >= arg0.min_bet, 2);
        assert!(arg0.total_shares >= 1000000000, 16);
        let v1 = 0x2::coin::into_balance<T0>(arg2);
        let v2 = mul_div(v0, arg0.fee_bps, 10000);
        arg0.acc_fee_per_share = arg0.acc_fee_per_share + (v2 as u256) * 1000000000000000000000000 / (arg0.total_shares as u256);
        0x2::balance::join<T0>(&mut arg0.fees, 0x2::balance::split<T0>(&mut v1, v2));
        arg0.total_fees = arg0.total_fees + (v2 as u128);
        0x2::balance::join<T0>(&mut arg0.bankroll, v1);
        record_wager<T0>(arg0, arg3, v0, arg4);
        v0 - v2
    }

    public(friend) fun take_pvp_fee<T0>(arg0: &mut House<T0>, arg1: &mut 0x2::balance::Balance<T0>, arg2: &vector<address>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) : u64 {
        let v0 = if (arg0.total_shares == 0) {
            0
        } else {
            mul_div(0x2::balance::value<T0>(arg1), 0x1::u64::min(arg0.fee_bps, arg4), 10000)
        };
        if (v0 > 0) {
            arg0.acc_fee_per_share = arg0.acc_fee_per_share + (v0 as u256) * 1000000000000000000000000 / (arg0.total_shares as u256);
            0x2::balance::join<T0>(&mut arg0.fees, 0x2::balance::split<T0>(arg1, v0));
            arg0.total_fees = arg0.total_fees + (v0 as u128);
        };
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(arg2)) {
            record_wager<T0>(arg0, *0x1::vector::borrow<address>(arg2, v1), arg3, arg5);
            v1 = v1 + 1;
        };
        v0
    }

    public fun team_deposit<T0>(arg0: &mut House<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::vec_set::contains<address>(&arg0.team, &v0), 8);
        let v1 = 0x2::coin::value<T0>(&arg1);
        assert!(v1 >= 1000000, 9);
        let v2 = pool_value<T0>(arg0);
        let v3 = if (arg0.total_shares == 0) {
            v1
        } else {
            assert!(v2 > 0, 13);
            mul_div(v1, arg0.total_shares, v2)
        };
        assert!(v3 > 0, 9);
        assert!(arg0.total_shares + v3 >= 1000000000, 17);
        if (!0x2::table::contains<address, Position>(&arg0.positions, v0)) {
            let v4 = Position{
                shares       : 0,
                fee_debt     : 0,
                unclaimed    : 0,
                deposited    : 0,
                withdrawn    : 0,
                fees_claimed : 0,
            };
            0x2::table::add<address, Position>(&mut arg0.positions, v0, v4);
        };
        harvest<T0>(arg0, v0);
        0x2::balance::join<T0>(&mut arg0.bankroll, 0x2::coin::into_balance<T0>(arg1));
        arg0.total_shares = arg0.total_shares + v3;
        let v5 = 0x2::table::borrow_mut<address, Position>(&mut arg0.positions, v0);
        v5.shares = v5.shares + v3;
        v5.deposited = v5.deposited + (v1 as u128);
        v5.fee_debt = (v5.shares as u256) * arg0.acc_fee_per_share;
        let v6 = TeamDeposited{
            house  : 0x2::object::id<House<T0>>(arg0),
            member : v0,
            amount : v1,
            shares : v3,
        };
        0x2::event::emit<TeamDeposited>(v6);
    }

    public fun team_withdraw<T0>(arg0: &mut House<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, Position>(&arg0.positions, v0), 10);
        assert!(arg1 > 0 && arg1 <= 0x2::table::borrow<address, Position>(&arg0.positions, v0).shares, 11);
        harvest<T0>(arg0, v0);
        let v1 = mul_div(arg1, pool_value<T0>(arg0), arg0.total_shares);
        assert!(0x2::balance::value<T0>(&arg0.bankroll) - v1 >= arg0.reserved, 12);
        arg0.total_shares = arg0.total_shares - arg1;
        let v2 = 0x2::table::borrow_mut<address, Position>(&mut arg0.positions, v0);
        v2.shares = v2.shares - arg1;
        v2.withdrawn = v2.withdrawn + (v1 as u128);
        v2.fee_debt = (v2.shares as u256) * arg0.acc_fee_per_share;
        let v3 = TeamWithdrew{
            house  : 0x2::object::id<House<T0>>(arg0),
            member : v0,
            amount : v1,
            shares : arg1,
        };
        0x2::event::emit<TeamWithdrew>(v3);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.bankroll, v1), arg2)
    }

    public fun top_all<T0>(arg0: &House<T0>) : &vector<Entry> {
        &arg0.top_all
    }

    public fun top_week<T0>(arg0: &House<T0>) : &vector<Entry> {
        &arg0.top_week
    }

    public fun total_shares<T0>(arg0: &House<T0>) : u64 {
        arg0.total_shares
    }

    public(friend) fun uid<T0>(arg0: &House<T0>) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun uid_mut<T0>(arg0: &mut House<T0>) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun wagered_by<T0>(arg0: &House<T0>, arg1: address) : u128 {
        if (0x2::table::contains<address, PlayerStats>(&arg0.stats, arg1)) {
            0x2::table::borrow<address, PlayerStats>(&arg0.stats, arg1).wagered
        } else {
            0
        }
    }

    public fun week_id<T0>(arg0: &House<T0>) : u64 {
        arg0.week_id
    }

    // decompiled from Move bytecode v7
}

