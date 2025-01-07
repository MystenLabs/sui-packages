module 0xc0bfc90b3a663357d63878cef0ec80b623624eb0127300f3accda005cf155a73::drand_based_roulette {
    struct Bet<phantom T0> has store, key {
        id: 0x2::object::UID,
        bet_type: u8,
        bet_number: 0x1::option::Option<u64>,
        bet_size: 0x2::balance::Balance<T0>,
        player: address,
        is_settled: bool,
        name: 0x1::option::Option<0x1::string::String>,
        avatar: 0x1::option::Option<0x2::object::ID>,
        image_url: 0x1::option::Option<0x1::string::String>,
    }

    struct BetDisplay<phantom T0> has drop, store {
        id: 0x2::object::ID,
        bet_type: u8,
        bet_number: 0x1::option::Option<u64>,
        bet_size: u64,
        player: address,
        name: 0x1::option::Option<0x1::string::String>,
        avatar: 0x1::option::Option<0x2::object::ID>,
        image_url: 0x1::option::Option<0x1::string::String>,
    }

    struct HouseData<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        house: address,
        house_risk: u64,
        max_risk_per_game: u64,
        rebate_manager: 0xc0bfc90b3a663357d63878cef0ec80b623624eb0127300f3accda005cf155a73::rebate_manager::RebateManager,
    }

    struct HouseCap has store, key {
        id: 0x2::object::UID,
        owner: address,
    }

    struct RouletteGame<phantom T0> has store, key {
        id: 0x2::object::UID,
        owner: address,
        status: u8,
        round: u64,
        bets: 0x2::table_vec::TableVec<Bet<T0>>,
        risk_manager: 0xc0bfc90b3a663357d63878cef0ec80b623624eb0127300f3accda005cf155a73::risk_manager::RiskManager,
        result_roll: u64,
        min_bet: u64,
        settled_bets_count: u64,
        player_bets_table: 0x2::table::Table<address, vector<BetDisplay<T0>>>,
    }

    public fun balance<T0>(arg0: &HouseData<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun account_owner(arg0: &HouseCap) : address {
        arg0.owner
    }

    public fun bets<T0>(arg0: &RouletteGame<T0>) : &0x2::table_vec::TableVec<Bet<T0>> {
        &arg0.bets
    }

    public fun borrow_game<T0>(arg0: &HouseData<T0>, arg1: 0x2::object::ID) : &RouletteGame<T0> {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, RouletteGame<T0>>(&arg0.id, arg1), 13);
        0x2::dynamic_object_field::borrow<0x2::object::ID, RouletteGame<T0>>(&arg0.id, arg1)
    }

    fun borrow_game_mut<T0>(arg0: &mut HouseData<T0>, arg1: 0x2::object::ID) : &mut RouletteGame<T0> {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, RouletteGame<T0>>(&arg0.id, arg1), 13);
        0x2::dynamic_object_field::borrow_mut<0x2::object::ID, RouletteGame<T0>>(&mut arg0.id, arg1)
    }

    public fun claim_rebate<T0>(arg0: &mut HouseData<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2, v3) = 0xc0bfc90b3a663357d63878cef0ec80b623624eb0127300f3accda005cf155a73::rebate_manager::claim_rebate_v3(&mut arg0.rebate_manager, v0);
        let v4 = v2;
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.balance, v1, arg1), v0);
        };
        if (0x1::option::is_some<address>(&v4) && v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.balance, v1, arg1), 0x1::option::destroy_some<address>(v4));
        };
    }

    public entry fun close<T0>(arg0: &mut HouseData<T0>, arg1: 0x2::object::ID, arg2: vector<u8>, arg3: vector<u8>) {
        let v0 = borrow_game_mut<T0>(arg0, arg1);
        assert!(v0.status == 0xc0bfc90b3a663357d63878cef0ec80b623624eb0127300f3accda005cf155a73::game_status::in_progress(), 0);
        0xc0bfc90b3a663357d63878cef0ec80b623624eb0127300f3accda005cf155a73::drand_lib::verify_drand_signature(arg2, arg3, closing_round(v0.round));
        v0.status = 0xc0bfc90b3a663357d63878cef0ec80b623624eb0127300f3accda005cf155a73::game_status::closed();
        0xc0bfc90b3a663357d63878cef0ec80b623624eb0127300f3accda005cf155a73::events::emit_game_closed<T0>(*0x2::object::uid_as_inner(&v0.id));
    }

    fun closing_round(arg0: u64) : u64 {
        arg0 - 1
    }

    public entry fun complete<T0>(arg0: 0x2::object::ID, arg1: &HouseCap, arg2: &mut HouseData<T0>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(borrow_game<T0>(arg2, arg0).status != 0xc0bfc90b3a663357d63878cef0ec80b623624eb0127300f3accda005cf155a73::game_status::completed(), 1);
        complete_partial<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, false, arg7);
        complete_partial<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, true, arg7);
    }

    fun complete_partial<T0>(arg0: 0x2::object::ID, arg1: &HouseCap, arg2: &mut HouseData<T0>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: bool, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = borrow_game_mut<T0>(arg2, arg0);
        if (v0.status == 0xc0bfc90b3a663357d63878cef0ec80b623624eb0127300f3accda005cf155a73::game_status::completed()) {
            return
        };
        assert!(account_owner(arg1) == 0x2::tx_context::sender(arg8), 4);
        0xc0bfc90b3a663357d63878cef0ec80b623624eb0127300f3accda005cf155a73::drand_lib::verify_drand_signature(arg3, arg4, v0.round);
        let v1 = 0xc0bfc90b3a663357d63878cef0ec80b623624eb0127300f3accda005cf155a73::drand_lib::derive_randomness(arg3);
        let v2 = 0xc0bfc90b3a663357d63878cef0ec80b623624eb0127300f3accda005cf155a73::drand_lib::safe_selection(38, &v1);
        v0.result_roll = v2;
        let v3 = *0x2::object::uid_as_inner(&v0.id);
        let v4 = arg5;
        let v5 = arg5 + arg6;
        let v6 = v5;
        let v7 = 0x2::table_vec::length<Bet<T0>>(&v0.bets);
        if (v5 > v7) {
            v6 = v7;
        };
        let v8 = 0x1::vector::empty<0xc0bfc90b3a663357d63878cef0ec80b623624eb0127300f3accda005cf155a73::events::BetResult<T0>>();
        v0.status = 0xc0bfc90b3a663357d63878cef0ec80b623624eb0127300f3accda005cf155a73::game_status::in_settlement();
        while (v4 < v6) {
            let v9 = borrow_game_mut<T0>(arg2, v3);
            let v10 = 0x2::table_vec::borrow_mut<Bet<T0>>(&mut v9.bets, v4);
            let v11 = 0xc0bfc90b3a663357d63878cef0ec80b623624eb0127300f3accda005cf155a73::bet_manager::won_bet(v10.bet_type, v2, v10.bet_number);
            if (arg7 != v11) {
                v4 = v4 + 1;
                continue
            };
            if (v10.is_settled) {
                v4 = v4 + 1;
                continue
            };
            let v12 = v10.player;
            let v13 = 0x2::balance::value<T0>(&v10.bet_size);
            let v14 = 0xc0bfc90b3a663357d63878cef0ec80b623624eb0127300f3accda005cf155a73::bet_manager::get_bet_payout(v13, v10.bet_type);
            0x1::vector::push_back<0xc0bfc90b3a663357d63878cef0ec80b623624eb0127300f3accda005cf155a73::events::BetResult<T0>>(&mut v8, 0xc0bfc90b3a663357d63878cef0ec80b623624eb0127300f3accda005cf155a73::events::new_bet_result<T0>(*0x2::object::uid_as_inner(&v10.id), v11, v10.bet_type, v10.bet_number, v13, v10.player));
            let v15 = 0x2::coin::take<T0>(&mut v10.bet_size, v13, arg8);
            v10.is_settled = true;
            let v16 = &mut v9.player_bets_table;
            if (0x2::table::contains<address, vector<BetDisplay<T0>>>(v16, v12)) {
                0x2::table::remove<address, vector<BetDisplay<T0>>>(v16, v12);
            };
            v9.settled_bets_count = v9.settled_bets_count + 1;
            if (v11) {
                0x2::coin::join<T0>(&mut v15, 0x2::coin::take<T0>(&mut arg2.balance, v14, arg8));
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v15, v12);
            } else {
                0x2::coin::put<T0>(&mut arg2.balance, v15);
            };
            v4 = v4 + 1;
        };
        let v17 = borrow_game_mut<T0>(arg2, v3);
        let v18 = v17.settled_bets_count;
        if (v18 == v7) {
            v17.status = 0xc0bfc90b3a663357d63878cef0ec80b623624eb0127300f3accda005cf155a73::game_status::completed();
        };
        if (v18 == v7) {
            arg2.house_risk = arg2.house_risk - 0xc0bfc90b3a663357d63878cef0ec80b623624eb0127300f3accda005cf155a73::risk_manager::total_risk(&v17.risk_manager);
        };
        0xc0bfc90b3a663357d63878cef0ec80b623624eb0127300f3accda005cf155a73::events::emit_game_completed<T0>(v3, v2, v8);
    }

    public entry fun create<T0>(arg0: u64, arg1: &mut HouseData<T0>, arg2: &HouseCap, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(account_owner(arg2) == arg1.house, 4);
        let v0 = RouletteGame<T0>{
            id                 : 0x2::object::new(arg3),
            owner              : 0x2::tx_context::sender(arg3),
            status             : 0xc0bfc90b3a663357d63878cef0ec80b623624eb0127300f3accda005cf155a73::game_status::in_progress(),
            round              : arg0,
            bets               : 0x2::table_vec::empty<Bet<T0>>(arg3),
            risk_manager       : 0xc0bfc90b3a663357d63878cef0ec80b623624eb0127300f3accda005cf155a73::risk_manager::new_manager(),
            result_roll        : 0,
            min_bet            : 1000000000,
            settled_bets_count : 0,
            player_bets_table  : 0x2::table::new<address, vector<BetDisplay<T0>>>(arg3),
        };
        let v1 = *0x2::object::uid_as_inner(&v0.id);
        0x2::dynamic_object_field::add<0x2::object::ID, RouletteGame<T0>>(&mut arg1.id, v1, v0);
        0xc0bfc90b3a663357d63878cef0ec80b623624eb0127300f3accda005cf155a73::events::emit_game_created<T0>(v1);
        v1
    }

    public fun create_child_account_cap(arg0: &HouseCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 4);
        let v0 = HouseCap{
            id    : 0x2::object::new(arg2),
            owner : arg1,
        };
        0x2::transfer::transfer<HouseCap>(v0, arg1);
    }

    fun delete_bet<T0>(arg0: Bet<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let Bet {
            id         : v0,
            bet_type   : _,
            bet_number : _,
            bet_size   : v3,
            player     : v4,
            is_settled : _,
            name       : _,
            avatar     : _,
            image_url  : _,
        } = arg0;
        let v9 = v3;
        let v10 = 0x2::balance::value<T0>(&v9);
        if (v10 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut v9, v10, arg1), v4);
        };
        0x2::balance::destroy_zero<T0>(v9);
        0x2::object::delete(v0);
    }

    fun delete_game<T0>(arg0: RouletteGame<T0>) {
        let RouletteGame {
            id                 : v0,
            owner              : _,
            status             : _,
            round              : _,
            bets               : v4,
            risk_manager       : _,
            result_roll        : _,
            min_bet            : _,
            settled_bets_count : _,
            player_bets_table  : v9,
        } = arg0;
        0x2::object::delete(v0);
        0x2::table_vec::destroy_empty<Bet<T0>>(v4);
        0x2::table::drop<address, vector<BetDisplay<T0>>>(v9);
    }

    public fun game_risk<T0>(arg0: &RouletteGame<T0>) : u64 {
        0xc0bfc90b3a663357d63878cef0ec80b623624eb0127300f3accda005cf155a73::risk_manager::total_risk(&arg0.risk_manager)
    }

    public fun house<T0>(arg0: &HouseData<T0>) : address {
        arg0.house
    }

    public fun house_risk<T0>(arg0: &HouseData<T0>) : u64 {
        arg0.house_risk
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = HouseCap{
            id    : 0x2::object::new(arg0),
            owner : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::transfer<HouseCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun initialize_house_data<T0>(arg0: &HouseCap, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(account_owner(arg0) == 0x2::tx_context::sender(arg1), 4);
        let v0 = HouseData<T0>{
            id                : 0x2::object::new(arg1),
            balance           : 0x2::balance::zero<T0>(),
            house             : 0x2::tx_context::sender(arg1),
            house_risk        : 0,
            max_risk_per_game : 1000000000000,
            rebate_manager    : 0xc0bfc90b3a663357d63878cef0ec80b623624eb0127300f3accda005cf155a73::rebate_manager::new(0, 0, arg1),
        };
        0x2::transfer::share_object<HouseData<T0>>(v0);
    }

    public entry fun place_bet<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u8, arg2: 0x1::option::Option<u64>, arg3: 0x2::object::ID, arg4: &mut HouseData<T0>, arg5: 0x1::option::Option<0x1::string::String>, arg6: 0x1::option::Option<0x2::object::ID>, arg7: 0x1::option::Option<0x1::string::String>, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 >= 0 && arg1 <= 12, 10);
        if (arg1 == 2) {
            assert!(0x1::option::is_some<u64>(&arg2), 12);
            assert!(*0x1::option::borrow<u64>(&arg2) <= 37, 12);
        };
        let v0 = 0x2::coin::value<T0>(&arg0);
        let v1 = borrow_game_mut<T0>(arg4, arg3);
        let (v2, v3) = 0xc0bfc90b3a663357d63878cef0ec80b623624eb0127300f3accda005cf155a73::risk_manager::add_risk(&mut v1.risk_manager, arg1, arg2, 0xc0bfc90b3a663357d63878cef0ec80b623624eb0127300f3accda005cf155a73::bet_manager::get_bet_payout(v0, arg1));
        if (v2) {
            arg4.house_risk = arg4.house_risk + v3;
        } else {
            arg4.house_risk = arg4.house_risk - v3;
        };
        let v4 = arg4.max_risk_per_game;
        assert!(house_risk<T0>(arg4) <= balance<T0>(arg4), 8);
        let v5 = borrow_game_mut<T0>(arg4, arg3);
        assert!(0xc0bfc90b3a663357d63878cef0ec80b623624eb0127300f3accda005cf155a73::risk_manager::total_risk(&v5.risk_manager) <= v4, 8);
        assert!(v5.status == 0xc0bfc90b3a663357d63878cef0ec80b623624eb0127300f3accda005cf155a73::game_status::in_progress(), 0);
        assert!(v0 >= v5.min_bet, 6);
        let v6 = 0x2::tx_context::sender(arg8);
        let v7 = Bet<T0>{
            id         : 0x2::object::new(arg8),
            bet_type   : arg1,
            bet_number : arg2,
            bet_size   : 0x2::coin::into_balance<T0>(arg0),
            player     : v6,
            is_settled : false,
            name       : arg5,
            avatar     : arg6,
            image_url  : arg7,
        };
        let v8 = 0x2::balance::value<T0>(&v7.bet_size);
        let v9 = *0x2::object::uid_as_inner(&v7.id);
        0xc0bfc90b3a663357d63878cef0ec80b623624eb0127300f3accda005cf155a73::events::emit_place_bet<T0>(v9, v7.bet_type, v7.bet_number, v8, v7.player);
        0x2::table_vec::push_back<Bet<T0>>(&mut v5.bets, v7);
        let v10 = BetDisplay<T0>{
            id         : v9,
            bet_type   : arg1,
            bet_number : arg2,
            bet_size   : v8,
            player     : v6,
            name       : arg5,
            avatar     : arg6,
            image_url  : arg7,
        };
        let v11 = &mut v5.player_bets_table;
        if (0x2::table::contains<address, vector<BetDisplay<T0>>>(v11, v6)) {
            0x1::vector::push_back<BetDisplay<T0>>(0x2::table::borrow_mut<address, vector<BetDisplay<T0>>>(v11, v6), v10);
        } else {
            0x2::table::add<address, vector<BetDisplay<T0>>>(v11, v6, 0x1::vector::singleton<BetDisplay<T0>>(v10));
        };
        0xc0bfc90b3a663357d63878cef0ec80b623624eb0127300f3accda005cf155a73::rebate_manager::add_volume_v3(&mut arg4.rebate_manager, v6, v0);
    }

    public fun player_bets_table<T0>(arg0: &RouletteGame<T0>) : &0x2::table::Table<address, vector<BetDisplay<T0>>> {
        &arg0.player_bets_table
    }

    public entry fun refund_all_bets<T0>(arg0: &HouseCap, arg1: &mut HouseData<T0>, arg2: 0x2::object::ID, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(account_owner(arg0) == 0x2::tx_context::sender(arg4), 4);
        let v0 = borrow_game_mut<T0>(arg1, arg2);
        if (arg3 > 0x2::table_vec::length<Bet<T0>>(&v0.bets)) {
            arg3 = 0x2::table_vec::length<Bet<T0>>(&v0.bets);
        };
        let v1 = 0;
        while (v1 < arg3) {
            delete_bet<T0>(0x2::table_vec::pop_back<Bet<T0>>(&mut v0.bets), arg4);
            v1 = v1 + 1;
        };
        if (0x2::table_vec::is_empty<Bet<T0>>(&v0.bets)) {
            delete_game<T0>(0x2::dynamic_object_field::remove<0x2::object::ID, RouletteGame<T0>>(&mut arg1.id, arg2));
        };
    }

    public fun risk_manager<T0>(arg0: &RouletteGame<T0>) : &0xc0bfc90b3a663357d63878cef0ec80b623624eb0127300f3accda005cf155a73::risk_manager::RiskManager {
        &arg0.risk_manager
    }

    public entry fun set_account_owner(arg0: &mut HouseCap, arg1: &mut 0x2::tx_context::TxContext) {
        arg0.owner = 0x2::tx_context::sender(arg1);
    }

    public entry fun set_max_risk_per_game<T0>(arg0: &HouseCap, arg1: &mut HouseData<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(account_owner(arg0) == 0x2::tx_context::sender(arg3), 4);
        arg1.max_risk_per_game = arg2;
    }

    public fun set_referrer<T0>(arg0: &mut HouseData<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        0xc0bfc90b3a663357d63878cef0ec80b623624eb0127300f3accda005cf155a73::rebate_manager::register_v3(&mut arg0.rebate_manager, 0x2::tx_context::sender(arg2), 0x1::option::some<address>(arg1));
    }

    public entry fun top_up<T0>(arg0: &mut HouseData<T0>, arg1: 0x2::coin::Coin<T0>) {
        0xc0bfc90b3a663357d63878cef0ec80b623624eb0127300f3accda005cf155a73::events::emit_house_deposit<T0>(0x2::coin::value<T0>(&arg1));
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
    }

    public entry fun update_rebate_rate<T0>(arg0: &HouseCap, arg1: &mut HouseData<T0>, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert!(account_owner(arg0) == 0x2::tx_context::sender(arg4), 4);
        0xc0bfc90b3a663357d63878cef0ec80b623624eb0127300f3accda005cf155a73::rebate_manager::update_rate(&mut arg1.rebate_manager, arg2, arg3);
    }

    public entry fun withdraw<T0>(arg0: &mut HouseData<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.house, 4);
        0xc0bfc90b3a663357d63878cef0ec80b623624eb0127300f3accda005cf155a73::events::emit_house_withdraw<T0>(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.balance, arg1, arg2), arg0.house);
    }

    // decompiled from Move bytecode v6
}

