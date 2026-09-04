module 0x99d3caafe2e4a26d6f8da03773a672190c13da099c1715aac789254046db99f4::casino {
    struct House has key {
        id: 0x2::object::UID,
        vault: 0x2::balance::Balance<0x2::sui::SUI>,
        min_bet: u64,
        max_bet: u64,
        max_payout_bps: u64,
        paused: bool,
        round: u64,
    }

    struct JasonHouse has key {
        id: 0x2::object::UID,
        vault: 0x2::balance::Balance<0x4ddca40b10ff92ccaa1b1797b14dc63ad15e0c87cb7b5669af9bdc49e11e8dab::suipump::SUIPUMP>,
        min_bet: u64,
        max_bet: u64,
        max_payout_bps: u64,
        paused: bool,
        round: u64,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct RevenueConfig has key {
        id: 0x2::object::UID,
        recipient: address,
        fee_bps: u64,
    }

    struct BlackjackSession has key {
        id: 0x2::object::UID,
        player: address,
        stake: 0x2::balance::Balance<0x2::sui::SUI>,
        wager: u64,
        player_cards: vector<u8>,
        dealer_cards: vector<u8>,
        status: u8,
    }

    struct JasonBlackjackSession has key {
        id: 0x2::object::UID,
        player: address,
        stake: 0x2::balance::Balance<0x4ddca40b10ff92ccaa1b1797b14dc63ad15e0c87cb7b5669af9bdc49e11e8dab::suipump::SUIPUMP>,
        wager: u64,
        player_cards: vector<u8>,
        dealer_cards: vector<u8>,
        status: u8,
    }

    struct JasonBlackjackTableSeat has store {
        occupied: bool,
        player: address,
        stake: 0x2::balance::Balance<0x4ddca40b10ff92ccaa1b1797b14dc63ad15e0c87cb7b5669af9bdc49e11e8dab::suipump::SUIPUMP>,
        wager: u64,
        player_cards: vector<u8>,
        status: u8,
        result: u8,
        payout: u64,
        fee: u64,
    }

    struct JasonBlackjackTable has key {
        id: 0x2::object::UID,
        host: address,
        phase: u8,
        round: u64,
        dealer_cards: vector<u8>,
        dealer_resolved: bool,
        seats: vector<JasonBlackjackTableSeat>,
    }

    struct PlayEvent has copy, drop {
        player: address,
        game: u8,
        outcome: u64,
        stake: u64,
        payout: u64,
        won: bool,
        round: u64,
    }

    struct RevenueEvent has copy, drop {
        player: address,
        recipient: address,
        game: u8,
        stake: u64,
        fee: u64,
        round: u64,
    }

    struct BlackjackOpenedEvent has copy, drop {
        session_id: 0x2::object::ID,
        player: address,
        stake: u64,
        player_total: u64,
        dealer_up_card: u8,
    }

    struct BlackjackActionEvent has copy, drop {
        session_id: 0x2::object::ID,
        player: address,
        action: u8,
        card: u8,
        player_total: u64,
        dealer_total: u64,
        status: u8,
    }

    struct BlackjackSettledEvent has copy, drop {
        session_id: 0x2::object::ID,
        player: address,
        stake: u64,
        player_total: u64,
        dealer_total: u64,
        result: u8,
        payout: u64,
        fee: u64,
        round: u64,
    }

    struct JasonBlackjackTableCreatedEvent has copy, drop {
        table_id: 0x2::object::ID,
        host: address,
    }

    struct JasonBlackjackTableJoinedEvent has copy, drop {
        table_id: 0x2::object::ID,
        round: u64,
        seat: u8,
        player: address,
        stake: u64,
    }

    struct JasonBlackjackTableStartedEvent has copy, drop {
        table_id: 0x2::object::ID,
        round: u64,
        seat_count: u8,
        dealer_up_card: u8,
    }

    struct JasonBlackjackTableActionEvent has copy, drop {
        table_id: 0x2::object::ID,
        round: u64,
        seat: u8,
        player: address,
        action: u8,
        card: u8,
        player_total: u64,
        dealer_total: u64,
        status: u8,
    }

    struct JasonBlackjackTableSettledEvent has copy, drop {
        table_id: 0x2::object::ID,
        round: u64,
        seat: u8,
        player: address,
        stake: u64,
        player_total: u64,
        dealer_total: u64,
        result: u8,
        payout: u64,
        fee: u64,
    }

    struct JasonBlackjackTableCancelledEvent has copy, drop {
        table_id: 0x2::object::ID,
        host: address,
        round: u64,
    }

    struct HouseWithdrawalEvent has copy, drop {
        recipient: address,
        amount: u64,
    }

    struct DepositEvent has copy, drop {
        amount: u64,
        vault_balance: u64,
    }

    struct PauseChangeEvent has copy, drop {
        old_paused: bool,
        new_paused: bool,
    }

    struct LimitChangeEvent has copy, drop {
        old_min_bet: u64,
        old_max_bet: u64,
        old_max_payout_bps: u64,
        new_min_bet: u64,
        new_max_bet: u64,
        new_max_payout_bps: u64,
    }

    struct JasonDepositEvent has copy, drop {
        amount: u64,
        vault_balance: u64,
    }

    struct JasonPauseChangeEvent has copy, drop {
        old_paused: bool,
        new_paused: bool,
    }

    struct JasonLimitChangeEvent has copy, drop {
        old_min_bet: u64,
        old_max_bet: u64,
        old_max_payout_bps: u64,
        new_min_bet: u64,
        new_max_bet: u64,
        new_max_payout_bps: u64,
    }

    fun blackjack_card_value(arg0: u8) : u64 {
        if (arg0 == 1) {
            11
        } else if (arg0 >= 10) {
            10
        } else {
            (arg0 as u64)
        }
    }

    fun blackjack_draw(arg0: &mut 0x2::random::RandomGenerator) : u8 {
        0x2::random::generate_u8_in_range(arg0, 1, 13)
    }

    fun blackjack_hand_total(arg0: &vector<u8>) : u64 {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(arg0)) {
            let v3 = *0x1::vector::borrow<u8>(arg0, v2);
            v0 = v0 + blackjack_card_value(v3);
            if (v3 == 1) {
                v1 = v1 + 1;
            };
            v2 = v2 + 1;
        };
        while (v0 > 21 && v1 > 0) {
            v0 = v0 - 10;
            v1 = v1 - 1;
        };
        v0
    }

    fun blackjack_result(arg0: &vector<u8>, arg1: u64, arg2: &vector<u8>, arg3: u64) : u8 {
        let v0 = 0x1::vector::length<u8>(arg0) == 2 && arg1 == 21;
        let v1 = 0x1::vector::length<u8>(arg2) == 2 && arg3 == 21;
        if (v0 && !v1) {
            3
        } else if (arg1 > 21) {
            0
        } else if (arg3 > 21 || arg1 > arg3) {
            1
        } else if (arg1 == arg3) {
            2
        } else {
            0
        }
    }

    fun blackjack_total(arg0: u8, arg1: u8) : u64 {
        let v0 = blackjack_card_value(arg0) + blackjack_card_value(arg1);
        let v1 = if (arg0 == 1) {
            1
        } else {
            0
        };
        let v2 = v1;
        if (arg1 == 1) {
            v2 = v1 + 1;
        };
        while (v0 > 21 && v2 > 0) {
            v0 = v0 - 10;
            v2 = v2 - 1;
        };
        v0
    }

    public entry fun cancel_jason_blackjack_table(arg0: &mut JasonBlackjackTable, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(arg0.phase == 0, 8);
        assert!(v0 == arg0.host, 9);
        let v1 = 0;
        while (v1 < 0x1::vector::length<JasonBlackjackTableSeat>(&arg0.seats)) {
            let v2 = 0x1::vector::borrow_mut<JasonBlackjackTableSeat>(&mut arg0.seats, v1);
            if (v2.occupied) {
                v2.occupied = false;
                v2.status = 1;
                0x2::transfer::public_transfer<0x2::coin::Coin<0x4ddca40b10ff92ccaa1b1797b14dc63ad15e0c87cb7b5669af9bdc49e11e8dab::suipump::SUIPUMP>>(0x2::coin::from_balance<0x4ddca40b10ff92ccaa1b1797b14dc63ad15e0c87cb7b5669af9bdc49e11e8dab::suipump::SUIPUMP>(0x2::balance::withdraw_all<0x4ddca40b10ff92ccaa1b1797b14dc63ad15e0c87cb7b5669af9bdc49e11e8dab::suipump::SUIPUMP>(&mut v2.stake), arg1), v2.player);
            };
            v1 = v1 + 1;
        };
        arg0.phase = 2;
        let v3 = JasonBlackjackTableCancelledEvent{
            table_id : 0x2::object::uid_to_inner(&arg0.id),
            host     : v0,
            round    : arg0.round,
        };
        0x2::event::emit<JasonBlackjackTableCancelledEvent>(v3);
    }

    public entry fun create_jason_blackjack_table(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = JasonBlackjackTable{
            id              : 0x2::object::new(arg0),
            host            : v0,
            phase           : 0,
            round           : 0,
            dealer_cards    : 0x1::vector::empty<u8>(),
            dealer_resolved : false,
            seats           : 0x1::vector::empty<JasonBlackjackTableSeat>(),
        };
        let v2 = JasonBlackjackTableCreatedEvent{
            table_id : 0x2::object::uid_to_inner(&v1.id),
            host     : v0,
        };
        0x2::event::emit<JasonBlackjackTableCreatedEvent>(v2);
        0x2::transfer::share_object<JasonBlackjackTable>(v1);
    }

    public entry fun create_jason_house(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = JasonHouse{
            id             : 0x2::object::new(arg1),
            vault          : 0x2::balance::zero<0x4ddca40b10ff92ccaa1b1797b14dc63ad15e0c87cb7b5669af9bdc49e11e8dab::suipump::SUIPUMP>(),
            min_bet        : 1000000,
            max_bet        : 10000000000,
            max_payout_bps : 500,
            paused         : true,
            round          : 0,
        };
        0x2::transfer::share_object<JasonHouse>(v0);
    }

    public entry fun create_revenue_config(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = RevenueConfig{
            id        : 0x2::object::new(arg1),
            recipient : @0xd2cebe8666352e1ddb3dc7f271340432c983fc81017b3d6f7873dd66881433a4,
            fee_bps   : 250,
        };
        0x2::transfer::share_object<RevenueConfig>(v0);
    }

    public entry fun deposit(arg0: &mut House, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &AdminCap) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.vault, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v0 = DepositEvent{
            amount        : 0x2::coin::value<0x2::sui::SUI>(&arg1),
            vault_balance : 0x2::balance::value<0x2::sui::SUI>(&arg0.vault),
        };
        0x2::event::emit<DepositEvent>(v0);
    }

    public entry fun deposit_jason(arg0: &mut JasonHouse, arg1: 0x2::coin::Coin<0x4ddca40b10ff92ccaa1b1797b14dc63ad15e0c87cb7b5669af9bdc49e11e8dab::suipump::SUIPUMP>, arg2: &AdminCap) {
        0x2::balance::join<0x4ddca40b10ff92ccaa1b1797b14dc63ad15e0c87cb7b5669af9bdc49e11e8dab::suipump::SUIPUMP>(&mut arg0.vault, 0x2::coin::into_balance<0x4ddca40b10ff92ccaa1b1797b14dc63ad15e0c87cb7b5669af9bdc49e11e8dab::suipump::SUIPUMP>(arg1));
        let v0 = JasonDepositEvent{
            amount        : 0x2::coin::value<0x4ddca40b10ff92ccaa1b1797b14dc63ad15e0c87cb7b5669af9bdc49e11e8dab::suipump::SUIPUMP>(&arg1),
            vault_balance : 0x2::balance::value<0x4ddca40b10ff92ccaa1b1797b14dc63ad15e0c87cb7b5669af9bdc49e11e8dab::suipump::SUIPUMP>(&arg0.vault),
        };
        0x2::event::emit<JasonDepositEvent>(v0);
    }

    fun dice_payout(arg0: u8, arg1: bool) : u64 {
        let v0 = if (arg1) {
            100 - arg0
        } else {
            arg0
        };
        9800 / (v0 as u64)
    }

    public entry fun forfeit_blackjack(arg0: BlackjackSession, arg1: &mut House, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.player == 0x2::tx_context::sender(arg2), 1);
        assert!(arg0.status == 0, 1);
        arg0.status = 2;
        forfeit_blackjack_sui(arg0, arg1, blackjack_hand_total(&arg0.player_cards), blackjack_hand_total(&arg0.dealer_cards), arg2);
    }

    fun forfeit_blackjack_sui(arg0: BlackjackSession, arg1: &mut House, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let BlackjackSession {
            id           : v0,
            player       : v1,
            stake        : v2,
            wager        : v3,
            player_cards : _,
            dealer_cards : _,
            status       : _,
        } = arg0;
        let v7 = v0;
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.vault, v2);
        arg1.round = arg1.round + 1;
        0x2::object::delete(v7);
        let v8 = BlackjackSettledEvent{
            session_id   : 0x2::object::uid_to_inner(&v7),
            player       : v1,
            stake        : v3,
            player_total : arg2,
            dealer_total : arg3,
            result       : 4,
            payout       : 0,
            fee          : 0,
            round        : arg1.round,
        };
        0x2::event::emit<BlackjackSettledEvent>(v8);
    }

    public entry fun forfeit_jason_blackjack(arg0: JasonBlackjackSession, arg1: &mut JasonHouse, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.player == 0x2::tx_context::sender(arg2), 1);
        assert!(arg0.status == 0, 1);
        let JasonBlackjackSession {
            id           : v0,
            player       : v1,
            stake        : v2,
            wager        : v3,
            player_cards : v4,
            dealer_cards : v5,
            status       : _,
        } = arg0;
        let v7 = v5;
        let v8 = v4;
        let v9 = v0;
        0x2::balance::join<0x4ddca40b10ff92ccaa1b1797b14dc63ad15e0c87cb7b5669af9bdc49e11e8dab::suipump::SUIPUMP>(&mut arg1.vault, v2);
        arg1.round = arg1.round + 1;
        0x2::object::delete(v9);
        let v10 = BlackjackSettledEvent{
            session_id   : 0x2::object::uid_to_inner(&v9),
            player       : v1,
            stake        : v3,
            player_total : blackjack_hand_total(&v8),
            dealer_total : blackjack_hand_total(&v7),
            result       : 4,
            payout       : 0,
            fee          : 0,
            round        : arg1.round,
        };
        0x2::event::emit<BlackjackSettledEvent>(v10);
    }

    public entry fun forfeit_jason_blackjack_table(arg0: &mut JasonBlackjackTable, arg1: &mut JasonHouse, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = (arg2 as u64);
        assert!(arg0.phase == 1, 8);
        assert!(v0 < 0x1::vector::length<JasonBlackjackTableSeat>(&arg0.seats), 10);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = 0x1::vector::borrow_mut<JasonBlackjackTableSeat>(&mut arg0.seats, v0);
        assert!(v2.occupied && v2.player == v1, 10);
        assert!(v2.status == 0, 11);
        v2.status = 1;
        v2.result = 4;
        0x2::balance::join<0x4ddca40b10ff92ccaa1b1797b14dc63ad15e0c87cb7b5669af9bdc49e11e8dab::suipump::SUIPUMP>(&mut arg1.vault, 0x2::balance::withdraw_all<0x4ddca40b10ff92ccaa1b1797b14dc63ad15e0c87cb7b5669af9bdc49e11e8dab::suipump::SUIPUMP>(&mut v2.stake));
        arg1.round = arg1.round + 1;
        let v3 = JasonBlackjackTableSettledEvent{
            table_id     : 0x2::object::uid_to_inner(&arg0.id),
            round        : arg0.round,
            seat         : arg2,
            player       : v1,
            stake        : v2.wager,
            player_total : blackjack_hand_total(&v2.player_cards),
            dealer_total : blackjack_hand_total(&arg0.dealer_cards),
            result       : 4,
            payout       : 0,
            fee          : 0,
        };
        0x2::event::emit<JasonBlackjackTableSettledEvent>(v3);
    }

    public entry fun hit_blackjack(arg0: BlackjackSession, arg1: &mut House, arg2: &RevenueConfig, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.player == 0x2::tx_context::sender(arg4), 1);
        assert!(arg0.status == 0, 1);
        let v0 = 0x2::random::new_generator(arg3, arg4);
        let v1 = &mut v0;
        let v2 = blackjack_draw(v1);
        0x1::vector::push_back<u8>(&mut arg0.player_cards, v2);
        let v3 = blackjack_hand_total(&arg0.player_cards);
        let v4 = blackjack_hand_total(&arg0.dealer_cards);
        if (v3 > 21) {
            arg0.status = 1;
            let v5 = BlackjackActionEvent{
                session_id   : 0x2::object::uid_to_inner(&arg0.id),
                player       : arg0.player,
                action       : 2,
                card         : v2,
                player_total : v3,
                dealer_total : v4,
                status       : 1,
            };
            0x2::event::emit<BlackjackActionEvent>(v5);
            settle_blackjack_sui(arg0, arg1, arg2, v3, v4, 0, arg4);
        } else {
            let v6 = arg0.player;
            let v7 = BlackjackActionEvent{
                session_id   : 0x2::object::uid_to_inner(&arg0.id),
                player       : v6,
                action       : 0,
                card         : v2,
                player_total : v3,
                dealer_total : v4,
                status       : 0,
            };
            0x2::event::emit<BlackjackActionEvent>(v7);
            0x2::transfer::transfer<BlackjackSession>(arg0, v6);
        };
    }

    public entry fun hit_jason_blackjack(arg0: JasonBlackjackSession, arg1: &mut JasonHouse, arg2: &RevenueConfig, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.player == 0x2::tx_context::sender(arg4), 1);
        assert!(arg0.status == 0, 1);
        let v0 = 0x2::random::new_generator(arg3, arg4);
        let v1 = &mut v0;
        let v2 = blackjack_draw(v1);
        0x1::vector::push_back<u8>(&mut arg0.player_cards, v2);
        let v3 = blackjack_hand_total(&arg0.player_cards);
        let v4 = blackjack_hand_total(&arg0.dealer_cards);
        if (v3 > 21) {
            arg0.status = 1;
            let v5 = BlackjackActionEvent{
                session_id   : 0x2::object::uid_to_inner(&arg0.id),
                player       : arg0.player,
                action       : 2,
                card         : v2,
                player_total : v3,
                dealer_total : v4,
                status       : 1,
            };
            0x2::event::emit<BlackjackActionEvent>(v5);
            settle_blackjack_jason(arg0, arg1, arg2, v3, v4, 0, arg4);
        } else {
            let v6 = arg0.player;
            let v7 = BlackjackActionEvent{
                session_id   : 0x2::object::uid_to_inner(&arg0.id),
                player       : v6,
                action       : 0,
                card         : v2,
                player_total : v3,
                dealer_total : v4,
                status       : 0,
            };
            0x2::event::emit<BlackjackActionEvent>(v7);
            0x2::transfer::transfer<JasonBlackjackSession>(arg0, v6);
        };
    }

    public entry fun hit_jason_blackjack_table(arg0: &mut JasonBlackjackTable, arg1: &mut JasonHouse, arg2: &RevenueConfig, arg3: &0x2::random::Random, arg4: u8, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = (arg4 as u64);
        assert!(arg0.phase == 1, 8);
        assert!(v0 < 0x1::vector::length<JasonBlackjackTableSeat>(&arg0.seats), 10);
        assert!(!arg1.paused, 2);
        assert!(arg2.recipient == @0xd2cebe8666352e1ddb3dc7f271340432c983fc81017b3d6f7873dd66881433a4 && arg2.fee_bps == 250, 7);
        let v1 = 0x2::tx_context::sender(arg5);
        let v2 = 0x1::vector::borrow<JasonBlackjackTableSeat>(&arg0.seats, v0);
        assert!(v2.occupied && v2.player == v1, 10);
        assert!(v2.status == 0, 11);
        let v3 = 0x2::random::new_generator(arg3, arg5);
        let v4 = &mut v3;
        let v5 = blackjack_draw(v4);
        let v6 = false;
        let v7 = 0x1::vector::borrow_mut<JasonBlackjackTableSeat>(&mut arg0.seats, v0);
        0x1::vector::push_back<u8>(&mut v7.player_cards, v5);
        let v8 = blackjack_hand_total(&v7.player_cards);
        if (v8 > 21) {
            v7.status = 1;
            v7.result = 0;
            v6 = true;
        };
        let v9 = blackjack_hand_total(&arg0.dealer_cards);
        let v10 = if (v6) {
            2
        } else {
            0
        };
        let v11 = if (v6) {
            1
        } else {
            0
        };
        let v12 = JasonBlackjackTableActionEvent{
            table_id     : 0x2::object::uid_to_inner(&arg0.id),
            round        : arg0.round,
            seat         : arg4,
            player       : v1,
            action       : v10,
            card         : v5,
            player_total : v8,
            dealer_total : v9,
            status       : v11,
        };
        0x2::event::emit<JasonBlackjackTableActionEvent>(v12);
        if (v6) {
            settle_jason_blackjack_table_seat(arg0, arg1, arg2, v0, v8, v9, 0, arg5);
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = House{
            id             : 0x2::object::new(arg0),
            vault          : 0x2::balance::zero<0x2::sui::SUI>(),
            min_bet        : 1000000,
            max_bet        : 10000000000,
            max_payout_bps : 1960,
            paused         : false,
            round          : 0,
        };
        0x2::transfer::share_object<House>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    fun jackpot_payout(arg0: u8, arg1: u8, arg2: u8) : u64 {
        let v0 = arg0 == arg1 && arg1 == arg2;
        let v1 = if (arg0 == arg1) {
            true
        } else if (arg1 == arg2) {
            true
        } else {
            arg0 == arg2
        };
        let v2 = (arg0 + 1) % 10 == arg1 && (arg1 + 1) % 10 == arg2;
        if (v0 && arg0 == 7) {
            500
        } else if (v0) {
            200
        } else if (v1) {
            50
        } else if (v2) {
            33
        } else {
            0
        }
    }

    public entry fun join_jason_blackjack_table(arg0: &mut JasonBlackjackTable, arg1: &JasonHouse, arg2: &RevenueConfig, arg3: 0x2::coin::Coin<0x4ddca40b10ff92ccaa1b1797b14dc63ad15e0c87cb7b5669af9bdc49e11e8dab::suipump::SUIPUMP>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg0.phase == 0, 8);
        assert!(!arg1.paused, 2);
        assert!(arg2.recipient == @0xd2cebe8666352e1ddb3dc7f271340432c983fc81017b3d6f7873dd66881433a4 && arg2.fee_bps == 250, 7);
        let v1 = 0x1::vector::length<JasonBlackjackTableSeat>(&arg0.seats);
        assert!(v1 < 6, 8);
        let v2 = 0;
        while (v2 < v1) {
            assert!(0x1::vector::borrow<JasonBlackjackTableSeat>(&arg0.seats, v2).player != v0, 8);
            v2 = v2 + 1;
        };
        let v3 = 0x2::coin::value<0x4ddca40b10ff92ccaa1b1797b14dc63ad15e0c87cb7b5669af9bdc49e11e8dab::suipump::SUIPUMP>(&arg3);
        assert!(v3 >= arg1.min_bet && v3 <= arg1.max_bet, 1);
        let v4 = v3 * arg2.fee_bps / 10000;
        assert!(v4 > 0, 1);
        assert!(0x2::balance::value<0x4ddca40b10ff92ccaa1b1797b14dc63ad15e0c87cb7b5669af9bdc49e11e8dab::suipump::SUIPUMP>(&arg1.vault) >= v3 * 250 / 100 + v4, 4);
        let v5 = JasonBlackjackTableSeat{
            occupied     : true,
            player       : v0,
            stake        : 0x2::coin::into_balance<0x4ddca40b10ff92ccaa1b1797b14dc63ad15e0c87cb7b5669af9bdc49e11e8dab::suipump::SUIPUMP>(arg3),
            wager        : v3,
            player_cards : 0x1::vector::empty<u8>(),
            status       : 0,
            result       : 0,
            payout       : 0,
            fee          : 0,
        };
        0x1::vector::push_back<JasonBlackjackTableSeat>(&mut arg0.seats, v5);
        let v6 = JasonBlackjackTableJoinedEvent{
            table_id : 0x2::object::uid_to_inner(&arg0.id),
            round    : arg0.round,
            seat     : (v1 as u8),
            player   : v0,
            stake    : v3,
        };
        0x2::event::emit<JasonBlackjackTableJoinedEvent>(v6);
    }

    public entry fun open_blackjack(arg0: &mut House, arg1: &RevenueConfig, arg2: &0x2::random::Random, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 2);
        assert!(arg1.recipient == @0xd2cebe8666352e1ddb3dc7f271340432c983fc81017b3d6f7873dd66881433a4 && arg1.fee_bps == 250, 7);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        assert!(v0 >= arg0.min_bet && v0 <= arg0.max_bet, 1);
        let v1 = v0 * arg1.fee_bps / 10000;
        assert!(v1 > 0, 1);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.vault) >= v0 * 250 / 100 + v1, 4);
        let v2 = 0x2::tx_context::sender(arg4);
        let v3 = 0x2::random::new_generator(arg2, arg4);
        let v4 = 0x1::vector::empty<u8>();
        let v5 = 0x1::vector::empty<u8>();
        let v6 = &mut v3;
        0x1::vector::push_back<u8>(&mut v4, blackjack_draw(v6));
        let v7 = &mut v3;
        0x1::vector::push_back<u8>(&mut v4, blackjack_draw(v7));
        let v8 = &mut v3;
        0x1::vector::push_back<u8>(&mut v5, blackjack_draw(v8));
        let v9 = &mut v3;
        0x1::vector::push_back<u8>(&mut v5, blackjack_draw(v9));
        let v10 = BlackjackSession{
            id           : 0x2::object::new(arg4),
            player       : v2,
            stake        : 0x2::coin::into_balance<0x2::sui::SUI>(arg3),
            wager        : v0,
            player_cards : v4,
            dealer_cards : v5,
            status       : 0,
        };
        let v11 = BlackjackOpenedEvent{
            session_id     : 0x2::object::uid_to_inner(&v10.id),
            player         : v2,
            stake          : v0,
            player_total   : blackjack_hand_total(&v4),
            dealer_up_card : *0x1::vector::borrow<u8>(&v10.dealer_cards, 0),
        };
        0x2::event::emit<BlackjackOpenedEvent>(v11);
        0x2::transfer::transfer<BlackjackSession>(v10, v2);
    }

    public entry fun open_jason_blackjack(arg0: &mut JasonHouse, arg1: &RevenueConfig, arg2: &0x2::random::Random, arg3: 0x2::coin::Coin<0x4ddca40b10ff92ccaa1b1797b14dc63ad15e0c87cb7b5669af9bdc49e11e8dab::suipump::SUIPUMP>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 2);
        assert!(arg1.recipient == @0xd2cebe8666352e1ddb3dc7f271340432c983fc81017b3d6f7873dd66881433a4 && arg1.fee_bps == 250, 7);
        let v0 = 0x2::coin::value<0x4ddca40b10ff92ccaa1b1797b14dc63ad15e0c87cb7b5669af9bdc49e11e8dab::suipump::SUIPUMP>(&arg3);
        assert!(v0 >= arg0.min_bet && v0 <= arg0.max_bet, 1);
        let v1 = v0 * arg1.fee_bps / 10000;
        assert!(v1 > 0, 1);
        assert!(0x2::balance::value<0x4ddca40b10ff92ccaa1b1797b14dc63ad15e0c87cb7b5669af9bdc49e11e8dab::suipump::SUIPUMP>(&arg0.vault) >= v0 * 250 / 100 + v1, 4);
        let v2 = 0x2::tx_context::sender(arg4);
        let v3 = 0x2::random::new_generator(arg2, arg4);
        let v4 = 0x1::vector::empty<u8>();
        let v5 = 0x1::vector::empty<u8>();
        let v6 = &mut v3;
        0x1::vector::push_back<u8>(&mut v4, blackjack_draw(v6));
        let v7 = &mut v3;
        0x1::vector::push_back<u8>(&mut v4, blackjack_draw(v7));
        let v8 = &mut v3;
        0x1::vector::push_back<u8>(&mut v5, blackjack_draw(v8));
        let v9 = &mut v3;
        0x1::vector::push_back<u8>(&mut v5, blackjack_draw(v9));
        let v10 = JasonBlackjackSession{
            id           : 0x2::object::new(arg4),
            player       : v2,
            stake        : 0x2::coin::into_balance<0x4ddca40b10ff92ccaa1b1797b14dc63ad15e0c87cb7b5669af9bdc49e11e8dab::suipump::SUIPUMP>(arg3),
            wager        : v0,
            player_cards : v4,
            dealer_cards : v5,
            status       : 0,
        };
        let v11 = BlackjackOpenedEvent{
            session_id     : 0x2::object::uid_to_inner(&v10.id),
            player         : v2,
            stake          : v0,
            player_total   : blackjack_hand_total(&v4),
            dealer_up_card : *0x1::vector::borrow<u8>(&v10.dealer_cards, 0),
        };
        0x2::event::emit<BlackjackOpenedEvent>(v11);
        0x2::transfer::transfer<JasonBlackjackSession>(v10, v2);
    }

    public entry fun play(arg0: &mut House, arg1: &0x2::random::Random, arg2: u8, arg3: u8, arg4: bool, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &mut 0x2::tx_context::TxContext) {
        abort 2
    }

    entry fun play_jason_with_revenue(arg0: &mut JasonHouse, arg1: &RevenueConfig, arg2: &0x2::random::Random, arg3: u8, arg4: u8, arg5: bool, arg6: 0x2::coin::Coin<0x4ddca40b10ff92ccaa1b1797b14dc63ad15e0c87cb7b5669af9bdc49e11e8dab::suipump::SUIPUMP>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 2);
        assert!(arg1.recipient == @0xd2cebe8666352e1ddb3dc7f271340432c983fc81017b3d6f7873dd66881433a4 && arg1.fee_bps == 250, 7);
        let v0 = 0x2::coin::value<0x4ddca40b10ff92ccaa1b1797b14dc63ad15e0c87cb7b5669af9bdc49e11e8dab::suipump::SUIPUMP>(&arg6);
        assert!(v0 >= arg0.min_bet && v0 <= arg0.max_bet, 1);
        assert!(arg3 <= 4, 0);
        if (arg3 == 2) {
            assert!(arg4 >= 5 && arg4 <= 95, 3);
        } else if (arg3 == 4) {
            assert!(arg4 <= 2, 3);
        };
        let v1 = v0 * arg1.fee_bps / 10000;
        assert!(v1 > 0, 1);
        assert!(0x2::balance::value<0x4ddca40b10ff92ccaa1b1797b14dc63ad15e0c87cb7b5669af9bdc49e11e8dab::suipump::SUIPUMP>(&arg0.vault) >= v0 * worst_case_payout_bps(arg3, arg4, arg5, arg0.max_payout_bps) / 100 + v1, 4);
        0x2::balance::join<0x4ddca40b10ff92ccaa1b1797b14dc63ad15e0c87cb7b5669af9bdc49e11e8dab::suipump::SUIPUMP>(&mut arg0.vault, 0x2::coin::into_balance<0x4ddca40b10ff92ccaa1b1797b14dc63ad15e0c87cb7b5669af9bdc49e11e8dab::suipump::SUIPUMP>(arg6));
        let v2 = 0x2::random::new_generator(arg2, arg7);
        let v3 = &mut v2;
        let (v4, v5, v6) = resolve_round(v3, arg3, arg4, arg5);
        let v7 = if (v6 > arg0.max_payout_bps) {
            arg0.max_payout_bps
        } else {
            v6
        };
        let v8 = if (v5) {
            v0 * v7 / 100
        } else {
            0
        };
        let v9 = 0x2::balance::value<0x4ddca40b10ff92ccaa1b1797b14dc63ad15e0c87cb7b5669af9bdc49e11e8dab::suipump::SUIPUMP>(&arg0.vault);
        assert!(v8 <= v9, 4);
        assert!(v1 <= v9 - v8, 4);
        arg0.round = arg0.round + 1;
        if (v8 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x4ddca40b10ff92ccaa1b1797b14dc63ad15e0c87cb7b5669af9bdc49e11e8dab::suipump::SUIPUMP>>(0x2::coin::from_balance<0x4ddca40b10ff92ccaa1b1797b14dc63ad15e0c87cb7b5669af9bdc49e11e8dab::suipump::SUIPUMP>(0x2::balance::split<0x4ddca40b10ff92ccaa1b1797b14dc63ad15e0c87cb7b5669af9bdc49e11e8dab::suipump::SUIPUMP>(&mut arg0.vault, v8), arg7), 0x2::tx_context::sender(arg7));
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x4ddca40b10ff92ccaa1b1797b14dc63ad15e0c87cb7b5669af9bdc49e11e8dab::suipump::SUIPUMP>>(0x2::coin::from_balance<0x4ddca40b10ff92ccaa1b1797b14dc63ad15e0c87cb7b5669af9bdc49e11e8dab::suipump::SUIPUMP>(0x2::balance::split<0x4ddca40b10ff92ccaa1b1797b14dc63ad15e0c87cb7b5669af9bdc49e11e8dab::suipump::SUIPUMP>(&mut arg0.vault, v1), arg7), arg1.recipient);
        let v10 = PlayEvent{
            player  : 0x2::tx_context::sender(arg7),
            game    : arg3,
            outcome : v4,
            stake   : v0,
            payout  : v8,
            won     : v5,
            round   : arg0.round,
        };
        0x2::event::emit<PlayEvent>(v10);
        let v11 = RevenueEvent{
            player    : 0x2::tx_context::sender(arg7),
            recipient : arg1.recipient,
            game      : arg3,
            stake     : v0,
            fee       : v1,
            round     : arg0.round,
        };
        0x2::event::emit<RevenueEvent>(v11);
    }

    entry fun play_with_revenue(arg0: &mut House, arg1: &RevenueConfig, arg2: &0x2::random::Random, arg3: u8, arg4: u8, arg5: bool, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 2);
        assert!(arg1.recipient == @0xd2cebe8666352e1ddb3dc7f271340432c983fc81017b3d6f7873dd66881433a4 && arg1.fee_bps == 250, 7);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg6);
        assert!(v0 >= arg0.min_bet && v0 <= arg0.max_bet, 1);
        assert!(arg3 <= 4, 0);
        if (arg3 == 2) {
            assert!(arg4 >= 5 && arg4 <= 95, 3);
        } else if (arg3 == 4) {
            assert!(arg4 <= 2, 3);
        };
        let v1 = v0 * arg1.fee_bps / 10000;
        assert!(v1 > 0, 1);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.vault) >= v0 * worst_case_payout_bps(arg3, arg4, arg5, arg0.max_payout_bps) / 100 + v1, 4);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.vault, 0x2::coin::into_balance<0x2::sui::SUI>(arg6));
        let v2 = 0x2::random::new_generator(arg2, arg7);
        let v3 = &mut v2;
        let (v4, v5, v6) = resolve_round(v3, arg3, arg4, arg5);
        let v7 = if (v6 > arg0.max_payout_bps) {
            arg0.max_payout_bps
        } else {
            v6
        };
        let v8 = if (v5) {
            v0 * v7 / 100
        } else {
            0
        };
        let v9 = 0x2::balance::value<0x2::sui::SUI>(&arg0.vault);
        assert!(v8 <= v9, 4);
        assert!(v1 <= v9 - v8, 4);
        arg0.round = arg0.round + 1;
        if (v8 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.vault, v8), arg7), 0x2::tx_context::sender(arg7));
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.vault, v1), arg7), arg1.recipient);
        let v10 = PlayEvent{
            player  : 0x2::tx_context::sender(arg7),
            game    : arg3,
            outcome : v4,
            stake   : v0,
            payout  : v8,
            won     : v5,
            round   : arg0.round,
        };
        0x2::event::emit<PlayEvent>(v10);
        let v11 = RevenueEvent{
            player    : 0x2::tx_context::sender(arg7),
            recipient : arg1.recipient,
            game      : arg3,
            stake     : v0,
            fee       : v1,
            round     : arg0.round,
        };
        0x2::event::emit<RevenueEvent>(v11);
    }

    fun plinko_max_payout_bps(arg0: u8) : u64 {
        if (arg0 == 0) {
            300
        } else {
            500
        }
    }

    fun plinko_payout(arg0: u8, arg1: u8) : u64 {
        if (arg0 == 0) {
            if (arg1 == 0 || arg1 == 8) {
                300
            } else if (arg1 == 1 || arg1 == 7) {
                150
            } else if (arg1 == 2 || arg1 == 6) {
                120
            } else if (arg1 == 3 || arg1 == 5) {
                100
            } else {
                80
            }
        } else if (arg0 == 1) {
            if (arg1 == 0 || arg1 == 8) {
                500
            } else if (arg1 == 1 || arg1 == 7) {
                250
            } else if (arg1 == 2 || arg1 == 6) {
                150
            } else if (arg1 == 3 || arg1 == 5) {
                75
            } else {
                0
            }
        } else if (arg1 == 0 || arg1 == 8) {
            500
        } else if (arg1 == 1 || arg1 == 7) {
            300
        } else if (arg1 == 2 || arg1 == 6) {
            120
        } else {
            0
        }
    }

    fun resolve_blackjack(arg0: &mut 0x2::random::RandomGenerator) : (u64, bool, u64) {
        let v0 = blackjack_total(0x2::random::generate_u8_in_range(arg0, 1, 13), 0x2::random::generate_u8_in_range(arg0, 1, 13));
        let v1 = blackjack_total(0x2::random::generate_u8_in_range(arg0, 1, 13), 0x2::random::generate_u8_in_range(arg0, 1, 13));
        let v2 = v0 <= 21 && (v0 > v1 || v1 > 21);
        let v3 = if (v2) {
            if (v0 == 21) {
                250
            } else {
                200
            }
        } else {
            0
        };
        (v0 * 100 + v1, v2, v3)
    }

    fun resolve_plinko(arg0: &mut 0x2::random::RandomGenerator, arg1: u8) : (u64, bool, u64) {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 8) {
            v0 = v0 + 0x2::random::generate_u8_in_range(arg0, 0, 1);
            v1 = v1 + 1;
        };
        let v2 = plinko_payout(arg1, v0);
        ((arg1 as u64) * 10 + (v0 as u64), v2 > 0, v2)
    }

    fun resolve_round(arg0: &mut 0x2::random::RandomGenerator, arg1: u8, arg2: u8, arg3: bool) : (u64, bool, u64) {
        if (arg1 == 0) {
            let v3 = 0x2::random::generate_u8_in_range(arg0, 0, 9);
            let v4 = 0x2::random::generate_u8_in_range(arg0, 0, 9);
            let v5 = 0x2::random::generate_u8_in_range(arg0, 0, 9);
            let v6 = jackpot_payout(v3, v4, v5);
            ((v3 as u64) * 100 + (v4 as u64) * 10 + (v5 as u64), v6 > 0, v6)
        } else {
            let (v7, v8, v9) = if (arg1 == 1) {
                let v10 = 0x2::random::generate_u8_in_range(arg0, 0, 11);
                let v11 = wheel_payout(v10);
                (v11, (v10 as u64), v11 > 0)
            } else {
                let (v12, v13, v14) = if (arg1 == 2) {
                    let v15 = 0x2::random::generate_u8_in_range(arg0, 1, 100);
                    let v16 = arg3 && v15 > arg2 || v15 <= arg2;
                    ((v15 as u64), v16, dice_payout(arg2, arg3))
                } else if (arg1 == 3) {
                    resolve_blackjack(arg0)
                } else {
                    resolve_plinko(arg0, arg2)
                };
                (v14, v12, v13)
            };
            (v8, v9, v7)
        }
    }

    fun revenue_fee_for_test(arg0: u64) : u64 {
        arg0 * 250 / 10000
    }

    public entry fun set_jason_limits(arg0: &mut JasonHouse, arg1: u64, arg2: u64, arg3: u64, arg4: &AdminCap) {
        let v0 = if (arg1 >= 1000000) {
            if (arg2 >= arg1) {
                if (arg2 <= 10000000000) {
                    if (arg3 > 0) {
                        arg3 <= 2500
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 5);
        arg0.min_bet = arg1;
        arg0.max_bet = arg2;
        arg0.max_payout_bps = arg3;
        let v1 = JasonLimitChangeEvent{
            old_min_bet        : arg0.min_bet,
            old_max_bet        : arg0.max_bet,
            old_max_payout_bps : arg0.max_payout_bps,
            new_min_bet        : arg1,
            new_max_bet        : arg2,
            new_max_payout_bps : arg3,
        };
        0x2::event::emit<JasonLimitChangeEvent>(v1);
    }

    public entry fun set_jason_paused(arg0: &mut JasonHouse, arg1: bool, arg2: &AdminCap) {
        let v0 = arg0.paused;
        arg0.paused = arg1;
        if (v0 != arg1) {
            let v1 = JasonPauseChangeEvent{
                old_paused : v0,
                new_paused : arg1,
            };
            0x2::event::emit<JasonPauseChangeEvent>(v1);
        };
    }

    public entry fun set_limits(arg0: &mut House, arg1: u64, arg2: u64, arg3: u64, arg4: &AdminCap) {
        let v0 = if (arg1 >= 1000000) {
            if (arg2 >= arg1) {
                if (arg2 <= 100000000000) {
                    if (arg3 > 0) {
                        arg3 <= 2500
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 5);
        arg0.min_bet = arg1;
        arg0.max_bet = arg2;
        arg0.max_payout_bps = arg3;
        let v1 = LimitChangeEvent{
            old_min_bet        : arg0.min_bet,
            old_max_bet        : arg0.max_bet,
            old_max_payout_bps : arg0.max_payout_bps,
            new_min_bet        : arg1,
            new_max_bet        : arg2,
            new_max_payout_bps : arg3,
        };
        0x2::event::emit<LimitChangeEvent>(v1);
    }

    public entry fun set_paused(arg0: &mut House, arg1: bool, arg2: &AdminCap) {
        let v0 = arg0.paused;
        arg0.paused = arg1;
        if (v0 != arg1) {
            let v1 = PauseChangeEvent{
                old_paused : v0,
                new_paused : arg1,
            };
            0x2::event::emit<PauseChangeEvent>(v1);
        };
    }

    fun settle_blackjack_jason(arg0: JasonBlackjackSession, arg1: &mut JasonHouse, arg2: &RevenueConfig, arg3: u64, arg4: u64, arg5: u8, arg6: &mut 0x2::tx_context::TxContext) {
        let JasonBlackjackSession {
            id           : v0,
            player       : v1,
            stake        : v2,
            wager        : v3,
            player_cards : _,
            dealer_cards : _,
            status       : _,
        } = arg0;
        let v7 = v0;
        let v8 = v3 * arg2.fee_bps / 10000;
        let v9 = if (arg5 == 3) {
            250
        } else if (arg5 == 1) {
            200
        } else if (arg5 == 2) {
            100
        } else {
            0
        };
        let v10 = v3 * v9 / 100;
        0x2::balance::join<0x4ddca40b10ff92ccaa1b1797b14dc63ad15e0c87cb7b5669af9bdc49e11e8dab::suipump::SUIPUMP>(&mut arg1.vault, v2);
        let v11 = 0x2::balance::value<0x4ddca40b10ff92ccaa1b1797b14dc63ad15e0c87cb7b5669af9bdc49e11e8dab::suipump::SUIPUMP>(&arg1.vault);
        assert!(v10 <= v11 && v8 <= v11 - v10, 4);
        arg1.round = arg1.round + 1;
        if (v10 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x4ddca40b10ff92ccaa1b1797b14dc63ad15e0c87cb7b5669af9bdc49e11e8dab::suipump::SUIPUMP>>(0x2::coin::from_balance<0x4ddca40b10ff92ccaa1b1797b14dc63ad15e0c87cb7b5669af9bdc49e11e8dab::suipump::SUIPUMP>(0x2::balance::split<0x4ddca40b10ff92ccaa1b1797b14dc63ad15e0c87cb7b5669af9bdc49e11e8dab::suipump::SUIPUMP>(&mut arg1.vault, v10), arg6), v1);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x4ddca40b10ff92ccaa1b1797b14dc63ad15e0c87cb7b5669af9bdc49e11e8dab::suipump::SUIPUMP>>(0x2::coin::from_balance<0x4ddca40b10ff92ccaa1b1797b14dc63ad15e0c87cb7b5669af9bdc49e11e8dab::suipump::SUIPUMP>(0x2::balance::split<0x4ddca40b10ff92ccaa1b1797b14dc63ad15e0c87cb7b5669af9bdc49e11e8dab::suipump::SUIPUMP>(&mut arg1.vault, v8), arg6), arg2.recipient);
        0x2::object::delete(v7);
        let v12 = BlackjackSettledEvent{
            session_id   : 0x2::object::uid_to_inner(&v7),
            player       : v1,
            stake        : v3,
            player_total : arg3,
            dealer_total : arg4,
            result       : arg5,
            payout       : v10,
            fee          : v8,
            round        : arg1.round,
        };
        0x2::event::emit<BlackjackSettledEvent>(v12);
        let v13 = RevenueEvent{
            player    : v1,
            recipient : arg2.recipient,
            game      : 3,
            stake     : v3,
            fee       : v8,
            round     : arg1.round,
        };
        0x2::event::emit<RevenueEvent>(v13);
    }

    fun settle_blackjack_sui(arg0: BlackjackSession, arg1: &mut House, arg2: &RevenueConfig, arg3: u64, arg4: u64, arg5: u8, arg6: &mut 0x2::tx_context::TxContext) {
        let BlackjackSession {
            id           : v0,
            player       : v1,
            stake        : v2,
            wager        : v3,
            player_cards : _,
            dealer_cards : _,
            status       : _,
        } = arg0;
        let v7 = v0;
        let v8 = v3 * arg2.fee_bps / 10000;
        let v9 = if (arg5 == 3) {
            250
        } else if (arg5 == 1) {
            200
        } else if (arg5 == 2) {
            100
        } else {
            0
        };
        let v10 = v3 * v9 / 100;
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.vault, v2);
        let v11 = 0x2::balance::value<0x2::sui::SUI>(&arg1.vault);
        assert!(v10 <= v11 && v8 <= v11 - v10, 4);
        arg1.round = arg1.round + 1;
        if (v10 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.vault, v10), arg6), v1);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.vault, v8), arg6), arg2.recipient);
        0x2::object::delete(v7);
        let v12 = BlackjackSettledEvent{
            session_id   : 0x2::object::uid_to_inner(&v7),
            player       : v1,
            stake        : v3,
            player_total : arg3,
            dealer_total : arg4,
            result       : arg5,
            payout       : v10,
            fee          : v8,
            round        : arg1.round,
        };
        0x2::event::emit<BlackjackSettledEvent>(v12);
        let v13 = RevenueEvent{
            player    : v1,
            recipient : arg2.recipient,
            game      : 3,
            stake     : v3,
            fee       : v8,
            round     : arg1.round,
        };
        0x2::event::emit<RevenueEvent>(v13);
    }

    fun settle_jason_blackjack_table_seat(arg0: &mut JasonBlackjackTable, arg1: &mut JasonHouse, arg2: &RevenueConfig, arg3: u64, arg4: u64, arg5: u64, arg6: u8, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::borrow_mut<JasonBlackjackTableSeat>(&mut arg0.seats, arg3);
        let v1 = v0.player;
        let v2 = v0.wager;
        let v3 = v2 * arg2.fee_bps / 10000;
        let v4 = if (arg6 == 3) {
            250
        } else if (arg6 == 1) {
            200
        } else if (arg6 == 2) {
            100
        } else {
            0
        };
        let v5 = v2 * v4 / 100;
        0x2::balance::join<0x4ddca40b10ff92ccaa1b1797b14dc63ad15e0c87cb7b5669af9bdc49e11e8dab::suipump::SUIPUMP>(&mut arg1.vault, 0x2::balance::withdraw_all<0x4ddca40b10ff92ccaa1b1797b14dc63ad15e0c87cb7b5669af9bdc49e11e8dab::suipump::SUIPUMP>(&mut v0.stake));
        let v6 = 0x2::balance::value<0x4ddca40b10ff92ccaa1b1797b14dc63ad15e0c87cb7b5669af9bdc49e11e8dab::suipump::SUIPUMP>(&arg1.vault);
        assert!(v5 <= v6 && v3 <= v6 - v5, 4);
        arg1.round = arg1.round + 1;
        if (v5 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x4ddca40b10ff92ccaa1b1797b14dc63ad15e0c87cb7b5669af9bdc49e11e8dab::suipump::SUIPUMP>>(0x2::coin::from_balance<0x4ddca40b10ff92ccaa1b1797b14dc63ad15e0c87cb7b5669af9bdc49e11e8dab::suipump::SUIPUMP>(0x2::balance::split<0x4ddca40b10ff92ccaa1b1797b14dc63ad15e0c87cb7b5669af9bdc49e11e8dab::suipump::SUIPUMP>(&mut arg1.vault, v5), arg7), v1);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x4ddca40b10ff92ccaa1b1797b14dc63ad15e0c87cb7b5669af9bdc49e11e8dab::suipump::SUIPUMP>>(0x2::coin::from_balance<0x4ddca40b10ff92ccaa1b1797b14dc63ad15e0c87cb7b5669af9bdc49e11e8dab::suipump::SUIPUMP>(0x2::balance::split<0x4ddca40b10ff92ccaa1b1797b14dc63ad15e0c87cb7b5669af9bdc49e11e8dab::suipump::SUIPUMP>(&mut arg1.vault, v3), arg7), arg2.recipient);
        let v7 = 0x1::vector::borrow_mut<JasonBlackjackTableSeat>(&mut arg0.seats, arg3);
        v7.payout = v5;
        v7.fee = v3;
        v7.status = 1;
        v7.result = arg6;
        let v8 = JasonBlackjackTableSettledEvent{
            table_id     : 0x2::object::uid_to_inner(&arg0.id),
            round        : arg0.round,
            seat         : (arg3 as u8),
            player       : v1,
            stake        : v2,
            player_total : arg4,
            dealer_total : arg5,
            result       : arg6,
            payout       : v5,
            fee          : v3,
        };
        0x2::event::emit<JasonBlackjackTableSettledEvent>(v8);
        let v9 = RevenueEvent{
            player    : v1,
            recipient : arg2.recipient,
            game      : 3,
            stake     : v2,
            fee       : v3,
            round     : arg1.round,
        };
        0x2::event::emit<RevenueEvent>(v9);
    }

    public entry fun stand_blackjack(arg0: BlackjackSession, arg1: &mut House, arg2: &RevenueConfig, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.player == 0x2::tx_context::sender(arg4), 1);
        assert!(arg0.status == 0, 1);
        let v0 = blackjack_hand_total(&arg0.player_cards);
        let v1 = 0x2::random::new_generator(arg3, arg4);
        let v2 = blackjack_hand_total(&arg0.dealer_cards);
        while (v2 < 17) {
            let v3 = &mut v1;
            0x1::vector::push_back<u8>(&mut arg0.dealer_cards, blackjack_draw(v3));
            v2 = blackjack_hand_total(&arg0.dealer_cards);
        };
        arg0.status = 1;
        let v4 = BlackjackActionEvent{
            session_id   : 0x2::object::uid_to_inner(&arg0.id),
            player       : arg0.player,
            action       : 1,
            card         : 0,
            player_total : v0,
            dealer_total : v2,
            status       : 1,
        };
        0x2::event::emit<BlackjackActionEvent>(v4);
        settle_blackjack_sui(arg0, arg1, arg2, v0, v2, blackjack_result(&arg0.player_cards, v0, &arg0.dealer_cards, v2), arg4);
    }

    public entry fun stand_jason_blackjack(arg0: JasonBlackjackSession, arg1: &mut JasonHouse, arg2: &RevenueConfig, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.player == 0x2::tx_context::sender(arg4), 1);
        assert!(arg0.status == 0, 1);
        let v0 = blackjack_hand_total(&arg0.player_cards);
        let v1 = 0x2::random::new_generator(arg3, arg4);
        let v2 = blackjack_hand_total(&arg0.dealer_cards);
        while (v2 < 17) {
            let v3 = &mut v1;
            0x1::vector::push_back<u8>(&mut arg0.dealer_cards, blackjack_draw(v3));
            v2 = blackjack_hand_total(&arg0.dealer_cards);
        };
        arg0.status = 1;
        let v4 = BlackjackActionEvent{
            session_id   : 0x2::object::uid_to_inner(&arg0.id),
            player       : arg0.player,
            action       : 1,
            card         : 0,
            player_total : v0,
            dealer_total : v2,
            status       : 1,
        };
        0x2::event::emit<BlackjackActionEvent>(v4);
        settle_blackjack_jason(arg0, arg1, arg2, v0, v2, blackjack_result(&arg0.player_cards, v0, &arg0.dealer_cards, v2), arg4);
    }

    public entry fun stand_jason_blackjack_table(arg0: &mut JasonBlackjackTable, arg1: &mut JasonHouse, arg2: &RevenueConfig, arg3: &0x2::random::Random, arg4: u8, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = (arg4 as u64);
        assert!(arg0.phase == 1, 8);
        assert!(v0 < 0x1::vector::length<JasonBlackjackTableSeat>(&arg0.seats), 10);
        assert!(!arg1.paused, 2);
        assert!(arg2.recipient == @0xd2cebe8666352e1ddb3dc7f271340432c983fc81017b3d6f7873dd66881433a4 && arg2.fee_bps == 250, 7);
        let v1 = 0x2::tx_context::sender(arg5);
        let v2 = 0x1::vector::borrow<JasonBlackjackTableSeat>(&arg0.seats, v0);
        assert!(v2.occupied && v2.player == v1, 10);
        assert!(v2.status == 0, 11);
        if (!arg0.dealer_resolved) {
            let v3 = 0x2::random::new_generator(arg3, arg5);
            let v4 = blackjack_hand_total(&arg0.dealer_cards);
            while (v4 < 17) {
                let v5 = &mut v3;
                0x1::vector::push_back<u8>(&mut arg0.dealer_cards, blackjack_draw(v5));
                v4 = blackjack_hand_total(&arg0.dealer_cards);
            };
            arg0.dealer_resolved = true;
        };
        let v6 = blackjack_hand_total(&0x1::vector::borrow<JasonBlackjackTableSeat>(&arg0.seats, v0).player_cards);
        let v7 = blackjack_hand_total(&arg0.dealer_cards);
        let v8 = blackjack_result(&0x1::vector::borrow<JasonBlackjackTableSeat>(&arg0.seats, v0).player_cards, v6, &arg0.dealer_cards, v7);
        let v9 = 0x1::vector::borrow_mut<JasonBlackjackTableSeat>(&mut arg0.seats, v0);
        v9.status = 1;
        v9.result = v8;
        let v10 = JasonBlackjackTableActionEvent{
            table_id     : 0x2::object::uid_to_inner(&arg0.id),
            round        : arg0.round,
            seat         : arg4,
            player       : v1,
            action       : 1,
            card         : 0,
            player_total : v6,
            dealer_total : v7,
            status       : 1,
        };
        0x2::event::emit<JasonBlackjackTableActionEvent>(v10);
        settle_jason_blackjack_table_seat(arg0, arg1, arg2, v0, v6, v7, v8, arg5);
    }

    public entry fun start_jason_blackjack_table(arg0: &mut JasonBlackjackTable, arg1: &JasonHouse, arg2: &RevenueConfig, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.phase == 0, 8);
        assert!(0x2::tx_context::sender(arg4) == arg0.host, 9);
        assert!(0x1::vector::length<JasonBlackjackTableSeat>(&arg0.seats) > 0, 11);
        assert!(!arg1.paused, 2);
        assert!(arg2.recipient == @0xd2cebe8666352e1ddb3dc7f271340432c983fc81017b3d6f7873dd66881433a4 && arg2.fee_bps == 250, 7);
        let v0 = 0;
        let v1 = 0;
        let v2 = 0x1::vector::length<JasonBlackjackTableSeat>(&arg0.seats);
        while (v1 < v2) {
            let v3 = 0x1::vector::borrow<JasonBlackjackTableSeat>(&arg0.seats, v1);
            let v4 = v0 + v3.wager * 250 / 100;
            v0 = v4 + v3.wager * arg2.fee_bps / 10000;
            v1 = v1 + 1;
        };
        assert!(0x2::balance::value<0x4ddca40b10ff92ccaa1b1797b14dc63ad15e0c87cb7b5669af9bdc49e11e8dab::suipump::SUIPUMP>(&arg1.vault) >= v0, 4);
        let v5 = 0x2::random::new_generator(arg3, arg4);
        let v6 = &mut v5;
        0x1::vector::push_back<u8>(&mut arg0.dealer_cards, blackjack_draw(v6));
        let v7 = &mut v5;
        0x1::vector::push_back<u8>(&mut arg0.dealer_cards, blackjack_draw(v7));
        v1 = 0;
        while (v1 < v2) {
            let v8 = 0x1::vector::borrow_mut<JasonBlackjackTableSeat>(&mut arg0.seats, v1);
            let v9 = &mut v5;
            0x1::vector::push_back<u8>(&mut v8.player_cards, blackjack_draw(v9));
            let v10 = &mut v5;
            0x1::vector::push_back<u8>(&mut v8.player_cards, blackjack_draw(v10));
            v8.status = 0;
            v1 = v1 + 1;
        };
        arg0.phase = 1;
        arg0.round = arg0.round + 1;
        let v11 = JasonBlackjackTableStartedEvent{
            table_id       : 0x2::object::uid_to_inner(&arg0.id),
            round          : arg0.round,
            seat_count     : (v2 as u8),
            dealer_up_card : *0x1::vector::borrow<u8>(&arg0.dealer_cards, 0),
        };
        0x2::event::emit<JasonBlackjackTableStartedEvent>(v11);
    }

    fun wheel_payout(arg0: u8) : u64 {
        if (arg0 == 0 || arg0 == 8) {
            150
        } else if (arg0 == 2) {
            175
        } else if (arg0 == 4) {
            200
        } else if (arg0 == 6) {
            300
        } else if (arg0 == 10) {
            500
        } else {
            0
        }
    }

    public entry fun withdraw(arg0: &mut House, arg1: u64, arg2: &AdminCap, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.paused, 6);
        assert!(arg1 <= 0x2::balance::value<0x2::sui::SUI>(&arg0.vault), 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.vault, arg1), arg3), @0xd2cebe8666352e1ddb3dc7f271340432c983fc81017b3d6f7873dd66881433a4);
        let v0 = HouseWithdrawalEvent{
            recipient : @0xd2cebe8666352e1ddb3dc7f271340432c983fc81017b3d6f7873dd66881433a4,
            amount    : arg1,
        };
        0x2::event::emit<HouseWithdrawalEvent>(v0);
    }

    public entry fun withdraw_jason(arg0: &mut JasonHouse, arg1: u64, arg2: &AdminCap, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.paused, 6);
        assert!(arg1 <= 0x2::balance::value<0x4ddca40b10ff92ccaa1b1797b14dc63ad15e0c87cb7b5669af9bdc49e11e8dab::suipump::SUIPUMP>(&arg0.vault), 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x4ddca40b10ff92ccaa1b1797b14dc63ad15e0c87cb7b5669af9bdc49e11e8dab::suipump::SUIPUMP>>(0x2::coin::from_balance<0x4ddca40b10ff92ccaa1b1797b14dc63ad15e0c87cb7b5669af9bdc49e11e8dab::suipump::SUIPUMP>(0x2::balance::split<0x4ddca40b10ff92ccaa1b1797b14dc63ad15e0c87cb7b5669af9bdc49e11e8dab::suipump::SUIPUMP>(&mut arg0.vault, arg1), arg3), @0xd2cebe8666352e1ddb3dc7f271340432c983fc81017b3d6f7873dd66881433a4);
        let v0 = HouseWithdrawalEvent{
            recipient : @0xd2cebe8666352e1ddb3dc7f271340432c983fc81017b3d6f7873dd66881433a4,
            amount    : arg1,
        };
        0x2::event::emit<HouseWithdrawalEvent>(v0);
    }

    fun worst_case_payout_bps(arg0: u8, arg1: u8, arg2: bool, arg3: u64) : u64 {
        let v0 = if (arg0 == 0 || arg0 == 1) {
            500
        } else if (arg0 == 3) {
            250
        } else if (arg0 == 4) {
            plinko_max_payout_bps(arg1)
        } else {
            let v1 = if (arg2) {
                100 - arg1
            } else {
                arg1
            };
            9800 / (v1 as u64)
        };
        if (v0 > arg3) {
            arg3
        } else {
            v0
        }
    }

    // decompiled from Move bytecode v7
}

