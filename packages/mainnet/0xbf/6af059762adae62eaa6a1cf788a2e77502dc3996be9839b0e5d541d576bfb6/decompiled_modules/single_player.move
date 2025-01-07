module 0xd9fc80a30c89489764bc07f557dc17162a477d34a9b44e65aae48af8ead006e7::single_player {
    struct SinglePlayerGameStartedEvent has copy, drop, store {
        game: address,
        p1: address,
    }

    struct SinglePlayerGameHumanPlayerMadeAMove has copy, drop, store {
        game: address,
        nonce: u64,
    }

    public fun ai_make_move(arg0: &0xd9fc80a30c89489764bc07f557dc17162a477d34a9b44e65aae48af8ead006e7::FFIO::FindFourAdminCap, arg1: &mut 0xd9fc80a30c89489764bc07f557dc17162a477d34a9b44e65aae48af8ead006e7::find_four_game::GameBoard, arg2: u64) {
        0xd9fc80a30c89489764bc07f557dc17162a477d34a9b44e65aae48af8ead006e7::find_four_game::ai_move(arg1, arg2);
        0xd9fc80a30c89489764bc07f557dc17162a477d34a9b44e65aae48af8ead006e7::find_four_game::incrementGameNonce(arg1);
    }

    public fun do_win_stuffs(arg0: &mut 0xd9fc80a30c89489764bc07f557dc17162a477d34a9b44e65aae48af8ead006e7::find_four_game::GameBoard, arg1: &mut 0xd9fc80a30c89489764bc07f557dc17162a477d34a9b44e65aae48af8ead006e7::FFIO::Treasury, arg2: &mut 0x2::tx_context::TxContext) {
        if (!0xd9fc80a30c89489764bc07f557dc17162a477d34a9b44e65aae48af8ead006e7::find_four_game::getWinHandled(arg0) && 0xd9fc80a30c89489764bc07f557dc17162a477d34a9b44e65aae48af8ead006e7::find_four_game::getGameType(arg0) == 1) {
            0xd9fc80a30c89489764bc07f557dc17162a477d34a9b44e65aae48af8ead006e7::FFIO::reward_winner(arg1, 1, arg2);
            0xd9fc80a30c89489764bc07f557dc17162a477d34a9b44e65aae48af8ead006e7::find_four_game::setWinHandled(arg0, true);
        };
    }

    public fun player_make_move(arg0: &mut 0xd9fc80a30c89489764bc07f557dc17162a477d34a9b44e65aae48af8ead006e7::find_four_game::GameBoard, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0xd9fc80a30c89489764bc07f557dc17162a477d34a9b44e65aae48af8ead006e7::find_four_game::player_move(arg0, arg1, arg2);
        0xd9fc80a30c89489764bc07f557dc17162a477d34a9b44e65aae48af8ead006e7::find_four_game::incrementGameNonce(arg0);
        let v0 = SinglePlayerGameHumanPlayerMadeAMove{
            game  : 0xd9fc80a30c89489764bc07f557dc17162a477d34a9b44e65aae48af8ead006e7::find_four_game::getGameId(arg0),
            nonce : 0xd9fc80a30c89489764bc07f557dc17162a477d34a9b44e65aae48af8ead006e7::find_four_game::getNonce(arg0),
        };
        0x2::event::emit<SinglePlayerGameHumanPlayerMadeAMove>(v0);
    }

    public fun start_single_player_game(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SinglePlayerGameStartedEvent{
            game : 0xd9fc80a30c89489764bc07f557dc17162a477d34a9b44e65aae48af8ead006e7::find_four_game::initialize_game(0x2::tx_context::sender(arg0), @0x66696e64342e696f, 1, arg0),
            p1   : 0x2::tx_context::sender(arg0),
        };
        0x2::event::emit<SinglePlayerGameStartedEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

