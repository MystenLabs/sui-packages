module 0xf0c58ac1c55af43b5064327f690ea37e6d14a3af23a086993caba2f328d16ecb::panthers_wheel {
    struct Session<phantom T0> has store, key {
        id: 0x2::object::UID,
        owner: address,
        status: u8,
        min_players: u8,
        n_pots: u8,
        pots: vector<Pot>,
        players: 0x2::table_vec::TableVec<PlayerState>,
        ready_count: u16,
        entropy: vector<u8>,
        price_per_pot: u64,
        max_pots_per_player: u8,
        rake_bps: u16,
        alpha: u8,
        bank: 0x2::balance::Balance<T0>,
        resolved_pot: 0x1::option::Option<u8>,
        paid_out: bool,
    }

    struct Pot has store {
        index: u8,
        total_stake: u64,
    }

    struct PlayerState has store {
        player: address,
        joined: bool,
        ready: bool,
        selected_pots: vector<u8>,
        stakes: vector<Stake>,
        has_paid: bool,
        reveal: 0x1::option::Option<RevealPayload>,
        points_total: u16,
        tactic_desc: 0x1::string::String,
        status_tag: u8,
    }

    struct Stake has drop, store {
        pot_index: u8,
        amount: u64,
    }

    struct RevealPayload has store {
        bubble_ms: u16,
        gems_collected: u8,
        tactic: u8,
        tactic_target_pot: u8,
    }

    struct RoundSummaryEvent has copy, drop {
        session: 0x2::object::ID,
        pot: u8,
        winners: vector<address>,
        winners_points: vector<u16>,
        winners_amounts: vector<u64>,
        winners_tactic_desc: vector<0x1::string::String>,
        losers: vector<address>,
        losers_points: vector<u16>,
        losers_tactic_desc: vector<0x1::string::String>,
    }

    struct SessionCreatedEvent has copy, drop {
        session: 0x2::object::ID,
        creator: address,
        n_pots: u8,
    }

    struct PlayerJoinedEvent has copy, drop {
        session: 0x2::object::ID,
        player: address,
    }

    struct RevealedEvent has copy, drop {
        session: 0x2::object::ID,
        player: address,
        points: u16,
    }

    struct ResolvedEvent has copy, drop {
        session: 0x2::object::ID,
        pot: u8,
    }

    struct PhaseAdvancedEvent has copy, drop {
        session: 0x2::object::ID,
        phase: u8,
    }

    struct PayoutEvent has copy, drop {
        session: 0x2::object::ID,
        pot: u8,
        player: address,
        amount: u64,
    }

    struct StakePlacedEvent has copy, drop {
        session: 0x2::object::ID,
        player: address,
        pot: u8,
        amount: u64,
    }

    struct FHCap has drop {
        dummy_field: bool,
    }

    fun join<T0>(arg0: &mut Session<T0>, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        if (!contains_player<T0>(arg0, v0)) {
            let v1 = PlayerState{
                player        : v0,
                joined        : true,
                ready         : false,
                selected_pots : 0x1::vector::empty<u8>(),
                stakes        : 0x1::vector::empty<Stake>(),
                has_paid      : false,
                reveal        : 0x1::option::none<RevealPayload>(),
                points_total  : 0,
                tactic_desc   : 0x1::string::utf8(b""),
                status_tag    : 0,
            };
            0x2::table_vec::push_back<PlayerState>(&mut arg0.players, v1);
            let v2 = PlayerJoinedEvent{
                session : 0x2::object::id<Session<T0>>(arg0),
                player  : v0,
            };
            0x2::event::emit<PlayerJoinedEvent>(v2);
        };
    }

    public fun admin_destroy_session<T0>(arg0: &0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::Admins, arg1: Session<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::check_admin(arg0, arg2);
        let Session {
            id                  : v0,
            owner               : _,
            status              : _,
            min_players         : _,
            n_pots              : _,
            pots                : v5,
            players             : v6,
            ready_count         : _,
            entropy             : _,
            price_per_pot       : _,
            max_pots_per_player : _,
            rake_bps            : _,
            alpha               : _,
            bank                : v13,
            resolved_pot        : _,
            paid_out            : _,
        } = arg1;
        destroy_pots(v5);
        0x2::table_vec::destroy_empty<PlayerState>(v6);
        0x2::balance::destroy_zero<T0>(v13);
        0x2::object::delete(v0);
    }

    public fun admin_destroy_session_safe<T0>(arg0: &0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::Admins, arg1: Session<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::check_admin(arg0, arg2);
        let Session {
            id                  : v0,
            owner               : _,
            status              : _,
            min_players         : _,
            n_pots              : _,
            pots                : v5,
            players             : v6,
            ready_count         : _,
            entropy             : _,
            price_per_pot       : _,
            max_pots_per_player : _,
            rake_bps            : _,
            alpha               : _,
            bank                : v13,
            resolved_pot        : _,
            paid_out            : _,
        } = arg1;
        destroy_pots(v5);
        destroy_players_table_vec(v6);
        0x2::balance::destroy_zero<T0>(v13);
        0x2::object::delete(v0);
    }

    public fun admin_return_stakes<T0>(arg0: &0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::Admins, arg1: &mut Session<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::check_admin(arg0, arg2);
        assert_phase<T0>(arg1, 0);
        let v0 = 0;
        while (v0 < 0x2::table_vec::length<PlayerState>(&arg1.players)) {
            let v1 = 0x2::table_vec::borrow_mut<PlayerState>(&mut arg1.players, v0);
            let v2 = 0;
            while (v2 < 0x1::vector::length<Stake>(&v1.stakes)) {
                let v3 = 0x1::vector::borrow<Stake>(&v1.stakes, v2);
                if (v3.amount > 0) {
                    0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.bank, v3.amount), arg2), v1.player);
                };
                0x1::vector::remove<Stake>(&mut v1.stakes, v2);
                v2 = v2 + 1;
            };
            v0 = v0 + 1;
        };
        arg1.status = 6;
        let v4 = PhaseAdvancedEvent{
            session : 0x2::object::id<Session<T0>>(arg1),
            phase   : 5,
        };
        0x2::event::emit<PhaseAdvancedEvent>(v4);
    }

    fun assert_phase<T0>(arg0: &Session<T0>, arg1: u8) {
        assert!(arg0.status == arg1, 15);
    }

    fun contains_player<T0>(arg0: &Session<T0>, arg1: address) : bool {
        let v0 = 0;
        let v1 = false;
        while (v0 < 0x2::table_vec::length<PlayerState>(&arg0.players)) {
            if (0x2::table_vec::borrow<PlayerState>(&arg0.players, v0).player == arg1) {
                v1 = true;
                break
            };
            v0 = v0 + 1;
        };
        v1
    }

    public fun create_session<T0>(arg0: &0xf0c58ac1c55af43b5064327f690ea37e6d14a3af23a086993caba2f328d16ecb::pw_config::Config, arg1: &0x14df736178104ac1f04525d58192a82eb390bba2422a79a69ac47046619e9d1c::config::PlayerConfig, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<Pot>();
        let v1 = 0;
        while (v1 < 0xf0c58ac1c55af43b5064327f690ea37e6d14a3af23a086993caba2f328d16ecb::pw_config::get_num_pots(arg0)) {
            let v2 = Pot{
                index       : v1,
                total_stake : 0,
            };
            0x1::vector::push_back<Pot>(&mut v0, v2);
            v1 = v1 + 1;
        };
        let v3 = Session<T0>{
            id                  : 0x2::object::new(arg4),
            owner               : 0x2::tx_context::sender(arg4),
            status              : 0,
            min_players         : 0xf0c58ac1c55af43b5064327f690ea37e6d14a3af23a086993caba2f328d16ecb::pw_config::get_min_players(arg0),
            n_pots              : 0xf0c58ac1c55af43b5064327f690ea37e6d14a3af23a086993caba2f328d16ecb::pw_config::get_num_pots(arg0),
            pots                : v0,
            players             : 0x2::table_vec::empty<PlayerState>(arg4),
            ready_count         : 0,
            entropy             : b"panthers-wheel",
            price_per_pot       : arg2,
            max_pots_per_player : (get_param_or_default(arg1, 0x1::string::utf8(b"Panther Wheel::MaxPots"), 3) as u8),
            rake_bps            : (0x14df736178104ac1f04525d58192a82eb390bba2422a79a69ac47046619e9d1c::config::get_game_param(arg1, 0x1::string::utf8(b"Panther Wheel::Rake")) as u16),
            alpha               : (get_param_or_default(arg1, 0x1::string::utf8(b"Panther Wheel::Alpha"), 1) as u8),
            bank                : 0x2::balance::zero<T0>(),
            resolved_pot        : 0x1::option::none<u8>(),
            paid_out            : false,
        };
        let v4 = SessionCreatedEvent{
            session : 0x2::object::id<Session<T0>>(&v3),
            creator : 0x2::tx_context::sender(arg4),
            n_pots  : 0xf0c58ac1c55af43b5064327f690ea37e6d14a3af23a086993caba2f328d16ecb::pw_config::get_num_pots(arg0),
        };
        0x2::event::emit<SessionCreatedEvent>(v4);
        0x2::transfer::public_share_object<Session<T0>>(v3);
    }

    public fun create_session_new<T0>(arg0: &0xf0c58ac1c55af43b5064327f690ea37e6d14a3af23a086993caba2f328d16ecb::pw_config::Config, arg1: &0x14df736178104ac1f04525d58192a82eb390bba2422a79a69ac47046619e9d1c::config::PlayerConfig, arg2: &0x14df736178104ac1f04525d58192a82eb390bba2422a79a69ac47046619e9d1c::voultron_players::WhitelistedPlayerModules, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = FHCap{dummy_field: false};
        let v1 = 0x14df736178104ac1f04525d58192a82eb390bba2422a79a69ac47046619e9d1c::voultron_players::create_player<FHCap>(arg2, v0, arg4, arg5);
        create_session<T0>(arg0, arg1, arg3, arg4, arg5);
        0x2::transfer::public_transfer<0x14df736178104ac1f04525d58192a82eb390bba2422a79a69ac47046619e9d1c::voultron_players::VoultronPlayer>(v1, 0x2::tx_context::sender(arg5));
    }

    fun destroy_player_state(arg0: PlayerState) {
        let PlayerState {
            player        : _,
            joined        : _,
            ready         : _,
            selected_pots : _,
            stakes        : _,
            has_paid      : _,
            reveal        : v6,
            points_total  : _,
            tactic_desc   : _,
            status_tag    : _,
        } = arg0;
        let v10 = v6;
        if (0x1::option::is_some<RevealPayload>(&v10)) {
            destroy_reveal_payload(0x1::option::extract<RevealPayload>(&mut v10));
        };
        0x1::option::destroy_none<RevealPayload>(v10);
    }

    fun destroy_players_table_vec(arg0: 0x2::table_vec::TableVec<PlayerState>) {
        while (!0x2::table_vec::is_empty<PlayerState>(&arg0)) {
            destroy_player_state(0x2::table_vec::pop_back<PlayerState>(&mut arg0));
        };
        0x2::table_vec::destroy_empty<PlayerState>(arg0);
    }

    fun destroy_pots(arg0: vector<Pot>) {
        while (!0x1::vector::is_empty<Pot>(&arg0)) {
            let Pot {
                index       : _,
                total_stake : _,
            } = 0x1::vector::pop_back<Pot>(&mut arg0);
        };
        0x1::vector::destroy_empty<Pot>(arg0);
    }

    fun destroy_reveal_payload(arg0: RevealPayload) {
        let RevealPayload {
            bubble_ms         : _,
            gems_collected    : _,
            tactic            : _,
            tactic_target_pot : _,
        } = arg0;
    }

    fun get_param_or_default(arg0: &0x14df736178104ac1f04525d58192a82eb390bba2422a79a69ac47046619e9d1c::config::PlayerConfig, arg1: 0x1::string::String, arg2: u64) : u64 {
        let v0 = 0x14df736178104ac1f04525d58192a82eb390bba2422a79a69ac47046619e9d1c::config::get_game_param(arg0, arg1);
        if (v0 == 0) {
            arg2
        } else {
            v0
        }
    }

    fun get_player_state<T0>(arg0: &mut Session<T0>, arg1: address) : 0x1::option::Option<PlayerState> {
        let v0 = 0;
        let v1 = 0x1::option::none<PlayerState>();
        while (v0 < 0x2::table_vec::length<PlayerState>(&arg0.players)) {
            if (0x2::table_vec::borrow<PlayerState>(&arg0.players, v0).player == arg1) {
                0x1::option::fill<PlayerState>(&mut v1, 0x2::table_vec::swap_remove<PlayerState>(&mut arg0.players, v0));
                break
            };
            v0 = v0 + 1;
        };
        v1
    }

    public fun get_session_bank_value<T0>(arg0: &Session<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.bank)
    }

    public fun get_session_max_pots_per_player<T0>(arg0: &Session<T0>) : u8 {
        arg0.max_pots_per_player
    }

    public fun get_session_min_players<T0>(arg0: &Session<T0>) : u8 {
        arg0.min_players
    }

    public fun get_session_n_pots<T0>(arg0: &Session<T0>) : u8 {
        arg0.n_pots
    }

    public fun get_session_price_per_pot<T0>(arg0: &Session<T0>) : u64 {
        arg0.price_per_pot
    }

    public fun get_session_rake_bps<T0>(arg0: &Session<T0>) : u16 {
        arg0.rake_bps
    }

    public fun get_session_status<T0>(arg0: &Session<T0>) : u8 {
        arg0.status
    }

    fun payout_winner<T0>(arg0: &mut Session<T0>, arg1: address, arg2: &0x930c7f9155da8239d928358abb8b40627f44bdc0be7b3a5a34b3b5e428fe3086::voultron_treasury::TreasuryWhitelistedModules, arg3: &mut 0x930c7f9155da8239d928358abb8b40627f44bdc0be7b3a5a34b3b5e428fe3086::voultron_treasury::Treasury<T0>, arg4: &mut 0x2::tx_context::TxContext) : (vector<address>, vector<u16>, vector<u64>, vector<0x1::string::String>, vector<address>, vector<u16>, vector<0x1::string::String>) {
        let v0 = 0x1::vector::empty<address>();
        let v1 = 0x1::vector::empty<u16>();
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = 0x1::vector::empty<address>();
        let v5 = 0x1::vector::empty<u16>();
        let v6 = 0x1::vector::empty<0x1::string::String>();
        let v7 = 0x2::balance::value<T0>(&arg0.bank);
        if (v7 == 0) {
            arg0.paid_out = true;
            return (v0, v1, v2, v3, v4, v5, v6)
        };
        let v8 = (v7 as u128) * (arg0.rake_bps as u128) / 10000;
        if (v8 > 0) {
            let v9 = FHCap{dummy_field: false};
            0x930c7f9155da8239d928358abb8b40627f44bdc0be7b3a5a34b3b5e428fe3086::voultron_treasury::add_to_treasury<FHCap, T0>(arg3, arg2, v9, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.bank, (v8 as u64)), arg4));
        };
        let v10 = 0x2::balance::value<T0>(&arg0.bank);
        let v11 = 0;
        while (v11 < 0x2::table_vec::length<PlayerState>(&arg0.players)) {
            let v12 = 0x2::table_vec::borrow<PlayerState>(&arg0.players, v11);
            if (0x1::vector::length<Stake>(&v12.stakes) > 0) {
                if (v12.player == arg1) {
                    if (v10 > 0) {
                        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.bank, v10), arg4), v12.player);
                        let v13 = PayoutEvent{
                            session : 0x2::object::id<Session<T0>>(arg0),
                            pot     : 0x1::vector::borrow<Stake>(&v12.stakes, 0).pot_index,
                            player  : v12.player,
                            amount  : v10,
                        };
                        0x2::event::emit<PayoutEvent>(v13);
                    };
                    0x1::vector::push_back<address>(&mut v0, v12.player);
                    0x1::vector::push_back<u16>(&mut v1, v12.points_total);
                    0x1::vector::push_back<u64>(&mut v2, v10);
                    0x1::vector::push_back<0x1::string::String>(&mut v3, v12.tactic_desc);
                } else {
                    0x1::vector::push_back<address>(&mut v4, v12.player);
                    0x1::vector::push_back<u16>(&mut v5, v12.points_total);
                    0x1::vector::push_back<0x1::string::String>(&mut v6, v12.tactic_desc);
                };
            };
            v11 = v11 + 1;
        };
        if (0x2::balance::value<T0>(&arg0.bank) > 0) {
            let v14 = FHCap{dummy_field: false};
            0x930c7f9155da8239d928358abb8b40627f44bdc0be7b3a5a34b3b5e428fe3086::voultron_treasury::add_to_treasury<FHCap, T0>(arg3, arg2, v14, 0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.bank), arg4));
        };
        arg0.paid_out = true;
        (v0, v1, v2, v3, v4, v5, v6)
    }

    fun pick_winner_by_points<T0>(arg0: &Session<T0>) : (address, u8) {
        let v0 = 0;
        let v1 = @0x0;
        let v2 = 0;
        let v3 = 0;
        while (v3 < 0x2::table_vec::length<PlayerState>(&arg0.players)) {
            let v4 = 0x2::table_vec::borrow<PlayerState>(&arg0.players, v3);
            if (0x1::vector::length<Stake>(&v4.stakes) > 0 && v4.points_total > v0) {
                v0 = v4.points_total;
                v1 = v4.player;
                if (0x1::vector::length<Stake>(&v4.stakes) > 0) {
                    v2 = 0x1::vector::borrow<Stake>(&v4.stakes, 0).pot_index;
                };
            };
            v3 = v3 + 1;
        };
        (v1, v2)
    }

    fun points_for_bubble_ms(arg0: u16) : u16 {
        if (arg0 <= 2000) {
            return 5
        };
        if (arg0 <= 4000) {
            return 4
        };
        if (arg0 <= 5000) {
            return 2
        };
        0
    }

    public fun refund_players_without_reveal<T0>(arg0: &0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::Admins, arg1: &mut Session<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::check_admin(arg0, arg2);
        assert_phase<T0>(arg1, 0);
        let v0 = 0;
        while (v0 < 0x2::table_vec::length<PlayerState>(&arg1.players)) {
            let v1 = 0x2::table_vec::borrow_mut<PlayerState>(&mut arg1.players, v0);
            if (0x1::vector::length<Stake>(&v1.stakes) > 0 && !0x1::option::is_some<RevealPayload>(&v1.reveal)) {
                let v2 = 0;
                while (v2 < 0x1::vector::length<Stake>(&v1.stakes)) {
                    let v3 = 0x1::vector::borrow<Stake>(&v1.stakes, v2);
                    let v4 = v3.amount;
                    let v5 = (v3.pot_index as u64);
                    if (v4 > 0) {
                        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.bank, v4), arg2), v1.player);
                        let v6 = PayoutEvent{
                            session : 0x2::object::id<Session<T0>>(arg1),
                            pot     : v3.pot_index,
                            player  : v1.player,
                            amount  : v4,
                        };
                        0x2::event::emit<PayoutEvent>(v6);
                    };
                    if (v5 < 0x1::vector::length<Pot>(&arg1.pots)) {
                        let v7 = 0x1::vector::borrow_mut<Pot>(&mut arg1.pots, v5);
                        v7.total_stake = v7.total_stake - v4;
                    };
                    v2 = v2 + 1;
                };
                while (0x1::vector::length<Stake>(&v1.stakes) > 0) {
                    0x1::vector::pop_back<Stake>(&mut v1.stakes);
                };
            };
            v0 = v0 + 1;
        };
    }

    fun refund_players_without_reveal_internal<T0>(arg0: &mut Session<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x2::table_vec::length<PlayerState>(&arg0.players)) {
            let v1 = 0x2::table_vec::borrow_mut<PlayerState>(&mut arg0.players, v0);
            if (0x1::vector::length<Stake>(&v1.stakes) > 0 && !0x1::option::is_some<RevealPayload>(&v1.reveal)) {
                let v2 = 0;
                while (v2 < 0x1::vector::length<Stake>(&v1.stakes)) {
                    let v3 = 0x1::vector::borrow<Stake>(&v1.stakes, v2);
                    let v4 = v3.amount;
                    let v5 = (v3.pot_index as u64);
                    if (v4 > 0) {
                        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.bank, v4), arg1), v1.player);
                        let v6 = PayoutEvent{
                            session : 0x2::object::id<Session<T0>>(arg0),
                            pot     : v3.pot_index,
                            player  : v1.player,
                            amount  : v4,
                        };
                        0x2::event::emit<PayoutEvent>(v6);
                    };
                    if (v5 < 0x1::vector::length<Pot>(&arg0.pots)) {
                        let v7 = 0x1::vector::borrow_mut<Pot>(&mut arg0.pots, v5);
                        v7.total_stake = v7.total_stake - v4;
                    };
                    v2 = v2 + 1;
                };
                while (0x1::vector::length<Stake>(&v1.stakes) > 0) {
                    0x1::vector::pop_back<Stake>(&mut v1.stakes);
                };
            };
            v0 = v0 + 1;
        };
    }

    public fun refund_specific_player_without_reveal<T0>(arg0: &0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::Admins, arg1: &mut Session<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::check_admin(arg0, arg3);
        assert_phase<T0>(arg1, 0);
        let v0 = get_player_state<T0>(arg1, arg2);
        assert!(0x1::option::is_some<PlayerState>(&v0), 12);
        let v1 = 0x1::option::extract<PlayerState>(&mut v0);
        assert!(0x1::vector::length<Stake>(&v1.stakes) > 0 && !0x1::option::is_some<RevealPayload>(&v1.reveal), 15);
        let v2 = 0;
        while (v2 < 0x1::vector::length<Stake>(&v1.stakes)) {
            let v3 = 0x1::vector::borrow<Stake>(&v1.stakes, v2);
            let v4 = v3.amount;
            let v5 = (v3.pot_index as u64);
            if (v4 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.bank, v4), arg3), v1.player);
                let v6 = PayoutEvent{
                    session : 0x2::object::id<Session<T0>>(arg1),
                    pot     : v3.pot_index,
                    player  : v1.player,
                    amount  : v4,
                };
                0x2::event::emit<PayoutEvent>(v6);
            };
            if (v5 < 0x1::vector::length<Pot>(&arg1.pots)) {
                let v7 = 0x1::vector::borrow_mut<Pot>(&mut arg1.pots, v5);
                v7.total_stake = v7.total_stake - v4;
            };
            v2 = v2 + 1;
        };
        while (0x1::vector::length<Stake>(&v1.stakes) > 0) {
            0x1::vector::pop_back<Stake>(&mut v1.stakes);
        };
        return_player_state<T0>(arg1, v1);
        0x1::option::destroy_none<PlayerState>(v0);
    }

    public fun remove_player_and_refund<T0>(arg0: &0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::Admins, arg1: &mut Session<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::check_admin(arg0, arg3);
        assert_phase<T0>(arg1, 0);
        let v0 = get_player_state<T0>(arg1, arg2);
        assert!(0x1::option::is_some<PlayerState>(&v0), 12);
        let v1 = 0x1::option::extract<PlayerState>(&mut v0);
        let v2 = 0;
        while (v2 < 0x1::vector::length<Stake>(&v1.stakes)) {
            let v3 = 0x1::vector::borrow<Stake>(&v1.stakes, v2);
            let v4 = v3.amount;
            let v5 = (v3.pot_index as u64);
            if (v5 < 0x1::vector::length<Pot>(&arg1.pots)) {
                let v6 = 0x1::vector::borrow_mut<Pot>(&mut arg1.pots, v5);
                v6.total_stake = v6.total_stake - v4;
            };
            if (v4 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.bank, v4), arg3), v1.player);
            };
            v2 = v2 + 1;
        };
        destroy_player_state(v1);
        0x1::option::destroy_none<PlayerState>(v0);
    }

    public fun resolve_and_payout<T0>(arg0: &0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::Admins, arg1: &mut Session<T0>, arg2: &0x930c7f9155da8239d928358abb8b40627f44bdc0be7b3a5a34b3b5e428fe3086::voultron_treasury::TreasuryWhitelistedModules, arg3: &mut 0x930c7f9155da8239d928358abb8b40627f44bdc0be7b3a5a34b3b5e428fe3086::voultron_treasury::Treasury<T0>, arg4: &0x14df736178104ac1f04525d58192a82eb390bba2422a79a69ac47046619e9d1c::voultron_players::WhitelistedPlayerModules, arg5: &mut 0x14df736178104ac1f04525d58192a82eb390bba2422a79a69ac47046619e9d1c::referrals::Referrals, arg6: &0xe59e5e4471b3878b360f9ed7b5551aa67a03a4a6096732f3238aba19ed27725::creators::Creators, arg7: &0x14df736178104ac1f04525d58192a82eb390bba2422a79a69ac47046619e9d1c::config::PlayerConfig, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::check_admin(arg0, arg9);
        assert_phase<T0>(arg1, 0);
        refund_players_without_reveal_internal<T0>(arg1, arg9);
        let v0 = 0;
        while (v0 < 0x2::table_vec::length<PlayerState>(&arg1.players)) {
            let v1 = 0x2::table_vec::borrow<PlayerState>(&arg1.players, v0);
            let v2 = 0;
            let v3 = 0;
            while (v3 < 0x1::vector::length<Stake>(&v1.stakes)) {
                v2 = v2 + 0x1::vector::borrow<Stake>(&v1.stakes, v3).amount;
                v3 = v3 + 1;
            };
            if (v2 > 0) {
                let v4 = (v2 as u128) * (arg1.rake_bps as u128) / 10000;
                if (v4 > 0) {
                    let v5 = FHCap{dummy_field: false};
                    0x14df736178104ac1f04525d58192a82eb390bba2422a79a69ac47046619e9d1c::referrals::accrue_referral_revenue<T0, FHCap>(arg5, arg6, arg7, arg4, arg3, arg2, v5, (v4 as u64), v1.player, arg1.owner, 0x1::string::utf8(b"Panther Wheel"), arg8, arg9);
                };
            };
            v0 = v0 + 1;
        };
        let v6 = 0x1::vector::length<Pot>(&arg1.pots);
        let v7 = 0x1::vector::empty<u64>();
        let v8 = 0x1::vector::empty<u64>();
        let v9 = 0;
        while (v9 < v6) {
            0x1::vector::push_back<u64>(&mut v7, 0);
            0x1::vector::push_back<u64>(&mut v8, 0);
            v9 = v9 + 1;
        };
        let v10 = 0;
        while (v10 < 0x2::table_vec::length<PlayerState>(&arg1.players)) {
            let v11 = 0x2::table_vec::borrow_mut<PlayerState>(&mut arg1.players, v10);
            if (0x1::option::is_some<RevealPayload>(&v11.reveal)) {
                let v12 = 0x1::option::borrow<RevealPayload>(&v11.reveal);
                let v13 = v12.tactic;
                let v14 = (v12.tactic_target_pot as u64);
                if ((v13 == 1 || v13 == 2) && v14 < v6) {
                    if (v13 == 1) {
                        let v15 = 0x1::vector::borrow_mut<u64>(&mut v8, v14);
                        *v15 = *v15 + 1;
                    } else {
                        let v16 = 0x1::vector::borrow_mut<u64>(&mut v7, v14);
                        *v16 = *v16 + 1;
                    };
                };
            };
            v10 = v10 + 1;
        };
        let v17 = 0;
        while (v17 < 0x2::table_vec::length<PlayerState>(&arg1.players)) {
            let v18 = 0x2::table_vec::borrow_mut<PlayerState>(&mut arg1.players, v17);
            let v19 = 0;
            let v20 = v19;
            let v21 = 0x1::string::utf8(b"");
            if (0x1::option::is_some<RevealPayload>(&v18.reveal)) {
                let v22 = 0x1::option::borrow<RevealPayload>(&v18.reveal);
                let v23 = (v22.tactic_target_pot as u64);
                let v24 = v22.tactic;
                if (v23 < v6) {
                    if (v24 == 2) {
                        if (*0x1::vector::borrow<u64>(&v8, v23) > 0) {
                            v20 = v19 + 5;
                            v21 = 0x1::string::utf8(b"Your pot was attacked, Shield Triggered (+5)");
                        } else {
                            v21 = 0x1::string::utf8(b"Your pot wasn't attacked, Shield Wasted");
                        };
                    } else if (v24 == 1) {
                        if (!(*0x1::vector::borrow<u64>(&v7, v23) > 0)) {
                            v20 = v19 + 5;
                            v21 = 0x1::string::utf8(b"Your attack on another pot without Shield was successful (+5)");
                        } else {
                            v21 = 0x1::string::utf8(b"Your attack to another pot was Blocked");
                        };
                    };
                };
            };
            v18.points_total = v18.points_total + v20;
            v18.tactic_desc = v21;
            v17 = v17 + 1;
        };
        let (v25, v26) = pick_winner_by_points<T0>(arg1);
        let v27 = 0x2::object::id<Session<T0>>(arg1);
        let v28 = ResolvedEvent{
            session : v27,
            pot     : v26,
        };
        0x2::event::emit<ResolvedEvent>(v28);
        let (v29, v30, v31, v32, v33, v34, v35) = payout_winner<T0>(arg1, v25, arg2, arg3, arg9);
        let v36 = RoundSummaryEvent{
            session             : v27,
            pot                 : v26,
            winners             : v29,
            winners_points      : v30,
            winners_amounts     : v31,
            winners_tactic_desc : v32,
            losers              : v33,
            losers_points       : v34,
            losers_tactic_desc  : v35,
        };
        0x2::event::emit<RoundSummaryEvent>(v36);
        arg1.status = 5;
        let v37 = PhaseAdvancedEvent{
            session : v27,
            phase   : 5,
        };
        0x2::event::emit<PhaseAdvancedEvent>(v37);
    }

    fun return_player_state<T0>(arg0: &mut Session<T0>, arg1: PlayerState) {
        0x2::table_vec::push_back<PlayerState>(&mut arg0.players, arg1);
    }

    public fun reveal<T0>(arg0: &mut Session<T0>, arg1: &0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::Admins, arg2: u16, arg3: u8, arg4: u8, arg5: u8, arg6: &0x2::clock::Clock, arg7: address, arg8: &mut 0x2::tx_context::TxContext) {
        0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::check_admin(arg1, arg8);
        let v0 = get_player_state<T0>(arg0, arg7);
        let v1 = 0x1::option::extract<PlayerState>(&mut v0);
        let v2 = RevealPayload{
            bubble_ms         : arg2,
            gems_collected    : arg3,
            tactic            : arg4,
            tactic_target_pot : arg5,
        };
        0x1::option::fill<RevealPayload>(&mut v1.reveal, v2);
        let v3 = points_for_bubble_ms(arg2) + (arg3 as u16);
        v1.points_total = v3;
        return_player_state<T0>(arg0, v1);
        0x1::option::destroy_none<PlayerState>(v0);
        let v4 = RevealedEvent{
            session : 0x2::object::id<Session<T0>>(arg0),
            player  : arg7,
            points  : v3,
        };
        0x2::event::emit<RevealedEvent>(v4);
    }

    public fun stake<T0>(arg0: &0x14df736178104ac1f04525d58192a82eb390bba2422a79a69ac47046619e9d1c::config::PlayerConfig, arg1: &mut 0x14df736178104ac1f04525d58192a82eb390bba2422a79a69ac47046619e9d1c::voultron_players::VoultronPlayer, arg2: &0x14df736178104ac1f04525d58192a82eb390bba2422a79a69ac47046619e9d1c::voultron_players::WhitelistedPlayerModules, arg3: &0xdec974fe362e058b64b8215886ec45c17560e4d67da7133e75bb49f094b055ac::award_points::AwardPointsWhitelistedModule, arg4: &mut 0x2::token::TokenPolicy<0xdec974fe362e058b64b8215886ec45c17560e4d67da7133e75bb49f094b055ac::voultron_points::VOULTRON_POINTS>, arg5: &mut 0xdec974fe362e058b64b8215886ec45c17560e4d67da7133e75bb49f094b055ac::voultron_points::PointsTreasuryCapOwner, arg6: &mut Session<T0>, arg7: 0x2::coin::Coin<T0>, arg8: u8, arg9: &mut 0x14df736178104ac1f04525d58192a82eb390bba2422a79a69ac47046619e9d1c::referrals::Referrals, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg11);
        assert!(0x2::coin::value<T0>(&arg7) >= arg6.price_per_pot, 11);
        join<T0>(arg6, arg11);
        let v1 = false;
        let v2 = 0;
        while (v2 < 0x2::table_vec::length<PlayerState>(&arg6.players)) {
            let v3 = 0x2::table_vec::borrow<PlayerState>(&arg6.players, v2);
            if (v3.player != v0) {
                let v4 = 0;
                while (v4 < 0x1::vector::length<Stake>(&v3.stakes)) {
                    if (0x1::vector::borrow<Stake>(&v3.stakes, v4).pot_index == arg8) {
                        v1 = true;
                        break
                    };
                    v4 = v4 + 1;
                };
            };
            if (v1) {
                break
            };
            v2 = v2 + 1;
        };
        assert!(!v1, 19);
        let v5 = get_player_state<T0>(arg6, v0);
        let v6 = 0x1::option::extract<PlayerState>(&mut v5);
        let v7 = true;
        let v8 = 0;
        while (v8 < 0x1::vector::length<u8>(&v6.selected_pots)) {
            if (0x1::vector::borrow<u8>(&v6.selected_pots, v8) == &arg8) {
                v7 = false;
                break
            };
            v8 = v8 + 1;
        };
        if (v7) {
            0x1::vector::push_back<u8>(&mut v6.selected_pots, arg8);
        };
        assert!((0x1::vector::length<u8>(&v6.selected_pots) as u8) <= arg6.max_pots_per_player, 9);
        let v9 = 0x2::coin::value<T0>(&arg7);
        0x2::balance::join<T0>(&mut arg6.bank, 0x2::coin::into_balance<T0>(arg7));
        let v10 = FHCap{dummy_field: false};
        0x14df736178104ac1f04525d58192a82eb390bba2422a79a69ac47046619e9d1c::voultron_players::award_points<FHCap, T0>(arg1, arg2, arg3, arg4, arg5, v10, v9, arg0, arg10, arg11);
        let v11 = FHCap{dummy_field: false};
        0x14df736178104ac1f04525d58192a82eb390bba2422a79a69ac47046619e9d1c::voultron_players::update_streak<FHCap>(arg1, arg2, arg3, arg4, arg5, v11, arg0, arg10, arg11);
        v6.has_paid = true;
        v6.status_tag = 1;
        let v12 = 0x1::vector::borrow_mut<Pot>(&mut arg6.pots, (arg8 as u64));
        v12.total_stake = v12.total_stake + v9;
        let v13 = Stake{
            pot_index : arg8,
            amount    : v9,
        };
        0x1::vector::push_back<Stake>(&mut v6.stakes, v13);
        return_player_state<T0>(arg6, v6);
        0x1::option::destroy_none<PlayerState>(v5);
        let v14 = StakePlacedEvent{
            session : 0x2::object::id<Session<T0>>(arg6),
            player  : v0,
            pot     : arg8,
            amount  : v9,
        };
        0x2::event::emit<StakePlacedEvent>(v14);
    }

    public fun stake_new<T0>(arg0: &0x14df736178104ac1f04525d58192a82eb390bba2422a79a69ac47046619e9d1c::config::PlayerConfig, arg1: &0x14df736178104ac1f04525d58192a82eb390bba2422a79a69ac47046619e9d1c::voultron_players::WhitelistedPlayerModules, arg2: &0xdec974fe362e058b64b8215886ec45c17560e4d67da7133e75bb49f094b055ac::award_points::AwardPointsWhitelistedModule, arg3: &mut 0x2::token::TokenPolicy<0xdec974fe362e058b64b8215886ec45c17560e4d67da7133e75bb49f094b055ac::voultron_points::VOULTRON_POINTS>, arg4: &mut 0xdec974fe362e058b64b8215886ec45c17560e4d67da7133e75bb49f094b055ac::voultron_points::PointsTreasuryCapOwner, arg5: &mut Session<T0>, arg6: 0x2::coin::Coin<T0>, arg7: u8, arg8: &mut 0x14df736178104ac1f04525d58192a82eb390bba2422a79a69ac47046619e9d1c::referrals::Referrals, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = FHCap{dummy_field: false};
        let v1 = 0x14df736178104ac1f04525d58192a82eb390bba2422a79a69ac47046619e9d1c::voultron_players::create_player<FHCap>(arg1, v0, arg9, arg10);
        let v2 = &mut v1;
        stake<T0>(arg0, v2, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        0x2::transfer::public_transfer<0x14df736178104ac1f04525d58192a82eb390bba2422a79a69ac47046619e9d1c::voultron_players::VoultronPlayer>(v1, 0x2::tx_context::sender(arg10));
    }

    // decompiled from Move bytecode v6
}

