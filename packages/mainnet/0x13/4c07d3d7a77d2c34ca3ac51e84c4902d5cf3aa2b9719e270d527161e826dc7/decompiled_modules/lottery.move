module 0x5fad208418200537f2785aefdca3c8e15e2843ebdffd524956e6d6d6aca845a9::lottery {
    struct TicketPurchased<phantom T0> has copy, drop, store {
        id: 0x2::object::ID,
        picks: Picks,
        lottery_id: 0x2::object::ID,
        round: u64,
        timestamp_issued: u64,
    }

    struct TicketPurchasedWithIdentifier<phantom T0> has copy, drop, store {
        id: 0x2::object::ID,
        picks: Picks,
        lottery_id: 0x2::object::ID,
        round: u64,
        timestamp_issued: u64,
        origin: 0x1::string::String,
    }

    struct TicketResult<phantom T0> has copy, drop, store {
        player: address,
        reward_structure: RewardStructure,
        amount_won: u64,
        picks: Picks,
    }

    struct DepositEvent<phantom T0> has copy, drop, store {
        lottery_id: 0x2::object::ID,
        amount: u64,
    }

    struct FeeWithdrawEvent<phantom T0> has copy, drop, store {
        lottery_id: 0x2::object::ID,
        amount: u64,
    }

    struct RoundResult<phantom T0> has copy, drop, store {
        round: u64,
        lottery_id: 0x2::object::ID,
        results: Picks,
        timestamp_drawn: u64,
    }

    struct RoundStarted<phantom T0> has copy, drop, store {
        round: u64,
        lottery_id: 0x2::object::ID,
        next_drawing_time: u64,
    }

    struct LotteryCreated<phantom T0> has copy, drop, store {
        lottery_id: 0x2::object::ID,
        initial_prize_amount: u64,
    }

    struct RedeemEvent<phantom T0> has copy, drop {
        player: address,
        amount: u64,
    }

    struct RedeemEventV2<phantom T0> has copy, drop {
        player: address,
        amount: u64,
        picks: Picks,
    }

    struct RoundWinnersEvent<phantom T0> has copy, drop {
        ticket_id: 0x2::object::ID,
        round: u64,
        reward_structure: RewardStructure,
        amount_won: u64,
    }

    struct LOTTERY has drop {
        dummy_field: bool,
    }

    struct LotteryStoreAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct LotteryStore has store, key {
        id: 0x2::object::UID,
        is_closed: bool,
    }

    struct Lottery<phantom T0> has store, key {
        id: 0x2::object::UID,
        lottery_prize_pool: 0x2::balance::Balance<T0>,
        minimum_jackpot: u64,
        lottery_fees: 0x2::balance::Balance<T0>,
        current_round: u64,
        ticket_cost: u64,
        reward_structure_table: 0x2::table::Table<RewardStructure, u64>,
        normal_ball_count: u8,
        max_normal_ball: u8,
        max_special_ball: u8,
        drawing_time_ms: u64,
        tickets: 0x5fad208418200537f2785aefdca3c8e15e2843ebdffd524956e6d6d6aca845a9::big_queue::BigQueue<TicketReceipt>,
        winning_tickets: 0x2::table::Table<0x2::object::ID, 0x2::balance::Balance<T0>>,
        jackpot_winners: 0x2::table::Table<0x2::object::ID, bool>,
        rounds_settled: 0x2::table::Table<u64, bool>,
        redemptions_allowed: 0x2::table::Table<u64, bool>,
    }

    struct TicketReceipt has drop, store {
        original_ticket_id: 0x2::object::ID,
        picks: Picks,
    }

    struct RewardStructureInput has drop, store {
        normal_ball_count: u8,
        special_number_hit: bool,
        balance_paid: u64,
    }

    struct RewardStructure has copy, drop, store {
        normal_ball_count: u8,
        special_number_hit: bool,
    }

    struct Picks has copy, drop, store {
        numbers: 0x2::vec_set::VecSet<u8>,
        special_number: u8,
    }

    struct Ticket has store, key {
        id: 0x2::object::UID,
        picks: Picks,
        lottery_id: 0x2::object::ID,
        round: u64,
        timestamp_issued: u64,
    }

    public fun allow_redemptions_for_round<T0>(arg0: &LotteryStoreAdminCap, arg1: &mut LotteryStore, arg2: 0x2::object::ID, arg3: u64) {
        let v0 = borrow_mut_lottery<T0>(arg1, arg2);
        assert!(round_is_settled<T0>(v0, arg3), 6);
        if (0x2::table::length<0x2::object::ID, bool>(&v0.jackpot_winners) > 0) {
            assert!(0x2::balance::value<T0>(&v0.lottery_prize_pool) >= v0.minimum_jackpot, 5);
        };
        *0x2::table::borrow_mut<u64, bool>(&mut v0.redemptions_allowed, arg3) = true;
    }

    public fun batch_redeem<T0>(arg0: vector<Ticket>, arg1: &mut LotteryStore, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<T0>> {
        let v0 = 0x2::coin::zero<T0>(arg3);
        while (!0x1::vector::is_empty<Ticket>(&arg0)) {
            let v1 = redeem<T0>(0x1::vector::pop_back<Ticket>(&mut arg0), arg1, arg2, arg3);
            if (0x1::option::is_some<0x2::coin::Coin<T0>>(&v1)) {
                0x2::coin::join<T0>(&mut v0, 0x1::option::destroy_some<0x2::coin::Coin<T0>>(v1));
                continue
            };
            0x1::option::destroy_none<0x2::coin::Coin<T0>>(v1);
        };
        0x1::vector::destroy_empty<Ticket>(arg0);
        if (0x2::coin::value<T0>(&v0) > 0) {
            0x1::option::some<0x2::coin::Coin<T0>>(v0)
        } else {
            0x2::coin::destroy_zero<T0>(v0);
            0x1::option::none<0x2::coin::Coin<T0>>()
        }
    }

    fun borrow_mut_lottery<T0>(arg0: &mut LotteryStore, arg1: 0x2::object::ID) : &mut Lottery<T0> {
        assert!(lottery_exists<T0>(arg0, arg1), 9);
        0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Lottery<T0>>(&mut arg0.id, arg1)
    }

    public fun buy_ticket<T0>(arg0: &mut LotteryStore, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T0>, arg3: vector<u8>, arg4: u8, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : Ticket {
        let v0 = borrow_mut_lottery<T0>(arg0, arg1);
        let v1 = v0.current_round;
        assert!(0x2::clock::timestamp_ms(arg5) <= v0.drawing_time_ms, 0);
        assert!(!round_is_settled<T0>(v0, v1), 6);
        assert!(!redemptions_allowed_for_round<T0>(v0, v1), 6);
        check_is_valid_numbers<T0>(arg3, arg4, v0);
        let v2 = 0x2::coin::value<T0>(&arg2);
        assert!(v2 == v0.ticket_cost, 1);
        let v3 = 0x2::coin::into_balance<T0>(arg2);
        0x2::balance::join<T0>(&mut v0.lottery_prize_pool, 0x2::balance::split<T0>(&mut v3, v2 / 2));
        0x2::balance::join<T0>(&mut v0.lottery_fees, v3);
        let v4 = 0x2::object::new(arg6);
        let v5 = 0x2::object::uid_to_inner(&v4);
        assert!(arg4 < v0.max_special_ball, 1);
        let v6 = 0x2::vec_set::empty<u8>();
        while (0x1::vector::length<u8>(&arg3) > 0) {
            let v7 = 0x1::vector::pop_back<u8>(&mut arg3);
            assert!(v7 < v0.max_normal_ball, 1);
            0x2::vec_set::insert<u8>(&mut v6, v7);
        };
        let v8 = Picks{
            numbers        : v6,
            special_number : arg4,
        };
        let v9 = Ticket{
            id               : v4,
            picks            : v8,
            lottery_id       : arg1,
            round            : v0.current_round,
            timestamp_issued : 0x2::clock::timestamp_ms(arg5),
        };
        let v10 = TicketReceipt{
            original_ticket_id : v5,
            picks              : v8,
        };
        0x5fad208418200537f2785aefdca3c8e15e2843ebdffd524956e6d6d6aca845a9::big_queue::push_back<TicketReceipt>(&mut v0.tickets, v10);
        let v11 = TicketPurchased<T0>{
            id               : v5,
            picks            : v8,
            lottery_id       : arg1,
            round            : v0.current_round,
            timestamp_issued : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<TicketPurchased<T0>>(v11);
        v9
    }

    public fun buy_ticket_with_identifier<T0>(arg0: &mut LotteryStore, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T0>, arg3: vector<u8>, arg4: u8, arg5: 0x1::string::String, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : Ticket {
        let v0 = borrow_mut_lottery<T0>(arg0, arg1);
        let v1 = v0.current_round;
        assert!(0x2::clock::timestamp_ms(arg6) <= v0.drawing_time_ms, 0);
        assert!(!round_is_settled<T0>(v0, v1), 6);
        assert!(!redemptions_allowed_for_round<T0>(v0, v1), 6);
        check_is_valid_numbers<T0>(arg3, arg4, v0);
        let v2 = 0x2::coin::value<T0>(&arg2);
        assert!(v2 == v0.ticket_cost, 1);
        let v3 = 0x2::coin::into_balance<T0>(arg2);
        0x2::balance::join<T0>(&mut v0.lottery_prize_pool, 0x2::balance::split<T0>(&mut v3, v2 / 2));
        0x2::balance::join<T0>(&mut v0.lottery_fees, v3);
        let v4 = 0x2::object::new(arg7);
        let v5 = 0x2::object::uid_to_inner(&v4);
        assert!(arg4 < v0.max_special_ball, 1);
        let v6 = 0x2::vec_set::empty<u8>();
        while (0x1::vector::length<u8>(&arg3) > 0) {
            let v7 = 0x1::vector::pop_back<u8>(&mut arg3);
            assert!(v7 < v0.max_normal_ball, 1);
            0x2::vec_set::insert<u8>(&mut v6, v7);
        };
        let v8 = Picks{
            numbers        : v6,
            special_number : arg4,
        };
        let v9 = Ticket{
            id               : v4,
            picks            : v8,
            lottery_id       : arg1,
            round            : v0.current_round,
            timestamp_issued : 0x2::clock::timestamp_ms(arg6),
        };
        let v10 = TicketReceipt{
            original_ticket_id : v5,
            picks              : v8,
        };
        0x5fad208418200537f2785aefdca3c8e15e2843ebdffd524956e6d6d6aca845a9::big_queue::push_back<TicketReceipt>(&mut v0.tickets, v10);
        let v11 = TicketPurchasedWithIdentifier<T0>{
            id               : v5,
            picks            : v8,
            lottery_id       : arg1,
            round            : v0.current_round,
            timestamp_issued : 0x2::clock::timestamp_ms(arg6),
            origin           : arg5,
        };
        0x2::event::emit<TicketPurchasedWithIdentifier<T0>>(v11);
        v9
    }

    fun check_is_valid_numbers<T0>(arg0: vector<u8>, arg1: u8, arg2: &Lottery<T0>) {
        let v0 = (0x1::vector::length<u8>(&arg0) as u8);
        assert!(v0 == arg2.normal_ball_count, 3);
        let v1 = 0;
        let v2 = b"";
        while (v1 < (v0 as u64)) {
            let v3 = *0x1::vector::borrow<u8>(&arg0, v1);
            assert!(v3 <= arg2.max_normal_ball, 3);
            assert!(v3 >= 0, 3);
            0x1::vector::push_back<u8>(&mut v2, v3);
            v1 = v1 + 1;
        };
        v1 = 0;
        while (v1 < (v0 as u64)) {
            let v4 = 0x1::vector::pop_back<u8>(&mut v2);
            assert!(!0x1::vector::contains<u8>(&v2, &v4), 3);
            v1 = v1 + 1;
        };
        assert!(arg1 <= arg2.max_special_ball, 3);
        assert!(arg1 >= 0, 3);
    }

    public fun create_lottery<T0>(arg0: &LotteryStoreAdminCap, arg1: &mut LotteryStore, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: u64, arg6: vector<RewardStructureInput>, arg7: u8, arg8: u8, arg9: u8, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::object::new(arg11);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = 0x2::table::new<RewardStructure, u64>(arg11);
        while (0x1::vector::length<RewardStructureInput>(&arg6) > 0) {
            let v3 = 0x1::vector::pop_back<RewardStructureInput>(&mut arg6);
            let v4 = RewardStructure{
                normal_ball_count  : v3.normal_ball_count,
                special_number_hit : v3.special_number_hit,
            };
            0x2::table::add<RewardStructure, u64>(&mut v2, v4, v3.balance_paid);
        };
        let v5 = Lottery<T0>{
            id                     : v0,
            lottery_prize_pool     : 0x2::coin::into_balance<T0>(arg2),
            minimum_jackpot        : arg3,
            lottery_fees           : 0x2::balance::zero<T0>(),
            current_round          : arg4,
            ticket_cost            : arg5,
            reward_structure_table : v2,
            normal_ball_count      : arg7,
            max_normal_ball        : arg8,
            max_special_ball       : arg9,
            drawing_time_ms        : arg10,
            tickets                : 0x5fad208418200537f2785aefdca3c8e15e2843ebdffd524956e6d6d6aca845a9::big_queue::new<TicketReceipt>(50000, arg11),
            winning_tickets        : 0x2::table::new<0x2::object::ID, 0x2::balance::Balance<T0>>(arg11),
            jackpot_winners        : 0x2::table::new<0x2::object::ID, bool>(arg11),
            rounds_settled         : 0x2::table::new<u64, bool>(arg11),
            redemptions_allowed    : 0x2::table::new<u64, bool>(arg11),
        };
        0x2::table::add<u64, bool>(&mut v5.redemptions_allowed, arg4, false);
        0x2::table::add<u64, bool>(&mut v5.rounds_settled, arg4, false);
        0x2::dynamic_object_field::add<0x2::object::ID, Lottery<T0>>(&mut arg1.id, v1, v5);
        let v6 = LotteryCreated<T0>{
            lottery_id           : v1,
            initial_prize_amount : 0x2::coin::value<T0>(&arg2),
        };
        0x2::event::emit<LotteryCreated<T0>>(v6);
        v1
    }

    public fun create_store(arg0: &LotteryStoreAdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = LotteryStore{
            id        : 0x2::object::new(arg1),
            is_closed : true,
        };
        0x2::transfer::share_object<LotteryStore>(v0);
    }

    public fun deposit_funds<T0>(arg0: &mut LotteryStore, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T0>) {
        let v0 = borrow_mut_lottery<T0>(arg0, arg1);
        let v1 = DepositEvent<T0>{
            lottery_id : 0x2::object::id<Lottery<T0>>(v0),
            amount     : 0x2::coin::value<T0>(&arg2),
        };
        0x2::event::emit<DepositEvent<T0>>(v1);
        0x2::balance::join<T0>(&mut v0.lottery_prize_pool, 0x2::coin::into_balance<T0>(arg2));
    }

    public fun get_lottery_queue_size<T0>(arg0: &LotteryStore, arg1: 0x2::object::ID) : u64 {
        assert!(lottery_exists<T0>(arg0, arg1), 9);
        0x5fad208418200537f2785aefdca3c8e15e2843ebdffd524956e6d6d6aca845a9::big_queue::length<TicketReceipt>(&0x2::dynamic_object_field::borrow<0x2::object::ID, Lottery<T0>>(&arg0.id, arg1).tickets)
    }

    fun get_ticket_result<T0>(arg0: &TicketReceipt, arg1: &Picks, arg2: &Lottery<T0>) : (u64, bool) {
        let v0 = arg0.picks;
        let v1 = 0;
        let v2 = 0x2::vec_set::into_keys<u8>(v0.numbers);
        while (0x1::vector::length<u8>(&v2) > 0) {
            let v3 = 0x1::vector::pop_back<u8>(&mut v2);
            if (0x2::vec_set::contains<u8>(&arg1.numbers, &v3)) {
                v1 = v1 + 1;
            };
        };
        let v4 = false;
        if (v0.special_number == arg1.special_number) {
            v4 = true;
        };
        if (v1 == arg2.normal_ball_count && v4) {
            return (0, true)
        };
        let v5 = RewardStructure{
            normal_ball_count  : v1,
            special_number_hit : v4,
        };
        if (0x2::table::contains<RewardStructure, u64>(&arg2.reward_structure_table, v5)) {
            let v6 = *0x2::table::borrow<RewardStructure, u64>(&arg2.reward_structure_table, v5);
            let v7 = RoundWinnersEvent<T0>{
                ticket_id        : arg0.original_ticket_id,
                round            : arg2.current_round,
                reward_structure : v5,
                amount_won       : v6,
            };
            0x2::event::emit<RoundWinnersEvent<T0>>(v7);
            return (v6, false)
        };
        (0, false)
    }

    fun init(arg0: LOTTERY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = LotteryStoreAdminCap{id: 0x2::object::new(arg1)};
        0x2::package::claim_and_keep<LOTTERY>(arg0, arg1);
        0x2::transfer::transfer<LotteryStoreAdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun jackpot_winners<T0>(arg0: &LotteryStore, arg1: 0x2::object::ID) : &0x2::table::Table<0x2::object::ID, bool> {
        &0x2::dynamic_object_field::borrow<0x2::object::ID, Lottery<T0>>(&arg0.id, arg1).jackpot_winners
    }

    public fun lottery_exists<T0>(arg0: &LotteryStore, arg1: 0x2::object::ID) : bool {
        0x2::dynamic_object_field::exists_with_type<0x2::object::ID, Lottery<T0>>(&arg0.id, arg1)
    }

    public fun lottery_fees<T0>(arg0: &LotteryStore, arg1: 0x2::object::ID) : u64 {
        0x2::balance::value<T0>(&0x2::dynamic_object_field::borrow<0x2::object::ID, Lottery<T0>>(&arg0.id, arg1).lottery_fees)
    }

    public fun lottery_fees_value<T0>(arg0: &Lottery<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.lottery_fees)
    }

    public fun lottery_prize_pool<T0>(arg0: &LotteryStore, arg1: 0x2::object::ID) : u64 {
        0x2::balance::value<T0>(&0x2::dynamic_object_field::borrow<0x2::object::ID, Lottery<T0>>(&arg0.id, arg1).lottery_prize_pool)
    }

    public fun new_reward_structure_input(arg0: u8, arg1: bool, arg2: u64) : RewardStructureInput {
        RewardStructureInput{
            normal_ball_count  : arg0,
            special_number_hit : arg1,
            balance_paid       : arg2,
        }
    }

    public fun new_reward_structure_input_vector(arg0: vector<u8>, arg1: vector<bool>, arg2: vector<u64>) : vector<RewardStructureInput> {
        assert!(0x1::vector::length<u8>(&arg0) == 0x1::vector::length<bool>(&arg1), 3);
        assert!(0x1::vector::length<bool>(&arg1) == 0x1::vector::length<u64>(&arg2), 3);
        let v0 = 0;
        let v1 = 0x1::vector::empty<RewardStructureInput>();
        while (v0 < 0x1::vector::length<u8>(&arg0)) {
            let v2 = RewardStructureInput{
                normal_ball_count  : *0x1::vector::borrow<u8>(&arg0, v0),
                special_number_hit : *0x1::vector::borrow<bool>(&arg1, v0),
                balance_paid       : *0x1::vector::borrow<u64>(&arg2, v0),
            };
            0x1::vector::push_back<RewardStructureInput>(&mut v1, v2);
            v0 = v0 + 1;
        };
        v1
    }

    public fun redeem<T0>(arg0: Ticket, arg1: &mut LotteryStore, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0x2::coin::Coin<T0>> {
        let v0 = borrow_mut_lottery<T0>(arg1, arg2);
        assert!(arg0.lottery_id == 0x2::object::id<Lottery<T0>>(v0), 4);
        assert!(redemptions_allowed_for_round<T0>(v0, arg0.round), 6);
        let v1 = 0x2::object::id<Ticket>(&arg0);
        let Ticket {
            id               : v2,
            picks            : v3,
            lottery_id       : _,
            round            : _,
            timestamp_issued : _,
        } = arg0;
        0x2::object::delete(v2);
        if (0x2::table::contains<0x2::object::ID, bool>(&v0.jackpot_winners, v1)) {
            0x2::table::remove<0x2::object::ID, bool>(&mut v0.jackpot_winners, v1);
            let v8 = 0x2::coin::take<T0>(&mut v0.lottery_prize_pool, 0x2::balance::value<T0>(&v0.lottery_prize_pool) / 0x2::table::length<0x2::object::ID, bool>(&v0.jackpot_winners), arg3);
            let v9 = RedeemEventV2<T0>{
                player : 0x2::tx_context::sender(arg3),
                amount : 0x2::coin::value<T0>(&v8),
                picks  : v3,
            };
            0x2::event::emit<RedeemEventV2<T0>>(v9);
            0x1::option::some<0x2::coin::Coin<T0>>(v8)
        } else if (0x2::table::contains<0x2::object::ID, 0x2::balance::Balance<T0>>(&v0.winning_tickets, v1)) {
            let v10 = 0x2::table::remove<0x2::object::ID, 0x2::balance::Balance<T0>>(&mut v0.winning_tickets, v1);
            let v11 = 0x2::coin::take<T0>(&mut v10, 0x2::balance::value<T0>(&v10), arg3);
            0x2::balance::destroy_zero<T0>(v10);
            let v12 = RedeemEventV2<T0>{
                player : 0x2::tx_context::sender(arg3),
                amount : 0x2::coin::value<T0>(&v11),
                picks  : v3,
            };
            0x2::event::emit<RedeemEventV2<T0>>(v12);
            0x1::option::some<0x2::coin::Coin<T0>>(v11)
        } else {
            let v13 = RedeemEventV2<T0>{
                player : 0x2::tx_context::sender(arg3),
                amount : 0,
                picks  : v3,
            };
            0x2::event::emit<RedeemEventV2<T0>>(v13);
            0x1::option::none<0x2::coin::Coin<T0>>()
        }
    }

    public fun redemptions_allowed_for_round<T0>(arg0: &Lottery<T0>, arg1: u64) : bool {
        *0x2::table::borrow<u64, bool>(&arg0.redemptions_allowed, arg1)
    }

    public fun remove_reward_structure<T0>(arg0: &LotteryStoreAdminCap, arg1: &mut Lottery<T0>, arg2: vector<RewardStructureInput>, arg3: &mut 0x2::tx_context::TxContext) {
        while (0x1::vector::length<RewardStructureInput>(&arg2) > 0) {
            let v0 = 0x1::vector::pop_back<RewardStructureInput>(&mut arg2);
            let v1 = RewardStructure{
                normal_ball_count  : v0.normal_ball_count,
                special_number_hit : v0.special_number_hit,
            };
            0x2::table::remove<RewardStructure, u64>(&mut arg1.reward_structure_table, v1);
        };
    }

    public fun remove_reward_structure_v2<T0>(arg0: &LotteryStoreAdminCap, arg1: &mut LotteryStore, arg2: 0x2::object::ID, arg3: vector<RewardStructureInput>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = borrow_mut_lottery<T0>(arg1, arg2);
        while (0x1::vector::length<RewardStructureInput>(&arg3) > 0) {
            let v1 = 0x1::vector::pop_back<RewardStructureInput>(&mut arg3);
            let v2 = RewardStructure{
                normal_ball_count  : v1.normal_ball_count,
                special_number_hit : v1.special_number_hit,
            };
            0x2::table::remove<RewardStructure, u64>(&mut v0.reward_structure_table, v2);
        };
    }

    public fun round_is_settled<T0>(arg0: &Lottery<T0>, arg1: u64) : bool {
        *0x2::table::borrow<u64, bool>(&arg0.rounds_settled, arg1)
    }

    fun select_numbers<T0>(arg0: &Lottery<T0>, arg1: vector<u8>) : Picks {
        let v0 = 0x2::vec_set::empty<u8>();
        let v1 = 0x5fad208418200537f2785aefdca3c8e15e2843ebdffd524956e6d6d6aca845a9::drand_lib::derive_randomness(arg1);
        let v2 = 0;
        while (v2 < arg0.normal_ball_count) {
            let v3 = v1;
            v1 = 0x5fad208418200537f2785aefdca3c8e15e2843ebdffd524956e6d6d6aca845a9::drand_lib::derive_randomness(v3);
            let v4 = (0x5fad208418200537f2785aefdca3c8e15e2843ebdffd524956e6d6d6aca845a9::drand_lib::safe_selection((arg0.max_normal_ball as u64), &v1) as u8);
            while (0x2::vec_set::contains<u8>(&v0, &v4)) {
                let v5 = v1;
                v1 = 0x5fad208418200537f2785aefdca3c8e15e2843ebdffd524956e6d6d6aca845a9::drand_lib::derive_randomness(v5);
                v4 = (0x5fad208418200537f2785aefdca3c8e15e2843ebdffd524956e6d6d6aca845a9::drand_lib::safe_selection((arg0.max_normal_ball as u64), &v1) as u8);
            };
            0x2::vec_set::insert<u8>(&mut v0, v4);
            v2 = v2 + 1;
        };
        let v6 = v1;
        v1 = 0x5fad208418200537f2785aefdca3c8e15e2843ebdffd524956e6d6d6aca845a9::drand_lib::derive_randomness(v6);
        Picks{
            numbers        : v0,
            special_number : (0x5fad208418200537f2785aefdca3c8e15e2843ebdffd524956e6d6d6aca845a9::drand_lib::safe_selection((arg0.max_special_ball as u64), &v1) as u8),
        }
    }

    public fun set_lottery<T0>(arg0: &LotteryStoreAdminCap, arg1: &mut LotteryStore, arg2: 0x2::object::ID, arg3: u64, arg4: u8, arg5: u8, arg6: u64) {
        let v0 = borrow_mut_lottery<T0>(arg1, arg2);
        v0.minimum_jackpot = arg3;
        v0.max_normal_ball = arg4;
        v0.max_special_ball = arg5;
        v0.ticket_cost = arg6;
    }

    public fun set_next_round_and_drawing_time<T0>(arg0: &mut LotteryStore, arg1: 0x2::object::ID, arg2: &LotteryStoreAdminCap, arg3: u64, arg4: u64) {
        let v0 = borrow_mut_lottery<T0>(arg0, arg1);
        assert!(redemptions_allowed_for_round<T0>(v0, v0.current_round), 6);
        assert!(0x2::table::length<0x2::object::ID, bool>(&v0.jackpot_winners) == 0, 8);
        v0.drawing_time_ms = arg3;
        v0.current_round = arg4;
        0x2::table::add<u64, bool>(&mut v0.rounds_settled, arg4, false);
        0x2::table::add<u64, bool>(&mut v0.redemptions_allowed, arg4, false);
        let v1 = RoundStarted<T0>{
            round             : arg4,
            lottery_id        : 0x2::object::id<Lottery<T0>>(v0),
            next_drawing_time : arg3,
        };
        0x2::event::emit<RoundStarted<T0>>(v1);
    }

    public fun set_reward_structure<T0>(arg0: &LotteryStoreAdminCap, arg1: &mut Lottery<T0>, arg2: vector<RewardStructureInput>, arg3: &mut 0x2::tx_context::TxContext) {
        while (0x1::vector::length<RewardStructureInput>(&arg2) > 0) {
            let v0 = 0x1::vector::pop_back<RewardStructureInput>(&mut arg2);
            let v1 = RewardStructure{
                normal_ball_count  : v0.normal_ball_count,
                special_number_hit : v0.special_number_hit,
            };
            0x2::table::add<RewardStructure, u64>(&mut arg1.reward_structure_table, v1, v0.balance_paid);
        };
    }

    public fun set_reward_structure_v2<T0>(arg0: &LotteryStoreAdminCap, arg1: &mut LotteryStore, arg2: 0x2::object::ID, arg3: vector<RewardStructureInput>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = borrow_mut_lottery<T0>(arg1, arg2);
        while (0x1::vector::length<RewardStructureInput>(&arg3) > 0) {
            let v1 = 0x1::vector::pop_back<RewardStructureInput>(&mut arg3);
            let v2 = RewardStructure{
                normal_ball_count  : v1.normal_ball_count,
                special_number_hit : v1.special_number_hit,
            };
            0x2::table::add<RewardStructure, u64>(&mut v0.reward_structure_table, v2, v1.balance_paid);
        };
    }

    public fun set_store_state(arg0: &LotteryStoreAdminCap, arg1: &mut LotteryStore, arg2: bool) {
        arg1.is_closed = arg2;
    }

    public fun settle_or_continue<T0>(arg0: &LotteryStoreAdminCap, arg1: &mut LotteryStore, arg2: 0x2::object::ID, arg3: vector<u8>, arg4: u64, arg5: 0x1::option::Option<u64>, arg6: &0x2::clock::Clock) {
        let v0 = borrow_mut_lottery<T0>(arg1, arg2);
        assert!(arg4 == v0.current_round, 7);
        assert!(!round_is_settled<T0>(v0, arg4), 6);
        0x5fad208418200537f2785aefdca3c8e15e2843ebdffd524956e6d6d6aca845a9::drand_lib::verify_drand_signature(arg3, v0.current_round);
        let v1 = select_numbers<T0>(v0, arg3);
        let v2 = 0;
        if (0x1::option::is_some<u64>(&arg5)) {
            v2 = 0x5fad208418200537f2785aefdca3c8e15e2843ebdffd524956e6d6d6aca845a9::big_queue::length<TicketReceipt>(&v0.tickets) - *0x1::option::borrow<u64>(&arg5);
        };
        while (0x5fad208418200537f2785aefdca3c8e15e2843ebdffd524956e6d6d6aca845a9::big_queue::length<TicketReceipt>(&v0.tickets) > v2) {
            let v3 = 0x5fad208418200537f2785aefdca3c8e15e2843ebdffd524956e6d6d6aca845a9::big_queue::pop_front<TicketReceipt>(&mut v0.tickets);
            let (v4, v5) = get_ticket_result<T0>(&v3, &v1, v0);
            if (v5) {
                0x2::table::add<0x2::object::ID, bool>(&mut v0.jackpot_winners, v3.original_ticket_id, true);
                continue
            };
            if (v4 > 0) {
                0x2::table::add<0x2::object::ID, 0x2::balance::Balance<T0>>(&mut v0.winning_tickets, v3.original_ticket_id, 0x2::balance::split<T0>(&mut v0.lottery_prize_pool, v4));
            };
        };
        if (0x5fad208418200537f2785aefdca3c8e15e2843ebdffd524956e6d6d6aca845a9::big_queue::length<TicketReceipt>(&v0.tickets) == 0) {
            *0x2::table::borrow_mut<u64, bool>(&mut v0.rounds_settled, arg4) = true;
            let v6 = RoundResult<T0>{
                round           : arg4,
                lottery_id      : 0x2::object::id<Lottery<T0>>(v0),
                results         : v1,
                timestamp_drawn : 0x2::clock::timestamp_ms(arg6),
            };
            0x2::event::emit<RoundResult<T0>>(v6);
        };
    }

    public fun transfer_optional_coin<T0>(arg0: &mut 0x1::option::Option<0x2::coin::Coin<T0>>, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x1::option::is_some<0x2::coin::Coin<T0>>(arg0)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x1::option::extract<0x2::coin::Coin<T0>>(arg0), 0x2::tx_context::sender(arg1));
        };
    }

    public fun withdraw_fees<T0>(arg0: &LotteryStoreAdminCap, arg1: &mut Lottery<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.lottery_fees, lottery_fees_value<T0>(arg1)), arg2)
    }

    public fun withdraw_fees_v2<T0>(arg0: &LotteryStoreAdminCap, arg1: &mut LotteryStore, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = borrow_mut_lottery<T0>(arg1, arg2);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v0.lottery_fees, lottery_fees_value<T0>(v0)), arg3)
    }

    // decompiled from Move bytecode v6
}

