module 0x3587bae4e3e2e379d0b9a45f69311499e9fa8f140b26ef0f005b25755c050696::stage {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
        stage_id: 0x2::object::ID,
    }

    struct KeeperCap has store, key {
        id: 0x2::object::UID,
        stage_id: 0x2::object::ID,
    }

    struct Tally has drop, store {
        round: u64,
        total: u64,
        burns: u64,
    }

    struct Stage has key {
        id: 0x2::object::UID,
        version: u64,
        round: u64,
        open: bool,
        opened_ms: u64,
        ends_ms: u64,
        hard_end_ms: u64,
        round_ms: u64,
        extend_ms: u64,
        full_burn: u64,
        full_burn_ms: u64,
        closed_ms: u64,
        options_ms: vector<u64>,
        votes: vector<u64>,
        pot: 0x2::balance::Balance<0x2::sui::SUI>,
        entry_coin: 0x1::option::Option<0x1::type_name::TypeName>,
        tallies: 0x2::table::Table<address, Tally>,
        leader: address,
        leader_total: u64,
        round_total: u64,
        player_count: u64,
    }

    struct RoundOpened has copy, drop {
        stage: 0x2::object::ID,
        round: u64,
        pot: u64,
        opened_ms: u64,
        ends_ms: u64,
    }

    struct TimingSet has copy, drop {
        stage: 0x2::object::ID,
        old_round_ms: u64,
        new_round_ms: u64,
        old_extend_ms: u64,
        new_extend_ms: u64,
    }

    struct OptionsSet has copy, drop {
        stage: 0x2::object::ID,
        options_ms: vector<u64>,
    }

    struct FullBurnSet has copy, drop {
        stage: 0x2::object::ID,
        old_full_burn: u64,
        new_full_burn: u64,
    }

    struct Migrated has copy, drop {
        stage: 0x2::object::ID,
        from: u64,
        to: u64,
    }

    struct Burned has copy, drop {
        stage: 0x2::object::ID,
        round: u64,
        who: address,
        amount: u64,
        total: u64,
        took_lead: bool,
        ends_ms: u64,
    }

    struct RoundWon has copy, drop {
        stage: 0x2::object::ID,
        round: u64,
        winner: address,
        burned: u64,
        payout: u64,
        rolled: u64,
        round_total: u64,
        payout_bps: u64,
        next_round_ms: u64,
    }

    struct RoundVoided has copy, drop {
        stage: 0x2::object::ID,
        round: u64,
        round_total: u64,
    }

    struct PotToppedUp has copy, drop {
        stage: 0x2::object::ID,
        amount: u64,
        pot: u64,
    }

    struct EntryCoinPinned has copy, drop {
        stage: 0x2::object::ID,
        coin: 0x1::type_name::TypeName,
    }

    public fun burn<T0>(arg0: &mut Stage, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 0);
        assert!(arg0.open, 2);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 < arg0.ends_ms, 11);
        assert!(0x1::option::is_some<0x1::type_name::TypeName>(&arg0.entry_coin), 7);
        assert!(*0x1::option::borrow<0x1::type_name::TypeName>(&arg0.entry_coin) == 0x1::type_name::with_defining_ids<T0>(), 8);
        let v1 = 0x2::coin::value<T0>(&arg1);
        assert!(v1 >= 1111000000, 5);
        assert!(arg2 < 3, 16);
        let v2 = 0x2::tx_context::sender(arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, @0x0);
        if (!0x2::table::contains<address, Tally>(&arg0.tallies, v2) || 0x2::table::borrow<address, Tally>(&arg0.tallies, v2).round != arg0.round) {
            let v3 = Tally{
                round : arg0.round,
                total : v1,
                burns : 1,
            };
            if (0x2::table::contains<address, Tally>(&arg0.tallies, v2)) {
                *0x2::table::borrow_mut<address, Tally>(&mut arg0.tallies, v2) = v3;
            } else {
                0x2::table::add<address, Tally>(&mut arg0.tallies, v2, v3);
            };
            arg0.player_count = arg0.player_count + 1;
        } else {
            let v4 = 0x2::table::borrow_mut<address, Tally>(&mut arg0.tallies, v2);
            v4.total = v4.total + v1;
            v4.burns = v4.burns + 1;
        };
        let v5 = 0x2::table::borrow<address, Tally>(&arg0.tallies, v2).total;
        arg0.round_total = arg0.round_total + v1;
        let v6 = 0x1::vector::borrow_mut<u64>(&mut arg0.votes, arg2);
        *v6 = *v6 + v1;
        let v7 = v5 > arg0.leader_total;
        if (v7) {
            arg0.leader = v2;
            arg0.leader_total = v5;
            if (v2 != arg0.leader && v0 + arg0.extend_ms > arg0.ends_ms) {
                let v8 = v0 + arg0.extend_ms;
                let v9 = if (v8 > arg0.hard_end_ms) {
                    arg0.hard_end_ms
                } else {
                    v8
                };
                arg0.ends_ms = v9;
            };
        };
        let v10 = Burned{
            stage     : 0x2::object::id<Stage>(arg0),
            round     : arg0.round,
            who       : v2,
            amount    : v1,
            total     : v5,
            took_lead : v7,
            ends_ms   : arg0.ends_ms,
        };
        0x2::event::emit<Burned>(v10);
    }

    public fun burn_address() : address {
        @0x0
    }

    public fun burn_keeper_cap(arg0: KeeperCap) {
        let KeeperCap {
            id       : v0,
            stage_id : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun burned_by(arg0: &Stage, arg1: address) : (u64, u64) {
        if (!0x2::table::contains<address, Tally>(&arg0.tallies, arg1)) {
            return (0, 0)
        };
        let v0 = 0x2::table::borrow<address, Tally>(&arg0.tallies, arg1);
        if (v0.round != arg0.round) {
            return (0, 0)
        };
        (v0.total, v0.burns)
    }

    public fun closed_ms(arg0: &Stage) : u64 {
        arg0.closed_ms
    }

    public fun default_extend_ms() : u64 {
        900000
    }

    public fun default_full_burn() : u64 {
        300000000000
    }

    public fun default_round_ms() : u64 {
        86400000
    }

    public fun ends_ms(arg0: &Stage) : u64 {
        arg0.ends_ms
    }

    public fun extend_ms(arg0: &Stage) : u64 {
        arg0.extend_ms
    }

    public fun full_burn(arg0: &Stage) : u64 {
        arg0.full_burn
    }

    public fun full_burn_ms(arg0: &Stage) : u64 {
        arg0.full_burn_ms
    }

    public fun hard_cap_ms() : u64 {
        172800000
    }

    public fun hard_end_ms(arg0: &Stage) : u64 {
        arg0.hard_end_ms
    }

    public fun idle_rescue_ms() : u64 {
        2592000000
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        new_stage(arg0);
    }

    public fun is_open(arg0: &Stage) : bool {
        arg0.open
    }

    public fun leader(arg0: &Stage) : address {
        arg0.leader
    }

    public fun leader_total(arg0: &Stage) : u64 {
        arg0.leader_total
    }

    public fun max_curve_age_ms() : u64 {
        21600000
    }

    public fun max_full_burn() : u64 {
        20000000000000
    }

    public fun max_payout_bps() : u64 {
        9000
    }

    public fun migrate(arg0: &AdminCap, arg1: &mut Stage) {
        assert!(arg0.stage_id == 0x2::object::id<Stage>(arg1), 1);
        assert!(arg1.version < 1, 20);
        arg1.version = 1;
        let v0 = Migrated{
            stage : 0x2::object::id<Stage>(arg1),
            from  : arg1.version,
            to    : 1,
        };
        0x2::event::emit<Migrated>(v0);
    }

    public fun min_burn() : u64 {
        1111000000
    }

    public fun min_extend_ms() : u64 {
        15000
    }

    public fun min_full_burn() : u64 {
        50000000000
    }

    public fun min_round_ms() : u64 {
        60000
    }

    fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public fun new_keeper_cap(arg0: &AdminCap, arg1: &Stage, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.stage_id == 0x2::object::id<Stage>(arg1), 1);
        let v0 = KeeperCap{
            id       : 0x2::object::new(arg3),
            stage_id : 0x2::object::id<Stage>(arg1),
        };
        0x2::transfer::public_transfer<KeeperCap>(v0, arg2);
    }

    public fun new_stage(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = &mut v0;
        0x1::vector::push_back<u64>(v1, 21600000);
        0x1::vector::push_back<u64>(v1, 86400000);
        0x1::vector::push_back<u64>(v1, 129600000);
        let v2 = Stage{
            id           : 0x2::object::new(arg0),
            version      : 1,
            round        : 0,
            open         : false,
            opened_ms    : 0,
            ends_ms      : 0,
            hard_end_ms  : 0,
            round_ms     : 86400000,
            extend_ms    : 900000,
            full_burn    : 300000000000,
            full_burn_ms : 0,
            closed_ms    : 0,
            options_ms   : v0,
            votes        : vector[0, 0, 0],
            pot          : 0x2::balance::zero<0x2::sui::SUI>(),
            entry_coin   : 0x1::option::none<0x1::type_name::TypeName>(),
            tallies      : 0x2::table::new<address, Tally>(arg0),
            leader       : @0x0,
            leader_total : 0,
            round_total  : 0,
            player_count : 0,
        };
        let v3 = 0x2::object::id<Stage>(&v2);
        let v4 = AdminCap{
            id       : 0x2::object::new(arg0),
            stage_id : v3,
        };
        let v5 = KeeperCap{
            id       : 0x2::object::new(arg0),
            stage_id : v3,
        };
        0x2::transfer::share_object<Stage>(v2);
        0x2::transfer::public_transfer<AdminCap>(v4, 0x2::tx_context::sender(arg0));
        0x2::transfer::public_transfer<KeeperCap>(v5, 0x2::tx_context::sender(arg0));
    }

    fun open_inner(arg0: &mut Stage, arg1: &0x2::clock::Clock) {
        assert!(!arg0.open, 3);
        assert!(0x1::option::is_some<0x1::type_name::TypeName>(&arg0.entry_coin), 7);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.pot) > 0, 4);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 <= arg0.full_burn_ms + 21600000, 23);
        arg0.round = arg0.round + 1;
        arg0.open = true;
        arg0.opened_ms = v0;
        arg0.ends_ms = v0 + arg0.round_ms;
        arg0.hard_end_ms = v0 + 172800000;
        arg0.leader = @0x0;
        arg0.leader_total = 0;
        arg0.round_total = 0;
        arg0.player_count = 0;
        let v1 = RoundOpened{
            stage     : 0x2::object::id<Stage>(arg0),
            round     : arg0.round,
            pot       : 0x2::balance::value<0x2::sui::SUI>(&arg0.pot),
            opened_ms : v0,
            ends_ms   : arg0.ends_ms,
        };
        0x2::event::emit<RoundOpened>(v1);
    }

    public fun open_round(arg0: &KeeperCap, arg1: &mut Stage, arg2: &0x2::clock::Clock) {
        assert!(arg1.version == 1, 0);
        assert!(arg0.stage_id == 0x2::object::id<Stage>(arg1), 1);
        open_inner(arg1, arg2);
    }

    public fun open_round_after_silence(arg0: &mut Stage, arg1: &0x2::clock::Clock) {
        assert!(arg0.version == 1, 0);
        assert!(!arg0.open, 3);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.closed_ms + 2592000000, 24);
        open_inner(arg0, arg1);
    }

    public fun options_ms(arg0: &Stage) : &vector<u64> {
        &arg0.options_ms
    }

    public fun payout_bps(arg0: u64, arg1: u64) : u64 {
        if (arg1 >= arg0) {
            9000
        } else {
            mul_div(9000, arg1, arg0)
        }
    }

    public fun payout_bps_now(arg0: &Stage, arg1: u64) : u64 {
        payout_bps(arg0.full_burn, arg1)
    }

    public fun pin_entry_coin<T0>(arg0: &AdminCap, arg1: &mut Stage) {
        assert!(arg1.version == 1, 0);
        assert!(arg0.stage_id == 0x2::object::id<Stage>(arg1), 1);
        assert!(0x1::option::is_none<0x1::type_name::TypeName>(&arg1.entry_coin), 10);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        0x1::option::fill<0x1::type_name::TypeName>(&mut arg1.entry_coin, v0);
        let v1 = EntryCoinPinned{
            stage : 0x2::object::id<Stage>(arg1),
            coin  : v0,
        };
        0x2::event::emit<EntryCoinPinned>(v1);
    }

    public fun player_count(arg0: &Stage) : u64 {
        arg0.player_count
    }

    public fun pot(arg0: &Stage) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.pot)
    }

    public fun resolve(arg0: &mut Stage, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 0);
        assert!(arg0.open, 2);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.ends_ms, 6);
        let v0 = arg0.round_total;
        let v1 = *0x1::vector::borrow<u64>(&arg0.votes, 0) + *0x1::vector::borrow<u64>(&arg0.votes, 1) + *0x1::vector::borrow<u64>(&arg0.votes, 2) > 0;
        let v2 = if (v1) {
            winning_option(arg0)
        } else {
            arg0.round_ms
        };
        if (v1) {
            arg0.round_ms = v2;
            arg0.extend_ms = window_for(v2);
        };
        arg0.votes = vector[0, 0, 0];
        if (v0 == 0) {
            arg0.open = false;
            arg0.closed_ms = 0x2::clock::timestamp_ms(arg1);
            let v3 = RoundVoided{
                stage       : 0x2::object::id<Stage>(arg0),
                round       : arg0.round,
                round_total : v0,
            };
            0x2::event::emit<RoundVoided>(v3);
            return
        };
        let v4 = arg0.leader;
        let v5 = payout_bps(arg0.full_burn, v0);
        let v6 = mul_div(0x2::balance::value<0x2::sui::SUI>(&arg0.pot), v5, 10000);
        arg0.open = false;
        arg0.closed_ms = 0x2::clock::timestamp_ms(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.pot, v6), arg2), v4);
        let v7 = RoundWon{
            stage         : 0x2::object::id<Stage>(arg0),
            round         : arg0.round,
            winner        : v4,
            burned        : arg0.leader_total,
            payout        : v6,
            rolled        : 0x2::balance::value<0x2::sui::SUI>(&arg0.pot),
            round_total   : v0,
            payout_bps    : v5,
            next_round_ms : v2,
        };
        0x2::event::emit<RoundWon>(v7);
    }

    public fun round(arg0: &Stage) : u64 {
        arg0.round
    }

    public fun round_ms(arg0: &Stage) : u64 {
        arg0.round_ms
    }

    public fun round_total(arg0: &Stage) : u64 {
        arg0.round_total
    }

    public fun set_full_burn(arg0: &KeeperCap, arg1: &mut Stage, arg2: u64, arg3: &0x2::clock::Clock) {
        assert!(arg1.version == 1, 0);
        assert!(arg0.stage_id == 0x2::object::id<Stage>(arg1), 1);
        assert!(!arg1.open, 3);
        assert!(arg2 >= 50000000000 && arg2 <= 20000000000000, 18);
        if (arg1.full_burn_ms > 0) {
            assert!(arg2 >= mul_div(arg1.full_burn, 75, 100), 25);
            assert!(arg2 <= mul_div(arg1.full_burn, 250, 100), 25);
        };
        arg1.full_burn = arg2;
        arg1.full_burn_ms = 0x2::clock::timestamp_ms(arg3);
        let v0 = FullBurnSet{
            stage         : 0x2::object::id<Stage>(arg1),
            old_full_burn : arg1.full_burn,
            new_full_burn : arg2,
        };
        0x2::event::emit<FullBurnSet>(v0);
    }

    public fun set_options(arg0: &AdminCap, arg1: &mut Stage, arg2: u64, arg3: u64, arg4: u64) {
        assert!(arg1.version == 1, 0);
        assert!(arg0.stage_id == 0x2::object::id<Stage>(arg1), 1);
        assert!(!arg1.open, 3);
        assert!(arg2 >= 60000, 12);
        assert!(arg2 < arg3 && arg3 < arg4, 17);
        assert!(arg4 + 900000 <= 172800000, 21);
        let v0 = 0x1::vector::empty<u64>();
        let v1 = &mut v0;
        0x1::vector::push_back<u64>(v1, arg2);
        0x1::vector::push_back<u64>(v1, arg3);
        0x1::vector::push_back<u64>(v1, arg4);
        assert!(arg1.options_ms != v0, 22);
        let v2 = 0x1::vector::empty<u64>();
        let v3 = &mut v2;
        0x1::vector::push_back<u64>(v3, arg2);
        0x1::vector::push_back<u64>(v3, arg3);
        0x1::vector::push_back<u64>(v3, arg4);
        arg1.options_ms = v2;
        let v4 = OptionsSet{
            stage      : 0x2::object::id<Stage>(arg1),
            options_ms : arg1.options_ms,
        };
        0x2::event::emit<OptionsSet>(v4);
    }

    public fun set_round_length(arg0: &AdminCap, arg1: &mut Stage, arg2: u64) {
        assert!(arg1.version == 1, 0);
        assert!(arg0.stage_id == 0x2::object::id<Stage>(arg1), 1);
        assert!(!arg1.open, 3);
        assert!(arg2 >= 60000, 12);
        assert!(arg2 + 900000 <= 172800000, 21);
        assert!(arg2 != arg1.round_ms, 13);
        arg1.round_ms = arg2;
        arg1.extend_ms = window_for(arg2);
        let v0 = TimingSet{
            stage         : 0x2::object::id<Stage>(arg1),
            old_round_ms  : arg1.round_ms,
            new_round_ms  : arg2,
            old_extend_ms : arg1.extend_ms,
            new_extend_ms : arg1.extend_ms,
        };
        0x2::event::emit<TimingSet>(v0);
    }

    public fun top_up(arg0: &mut Stage, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        assert!(arg0.version == 1, 0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.pot, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v0 = PotToppedUp{
            stage  : 0x2::object::id<Stage>(arg0),
            amount : 0x2::coin::value<0x2::sui::SUI>(&arg1),
            pot    : 0x2::balance::value<0x2::sui::SUI>(&arg0.pot),
        };
        0x2::event::emit<PotToppedUp>(v0);
    }

    public fun votes(arg0: &Stage) : &vector<u64> {
        &arg0.votes
    }

    public fun window_for(arg0: u64) : u64 {
        let v0 = arg0 / 8;
        if (v0 < 15000) {
            15000
        } else if (v0 > 900000) {
            900000
        } else {
            v0
        }
    }

    public fun winning_option(arg0: &Stage) : u64 {
        let v0 = *0x1::vector::borrow<u64>(&arg0.votes, 0);
        let v1 = 1;
        while (v1 < 3) {
            if (*0x1::vector::borrow<u64>(&arg0.votes, v1) > v0) {
                v0 = *0x1::vector::borrow<u64>(&arg0.votes, v1);
            };
            v1 = v1 + 1;
        };
        *0x1::vector::borrow<u64>(&arg0.options_ms, 0)
    }

    // decompiled from Move bytecode v7
}

