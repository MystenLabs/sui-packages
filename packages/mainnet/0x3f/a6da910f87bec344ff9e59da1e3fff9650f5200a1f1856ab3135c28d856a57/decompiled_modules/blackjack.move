module 0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::blackjack {
    struct GameKey has copy, drop, store {
        player: address,
    }

    struct Game has drop, store {
        wager: u64,
        stake: u64,
        player_cards: vector<u8>,
        dealer_cards: vector<u8>,
        finished: bool,
        reserved: u64,
        liability: u64,
        started_ms: u64,
    }

    struct Settlement has drop {
        wager: u64,
        stake: u64,
        payout: u64,
        reserved: u64,
        liability: u64,
    }

    struct HandUpdated has copy, drop {
        player: address,
        player_cards: vector<u8>,
        dealer_cards: vector<u8>,
        outcome: u8,
        wager: u64,
        payout: u64,
    }

    fun assert_live_game<T0>(arg0: &0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::house::House<T0>, arg1: address) {
        assert!(has_game<T0>(arg0, arg1), 1);
    }

    fun cards_on_table<T0>(arg0: &0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::house::House<T0>, arg1: address) : vector<u8> {
        assert_live_game<T0>(arg0, arg1);
        let v0 = GameKey{player: arg1};
        let v1 = 0x2::dynamic_field::borrow<GameKey, Game>(0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::house::uid<T0>(arg0), v0);
        let v2 = v1.player_cards;
        0x1::vector::append<u8>(&mut v2, v1.dealer_cards);
        v2
    }

    fun close(arg0: &mut Game, arg1: address, arg2: u8) : Settlement {
        let v0 = if (arg2 == 1) {
            arg0.stake * 5 / 2
        } else if (arg2 == 2) {
            arg0.stake * 2
        } else if (arg2 == 3) {
            arg0.stake
        } else {
            0
        };
        arg0.finished = true;
        emit_update(arg1, arg0, arg2, v0);
        let v1 = Settlement{
            wager     : arg0.wager,
            stake     : arg0.stake,
            payout    : v0,
            reserved  : arg0.reserved,
            liability : arg0.liability,
        };
        arg0.reserved = 0;
        arg0.liability = 0;
        v1
    }

    entry fun deal<T0>(arg0: &mut 0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::house::House<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::random::Random, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::random::new_generator(arg2, arg4);
        let v1 = b"";
        let v2 = &mut v0;
        let v3 = &mut v1;
        let v4 = &mut v0;
        let v5 = &mut v1;
        let v6 = 0x1::vector::empty<u8>();
        let v7 = &mut v6;
        0x1::vector::push_back<u8>(v7, draw(v2, v3));
        0x1::vector::push_back<u8>(v7, draw(v4, v5));
        let v8 = &mut v0;
        let v9 = &mut v1;
        let v10 = &mut v0;
        let v11 = &mut v1;
        resolve_deal<T0>(arg0, arg1, v6, draw(v8, v9), draw(v10, v11), arg3, arg4);
    }

    fun dealer_draws(arg0: &mut 0x2::random::RandomGenerator, arg1: &mut vector<u8>) : vector<u8> {
        let v0 = b"";
        let v1 = 0;
        while (v1 < 12) {
            0x1::vector::push_back<u8>(&mut v0, draw(arg0, arg1));
            v1 = v1 + 1;
        };
        v0
    }

    entry fun double<T0>(arg0: &mut 0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::house::House<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::random::Random, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = cards_on_table<T0>(arg0, 0x2::tx_context::sender(arg4));
        let v1 = 0x2::random::new_generator(arg2, arg4);
        let v2 = &mut v1;
        let v3 = &mut v0;
        let v4 = &mut v1;
        let v5 = &mut v0;
        resolve_double<T0>(arg0, arg1, draw(v2, v3), dealer_draws(v4, v5), arg3, arg4);
    }

    fun draw(arg0: &mut 0x2::random::RandomGenerator, arg1: &mut vector<u8>) : u8 {
        let v0;
        loop {
            v0 = 0x2::random::generate_u8_in_range(arg0, 0, 208 - 1);
            if (!0x1::vector::contains<u8>(arg1, &v0)) {
                break
            };
        };
        0x1::vector::push_back<u8>(arg1, v0);
        v0
    }

    fun emit_update(arg0: address, arg1: &Game, arg2: u8, arg3: u64) {
        let v0 = HandUpdated{
            player       : arg0,
            player_cards : arg1.player_cards,
            dealer_cards : arg1.dealer_cards,
            outcome      : arg2,
            wager        : arg1.wager,
            payout       : arg3,
        };
        0x2::event::emit<HandUpdated>(v0);
    }

    public fun hand_value(arg0: &vector<u8>) : u8 {
        let v0 = 0;
        let v1 = false;
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(arg0)) {
            let v3 = *0x1::vector::borrow<u8>(arg0, v2) % 13;
            if (v3 == 0) {
                v1 = true;
            };
            let v4 = if (v3 >= 9) {
                10
            } else {
                v3 + 1
            };
            v0 = v0 + v4;
            v2 = v2 + 1;
        };
        if (v1 && v0 <= 11) {
            v0 + 10
        } else {
            v0
        }
    }

    public fun has_game<T0>(arg0: &0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::house::House<T0>, arg1: address) : bool {
        let v0 = GameKey{player: arg1};
        if (!0x2::dynamic_field::exists<GameKey>(0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::house::uid<T0>(arg0), v0)) {
            return false
        };
        !0x2::dynamic_field::borrow<GameKey, Game>(0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::house::uid<T0>(arg0), v0).finished
    }

    entry fun hit<T0>(arg0: &mut 0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::house::House<T0>, arg1: &0x2::random::Random, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = cards_on_table<T0>(arg0, 0x2::tx_context::sender(arg2));
        let v1 = 0x2::random::new_generator(arg1, arg2);
        let v2 = &mut v1;
        let v3 = &mut v0;
        let v4 = &mut v1;
        let v5 = &mut v0;
        resolve_hit<T0>(arg0, draw(v2, v3), dealer_draws(v4, v5), arg2);
    }

    public fun is_natural(arg0: &vector<u8>) : bool {
        0x1::vector::length<u8>(arg0) == 2 && hand_value(arg0) == 21
    }

    fun play_dealer(arg0: &mut Game, arg1: address, arg2: vector<u8>) : Settlement {
        0x1::vector::reverse<u8>(&mut arg2);
        while (hand_value(&arg0.dealer_cards) < 17) {
            0x1::vector::push_back<u8>(&mut arg0.dealer_cards, 0x1::vector::pop_back<u8>(&mut arg2));
        };
        let v0 = hand_value(&arg0.dealer_cards);
        let v1 = hand_value(&arg0.player_cards);
        let v2 = if (is_natural(&arg0.dealer_cards)) {
            4
        } else if (v0 > 21 || v1 > v0) {
            2
        } else if (v1 == v0) {
            3
        } else {
            4
        };
        close(arg0, arg1, v2)
    }

    fun resolve_deal<T0>(arg0: &mut 0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::house::House<T0>, arg1: 0x2::coin::Coin<T0>, arg2: vector<u8>, arg3: u8, arg4: u8, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = GameKey{player: v0};
        if (0x2::dynamic_field::exists<GameKey>(0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::house::uid<T0>(arg0), v1)) {
            let v2 = 0x2::dynamic_field::remove<GameKey, Game>(0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::house::uid_mut<T0>(arg0), v1);
            assert!(v2.finished, 0);
        };
        let v3 = 0x2::coin::value<T0>(&arg1);
        let v4 = 0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::house::take_bet<T0>(arg0, 4, arg1, v0, arg5);
        0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::house::assert_max_profit<T0>(arg0, v4, 2 * v4);
        let v5 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v5, arg3);
        let v6 = Game{
            wager        : v3,
            stake        : v4,
            player_cards : arg2,
            dealer_cards : v5,
            finished     : false,
            reserved     : 2 * v4,
            liability    : v4,
            started_ms   : 0x2::clock::timestamp_ms(arg5),
        };
        0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::house::reserve<T0>(arg0, 4, v6.reserved, v6.liability);
        if (is_natural(&v6.player_cards)) {
            0x1::vector::push_back<u8>(&mut v6.dealer_cards, arg4);
            let v7 = if (is_natural(&v6.dealer_cards)) {
                3
            } else {
                1
            };
            let v8 = &mut v6;
            0x2::dynamic_field::add<GameKey, Game>(0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::house::uid_mut<T0>(arg0), v1, v6);
            settle<T0>(arg0, v0, close(v8, v0, v7), arg6);
        } else {
            emit_update(v0, &v6, 0, 0);
            0x2::dynamic_field::add<GameKey, Game>(0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::house::uid_mut<T0>(arg0), v1, v6);
            0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::house::checkpoint<T0>(arg0, 4, v0, v3, v4);
        };
    }

    fun resolve_double<T0>(arg0: &mut 0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::house::House<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u8, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert_live_game<T0>(arg0, v0);
        let v1 = GameKey{player: v0};
        let v2 = 0x2::dynamic_field::borrow<GameKey, Game>(0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::house::uid<T0>(arg0), v1);
        assert!(0x1::vector::length<u8>(&v2.player_cards) == 2, 2);
        let v3 = v2.reserved;
        assert!(0x2::coin::value<T0>(&arg1) == v2.wager, 3);
        let v4 = 0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::house::take_bet<T0>(arg0, 4, arg1, v0, arg4);
        let v5 = GameKey{player: v0};
        let v6 = 0x2::dynamic_field::borrow_mut<GameKey, Game>(0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::house::uid_mut<T0>(arg0), v5);
        v6.wager = v6.wager + 0x2::coin::value<T0>(&arg1);
        v6.stake = v6.stake + v4;
        let v7 = 2 * v6.stake;
        let v8 = if (v7 > v3) {
            v7 - v3
        } else {
            0
        };
        v6.reserved = v3 + v8;
        v6.liability = v6.liability + v4;
        0x1::vector::push_back<u8>(&mut v6.player_cards, arg2);
        let v9 = if (hand_value(&v6.player_cards) > 21) {
            close(v6, v0, 5)
        } else {
            play_dealer(v6, v0, arg3)
        };
        0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::house::reserve<T0>(arg0, 4, v8, v4);
        settle<T0>(arg0, v0, v9, arg5);
    }

    fun resolve_hit<T0>(arg0: &mut 0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::house::House<T0>, arg1: u8, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert_live_game<T0>(arg0, v0);
        let v1 = GameKey{player: v0};
        let v2 = 0x2::dynamic_field::borrow_mut<GameKey, Game>(0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::house::uid_mut<T0>(arg0), v1);
        0x1::vector::push_back<u8>(&mut v2.player_cards, arg1);
        let v3 = hand_value(&v2.player_cards);
        if (v3 < 21) {
            emit_update(v0, v2, 0, 0);
            0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::house::checkpoint<T0>(arg0, 4, v0, v2.wager, v2.liability);
            return
        };
        let v4 = if (v3 > 21) {
            close(v2, v0, 5)
        } else {
            play_dealer(v2, v0, arg2)
        };
        settle<T0>(arg0, v0, v4, arg3);
    }

    fun resolve_stand<T0>(arg0: &mut 0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::house::House<T0>, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert_live_game<T0>(arg0, v0);
        let v1 = GameKey{player: v0};
        let v2 = 0x2::dynamic_field::borrow_mut<GameKey, Game>(0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::house::uid_mut<T0>(arg0), v1);
        settle<T0>(arg0, v0, play_dealer(v2, v0, arg1), arg2);
    }

    fun settle<T0>(arg0: &mut 0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::house::House<T0>, arg1: address, arg2: Settlement, arg3: &mut 0x2::tx_context::TxContext) {
        0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::house::release<T0>(arg0, 4, arg2.reserved, arg2.liability);
        0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::house::settle<T0>(arg0, 4, arg1, arg2.wager, arg2.stake, arg2.payout, arg3);
    }

    entry fun stand<T0>(arg0: &mut 0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::house::House<T0>, arg1: &0x2::random::Random, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = cards_on_table<T0>(arg0, 0x2::tx_context::sender(arg2));
        let v1 = 0x2::random::new_generator(arg1, arg2);
        let v2 = &mut v1;
        let v3 = &mut v0;
        resolve_stand<T0>(arg0, dealer_draws(v2, v3), arg2);
    }

    public fun void_abandoned<T0>(arg0: &mut 0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::house::House<T0>, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_live_game<T0>(arg0, arg1);
        let v0 = GameKey{player: arg1};
        let v1 = 0x2::dynamic_field::borrow_mut<GameKey, Game>(0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::house::uid_mut<T0>(arg0), v0);
        assert!(0x2::clock::timestamp_ms(arg2) >= v1.started_ms + 3600000, 4);
        settle<T0>(arg0, arg1, close(v1, arg1, 4), arg3);
    }

    // decompiled from Move bytecode v7
}

