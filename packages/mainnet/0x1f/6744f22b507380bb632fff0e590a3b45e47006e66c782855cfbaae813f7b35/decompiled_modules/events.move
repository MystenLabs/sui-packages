module 0xc0bfc90b3a663357d63878cef0ec80b623624eb0127300f3accda005cf155a73::events {
    struct PlaceBet<phantom T0> has copy, drop, store {
        bet_id: 0x2::object::ID,
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

    struct BetResult<phantom T0> has copy, drop, store {
        bet_id: 0x2::object::ID,
        is_win: bool,
        bet_type: u8,
        bet_number: 0x1::option::Option<u64>,
        bet_size: u64,
        player: address,
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

    public(friend) fun emit_game_closed<T0>(arg0: 0x2::object::ID) {
        let v0 = GameClosed<T0>{game_id: arg0};
        0x2::event::emit<GameClosed<T0>>(v0);
    }

    public(friend) fun emit_game_completed<T0>(arg0: 0x2::object::ID, arg1: u64, arg2: vector<BetResult<T0>>) {
        let v0 = GameCompleted<T0>{
            game_id     : arg0,
            result_roll : arg1,
            bet_results : arg2,
        };
        0x2::event::emit<GameCompleted<T0>>(v0);
    }

    public(friend) fun emit_game_created<T0>(arg0: 0x2::object::ID) {
        let v0 = GameCreated<T0>{game_id: arg0};
        0x2::event::emit<GameCreated<T0>>(v0);
    }

    public(friend) fun emit_house_deposit<T0>(arg0: u64) {
        let v0 = HouseDeposit<T0>{amount: arg0};
        0x2::event::emit<HouseDeposit<T0>>(v0);
    }

    public(friend) fun emit_house_withdraw<T0>(arg0: u64) {
        let v0 = HouseWithdraw<T0>{amount: arg0};
        0x2::event::emit<HouseWithdraw<T0>>(v0);
    }

    public(friend) fun emit_place_bet<T0>(arg0: 0x2::object::ID, arg1: u8, arg2: 0x1::option::Option<u64>, arg3: u64, arg4: address) {
        let v0 = PlaceBet<T0>{
            bet_id     : arg0,
            bet_type   : arg1,
            bet_number : arg2,
            bet_size   : arg3,
            player     : arg4,
        };
        0x2::event::emit<PlaceBet<T0>>(v0);
    }

    public(friend) fun new_bet_result<T0>(arg0: 0x2::object::ID, arg1: bool, arg2: u8, arg3: 0x1::option::Option<u64>, arg4: u64, arg5: address) : BetResult<T0> {
        BetResult<T0>{
            bet_id     : arg0,
            is_win     : arg1,
            bet_type   : arg2,
            bet_number : arg3,
            bet_size   : arg4,
            player     : arg5,
        }
    }

    // decompiled from Move bytecode v6
}

