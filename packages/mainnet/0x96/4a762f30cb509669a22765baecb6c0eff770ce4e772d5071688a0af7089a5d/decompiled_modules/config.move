module 0x964a762f30cb509669a22765baecb6c0eff770ce4e772d5071688a0af7089a5d::config {
    struct PotAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PotVerifierCap has store, key {
        id: 0x2::object::UID,
    }

    struct PotKeeperCap has store, key {
        id: 0x2::object::UID,
    }

    struct PotConfig<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        paused: bool,
        house: address,
        pool_id: 0x2::object::ID,
        registry_id: 0x2::object::ID,
        coin_decimals: u8,
        pot_amount: u64,
        max_pot_bps: u64,
        daily_spend_bps: u64,
        win_bps: u64,
        ticket_coin_days: u64,
        retro_window_ms: u64,
        max_tickets: u64,
        daily_games: u64,
        daily_wins: u64,
        game_window_ms: u64,
        settle_grace_ms: u64,
        ticket_price_bps: u64,
        split_pool_bps: u64,
        split_burn_bps: u64,
        split_studio_bps: u64,
        difficulty: u8,
        keeper_pot_day: u64,
        keeper_pot_anchor: u64,
        keeper_difficulty_day: u64,
        keeper_difficulty_anchor: u8,
        verifiers: 0x2::vec_set::VecSet<0x2::object::ID>,
        keepers: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    struct PotConfigUpdated has copy, drop {
        config_id: 0x2::object::ID,
        field: vector<u8>,
        keeper: 0x1::option::Option<0x2::object::ID>,
    }

    struct PotVerifierIssued has copy, drop {
        config_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
    }

    struct PotVerifierRevoked has copy, drop {
        config_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
    }

    struct PotKeeperIssued has copy, drop {
        config_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
    }

    struct PotKeeperRevoked has copy, drop {
        config_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
    }

    public(friend) fun new<T0>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: u8, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : PotConfig<T0> {
        assert_house(arg2);
        assert_pot_amount(arg3);
        assert!(arg4 <= 18, 13906837064859189292);
        assert_in(arg5, 1000, 1000000000000);
        PotConfig<T0>{
            id                       : 0x2::object::new(arg6),
            version                  : 1,
            paused                   : false,
            house                    : arg2,
            pool_id                  : arg0,
            registry_id              : arg1,
            coin_decimals            : arg4,
            pot_amount               : arg3,
            max_pot_bps              : 200,
            daily_spend_bps          : 1000,
            win_bps                  : 9500,
            ticket_coin_days         : arg5,
            retro_window_ms          : 2592000000,
            max_tickets              : 30,
            daily_games              : 5,
            daily_wins               : 2,
            game_window_ms           : 1200000,
            settle_grace_ms          : 600000,
            ticket_price_bps         : 6000,
            split_pool_bps           : 8500,
            split_burn_bps           : 1000,
            split_studio_bps         : 500,
            difficulty               : 2,
            keeper_pot_day           : 18446744073709551615,
            keeper_pot_anchor        : 0,
            keeper_difficulty_day    : 18446744073709551615,
            keeper_difficulty_anchor : 0,
            verifiers                : 0x2::vec_set::empty<0x2::object::ID>(),
            keepers                  : 0x2::vec_set::empty<0x2::object::ID>(),
        }
    }

    public(friend) fun assert_accepting<T0>(arg0: &PotConfig<T0>) {
        assert_version<T0>(arg0);
        assert!(!arg0.paused, 13906837266722521130);
    }

    fun assert_house(arg0: address) {
        assert!(arg0 != @0x0, 13906837395571802158);
    }

    fun assert_in(arg0: u64, arg1: u64, arg2: u64) {
        assert!(arg0 >= arg1 && arg0 <= arg2, 13906837361211932716);
    }

    public(friend) fun assert_keeper<T0>(arg0: &PotConfig<T0>, arg1: &PotKeeperCap) {
        let v0 = 0x2::object::id<PotKeeperCap>(arg1);
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.keepers, &v0), 13906837318263046200);
    }

    fun assert_pot_amount(arg0: u64) {
        assert_in(arg0, 1, 72057594037927936);
    }

    fun assert_split(arg0: u64, arg1: u64, arg2: u64) {
        let v0 = if (arg0 <= 10000) {
            if (arg1 <= 10000) {
                if (arg2 <= 10000) {
                    arg0 + arg1 + arg2 == 10000
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 13906837425636704304);
    }

    public(friend) fun assert_verifier<T0>(arg0: &PotConfig<T0>, arg1: &PotVerifierCap) {
        let v0 = 0x2::object::id<PotVerifierCap>(arg1);
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.verifiers, &v0), 13906837292492980276);
    }

    public(friend) fun assert_version<T0>(arg0: &PotConfig<T0>) {
        assert!(arg0.version == 1, 13906837240952455206);
    }

    public fun coin_decimals<T0>(arg0: &PotConfig<T0>) : u8 {
        arg0.coin_decimals
    }

    public fun coin_unit<T0>(arg0: &PotConfig<T0>) : u64 {
        0x1::u64::pow(10, arg0.coin_decimals)
    }

    public fun daily_games<T0>(arg0: &PotConfig<T0>) : u64 {
        arg0.daily_games
    }

    public fun daily_spend_bps<T0>(arg0: &PotConfig<T0>) : u64 {
        arg0.daily_spend_bps
    }

    public fun daily_wins<T0>(arg0: &PotConfig<T0>) : u64 {
        arg0.daily_wins
    }

    public fun difficulty<T0>(arg0: &PotConfig<T0>) : u8 {
        arg0.difficulty
    }

    fun emit_updated<T0>(arg0: &PotConfig<T0>, arg1: vector<u8>, arg2: 0x1::option::Option<0x2::object::ID>) {
        let v0 = PotConfigUpdated{
            config_id : 0x2::object::id<PotConfig<T0>>(arg0),
            field     : arg1,
            keeper    : arg2,
        };
        0x2::event::emit<PotConfigUpdated>(v0);
    }

    public fun game_window_ms<T0>(arg0: &PotConfig<T0>) : u64 {
        arg0.game_window_ms
    }

    public fun house<T0>(arg0: &PotConfig<T0>) : address {
        arg0.house
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PotAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<PotAdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun is_keeper<T0>(arg0: &PotConfig<T0>, arg1: 0x2::object::ID) : bool {
        0x2::vec_set::contains<0x2::object::ID>(&arg0.keepers, &arg1)
    }

    public fun is_paused<T0>(arg0: &PotConfig<T0>) : bool {
        arg0.paused
    }

    public fun is_verifier<T0>(arg0: &PotConfig<T0>, arg1: 0x2::object::ID) : bool {
        0x2::vec_set::contains<0x2::object::ID>(&arg0.verifiers, &arg1)
    }

    public fun issue_keeper_cap<T0>(arg0: &mut PotConfig<T0>, arg1: &PotAdminCap, arg2: &mut 0x2::tx_context::TxContext) : PotKeeperCap {
        assert_version<T0>(arg0);
        assert!(0x2::vec_set::length<0x2::object::ID>(&arg0.keepers) < 4, 13906836261701222458);
        let v0 = PotKeeperCap{id: 0x2::object::new(arg2)};
        let v1 = 0x2::object::id<PotKeeperCap>(&v0);
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.keepers, v1);
        let v2 = PotKeeperIssued{
            config_id : 0x2::object::id<PotConfig<T0>>(arg0),
            cap_id    : v1,
        };
        0x2::event::emit<PotKeeperIssued>(v2);
        v0
    }

    public fun issue_verifier_cap<T0>(arg0: &mut PotConfig<T0>, arg1: &PotAdminCap, arg2: &mut 0x2::tx_context::TxContext) : PotVerifierCap {
        assert_version<T0>(arg0);
        assert!(0x2::vec_set::length<0x2::object::ID>(&arg0.verifiers) < 4, 13906836141441876022);
        let v0 = PotVerifierCap{id: 0x2::object::new(arg2)};
        let v1 = 0x2::object::id<PotVerifierCap>(&v0);
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.verifiers, v1);
        let v2 = PotVerifierIssued{
            config_id : 0x2::object::id<PotConfig<T0>>(arg0),
            cap_id    : v1,
        };
        0x2::event::emit<PotVerifierIssued>(v2);
        v0
    }

    public fun keeper_count<T0>(arg0: &PotConfig<T0>) : u64 {
        0x2::vec_set::length<0x2::object::ID>(&arg0.keepers)
    }

    public fun keeper_difficulty_range<T0>(arg0: &PotConfig<T0>, arg1: &0x2::clock::Clock) : (u8, u8) {
        let v0 = if (arg0.keeper_difficulty_day == 0x2::clock::timestamp_ms(arg1) / 86400000) {
            arg0.keeper_difficulty_anchor
        } else {
            arg0.difficulty
        };
        let v1 = if (v0 >= 1) {
            v0 - 1
        } else {
            0
        };
        (0x1::u8::max(v1, 1), 0x1::u8::min(v0 + 1, 6))
    }

    public fun keeper_pot_range<T0>(arg0: &PotConfig<T0>, arg1: &0x2::clock::Clock) : (u64, u64) {
        let v0 = if (arg0.keeper_pot_day == 0x2::clock::timestamp_ms(arg1) / 86400000) {
            arg0.keeper_pot_anchor
        } else {
            arg0.pot_amount
        };
        let v1 = 0x1::u64::mul_div(v0, 2500, 10000);
        (0x1::u64::max(v0 - v1, 1), 0x1::u64::min(v0 + v1, 72057594037927936))
    }

    public fun keeper_set_difficulty<T0>(arg0: &mut PotConfig<T0>, arg1: &PotKeeperCap, arg2: u8, arg3: &0x2::clock::Clock) {
        assert_version<T0>(arg0);
        assert_keeper<T0>(arg0, arg1);
        assert!(arg2 >= 1 && arg2 <= 6, 13906836540873179180);
        assert!(arg2 != arg0.difficulty, 13906836545168539698);
        let v0 = 0x2::clock::timestamp_ms(arg3) / 86400000;
        let v1 = if (arg0.keeper_difficulty_day == v0) {
            arg0.keeper_difficulty_anchor
        } else {
            arg0.difficulty
        };
        assert!(arg2 <= v1 + 1 && arg2 + 1 >= v1, 13906836575233966140);
        arg0.keeper_difficulty_day = v0;
        arg0.keeper_difficulty_anchor = v1;
        arg0.difficulty = arg2;
        emit_updated<T0>(arg0, b"difficulty", 0x1::option::some<0x2::object::ID>(0x2::object::id<PotKeeperCap>(arg1)));
    }

    public fun keeper_set_pot_amount<T0>(arg0: &mut PotConfig<T0>, arg1: &PotKeeperCap, arg2: u64, arg3: &0x2::clock::Clock) {
        assert_version<T0>(arg0);
        assert_keeper<T0>(arg0, arg1);
        assert_pot_amount(arg2);
        assert!(arg2 != arg0.pot_amount, 13906836442089324594);
        let v0 = 0x2::clock::timestamp_ms(arg3) / 86400000;
        let v1 = if (arg0.keeper_pot_day == v0) {
            arg0.keeper_pot_anchor
        } else {
            arg0.pot_amount
        };
        let v2 = 0x1::u64::mul_div(v1, 2500, 10000);
        assert!(arg2 >= v1 - v2 && arg2 <= v1 + v2, 13906836463564816444);
        arg0.keeper_pot_day = v0;
        arg0.keeper_pot_anchor = v1;
        arg0.pot_amount = arg2;
        emit_updated<T0>(arg0, b"pot_amount", 0x1::option::some<0x2::object::ID>(0x2::object::id<PotKeeperCap>(arg1)));
    }

    public fun max_difficulty() : u8 {
        6
    }

    public fun max_pot_bps<T0>(arg0: &PotConfig<T0>) : u64 {
        arg0.max_pot_bps
    }

    public fun max_ticket_units<T0>(arg0: &PotConfig<T0>) : u64 {
        arg0.max_tickets * 1000000
    }

    public fun max_tickets<T0>(arg0: &PotConfig<T0>) : u64 {
        arg0.max_tickets
    }

    public fun migrate<T0>(arg0: &mut PotConfig<T0>, arg1: &PotAdminCap) {
        assert!(arg0.version < 1, 13906836360484290600);
        arg0.version = 1;
        emit_updated<T0>(arg0, b"version", 0x1::option::none<0x2::object::ID>());
    }

    public fun pool_id<T0>(arg0: &PotConfig<T0>) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun pot_amount<T0>(arg0: &PotConfig<T0>) : u64 {
        arg0.pot_amount
    }

    public fun registry_id<T0>(arg0: &PotConfig<T0>) : 0x2::object::ID {
        arg0.registry_id
    }

    public fun retro_window_ms<T0>(arg0: &PotConfig<T0>) : u64 {
        arg0.retro_window_ms
    }

    public fun revoke_keeper_cap<T0>(arg0: &mut PotConfig<T0>, arg1: &PotAdminCap, arg2: 0x2::object::ID) {
        assert_version<T0>(arg0);
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.keepers, &arg2), 13906836321830633528);
        0x2::vec_set::remove<0x2::object::ID>(&mut arg0.keepers, &arg2);
        let v0 = PotKeeperRevoked{
            config_id : 0x2::object::id<PotConfig<T0>>(arg0),
            cap_id    : arg2,
        };
        0x2::event::emit<PotKeeperRevoked>(v0);
    }

    public fun revoke_verifier_cap<T0>(arg0: &mut PotConfig<T0>, arg1: &PotAdminCap, arg2: 0x2::object::ID) {
        assert_version<T0>(arg0);
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.verifiers, &arg2), 13906836201571287092);
        0x2::vec_set::remove<0x2::object::ID>(&mut arg0.verifiers, &arg2);
        let v0 = PotVerifierRevoked{
            config_id : 0x2::object::id<PotConfig<T0>>(arg0),
            cap_id    : arg2,
        };
        0x2::event::emit<PotVerifierRevoked>(v0);
    }

    public fun set_daily_games<T0>(arg0: &mut PotConfig<T0>, arg1: &PotAdminCap, arg2: u64) {
        assert_version<T0>(arg0);
        assert_in(arg2, 1, 50);
        assert!(arg2 != arg0.daily_games, 13906835608865669170);
        arg0.daily_games = arg2;
        emit_updated<T0>(arg0, b"daily_games", 0x1::option::none<0x2::object::ID>());
    }

    public fun set_daily_spend_bps<T0>(arg0: &mut PotConfig<T0>, arg1: &PotAdminCap, arg2: u64) {
        assert_version<T0>(arg0);
        assert_in(arg2, 100, 3000);
        assert!(arg2 != arg0.daily_spend_bps, 13906835351167631410);
        arg0.daily_spend_bps = arg2;
        emit_updated<T0>(arg0, b"daily_spend_bps", 0x1::option::none<0x2::object::ID>());
    }

    public fun set_daily_wins<T0>(arg0: &mut PotConfig<T0>, arg1: &PotAdminCap, arg2: u64) {
        assert_version<T0>(arg0);
        assert_in(arg2, 1, 20);
        assert!(arg2 != arg0.daily_wins, 13906835651815342130);
        arg0.daily_wins = arg2;
        emit_updated<T0>(arg0, b"daily_wins", 0x1::option::none<0x2::object::ID>());
    }

    public fun set_difficulty<T0>(arg0: &mut PotConfig<T0>, arg1: &PotAdminCap, arg2: u8) {
        assert_version<T0>(arg0);
        assert!(arg2 <= 6, 13906835973937496108);
        assert!(arg2 != arg0.difficulty, 13906835978232856626);
        arg0.difficulty = arg2;
        arg0.keeper_difficulty_day = 18446744073709551615;
        emit_updated<T0>(arg0, b"difficulty", 0x1::option::none<0x2::object::ID>());
    }

    public fun set_game_window_ms<T0>(arg0: &mut PotConfig<T0>, arg1: &PotAdminCap, arg2: u64) {
        assert_version<T0>(arg0);
        assert_in(arg2, 300000, 3600000);
        assert!(arg2 != arg0.game_window_ms, 13906835711944884274);
        arg0.game_window_ms = arg2;
        emit_updated<T0>(arg0, b"game_window_ms", 0x1::option::none<0x2::object::ID>());
    }

    public fun set_house<T0>(arg0: &mut PotConfig<T0>, arg1: &PotAdminCap, arg2: address) {
        assert_version<T0>(arg0);
        assert_house(arg2);
        assert!(arg2 != arg0.house, 13906836029772464178);
        arg0.house = arg2;
        emit_updated<T0>(arg0, b"house", 0x1::option::none<0x2::object::ID>());
    }

    public fun set_max_pot_bps<T0>(arg0: &mut PotConfig<T0>, arg1: &PotAdminCap, arg2: u64) {
        assert_version<T0>(arg0);
        assert_in(arg2, 50, 1000);
        assert!(arg2 != arg0.max_pot_bps, 13906835286743121970);
        arg0.max_pot_bps = arg2;
        emit_updated<T0>(arg0, b"max_pot_bps", 0x1::option::none<0x2::object::ID>());
    }

    public fun set_max_tickets<T0>(arg0: &mut PotConfig<T0>, arg1: &PotAdminCap, arg2: u64) {
        assert_version<T0>(arg0);
        assert_in(arg2, 1, 100);
        assert!(arg2 != arg0.max_tickets, 13906835565915996210);
        arg0.max_tickets = arg2;
        emit_updated<T0>(arg0, b"max_tickets", 0x1::option::none<0x2::object::ID>());
    }

    public fun set_paused<T0>(arg0: &mut PotConfig<T0>, arg1: &PotAdminCap, arg2: bool) {
        assert_version<T0>(arg0);
        assert!(arg2 != arg0.paused, 13906836072722137138);
        arg0.paused = arg2;
        emit_updated<T0>(arg0, b"paused", 0x1::option::none<0x2::object::ID>());
    }

    public fun set_pot_amount<T0>(arg0: &mut PotConfig<T0>, arg1: &PotAdminCap, arg2: u64) {
        assert_version<T0>(arg0);
        assert_pot_amount(arg2);
        assert!(arg2 != arg0.pot_amount, 13906835239498481714);
        arg0.pot_amount = arg2;
        arg0.keeper_pot_day = 18446744073709551615;
        emit_updated<T0>(arg0, b"pot_amount", 0x1::option::none<0x2::object::ID>());
    }

    public fun set_retro_window_ms<T0>(arg0: &mut PotConfig<T0>, arg1: &PotAdminCap, arg2: u64) {
        assert_version<T0>(arg0);
        assert_in(arg2, 0, 7776000000);
        assert!(arg2 != arg0.retro_window_ms, 13906835518671355954);
        arg0.retro_window_ms = arg2;
        emit_updated<T0>(arg0, b"retro_window_ms", 0x1::option::none<0x2::object::ID>());
    }

    public fun set_settle_grace_ms<T0>(arg0: &mut PotConfig<T0>, arg1: &PotAdminCap, arg2: u64) {
        assert_version<T0>(arg0);
        assert_in(arg2, 60000, 3600000);
        assert!(arg2 != arg0.settle_grace_ms, 13906835772074426418);
        arg0.settle_grace_ms = arg2;
        emit_updated<T0>(arg0, b"settle_grace_ms", 0x1::option::none<0x2::object::ID>());
    }

    public fun set_ticket_coin_days<T0>(arg0: &mut PotConfig<T0>, arg1: &PotAdminCap, arg2: u64) {
        assert_version<T0>(arg0);
        assert_in(arg2, 1000, 1000000000000);
        assert!(arg2 != arg0.ticket_coin_days, 13906835458541813810);
        arg0.ticket_coin_days = arg2;
        emit_updated<T0>(arg0, b"ticket_coin_days", 0x1::option::none<0x2::object::ID>());
    }

    public fun set_ticket_price_bps<T0>(arg0: &mut PotConfig<T0>, arg1: &PotAdminCap, arg2: u64) {
        assert_version<T0>(arg0);
        assert_in(arg2, 5500, 20000);
        assert!(arg2 != arg0.ticket_price_bps, 13906835832203968562);
        arg0.ticket_price_bps = arg2;
        emit_updated<T0>(arg0, b"ticket_price_bps", 0x1::option::none<0x2::object::ID>());
    }

    public fun set_ticket_split<T0>(arg0: &mut PotConfig<T0>, arg1: &PotAdminCap, arg2: u64, arg3: u64, arg4: u64) {
        assert_version<T0>(arg0);
        assert_split(arg2, arg3, arg4);
        let v0 = if (arg2 != arg0.split_pool_bps) {
            true
        } else if (arg3 != arg0.split_burn_bps) {
            true
        } else {
            arg4 != arg0.split_studio_bps
        };
        assert!(v0, 13906835918103314482);
        arg0.split_pool_bps = arg2;
        arg0.split_burn_bps = arg3;
        arg0.split_studio_bps = arg4;
        emit_updated<T0>(arg0, b"ticket_split", 0x1::option::none<0x2::object::ID>());
    }

    public fun set_win_bps<T0>(arg0: &mut PotConfig<T0>, arg1: &PotAdminCap, arg2: u64) {
        assert_version<T0>(arg0);
        assert_in(arg2, 8000, 9800);
        assert!(arg2 != arg0.win_bps, 13906835398412271666);
        arg0.win_bps = arg2;
        emit_updated<T0>(arg0, b"win_bps", 0x1::option::none<0x2::object::ID>());
    }

    public fun settle_grace_ms<T0>(arg0: &PotConfig<T0>) : u64 {
        arg0.settle_grace_ms
    }

    public(friend) fun share<T0>(arg0: PotConfig<T0>) {
        0x2::transfer::share_object<PotConfig<T0>>(arg0);
    }

    public fun ticket_coin_days<T0>(arg0: &PotConfig<T0>) : u64 {
        arg0.ticket_coin_days
    }

    public fun ticket_price<T0>(arg0: &PotConfig<T0>) : u64 {
        0x1::u64::mul_div_ceil(arg0.pot_amount, arg0.ticket_price_bps, 10000)
    }

    public fun ticket_price_bps<T0>(arg0: &PotConfig<T0>) : u64 {
        arg0.ticket_price_bps
    }

    public fun ticket_split<T0>(arg0: &PotConfig<T0>) : (u64, u64, u64) {
        (arg0.split_pool_bps, arg0.split_burn_bps, arg0.split_studio_bps)
    }

    public fun ticket_units() : u64 {
        1000000
    }

    public fun verifier_count<T0>(arg0: &PotConfig<T0>) : u64 {
        0x2::vec_set::length<0x2::object::ID>(&arg0.verifiers)
    }

    public fun version<T0>(arg0: &PotConfig<T0>) : u64 {
        arg0.version
    }

    public fun win_bps<T0>(arg0: &PotConfig<T0>) : u64 {
        arg0.win_bps
    }

    // decompiled from Move bytecode v7
}

