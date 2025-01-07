module 0xff7fed37f3d61ca2cb7f2628f527e5c0a26294f1589c8565333aeb1a66b02c60::lottery {
    struct TicketPurchased has copy, drop, store {
        owner: address,
        picks: Picks,
        lottery_id: 0x2::object::ID,
        epoch: u64,
        timestamp_issued: u64,
        referrer: 0x1::option::Option<address>,
        coin_type: 0x1::string::String,
        origin: 0x1::string::String,
    }

    struct RoundResult has copy, drop, store {
        epoch: u64,
        lottery_id: 0x2::object::ID,
        results: Picks,
        timestamp_drawn: u64,
    }

    struct RoundStarted has copy, drop, store {
        epoch: u64,
        lottery_id: 0x2::object::ID,
    }

    struct LotteryCreated has copy, drop, store {
        lottery_id: 0x2::object::ID,
        initial_prize_amount: u64,
        epoch: u64,
    }

    struct RedeemEvent has copy, drop {
        lottery_id: 0x2::object::ID,
        player: address,
        amount: u64,
        epoch: u64,
        picks: 0x1::option::Option<Picks>,
        timestamp_issued: 0x1::option::Option<u64>,
    }

    struct LOTTERY has drop {
        dummy_field: bool,
    }

    struct LotteryStoreAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct LotterySuperAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct LotteryStore has store, key {
        id: 0x2::object::UID,
        version_set: 0x2::vec_set::VecSet<u64>,
        is_closed: bool,
    }

    struct AlternativePrice<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        ticket_cost: u64,
    }

    struct Lottery<phantom T0> has store, key {
        id: 0x2::object::UID,
        lottery_prize_pool: 0x2::balance::Balance<T0>,
        lottery_prize_pool_size: u64,
        minimum_jackpot: u64,
        lottery_fees: 0x2::balance::Balance<T0>,
        current_epoch: u64,
        current_round_picks: 0x1::option::Option<Picks>,
        status: u64,
        referral_rate: u64,
        ticket_cost: u64,
        reward_structure_table: 0x2::table::Table<RewardStructure, u64>,
        normal_ball_count: u8,
        max_normal_ball: u8,
        max_special_ball: u8,
        tickets: 0xff7fed37f3d61ca2cb7f2628f527e5c0a26294f1589c8565333aeb1a66b02c60::big_queue::BigQueue<Ticket<T0>>,
        ticket_history: 0x2::linked_table::LinkedTable<address, 0x2::linked_table::LinkedTable<u64, 0xff7fed37f3d61ca2cb7f2628f527e5c0a26294f1589c8565333aeb1a66b02c60::big_queue::BigQueue<TicketHistory>>>,
        picks_history: 0x2::table::Table<u64, Picks>,
        winning_tickets: 0x2::table::Table<address, vector<Ticket<T0>>>,
        jackpot_winners: vector<address>,
        epochs_settled: 0x2::table::Table<u64, bool>,
        redemptions_allowed: 0x2::table::Table<u64, bool>,
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

    struct Ticket<phantom T0> has store {
        owner: address,
        picks: Picks,
        lottery_id: 0x2::object::ID,
        epoch: u64,
        timestamp_issued: u64,
        origin: 0x1::string::String,
        winning_balance: 0x1::option::Option<0x2::balance::Balance<T0>>,
    }

    struct TicketHistory has copy, drop, store {
        owner: address,
        picks: Picks,
        lottery_id: 0x2::object::ID,
        epoch: u64,
        timestamp_issued: u64,
        origin: 0x1::string::String,
    }

    struct DoubleUpLottery has drop {
        dummy_field: bool,
    }

    struct LotterySheet<phantom T0> has store, key {
        id: 0x2::object::UID,
        sheet: 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Sheet<DoubleUpLottery, T0>,
    }

    fun delete<T0>(arg0: &mut LotteryStore, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(lottery_exists<T0>(arg0, arg1), 9);
        assert!(!arg0.is_closed, 13);
        let Lottery {
            id                      : v0,
            lottery_prize_pool      : v1,
            lottery_prize_pool_size : _,
            minimum_jackpot         : _,
            lottery_fees            : v4,
            current_epoch           : _,
            current_round_picks     : _,
            status                  : v7,
            referral_rate           : _,
            ticket_cost             : _,
            reward_structure_table  : v10,
            normal_ball_count       : _,
            max_normal_ball         : _,
            max_special_ball        : _,
            tickets                 : v14,
            ticket_history          : v15,
            picks_history           : v16,
            winning_tickets         : v17,
            jackpot_winners         : _,
            epochs_settled          : v19,
            redemptions_allowed     : v20,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, Lottery<T0>>(&mut arg0.id, arg1);
        let v21 = v17;
        let v22 = v15;
        let v23 = v14;
        let v24 = v4;
        let v25 = v1;
        assert!(v7 == 106, 9223377126391021567);
        assert!(0x2::table::length<address, vector<Ticket<T0>>>(&v21) == 0, 17);
        if (0x2::balance::value<T0>(&v25) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v25, arg2), 0x2::tx_context::sender(arg2));
        } else {
            0x2::balance::destroy_zero<T0>(v25);
        };
        if (0x2::balance::value<T0>(&v24) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v24, arg2), 0x2::tx_context::sender(arg2));
        } else {
            0x2::balance::destroy_zero<T0>(v24);
        };
        0x2::table::destroy_empty<address, vector<Ticket<T0>>>(v21);
        while (0xff7fed37f3d61ca2cb7f2628f527e5c0a26294f1589c8565333aeb1a66b02c60::big_queue::length<Ticket<T0>>(&v23) > 0) {
            destroy<T0>(0xff7fed37f3d61ca2cb7f2628f527e5c0a26294f1589c8565333aeb1a66b02c60::big_queue::pop_front<Ticket<T0>>(&mut v23));
        };
        0xff7fed37f3d61ca2cb7f2628f527e5c0a26294f1589c8565333aeb1a66b02c60::big_queue::destroy_empty<Ticket<T0>>(v23);
        while (0x2::linked_table::length<address, 0x2::linked_table::LinkedTable<u64, 0xff7fed37f3d61ca2cb7f2628f527e5c0a26294f1589c8565333aeb1a66b02c60::big_queue::BigQueue<TicketHistory>>>(&v22) > 0) {
            let (_, v27) = 0x2::linked_table::pop_front<address, 0x2::linked_table::LinkedTable<u64, 0xff7fed37f3d61ca2cb7f2628f527e5c0a26294f1589c8565333aeb1a66b02c60::big_queue::BigQueue<TicketHistory>>>(&mut v22);
            let v28 = v27;
            while (0x2::linked_table::length<u64, 0xff7fed37f3d61ca2cb7f2628f527e5c0a26294f1589c8565333aeb1a66b02c60::big_queue::BigQueue<TicketHistory>>(&v28) > 0) {
                let (_, v30) = 0x2::linked_table::pop_front<u64, 0xff7fed37f3d61ca2cb7f2628f527e5c0a26294f1589c8565333aeb1a66b02c60::big_queue::BigQueue<TicketHistory>>(&mut v28);
                0xff7fed37f3d61ca2cb7f2628f527e5c0a26294f1589c8565333aeb1a66b02c60::big_queue::drop<TicketHistory>(v30);
            };
            0x2::linked_table::destroy_empty<u64, 0xff7fed37f3d61ca2cb7f2628f527e5c0a26294f1589c8565333aeb1a66b02c60::big_queue::BigQueue<TicketHistory>>(v28);
        };
        0x2::linked_table::destroy_empty<address, 0x2::linked_table::LinkedTable<u64, 0xff7fed37f3d61ca2cb7f2628f527e5c0a26294f1589c8565333aeb1a66b02c60::big_queue::BigQueue<TicketHistory>>>(v22);
        0x2::table::drop<RewardStructure, u64>(v10);
        0x2::table::drop<u64, Picks>(v16);
        0x2::table::drop<u64, bool>(v19);
        0x2::table::drop<u64, bool>(v20);
        0x2::object::delete(v0);
    }

    public fun id<T0>(arg0: &Lottery<T0>) : 0x2::object::ID {
        0x2::object::id<Lottery<T0>>(arg0)
    }

    public fun collect<T0, T1: drop>(arg0: &mut LotteryStore, arg1: 0x2::object::ID, arg2: &mut LotterySheet<T0>, arg3: 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Collector<DoubleUpLottery, T1, T0>) {
        let v0 = DoubleUpLottery{dummy_field: false};
        0x2::balance::join<T0>(&mut borrow_mut_lottery<T0>(arg0, arg1).lottery_prize_pool, 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::collect<DoubleUpLottery, T1, T0>(&mut arg2.sheet, arg3, v0));
    }

    public fun dun<T0, T1: drop>(arg0: &LotterySuperAdminCap, arg1: u64) : 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Collector<DoubleUpLottery, T1, T0> {
        let v0 = DoubleUpLottery{dummy_field: false};
        0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::dun<DoubleUpLottery, T1, T0>(arg1, v0)
    }

    public fun loan<T0, T1: drop>(arg0: &mut LotteryStore, arg1: 0x2::object::ID, arg2: &LotterySuperAdminCap, arg3: &mut LotterySheet<T0>, arg4: u64) : 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Loan<DoubleUpLottery, T1, T0> {
        let v0 = DoubleUpLottery{dummy_field: false};
        0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::loan<DoubleUpLottery, T1, T0>(&mut arg3.sheet, 0x2::balance::split<T0>(&mut borrow_mut_lottery<T0>(arg0, arg1).lottery_prize_pool, arg4), v0)
    }

    public fun add_ticket_cost<T0, T1>(arg0: &LotteryStoreAdminCap, arg1: &mut LotteryStore, arg2: 0x2::object::ID, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T1>();
        let v1 = borrow_mut_lottery<T0>(arg1, arg2);
        assert!(!0x2::dynamic_object_field::exists_with_type<0x1::type_name::TypeName, AlternativePrice<T1>>(&v1.id, v0), 18);
        let v2 = AlternativePrice<T1>{
            id          : 0x2::object::new(arg4),
            balance     : 0x2::balance::zero<T1>(),
            ticket_cost : arg3,
        };
        0x2::dynamic_object_field::add<0x1::type_name::TypeName, AlternativePrice<T1>>(&mut v1.id, v0, v2);
    }

    public fun add_version(arg0: &LotteryStoreAdminCap, arg1: &mut LotteryStore, arg2: u64) {
        0x2::vec_set::insert<u64>(&mut arg1.version_set, arg2);
    }

    public fun admin_end_lottery<T0>(arg0: &mut LotteryStore, arg1: 0x2::object::ID, arg2: &LotterySuperAdminCap) {
        assert_valid_version(arg0);
        borrow_mut_lottery<T0>(arg0, arg1).status = 106;
    }

    public fun admin_redeem_for_winner<T0>(arg0: &mut LotteryStore, arg1: 0x2::object::ID, arg2: &LotterySuperAdminCap, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert_valid_version(arg0);
        let v0 = borrow_mut_lottery<T0>(arg0, arg1);
        if (!0x2::table::contains<address, vector<Ticket<T0>>>(&v0.winning_tickets, arg3)) {
            abort 15
        };
        let v1 = 0x2::table::borrow_mut<address, vector<Ticket<T0>>>(&mut v0.winning_tickets, arg3);
        let v2 = 0x1::vector::length<Ticket<T0>>(v1);
        let v3 = 0x2::balance::zero<T0>();
        while (v2 > 0) {
            let v4 = 0x1::vector::remove<Ticket<T0>>(v1, v2 - 1);
            assert!(v4.lottery_id == arg1, 4);
            let v5 = 0x1::option::extract<0x2::balance::Balance<T0>>(&mut v4.winning_balance);
            0x2::balance::join<T0>(&mut v3, v5);
            let v6 = RedeemEvent{
                lottery_id       : arg1,
                player           : arg3,
                amount           : 0x2::balance::value<T0>(&v5),
                epoch            : v4.epoch,
                picks            : 0x1::option::some<Picks>(v4.picks),
                timestamp_issued : 0x1::option::some<u64>(v4.timestamp_issued),
            };
            0x2::event::emit<RedeemEvent>(v6);
            destroy<T0>(v4);
            v2 = v2 - 1;
        };
        0x2::balance::destroy_zero<T0>(v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut v3, 0x2::balance::value<T0>(&v3), arg4), arg3);
    }

    public fun allow_redemptions_for_round<T0>(arg0: &LotteryStoreAdminCap, arg1: &mut LotteryStore, arg2: 0x2::object::ID, arg3: u64) {
        assert_valid_version(arg1);
        let v0 = borrow_mut_lottery<T0>(arg1, arg2);
        assert!(epoch_is_settled<T0>(v0, arg3), 6);
        assert!(v0.status == 104 || v0.status == 105, 6);
        assert!(0x1::option::is_none<Picks>(&v0.current_round_picks), 6);
        if (v0.status == 105) {
            assert!(0x2::balance::value<T0>(&v0.lottery_prize_pool) >= v0.minimum_jackpot, 5);
        };
        *0x2::table::borrow_mut<u64, bool>(&mut v0.redemptions_allowed, arg3) = true;
    }

    public fun alternative_price<T0, T1>(arg0: &Lottery<T0>, arg1: 0x1::type_name::TypeName) : &AlternativePrice<T1> {
        0x2::dynamic_object_field::borrow<0x1::type_name::TypeName, AlternativePrice<T1>>(&arg0.id, arg1)
    }

    fun alternative_price_mut<T0, T1>(arg0: &mut Lottery<T0>, arg1: 0x1::type_name::TypeName) : &mut AlternativePrice<T1> {
        0x2::dynamic_object_field::borrow_mut<0x1::type_name::TypeName, AlternativePrice<T1>>(&mut arg0.id, arg1)
    }

    fun assert_valid_version(arg0: &LotteryStore) {
        let v0 = package_version();
        assert!(0x2::vec_set::contains<u64>(&arg0.version_set, &v0), 14);
    }

    public fun borrow_lottery<T0>(arg0: &LotteryStore, arg1: 0x2::object::ID) : &Lottery<T0> {
        0x2::dynamic_object_field::borrow<0x2::object::ID, Lottery<T0>>(&arg0.id, arg1)
    }

    fun borrow_mut_lottery<T0>(arg0: &mut LotteryStore, arg1: 0x2::object::ID) : &mut Lottery<T0> {
        assert!(lottery_exists<T0>(arg0, arg1), 9);
        assert!(!arg0.is_closed, 13);
        0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Lottery<T0>>(&mut arg0.id, arg1)
    }

    public fun buy_ticket<T0>(arg0: &mut LotteryStore, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T0>, arg3: address, arg4: vector<u8>, arg5: u8, arg6: 0x1::string::String, arg7: 0x1::option::Option<address>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert_valid_version(arg0);
        let v0 = borrow_mut_lottery<T0>(arg0, arg1);
        let v1 = 0x2::coin::value<T0>(&arg2);
        assert!(v1 == v0.ticket_cost, 1);
        let v2 = 0x2::coin::into_balance<T0>(arg2);
        let v3 = if (0x1::option::is_some<address>(&arg7)) {
            let v4 = 0x1::option::extract<address>(&mut arg7);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v2, v1 * v0.referral_rate / 10000), arg9), v4);
            0x1::option::some<address>(v4)
        } else {
            0x1::option::none<address>()
        };
        0x1::option::destroy_none<address>(arg7);
        0x2::balance::join<T0>(&mut v0.lottery_prize_pool, 0x2::balance::split<T0>(&mut v2, v1 / 2));
        0x2::balance::join<T0>(&mut v0.lottery_fees, v2);
        v0.lottery_prize_pool_size = v0.lottery_prize_pool_size + v1 / 2;
        buy_ticket_internal<T0>(v0, arg3, arg4, arg5, arg6, arg8, v3, 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())), arg9);
    }

    public fun buy_ticket_alternative_price<T0, T1>(arg0: &mut LotteryStore, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T1>, arg3: address, arg4: vector<u8>, arg5: u8, arg6: 0x1::string::String, arg7: 0x1::option::Option<address>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert_valid_version(arg0);
        let v0 = borrow_mut_lottery<T0>(arg0, arg1);
        let v1 = 0x2::coin::value<T1>(&arg2);
        let v2 = 0x2::coin::into_balance<T1>(arg2);
        let v3 = if (0x1::option::is_some<address>(&arg7)) {
            let v4 = 0x1::option::extract<address>(&mut arg7);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v2, v1 * v0.referral_rate / 10000), arg9), v4);
            0x1::option::some<address>(v4)
        } else {
            0x1::option::none<address>()
        };
        0x1::option::destroy_none<address>(arg7);
        let v5 = 0x1::type_name::get<T1>();
        buy_ticket_internal<T0>(v0, arg3, arg4, arg5, arg6, arg8, v3, 0x1::string::from_ascii(0x1::type_name::into_string(v5)), arg9);
        let v6 = alternative_price_mut<T0, T1>(v0, v5);
        assert!(v1 == v6.ticket_cost, 1);
        0x2::balance::join<T1>(&mut v6.balance, v2);
    }

    fun buy_ticket_internal<T0>(arg0: &mut Lottery<T0>, arg1: address, arg2: vector<u8>, arg3: u8, arg4: 0x1::string::String, arg5: &0x2::clock::Clock, arg6: 0x1::option::Option<address>, arg7: 0x1::string::String, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.current_epoch;
        let v1 = 0x2::tx_context::epoch(arg8);
        assert!(v1 == v0, 0);
        assert!(arg0.status == 100, 0);
        assert!(!epoch_is_settled<T0>(arg0, v0), 6);
        assert!(!redemptions_allowed_for_epoch<T0>(arg0, v0), 6);
        check_is_valid_numbers<T0>(arg2, arg3, arg0);
        assert!(0x1::option::is_none<Picks>(&arg0.current_round_picks), 6);
        assert!(arg3 < arg0.max_special_ball, 1);
        let v2 = 0x2::vec_set::empty<u8>();
        while (0x1::vector::length<u8>(&arg2) > 0) {
            let v3 = 0x1::vector::pop_back<u8>(&mut arg2);
            assert!(v3 < arg0.max_normal_ball, 1);
            0x2::vec_set::insert<u8>(&mut v2, v3);
        };
        let v4 = Picks{
            numbers        : v2,
            special_number : arg3,
        };
        let v5 = Ticket<T0>{
            owner            : arg1,
            picks            : v4,
            lottery_id       : id<T0>(arg0),
            epoch            : arg0.current_epoch,
            timestamp_issued : 0x2::clock::timestamp_ms(arg5),
            origin           : arg4,
            winning_balance  : 0x1::option::none<0x2::balance::Balance<T0>>(),
        };
        0xff7fed37f3d61ca2cb7f2628f527e5c0a26294f1589c8565333aeb1a66b02c60::big_queue::push_back<Ticket<T0>>(&mut arg0.tickets, v5);
        let v6 = TicketHistory{
            owner            : arg1,
            picks            : v4,
            lottery_id       : id<T0>(arg0),
            epoch            : arg0.current_epoch,
            timestamp_issued : 0x2::clock::timestamp_ms(arg5),
            origin           : arg4,
        };
        if (0x2::linked_table::contains<address, 0x2::linked_table::LinkedTable<u64, 0xff7fed37f3d61ca2cb7f2628f527e5c0a26294f1589c8565333aeb1a66b02c60::big_queue::BigQueue<TicketHistory>>>(&arg0.ticket_history, arg1)) {
            let v7 = 0x2::linked_table::borrow_mut<address, 0x2::linked_table::LinkedTable<u64, 0xff7fed37f3d61ca2cb7f2628f527e5c0a26294f1589c8565333aeb1a66b02c60::big_queue::BigQueue<TicketHistory>>>(&mut arg0.ticket_history, arg1);
            if (0x2::linked_table::contains<u64, 0xff7fed37f3d61ca2cb7f2628f527e5c0a26294f1589c8565333aeb1a66b02c60::big_queue::BigQueue<TicketHistory>>(v7, v1)) {
                0xff7fed37f3d61ca2cb7f2628f527e5c0a26294f1589c8565333aeb1a66b02c60::big_queue::push_back<TicketHistory>(0x2::linked_table::borrow_mut<u64, 0xff7fed37f3d61ca2cb7f2628f527e5c0a26294f1589c8565333aeb1a66b02c60::big_queue::BigQueue<TicketHistory>>(v7, v1), v6);
            } else {
                let v8 = 0xff7fed37f3d61ca2cb7f2628f527e5c0a26294f1589c8565333aeb1a66b02c60::big_queue::new<TicketHistory>(5000, arg8);
                0xff7fed37f3d61ca2cb7f2628f527e5c0a26294f1589c8565333aeb1a66b02c60::big_queue::push_back<TicketHistory>(&mut v8, v6);
                0x2::linked_table::push_back<u64, 0xff7fed37f3d61ca2cb7f2628f527e5c0a26294f1589c8565333aeb1a66b02c60::big_queue::BigQueue<TicketHistory>>(v7, v1, v8);
            };
        } else {
            let v9 = 0x2::linked_table::new<u64, 0xff7fed37f3d61ca2cb7f2628f527e5c0a26294f1589c8565333aeb1a66b02c60::big_queue::BigQueue<TicketHistory>>(arg8);
            let v10 = 0xff7fed37f3d61ca2cb7f2628f527e5c0a26294f1589c8565333aeb1a66b02c60::big_queue::new<TicketHistory>(5000, arg8);
            0xff7fed37f3d61ca2cb7f2628f527e5c0a26294f1589c8565333aeb1a66b02c60::big_queue::push_back<TicketHistory>(&mut v10, v6);
            0x2::linked_table::push_back<u64, 0xff7fed37f3d61ca2cb7f2628f527e5c0a26294f1589c8565333aeb1a66b02c60::big_queue::BigQueue<TicketHistory>>(&mut v9, v1, v10);
            0x2::linked_table::push_back<address, 0x2::linked_table::LinkedTable<u64, 0xff7fed37f3d61ca2cb7f2628f527e5c0a26294f1589c8565333aeb1a66b02c60::big_queue::BigQueue<TicketHistory>>>(&mut arg0.ticket_history, arg1, v9);
        };
        let v11 = TicketPurchased{
            owner            : arg1,
            picks            : v4,
            lottery_id       : id<T0>(arg0),
            epoch            : arg0.current_epoch,
            timestamp_issued : 0x2::clock::timestamp_ms(arg5),
            referrer         : arg6,
            coin_type        : arg7,
            origin           : arg4,
        };
        0x2::event::emit<TicketPurchased>(v11);
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

    public fun create_lottery<T0>(arg0: &LotteryStoreAdminCap, arg1: &mut LotteryStore, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_valid_version(arg1);
        let v0 = 0x2::coin::value<T0>(&arg2);
        let v1 = 0x2::object::new(arg5);
        let v2 = 0x2::object::uid_to_inner(&v1);
        let v3 = 0x2::tx_context::epoch(arg5);
        let v4 = new_reward_structure_input_vector(x"0001020203030404050506", vector[true, true, false, true, false, true, false, true, false, true, false], vector[2000000000, 4000000000, 1000000000, 10000000000, 8000000000, 25000000000, 50000000000, 500000000000, 5000000000000, 20000000000000, 200000000000000]);
        let v5 = 0x2::table::new<RewardStructure, u64>(arg5);
        while (0x1::vector::length<RewardStructureInput>(&v4) > 0) {
            let v6 = 0x1::vector::pop_back<RewardStructureInput>(&mut v4);
            let v7 = RewardStructure{
                normal_ball_count  : v6.normal_ball_count,
                special_number_hit : v6.special_number_hit,
            };
            0x2::table::add<RewardStructure, u64>(&mut v5, v7, v6.balance_paid);
        };
        let v8 = Lottery<T0>{
            id                      : v1,
            lottery_prize_pool      : 0x2::coin::into_balance<T0>(arg2),
            lottery_prize_pool_size : v0,
            minimum_jackpot         : arg3,
            lottery_fees            : 0x2::balance::zero<T0>(),
            current_epoch           : v3,
            current_round_picks     : 0x1::option::none<Picks>(),
            status                  : 100,
            referral_rate           : 500,
            ticket_cost             : arg4,
            reward_structure_table  : v5,
            normal_ball_count       : 6,
            max_normal_ball         : 42,
            max_special_ball        : 10,
            tickets                 : 0xff7fed37f3d61ca2cb7f2628f527e5c0a26294f1589c8565333aeb1a66b02c60::big_queue::new<Ticket<T0>>(5000, arg5),
            ticket_history          : 0x2::linked_table::new<address, 0x2::linked_table::LinkedTable<u64, 0xff7fed37f3d61ca2cb7f2628f527e5c0a26294f1589c8565333aeb1a66b02c60::big_queue::BigQueue<TicketHistory>>>(arg5),
            picks_history           : 0x2::table::new<u64, Picks>(arg5),
            winning_tickets         : 0x2::table::new<address, vector<Ticket<T0>>>(arg5),
            jackpot_winners         : 0x1::vector::empty<address>(),
            epochs_settled          : 0x2::table::new<u64, bool>(arg5),
            redemptions_allowed     : 0x2::table::new<u64, bool>(arg5),
        };
        0x2::table::add<u64, bool>(&mut v8.redemptions_allowed, v3, false);
        0x2::table::add<u64, bool>(&mut v8.epochs_settled, v3, false);
        0x2::dynamic_object_field::add<0x2::object::ID, Lottery<T0>>(&mut arg1.id, v2, v8);
        let v9 = LotteryCreated{
            lottery_id           : v2,
            initial_prize_amount : v0,
            epoch                : v3,
        };
        0x2::event::emit<LotteryCreated>(v9);
        v2
    }

    public fun create_sheet<T0>(arg0: &LotterySuperAdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = DoubleUpLottery{dummy_field: false};
        let v1 = LotterySheet<T0>{
            id    : 0x2::object::new(arg1),
            sheet : 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::new<DoubleUpLottery, T0>(v0),
        };
        0x2::transfer::share_object<LotterySheet<T0>>(v1);
    }

    public fun create_store(arg0: &LotteryStoreAdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = LotteryStore{
            id          : 0x2::object::new(arg1),
            version_set : 0x2::vec_set::singleton<u64>(2),
            is_closed   : true,
        };
        0x2::transfer::share_object<LotteryStore>(v0);
    }

    public fun delete_lottery<T0>(arg0: &mut LotteryStore, arg1: 0x2::object::ID, arg2: &LotteryStoreAdminCap, arg3: &mut 0x2::tx_context::TxContext) {
        assert_valid_version(arg0);
        delete<T0>(arg0, arg1, arg3);
    }

    fun destroy<T0>(arg0: Ticket<T0>) {
        let Ticket {
            owner            : _,
            picks            : _,
            lottery_id       : _,
            epoch            : _,
            timestamp_issued : _,
            origin           : _,
            winning_balance  : v6,
        } = arg0;
        let v7 = v6;
        if (0x1::option::is_some<0x2::balance::Balance<T0>>(&v7)) {
            0x2::balance::destroy_zero<T0>(0x1::option::extract<0x2::balance::Balance<T0>>(&mut v7));
            0x1::option::destroy_none<0x2::balance::Balance<T0>>(v7);
        } else {
            0x1::option::destroy_none<0x2::balance::Balance<T0>>(v7);
        };
    }

    public fun dun_all<T0, T1: drop>(arg0: &LotterySuperAdminCap, arg1: &LotterySheet<T0>) : 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Collector<DoubleUpLottery, T1, T0> {
        let v0 = 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::debtor<T1>();
        let v1 = DoubleUpLottery{dummy_field: false};
        0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::dun<DoubleUpLottery, T1, T0>(0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::credit_value<T0>(0x2::vec_map::get<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Debtor, 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Credit<T0>>(0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::credits<DoubleUpLottery, T0>(&arg1.sheet), &v0)), v1)
    }

    public fun epoch_is_settled<T0>(arg0: &Lottery<T0>, arg1: u64) : bool {
        *0x2::table::borrow<u64, bool>(&arg0.epochs_settled, arg1)
    }

    public fun get_lottery_queue_size<T0>(arg0: &LotteryStore, arg1: 0x2::object::ID) : u64 {
        assert!(lottery_exists<T0>(arg0, arg1), 9);
        0xff7fed37f3d61ca2cb7f2628f527e5c0a26294f1589c8565333aeb1a66b02c60::big_queue::length<Ticket<T0>>(&0x2::dynamic_object_field::borrow<0x2::object::ID, Lottery<T0>>(&arg0.id, arg1).tickets)
    }

    public fun get_pick_for_round<T0>(arg0: &LotteryStore, arg1: 0x2::object::ID, arg2: u64) : &Picks {
        0x2::table::borrow<u64, Picks>(&0x2::dynamic_object_field::borrow<0x2::object::ID, Lottery<T0>>(&arg0.id, arg1).picks_history, arg2)
    }

    public fun get_picks_for_epoch<T0>(arg0: &LotteryStore, arg1: 0x2::object::ID, arg2: u64) : (u8, u8, u8, u8, u8, u8, u8) {
        let v0 = 0x2::table::borrow<u64, Picks>(&0x2::dynamic_object_field::borrow<0x2::object::ID, Lottery<T0>>(&arg0.id, arg1).picks_history, arg2);
        let v1 = 0x2::vec_set::keys<u8>(&v0.numbers);
        (*0x1::vector::borrow<u8>(v1, 0), *0x1::vector::borrow<u8>(v1, 1), *0x1::vector::borrow<u8>(v1, 2), *0x1::vector::borrow<u8>(v1, 3), *0x1::vector::borrow<u8>(v1, 4), *0x1::vector::borrow<u8>(v1, 5), v0.special_number)
    }

    public fun get_player_ticket_history_for_round<T0>(arg0: &LotteryStore, arg1: 0x2::object::ID, arg2: address, arg3: u64) : &0xff7fed37f3d61ca2cb7f2628f527e5c0a26294f1589c8565333aeb1a66b02c60::big_queue::BigQueue<TicketHistory> {
        0x2::linked_table::borrow<u64, 0xff7fed37f3d61ca2cb7f2628f527e5c0a26294f1589c8565333aeb1a66b02c60::big_queue::BigQueue<TicketHistory>>(0x2::linked_table::borrow<address, 0x2::linked_table::LinkedTable<u64, 0xff7fed37f3d61ca2cb7f2628f527e5c0a26294f1589c8565333aeb1a66b02c60::big_queue::BigQueue<TicketHistory>>>(&0x2::dynamic_object_field::borrow<0x2::object::ID, Lottery<T0>>(&arg0.id, arg1).ticket_history, arg2), arg3)
    }

    public fun get_player_ticket_history_total<T0>(arg0: &LotteryStore, arg1: 0x2::object::ID, arg2: address) : &0x2::linked_table::LinkedTable<u64, 0xff7fed37f3d61ca2cb7f2628f527e5c0a26294f1589c8565333aeb1a66b02c60::big_queue::BigQueue<TicketHistory>> {
        0x2::linked_table::borrow<address, 0x2::linked_table::LinkedTable<u64, 0xff7fed37f3d61ca2cb7f2628f527e5c0a26294f1589c8565333aeb1a66b02c60::big_queue::BigQueue<TicketHistory>>>(&0x2::dynamic_object_field::borrow<0x2::object::ID, Lottery<T0>>(&arg0.id, arg1).ticket_history, arg2)
    }

    fun get_ticket_result<T0>(arg0: Picks, arg1: &Picks, arg2: &Lottery<T0>) : (u64, bool) {
        let v0 = 0;
        let v1 = 0x2::vec_set::into_keys<u8>(arg0.numbers);
        while (0x1::vector::length<u8>(&v1) > 0) {
            let v2 = 0x1::vector::pop_back<u8>(&mut v1);
            if (0x2::vec_set::contains<u8>(&arg1.numbers, &v2)) {
                v0 = v0 + 1;
            };
        };
        let v3 = false;
        if (arg0.special_number == arg1.special_number) {
            v3 = true;
        };
        if (v0 == arg2.normal_ball_count && v3) {
            return (0, true)
        };
        let v4 = RewardStructure{
            normal_ball_count  : v0,
            special_number_hit : v3,
        };
        if (0x2::table::contains<RewardStructure, u64>(&arg2.reward_structure_table, v4)) {
            return (*0x2::table::borrow<RewardStructure, u64>(&arg2.reward_structure_table, v4), false)
        };
        (0, false)
    }

    fun init(arg0: LOTTERY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = LotteryStoreAdminCap{id: 0x2::object::new(arg1)};
        let v2 = LotterySuperAdminCap{id: 0x2::object::new(arg1)};
        0x2::package::claim_and_keep<LOTTERY>(arg0, arg1);
        0x2::transfer::transfer<LotteryStoreAdminCap>(v1, v0);
        0x2::transfer::transfer<LotterySuperAdminCap>(v2, v0);
    }

    public fun jackpot_winners<T0>(arg0: &LotteryStore, arg1: 0x2::object::ID) : &vector<address> {
        &0x2::dynamic_object_field::borrow<0x2::object::ID, Lottery<T0>>(&arg0.id, arg1).jackpot_winners
    }

    public fun loan_all<T0, T1: drop>(arg0: &mut LotteryStore, arg1: 0x2::object::ID, arg2: &LotterySuperAdminCap, arg3: &mut LotterySheet<T0>) : 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Loan<DoubleUpLottery, T1, T0> {
        let v0 = borrow_mut_lottery<T0>(arg0, arg1);
        let v1 = DoubleUpLottery{dummy_field: false};
        0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::loan<DoubleUpLottery, T1, T0>(&mut arg3.sheet, 0x2::balance::split<T0>(&mut v0.lottery_prize_pool, 0x2::balance::value<T0>(&v0.lottery_prize_pool)), v1)
    }

    public fun lottery_current_epoch<T0>(arg0: &LotteryStore, arg1: 0x2::object::ID) : u64 {
        0x2::dynamic_object_field::borrow<0x2::object::ID, Lottery<T0>>(&arg0.id, arg1).current_epoch
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
        0x2::balance::value<T0>(&borrow_lottery<T0>(arg0, arg1).lottery_prize_pool)
    }

    public fun lottery_prize_pool_size<T0>(arg0: &LotteryStore, arg1: 0x2::object::ID) : u64 {
        0x2::dynamic_object_field::borrow<0x2::object::ID, Lottery<T0>>(&arg0.id, arg1).lottery_prize_pool_size
    }

    public fun lottery_status<T0>(arg0: &Lottery<T0>) : u64 {
        arg0.status
    }

    public fun mint_duplicate_admin_caps(arg0: &LotteryStoreAdminCap, arg1: &mut 0x2::tx_context::TxContext) : LotteryStoreAdminCap {
        LotteryStoreAdminCap{id: 0x2::object::new(arg1)}
    }

    fun new_reward_structure_input_vector(arg0: vector<u8>, arg1: vector<bool>, arg2: vector<u64>) : vector<RewardStructureInput> {
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

    public fun package_version() : u64 {
        2
    }

    public fun payout_jackpot_end_lottery<T0>(arg0: &mut LotteryStore, arg1: 0x2::object::ID, arg2: &LotterySuperAdminCap, arg3: &mut 0x2::tx_context::TxContext) {
        assert_valid_version(arg0);
        let v0 = borrow_mut_lottery<T0>(arg0, arg1);
        assert!(v0.status == 105, 16);
        while (0x1::vector::length<address>(&v0.jackpot_winners) > 0) {
            let v1 = 0x1::vector::pop_back<address>(&mut v0.jackpot_winners);
            let v2 = 0x2::coin::take<T0>(&mut v0.lottery_prize_pool, 0x2::balance::value<T0>(&v0.lottery_prize_pool) / 0x1::vector::length<address>(&v0.jackpot_winners), arg3);
            let v3 = 0x2::coin::value<T0>(&v2);
            v0.lottery_prize_pool_size = v0.lottery_prize_pool_size - v3;
            let v4 = RedeemEvent{
                lottery_id       : arg1,
                player           : v1,
                amount           : v3,
                epoch            : v0.current_epoch,
                picks            : 0x1::option::none<Picks>(),
                timestamp_issued : 0x1::option::none<u64>(),
            };
            0x2::event::emit<RedeemEvent>(v4);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, v1);
        };
        assert!(0x2::balance::value<T0>(&v0.lottery_prize_pool) == 0, 17);
        v0.status = 106;
    }

    public fun picks_history<T0>(arg0: &LotteryStore, arg1: 0x2::object::ID) : &0x2::table::Table<u64, Picks> {
        &0x2::dynamic_object_field::borrow<0x2::object::ID, Lottery<T0>>(&arg0.id, arg1).picks_history
    }

    public fun redeem<T0>(arg0: &mut LotteryStore, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert_valid_version(arg0);
        let v0 = borrow_mut_lottery<T0>(arg0, arg1);
        assert!(redemptions_allowed_for_epoch<T0>(v0, arg2), 6);
        let v1 = 0x2::tx_context::sender(arg3);
        if (!0x2::table::contains<address, vector<Ticket<T0>>>(&v0.winning_tickets, v1)) {
            abort 15
        };
        let v2 = 0x2::table::borrow_mut<address, vector<Ticket<T0>>>(&mut v0.winning_tickets, v1);
        let v3 = 0x1::vector::length<Ticket<T0>>(v2);
        let v4 = 0x2::balance::zero<T0>();
        while (v3 > 0) {
            if (0x1::vector::borrow<Ticket<T0>>(v2, v3 - 1).epoch == arg2) {
                let v5 = 0x1::vector::remove<Ticket<T0>>(v2, v3 - 1);
                assert!(v5.lottery_id == arg1, 4);
                let v6 = 0x1::option::extract<0x2::balance::Balance<T0>>(&mut v5.winning_balance);
                0x2::balance::join<T0>(&mut v4, v6);
                let v7 = RedeemEvent{
                    lottery_id       : arg1,
                    player           : v1,
                    amount           : 0x2::balance::value<T0>(&v6),
                    epoch            : arg2,
                    picks            : 0x1::option::some<Picks>(v5.picks),
                    timestamp_issued : 0x1::option::some<u64>(v5.timestamp_issued),
                };
                0x2::event::emit<RedeemEvent>(v7);
                destroy<T0>(v5);
            };
            v3 = v3 - 1;
        };
        0x2::balance::destroy_zero<T0>(v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut v4, 0x2::balance::value<T0>(&v4), arg3), v1);
    }

    public fun redemptions_allowed_for_epoch<T0>(arg0: &Lottery<T0>, arg1: u64) : bool {
        *0x2::table::borrow<u64, bool>(&arg0.redemptions_allowed, arg1)
    }

    public fun remove_ticket_cost<T0, T1>(arg0: &LotteryStoreAdminCap, arg1: &mut LotteryStore, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let AlternativePrice {
            id          : v0,
            balance     : v1,
            ticket_cost : _,
        } = 0x2::dynamic_object_field::remove<0x1::type_name::TypeName, AlternativePrice<T1>>(&mut borrow_mut_lottery<T0>(arg1, arg2).id, 0x1::type_name::get<T1>());
        0x2::object::delete(v0);
        0x2::coin::from_balance<T1>(v1, arg3)
    }

    public fun remove_version(arg0: &LotteryStoreAdminCap, arg1: &mut LotteryStore, arg2: u64) {
        0x2::vec_set::remove<u64>(&mut arg1.version_set, &arg2);
    }

    entry fun select_numbers<T0>(arg0: &LotteryStoreAdminCap, arg1: &mut LotteryStore, arg2: 0x2::object::ID, arg3: u64, arg4: &0x2::random::Random, arg5: &mut 0x2::tx_context::TxContext) {
        assert_valid_version(arg1);
        let v0 = borrow_mut_lottery<T0>(arg1, arg2);
        assert!(0x2::tx_context::epoch(arg5) > v0.current_epoch, 12);
        assert!(arg3 == v0.current_epoch, 7);
        assert!(!epoch_is_settled<T0>(v0, arg3), 11);
        assert!(v0.status == 100, 0);
        assert!(0x1::option::is_none<Picks>(&v0.current_round_picks), 11);
        v0.status = 101;
        let v1 = 0x2::vec_set::empty<u8>();
        let v2 = 0x2::random::new_generator(arg4, arg5);
        let v3 = 0;
        while (v3 < v0.normal_ball_count) {
            let v4 = 0x2::random::generate_u8_in_range(&mut v2, 0, v0.max_normal_ball - 1);
            while (0x2::vec_set::contains<u8>(&v1, &v4)) {
                v4 = 0x2::random::generate_u8_in_range(&mut v2, 0, v0.max_normal_ball - 1);
            };
            0x2::vec_set::insert<u8>(&mut v1, v4);
            v3 = v3 + 1;
        };
        let v5 = Picks{
            numbers        : v1,
            special_number : 0x2::random::generate_u8_in_range(&mut v2, 0, v0.max_special_ball - 1),
        };
        v0.current_round_picks = 0x1::option::some<Picks>(v5);
        v0.status = 102;
    }

    public fun set_next_round<T0>(arg0: &mut LotteryStore, arg1: 0x2::object::ID, arg2: &LotteryStoreAdminCap, arg3: &0x2::tx_context::TxContext) {
        assert_valid_version(arg0);
        let v0 = borrow_mut_lottery<T0>(arg0, arg1);
        assert!(redemptions_allowed_for_epoch<T0>(v0, v0.current_epoch), 6);
        assert!(0x1::vector::length<address>(&v0.jackpot_winners) == 0, 8);
        assert!(v0.status == 104, 6);
        assert!(0x1::option::is_none<Picks>(&v0.current_round_picks), 6);
        let v1 = 0x2::tx_context::epoch(arg3);
        v0.current_epoch = v1;
        0x2::table::add<u64, bool>(&mut v0.epochs_settled, v1, false);
        0x2::table::add<u64, bool>(&mut v0.redemptions_allowed, v1, false);
        v0.status = 100;
        let v2 = RoundStarted{
            epoch      : v1,
            lottery_id : 0x2::object::id<Lottery<T0>>(v0),
        };
        0x2::event::emit<RoundStarted>(v2);
    }

    public fun set_store_state(arg0: &LotteryStoreAdminCap, arg1: &mut LotteryStore, arg2: bool) {
        assert_valid_version(arg1);
        arg1.is_closed = arg2;
    }

    public fun settle_or_continue<T0>(arg0: &LotteryStoreAdminCap, arg1: &mut LotteryStore, arg2: 0x2::object::ID, arg3: u64, arg4: 0x1::option::Option<u64>, arg5: &0x2::clock::Clock) {
        assert_valid_version(arg1);
        let v0 = borrow_mut_lottery<T0>(arg1, arg2);
        assert!(arg3 == v0.current_epoch, 7);
        assert!(!epoch_is_settled<T0>(v0, arg3), 11);
        assert!(v0.status == 102 || v0.status == 103, 10);
        v0.status = 103;
        let v1 = 0;
        if (0x1::option::is_some<u64>(&arg4)) {
            v1 = 0xff7fed37f3d61ca2cb7f2628f527e5c0a26294f1589c8565333aeb1a66b02c60::big_queue::length<Ticket<T0>>(&v0.tickets) - *0x1::option::borrow<u64>(&arg4);
        };
        let v2 = 0x1::option::extract<Picks>(&mut v0.current_round_picks);
        while (0xff7fed37f3d61ca2cb7f2628f527e5c0a26294f1589c8565333aeb1a66b02c60::big_queue::length<Ticket<T0>>(&v0.tickets) > v1) {
            let v3 = 0xff7fed37f3d61ca2cb7f2628f527e5c0a26294f1589c8565333aeb1a66b02c60::big_queue::pop_front<Ticket<T0>>(&mut v0.tickets);
            let (v4, v5) = get_ticket_result<T0>(v3.picks, &v2, v0);
            if (v5) {
                0x1::vector::push_back<address>(&mut v0.jackpot_winners, v3.owner);
                destroy<T0>(v3);
                continue
            };
            if (v4 > 0) {
                0x1::option::fill<0x2::balance::Balance<T0>>(&mut v3.winning_balance, 0x2::balance::split<T0>(&mut v0.lottery_prize_pool, v4));
                v0.lottery_prize_pool_size = v0.lottery_prize_pool_size - v4;
                if (0x2::table::contains<address, vector<Ticket<T0>>>(&v0.winning_tickets, v3.owner)) {
                    0x1::vector::push_back<Ticket<T0>>(0x2::table::borrow_mut<address, vector<Ticket<T0>>>(&mut v0.winning_tickets, v3.owner), v3);
                    continue
                };
                let v6 = 0x1::vector::empty<Ticket<T0>>();
                0x1::vector::push_back<Ticket<T0>>(&mut v6, v3);
                0x2::table::add<address, vector<Ticket<T0>>>(&mut v0.winning_tickets, v3.owner, v6);
                continue
            };
            destroy<T0>(v3);
        };
        if (0xff7fed37f3d61ca2cb7f2628f527e5c0a26294f1589c8565333aeb1a66b02c60::big_queue::length<Ticket<T0>>(&v0.tickets) == 0) {
            *0x2::table::borrow_mut<u64, bool>(&mut v0.epochs_settled, arg3) = true;
            let v7 = RoundResult{
                epoch           : arg3,
                lottery_id      : 0x2::object::id<Lottery<T0>>(v0),
                results         : v2,
                timestamp_drawn : 0x2::clock::timestamp_ms(arg5),
            };
            0x2::event::emit<RoundResult>(v7);
            if (0x1::vector::length<address>(&v0.jackpot_winners) > 0) {
                v0.status = 105;
            } else {
                v0.status = 104;
            };
            0x2::table::add<u64, Picks>(&mut v0.picks_history, arg3, v2);
        } else {
            v0.current_round_picks = 0x1::option::some<Picks>(v2);
        };
    }

    public fun stamp(arg0: &LotterySuperAdminCap) : DoubleUpLottery {
        DoubleUpLottery{dummy_field: false}
    }

    public fun top_up<T0>(arg0: &LotterySuperAdminCap, arg1: &mut LotteryStore, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<T0>) {
        let v0 = borrow_mut_lottery<T0>(arg1, arg2);
        0x2::balance::join<T0>(&mut v0.lottery_prize_pool, 0x2::coin::into_balance<T0>(arg3));
        v0.lottery_prize_pool_size = v0.lottery_prize_pool_size + 0x2::coin::value<T0>(&arg3);
    }

    public fun withdraw<T0>(arg0: &LotterySuperAdminCap, arg1: &mut LotteryStore, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = borrow_mut_lottery<T0>(arg1, arg2);
        let v1 = 0x2::balance::zero<T0>();
        0x2::balance::join<T0>(&mut v1, 0x2::balance::split<T0>(&mut v0.lottery_prize_pool, 0x2::balance::value<T0>(&v0.lottery_prize_pool)));
        0x2::balance::join<T0>(&mut v1, 0x2::balance::split<T0>(&mut v0.lottery_fees, 0x2::balance::value<T0>(&v0.lottery_fees)));
        0x2::coin::from_balance<T0>(v1, arg3)
    }

    public fun withdraw_fees<T0>(arg0: &LotterySuperAdminCap, arg1: &mut LotteryStore, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = borrow_mut_lottery<T0>(arg1, arg2);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v0.lottery_fees, lottery_fees_value<T0>(v0)), arg3)
    }

    // decompiled from Move bytecode v6
}

