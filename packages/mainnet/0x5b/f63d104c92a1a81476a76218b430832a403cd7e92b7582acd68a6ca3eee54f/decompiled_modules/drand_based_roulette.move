module 0xdcb0957ffbeffb4e4b934cc7df1b9b84fc40775de8bd7e0b188a725962496ea9::drand_based_roulette {
    struct Bet<phantom T0> has store, key {
        id: 0x2::object::UID,
        bet_type: u8,
        bet_number: 0x1::option::Option<u64>,
        bet_size: 0x2::balance::Balance<T0>,
        player: address,
    }

    struct PlaceBet<phantom T0> has copy, drop, store {
        bet_id: 0x2::object::ID,
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

    struct GameCreated<phantom T0> has copy, drop, store {
        game_id: 0x2::object::ID,
    }

    struct GameClosed<phantom T0> has copy, drop, store {
        game_id: 0x2::object::ID,
    }

    struct GameCompleted<phantom T0> has copy, drop, store {
        game_id: 0x2::object::ID,
        result_roll: u64,
        bet_results: vector<BetResult<T0>>,
    }

    struct HouseDeposit<phantom T0> has copy, drop, store {
        amount: u64,
    }

    struct HouseWithdraw<phantom T0> has copy, drop, store {
        amount: u64,
    }

    struct HouseData<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        house: address,
        house_risk: u64,
        max_risk_per_game: u64,
    }

    struct HouseCap has store, key {
        id: 0x2::object::UID,
        owner: address,
    }

    struct NumberRisk has copy, drop, store {
        risk: u64,
    }

    struct RouletteGame<phantom T0> has store, key {
        id: 0x2::object::UID,
        owner: address,
        status: u8,
        round: u64,
        bets: vector<Bet<T0>>,
        numbers_risk: vector<NumberRisk>,
        total_risked: u64,
        result_roll: u64,
        min_bet: u64,
    }

    public fun balance<T0>(arg0: &HouseData<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun account_owner(arg0: &HouseCap) : address {
        arg0.owner
    }

    public entry fun close<T0>(arg0: &mut RouletteGame<T0>, arg1: vector<u8>, arg2: vector<u8>) {
        assert!(arg0.status == 0, 0);
        0xdcb0957ffbeffb4e4b934cc7df1b9b84fc40775de8bd7e0b188a725962496ea9::drand_lib::verify_drand_signature(arg1, arg2, closing_round(arg0.round));
        arg0.status = 1;
        let v0 = GameClosed<T0>{game_id: *0x2::object::uid_as_inner(&arg0.id)};
        0x2::event::emit<GameClosed<T0>>(v0);
    }

    fun closing_round(arg0: u64) : u64 {
        arg0 - 1
    }

    public entry fun complete<T0>(arg0: &mut RouletteGame<T0>, arg1: &HouseCap, arg2: &mut HouseData<T0>, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status != 2, 1);
        assert!(account_owner(arg1) == 0x2::tx_context::sender(arg5), 4);
        0xdcb0957ffbeffb4e4b934cc7df1b9b84fc40775de8bd7e0b188a725962496ea9::drand_lib::verify_drand_signature(arg3, arg4, arg0.round);
        arg0.status = 2;
        let v0 = 0xdcb0957ffbeffb4e4b934cc7df1b9b84fc40775de8bd7e0b188a725962496ea9::drand_lib::derive_randomness(arg3);
        let v1 = 0xdcb0957ffbeffb4e4b934cc7df1b9b84fc40775de8bd7e0b188a725962496ea9::drand_lib::safe_selection(38, &v0);
        arg0.result_roll = v1;
        0x1::debug::print<u64>(&v1);
        let v2 = &mut arg0.bets;
        let v3 = 0;
        let v4 = 0x1::vector::empty<BetResult<T0>>();
        arg2.house_risk = arg2.house_risk - max_number_risk_vector(&arg0.numbers_risk);
        while (v3 < 0x1::vector::length<Bet<T0>>(v2)) {
            let v5 = 0x1::vector::borrow_mut<Bet<T0>>(v2, v3);
            let v6 = get_bet_payout(0x2::balance::value<T0>(&v5.bet_size), v5.bet_type);
            v3 = v3 + 1;
            if (v5.bet_type != 2) {
                arg2.house_risk = arg2.house_risk - v6;
            };
            if (won_bet(v5.bet_type, v1, v5.bet_number)) {
                let v7 = 0x2::balance::value<T0>(&v5.bet_size);
                let v8 = 0x2::coin::into_balance<T0>(0x2::coin::take<T0>(&mut v5.bet_size, v7, arg5));
                0x2::balance::join<T0>(&mut v8, 0x2::balance::split<T0>(&mut arg2.balance, v6));
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut v8, 0x2::balance::value<T0>(&v8), arg5), v5.player);
                0x2::balance::destroy_zero<T0>(v8);
                let v9 = BetResult<T0>{
                    bet_id     : *0x2::object::uid_as_inner(&v5.id),
                    is_win     : true,
                    bet_type   : v5.bet_type,
                    bet_number : v5.bet_number,
                    bet_size   : v7,
                    player     : v5.player,
                };
                0x1::vector::push_back<BetResult<T0>>(&mut v4, v9);
                continue
            };
            let v10 = 0x2::balance::value<T0>(&v5.bet_size);
            0x2::balance::join<T0>(&mut arg2.balance, 0x2::coin::into_balance<T0>(0x2::coin::take<T0>(&mut v5.bet_size, v10, arg5)));
            let v11 = BetResult<T0>{
                bet_id     : *0x2::object::uid_as_inner(&v5.id),
                is_win     : false,
                bet_type   : v5.bet_type,
                bet_number : v5.bet_number,
                bet_size   : v10,
                player     : v5.player,
            };
            0x1::vector::push_back<BetResult<T0>>(&mut v4, v11);
        };
        let v12 = GameCompleted<T0>{
            game_id     : *0x2::object::uid_as_inner(&arg0.id),
            result_roll : v1,
            bet_results : v4,
        };
        0x2::event::emit<GameCompleted<T0>>(v12);
    }

    public entry fun create<T0>(arg0: u64, arg1: &mut HouseData<T0>, arg2: &HouseCap, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(account_owner(arg2) == arg1.house, 4);
        let v0 = 0x1::vector::empty<NumberRisk>();
        let v1 = 0;
        while (v1 < 38) {
            let v2 = NumberRisk{risk: 0};
            0x1::vector::push_back<NumberRisk>(&mut v0, v2);
            v1 = v1 + 1;
        };
        let v3 = RouletteGame<T0>{
            id           : 0x2::object::new(arg3),
            owner        : 0x2::tx_context::sender(arg3),
            status       : 0,
            round        : arg0,
            bets         : 0x1::vector::empty<Bet<T0>>(),
            numbers_risk : v0,
            total_risked : 0,
            result_roll  : 0,
            min_bet      : 1000000000,
        };
        0x2::transfer::public_share_object<RouletteGame<T0>>(v3);
        let v4 = GameCreated<T0>{game_id: *0x2::object::uid_as_inner(&v3.id)};
        0x2::event::emit<GameCreated<T0>>(v4);
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
        } = arg0;
        let v5 = v3;
        let v6 = 0x2::balance::value<T0>(&v5);
        if (v6 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut v5, v6, arg1), v4);
        };
        0x2::balance::destroy_zero<T0>(v5);
        0x2::object::delete(v0);
    }

    public fun get_bet_payout(arg0: u64, arg1: u8) : u64 {
        if (arg1 == 0 || arg1 == 1 || arg1 == 3 || arg1 == 4 || arg1 == 8 || arg1 == 9) {
            return 0xdcb0957ffbeffb4e4b934cc7df1b9b84fc40775de8bd7e0b188a725962496ea9::math::unsafe_mul(arg0, 1000000000)
        };
        if (arg1 == 5 || arg1 == 6 || arg1 == 7 || arg1 == 10 || arg1 == 11 || arg1 == 12) {
            return 0xdcb0957ffbeffb4e4b934cc7df1b9b84fc40775de8bd7e0b188a725962496ea9::math::unsafe_mul(arg0, 2000000000)
        };
        if (arg1 == 2) {
            return 0xdcb0957ffbeffb4e4b934cc7df1b9b84fc40775de8bd7e0b188a725962496ea9::math::unsafe_mul(arg0, 35000000000)
        };
        0
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
        };
        0x2::transfer::share_object<HouseData<T0>>(v0);
    }

    public fun max_number_risk_vector(arg0: &vector<NumberRisk>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v0 < 0x1::vector::length<NumberRisk>(arg0)) {
            let v2 = 0x1::vector::borrow<NumberRisk>(arg0, v0);
            if (v2.risk > v1) {
                v1 = v2.risk;
            };
            v0 = v0 + 1;
        };
        v1
    }

    public entry fun place_bet<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u8, arg2: 0x1::option::Option<u64>, arg3: &mut RouletteGame<T0>, arg4: &mut HouseData<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 >= 0 && arg1 <= 12, 10);
        let v0 = 0x2::coin::value<T0>(&arg0);
        let v1 = get_bet_payout(v0, arg1);
        if (arg1 == 2) {
            assert!(!0x1::option::is_none<u64>(&arg2), 12);
            let v2 = max_number_risk_vector(&arg3.numbers_risk);
            let v3 = 0x1::vector::borrow_mut<NumberRisk>(&mut arg3.numbers_risk, *0x1::option::borrow<u64>(&arg2));
            v3.risk = v3.risk + v1;
            if (v3.risk > v2) {
                arg4.house_risk = arg4.house_risk + v3.risk - v2;
                arg3.total_risked = arg3.total_risked + v3.risk - v2;
            };
        } else {
            arg4.house_risk = arg4.house_risk + v1;
            arg3.total_risked = arg3.total_risked + v1;
        };
        assert!(house_risk<T0>(arg4) <= balance<T0>(arg4), 8);
        assert!(arg3.total_risked <= arg4.max_risk_per_game, 8);
        assert!(arg3.status == 0, 0);
        assert!(v0 >= arg3.min_bet, 6);
        let v4 = Bet<T0>{
            id         : 0x2::object::new(arg5),
            bet_type   : arg1,
            bet_number : arg2,
            bet_size   : 0x2::coin::into_balance<T0>(arg0),
            player     : 0x2::tx_context::sender(arg5),
        };
        let v5 = PlaceBet<T0>{
            bet_id     : *0x2::object::uid_as_inner(&v4.id),
            bet_type   : v4.bet_type,
            bet_number : v4.bet_number,
            bet_size   : 0x2::balance::value<T0>(&v4.bet_size),
            player     : v4.player,
        };
        0x2::event::emit<PlaceBet<T0>>(v5);
        0x1::vector::push_back<Bet<T0>>(&mut arg3.bets, v4);
    }

    public entry fun refundAllBets<T0>(arg0: &HouseCap, arg1: &mut RouletteGame<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg1.bets;
        assert!(account_owner(arg0) == 0x2::tx_context::sender(arg2), 4);
        while (0x1::vector::length<Bet<T0>>(v0) > 0) {
            delete_bet<T0>(0x1::vector::pop_back<Bet<T0>>(v0), arg2);
        };
    }

    public entry fun set_account_owner(arg0: &mut HouseCap, arg1: &mut 0x2::tx_context::TxContext) {
        arg0.owner = 0x2::tx_context::sender(arg1);
    }

    public entry fun set_max_risk_per_game<T0>(arg0: &HouseCap, arg1: &mut HouseData<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(account_owner(arg0) == 0x2::tx_context::sender(arg3), 4);
        arg1.max_risk_per_game = arg2;
    }

    public entry fun top_up<T0>(arg0: &mut HouseData<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = HouseDeposit<T0>{amount: 0x2::coin::value<T0>(&arg1)};
        0x2::event::emit<HouseDeposit<T0>>(v0);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
    }

    public entry fun withdraw<T0>(arg0: &mut HouseData<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.house, 4);
        let v0 = HouseWithdraw<T0>{amount: arg1};
        0x2::event::emit<HouseWithdraw<T0>>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.balance, arg1, arg2), arg0.house);
    }

    public fun won_bet(arg0: u8, arg1: u64, arg2: 0x1::option::Option<u64>) : bool {
        if (arg0 == 2) {
            return 0x1::option::contains<u64>(&arg2, &arg1)
        };
        if (arg1 == 0 || arg1 == 37) {
            return false
        };
        if (arg0 == 3) {
            return arg1 % 2 == 0
        };
        if (arg0 == 4) {
            return arg1 % 2 != 0
        };
        if (arg0 == 0) {
            return arg1 == 1 || arg1 == 3 || arg1 == 5 || arg1 == 7 || arg1 == 9 || arg1 == 12 || arg1 == 14 || arg1 == 16 || arg1 == 18 || arg1 == 19 || arg1 == 21 || arg1 == 23 || arg1 == 25 || arg1 == 27 || arg1 == 30 || arg1 == 32 || arg1 == 34 || arg1 == 36
        };
        if (arg0 == 1) {
            return arg1 == 2 || arg1 == 4 || arg1 == 6 || arg1 == 8 || arg1 == 10 || arg1 == 11 || arg1 == 13 || arg1 == 15 || arg1 == 17 || arg1 == 20 || arg1 == 22 || arg1 == 24 || arg1 == 26 || arg1 == 28 || arg1 == 29 || arg1 == 31 || arg1 == 33 || arg1 == 35
        };
        if (arg0 == 8) {
            return arg1 >= 1 && arg1 <= 18
        };
        if (arg0 == 9) {
            return arg1 >= 19 && arg1 <= 36
        };
        if (arg0 == 5) {
            return arg1 >= 1 && arg1 <= 12
        };
        if (arg0 == 6) {
            return arg1 >= 13 && arg1 <= 24
        };
        if (arg0 == 7) {
            return arg1 >= 25 && arg1 <= 36
        };
        if (arg0 == 10) {
            return (arg1 + 2) % 3 == 0
        };
        if (arg0 == 11) {
            return (arg1 + 1) % 3 == 0
        };
        if (arg0 == 12) {
            return arg1 % 3 == 0
        };
        false
    }

    // decompiled from Move bytecode v6
}

