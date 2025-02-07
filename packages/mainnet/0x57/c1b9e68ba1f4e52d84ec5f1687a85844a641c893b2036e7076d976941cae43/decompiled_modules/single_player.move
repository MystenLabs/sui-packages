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
        0xd9fc80a30c89489764bc07f557dc17162a477d34a9b44e65aae48af8ead006e7::find_four_game::recordLatestMoveCol(arg1, arg2);
    }

    public fun do_win_stuffs(arg0: &mut 0xd9fc80a30c89489764bc07f557dc17162a477d34a9b44e65aae48af8ead006e7::find_four_game::GameBoard, arg1: &mut 0xd9fc80a30c89489764bc07f557dc17162a477d34a9b44e65aae48af8ead006e7::FFIO::Treasury, arg2: &mut 0x2::tx_context::TxContext) {
    }

    public fun do_win_stuffs2(arg0: &mut 0xd9fc80a30c89489764bc07f557dc17162a477d34a9b44e65aae48af8ead006e7::find_four_game::GameBoard, arg1: &mut 0xd9fc80a30c89489764bc07f557dc17162a477d34a9b44e65aae48af8ead006e7::FFIO::Treasury, arg2: &0xd9fc80a30c89489764bc07f557dc17162a477d34a9b44e65aae48af8ead006e7::profile_and_rank::ProfileTable, arg3: &mut 0x2::tx_context::TxContext) {
        if (!0xd9fc80a30c89489764bc07f557dc17162a477d34a9b44e65aae48af8ead006e7::find_four_game::getWinHandled(arg0) && 0xd9fc80a30c89489764bc07f557dc17162a477d34a9b44e65aae48af8ead006e7::find_four_game::getGameType(arg0) == 1) {
            0xd9fc80a30c89489764bc07f557dc17162a477d34a9b44e65aae48af8ead006e7::FFIO::reward_winner(arg1, 0xd9fc80a30c89489764bc07f557dc17162a477d34a9b44e65aae48af8ead006e7::profile_and_rank::get_trophies(arg2, 0x2::tx_context::sender(arg3)) * 1000000000 * 100, arg3);
            0xd9fc80a30c89489764bc07f557dc17162a477d34a9b44e65aae48af8ead006e7::find_four_game::setWinHandled(arg0, true);
        };
    }

    public entry fun pay_start_game_fee(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 1000000000 / 100 * 2;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) >= v0, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg0, v0, arg1), @0x8418bb05799666b73c4645aa15e4d1ccae824e1487c01a665f51767826d192b7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg1));
    }

    public fun player_make_move(arg0: &mut 0xd9fc80a30c89489764bc07f557dc17162a477d34a9b44e65aae48af8ead006e7::find_four_game::GameBoard, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0xd9fc80a30c89489764bc07f557dc17162a477d34a9b44e65aae48af8ead006e7::find_four_game::player_move(arg0, arg1, arg2);
        0xd9fc80a30c89489764bc07f557dc17162a477d34a9b44e65aae48af8ead006e7::find_four_game::recordLatestMoveCol(arg0, arg1);
        let v0 = SinglePlayerGameHumanPlayerMadeAMove{
            game  : 0xd9fc80a30c89489764bc07f557dc17162a477d34a9b44e65aae48af8ead006e7::find_four_game::getGameId(arg0),
            nonce : 0xd9fc80a30c89489764bc07f557dc17162a477d34a9b44e65aae48af8ead006e7::find_four_game::getNonce(arg0),
        };
        0x2::event::emit<SinglePlayerGameHumanPlayerMadeAMove>(v0);
    }

    public fun start_single_player_game(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public fun start_single_player_game2(arg0: &mut 0xd9fc80a30c89489764bc07f557dc17162a477d34a9b44e65aae48af8ead006e7::find_four_game::GamesTracker, arg1: &mut 0x2::tx_context::TxContext) {
    }

    public fun start_single_player_game3(arg0: &mut 0xd9fc80a30c89489764bc07f557dc17162a477d34a9b44e65aae48af8ead006e7::find_four_game::GamesTracker, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        pay_start_game_fee(arg1, arg2);
        let v0 = 0xd9fc80a30c89489764bc07f557dc17162a477d34a9b44e65aae48af8ead006e7::find_four_game::initialize_game(0x2::tx_context::sender(arg2), @0x66696e64342e696f, 1, arg2);
        0xd9fc80a30c89489764bc07f557dc17162a477d34a9b44e65aae48af8ead006e7::find_four_game::addGameToTracker(0x2::tx_context::sender(arg2), v0, arg0);
        let v1 = SinglePlayerGameStartedEvent{
            game : v0,
            p1   : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<SinglePlayerGameStartedEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

