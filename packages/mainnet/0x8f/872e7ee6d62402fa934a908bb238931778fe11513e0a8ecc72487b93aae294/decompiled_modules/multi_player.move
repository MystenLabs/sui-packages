module 0x8f872e7ee6d62402fa934a908bb238931778fe11513e0a8ecc72487b93aae294::multi_player {
    struct PairingEvent has copy, drop, store {
        p1: address,
        p2: address,
        game: address,
    }

    struct AddToListEvent has copy, drop, store {
        addy: address,
        nonce: u64,
        points: u64,
    }

    struct FFIO_Nonce has key {
        id: 0x2::object::UID,
        nonce: u64,
        version: u64,
    }

    struct MultiPlayerGameStartedEvent2 has copy, drop, store {
        game: address,
        p1: address,
        p2: address,
        start_epoch: u64,
        nonce: u64,
    }

    struct MultiPlayerGameStartedEvent has copy, drop, store {
        game: address,
        p1: address,
        p2: address,
        start_epoch: u64,
    }

    struct MultiPlayerMoveEvent has copy, drop, store {
        game: address,
        p1: address,
        p2: address,
        epoch: u64,
    }

    public fun add_to_list(arg0: address, arg1: address, arg2: u64, arg3: &mut FFIO_Nonce) {
    }

    public fun add_to_list2(arg0: address, arg1: u64, arg2: &mut FFIO_Nonce) {
        check_version_Nonce(arg2);
        let v0 = AddToListEvent{
            addy   : arg0,
            nonce  : arg2.nonce,
            points : arg1,
        };
        0x2::event::emit<AddToListEvent>(v0);
    }

    public fun attempt_pairing(arg0: &0x8f872e7ee6d62402fa934a908bb238931778fe11513e0a8ecc72487b93aae294::FFIO::FindFourAdminCap, arg1: address, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = PairingEvent{
            p1   : arg1,
            p2   : arg2,
            game : 0x8f872e7ee6d62402fa934a908bb238931778fe11513e0a8ecc72487b93aae294::find_four_game::initialize_game(arg1, arg2, 2, arg3),
        };
        0x2::event::emit<PairingEvent>(v0);
    }

    fun check_version_Nonce(arg0: &FFIO_Nonce) {
        assert!(arg0.version == 1, 1);
    }

    public fun do_win_stuffs(arg0: &mut 0x8f872e7ee6d62402fa934a908bb238931778fe11513e0a8ecc72487b93aae294::find_four_game::GameBoard, arg1: &mut 0x8f872e7ee6d62402fa934a908bb238931778fe11513e0a8ecc72487b93aae294::profile_and_rank::ProfileTable, arg2: &mut 0x2::tx_context::TxContext) {
        if (!0x8f872e7ee6d62402fa934a908bb238931778fe11513e0a8ecc72487b93aae294::find_four_game::getWinHandled(arg0) && 0x8f872e7ee6d62402fa934a908bb238931778fe11513e0a8ecc72487b93aae294::find_four_game::getGameType(arg0) == 2) {
            0x8f872e7ee6d62402fa934a908bb238931778fe11513e0a8ecc72487b93aae294::profile_and_rank::update_both_trophies_after_win(arg1, 0x8f872e7ee6d62402fa934a908bb238931778fe11513e0a8ecc72487b93aae294::find_four_game::getWinner(arg0), 0x8f872e7ee6d62402fa934a908bb238931778fe11513e0a8ecc72487b93aae294::find_four_game::getP1(arg0), 0x8f872e7ee6d62402fa934a908bb238931778fe11513e0a8ecc72487b93aae294::find_four_game::getP2(arg0), arg2);
            0x8f872e7ee6d62402fa934a908bb238931778fe11513e0a8ecc72487b93aae294::find_four_game::setWinHandled(arg0, true);
        };
    }

    fun getCurrentEpoch(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 1000
    }

    public(friend) fun incrementNonce(arg0: &mut FFIO_Nonce) {
        check_version_Nonce(arg0);
        arg0.nonce = arg0.nonce + 1;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<FFIO_Nonce>(initialize_nonce_tracker(arg0));
    }

    fun initialize_nonce_tracker(arg0: &mut 0x2::tx_context::TxContext) : FFIO_Nonce {
        FFIO_Nonce{
            id      : 0x2::object::new(arg0),
            nonce   : 0,
            version : 1,
        }
    }

    public fun player_make_move(arg0: &mut 0x8f872e7ee6d62402fa934a908bb238931778fe11513e0a8ecc72487b93aae294::find_four_game::GameBoard, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x8f872e7ee6d62402fa934a908bb238931778fe11513e0a8ecc72487b93aae294::find_four_game::player_move(arg0, arg1, arg2);
        0x8f872e7ee6d62402fa934a908bb238931778fe11513e0a8ecc72487b93aae294::find_four_game::recordLatestMoveCol(arg0, arg1);
        let v0 = MultiPlayerMoveEvent{
            game  : 0x8f872e7ee6d62402fa934a908bb238931778fe11513e0a8ecc72487b93aae294::find_four_game::getGameId(arg0),
            p1    : 0x8f872e7ee6d62402fa934a908bb238931778fe11513e0a8ecc72487b93aae294::find_four_game::getP1(arg0),
            p2    : 0x8f872e7ee6d62402fa934a908bb238931778fe11513e0a8ecc72487b93aae294::find_four_game::getP2(arg0),
            epoch : 0,
        };
        0x2::event::emit<MultiPlayerMoveEvent>(v0);
    }

    public fun start_multi_player_game(arg0: address, arg1: &0x2::clock::Clock, arg2: &mut 0x8f872e7ee6d62402fa934a908bb238931778fe11513e0a8ecc72487b93aae294::find_four_game::GamesTracker, arg3: &mut 0x2::tx_context::TxContext) {
    }

    public fun start_multi_player_game2(arg0: address, arg1: &0x2::clock::Clock, arg2: &mut 0x8f872e7ee6d62402fa934a908bb238931778fe11513e0a8ecc72487b93aae294::find_four_game::GamesTracker, arg3: &mut FFIO_Nonce, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x8f872e7ee6d62402fa934a908bb238931778fe11513e0a8ecc72487b93aae294::find_four_game::initialize_game(v0, arg0, 2, arg4);
        let v2 = MultiPlayerGameStartedEvent2{
            game        : v1,
            p1          : v0,
            p2          : arg0,
            start_epoch : getCurrentEpoch(arg1),
            nonce       : arg3.nonce,
        };
        0x8f872e7ee6d62402fa934a908bb238931778fe11513e0a8ecc72487b93aae294::find_four_game::addGameToTracker(v0, v1, arg2);
        0x8f872e7ee6d62402fa934a908bb238931778fe11513e0a8ecc72487b93aae294::find_four_game::addGameToTracker(arg0, v1, arg2);
        0x2::event::emit<MultiPlayerGameStartedEvent2>(v2);
    }

    public entry fun update_version(arg0: &0x8f872e7ee6d62402fa934a908bb238931778fe11513e0a8ecc72487b93aae294::FFIO::FindFourAdminCap, arg1: &mut FFIO_Nonce) {
        arg1.version = 1;
    }

    // decompiled from Move bytecode v6
}

