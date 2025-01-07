module 0x12ba8d36d31e22a3ae23991b2ead11a2cbd5028afcd6bcc88af1731762f6587f::events {
    struct HouseWithdraw<phantom T0> has copy, drop, store {
        amount: u64,
    }

    struct HouseDeposit<phantom T0> has copy, drop, store {
        amount: u64,
        depositor: address,
    }

    struct PlaceBet<phantom T0> has copy, drop, store {
        bet_id: 0x2::object::ID,
        bet_amount: u64,
        player: address,
    }

    struct GameCreated<phantom T0> has copy, drop, store {
        game_id: 0x2::object::ID,
    }

    struct CardDrawn<phantom T0> has copy, drop, store {
        game_id: 0x2::object::ID,
        game_round: u64,
        player_type: u8,
        card: u8,
        score: u8,
    }

    struct PlayerHand has copy, drop, store {
        game_id: 0x2::object::ID,
        player_hand: vector<u8>,
        split_hand: vector<u8>,
    }

    struct StageChanged has copy, drop, store {
        game_id: 0x2::object::ID,
        game_round: u64,
        stage: u8,
    }

    struct GameResult has copy, drop, store {
        game_id: 0x2::object::ID,
        game_round: u64,
        player: address,
        payout: u64,
        income: u64,
        player_score: u8,
        split_player_score: u8,
        dealer_score: u8,
    }

    struct SplitBet<phantom T0> has copy, drop, store {
        game_id: 0x2::object::ID,
        game_round: u64,
        bet_amount: u64,
        player: address,
    }

    struct DoubleDownBet<phantom T0> has copy, drop, store {
        game_id: 0x2::object::ID,
        game_round: u64,
        bet_amount: u64,
        player: address,
    }

    struct InsuranceBet<phantom T0> has copy, drop, store {
        game_id: 0x2::object::ID,
        game_round: u64,
        bet_amount: u64,
        player: address,
    }

    struct Surrender<phantom T0> has copy, drop, store {
        game_id: 0x2::object::ID,
        game_round: u64,
        pay_amount: u64,
        player: address,
    }

    public(friend) fun emit_card_drawn<T0>(arg0: 0x2::object::ID, arg1: u64, arg2: u8, arg3: u8, arg4: u8) {
        let v0 = CardDrawn<T0>{
            game_id     : arg0,
            game_round  : arg1,
            player_type : arg2,
            card        : arg3,
            score       : arg4,
        };
        0x2::event::emit<CardDrawn<T0>>(v0);
    }

    public(friend) fun emit_double_down_bet<T0>(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: address) {
        let v0 = DoubleDownBet<T0>{
            game_id    : arg0,
            game_round : arg1,
            bet_amount : arg2,
            player     : arg3,
        };
        0x2::event::emit<DoubleDownBet<T0>>(v0);
    }

    public(friend) fun emit_game_created<T0>(arg0: 0x2::object::ID) {
        let v0 = GameCreated<T0>{game_id: arg0};
        0x2::event::emit<GameCreated<T0>>(v0);
    }

    public(friend) fun emit_game_result(arg0: 0x2::object::ID, arg1: u64, arg2: address, arg3: u64, arg4: u64, arg5: u8, arg6: u8, arg7: u8) {
        let v0 = GameResult{
            game_id            : arg0,
            game_round         : arg1,
            player             : arg2,
            payout             : arg3,
            income             : arg4,
            player_score       : arg5,
            split_player_score : arg6,
            dealer_score       : arg7,
        };
        0x2::event::emit<GameResult>(v0);
    }

    public(friend) fun emit_house_deposit<T0>(arg0: u64, arg1: address) {
        let v0 = HouseDeposit<T0>{
            amount    : arg0,
            depositor : arg1,
        };
        0x2::event::emit<HouseDeposit<T0>>(v0);
    }

    public(friend) fun emit_house_withdraw<T0>(arg0: u64) {
        let v0 = HouseWithdraw<T0>{amount: arg0};
        0x2::event::emit<HouseWithdraw<T0>>(v0);
    }

    public(friend) fun emit_insurance_bet<T0>(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: address) {
        let v0 = InsuranceBet<T0>{
            game_id    : arg0,
            game_round : arg1,
            bet_amount : arg2,
            player     : arg3,
        };
        0x2::event::emit<InsuranceBet<T0>>(v0);
    }

    public(friend) fun emit_place_bet<T0>(arg0: 0x2::object::ID, arg1: u64, arg2: address) {
        let v0 = PlaceBet<T0>{
            bet_id     : arg0,
            bet_amount : arg1,
            player     : arg2,
        };
        0x2::event::emit<PlaceBet<T0>>(v0);
    }

    public(friend) fun emit_player_hand(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: vector<u8>) {
        let v0 = PlayerHand{
            game_id     : arg0,
            player_hand : arg1,
            split_hand  : arg2,
        };
        0x2::event::emit<PlayerHand>(v0);
    }

    public(friend) fun emit_split_bet<T0>(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: address) {
        let v0 = SplitBet<T0>{
            game_id    : arg0,
            game_round : arg1,
            bet_amount : arg2,
            player     : arg3,
        };
        0x2::event::emit<SplitBet<T0>>(v0);
    }

    public(friend) fun emit_stage_changed(arg0: 0x2::object::ID, arg1: u64, arg2: u8) {
        let v0 = StageChanged{
            game_id    : arg0,
            game_round : arg1,
            stage      : arg2,
        };
        0x2::event::emit<StageChanged>(v0);
    }

    public(friend) fun emit_surrender<T0>(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: address) {
        let v0 = Surrender<T0>{
            game_id    : arg0,
            game_round : arg1,
            pay_amount : arg2,
            player     : arg3,
        };
        0x2::event::emit<Surrender<T0>>(v0);
    }

    // decompiled from Move bytecode v6
}

