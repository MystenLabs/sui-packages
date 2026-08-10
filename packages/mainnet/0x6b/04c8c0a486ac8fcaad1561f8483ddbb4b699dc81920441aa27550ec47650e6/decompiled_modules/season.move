module 0x6b04c8c0a486ac8fcaad1561f8483ddbb4b699dc81920441aa27550ec47650e6::season {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct OracleCap has store, key {
        id: 0x2::object::UID,
    }

    struct FeeTierCap has store, key {
        id: 0x2::object::UID,
    }

    struct Slot has copy, drop, store {
        coin_id: vector<u8>,
        is_short: bool,
    }

    struct PlayerEntry has drop, store {
        basket: vector<Slot>,
        moon_pick: vector<u8>,
        captain_slot: u8,
        transfers_used: u64,
        banked: u64,
        accrued_week: u64,
        bonus_transfers: u64,
        last_flip_day: u64,
        joined_ms: u64,
    }

    struct DaySnapshot has store {
        day_index: u64,
        results: 0x2::vec_map::VecMap<vector<u8>, u64>,
        submitted_ms: u64,
        finalized: bool,
    }

    struct Season<phantom T0> has key {
        id: 0x2::object::UID,
        entry_fee: u64,
        treasury_bps: u64,
        kickoff_ms: u64,
        entry_close_ms: u64,
        end_ms: u64,
        day_ms: u64,
        week_ms: u64,
        dispute_window_ms: u64,
        basket_size: u64,
        max_banked_transfers: u64,
        registry_hash: vector<u8>,
        paused: bool,
        prize_pool: 0x2::balance::Balance<T0>,
        treasury: 0x2::balance::Balance<T0>,
        treasury_wallet: address,
        tiers: 0x2::table::Table<address, u64>,
        entries: 0x2::table::Table<address, PlayerEntry>,
        players: vector<address>,
        total_entries: u64,
        snapshots: 0x2::table::Table<u64, DaySnapshot>,
        winners: vector<address>,
        payouts: vector<u64>,
        settled: bool,
        paid: 0x2::table::Table<address, bool>,
        paid_count: u64,
    }

    struct SeasonCreated has copy, drop {
        season_id: 0x2::object::ID,
        entry_fee: u64,
        kickoff_ms: u64,
        entry_close_ms: u64,
        end_ms: u64,
        day_ms: u64,
        basket_size: u64,
    }

    struct PlayerJoined has copy, drop {
        season_id: 0x2::object::ID,
        player: address,
        coin_ids: vector<vector<u8>>,
        shorts: vector<bool>,
        moon_pick: vector<u8>,
        captain_slot: u8,
        rebate: u64,
        joined_ms: u64,
    }

    struct SlotFlipped has copy, drop {
        season_id: 0x2::object::ID,
        player: address,
        slot_index: u8,
        coin_id: vector<u8>,
        new_is_short: bool,
        flip_ms: u64,
    }

    struct CaptainSet has copy, drop {
        season_id: 0x2::object::ID,
        player: address,
        slot: u8,
        set_ms: u64,
    }

    struct SlotTransferred has copy, drop {
        season_id: 0x2::object::ID,
        player: address,
        slot_index: u8,
        old_coin_id: vector<u8>,
        old_is_short: bool,
        new_coin_id: vector<u8>,
        new_is_short: bool,
        transfer_ms: u64,
    }

    struct EmergencyTransferGranted has copy, drop {
        season_id: 0x2::object::ID,
        player: address,
    }

    struct RegistryAnchored has copy, drop {
        season_id: 0x2::object::ID,
        registry_hash: vector<u8>,
    }

    struct DayResultsSubmitted has copy, drop {
        season_id: 0x2::object::ID,
        day_index: u64,
        coin_ids: vector<vector<u8>>,
        values: vector<u64>,
        submitted_count: u64,
        total_count: u64,
        window_end_ms: u64,
    }

    struct ResultOverridden has copy, drop {
        season_id: 0x2::object::ID,
        day_index: u64,
        coin_id: vector<u8>,
        new_value: u64,
    }

    struct DayFinalized has copy, drop {
        season_id: 0x2::object::ID,
        day_index: u64,
    }

    struct SeasonSettled has copy, drop {
        season_id: 0x2::object::ID,
        winner_count: u64,
        payout_total: u64,
    }

    struct SettlementReset has copy, drop {
        season_id: 0x2::object::ID,
    }

    struct PayoutDistributed has copy, drop {
        season_id: 0x2::object::ID,
        player: address,
        amount: u64,
    }

    struct TreasuryWithdrawn has copy, drop {
        season_id: 0x2::object::ID,
        amount: u64,
    }

    struct RemainderSwept has copy, drop {
        season_id: 0x2::object::ID,
        amount: u64,
    }

    fun assert_distinct(arg0: &vector<vector<u8>>) {
        let v0 = 0x1::vector::length<vector<u8>>(arg0);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = v1 + 1;
            while (v2 < v0) {
                assert!(0x1::vector::borrow<vector<u8>>(arg0, v1) != 0x1::vector::borrow<vector<u8>>(arg0, v2), 6);
                v2 = v2 + 1;
            };
            v1 = v1 + 1;
        };
    }

    public fun basket_of<T0>(arg0: &Season<T0>, arg1: address) : (vector<vector<u8>>, vector<bool>) {
        let v0 = 0x2::table::borrow<address, PlayerEntry>(&arg0.entries, arg1);
        let v1 = vector[];
        let v2 = vector[];
        let v3 = 0;
        while (v3 < 0x1::vector::length<Slot>(&v0.basket)) {
            let v4 = 0x1::vector::borrow<Slot>(&v0.basket, v3);
            0x1::vector::push_back<vector<u8>>(&mut v1, v4.coin_id);
            0x1::vector::push_back<bool>(&mut v2, v4.is_short);
            v3 = v3 + 1;
        };
        (v1, v2)
    }

    public fun bonus_transfers_of<T0>(arg0: &Season<T0>, arg1: address) : u64 {
        0x2::table::borrow<address, PlayerEntry>(&arg0.entries, arg1).bonus_transfers
    }

    public fun captain_of<T0>(arg0: &Season<T0>, arg1: address) : u8 {
        0x2::table::borrow<address, PlayerEntry>(&arg0.entries, arg1).captain_slot
    }

    public fun clear_tier<T0>(arg0: &mut Season<T0>, arg1: &FeeTierCap, arg2: address) {
        if (0x2::table::contains<address, u64>(&arg0.tiers, arg2)) {
            0x2::table::remove<address, u64>(&mut arg0.tiers, arg2);
        };
    }

    public fun create_season<T0>(arg0: &AdminCap, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: address, arg12: vector<u8>, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 1);
        assert!(arg2 < 10000, 1);
        assert!(arg6 > 0 && arg7 > 0, 1);
        assert!(arg9 > 0 && arg9 <= 32, 1);
        assert!(arg3 > 0x2::clock::timestamp_ms(arg13), 1);
        assert!(arg4 > arg3, 1);
        assert!(arg5 > arg4, 1);
        assert!((arg5 - arg3) % arg6 == 0, 1);
        assert!((arg5 - arg3) / arg6 >= 1, 1);
        let v0 = Season<T0>{
            id                   : 0x2::object::new(arg14),
            entry_fee            : arg1,
            treasury_bps         : arg2,
            kickoff_ms           : arg3,
            entry_close_ms       : arg4,
            end_ms               : arg5,
            day_ms               : arg6,
            week_ms              : arg7,
            dispute_window_ms    : arg8,
            basket_size          : arg9,
            max_banked_transfers : arg10,
            registry_hash        : arg12,
            paused               : false,
            prize_pool           : 0x2::balance::zero<T0>(),
            treasury             : 0x2::balance::zero<T0>(),
            treasury_wallet      : arg11,
            tiers                : 0x2::table::new<address, u64>(arg14),
            entries              : 0x2::table::new<address, PlayerEntry>(arg14),
            players              : vector[],
            total_entries        : 0,
            snapshots            : 0x2::table::new<u64, DaySnapshot>(arg14),
            winners              : vector[],
            payouts              : vector[],
            settled              : false,
            paid                 : 0x2::table::new<address, bool>(arg14),
            paid_count           : 0,
        };
        let v1 = SeasonCreated{
            season_id      : 0x2::object::id<Season<T0>>(&v0),
            entry_fee      : arg1,
            kickoff_ms     : arg3,
            entry_close_ms : arg4,
            end_ms         : arg5,
            day_ms         : arg6,
            basket_size    : arg9,
        };
        0x2::event::emit<SeasonCreated>(v1);
        0x2::transfer::share_object<Season<T0>>(v0);
    }

    public fun day_finalized<T0>(arg0: &Season<T0>, arg1: u64) : bool {
        0x2::table::contains<u64, DaySnapshot>(&arg0.snapshots, arg1) && 0x2::table::borrow<u64, DaySnapshot>(&arg0.snapshots, arg1).finalized
    }

    public fun day_ms<T0>(arg0: &Season<T0>) : u64 {
        arg0.day_ms
    }

    public fun day_result<T0>(arg0: &Season<T0>, arg1: u64, arg2: vector<u8>) : u64 {
        *0x2::vec_map::get<vector<u8>, u64>(&0x2::table::borrow<u64, DaySnapshot>(&arg0.snapshots, arg1).results, &arg2)
    }

    public fun day_result_count<T0>(arg0: &Season<T0>, arg1: u64) : u64 {
        0x2::vec_map::length<vector<u8>, u64>(&0x2::table::borrow<u64, DaySnapshot>(&arg0.snapshots, arg1).results)
    }

    public fun day_submitted<T0>(arg0: &Season<T0>, arg1: u64) : bool {
        0x2::table::contains<u64, DaySnapshot>(&arg0.snapshots, arg1)
    }

    public fun distribute_payouts<T0>(arg0: &mut Season<T0>, arg1: &AdminCap, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.settled, 21);
        let v0 = 0x1::vector::length<address>(&arg0.winners);
        let v1 = if (arg3 > v0) {
            v0
        } else {
            arg3
        };
        while (arg2 < v1) {
            let v2 = *0x1::vector::borrow<address>(&arg0.winners, arg2);
            let v3 = *0x1::vector::borrow<u64>(&arg0.payouts, arg2);
            if (v3 > 0 && !0x2::table::contains<address, bool>(&arg0.paid, v2)) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.prize_pool, v3), arg4), v2);
                0x2::table::add<address, bool>(&mut arg0.paid, v2, true);
                arg0.paid_count = arg0.paid_count + 1;
                let v4 = PayoutDistributed{
                    season_id : 0x2::object::id<Season<T0>>(arg0),
                    player    : v2,
                    amount    : v3,
                };
                0x2::event::emit<PayoutDistributed>(v4);
            };
            arg2 = arg2 + 1;
        };
    }

    public fun end_ms<T0>(arg0: &Season<T0>) : u64 {
        arg0.end_ms
    }

    public fun enter<T0>(arg0: &mut Season<T0>, arg1: 0x2::coin::Coin<T0>, arg2: vector<vector<u8>>, arg3: vector<bool>, arg4: vector<u8>, arg5: u8, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 0);
        let v0 = 0x2::clock::timestamp_ms(arg6);
        assert!(v0 < arg0.entry_close_ms, 2);
        assert!(0x2::coin::value<T0>(&arg1) == arg0.entry_fee, 3);
        let v1 = 0x2::tx_context::sender(arg7);
        assert!(!0x2::table::contains<address, PlayerEntry>(&arg0.entries, v1), 4);
        let v2 = 0x1::vector::length<vector<u8>>(&arg2);
        assert!(v2 == arg0.basket_size, 5);
        assert!(0x1::vector::length<bool>(&arg3) == v2, 5);
        assert!((arg5 as u64) < v2, 8);
        assert_distinct(&arg2);
        let v3 = if (0x2::table::contains<address, u64>(&arg0.tiers, v1)) {
            *0x2::table::borrow<address, u64>(&arg0.tiers, v1)
        } else {
            arg0.treasury_bps
        };
        let v4 = mul_div(arg0.entry_fee, v3, 10000);
        let v5 = mul_div(arg0.entry_fee, arg0.treasury_bps, 10000) - v4;
        let v6 = 0x2::coin::into_balance<T0>(arg1);
        0x2::balance::join<T0>(&mut arg0.treasury, 0x2::balance::split<T0>(&mut v6, v4));
        if (v5 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v6, v5), arg7), v1);
        };
        0x2::balance::join<T0>(&mut arg0.prize_pool, v6);
        let v7 = if (v0 < arg0.kickoff_ms) {
            arg4
        } else {
            b""
        };
        let v8 = 0x1::vector::empty<Slot>();
        let v9 = 0;
        while (v9 < v2) {
            let v10 = Slot{
                coin_id  : *0x1::vector::borrow<vector<u8>>(&arg2, v9),
                is_short : *0x1::vector::borrow<bool>(&arg3, v9),
            };
            0x1::vector::push_back<Slot>(&mut v8, v10);
            v9 = v9 + 1;
        };
        let v11 = PlayerEntry{
            basket          : v8,
            moon_pick       : v7,
            captain_slot    : arg5,
            transfers_used  : 0,
            banked          : 0,
            accrued_week    : 0,
            bonus_transfers : 0,
            last_flip_day   : 0,
            joined_ms       : v0,
        };
        0x2::table::add<address, PlayerEntry>(&mut arg0.entries, v1, v11);
        0x1::vector::push_back<address>(&mut arg0.players, v1);
        arg0.total_entries = arg0.total_entries + 1;
        let v12 = PlayerJoined{
            season_id    : 0x2::object::id<Season<T0>>(arg0),
            player       : v1,
            coin_ids     : arg2,
            shorts       : arg3,
            moon_pick    : v7,
            captain_slot : arg5,
            rebate       : v5,
            joined_ms    : v0,
        };
        0x2::event::emit<PlayerJoined>(v12);
    }

    public fun entry_close_ms<T0>(arg0: &Season<T0>) : u64 {
        arg0.entry_close_ms
    }

    public fun entry_fee<T0>(arg0: &Season<T0>) : u64 {
        arg0.entry_fee
    }

    public fun finalize_day<T0>(arg0: &mut Season<T0>, arg1: u64, arg2: &0x2::clock::Clock) {
        assert!(0x2::table::contains<u64, DaySnapshot>(&arg0.snapshots, arg1), 14);
        let v0 = 0x2::table::borrow_mut<u64, DaySnapshot>(&mut arg0.snapshots, arg1);
        assert!(!v0.finalized, 13);
        assert!(0x2::clock::timestamp_ms(arg2) >= v0.submitted_ms + arg0.dispute_window_ms, 16);
        v0.finalized = true;
        let v1 = DayFinalized{
            season_id : 0x2::object::id<Season<T0>>(arg0),
            day_index : arg1,
        };
        0x2::event::emit<DayFinalized>(v1);
    }

    public fun flip_slot<T0>(arg0: &mut Season<T0>, arg1: u8, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 0);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 >= arg0.kickoff_ms && v0 < arg0.end_ms, 9);
        let v1 = 0x2::tx_context::sender(arg3);
        assert!(0x2::table::contains<address, PlayerEntry>(&arg0.entries, v1), 7);
        let v2 = 0x2::table::borrow_mut<address, PlayerEntry>(&mut arg0.entries, v1);
        assert!((arg1 as u64) < 0x1::vector::length<Slot>(&v2.basket), 8);
        let v3 = (v0 - arg0.kickoff_ms) / arg0.day_ms + 1;
        assert!(v2.last_flip_day < v3, 26);
        v2.last_flip_day = v3;
        let v4 = 0x1::vector::borrow_mut<Slot>(&mut v2.basket, (arg1 as u64));
        v4.is_short = !v4.is_short;
        let v5 = SlotFlipped{
            season_id    : 0x2::object::id<Season<T0>>(arg0),
            player       : v1,
            slot_index   : arg1,
            coin_id      : v4.coin_id,
            new_is_short : v4.is_short,
            flip_ms      : v0,
        };
        0x2::event::emit<SlotFlipped>(v5);
    }

    public fun grant_emergency_transfer<T0>(arg0: &mut Season<T0>, arg1: &AdminCap, arg2: address) {
        assert!(0x2::table::contains<address, PlayerEntry>(&arg0.entries, arg2), 7);
        let v0 = 0x2::table::borrow_mut<address, PlayerEntry>(&mut arg0.entries, arg2);
        v0.bonus_transfers = v0.bonus_transfers + 1;
        let v1 = EmergencyTransferGranted{
            season_id : 0x2::object::id<Season<T0>>(arg0),
            player    : arg2,
        };
        0x2::event::emit<EmergencyTransferGranted>(v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v1, v0);
        let v2 = OracleCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<OracleCap>(v2, v0);
        let v3 = FeeTierCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<FeeTierCap>(v3, v0);
    }

    public fun is_entered<T0>(arg0: &Season<T0>, arg1: address) : bool {
        0x2::table::contains<address, PlayerEntry>(&arg0.entries, arg1)
    }

    public fun is_settled<T0>(arg0: &Season<T0>) : bool {
        arg0.settled
    }

    public fun kickoff_ms<T0>(arg0: &Season<T0>) : u64 {
        arg0.kickoff_ms
    }

    public fun last_flip_day_of<T0>(arg0: &Season<T0>, arg1: address) : u64 {
        0x2::table::borrow<address, PlayerEntry>(&arg0.entries, arg1).last_flip_day
    }

    public fun moon_pick_of<T0>(arg0: &Season<T0>, arg1: address) : vector<u8> {
        0x2::table::borrow<address, PlayerEntry>(&arg0.entries, arg1).moon_pick
    }

    fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg2 == 0) {
            0
        } else {
            (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
        }
    }

    public fun num_days<T0>(arg0: &Season<T0>) : u64 {
        (arg0.end_ms - arg0.kickoff_ms) / arg0.day_ms
    }

    public fun override_result<T0>(arg0: &mut Season<T0>, arg1: &AdminCap, arg2: u64, arg3: vector<u8>, arg4: u64, arg5: &0x2::clock::Clock) {
        assert!(0x2::table::contains<u64, DaySnapshot>(&arg0.snapshots, arg2), 14);
        let v0 = 0x2::table::borrow_mut<u64, DaySnapshot>(&mut arg0.snapshots, arg2);
        assert!(!v0.finalized, 13);
        assert!(0x2::clock::timestamp_ms(arg5) < v0.submitted_ms + arg0.dispute_window_ms, 15);
        if (0x2::vec_map::contains<vector<u8>, u64>(&v0.results, &arg3)) {
            *0x2::vec_map::get_mut<vector<u8>, u64>(&mut v0.results, &arg3) = arg4;
        } else {
            0x2::vec_map::insert<vector<u8>, u64>(&mut v0.results, arg3, arg4);
        };
        let v1 = ResultOverridden{
            season_id : 0x2::object::id<Season<T0>>(arg0),
            day_index : arg2,
            coin_id   : arg3,
            new_value : arg4,
        };
        0x2::event::emit<ResultOverridden>(v1);
    }

    public fun paid_count<T0>(arg0: &Season<T0>) : u64 {
        arg0.paid_count
    }

    public fun players<T0>(arg0: &Season<T0>) : vector<address> {
        arg0.players
    }

    public fun prize_pool_value<T0>(arg0: &Season<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.prize_pool)
    }

    public fun registry_hash<T0>(arg0: &Season<T0>) : vector<u8> {
        arg0.registry_hash
    }

    public fun reset_settlement<T0>(arg0: &mut Season<T0>, arg1: &AdminCap) {
        assert!(arg0.settled, 21);
        assert!(arg0.paid_count == 0, 23);
        arg0.winners = vector[];
        arg0.payouts = vector[];
        arg0.settled = false;
        let v0 = SettlementReset{season_id: 0x2::object::id<Season<T0>>(arg0)};
        0x2::event::emit<SettlementReset>(v0);
    }

    public fun set_captain<T0>(arg0: &mut Season<T0>, arg1: u8, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 0);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 < arg0.end_ms, 9);
        let v1 = 0x2::tx_context::sender(arg3);
        assert!(0x2::table::contains<address, PlayerEntry>(&arg0.entries, v1), 7);
        let v2 = 0x2::table::borrow_mut<address, PlayerEntry>(&mut arg0.entries, v1);
        assert!((arg1 as u64) < 0x1::vector::length<Slot>(&v2.basket), 8);
        v2.captain_slot = arg1;
        let v3 = CaptainSet{
            season_id : 0x2::object::id<Season<T0>>(arg0),
            player    : v1,
            slot      : arg1,
            set_ms    : v0,
        };
        0x2::event::emit<CaptainSet>(v3);
    }

    public fun set_dispute_window<T0>(arg0: &mut Season<T0>, arg1: &AdminCap, arg2: u64) {
        arg0.dispute_window_ms = arg2;
    }

    public fun set_paused<T0>(arg0: &mut Season<T0>, arg1: &AdminCap, arg2: bool) {
        arg0.paused = arg2;
    }

    public fun set_registry_hash<T0>(arg0: &mut Season<T0>, arg1: &AdminCap, arg2: vector<u8>) {
        arg0.registry_hash = arg2;
        let v0 = RegistryAnchored{
            season_id     : 0x2::object::id<Season<T0>>(arg0),
            registry_hash : arg0.registry_hash,
        };
        0x2::event::emit<RegistryAnchored>(v0);
    }

    public fun set_tier<T0>(arg0: &mut Season<T0>, arg1: &FeeTierCap, arg2: address, arg3: u64) {
        assert!(arg3 <= arg0.treasury_bps, 27);
        if (0x2::table::contains<address, u64>(&arg0.tiers, arg2)) {
            *0x2::table::borrow_mut<address, u64>(&mut arg0.tiers, arg2) = arg3;
        } else {
            0x2::table::add<address, u64>(&mut arg0.tiers, arg2, arg3);
        };
    }

    public fun settle_season<T0>(arg0: &mut Season<T0>, arg1: &AdminCap, arg2: vector<address>, arg3: vector<u64>, arg4: &0x2::clock::Clock) {
        assert!(!arg0.settled, 20);
        assert!(0x2::clock::timestamp_ms(arg4) >= arg0.end_ms, 18);
        let v0 = num_days<T0>(arg0) - 1;
        assert!(0x2::table::contains<u64, DaySnapshot>(&arg0.snapshots, v0), 19);
        assert!(0x2::table::borrow<u64, DaySnapshot>(&arg0.snapshots, v0).finalized, 19);
        assert!(0x1::vector::length<address>(&arg2) == 0x1::vector::length<u64>(&arg3), 17);
        let v1 = 0;
        let v2 = 0;
        let v3 = 0x1::vector::length<u64>(&arg3);
        while (v2 < v3) {
            v1 = v1 + (*0x1::vector::borrow<u64>(&arg3, v2) as u128);
            v2 = v2 + 1;
        };
        assert!(v1 <= (0x2::balance::value<T0>(&arg0.prize_pool) as u128), 22);
        arg0.winners = arg2;
        arg0.payouts = arg3;
        arg0.settled = true;
        let v4 = SeasonSettled{
            season_id    : 0x2::object::id<Season<T0>>(arg0),
            winner_count : v3,
            payout_total : (v1 as u64),
        };
        0x2::event::emit<SeasonSettled>(v4);
    }

    public fun submit_day_results<T0>(arg0: &mut Season<T0>, arg1: &OracleCap, arg2: u64, arg3: vector<vector<u8>>, arg4: vector<u64>, arg5: &0x2::clock::Clock) {
        assert!(arg2 < num_days<T0>(arg0), 11);
        let v0 = 0x1::vector::length<vector<u8>>(&arg3);
        assert!(0x1::vector::length<u64>(&arg4) == v0, 17);
        let v1 = 0x2::clock::timestamp_ms(arg5);
        assert!(v1 >= arg0.kickoff_ms + (arg2 + 1) * arg0.day_ms, 12);
        if (!0x2::table::contains<u64, DaySnapshot>(&arg0.snapshots, arg2)) {
            let v2 = DaySnapshot{
                day_index    : arg2,
                results      : 0x2::vec_map::empty<vector<u8>, u64>(),
                submitted_ms : v1,
                finalized    : false,
            };
            0x2::table::add<u64, DaySnapshot>(&mut arg0.snapshots, arg2, v2);
        };
        let v3 = 0x2::table::borrow_mut<u64, DaySnapshot>(&mut arg0.snapshots, arg2);
        assert!(!v3.finalized, 13);
        let v4 = vector[];
        let v5 = vector[];
        let v6 = 0;
        while (v6 < v0) {
            let v7 = *0x1::vector::borrow<vector<u8>>(&arg3, v6);
            if (!0x2::vec_map::contains<vector<u8>, u64>(&v3.results, &v7)) {
                let v8 = *0x1::vector::borrow<u64>(&arg4, v6);
                0x2::vec_map::insert<vector<u8>, u64>(&mut v3.results, v7, v8);
                0x1::vector::push_back<vector<u8>>(&mut v4, v7);
                0x1::vector::push_back<u64>(&mut v5, v8);
            };
            v6 = v6 + 1;
        };
        let v9 = DayResultsSubmitted{
            season_id       : 0x2::object::id<Season<T0>>(arg0),
            day_index       : arg2,
            coin_ids        : v4,
            values          : v5,
            submitted_count : 0x1::vector::length<vector<u8>>(&v4),
            total_count     : 0x2::vec_map::length<vector<u8>, u64>(&v3.results),
            window_end_ms   : v3.submitted_ms + arg0.dispute_window_ms,
        };
        0x2::event::emit<DayResultsSubmitted>(v9);
    }

    public fun sweep_remainder<T0>(arg0: &mut Season<T0>, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.settled, 21);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg0.winners)) {
            if (*0x1::vector::borrow<u64>(&arg0.payouts, v0) > 0) {
                assert!(0x2::table::contains<address, bool>(&arg0.paid, *0x1::vector::borrow<address>(&arg0.winners, v0)), 24);
            };
            v0 = v0 + 1;
        };
        let v1 = 0x2::balance::value<T0>(&arg0.prize_pool);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.prize_pool, v1), arg2), arg0.treasury_wallet);
        let v2 = RemainderSwept{
            season_id : 0x2::object::id<Season<T0>>(arg0),
            amount    : v1,
        };
        0x2::event::emit<RemainderSwept>(v2);
    }

    public fun tier_of<T0>(arg0: &Season<T0>, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.tiers, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.tiers, arg1)
        } else {
            arg0.treasury_bps
        }
    }

    public fun total_entries<T0>(arg0: &Season<T0>) : u64 {
        arg0.total_entries
    }

    public fun transfer_slot<T0>(arg0: &mut Season<T0>, arg1: u8, arg2: vector<u8>, arg3: bool, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 0);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(v0 >= arg0.kickoff_ms && v0 < arg0.end_ms, 9);
        let v1 = 0x2::tx_context::sender(arg5);
        assert!(0x2::table::contains<address, PlayerEntry>(&arg0.entries, v1), 7);
        let v2 = arg0.max_banked_transfers;
        let v3 = 0x2::table::borrow_mut<address, PlayerEntry>(&mut arg0.entries, v1);
        let v4 = 0x1::vector::length<Slot>(&v3.basket);
        assert!((arg1 as u64) < v4, 8);
        let v5 = 0;
        while (v5 < v4) {
            if (v5 != (arg1 as u64)) {
                assert!(0x1::vector::borrow<Slot>(&v3.basket, v5).coin_id != arg2, 6);
            };
            v5 = v5 + 1;
        };
        let v6 = (v0 - arg0.kickoff_ms) / arg0.week_ms + 1;
        if (v6 > v3.accrued_week) {
            let v7 = v3.banked + v6 - v3.accrued_week;
            let v8 = if (v7 > v2) {
                v2
            } else {
                v7
            };
            v3.banked = v8;
            v3.accrued_week = v6;
        };
        if (v3.banked > 0) {
            v3.banked = v3.banked - 1;
            v3.transfers_used = v3.transfers_used + 1;
        } else {
            assert!(v3.bonus_transfers > 0, 10);
            v3.bonus_transfers = v3.bonus_transfers - 1;
            v3.transfers_used = v3.transfers_used + 1;
        };
        let v9 = 0x1::vector::borrow_mut<Slot>(&mut v3.basket, (arg1 as u64));
        v9.coin_id = arg2;
        v9.is_short = arg3;
        let v10 = SlotTransferred{
            season_id    : 0x2::object::id<Season<T0>>(arg0),
            player       : v1,
            slot_index   : arg1,
            old_coin_id  : v9.coin_id,
            old_is_short : v9.is_short,
            new_coin_id  : arg2,
            new_is_short : arg3,
            transfer_ms  : v0,
        };
        0x2::event::emit<SlotTransferred>(v10);
    }

    public fun transfers_banked_of<T0>(arg0: &Season<T0>, arg1: address) : u64 {
        0x2::table::borrow<address, PlayerEntry>(&arg0.entries, arg1).banked
    }

    public fun transfers_used_of<T0>(arg0: &Season<T0>, arg1: address) : u64 {
        0x2::table::borrow<address, PlayerEntry>(&arg0.entries, arg1).transfers_used
    }

    public fun treasury_value<T0>(arg0: &Season<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.treasury)
    }

    public fun value_offset() : u64 {
        10000
    }

    public fun withdraw_treasury<T0>(arg0: &mut Season<T0>, arg1: &AdminCap, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg2) >= arg0.entry_close_ms, 25);
        let v0 = 0x2::balance::value<T0>(&arg0.treasury);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.treasury, v0), arg3), arg0.treasury_wallet);
        let v1 = TreasuryWithdrawn{
            season_id : 0x2::object::id<Season<T0>>(arg0),
            amount    : v0,
        };
        0x2::event::emit<TreasuryWithdrawn>(v1);
    }

    // decompiled from Move bytecode v7
}

