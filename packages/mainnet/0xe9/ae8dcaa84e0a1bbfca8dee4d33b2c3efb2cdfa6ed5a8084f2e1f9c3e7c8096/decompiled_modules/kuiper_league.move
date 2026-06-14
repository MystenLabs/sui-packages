module 0x4c8a3b642d72e62b54c1cc571788d7fc5d009284bae718015444f0b2e11c277b::kuiper_league {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct LeagueConfig has key {
        id: 0x2::object::UID,
        entry_price_usd_micro: u64,
        fixed_entry_price_mist: 0x1::option::Option<u64>,
        winner_bps: u64,
        treasury_bps: u64,
        max_players: u64,
        duration_ms: u64,
        fill_timeout_ms: u64,
        treasury: address,
        pyth_feed_id: vector<u8>,
        paused: bool,
    }

    struct Entrant has copy, drop, store {
        wallet: address,
        uid_hash: vector<u8>,
        paid_mist: u64,
    }

    struct League has key {
        id: 0x2::object::UID,
        entrants: vector<Entrant>,
        pot: 0x2::balance::Balance<0x2::sui::SUI>,
        status: u8,
        max_players: u64,
        duration_ms: u64,
        fill_timeout_ms: u64,
        winner_bps: u64,
        treasury_bps: u64,
        treasury: address,
        created_ms: u64,
        started_ms: u64,
        ends_ms: u64,
        winner: 0x1::option::Option<address>,
        leaderboard_commit: 0x1::option::Option<vector<u8>>,
        settled_ms: u64,
    }

    struct LeagueCreated has copy, drop {
        league_id: 0x2::object::ID,
        created_ms: u64,
        fill_deadline_ms: u64,
        max_players: u64,
    }

    struct PlayerJoined has copy, drop {
        league_id: 0x2::object::ID,
        wallet: address,
        uid_hash: vector<u8>,
        paid_mist: u64,
        entrant_count: u64,
    }

    struct LeagueFilled has copy, drop {
        league_id: 0x2::object::ID,
        started_ms: u64,
        ends_ms: u64,
    }

    struct LeagueSettled has copy, drop {
        league_id: 0x2::object::ID,
        winner: address,
        winner_amount: u64,
        treasury_amount: u64,
        leaderboard_commit: vector<u8>,
        settled_ms: u64,
    }

    struct LeagueRefunded has copy, drop {
        league_id: 0x2::object::ID,
        entrant_count: u64,
        refunded_mist: u64,
        refunded_ms: u64,
        reason: u8,
    }

    struct PlayerProfile has store, key {
        id: 0x2::object::UID,
        owner: address,
        nickname: 0x1::string::String,
    }

    public fun active_status() : u8 {
        1
    }

    fun assert_valid_bps(arg0: u64, arg1: u64) {
        assert!(arg0 > 0 && arg1 > 0, 9);
        assert!(arg0 + arg1 == 10000, 9);
    }

    fun checked_add(arg0: u64, arg1: u64) : u64 {
        assert!(arg0 <= 18446744073709551615 - arg1, 5);
        arg0 + arg1
    }

    fun checked_bps_amount(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 <= 10000, 9);
        checked_mul(arg0, arg1) / 10000
    }

    fun checked_div_round_up(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 > 0, 8);
        if (arg0 == 0) {
            0
        } else {
            assert!(arg0 - 1 <= 18446744073709551615 - arg1, 12);
            (arg0 - 1 + arg1) / arg1
        }
    }

    fun checked_mul(arg0: u64, arg1: u64) : u64 {
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        assert!(arg0 <= 18446744073709551615 / arg1, 12);
        arg0 * arg1
    }

    public entry fun clear_fixed_entry_price_mist(arg0: &AdminCap, arg1: &mut LeagueConfig) {
        if (0x1::option::is_some<u64>(&arg1.fixed_entry_price_mist)) {
            0x1::option::extract<u64>(&mut arg1.fixed_entry_price_mist);
        };
    }

    public fun config_duration_ms(arg0: &LeagueConfig) : u64 {
        arg0.duration_ms
    }

    public fun config_entry_price_usd_micro(arg0: &LeagueConfig) : u64 {
        arg0.entry_price_usd_micro
    }

    public fun config_fill_timeout_ms(arg0: &LeagueConfig) : u64 {
        arg0.fill_timeout_ms
    }

    public fun config_fixed_entry_price_mist(arg0: &LeagueConfig) : 0x1::option::Option<u64> {
        arg0.fixed_entry_price_mist
    }

    public fun config_max_players(arg0: &LeagueConfig) : u64 {
        arg0.max_players
    }

    public fun config_paused(arg0: &LeagueConfig) : bool {
        arg0.paused
    }

    public fun config_pyth_feed_id(arg0: &LeagueConfig) : vector<u8> {
        arg0.pyth_feed_id
    }

    public fun config_treasury(arg0: &LeagueConfig) : address {
        arg0.treasury
    }

    public fun config_treasury_bps(arg0: &LeagueConfig) : u64 {
        arg0.treasury_bps
    }

    public fun config_winner_bps(arg0: &LeagueConfig) : u64 {
        arg0.winner_bps
    }

    fun contains_entrant(arg0: &League, arg1: address) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Entrant>(&arg0.entrants)) {
            if (0x1::vector::borrow<Entrant>(&arg0.entrants, v0).wallet == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public entry fun create_league(arg0: &AdminCap, arg1: &LeagueConfig, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.paused, 0);
        assert_valid_bps(arg1.winner_bps, arg1.treasury_bps);
        assert!(arg1.max_players > 0 && arg1.max_players <= 100, 8);
        assert!(arg1.duration_ms > 0 && arg1.fill_timeout_ms > 0, 8);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = League{
            id                 : 0x2::object::new(arg3),
            entrants           : 0x1::vector::empty<Entrant>(),
            pot                : 0x2::balance::zero<0x2::sui::SUI>(),
            status             : 0,
            max_players        : arg1.max_players,
            duration_ms        : arg1.duration_ms,
            fill_timeout_ms    : arg1.fill_timeout_ms,
            winner_bps         : arg1.winner_bps,
            treasury_bps       : arg1.treasury_bps,
            treasury           : arg1.treasury,
            created_ms         : v0,
            started_ms         : 0,
            ends_ms            : 0,
            winner             : 0x1::option::none<address>(),
            leaderboard_commit : 0x1::option::none<vector<u8>>(),
            settled_ms         : 0,
        };
        let v2 = LeagueCreated{
            league_id        : 0x2::object::id<League>(&v1),
            created_ms       : v0,
            fill_deadline_ms : checked_add(v0, arg1.fill_timeout_ms),
            max_players      : arg1.max_players,
        };
        0x2::event::emit<LeagueCreated>(v2);
        0x2::transfer::share_object<League>(v1);
    }

    fun default_config(arg0: &mut 0x2::tx_context::TxContext) : LeagueConfig {
        LeagueConfig{
            id                     : 0x2::object::new(arg0),
            entry_price_usd_micro  : 5000000,
            fixed_entry_price_mist : 0x1::option::none<u64>(),
            winner_bps             : 8000,
            treasury_bps           : 2000,
            max_players            : 5,
            duration_ms            : 172800000,
            fill_timeout_ms        : 86400000,
            treasury               : @0xce4be8bcc98ee6a8ffdf3da5b7ae9d6ab14f77f112a9df81e966903c19b4295f,
            pyth_feed_id           : x"23d7315113f5b1d3ba7a83604c44b94d79f4fd69af77f804fc7f920a6dc65744",
            paused                 : false,
        }
    }

    public entry fun emergency_refund(arg0: &mut League, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 1, 1);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 >= checked_add(arg0.ends_ms, 604800000), 6);
        pay_refund(arg0, v0, 2, arg2);
    }

    public entry fun enter_league(arg0: &mut League, arg1: &LeagueConfig, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = if (0x1::option::is_some<u64>(&arg1.fixed_entry_price_mist)) {
            *0x1::option::borrow<u64>(&arg1.fixed_entry_price_mist)
        } else {
            required_mist_from_pyth(arg1, arg3, arg5)
        };
        enter_league_with_required_mist(arg0, arg1, arg2, arg4, v0, arg5, arg6);
    }

    public entry fun enter_league_fixed(arg0: &mut League, arg1: &LeagueConfig, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<u64>(&arg1.fixed_entry_price_mist), 14);
        enter_league_with_required_mist(arg0, arg1, arg2, arg3, *0x1::option::borrow<u64>(&arg1.fixed_entry_price_mist), arg4, arg5);
    }

    fun enter_league_with_required_mist(arg0: &mut League, arg1: &LeagueConfig, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: vector<u8>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.paused, 0);
        assert!(arg0.status == 0, 1);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        assert!(v0 < checked_add(arg0.created_ms, arg0.fill_timeout_ms), 15);
        assert!(0x1::vector::length<Entrant>(&arg0.entrants) < arg0.max_players, 2);
        let v1 = 0x2::tx_context::sender(arg6);
        assert!(!contains_entrant(arg0, v1), 3);
        assert!(0x1::vector::length<u8>(&arg3) <= 32, 16);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= arg4, 4);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.pot, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, arg4, arg6)));
        if (0x2::coin::value<0x2::sui::SUI>(&arg2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, v1);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg2);
        };
        let v2 = Entrant{
            wallet    : v1,
            uid_hash  : arg3,
            paid_mist : arg4,
        };
        0x1::vector::push_back<Entrant>(&mut arg0.entrants, v2);
        let v3 = 0x1::vector::length<Entrant>(&arg0.entrants);
        let v4 = PlayerJoined{
            league_id     : 0x2::object::id<League>(arg0),
            wallet        : v1,
            uid_hash      : arg3,
            paid_mist     : arg4,
            entrant_count : v3,
        };
        0x2::event::emit<PlayerJoined>(v4);
        if (v3 == arg0.max_players) {
            arg0.status = 1;
            arg0.started_ms = v0;
            arg0.ends_ms = checked_add(v0, arg0.duration_ms);
            let v5 = LeagueFilled{
                league_id  : 0x2::object::id<League>(arg0),
                started_ms : arg0.started_ms,
                ends_ms    : arg0.ends_ms,
            };
            0x2::event::emit<LeagueFilled>(v5);
        };
    }

    public fun entrant_paid_mist(arg0: &Entrant) : u64 {
        arg0.paid_mist
    }

    public fun entrant_uid_hash(arg0: &Entrant) : vector<u8> {
        arg0.uid_hash
    }

    public fun entrant_wallet(arg0: &Entrant) : address {
        arg0.wallet
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<LeagueConfig>(default_config(arg0));
    }

    public fun league_duration_ms(arg0: &League) : u64 {
        arg0.duration_ms
    }

    public fun league_ends_ms(arg0: &League) : u64 {
        arg0.ends_ms
    }

    public fun league_entrant_count(arg0: &League) : u64 {
        0x1::vector::length<Entrant>(&arg0.entrants)
    }

    public fun league_fill_timeout_ms(arg0: &League) : u64 {
        arg0.fill_timeout_ms
    }

    public fun league_leaderboard_commit(arg0: &League) : 0x1::option::Option<vector<u8>> {
        arg0.leaderboard_commit
    }

    public fun league_max_players(arg0: &League) : u64 {
        arg0.max_players
    }

    public fun league_pot_value(arg0: &League) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.pot)
    }

    public fun league_started_ms(arg0: &League) : u64 {
        arg0.started_ms
    }

    public fun league_status(arg0: &League) : u8 {
        arg0.status
    }

    public fun league_treasury(arg0: &League) : address {
        arg0.treasury
    }

    public fun league_treasury_bps(arg0: &League) : u64 {
        arg0.treasury_bps
    }

    public fun league_winner(arg0: &League) : 0x1::option::Option<address> {
        arg0.winner
    }

    public fun league_winner_bps(arg0: &League) : u64 {
        arg0.winner_bps
    }

    public fun open_status() : u8 {
        0
    }

    public fun paid_status() : u8 {
        2
    }

    fun pay_refund(arg0: &mut League, arg1: u64, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<Entrant>(&arg0.entrants);
        arg0.status = 3;
        arg0.settled_ms = arg1;
        if (v0 > 0) {
            let v1 = 0;
            while (v1 < v0) {
                let v2 = 0x1::vector::borrow<Entrant>(&arg0.entrants, v1);
                let v3 = if (v1 + 1 == v0) {
                    0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.pot), arg3)
                } else {
                    0x2::coin::take<0x2::sui::SUI>(&mut arg0.pot, v2.paid_mist, arg3)
                };
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v3, v2.wallet);
                v1 = v1 + 1;
            };
        };
        let v4 = LeagueRefunded{
            league_id     : 0x2::object::id<League>(arg0),
            entrant_count : v0,
            refunded_mist : 0x2::balance::value<0x2::sui::SUI>(&arg0.pot),
            refunded_ms   : arg1,
            reason        : arg2,
        };
        0x2::event::emit<LeagueRefunded>(v4);
    }

    fun pow10(arg0: u64) : u64 {
        let v0 = 1;
        let v1 = 0;
        while (v1 < arg0) {
            v0 = checked_mul(v0, 10);
            v1 = v1 + 1;
        };
        v0
    }

    public entry fun refund_active(arg0: &AdminCap, arg1: &mut League, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.status == 1, 1);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 >= arg1.ends_ms, 6);
        pay_refund(arg1, v0, 1, arg3);
    }

    public entry fun refund_league(arg0: &mut League, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0, 1);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 >= checked_add(arg0.created_ms, arg0.fill_timeout_ms), 6);
        pay_refund(arg0, v0, 0, arg2);
    }

    public fun refunded_status() : u8 {
        3
    }

    fun required_mist_from_pyth(arg0: &LeagueConfig, arg1: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg2: &0x2::clock::Clock) : u64 {
        let v0 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::pyth::get_price_no_older_than(arg1, arg2, 60);
        let v1 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::get_price_info_from_price_info_object(arg1);
        let v2 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::get_price_identifier(&v1);
        assert!(0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_identifier::get_bytes(&v2) == arg0.pyth_feed_id, 10);
        let v3 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_price(&v0);
        assert!(!0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_is_negative(&v3), 11);
        let v4 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_magnitude_if_positive(&v3);
        assert!(v4 > 0, 11);
        let v5 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_expo(&v0);
        let v6 = if (0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_is_negative(&v5)) {
            let v7 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_magnitude_if_negative(&v5);
            if (v7 <= 6) {
                checked_mul(v4, pow10(6 - v7))
            } else {
                v4 / pow10(v7 - 6)
            }
        } else {
            checked_mul(v4, pow10(0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_magnitude_if_positive(&v5) + 6))
        };
        assert!(v6 > 0, 11);
        checked_div_round_up(checked_mul(arg0.entry_price_usd_micro, 1000000000), v6)
    }

    public entry fun set_bps(arg0: &AdminCap, arg1: &mut LeagueConfig, arg2: u64, arg3: u64) {
        assert_valid_bps(arg2, arg3);
        arg1.winner_bps = arg2;
        arg1.treasury_bps = arg3;
    }

    public entry fun set_duration_ms(arg0: &AdminCap, arg1: &mut LeagueConfig, arg2: u64) {
        assert!(arg2 > 0, 8);
        arg1.duration_ms = arg2;
    }

    public entry fun set_entry_price_usd_micro(arg0: &AdminCap, arg1: &mut LeagueConfig, arg2: u64) {
        assert!(arg2 > 0, 8);
        assert!(arg2 <= 18446744073709551615 / 1000000000, 12);
        arg1.entry_price_usd_micro = arg2;
    }

    public entry fun set_fill_timeout_ms(arg0: &AdminCap, arg1: &mut LeagueConfig, arg2: u64) {
        assert!(arg2 > 0, 8);
        arg1.fill_timeout_ms = arg2;
    }

    public entry fun set_fixed_entry_price_mist(arg0: &AdminCap, arg1: &mut LeagueConfig, arg2: u64) {
        assert!(arg2 > 0, 8);
        0x1::option::swap_or_fill<u64>(&mut arg1.fixed_entry_price_mist, arg2);
    }

    public entry fun set_max_players(arg0: &AdminCap, arg1: &mut LeagueConfig, arg2: u64) {
        assert!(arg2 > 0 && arg2 <= 100, 8);
        arg1.max_players = arg2;
    }

    public entry fun set_nickname(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg0) <= 30, 0);
        let v0 = PlayerProfile{
            id       : 0x2::object::new(arg1),
            owner    : 0x2::tx_context::sender(arg1),
            nickname : 0x1::string::utf8(arg0),
        };
        0x2::transfer::transfer<PlayerProfile>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun set_paused(arg0: &AdminCap, arg1: &mut LeagueConfig, arg2: bool) {
        arg1.paused = arg2;
    }

    public entry fun set_pyth_feed_id(arg0: &AdminCap, arg1: &mut LeagueConfig, arg2: vector<u8>) {
        assert!(0x1::vector::length<u8>(&arg2) == 32, 10);
        arg1.pyth_feed_id = arg2;
    }

    public entry fun set_treasury(arg0: &AdminCap, arg1: &mut LeagueConfig, arg2: address) {
        arg1.treasury = arg2;
    }

    public entry fun settle_league(arg0: &AdminCap, arg1: &mut League, arg2: address, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.status == 1, 1);
        assert!(0x1::vector::length<u8>(&arg3) <= 64, 17);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(v0 >= arg1.ends_ms, 6);
        assert!(contains_entrant(arg1, arg2), 7);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&arg1.pot);
        let v2 = checked_bps_amount(v1, arg1.winner_bps);
        0x1::option::fill<address>(&mut arg1.winner, arg2);
        0x1::option::fill<vector<u8>>(&mut arg1.leaderboard_commit, arg3);
        arg1.status = 2;
        arg1.settled_ms = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.pot, v2, arg5), arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg1.pot), arg5), arg1.treasury);
        let v3 = LeagueSettled{
            league_id          : 0x2::object::id<League>(arg1),
            winner             : arg2,
            winner_amount      : v2,
            treasury_amount    : v1 - v2,
            leaderboard_commit : *0x1::option::borrow<vector<u8>>(&arg1.leaderboard_commit),
            settled_ms         : v0,
        };
        0x2::event::emit<LeagueSettled>(v3);
    }

    public entry fun transfer_admin(arg0: AdminCap, arg1: address) {
        0x2::transfer::transfer<AdminCap>(arg0, arg1);
    }

    public entry fun update_nickname(arg0: &mut PlayerProfile, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg1) <= 30, 0);
        arg0.nickname = 0x1::string::utf8(arg1);
    }

    // decompiled from Move bytecode v7
}

