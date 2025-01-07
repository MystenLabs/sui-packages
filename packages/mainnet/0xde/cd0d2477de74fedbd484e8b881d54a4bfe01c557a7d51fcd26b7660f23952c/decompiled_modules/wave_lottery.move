module 0xdecd0d2477de74fedbd484e8b881d54a4bfe01c557a7d51fcd26b7660f23952c::wave_lottery {
    struct LotteryOwnerCap has key {
        id: 0x2::object::UID,
    }

    struct App has key {
        id: 0x2::object::UID,
        version: u8,
        sui_reward: 0x2::balance::Balance<0x2::sui::SUI>,
        ocean_receiver: address,
        sui_receiver: address,
        operator_pk: vector<u8>,
        ocean_seq: u64,
        sui_seq: u64,
        nft_seq: u64,
    }

    struct Game has store, key {
        id: 0x2::object::UID,
        seq: u64,
        round: u64,
        status: u8,
        n_winner: u8,
        ticket_price: u64,
        ticket_sold: u64,
        total_participants: u64,
        game_type: u8,
        sui_reward: 0x2::balance::Balance<0x2::sui::SUI>,
        prize: u64,
        start_at: u64,
        end_at: u64,
        participants: 0x2::table::Table<address, vector<Ticket>>,
        winners: vector<address>,
        ticket_claimed: u8,
        lucky_numbers: vector<u64>,
        commission_rate: u16,
        nft_discount_rate: u16,
        max_buy_times: u16,
        max_buy_tickets: u32,
    }

    struct WinnerRedeem has copy, drop {
        game_id: 0x2::object::ID,
        game_type: u8,
        seq: u64,
        winner: address,
        amount_received: u64,
    }

    struct GameCreated has copy, drop {
        id: 0x2::object::ID,
        seq: u64,
        round: u64,
        status: u8,
        n_winner: u8,
        ticket_price: u64,
        game_type: u8,
        prize: u64,
        start_at: u64,
        end_at: u64,
        commission_rate: u16,
        nft_discount_rate: u16,
        max_buy_times: u16,
        max_buy_tickets: u32,
    }

    struct GameUpdated has copy, drop {
        id: 0x2::object::ID,
        status: u8,
        ticket_price: u64,
        prize: u64,
        n_winner: u8,
        round: u64,
        start_at: u64,
        end_at: u64,
        commission_rate: u16,
        nft_discount_rate: u16,
        max_buy_times: u16,
        max_buy_tickets: u32,
    }

    struct GameCompleted has copy, drop {
        id: 0x2::object::ID,
        lucky_numbers: vector<u64>,
    }

    struct GameClaimed has copy, drop {
        id: 0x2::object::ID,
    }

    struct Ticket has drop, store {
        start: u64,
        end: u64,
    }

    struct TicketIssued has copy, drop {
        game_id: 0x2::object::ID,
        start: u64,
        end: u64,
        total_amount: u64,
    }

    fun add_ticket(arg0: &mut Game, arg1: u64, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        if (0x2::table::contains<address, vector<Ticket>>(&arg0.participants, v0)) {
            let v1 = Ticket{
                start : arg0.ticket_sold + 1,
                end   : arg0.ticket_sold + arg1,
            };
            0x1::vector::push_back<Ticket>(0x2::table::borrow_mut<address, vector<Ticket>>(&mut arg0.participants, v0), v1);
        } else {
            let v2 = Ticket{
                start : arg0.ticket_sold + 1,
                end   : arg0.ticket_sold + arg1,
            };
            0x2::table::add<address, vector<Ticket>>(&mut arg0.participants, v0, 0x1::vector::singleton<Ticket>(v2));
            arg0.total_participants = arg0.total_participants + 1;
        };
        let v3 = TicketIssued{
            game_id      : 0x2::object::id<Game>(arg0),
            start        : arg0.ticket_sold + 1,
            end          : arg0.ticket_sold + arg1,
            total_amount : arg2,
        };
        0x2::event::emit<TicketIssued>(v3);
        arg0.ticket_sold = arg0.ticket_sold + arg1;
    }

    entry fun app_deposit_sui(arg0: &LotteryOwnerCap, arg1: &mut App, arg2: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.sui_reward, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
    }

    entry fun authorize_nft(arg0: &0xbe9d578ed9e0b7dbd79555fe02b8058be262f4c534adbf816cd6c4606df9ead9::ocean_nft::NftOwnerCap, arg1: &mut App) {
        0xbe9d578ed9e0b7dbd79555fe02b8058be262f4c534adbf816cd6c4606df9ead9::ocean_nft::authorize_app(arg0, &mut arg1.id, 0);
    }

    fun can_participate(arg0: &App, arg1: &Game, arg2: u64, arg3: &0x2::clock::Clock, arg4: u8, arg5: address, arg6: vector<u8>) {
        assert!(arg0.version <= 2, 17);
        assert!(arg1.start_at <= 0x2::clock::timestamp_ms(arg3), 5);
        assert!(arg1.end_at >= 0x2::clock::timestamp_ms(arg3), 5);
        assert!(arg2 > 0, 7);
        assert!(arg1.status == 0, 0);
        assert!(arg1.game_type == arg4, 6);
        if (0x2::table::contains<address, vector<Ticket>>(&arg1.participants, arg5)) {
            let v0 = 0x2::table::borrow<address, vector<Ticket>>(&arg1.participants, arg5);
            let v1 = 0x1::vector::length<Ticket>(v0);
            assert!(v1 < (arg1.max_buy_times as u64), 12);
            let v2 = 0;
            let v3 = 0;
            while (v2 < v1) {
                let v4 = 0x1::vector::borrow<Ticket>(v0, v2);
                let v5 = v3 + v4.end - v4.start;
                v3 = v5 + 1;
                v2 = v2 + 1;
            };
            assert!(v3 + arg2 <= (arg1.max_buy_tickets as u64), 13);
        } else {
            assert!(arg2 <= (arg1.max_buy_tickets as u64), 13);
        };
        let v6 = 0x1::string::utf8(b"LOTTERY_PARTICIPATE:");
        let v7 = 0x2::bcs::to_bytes<0x1::string::String>(&v6);
        0x1::vector::append<u8>(&mut v7, 0x2::bcs::to_bytes<address>(&arg5));
        let v8 = 0x1::string::utf8(b"-");
        0x1::vector::append<u8>(&mut v7, 0x2::bcs::to_bytes<0x1::string::String>(&v8));
        0x1::vector::append<u8>(&mut v7, 0x2::bcs::to_bytes<0x2::object::UID>(&arg1.id));
        assert!(0x2::ed25519::ed25519_verify(&arg6, &arg0.operator_pk, &v7) == true, 9);
    }

    entry fun change_ocean_receiver(arg0: &LotteryOwnerCap, arg1: &mut App, arg2: address) {
        arg1.ocean_receiver = arg2;
    }

    entry fun change_sui_receiver(arg0: &LotteryOwnerCap, arg1: &mut App, arg2: address) {
        arg1.sui_receiver = arg2;
    }

    entry fun complete(arg0: &App, arg1: &mut Game, arg2: &0x2::clock::Clock, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version <= 2, 17);
        assert!(arg1.status == 0, 0);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg1.end_at, 5);
        0xdecd0d2477de74fedbd484e8b881d54a4bfe01c557a7d51fcd26b7660f23952c::drand_lib::verify_drand_signature(arg3, arg4, arg1.round);
        if (arg1.ticket_sold == 0) {
            let v0 = GameCompleted{
                id            : 0x2::object::id<Game>(arg1),
                lucky_numbers : arg1.lucky_numbers,
            };
            0x2::event::emit<GameCompleted>(v0);
            arg1.status = 2;
            let v1 = GameClaimed{id: 0x2::object::id<Game>(arg1)};
            0x2::event::emit<GameClaimed>(v1);
            return
        };
        arg1.status = 1;
        let v2 = 0xdecd0d2477de74fedbd484e8b881d54a4bfe01c557a7d51fcd26b7660f23952c::drand_lib::derive_randomness(arg3);
        let v3 = 0;
        while (v3 < arg1.n_winner) {
            0x1::vector::push_back<u64>(&mut arg1.lucky_numbers, 0xdecd0d2477de74fedbd484e8b881d54a4bfe01c557a7d51fcd26b7660f23952c::drand_lib::safe_selection(arg1.ticket_sold, &v2) + 1);
            v2 = 0xdecd0d2477de74fedbd484e8b881d54a4bfe01c557a7d51fcd26b7660f23952c::drand_lib::derive_randomness(v2);
            v3 = v3 + 1;
        };
        if (arg1.game_type == 0) {
            let v4 = 0x2::balance::value<0x2::sui::SUI>(&arg1.sui_reward) - arg1.prize * (10000 - (arg1.commission_rate as u64)) / 10000;
            if (v4 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.sui_reward, v4), arg5), arg0.sui_receiver);
            };
        };
        let v5 = GameCompleted{
            id            : 0x2::object::id<Game>(arg1),
            lucky_numbers : arg1.lucky_numbers,
        };
        0x2::event::emit<GameCompleted>(v5);
    }

    entry fun create(arg0: &LotteryOwnerCap, arg1: &mut App, arg2: u64, arg3: u64, arg4: u8, arg5: u64, arg6: u8, arg7: u64, arg8: u64, arg9: u16, arg10: u16, arg11: u16, arg12: u32, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        assert!(arg6 < 3, 6);
        assert!(arg9 <= 1000, 15);
        assert!(arg6 != 0 || arg6 == 0 && arg10 <= arg9, 15);
        valid_round_timestamp(arg13, arg2, arg7, arg8);
        if (arg6 == 1) {
            assert!(arg5 > 0, 8);
        };
        if (arg6 == 0 || arg6 == 2) {
            arg5 = 0;
        };
        if (arg6 == 1 || arg6 == 2) {
            arg9 = 0;
        };
        let v0 = Game{
            id                 : 0x2::object::new(arg14),
            seq                : next_sequence(arg1, arg6),
            round              : arg2,
            status             : 0,
            n_winner           : arg4,
            ticket_price       : arg3,
            ticket_sold        : 0,
            total_participants : 0,
            game_type          : arg6,
            sui_reward         : 0x2::balance::zero<0x2::sui::SUI>(),
            prize              : arg5,
            start_at           : arg7,
            end_at             : arg8,
            participants       : 0x2::table::new<address, vector<Ticket>>(arg14),
            winners            : 0x1::vector::empty<address>(),
            ticket_claimed     : 0,
            lucky_numbers      : 0x1::vector::empty<u64>(),
            commission_rate    : arg9,
            nft_discount_rate  : arg10,
            max_buy_times      : arg11,
            max_buy_tickets    : arg12,
        };
        let v1 = GameCreated{
            id                : 0x2::object::id<Game>(&v0),
            seq               : v0.seq,
            round             : arg2,
            status            : 0,
            n_winner          : arg4,
            ticket_price      : arg3,
            game_type         : arg6,
            prize             : arg5,
            start_at          : arg7,
            end_at            : arg8,
            commission_rate   : arg9,
            nft_discount_rate : arg10,
            max_buy_times     : arg11,
            max_buy_tickets   : arg12,
        };
        0x2::event::emit<GameCreated>(v1);
        0x2::transfer::share_object<Game>(v0);
    }

    fun finalize_redeem(arg0: &mut Game, arg1: address, arg2: u8, arg3: u64) {
        0x1::vector::push_back<address>(&mut arg0.winners, arg1);
        arg0.ticket_claimed = arg0.ticket_claimed + arg2;
        if (arg0.ticket_claimed >= arg0.n_winner) {
            let v0 = GameClaimed{id: 0x2::object::id<Game>(arg0)};
            0x2::event::emit<GameClaimed>(v0);
        };
        let v1 = WinnerRedeem{
            game_id         : 0x2::object::id<Game>(arg0),
            game_type       : arg0.game_type,
            seq             : arg0.seq,
            winner          : arg1,
            amount_received : arg3,
        };
        0x2::event::emit<WinnerRedeem>(v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = @0xfdefe17a05a90060ef50ef578992df05f55ee11d31877d0c3010cbe36781f1b0;
        let v1 = LotteryOwnerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<LotteryOwnerCap>(v1, 0x2::tx_context::sender(arg0));
        let v2 = App{
            id             : 0x2::object::new(arg0),
            version        : 2,
            sui_reward     : 0x2::balance::zero<0x2::sui::SUI>(),
            ocean_receiver : @0xc1bac4897af0434852095e18ef3f613e070855fc963d0d53c9da3123bf0cb686,
            sui_receiver   : @0xc1bac4897af0434852095e18ef3f613e070855fc963d0d53c9da3123bf0cb686,
            operator_pk    : 0x2::bcs::to_bytes<address>(&v0),
            ocean_seq      : 11,
            sui_seq        : 1,
            nft_seq        : 9,
        };
        0x2::transfer::share_object<App>(v2);
    }

    fun inner_claim_nft(arg0: &mut App, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u16, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xbe9d578ed9e0b7dbd79555fe02b8058be262f4c534adbf816cd6c4606df9ead9::ocean_nft::NFT>(0xbe9d578ed9e0b7dbd79555fe02b8058be262f4c534adbf816cd6c4606df9ead9::ocean_nft::mint(&mut arg0.id, arg1, arg2, arg3, arg4, arg6), arg5);
    }

    entry fun migrate(arg0: &LotteryOwnerCap, arg1: &mut App) {
        assert!(arg1.version < 2, 18);
        arg1.version = 2;
    }

    fun next_sequence(arg0: &mut App, arg1: u8) : u64 {
        let v0 = 0;
        if (arg1 == 0) {
            v0 = arg0.sui_seq;
            arg0.sui_seq = arg0.sui_seq + 1;
        } else if (arg1 == 1) {
            v0 = arg0.ocean_seq;
            arg0.ocean_seq = arg0.ocean_seq + 1;
        } else if (arg1 == 2) {
            v0 = arg0.nft_seq;
            arg0.nft_seq = arg0.nft_seq + 1;
        };
        v0
    }

    fun not_claimed(arg0: &Game, arg1: address) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg0.winners)) {
            assert!(*0x1::vector::borrow<address>(&arg0.winners, v0) != arg1, 2);
            v0 = v0 + 1;
        };
    }

    entry fun operator_adjust_time(arg0: &LotteryOwnerCap, arg1: &mut Game, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) {
        assert!(arg1.status == 0, 0);
        valid_round_timestamp(arg5, arg4, arg2, arg3);
        arg1.start_at = arg2;
        arg1.end_at = arg3;
        arg1.round = arg4;
        let v0 = GameUpdated{
            id                : 0x2::object::id<Game>(arg1),
            status            : arg1.status,
            ticket_price      : arg1.ticket_price,
            prize             : arg1.prize,
            n_winner          : arg1.n_winner,
            round             : arg4,
            start_at          : arg2,
            end_at            : arg3,
            commission_rate   : arg1.commission_rate,
            nft_discount_rate : arg1.nft_discount_rate,
            max_buy_times     : arg1.max_buy_times,
            max_buy_tickets   : arg1.max_buy_tickets,
        };
        0x2::event::emit<GameUpdated>(v0);
    }

    entry fun operator_cancel_game(arg0: &LotteryOwnerCap, arg1: &mut Game) {
        assert!(arg1.ticket_sold == 0, 0);
        arg1.status = 3;
        let v0 = GameUpdated{
            id                : 0x2::object::id<Game>(arg1),
            status            : arg1.status,
            ticket_price      : arg1.ticket_price,
            prize             : arg1.prize,
            n_winner          : arg1.n_winner,
            round             : arg1.round,
            start_at          : arg1.start_at,
            end_at            : arg1.end_at,
            commission_rate   : arg1.commission_rate,
            nft_discount_rate : arg1.nft_discount_rate,
            max_buy_times     : arg1.max_buy_times,
            max_buy_tickets   : arg1.max_buy_tickets,
        };
        0x2::event::emit<GameUpdated>(v0);
    }

    entry fun operator_redeem_nft(arg0: &LotteryOwnerCap, arg1: &mut App, arg2: &mut Game, arg3: vector<address>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: u16, arg8: vector<u8>, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg3)) {
            redeem_nft(arg1, arg2, *0x1::vector::borrow<address>(&arg3, v0), arg4, arg5, arg6, arg7, arg8, arg9);
            v0 = v0 + 1;
        };
    }

    entry fun operator_redeem_ocean(arg0: &LotteryOwnerCap, arg1: &mut App, arg2: &mut Game, arg3: vector<address>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg3)) {
            redeem_ocean(arg1, arg2, *0x1::vector::borrow<address>(&arg3, v0), arg4);
            v0 = v0 + 1;
        };
    }

    entry fun operator_redeem_sui(arg0: &LotteryOwnerCap, arg1: &mut Game, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            redeem_sui(arg1, *0x1::vector::borrow<address>(&arg2, v0), arg3);
            v0 = v0 + 1;
        };
    }

    entry fun operator_update_game(arg0: &LotteryOwnerCap, arg1: &mut Game, arg2: u64, arg3: u8, arg4: u16, arg5: u16, arg6: u16, arg7: u32) {
        assert!(arg1.ticket_sold == 0, 1);
        assert!(arg4 <= 1000, 15);
        assert!(arg1.game_type != 0 || arg1.game_type == 0 && arg5 <= arg4, 15);
        arg1.ticket_price = arg2;
        arg1.n_winner = arg3;
        arg1.commission_rate = arg4;
        arg1.nft_discount_rate = arg5;
        arg1.max_buy_times = arg6;
        arg1.max_buy_tickets = arg7;
        let v0 = GameUpdated{
            id                : 0x2::object::id<Game>(arg1),
            status            : arg1.status,
            ticket_price      : arg2,
            prize             : arg1.prize,
            n_winner          : arg3,
            round             : arg1.round,
            start_at          : arg1.start_at,
            end_at            : arg1.end_at,
            commission_rate   : arg4,
            nft_discount_rate : arg5,
            max_buy_times     : arg6,
            max_buy_tickets   : arg7,
        };
        0x2::event::emit<GameUpdated>(v0);
    }

    entry fun operator_update_ocean_prize(arg0: &LotteryOwnerCap, arg1: &mut Game, arg2: u64, arg3: &0x2::clock::Clock) {
        assert!(arg1.game_type == 1, 6);
        assert!(0x2::clock::timestamp_ms(arg3) < arg1.end_at, 16);
        arg1.prize = arg2;
        let v0 = GameUpdated{
            id                : 0x2::object::id<Game>(arg1),
            status            : arg1.status,
            ticket_price      : arg1.ticket_price,
            prize             : arg2,
            n_winner          : arg1.n_winner,
            round             : arg1.round,
            start_at          : arg1.start_at,
            end_at            : arg1.end_at,
            commission_rate   : arg1.commission_rate,
            nft_discount_rate : arg1.nft_discount_rate,
            max_buy_times     : arg1.max_buy_times,
            max_buy_tickets   : arg1.max_buy_tickets,
        };
        0x2::event::emit<GameUpdated>(v0);
    }

    entry fun owner_withdraw_sui(arg0: &LotteryOwnerCap, arg1: &mut App, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.sui_reward, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    entry fun participate_nft(arg0: &App, arg1: &mut Game, arg2: 0x2::coin::Coin<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>, arg3: u64, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        can_participate(arg0, arg1, arg3, arg5, 2, 0x2::tx_context::sender(arg6), arg4);
        let v0 = arg1.ticket_price * arg3;
        let v1 = take_exact_amount<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>(arg2, v0, arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>>(v1, arg0.ocean_receiver);
        add_ticket(arg1, arg3, v0, arg6);
    }

    entry fun participate_nft_discount(arg0: &App, arg1: &mut Game, arg2: 0x2::coin::Coin<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>, arg3: u64, arg4: &0xbe9d578ed9e0b7dbd79555fe02b8058be262f4c534adbf816cd6c4606df9ead9::ocean_nft::NFT, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        can_participate(arg0, arg1, arg3, arg6, 2, 0x2::tx_context::sender(arg7), arg5);
        let v0 = required_amount_nft(arg1, arg3);
        let v1 = take_exact_amount<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>(arg2, v0, arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>>(v1, arg0.ocean_receiver);
        add_ticket(arg1, arg3, v0, arg7);
    }

    entry fun participate_ocean(arg0: &App, arg1: &mut Game, arg2: 0x2::coin::Coin<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>, arg3: u64, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        can_participate(arg0, arg1, arg3, arg5, 1, 0x2::tx_context::sender(arg6), arg4);
        let v0 = arg1.ticket_price * arg3;
        let v1 = take_exact_amount<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>(arg2, v0, arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>>(v1, arg0.ocean_receiver);
        add_ticket(arg1, arg3, v0, arg6);
    }

    entry fun participate_ocean_discount(arg0: &App, arg1: &mut Game, arg2: 0x2::coin::Coin<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>, arg3: u64, arg4: &0xbe9d578ed9e0b7dbd79555fe02b8058be262f4c534adbf816cd6c4606df9ead9::ocean_nft::NFT, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        can_participate(arg0, arg1, arg3, arg6, 1, 0x2::tx_context::sender(arg7), arg5);
        let v0 = required_amount_nft(arg1, arg3);
        let v1 = take_exact_amount<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>(arg2, v0, arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>>(v1, arg0.ocean_receiver);
        add_ticket(arg1, arg3, v0, arg7);
    }

    entry fun participate_sui(arg0: &App, arg1: &mut Game, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        can_participate(arg0, arg1, arg3, arg5, 0, 0x2::tx_context::sender(arg6), arg4);
        let v0 = arg1.ticket_price * arg3;
        let v1 = take_exact_amount<0x2::sui::SUI>(arg2, v0, arg6);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.sui_reward, 0x2::coin::into_balance<0x2::sui::SUI>(v1));
        arg1.prize = arg1.prize + arg1.ticket_price * arg3;
        add_ticket(arg1, arg3, v0, arg6);
    }

    entry fun participate_sui_discount(arg0: &App, arg1: &mut Game, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &0xbe9d578ed9e0b7dbd79555fe02b8058be262f4c534adbf816cd6c4606df9ead9::ocean_nft::NFT, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        can_participate(arg0, arg1, arg3, arg6, 0, 0x2::tx_context::sender(arg7), arg5);
        let v0 = required_amount_nft(arg1, arg3);
        let v1 = take_exact_amount<0x2::sui::SUI>(arg2, v0, arg7);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.sui_reward, 0x2::coin::into_balance<0x2::sui::SUI>(v1));
        arg1.prize = arg1.prize + arg1.ticket_price * arg3;
        add_ticket(arg1, arg3, v0, arg7);
    }

    fun redeem_nft(arg0: &mut App, arg1: &mut Game, arg2: address, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: u16, arg7: vector<u8>, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.game_type == 2, 6);
        not_claimed(arg1, arg2);
        let v0 = verify_winner(arg1, arg2);
        let v1 = 0x1::string::utf8(b"LOTTERY_REDEEM:");
        let v2 = 0x2::bcs::to_bytes<0x1::string::String>(&v1);
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<address>(&arg2));
        let v3 = 0x1::string::utf8(b"-");
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<0x1::string::String>(&v3));
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<0x2::object::UID>(&arg1.id));
        let v4 = 0x1::string::utf8(b"-");
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<0x1::string::String>(&v4));
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<vector<u8>>(&arg3));
        let v5 = 0x1::string::utf8(b"-");
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<0x1::string::String>(&v5));
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<vector<u8>>(&arg4));
        let v6 = 0x1::string::utf8(b"-");
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<0x1::string::String>(&v6));
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<vector<u8>>(&arg5));
        let v7 = 0x1::string::utf8(b"-");
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<0x1::string::String>(&v7));
        0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<u16>(&arg6));
        assert!(0x2::ed25519::ed25519_verify(&arg7, &arg0.operator_pk, &v2) == true, 9);
        let v8 = 0;
        while (v8 < v0) {
            inner_claim_nft(arg0, arg3, arg4, arg5, arg6, arg2, arg8);
            v8 = v8 + 1;
        };
        finalize_redeem(arg1, arg2, v0, (v0 as u64));
    }

    fun redeem_ocean(arg0: &mut App, arg1: &mut Game, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.game_type == 1, 6);
        not_claimed(arg1, arg2);
        let v0 = verify_winner(arg1, arg2);
        let v1 = arg1.prize * (v0 as u64) / (arg1.n_winner as u64);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reward) >= v1, 14);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_reward, v1), arg3), arg2);
        finalize_redeem(arg1, arg2, v0, v1);
    }

    fun redeem_sui(arg0: &mut Game, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.game_type == 0, 6);
        not_claimed(arg0, arg1);
        let v0 = verify_winner(arg0, arg1);
        let v1 = arg0.prize * (v0 as u64) / 10000 * (10000 - (arg0.commission_rate as u64)) / (arg0.n_winner as u64);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_reward, v1), arg2), arg1);
        finalize_redeem(arg0, arg1, v0, v1);
    }

    fun required_amount_nft(arg0: &Game, arg1: u64) : u64 {
        (arg0.ticket_price - arg0.ticket_price * (arg0.nft_discount_rate as u64) / 10000) * arg1
    }

    entry fun self_redeem_nft(arg0: &mut App, arg1: &mut Game, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u16, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version <= 2, 17);
        let v0 = 0x2::tx_context::sender(arg7);
        redeem_nft(arg0, arg1, v0, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    entry fun self_redeem_ocean(arg0: &mut App, arg1: &mut Game, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version <= 2, 17);
        let v0 = 0x2::tx_context::sender(arg2);
        redeem_ocean(arg0, arg1, v0, arg2);
    }

    entry fun self_redeem_sui(arg0: &App, arg1: &mut Game, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version <= 2, 17);
        let v0 = 0x2::tx_context::sender(arg2);
        redeem_sui(arg1, v0, arg2);
    }

    fun take_exact_amount<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 >= arg1, 4);
        if (v0 > arg1) {
            0x2::pay::keep<T0>(arg0, arg2);
            0x2::coin::split<T0>(&mut arg0, arg1, arg2)
        } else {
            arg0
        }
    }

    entry fun update_operator(arg0: &LotteryOwnerCap, arg1: &mut App, arg2: vector<u8>) {
        arg1.operator_pk = arg2;
    }

    entry fun update_sequence(arg0: &LotteryOwnerCap, arg1: &mut App, arg2: u64, arg3: u64, arg4: u64) {
        arg1.sui_seq = arg2;
        arg1.ocean_seq = arg3;
        arg1.nft_seq = arg4;
    }

    fun valid_round_timestamp(arg0: &0x2::clock::Clock, arg1: u64, arg2: u64, arg3: u64) {
        assert!(0x2::clock::timestamp_ms(arg0) < arg3, 5);
        assert!(arg2 <= arg3, 5);
        assert!(arg3 < 1595431050000 + (arg1 - 1) * 30000, 11);
    }

    fun verify_winner(arg0: &Game, arg1: address) : u8 {
        assert!(arg0.status == 1, 10);
        assert!(0x2::table::contains<address, vector<Ticket>>(&arg0.participants, arg1), 3);
        let v0 = 0x2::table::borrow<address, vector<Ticket>>(&arg0.participants, arg1);
        let v1 = 0;
        let v2 = 0;
        while (v1 < 0x1::vector::length<Ticket>(v0)) {
            let v3 = 0x1::vector::borrow<Ticket>(v0, v1);
            let v4 = 0;
            while (v4 < 0x1::vector::length<u64>(&arg0.lucky_numbers)) {
                let v5 = *0x1::vector::borrow<u64>(&arg0.lucky_numbers, v4);
                if (v3.start <= v5 && v3.end >= v5) {
                    v2 = v2 + 1;
                };
                v4 = v4 + 1;
            };
            v1 = v1 + 1;
        };
        assert!(v2 > 0, 3);
        v2
    }

    // decompiled from Move bytecode v6
}

