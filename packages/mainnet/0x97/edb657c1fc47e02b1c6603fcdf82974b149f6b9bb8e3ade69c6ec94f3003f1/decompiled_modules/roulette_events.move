module 0x97edb657c1fc47e02b1c6603fcdf82974b149f6b9bb8e3ade69c6ec94f3003f1::roulette_events {
    struct PlaceBet<phantom T0> has copy, drop, store {
        game_round: u64,
        game_id: 0x2::object::ID,
        bet_id: 0x2::object::ID,
        bet_type: u8,
        bet_number: 0x1::option::Option<u64>,
        bet_size: u64,
        player: address,
    }

    struct PlaceBetWithVoucher<phantom T0> has copy, drop, store {
        voucher_id: 0x2::object::ID,
        game_round: u64,
        game_id: 0x2::object::ID,
        bet_id: 0x2::object::ID,
        bet_type: u8,
        bet_number: 0x1::option::Option<u64>,
        bet_size: u64,
        player: address,
    }

    struct VoucherUsed<phantom T0> has copy, drop {
        voucher_id: 0x2::object::ID,
        first_used: bool,
        deduction_amount: u64,
        current_balance: u64,
    }

    struct GameCreated<phantom T0> has copy, drop, store {
        game_round: u64,
        game_id: 0x2::object::ID,
    }

    struct GameClosed<phantom T0> has copy, drop, store {
        game_round: u64,
        game_id: 0x2::object::ID,
        result_roll: u64,
    }

    struct BetResult<phantom T0> has copy, drop, store {
        bet_id: 0x2::object::ID,
        is_win: bool,
        bet_type: u8,
        bet_number: 0x1::option::Option<u64>,
        bet_size: u64,
        player: address,
    }

    struct GameSettlement<phantom T0> has copy, drop, store {
        game_round: u64,
        game_id: 0x2::object::ID,
        result_roll: u64,
        bet_results: vector<BetResult<T0>>,
    }

    struct GameCompleted<phantom T0> has copy, drop, store {
        game_round: u64,
        game_id: 0x2::object::ID,
    }

    public(friend) fun emit_game_closed<T0>(arg0: u64, arg1: 0x2::object::ID, arg2: u64) {
        let v0 = GameClosed<T0>{
            game_round  : arg0,
            game_id     : arg1,
            result_roll : arg2,
        };
        0x2::event::emit<GameClosed<T0>>(v0);
    }

    public(friend) fun emit_game_completed<T0>(arg0: u64, arg1: 0x2::object::ID) {
        let v0 = GameCompleted<T0>{
            game_round : arg0,
            game_id    : arg1,
        };
        0x2::event::emit<GameCompleted<T0>>(v0);
    }

    public(friend) fun emit_game_created<T0>(arg0: u64, arg1: 0x2::object::ID) {
        let v0 = GameCreated<T0>{
            game_round : arg0,
            game_id    : arg1,
        };
        0x2::event::emit<GameCreated<T0>>(v0);
    }

    public(friend) fun emit_game_settlement<T0>(arg0: u64, arg1: 0x2::object::ID, arg2: u64, arg3: vector<BetResult<T0>>) {
        let v0 = GameSettlement<T0>{
            game_round  : arg0,
            game_id     : arg1,
            result_roll : arg2,
            bet_results : arg3,
        };
        0x2::event::emit<GameSettlement<T0>>(v0);
    }

    public(friend) fun emit_place_bet<T0>(arg0: u64, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u8, arg4: 0x1::option::Option<u64>, arg5: u64, arg6: address) {
        let v0 = PlaceBet<T0>{
            game_round : arg0,
            game_id    : arg1,
            bet_id     : arg2,
            bet_type   : arg3,
            bet_number : arg4,
            bet_size   : arg5,
            player     : arg6,
        };
        0x2::event::emit<PlaceBet<T0>>(v0);
    }

    public(friend) fun emit_place_bet_with_voucher<T0>(arg0: 0x2::object::ID, arg1: u64, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: u8, arg5: 0x1::option::Option<u64>, arg6: u64, arg7: address) {
        let v0 = PlaceBetWithVoucher<T0>{
            voucher_id : arg0,
            game_round : arg1,
            game_id    : arg2,
            bet_id     : arg3,
            bet_type   : arg4,
            bet_number : arg5,
            bet_size   : arg6,
            player     : arg7,
        };
        0x2::event::emit<PlaceBetWithVoucher<T0>>(v0);
    }

    public(friend) fun emit_voucher_used<T0>(arg0: 0x2::object::ID, arg1: bool, arg2: u64, arg3: u64) {
        let v0 = VoucherUsed<T0>{
            voucher_id       : arg0,
            first_used       : arg1,
            deduction_amount : arg2,
            current_balance  : arg3,
        };
        0x2::event::emit<VoucherUsed<T0>>(v0);
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

