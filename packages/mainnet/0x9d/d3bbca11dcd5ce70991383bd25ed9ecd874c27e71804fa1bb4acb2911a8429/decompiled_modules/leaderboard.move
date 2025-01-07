module 0x9dd3bbca11dcd5ce70991383bd25ed9ecd874c27e71804fa1bb4acb2911a8429::leaderboard {
    struct RankBoard has copy, drop, store {
        board_id: 0x2::object::ID,
        board_num: u64,
        player: address,
        stage: u64,
        last_update_date: u64,
    }

    struct Leaderboard has store, key {
        id: 0x2::object::UID,
        ranks: vector<RankBoard>,
        maxRankCount: u64,
        minStage: u64,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Leaderboard{
            id           : 0x2::object::new(arg0),
            ranks        : 0x1::vector::empty<RankBoard>(),
            maxRankCount : 100,
            minStage     : 0,
        };
        0x2::transfer::public_transfer<Leaderboard>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun ranks(arg0: &Leaderboard) : &vector<RankBoard> {
        &arg0.ranks
    }

    public entry fun set_clearrank(arg0: &mut Leaderboard, arg1: &mut 0x9dd3bbca11dcd5ce70991383bd25ed9ecd874c27e71804fa1bb4acb2911a8429::bp::LobbyManager, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == *0x9dd3bbca11dcd5ce70991383bd25ed9ecd874c27e71804fa1bb4acb2911a8429::bp::LobbyManagerAddress(arg1), 1);
        loop {
            if (0x1::vector::length<RankBoard>(&arg0.ranks) == 0) {
                break
            };
            0x1::vector::pop_back<RankBoard>(&mut arg0.ranks);
        };
        arg0.minStage = 0;
    }

    public entry fun set_maxrankcount(arg0: &mut Leaderboard, arg1: &mut 0x9dd3bbca11dcd5ce70991383bd25ed9ecd874c27e71804fa1bb4acb2911a8429::bp::LobbyManager, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == *0x9dd3bbca11dcd5ce70991383bd25ed9ecd874c27e71804fa1bb4acb2911a8429::bp::LobbyManagerAddress(arg1), 1);
        arg0.maxRankCount = arg2;
    }

    fun sort(arg0: vector<RankBoard>, arg1: &mut Leaderboard) : vector<RankBoard> {
        let v0 = 0x1::vector::length<RankBoard>(&arg0);
        if (v0 == 1) {
            return arg0
        };
        let v1 = 0;
        while (v1 < v0) {
            let v2 = 0x1::vector::borrow<RankBoard>(&arg0, v1);
            if (v1 + 1 >= v0) {
                break
            };
            if (v2.stage > 0x1::vector::borrow<RankBoard>(&arg0, v1 + 1).stage) {
                0x1::vector::swap<RankBoard>(&mut arg0, v1, v1 + 1);
            };
            v1 = v1 + 1;
        };
        if (v0 >= arg1.maxRankCount) {
            arg1.minStage = 0x1::vector::borrow<RankBoard>(&arg0, 0).stage;
        };
        0x1::vector::reverse<RankBoard>(&mut arg0);
        loop {
            if (0x1::vector::length<RankBoard>(&arg0) <= arg1.maxRankCount) {
                break
            };
            0x1::vector::pop_back<RankBoard>(&mut arg0);
        };
        arg0
    }

    public entry fun update_rank(arg0: &0x9dd3bbca11dcd5ce70991383bd25ed9ecd874c27e71804fa1bb4acb2911a8429::bp::PlayerBoard, arg1: &mut Leaderboard, arg2: &mut 0x9dd3bbca11dcd5ce70991383bd25ed9ecd874c27e71804fa1bb4acb2911a8429::bp::LobbyManager, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == *0x9dd3bbca11dcd5ce70991383bd25ed9ecd874c27e71804fa1bb4acb2911a8429::bp::LobbyManagerAddress(arg2), 1);
        let v0 = *0x9dd3bbca11dcd5ce70991383bd25ed9ecd874c27e71804fa1bb4acb2911a8429::bp::current_stage(arg0);
        let v1 = *0x9dd3bbca11dcd5ce70991383bd25ed9ecd874c27e71804fa1bb4acb2911a8429::bp::player(arg0);
        assert!(v0 > arg1.minStage, 0);
        let v2 = 0;
        while (v2 < 0x1::vector::length<RankBoard>(&arg1.ranks)) {
            let v3 = 0x1::vector::borrow<RankBoard>(&arg1.ranks, v2);
            if (v1 == v3.player) {
                assert!(v3.stage < v0, 0);
                0x1::vector::remove<RankBoard>(&mut arg1.ranks, v2);
                break
            };
            v2 = v2 + 1;
        };
        let v4 = RankBoard{
            board_id         : 0x9dd3bbca11dcd5ce70991383bd25ed9ecd874c27e71804fa1bb4acb2911a8429::bp::board_id(arg0),
            board_num        : 0x9dd3bbca11dcd5ce70991383bd25ed9ecd874c27e71804fa1bb4acb2911a8429::bp::board_num(arg0),
            player           : v1,
            stage            : v0,
            last_update_date : arg3,
        };
        0x1::vector::push_back<RankBoard>(&mut arg1.ranks, v4);
        0x1::vector::reverse<RankBoard>(&mut arg1.ranks);
        let v5 = arg1.ranks;
        let v6 = sort(v5, arg1);
        arg1.ranks = v6;
    }

    // decompiled from Move bytecode v6
}

