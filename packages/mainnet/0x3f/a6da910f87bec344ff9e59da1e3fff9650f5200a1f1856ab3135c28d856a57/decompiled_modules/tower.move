module 0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::tower {
    struct GameKey has copy, drop, store {
        player: address,
    }

    struct Game has drop, store {
        wager: u64,
        stake: u64,
        difficulty: u8,
        row: u8,
        finished: bool,
        reserved: u64,
        liability: u64,
        started_ms: u64,
    }

    struct TowerStarted has copy, drop {
        player: address,
        difficulty: u8,
        wager: u64,
    }

    struct TowerPicked has copy, drop {
        player: address,
        row: u8,
        tile: u8,
        trap: u8,
        safe: bool,
    }

    struct TowerClimbed has copy, drop {
        player: address,
        rows: u8,
        cash_out: u64,
    }

    fun assert_live_game<T0>(arg0: &0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::house::House<T0>, arg1: address) {
        assert!(has_game<T0>(arg0, arg1), 2);
    }

    public fun cash_out<T0>(arg0: &mut 0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::house::House<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert_live_game<T0>(arg0, v0);
        let v1 = GameKey{player: v0};
        let v2 = 0x2::dynamic_field::remove<GameKey, Game>(0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::house::uid_mut<T0>(arg0), v1);
        assert!(v2.row > 0, 4);
        0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::house::release<T0>(arg0, 3, v2.reserved, v2.liability);
        0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::house::settle<T0>(arg0, 3, v0, v2.wager, v2.stake, v2.liability, arg1);
    }

    public fun close_abandoned<T0>(arg0: &mut 0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::house::House<T0>, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_live_game<T0>(arg0, arg1);
        let v0 = GameKey{player: arg1};
        let v1 = 0x2::dynamic_field::remove<GameKey, Game>(0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::house::uid_mut<T0>(arg0), v0);
        assert!(0x2::clock::timestamp_ms(arg2) >= v1.started_ms + 3600000, 5);
        let v2 = if (v1.row > 0) {
            v1.liability
        } else {
            0
        };
        0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::house::release<T0>(arg0, 3, v1.reserved, v1.liability);
        0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::house::settle<T0>(arg0, 3, arg1, v1.wager, v1.stake, v2, arg3);
    }

    public fun has_game<T0>(arg0: &0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::house::House<T0>, arg1: address) : bool {
        let v0 = GameKey{player: arg1};
        if (!0x2::dynamic_field::exists<GameKey>(0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::house::uid<T0>(arg0), v0)) {
            return false
        };
        !0x2::dynamic_field::borrow<GameKey, Game>(0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::house::uid<T0>(arg0), v0).finished
    }

    public fun payout_at(arg0: u64, arg1: u8, arg2: u8) : u64 {
        let v0 = (tiles(arg1) as u128);
        let v1 = (arg0 as u128) * (99 as u128) / 100;
        let v2 = 0;
        while (v2 < arg2) {
            let v3 = v1 * v0;
            v1 = v3 / (v0 - 1);
            v2 = v2 + 1;
        };
        (v1 as u64)
    }

    entry fun pick<T0>(arg0: &mut 0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::house::House<T0>, arg1: u8, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert_live_game<T0>(arg0, v0);
        let v1 = GameKey{player: v0};
        let v2 = 0x2::random::new_generator(arg2, arg3);
        let v3 = 0x2::random::generate_u8_in_range(&mut v2, 0, tiles(0x2::dynamic_field::borrow<GameKey, Game>(0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::house::uid<T0>(arg0), v1).difficulty) - 1);
        resolve_pick<T0>(arg0, arg1, v3, arg3);
    }

    fun resolve_pick<T0>(arg0: &mut 0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::house::House<T0>, arg1: u8, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert_live_game<T0>(arg0, v0);
        let v1 = GameKey{player: v0};
        let v2 = 0x2::dynamic_field::borrow_mut<GameKey, Game>(0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::house::uid_mut<T0>(arg0), v1);
        assert!(arg1 < tiles(v2.difficulty), 3);
        let v3 = arg1 != arg2;
        let v4 = TowerPicked{
            player : v0,
            row    : v2.row,
            tile   : arg1,
            trap   : arg2,
            safe   : v3,
        };
        0x2::event::emit<TowerPicked>(v4);
        if (v3) {
            v2.row = v2.row + 1;
        };
        let v5 = v2.row;
        let v6 = payout_at(v2.stake, v2.difficulty, v5);
        let v7 = !v3 || v5 == 8;
        v2.finished = v7;
        if (v7) {
            v2.reserved = 0;
            v2.liability = 0;
        } else {
            v2.liability = v6;
        };
        if (!v7) {
            0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::house::set_liability<T0>(arg0, v2.liability, v6);
            let v8 = TowerClimbed{
                player   : v0,
                rows     : v5,
                cash_out : v6,
            };
            0x2::event::emit<TowerClimbed>(v8);
            0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::house::checkpoint<T0>(arg0, 3, v0, v2.wager, v6);
        } else {
            0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::house::release<T0>(arg0, 3, v2.reserved, v2.liability);
            let v9 = if (v3) {
                v6
            } else {
                0
            };
            0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::house::settle<T0>(arg0, 3, v0, v2.wager, v2.stake, v9, arg3);
        };
    }

    public fun rows_cleared<T0>(arg0: &0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::house::House<T0>, arg1: address) : u8 {
        let v0 = GameKey{player: arg1};
        0x2::dynamic_field::borrow<GameKey, Game>(0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::house::uid<T0>(arg0), v0).row
    }

    public fun start<T0>(arg0: &mut 0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::house::House<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u8, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = GameKey{player: v0};
        if (0x2::dynamic_field::exists<GameKey>(0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::house::uid<T0>(arg0), v1)) {
            let v2 = 0x2::dynamic_field::remove<GameKey, Game>(0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::house::uid_mut<T0>(arg0), v1);
            assert!(v2.finished, 1);
        };
        let v3 = 0x2::coin::value<T0>(&arg1);
        let v4 = 0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::house::take_bet<T0>(arg0, 3, arg1, v0, arg3);
        let v5 = payout_at(v4, arg2, 8);
        let v6 = payout_at(v4, arg2, 0);
        0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::house::assert_max_profit<T0>(arg0, v4, v5 - v4);
        0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::house::reserve<T0>(arg0, 3, v5, v6);
        let v7 = Game{
            wager      : v3,
            stake      : v4,
            difficulty : arg2,
            row        : 0,
            finished   : false,
            reserved   : v5,
            liability  : v6,
            started_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::dynamic_field::add<GameKey, Game>(0x3fa6da910f87bec344ff9e59da1e3fff9650f5200a1f1856ab3135c28d856a57::house::uid_mut<T0>(arg0), v1, v7);
        let v8 = TowerStarted{
            player     : v0,
            difficulty : arg2,
            wager      : v3,
        };
        0x2::event::emit<TowerStarted>(v8);
    }

    public fun tiles(arg0: u8) : u8 {
        assert!(arg0 <= 2, 0);
        4 - arg0
    }

    // decompiled from Move bytecode v7
}

