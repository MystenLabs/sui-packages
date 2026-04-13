module 0x3b519e3a0dfff4a4aafd9a81a89cdd851b6775b70d66095d2bb99221c0d503b9::blackjack {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct GameState has key {
        id: 0x2::object::UID,
        prize_pool: 0x2::balance::Balance<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>,
        min_bet: u64,
        paused: bool,
        total_hands: u64,
        total_volume: u64,
        jackpots_hit: u64,
    }

    struct GameSession has key {
        id: 0x2::object::UID,
        player: address,
        bet: u64,
        doubled: bool,
        active: bool,
        created_at: u64,
    }

    struct PendingWithdrawal has key {
        id: 0x2::object::UID,
        amount: u64,
        not_before: u64,
    }

    struct BetPlaced has copy, drop {
        session_id: 0x2::object::ID,
        player: address,
        bet: u64,
    }

    struct HandSettled has copy, drop {
        session_id: 0x2::object::ID,
        player: address,
        bet: u64,
        doubled: bool,
        result: u8,
        payout: u64,
        pool_after: u64,
    }

    struct JackpotHit has copy, drop {
        session_id: 0x2::object::ID,
        player: address,
        bet: u64,
        payout: u64,
    }

    struct PoolDeposited has copy, drop {
        depositor: address,
        amount: u64,
        pool_after: u64,
    }

    struct MinBetUpdated has copy, drop {
        old_min: u64,
        new_min: u64,
    }

    struct SpinResult has copy, drop {
        player: address,
        wager: u64,
        reel0: u8,
        reel1: u8,
        reel2: u8,
        result: u8,
        payout: u64,
        pool_after: u64,
    }

    struct TimeoutRefund has copy, drop {
        session_id: 0x2::object::ID,
        player: address,
        amount: u64,
    }

    struct WithdrawInitiated has copy, drop {
        amount: u64,
        not_before: u64,
    }

    struct WithdrawExecuted has copy, drop {
        amount: u64,
        pool_after: u64,
    }

    fun capped_jackpot(arg0: u64) : u64 {
        if (arg0 <= 10000000000000) {
            return 0
        };
        let v0 = arg0 * 5000 / 10000;
        let v1 = arg0 - 10000000000000;
        if (v0 < v1) {
            v0
        } else {
            v1
        }
    }

    public entry fun claim_timeout_refund(arg0: &mut GameState, arg1: GameSession, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.active, 3);
        assert!(arg1.player == 0x2::tx_context::sender(arg3), 0);
        assert!(0x2::clock::timestamp_ms(arg2) - arg1.created_at >= 86400000, 8);
        let GameSession {
            id         : v0,
            player     : v1,
            bet        : v2,
            doubled    : v3,
            active     : _,
            created_at : _,
        } = arg1;
        let v6 = v0;
        0x2::object::delete(v6);
        let v7 = if (v3) {
            v2 * 2
        } else {
            v2
        };
        let v8 = 0x2::balance::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg0.prize_pool);
        let v9 = if (v7 > v8) {
            v8
        } else {
            v7
        };
        if (v9 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>>(0x2::coin::from_balance<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(0x2::balance::split<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&mut arg0.prize_pool, v9), arg3), v1);
        };
        let v10 = TimeoutRefund{
            session_id : 0x2::object::uid_to_inner(&v6),
            player     : v1,
            amount     : v9,
        };
        0x2::event::emit<TimeoutRefund>(v10);
    }

    public entry fun deposit_pool(arg0: &mut GameState, arg1: 0x2::coin::Coin<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&mut arg0.prize_pool, 0x2::coin::into_balance<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(arg1));
        let v0 = PoolDeposited{
            depositor  : 0x2::tx_context::sender(arg2),
            amount     : 0x2::coin::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg1),
            pool_after : 0x2::balance::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg0.prize_pool),
        };
        0x2::event::emit<PoolDeposited>(v0);
    }

    public entry fun double_down(arg0: &mut GameState, arg1: &mut GameSession, arg2: 0x2::coin::Coin<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 6);
        assert!(arg1.active, 3);
        assert!(arg1.player == 0x2::tx_context::sender(arg3), 0);
        assert!(0x2::coin::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg2) == arg1.bet, 1);
        assert!(arg1.bet * 2 <= 0x2::balance::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg0.prize_pool) * 2000 / 10000, 4);
        0x2::balance::join<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&mut arg0.prize_pool, 0x2::coin::into_balance<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(arg2));
        arg1.doubled = true;
    }

    public entry fun execute_emergency_withdraw(arg0: &AdminCap, arg1: &mut GameState, arg2: PendingWithdrawal, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg3) >= arg2.not_before, 7);
        let PendingWithdrawal {
            id         : v0,
            amount     : v1,
            not_before : _,
        } = arg2;
        0x2::object::delete(v0);
        let v3 = 0x2::balance::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg1.prize_pool);
        let v4 = if (v1 > v3) {
            v3
        } else {
            v1
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>>(0x2::coin::from_balance<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(0x2::balance::split<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&mut arg1.prize_pool, v4), arg4), 0x2::tx_context::sender(arg4));
        let v5 = WithdrawExecuted{
            amount     : v4,
            pool_after : 0x2::balance::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg1.prize_pool),
        };
        0x2::event::emit<WithdrawExecuted>(v5);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = GameState{
            id           : 0x2::object::new(arg0),
            prize_pool   : 0x2::balance::zero<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(),
            min_bet      : 10000000000000,
            paused       : false,
            total_hands  : 0,
            total_volume : 0,
            jackpots_hit : 0,
        };
        0x2::transfer::share_object<GameState>(v1);
    }

    public entry fun initiate_emergency_withdraw(arg0: &AdminCap, arg1: &GameState, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= 0x2::balance::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg1.prize_pool) * 1000 / 10000, 4);
        let v0 = 0x2::clock::timestamp_ms(arg3) + 172800000;
        let v1 = WithdrawInitiated{
            amount     : arg2,
            not_before : v0,
        };
        0x2::event::emit<WithdrawInitiated>(v1);
        let v2 = PendingWithdrawal{
            id         : 0x2::object::new(arg4),
            amount     : arg2,
            not_before : v0,
        };
        0x2::transfer::transfer<PendingWithdrawal>(v2, 0x2::tx_context::sender(arg4));
    }

    public fun is_paused(arg0: &GameState) : bool {
        arg0.paused
    }

    public fun min_bet(arg0: &GameState) : u64 {
        arg0.min_bet
    }

    public entry fun place_bet(arg0: &mut GameState, arg1: 0x2::coin::Coin<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 6);
        let v0 = 0x2::coin::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg1);
        assert!(v0 >= arg0.min_bet, 1);
        let v1 = 0x2::balance::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg0.prize_pool);
        if (v1 > 0) {
            assert!(v0 <= v1 * 2000 / 10000, 4);
        };
        0x2::balance::join<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&mut arg0.prize_pool, 0x2::coin::into_balance<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(arg1));
        let v2 = GameSession{
            id         : 0x2::object::new(arg3),
            player     : 0x2::tx_context::sender(arg3),
            bet        : v0,
            doubled    : false,
            active     : true,
            created_at : 0x2::clock::timestamp_ms(arg2),
        };
        let v3 = BetPlaced{
            session_id : 0x2::object::id<GameSession>(&v2),
            player     : 0x2::tx_context::sender(arg3),
            bet        : v0,
        };
        0x2::event::emit<BetPlaced>(v3);
        0x2::transfer::transfer<GameSession>(v2, 0x2::tx_context::sender(arg3));
    }

    public fun pool_size(arg0: &GameState) : u64 {
        0x2::balance::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg0.prize_pool)
    }

    public entry fun receive_pool_donation(arg0: &mut GameState, arg1: 0x2::transfer::Receiving<0x2::coin::Coin<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::transfer::public_receive<0x2::coin::Coin<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>>(&mut arg0.id, arg1);
        0x2::balance::join<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&mut arg0.prize_pool, 0x2::coin::into_balance<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(v0));
        let v1 = PoolDeposited{
            depositor  : 0x2::tx_context::sender(arg2),
            amount     : 0x2::coin::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&v0),
            pool_after : 0x2::balance::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg0.prize_pool),
        };
        0x2::event::emit<PoolDeposited>(v1);
    }

    public entry fun set_min_bet(arg0: &AdminCap, arg1: &mut GameState, arg2: u64) {
        arg1.min_bet = arg2;
        let v0 = MinBetUpdated{
            old_min : arg1.min_bet,
            new_min : arg2,
        };
        0x2::event::emit<MinBetUpdated>(v0);
    }

    public entry fun set_paused(arg0: &AdminCap, arg1: &mut GameState, arg2: bool) {
        arg1.paused = arg2;
    }

    public entry fun settle(arg0: &AdminCap, arg1: &mut GameState, arg2: GameSession, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.active, 3);
        assert!(arg3 <= 6, 5);
        let GameSession {
            id         : v0,
            player     : v1,
            bet        : v2,
            doubled    : v3,
            active     : _,
            created_at : _,
        } = arg2;
        let v6 = v0;
        let v7 = 0x2::object::uid_to_inner(&v6);
        0x2::object::delete(v6);
        let v8 = if (v3) {
            v2 * 2
        } else {
            v2
        };
        arg1.total_hands = arg1.total_hands + 1;
        arg1.total_volume = arg1.total_volume + v8;
        let v9 = if (arg3 == 0 || arg3 == 5) {
            0
        } else if (arg3 == 3) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>>(0x2::coin::from_balance<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(0x2::balance::split<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&mut arg1.prize_pool, v8), arg4), v1);
            v8
        } else if (arg3 == 1 || arg3 == 4) {
            let v10 = v8 + v8 * 9000 / 10000;
            assert!(0x2::balance::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg1.prize_pool) >= v10, 4);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>>(0x2::coin::from_balance<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(0x2::balance::split<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&mut arg1.prize_pool, v10), arg4), v1);
            v10
        } else if (arg3 == 2) {
            let v11 = v8 + v8 * 15000 / 10000;
            assert!(0x2::balance::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg1.prize_pool) >= v11, 4);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>>(0x2::coin::from_balance<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(0x2::balance::split<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&mut arg1.prize_pool, v11), arg4), v1);
            v11
        } else {
            let v12 = capped_jackpot(0x2::balance::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg1.prize_pool));
            if (v12 > 0) {
                arg1.jackpots_hit = arg1.jackpots_hit + 1;
                let v13 = JackpotHit{
                    session_id : v7,
                    player     : v1,
                    bet        : v8,
                    payout     : v12,
                };
                0x2::event::emit<JackpotHit>(v13);
                0x2::transfer::public_transfer<0x2::coin::Coin<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>>(0x2::coin::from_balance<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(0x2::balance::split<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&mut arg1.prize_pool, v12), arg4), v1);
            };
            v12
        };
        let v14 = HandSettled{
            session_id : v7,
            player     : v1,
            bet        : v8,
            doubled    : v3,
            result     : arg3,
            payout     : v9,
            pool_after : 0x2::balance::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg1.prize_pool),
        };
        0x2::event::emit<HandSettled>(v14);
    }

    public entry fun spin(arg0: &mut GameState, arg1: 0x2::coin::Coin<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 6);
        let v0 = 0x2::coin::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg1);
        assert!(v0 >= 10000000000000, 1);
        assert!(v0 <= 1844674407370955161, 10);
        0x2::balance::join<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&mut arg0.prize_pool, 0x2::coin::into_balance<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(arg1));
        let v1 = 0x2::random::new_generator(arg2, arg3);
        let v2 = x"000101020203030404050506";
        let v3 = *0x1::vector::borrow<u8>(&v2, (0x2::random::generate_u8_in_range(&mut v1, 0, 11) as u64));
        let v4 = *0x1::vector::borrow<u8>(&v2, (0x2::random::generate_u8_in_range(&mut v1, 0, 11) as u64));
        let v5 = *0x1::vector::borrow<u8>(&v2, (0x2::random::generate_u8_in_range(&mut v1, 0, 11) as u64));
        let (v6, v7) = if (v3 == v4 && v4 == v5) {
            if (v3 == 0) {
                let v8 = capped_jackpot(0x2::balance::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg0.prize_pool));
                if (v8 > 0) {
                    arg0.jackpots_hit = arg0.jackpots_hit + 1;
                };
                (v8, 4)
            } else if (v3 == 6) {
                (v0 * 20, 3)
            } else if (v3 == 5 || v3 == 4) {
                (v0 * 5, 2)
            } else {
                (v0 * 2, 1)
            }
        } else {
            let v9 = if (v3 == v4) {
                true
            } else if (v4 == v5) {
                true
            } else {
                v3 == v5
            };
            let v10 = if (v9) {
                if (v3 == 0) {
                    true
                } else if (v4 == 0) {
                    true
                } else {
                    v5 == 0
                }
            } else {
                false
            };
            if (v10) {
                (v0 * 2, 1)
            } else {
                (0, 0)
            }
        };
        if (v6 > 0) {
            let v11 = 0x2::balance::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg0.prize_pool);
            let v12 = if (v6 > v11) {
                v11
            } else {
                v6
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>>(0x2::coin::from_balance<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(0x2::balance::split<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&mut arg0.prize_pool, v12), arg3), 0x2::tx_context::sender(arg3));
        };
        arg0.total_hands = arg0.total_hands + 1;
        arg0.total_volume = arg0.total_volume + v0;
        let v13 = SpinResult{
            player     : 0x2::tx_context::sender(arg3),
            wager      : v0,
            reel0      : v3,
            reel1      : v4,
            reel2      : v5,
            result     : v7,
            payout     : v6,
            pool_after : 0x2::balance::value<0x618e05f8e7405d63339ddade6d5e64887651b5dde73453e53f92c5be7b93ce3c::jui_on_sui::JUI_ON_SUI>(&arg0.prize_pool),
        };
        0x2::event::emit<SpinResult>(v13);
    }

    public fun total_hands(arg0: &GameState) : u64 {
        arg0.total_hands
    }

    // decompiled from Move bytecode v7
}

