module 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::blackjack {
    struct ConfigKey has copy, drop, store {
        dummy_field: bool,
    }

    struct BlackjackConfig has copy, drop, store {
        edge_bps: u64,
        dealer_stands_soft_17: bool,
        action_timeout_ms: u64,
        max_hand_exposure_bps: u64,
        paused: bool,
    }

    struct Hand has key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        player: address,
        stake: u64,
        escrowed: u64,
        max_win_net: u64,
        edge_bps: u64,
        dealer_stands_soft_17: bool,
        action_timeout_ms: u64,
        doubled: bool,
        status: u8,
        result: u8,
        player_cards: vector<u8>,
        player_len: u64,
        dealer_cards: vector<u8>,
        dealer_len: u64,
        pending: vector<u8>,
        pending_action: u8,
        started_at_ms: u64,
        action_deadline_ms: u64,
        hand_deadline_ms: u64,
        payout: u64,
        bet: 0x1::option::Option<0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::Bet>,
    }

    struct CardsDrawn has copy, drop {
        hand_id: 0x2::object::ID,
        player: address,
        action: u8,
        cards: vector<u8>,
        action_deadline_ms: u64,
    }

    struct HandStarted has copy, drop {
        pool_id: 0x2::object::ID,
        hand_id: 0x2::object::ID,
        player: address,
        stake: u64,
        max_win_net: u64,
        player_cards: vector<u8>,
        dealer_cards: vector<u8>,
        player_total: u64,
        natural: bool,
        status: u8,
        result: u8,
        action_deadline_ms: u64,
    }

    struct HandHit has copy, drop {
        hand_id: 0x2::object::ID,
        player: address,
        card: u8,
        player_cards: vector<u8>,
        player_total: u64,
        busted: bool,
        status: u8,
        result: u8,
        action_deadline_ms: u64,
    }

    struct HandStood has copy, drop {
        hand_id: 0x2::object::ID,
        player: address,
        player_cards: vector<u8>,
        dealer_cards: vector<u8>,
        player_total: u64,
        dealer_total: u64,
        result: u8,
    }

    struct HandDoubled has copy, drop {
        hand_id: 0x2::object::ID,
        player: address,
        extra_stake: u64,
        card: u8,
        player_cards: vector<u8>,
        dealer_cards: vector<u8>,
        player_total: u64,
        dealer_total: u64,
        result: u8,
    }

    struct HandSettled has copy, drop {
        pool_id: 0x2::object::ID,
        hand_id: 0x2::object::ID,
        player: address,
        result: u8,
        escrowed: u64,
        max_win_net: u64,
        payout: u64,
    }

    struct HandTimedOut has copy, drop {
        pool_id: 0x2::object::ID,
        hand_id: 0x2::object::ID,
        player: address,
        caller: address,
        action_deadline_ms: u64,
        now_ms: u64,
    }

    struct BlackjackConfigUpdated has copy, drop {
        pool_id: 0x2::object::ID,
        edge_bps: u64,
        dealer_stands_soft_17: bool,
        action_timeout_ms: u64,
        max_hand_exposure_bps: u64,
        paused: bool,
    }

    fun ace_u64(arg0: u8) : u64 {
        if (arg0 % 13 == 0) {
            1
        } else {
            0
        }
    }

    public fun action_deal() : u8 {
        1
    }

    public fun action_double() : u8 {
        4
    }

    public fun action_hit() : u8 {
        2
    }

    public fun action_none() : u8 {
        0
    }

    public fun action_stand() : u8 {
        3
    }

    fun add_checked(arg0: u64, arg1: u64) : u64 {
        assert!((arg0 as u128) + (arg1 as u128) <= 18446744073709551615, 13);
        arg0 + arg1
    }

    fun apply_double(arg0: &mut Hand, arg1: &vector<u8>) {
        let v0 = *0x1::vector::borrow<u8>(arg1, 0);
        *0x1::vector::borrow_mut<u8>(&mut arg0.player_cards, 2) = v0;
        arg0.player_len = 3;
        dealer_play(arg0, arg1, 1);
        let (v1, v2, v3) = compare(arg0);
        arg0.result = v1;
        arg0.status = 1;
        let v4 = HandDoubled{
            hand_id      : 0x2::object::id<Hand>(arg0),
            player       : arg0.player,
            extra_stake  : arg0.stake,
            card         : v0,
            player_cards : arg0.player_cards,
            dealer_cards : arg0.dealer_cards,
            player_total : v2,
            dealer_total : v3,
            result       : v1,
        };
        0x2::event::emit<HandDoubled>(v4);
    }

    fun apply_hit(arg0: &mut Hand, arg1: u8) {
        let v0 = arg0.player_len;
        *0x1::vector::borrow_mut<u8>(&mut arg0.player_cards, v0) = arg1;
        arg0.player_len = v0 + 1;
        let (v1, _) = total(&arg0.player_cards);
        let v3 = v1 > 21;
        let v4 = if (v3) {
            1
        } else {
            0
        };
        arg0.status = v4;
        let v5 = if (v3) {
            2
        } else {
            0
        };
        arg0.result = v5;
        let v6 = HandHit{
            hand_id            : 0x2::object::id<Hand>(arg0),
            player             : arg0.player,
            card               : arg1,
            player_cards       : arg0.player_cards,
            player_total       : v1,
            busted             : v3,
            status             : arg0.status,
            result             : arg0.result,
            action_deadline_ms : arg0.action_deadline_ms,
        };
        0x2::event::emit<HandHit>(v6);
    }

    fun apply_stand(arg0: &mut Hand, arg1: &vector<u8>) {
        dealer_play(arg0, arg1, 0);
        let (v0, v1, v2) = compare(arg0);
        arg0.result = v0;
        arg0.status = 1;
        let v3 = HandStood{
            hand_id      : 0x2::object::id<Hand>(arg0),
            player       : arg0.player,
            player_cards : arg0.player_cards,
            dealer_cards : arg0.dealer_cards,
            player_total : v1,
            dealer_total : v2,
            result       : v0,
        };
        0x2::event::emit<HandStood>(v3);
    }

    fun assert_can_act(arg0: &Hand, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) : u64 {
        assert!(arg0.player == 0x2::tx_context::sender(arg2), 4);
        assert!(arg0.status == 0, 5);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 <= arg0.action_deadline_ms, 6);
        v0
    }

    fun begin_action(arg0: &mut Hand, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) : u64 {
        assert!(arg0.player == 0x2::tx_context::sender(arg2), 4);
        if (arg0.status == 3) {
            resolve_pending(arg0);
        };
        assert_can_act(arg0, arg1, arg2)
    }

    fun begin_double(arg0: &mut 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::Pool, arg1: &mut Hand, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::tx_context::TxContext) {
        begin_action(arg1, arg2, arg4);
        assert!(arg1.player_len == 2 && !arg1.doubled, 8);
        assert!(arg1.pool_id == 0x2::object::id<0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::Pool>(arg0), 11);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) == arg1.stake, 12);
        0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::add_to_position(arg0, 0x1::option::borrow_mut<0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::Bet>(&mut arg1.bet), 0x2::coin::into_balance<0x2::sui::SUI>(arg3), arg1.player, arg1.edge_bps);
        arg1.escrowed = arg1.escrowed + arg1.stake;
        arg1.doubled = true;
        mark_drawn(arg1, 4);
    }

    fun begin_hit(arg0: &mut Hand, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        let v0 = begin_action(arg0, arg1, arg2);
        assert!(arg0.player_len < 12, 9);
        let v1 = add_checked(v0, arg0.action_timeout_ms);
        let v2 = if (v1 < arg0.hand_deadline_ms) {
            v1
        } else {
            arg0.hand_deadline_ms
        };
        arg0.action_deadline_ms = v2;
        mark_drawn(arg0, 2);
    }

    fun begin_stand(arg0: &mut Hand, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        begin_action(arg0, arg1, arg2);
        mark_drawn(arg0, 3);
    }

    public fun close_hand(arg0: Hand, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.player == 0x2::tx_context::sender(arg1), 4);
        assert!(arg0.status == 2, 5);
        let Hand {
            id                    : v0,
            pool_id               : _,
            player                : _,
            stake                 : _,
            escrowed              : _,
            max_win_net           : _,
            edge_bps              : _,
            dealer_stands_soft_17 : _,
            action_timeout_ms     : _,
            doubled               : _,
            status                : _,
            result                : _,
            player_cards          : _,
            player_len            : _,
            dealer_cards          : _,
            dealer_len            : _,
            pending               : _,
            pending_action        : _,
            started_at_ms         : _,
            action_deadline_ms    : _,
            hand_deadline_ms      : _,
            payout                : _,
            bet                   : v22,
        } = arg0;
        0x1::option::destroy_none<0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::Bet>(v22);
        0x2::object::delete(v0);
    }

    fun compare(arg0: &Hand) : (u8, u64, u64) {
        let (v0, _) = total(&arg0.player_cards);
        let (v2, _) = total(&arg0.dealer_cards);
        let v4 = if (arg0.dealer_len == 2 && v2 == 21 || v0 > 21) {
            2
        } else if (v2 > 21 || v0 > v2) {
            1
        } else if (v0 < v2) {
            2
        } else {
            3
        };
        (v4, v0, v2)
    }

    fun config(arg0: &0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::Pool) : BlackjackConfig {
        let v0 = 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::uid(arg0);
        let v1 = ConfigKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<ConfigKey>(v0, v1), 0);
        let v2 = ConfigKey{dummy_field: false};
        *0x2::dynamic_field::borrow<ConfigKey, BlackjackConfig>(v0, v2)
    }

    public fun config_action_timeout_ms(arg0: &0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::Pool) : u64 {
        let v0 = config(arg0);
        v0.action_timeout_ms
    }

    public fun config_dealer_stands_soft_17(arg0: &0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::Pool) : bool {
        let v0 = config(arg0);
        v0.dealer_stands_soft_17
    }

    public fun config_edge_bps(arg0: &0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::Pool) : u64 {
        let v0 = config(arg0);
        v0.edge_bps
    }

    public fun config_max_hand_exposure_bps(arg0: &0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::Pool) : u64 {
        let v0 = config(arg0);
        v0.max_hand_exposure_bps
    }

    public fun config_paused(arg0: &0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::Pool) : bool {
        let v0 = config(arg0);
        v0.paused
    }

    public fun configure(arg0: &mut 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::Pool, arg1: &0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::AdminCap, arg2: u64, arg3: bool, arg4: u64, arg5: u64) {
        assert!(0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::admin_cap_pool_id(arg1) == 0x2::object::id<0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::Pool>(arg0), 2);
        assert!(arg2 <= 500, 1);
        assert!(arg4 >= 3600000 && arg4 <= 86400000, 1);
        assert!(arg5 >= 10 && arg5 <= 300, 1);
        let v0 = 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::uid_mut(arg0);
        let v1 = ConfigKey{dummy_field: false};
        let v2 = if (0x2::dynamic_field::exists<ConfigKey>(v0, v1)) {
            let v3 = ConfigKey{dummy_field: false};
            let v4 = 0x2::dynamic_field::remove<ConfigKey, BlackjackConfig>(v0, v3);
            v4.paused
        } else {
            false
        };
        let v5 = BlackjackConfig{
            edge_bps              : arg2,
            dealer_stands_soft_17 : arg3,
            action_timeout_ms     : arg4,
            max_hand_exposure_bps : arg5,
            paused                : v2,
        };
        let v6 = ConfigKey{dummy_field: false};
        0x2::dynamic_field::add<ConfigKey, BlackjackConfig>(v0, v6, v5);
        emit_config(arg0, v5);
    }

    fun deal(arg0: &mut Hand, arg1: &vector<u8>) {
        *0x1::vector::borrow_mut<u8>(&mut arg0.player_cards, 0) = *0x1::vector::borrow<u8>(arg1, 0);
        *0x1::vector::borrow_mut<u8>(&mut arg0.dealer_cards, 0) = *0x1::vector::borrow<u8>(arg1, 1);
        *0x1::vector::borrow_mut<u8>(&mut arg0.player_cards, 1) = *0x1::vector::borrow<u8>(arg1, 2);
        arg0.player_len = 2;
        let (v0, _) = total(&arg0.player_cards);
        let v2 = v0 == 21;
        let v3 = if (v2) {
            *0x1::vector::borrow<u8>(arg1, 3)
        } else {
            255
        };
        *0x1::vector::borrow_mut<u8>(&mut arg0.dealer_cards, 1) = v3;
        let v4 = if (v2) {
            2
        } else {
            1
        };
        arg0.dealer_len = v4;
        let (v5, _) = total(&arg0.dealer_cards);
        let v7 = if (v2 && v5 == 21) {
            3
        } else if (v2) {
            4
        } else {
            0
        };
        arg0.result = v7;
        let v8 = if (v2) {
            1
        } else {
            0
        };
        arg0.status = v8;
        let v9 = HandStarted{
            pool_id            : arg0.pool_id,
            hand_id            : 0x2::object::id<Hand>(arg0),
            player             : arg0.player,
            stake              : arg0.stake,
            max_win_net        : arg0.max_win_net,
            player_cards       : arg0.player_cards,
            dealer_cards       : arg0.dealer_cards,
            player_total       : v0,
            natural            : v2,
            status             : arg0.status,
            result             : arg0.result,
            action_deadline_ms : arg0.action_deadline_ms,
        };
        0x2::event::emit<HandStarted>(v9);
    }

    fun dealer_play(arg0: &mut Hand, arg1: &vector<u8>, arg2: u64) {
        let v0 = *0x1::vector::borrow<u8>(&arg0.dealer_cards, 0);
        let v1 = rank_value(v0);
        let v2 = ace_u64(v0);
        let v3 = 1;
        let v4 = true;
        let v5 = 0;
        while (v5 < 11) {
            let v6 = *0x1::vector::borrow<u8>(arg1, arg2 + v5);
            let v7 = if (v4) {
                rank_value(v6)
            } else {
                0
            };
            v1 = v1 + v7;
            let v8 = if (v4) {
                ace_u64(v6)
            } else {
                0
            };
            v2 = v2 + v8;
            let v9 = if (v4) {
                v6
            } else {
                255
            };
            *0x1::vector::borrow_mut<u8>(&mut arg0.dealer_cards, 1 + v5) = v9;
            let v10 = if (v4) {
                1
            } else {
                0
            };
            v3 = v3 + v10;
            let v11 = if (dealer_should_hit(v1, v2 > 0, arg0.dealer_stands_soft_17)) {
                v4
            } else {
                false
            };
            v4 = v11;
            v5 = v5 + 1;
        };
        arg0.dealer_len = v3;
    }

    fun dealer_should_hit(arg0: u64, arg1: bool, arg2: bool) : bool {
        let v0 = arg1 && arg0 + 10 <= 21;
        let v1 = if (v0) {
            arg0 + 10
        } else {
            arg0
        };
        if (v1 < 17) {
            true
        } else if (v1 == 17) {
            if (v0) {
                !arg2
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun default_action_timeout_ms() : u64 {
        3600000
    }

    public fun default_max_hand_exposure_bps() : u64 {
        150
    }

    entry fun double(arg0: &mut 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::Pool, arg1: &mut Hand, arg2: &0x2::random::Random, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) {
        begin_double(arg0, arg1, arg3, arg4, arg5);
        let v0 = 0x2::random::new_generator(arg2, arg5);
        let v1 = &mut v0;
        draw_into_pending(arg1, v1, 1 + 11);
        emit_drawn(arg1);
    }

    fun draw_into_pending(arg0: &mut Hand, arg1: &mut 0x2::random::RandomGenerator, arg2: u64) {
        let v0 = 0;
        while (v0 < arg2) {
            *0x1::vector::borrow_mut<u8>(&mut arg0.pending, v0) = 0x2::random::generate_u8_in_range(arg1, 0, 51);
            v0 = v0 + 1;
        };
    }

    fun emit_config(arg0: &0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::Pool, arg1: BlackjackConfig) {
        let v0 = BlackjackConfigUpdated{
            pool_id               : 0x2::object::id<0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::Pool>(arg0),
            edge_bps              : arg1.edge_bps,
            dealer_stands_soft_17 : arg1.dealer_stands_soft_17,
            action_timeout_ms     : arg1.action_timeout_ms,
            max_hand_exposure_bps : arg1.max_hand_exposure_bps,
            paused                : arg1.paused,
        };
        0x2::event::emit<BlackjackConfigUpdated>(v0);
    }

    fun emit_drawn(arg0: &Hand) {
        let v0 = CardsDrawn{
            hand_id            : 0x2::object::id<Hand>(arg0),
            player             : arg0.player,
            action             : arg0.pending_action,
            cards              : arg0.pending,
            action_deadline_ms : arg0.action_deadline_ms,
        };
        0x2::event::emit<CardsDrawn>(v0);
    }

    public fun empty_card() : u8 {
        255
    }

    fun empty_cards() : vector<u8> {
        let v0 = b"";
        let v1 = 0;
        while (v1 < 12) {
            0x1::vector::push_back<u8>(&mut v0, 255);
            v1 = v1 + 1;
        };
        v0
    }

    public fun hand_action_deadline_ms(arg0: &Hand) : u64 {
        arg0.action_deadline_ms
    }

    public fun hand_action_timeout_ms(arg0: &Hand) : u64 {
        arg0.action_timeout_ms
    }

    public fun hand_deadline_ms(arg0: &Hand) : u64 {
        arg0.hand_deadline_ms
    }

    public fun hand_dealer_cards(arg0: &Hand) : vector<u8> {
        arg0.dealer_cards
    }

    public fun hand_dealer_len(arg0: &Hand) : u64 {
        arg0.dealer_len
    }

    public fun hand_dealer_stands_soft_17(arg0: &Hand) : bool {
        arg0.dealer_stands_soft_17
    }

    public fun hand_dealer_total(arg0: &Hand) : u64 {
        let (v0, _) = total(&arg0.dealer_cards);
        v0
    }

    public fun hand_doubled(arg0: &Hand) : bool {
        arg0.doubled
    }

    public fun hand_edge_bps(arg0: &Hand) : u64 {
        arg0.edge_bps
    }

    public fun hand_escrowed(arg0: &Hand) : u64 {
        arg0.escrowed
    }

    public fun hand_is_open(arg0: &Hand) : bool {
        0x1::option::is_some<0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::Bet>(&arg0.bet)
    }

    public fun hand_lifetime_timeouts() : u64 {
        2
    }

    public fun hand_max_win_net(arg0: &Hand) : u64 {
        arg0.max_win_net
    }

    public fun hand_payout(arg0: &Hand) : u64 {
        arg0.payout
    }

    public fun hand_pending_action(arg0: &Hand) : u8 {
        arg0.pending_action
    }

    public fun hand_pending_cards(arg0: &Hand) : vector<u8> {
        arg0.pending
    }

    public fun hand_player(arg0: &Hand) : address {
        arg0.player
    }

    public fun hand_player_cards(arg0: &Hand) : vector<u8> {
        arg0.player_cards
    }

    public fun hand_player_len(arg0: &Hand) : u64 {
        arg0.player_len
    }

    public fun hand_player_total(arg0: &Hand) : u64 {
        let (v0, _) = total(&arg0.player_cards);
        v0
    }

    public fun hand_pool_id(arg0: &Hand) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun hand_result(arg0: &Hand) : u8 {
        arg0.result
    }

    public fun hand_stake(arg0: &Hand) : u64 {
        arg0.stake
    }

    public fun hand_started_at_ms(arg0: &Hand) : u64 {
        arg0.started_at_ms
    }

    public fun hand_status(arg0: &Hand) : u8 {
        arg0.status
    }

    entry fun hit(arg0: &mut Hand, arg1: &0x2::random::Random, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        begin_hit(arg0, arg2, arg3);
        let v0 = 0x2::random::new_generator(arg1, arg3);
        let v1 = &mut v0;
        draw_into_pending(arg0, v1, 1);
        emit_drawn(arg0);
    }

    public fun is_configured(arg0: &0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::Pool) : bool {
        let v0 = ConfigKey{dummy_field: false};
        0x2::dynamic_field::exists<ConfigKey>(0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::uid(arg0), v0)
    }

    fun mark_drawn(arg0: &mut Hand, arg1: u8) {
        arg0.pending_action = arg1;
        arg0.status = 3;
    }

    public fun max_stake_for_hand_exposure(arg0: &0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::Pool) : u64 {
        let v0 = config(arg0);
        let v1 = 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::house_capital(arg0);
        let v2 = 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::open_liability(arg0);
        let v3 = if (v1 > v2) {
            v1 - v2
        } else {
            0
        };
        mul_div(v3, v0.max_hand_exposure_bps, 10000) / 2
    }

    public fun max_win_net(arg0: u64, arg1: u64) : u64 {
        let v0 = natural_payout(arg0) - arg0;
        let v1 = sat_sub(win_payout(arg0, arg1), arg0);
        let v2 = add_checked(arg0, arg0);
        let v3 = sat_sub(win_payout(v2, arg1), v2);
        let v4 = if (v0 > v1) {
            v0
        } else {
            v1
        };
        if (v3 > v4) {
            v3
        } else {
            v4
        }
    }

    fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = (arg0 as u128) * (arg1 as u128) / (arg2 as u128);
        assert!(v0 <= 18446744073709551615, 13);
        (v0 as u64)
    }

    public fun natural_payout(arg0: u64) : u64 {
        mul_div(arg0, 5, 2)
    }

    fun open_hand(arg0: &mut 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::Pool, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) : Hand {
        let v0 = config(arg0);
        assert!(!v0.paused, 3);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        let v2 = max_win_net(v1, v0.edge_bps);
        let v3 = 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::house_capital(arg0);
        let v4 = 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::open_liability(arg0);
        let v5 = if (v3 > v4) {
            v3 - v4
        } else {
            0
        };
        assert!((v2 as u128) * (10000 as u128) <= (v5 as u128) * (v0.max_hand_exposure_bps as u128), 10);
        let v6 = 0x2::tx_context::sender(arg3);
        let v7 = 0x2::clock::timestamp_ms(arg1);
        Hand{
            id                    : 0x2::object::new(arg3),
            pool_id               : 0x2::object::id<0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::Pool>(arg0),
            player                : v6,
            stake                 : v1,
            escrowed              : v1,
            max_win_net           : v2,
            edge_bps              : v0.edge_bps,
            dealer_stands_soft_17 : v0.dealer_stands_soft_17,
            action_timeout_ms     : v0.action_timeout_ms,
            doubled               : false,
            status                : 3,
            result                : 0,
            player_cards          : empty_cards(),
            player_len            : 0,
            dealer_cards          : empty_cards(),
            dealer_len            : 0,
            pending               : empty_cards(),
            pending_action        : 1,
            started_at_ms         : v7,
            action_deadline_ms    : add_checked(v7, v0.action_timeout_ms),
            hand_deadline_ms      : add_checked(v7, v0.action_timeout_ms * 2),
            payout                : 0,
            bet                   : 0x1::option::some<0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::Bet>(0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::open_position(arg0, 0x2::coin::into_balance<0x2::sui::SUI>(arg2), v2, v6, v0.edge_bps)),
        }
    }

    fun payout_for(arg0: u8, arg1: u64, arg2: u64, arg3: u64) : u64 {
        if (arg0 == 4) {
            natural_payout(arg1)
        } else if (arg0 == 1) {
            win_payout(arg2, arg3)
        } else if (arg0 == 3) {
            arg2
        } else {
            0
        }
    }

    fun rank_value(arg0: u8) : u64 {
        let v0 = arg0 % 13;
        if (v0 == 0) {
            1
        } else if (v0 <= 9) {
            (v0 as u64) + 1
        } else {
            10
        }
    }

    public fun resolve(arg0: &mut Hand) {
        assert!(arg0.status == 3, 5);
        resolve_pending(arg0);
    }

    fun resolve_pending(arg0: &mut Hand) {
        let v0 = arg0.pending_action;
        let v1 = arg0.pending;
        if (v0 == 1) {
            deal(arg0, &v1);
        } else if (v0 == 2) {
            apply_hit(arg0, *0x1::vector::borrow<u8>(&v1, 0));
        } else if (v0 == 3) {
            apply_stand(arg0, &v1);
        } else {
            apply_double(arg0, &v1);
        };
        arg0.pending = empty_cards();
        arg0.pending_action = 0;
    }

    public fun result_dealer_win() : u8 {
        2
    }

    public fun result_forfeit() : u8 {
        5
    }

    public fun result_none() : u8 {
        0
    }

    public fun result_player_bj() : u8 {
        4
    }

    public fun result_player_win() : u8 {
        1
    }

    public fun result_push() : u8 {
        3
    }

    fun sat_sub(arg0: u64, arg1: u64) : u64 {
        if (arg0 > arg1) {
            arg0 - arg1
        } else {
            0
        }
    }

    public fun set_paused(arg0: &mut 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::Pool, arg1: &0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::AdminCap, arg2: bool) {
        assert!(0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::admin_cap_pool_id(arg1) == 0x2::object::id<0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::Pool>(arg0), 2);
        let v0 = 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::uid_mut(arg0);
        let v1 = ConfigKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<ConfigKey>(v0, v1), 0);
        let v2 = ConfigKey{dummy_field: false};
        let v3 = 0x2::dynamic_field::borrow_mut<ConfigKey, BlackjackConfig>(v0, v2);
        v3.paused = arg2;
        emit_config(arg0, *v3);
    }

    public fun settle(arg0: &mut 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::Pool, arg1: &mut Hand, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.pool_id == 0x2::object::id<0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::Pool>(arg0), 11);
        if (arg1.status == 3) {
            resolve_pending(arg1);
        };
        assert!(arg1.status == 1, 5);
        settle_inner(arg0, arg1, arg2);
    }

    fun settle_inner(arg0: &mut 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::Pool, arg1: &mut Hand, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = payout_for(arg1.result, arg1.stake, arg1.escrowed, arg1.edge_bps);
        arg1.status = 2;
        arg1.payout = v0;
        let v1 = HandSettled{
            pool_id     : arg1.pool_id,
            hand_id     : 0x2::object::id<Hand>(arg1),
            player      : arg1.player,
            result      : arg1.result,
            escrowed    : arg1.escrowed,
            max_win_net : arg1.max_win_net,
            payout      : v0,
        };
        0x2::event::emit<HandSettled>(v1);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::settle_position(arg0, 0x1::option::extract<0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::Bet>(&mut arg1.bet), v0), arg2), arg1.player);
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::settle_position(arg0, 0x1::option::extract<0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::Bet>(&mut arg1.bet), v0));
        };
    }

    entry fun stand(arg0: &mut Hand, arg1: &0x2::random::Random, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        begin_stand(arg0, arg2, arg3);
        let v0 = 0x2::random::new_generator(arg1, arg3);
        let v1 = &mut v0;
        draw_into_pending(arg0, v1, 11);
        emit_drawn(arg0);
    }

    entry fun start_hand(arg0: &mut 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::Pool, arg1: &0x2::random::Random, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        start_impl(arg0, arg1, arg2, arg3, arg4);
    }

    entry fun start_hand_with_referrer(arg0: &mut 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::Pool, arg1: &0x2::random::Random, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::try_bind_referrer(arg0, 0x2::tx_context::sender(arg5), arg4);
        start_impl(arg0, arg1, arg2, arg3, arg5);
    }

    fun start_impl(arg0: &mut 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::Pool, arg1: &0x2::random::Random, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = open_hand(arg0, arg2, arg3, arg4);
        let v1 = 0x2::random::new_generator(arg1, arg4);
        let v2 = &mut v0;
        let v3 = &mut v1;
        draw_into_pending(v2, v3, 4);
        emit_drawn(&v0);
        0x2::transfer::share_object<Hand>(v0);
        0x2::object::id<Hand>(&v0)
    }

    public fun status_drawn() : u8 {
        3
    }

    public fun status_player_turn() : u8 {
        0
    }

    public fun status_resolved() : u8 {
        1
    }

    public fun status_settled() : u8 {
        2
    }

    public fun timeout(arg0: &mut 0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::Pool, arg1: &mut Hand, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.pool_id == 0x2::object::id<0xd3c6bc252bbbeabf8ec08aea7ce9d197dc45576c4cfde9f717e35ceedd25e844::pool::Pool>(arg0), 11);
        if (arg1.status == 3) {
            resolve_pending(arg1);
        };
        assert!(arg1.status == 0, 5);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 > arg1.action_deadline_ms, 7);
        arg1.result = 5;
        arg1.status = 1;
        let v1 = HandTimedOut{
            pool_id            : arg1.pool_id,
            hand_id            : 0x2::object::id<Hand>(arg1),
            player             : arg1.player,
            caller             : 0x2::tx_context::sender(arg3),
            action_deadline_ms : arg1.action_deadline_ms,
            now_ms             : v0,
        };
        0x2::event::emit<HandTimedOut>(v1);
        settle_inner(arg0, arg1, arg3);
    }

    fun total(arg0: &vector<u8>) : (u64, bool) {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        while (v2 < 12) {
            let v3 = *0x1::vector::borrow<u8>(arg0, v2);
            let v4 = v3 != 255;
            let v5 = if (v4) {
                rank_value(v3)
            } else {
                0
            };
            v0 = v0 + v5;
            let v6 = if (v4) {
                ace_u64(v3)
            } else {
                0
            };
            v1 = v1 + v6;
            v2 = v2 + 1;
        };
        let v7 = v1 > 0 && v0 + 10 <= 21;
        let v8 = if (v7) {
            v0 + 10
        } else {
            v0
        };
        (v8, v7)
    }

    public fun win_payout(arg0: u64, arg1: u64) : u64 {
        let v0 = (arg0 as u128) * 2 * ((10000 - arg1) as u128) / (10000 as u128);
        assert!(v0 <= 18446744073709551615, 13);
        (v0 as u64)
    }

    // decompiled from Move bytecode v7
}

