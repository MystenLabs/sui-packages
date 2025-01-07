module 0x54c6adf9f5e1d646d96b4f2977e1e1af96b1da381eebec3f423ccbb3abe55491::single_roulette {
    struct SingleRoulette has copy, drop, store {
        dummy_field: bool,
    }

    struct Bet has store, key {
        id: 0x2::object::UID,
        bet_type: u8,
        bet_number: 0x1::option::Option<u64>,
        bet_size: u64,
        player: address,
    }

    struct BetResult<phantom T0> has copy, drop, store {
        bet_id: 0x2::object::ID,
        is_win: bool,
        bet_type: u8,
        bet_number: 0x1::option::Option<u64>,
        bet_size: u64,
        player: address,
    }

    struct RouletteRollResults<phantom T0> has copy, drop, store {
        game_id: 0x2::object::ID,
        creator: address,
        round_volume: u64,
        round_number: u64,
        result_roll: u64,
        bet_results: vector<BetResult<T0>>,
    }

    struct RouletteTable<phantom T0> has store, key {
        id: 0x2::object::UID,
        host: address,
        max_risk: u64,
        risk_manager: 0x54c6adf9f5e1d646d96b4f2977e1e1af96b1da381eebec3f423ccbb3abe55491::risk_manager::RiskManager,
        balance: 0x2::balance::Balance<T0>,
        current_bets: 0x2::linked_table::LinkedTable<address, vector<Bet>>,
        status: u8,
        rounds_settled: 0x2::table::Table<u64, u64>,
        round_number: u64,
    }

    struct SinglePlayerRouletteConfig<phantom T0> has key {
        id: 0x2::object::UID,
        version_set: 0x2::vec_set::VecSet<u64>,
        min_bet_size: u64,
        bet_referral_rate: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct GameTag<phantom T0> has copy, drop, store {
        creator: address,
    }

    struct TableCreatedEvent<phantom T0> has copy, drop, store {
        table_id: 0x2::object::ID,
        creator: address,
    }

    struct BetAddedEvent<phantom T0> has copy, drop, store {
        table_id: 0x2::object::ID,
        bet_id: 0x2::object::ID,
        bet_size: u64,
        bet_type: u8,
        player: address,
        creator: address,
        origin: 0x1::string::String,
    }

    struct BetRemovedEvent<phantom T0> has copy, drop, store {
        table_id: 0x2::object::ID,
        bet_id: 0x2::object::ID,
        bet_size: u64,
        player: address,
        creator: address,
        origin: 0x1::string::String,
    }

    struct BetResolvedEvent<phantom T0> has copy, drop, store {
        table_id: 0x2::object::ID,
        bet_id: 0x2::object::ID,
        round_number: u64,
        outcome: u64,
        creator: address,
    }

    struct BetSettledEvent<phantom T0> has copy, drop, store {
        table_id: 0x2::object::ID,
        total_volume: u64,
        round_number: u64,
        creator: address,
        bet_results: vector<BetResult<T0>>,
        origin: 0x1::string::String,
    }

    struct ReferralPayoutEvent<phantom T0> has copy, drop, store {
        payout: u64,
        creator: address,
    }

    public fun add_bet<T0>(arg0: &mut SinglePlayerRouletteConfig<T0>, arg1: address, arg2: 0x2::coin::Coin<T0>, arg3: u8, arg4: 0x1::option::Option<u64>, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_valid_version<T0>(arg0);
        assert!(table_exists<T0>(arg0, arg1), 7);
        assert!(arg3 < 13, 3);
        if (arg3 == 2) {
            assert!(0x1::option::is_some<u64>(&arg4), 4);
            assert!(*0x1::option::borrow<u64>(&arg4) < 38, 4);
        };
        let v0 = borrow_table_mut<T0>(arg0, arg1);
        assert!(v0.status == 0, 1);
        assert!(0x2::linked_table::length<address, vector<Bet>>(&v0.current_bets) < 1000, 15);
        let v1 = 0x2::coin::value<T0>(&arg2);
        let (_, _) = 0x54c6adf9f5e1d646d96b4f2977e1e1af96b1da381eebec3f423ccbb3abe55491::risk_manager::add_risk(&mut v0.risk_manager, arg3, arg4, 0x54c6adf9f5e1d646d96b4f2977e1e1af96b1da381eebec3f423ccbb3abe55491::bet_manager::get_bet_payout(v1, arg3));
        assert!(0x54c6adf9f5e1d646d96b4f2977e1e1af96b1da381eebec3f423ccbb3abe55491::risk_manager::total_risk(&v0.risk_manager) <= v0.max_risk, 0);
        0x2::balance::join<T0>(&mut v0.balance, 0x2::coin::into_balance<T0>(arg2));
        let v4 = 0x2::tx_context::sender(arg6);
        let v5 = Bet{
            id         : 0x2::object::new(arg6),
            bet_type   : arg3,
            bet_number : arg4,
            bet_size   : v1,
            player     : v4,
        };
        let v6 = 0x2::object::id<Bet>(&v5);
        let v7 = &mut v0.current_bets;
        handle_add_bet(v7, v4, v5);
        let v8 = BetAddedEvent<T0>{
            table_id : 0x2::object::id<RouletteTable<T0>>(v0),
            bet_id   : v6,
            bet_size : v1,
            bet_type : arg3,
            player   : v4,
            creator  : arg1,
            origin   : arg5,
        };
        0x2::event::emit<BetAddedEvent<T0>>(v8);
        v6
    }

    public fun add_version<T0>(arg0: &AdminCap, arg1: &mut SinglePlayerRouletteConfig<T0>, arg2: u64) {
        0x2::vec_set::insert<u64>(&mut arg1.version_set, arg2);
    }

    fun assert_table_has_bets<T0>(arg0: &mut RouletteTable<T0>) : bool {
        0x2::linked_table::length<address, vector<Bet>>(&arg0.current_bets) > 0
    }

    fun assert_valid_version<T0>(arg0: &mut SinglePlayerRouletteConfig<T0>) {
        let v0 = package_version();
        assert!(0x2::vec_set::contains<u64>(&arg0.version_set, &v0), 13);
    }

    fun borrow_table_mut<T0>(arg0: &mut SinglePlayerRouletteConfig<T0>, arg1: address) : &mut RouletteTable<T0> {
        let v0 = GameTag<T0>{creator: arg1};
        0x2::dynamic_object_field::borrow_mut<GameTag<T0>, RouletteTable<T0>>(&mut arg0.id, v0)
    }

    public fun create_config<T0>(arg0: &AdminCap, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 < 26000000, 10);
        let v0 = SinglePlayerRouletteConfig<T0>{
            id                : 0x2::object::new(arg3),
            version_set       : 0x2::vec_set::singleton<u64>(1),
            min_bet_size      : arg1,
            bet_referral_rate : arg2,
        };
        0x2::transfer::share_object<SinglePlayerRouletteConfig<T0>>(v0);
    }

    public fun create_roulette_table<T0>(arg0: &mut 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::unihouse::UniHouse, arg1: &mut SinglePlayerRouletteConfig<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_valid_version<T0>(arg1);
        let v0 = RouletteTable<T0>{
            id             : 0x2::object::new(arg2),
            host           : 0x2::tx_context::sender(arg2),
            max_risk       : max_risk<T0>(arg0),
            risk_manager   : 0x54c6adf9f5e1d646d96b4f2977e1e1af96b1da381eebec3f423ccbb3abe55491::risk_manager::new_manager(),
            balance        : 0x2::balance::zero<T0>(),
            current_bets   : 0x2::linked_table::new<address, vector<Bet>>(arg2),
            status         : 0,
            rounds_settled : 0x2::table::new<u64, u64>(arg2),
            round_number   : 0,
        };
        let v1 = 0x2::object::id<RouletteTable<T0>>(&v0);
        let v2 = 0x2::tx_context::sender(arg2);
        let v3 = GameTag<T0>{creator: v2};
        0x2::dynamic_object_field::add<GameTag<T0>, RouletteTable<T0>>(&mut arg1.id, v3, v0);
        let v4 = TableCreatedEvent<T0>{
            table_id : v1,
            creator  : v2,
        };
        0x2::event::emit<TableCreatedEvent<T0>>(v4);
        v1
    }

    fun destroy_bet(arg0: Bet) : u64 {
        let Bet {
            id         : v0,
            bet_type   : _,
            bet_number : _,
            bet_size   : v3,
            player     : _,
        } = arg0;
        0x2::object::delete(v0);
        v3
    }

    fun handle_add_bet(arg0: &mut 0x2::linked_table::LinkedTable<address, vector<Bet>>, arg1: address, arg2: Bet) {
        if (0x2::linked_table::contains<address, vector<Bet>>(arg0, arg1)) {
            let v0 = 0x2::linked_table::remove<address, vector<Bet>>(arg0, arg1);
            assert!(0x1::vector::length<Bet>(&v0) > 500, 17);
            0x1::vector::push_back<Bet>(&mut v0, arg2);
            0x2::linked_table::push_back<address, vector<Bet>>(arg0, arg1, v0);
        } else {
            let v1 = 0x1::vector::empty<Bet>();
            0x1::vector::push_back<Bet>(&mut v1, arg2);
            0x2::linked_table::push_back<address, vector<Bet>>(arg0, arg1, v1);
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun max_risk<T0>(arg0: &0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::unihouse::UniHouse) : u64 {
        0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::house::max_risk<T0, SingleRoulette>(0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::unihouse::borrow_house<T0>(arg0))
    }

    public fun package_version() : u64 {
        1
    }

    public fun remove_bet<T0>(arg0: &mut SinglePlayerRouletteConfig<T0>, arg1: address, arg2: address, arg3: 0x2::object::ID, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_valid_version<T0>(arg0);
        assert!(table_exists<T0>(arg0, arg1), 7);
        let v0 = borrow_table_mut<T0>(arg0, arg1);
        assert!(v0.status == 0, 1);
        assert!(0x2::linked_table::contains<address, vector<Bet>>(&v0.current_bets, arg2), 11);
        let v1 = 0x2::linked_table::remove<address, vector<Bet>>(&mut v0.current_bets, arg2);
        let v2 = 0;
        let v3 = false;
        let v4 = 0;
        while (v2 < 0x1::vector::length<Bet>(&v1)) {
            if (0x2::object::id<Bet>(0x1::vector::borrow<Bet>(&v1, v2)) == arg3) {
                v3 = true;
                v4 = destroy_bet(0x1::vector::remove<Bet>(&mut v1, v2));
                break
            };
        };
        assert!(v3, 12);
        if (0x1::vector::length<Bet>(&v1) > 0) {
            0x2::linked_table::push_back<address, vector<Bet>>(&mut v0.current_bets, arg2, v1);
        } else {
            0x1::vector::destroy_empty<Bet>(v1);
        };
        let v5 = BetRemovedEvent<T0>{
            table_id : 0x2::object::id<RouletteTable<T0>>(v0),
            bet_id   : arg3,
            bet_size : v4,
            player   : arg2,
            creator  : arg1,
            origin   : arg4,
        };
        0x2::event::emit<BetRemovedEvent<T0>>(v5);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v0.balance, v4), arg5)
    }

    public fun remove_version<T0>(arg0: &AdminCap, arg1: &mut SinglePlayerRouletteConfig<T0>, arg2: u64) {
        0x2::vec_set::remove<u64>(&mut arg1.version_set, &arg2);
    }

    public fun resolve_bet_outcome<T0>(arg0: &mut SinglePlayerRouletteConfig<T0>, arg1: 0x1::option::Option<0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::bls_settler::BetOutcomeWithDraw<T0, SingleRoulette>>) {
        assert_valid_version<T0>(arg0);
        let (v0, v1, v2, v3) = 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::bls_settler::destroy_bet_outcome_with_draw<T0, SingleRoulette>(0x1::option::destroy_some<0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::bls_settler::BetOutcomeWithDraw<T0, SingleRoulette>>(arg1));
        assert!(table_exists<T0>(arg0, v1), 7);
        let v4 = borrow_table_mut<T0>(arg0, v1);
        assert!(!0x2::table::contains<u64, u64>(&v4.rounds_settled, v4.round_number), 16);
        let v5 = BetResolvedEvent<T0>{
            table_id     : 0x2::object::id<RouletteTable<T0>>(v4),
            bet_id       : v0,
            round_number : v4.round_number,
            outcome      : v2,
            creator      : v1,
        };
        0x2::event::emit<BetResolvedEvent<T0>>(v5);
        0x2::table::add<u64, u64>(&mut v4.rounds_settled, v4.round_number, v2);
        0x1::vector::destroy_empty<0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::bls_settler::BetWithDraw<T0>>(v3);
    }

    public fun settle_or_continue<T0>(arg0: &mut 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::unihouse::UniHouse, arg1: &mut SinglePlayerRouletteConfig<T0>, arg2: address, arg3: 0x1::option::Option<u64>, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        assert_valid_version<T0>(arg1);
        assert!(table_exists<T0>(arg1, arg2), 7);
        let v0 = arg1.bet_referral_rate;
        let v1 = borrow_table_mut<T0>(arg1, arg2);
        assert!(0x2::linked_table::length<address, vector<Bet>>(&v1.current_bets) != 0, 8);
        let v2 = 0x2::table::borrow<u64, u64>(&v1.rounds_settled, v1.round_number);
        let v3 = 0x1::vector::empty<BetResult<T0>>();
        let v4 = 0;
        let v5 = 10000;
        if (0x1::option::is_some<u64>(&arg3)) {
            v5 = *0x1::option::borrow<u64>(&arg3);
        };
        let v6 = 0;
        let v7 = false;
        while (v6 < v5 && 0x2::linked_table::length<address, vector<Bet>>(&v1.current_bets) > 0) {
            let (v8, v9) = 0x2::linked_table::pop_back<address, vector<Bet>>(&mut v1.current_bets);
            let v10 = v9;
            if (v8 != arg2) {
                v7 = true;
            };
            while (v6 < v5 && 0x1::vector::length<Bet>(&v10) != 0) {
                let v11 = 0x1::vector::pop_back<Bet>(&mut v10);
                let Bet {
                    id         : v12,
                    bet_type   : v13,
                    bet_number : v14,
                    bet_size   : v15,
                    player     : v16,
                } = v11;
                let v17 = 0x54c6adf9f5e1d646d96b4f2977e1e1af96b1da381eebec3f423ccbb3abe55491::bet_manager::won_bet(v13, *v2, v14);
                let v18 = 0x2::balance::split<T0>(&mut v1.balance, v15);
                if (v16 != arg2) {
                    v4 = v4 + 0x2::balance::value<T0>(&v18);
                };
                if (v17) {
                    let v19 = SingleRoulette{dummy_field: false};
                    let v20 = 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::unihouse::split<T0, SingleRoulette>(v19, arg0, 0x54c6adf9f5e1d646d96b4f2977e1e1af96b1da381eebec3f423ccbb3abe55491::bet_manager::get_bet_payout(v15, v13));
                    0x2::balance::join<T0>(&mut v20, v18);
                    0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v20, arg5), v16);
                } else {
                    let v21 = SingleRoulette{dummy_field: false};
                    0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::unihouse::join<T0, SingleRoulette>(v21, arg0, v18);
                };
                let v22 = BetResult<T0>{
                    bet_id     : 0x2::object::id<Bet>(&v11),
                    is_win     : v17,
                    bet_type   : v13,
                    bet_number : v14,
                    bet_size   : v15,
                    player     : v16,
                };
                0x2::object::delete(v12);
                0x1::vector::push_back<BetResult<T0>>(&mut v3, v22);
                v6 = v6 + 1;
            };
            if (v6 >= v5 && !0x1::vector::is_empty<Bet>(&v10)) {
                0x2::linked_table::push_back<address, vector<Bet>>(&mut v1.current_bets, v8, v10);
                break
            };
            0x1::vector::destroy_empty<Bet>(v10);
        };
        let v23 = BetSettledEvent<T0>{
            table_id     : 0x2::object::id<RouletteTable<T0>>(v1),
            total_volume : v4,
            round_number : v1.round_number,
            creator      : arg2,
            bet_results  : v3,
            origin       : arg4,
        };
        0x2::event::emit<BetSettledEvent<T0>>(v23);
        if (v7) {
            let v24 = 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::house::mul_rate(v4, v0);
            let v25 = SingleRoulette{dummy_field: false};
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::unihouse::take<T0, SingleRoulette>(v25, arg0, v24, arg5), arg2);
            let v26 = ReferralPayoutEvent<T0>{
                payout  : v24,
                creator : arg2,
            };
            0x2::event::emit<ReferralPayoutEvent<T0>>(v26);
        };
        if (0x2::linked_table::length<address, vector<Bet>>(&v1.current_bets) == 0) {
            v1.risk_manager = 0x54c6adf9f5e1d646d96b4f2977e1e1af96b1da381eebec3f423ccbb3abe55491::risk_manager::new_manager();
            v1.status = 0;
            v1.round_number = v1.round_number + 1;
        };
    }

    public fun start_roll<T0>(arg0: &mut 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::unihouse::UniHouse, arg1: &mut 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::bls_settler::BlsSettler, arg2: vector<u8>, arg3: &mut SinglePlayerRouletteConfig<T0>, arg4: &mut 0x2::tx_context::TxContext) : (address, 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::bls_settler::BetKey<T0, SingleRoulette>, 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::receipt::GameReceipt<T0, SingleRoulette>) {
        assert_valid_version<T0>(arg3);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(table_exists<T0>(arg3, v0), 7);
        let v1 = borrow_table_mut<T0>(arg3, v0);
        assert!(v1.status == 0, 1);
        v1.status = 1;
        assert!(assert_table_has_bets<T0>(v1), 14);
        let v2 = SingleRoulette{dummy_field: false};
        (v0, 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::bls_settler::add_bet_data_with_draw<T0, SingleRoulette>(arg0, arg1, v2, true, v0, 38, 0x1::vector::empty<0x2::coin::Coin<T0>>(), vector[], 0x1::vector::empty<0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::ranges::Ranges>(), 0x1::vector::empty<0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::ranges::Ranges>(), arg2, arg4), 0xf0978635bb456d2cb2e594cd4a018c9aed486d6cb68c7890abe5ef56838034bf::unihouse::new_game_receipt<T0, SingleRoulette>(v2, arg0, 0))
    }

    public fun table_exists<T0>(arg0: &SinglePlayerRouletteConfig<T0>, arg1: address) : bool {
        let v0 = GameTag<T0>{creator: arg1};
        0x2::dynamic_object_field::exists_<GameTag<T0>>(&arg0.id, v0)
    }

    public fun update_config<T0>(arg0: &AdminCap, arg1: &mut SinglePlayerRouletteConfig<T0>, arg2: u64, arg3: u64) {
        arg1.min_bet_size = arg2;
        arg1.bet_referral_rate = arg3;
    }

    // decompiled from Move bytecode v6
}

