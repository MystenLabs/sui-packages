module 0x61802af97d844828e1a6aa7ab1c95fa3f88378addb24f7090717aeb754010a7d::hdmv {
    struct Cast has store, key {
        id: 0x2::object::UID,
        user: address,
        at: 0x1::string::String,
        ate: u64,
        df: 0x1::string::String,
        dfe: u64,
        flag: u64,
    }

    struct Room has store, key {
        id: 0x2::object::UID,
        roomname: 0x1::string::String,
        castList: 0x2::table::Table<u64, Cast>,
        usrQueue: vector<u64>,
        usrBattle: vector<u64>,
        fightPlan: vector<FightQ>,
        flag: u64,
        starttime: u64,
        roundtime: u64,
        limited: u64,
        roundusers: u64,
    }

    struct FightQ has store {
        att: u64,
        def: u64,
    }

    struct RankList has store, key {
        id: 0x2::object::UID,
        usrScore: 0x2::table::Table<u64, Player>,
    }

    struct PlayerList has store, key {
        id: 0x2::object::UID,
        usrno: 0x2::table::Table<address, u64>,
        usrlist: 0x2::table::Table<u64, Player>,
    }

    struct Player has store {
        player: address,
        score: u64,
    }

    struct NewRoomCapEv has copy, drop {
        id: 0x2::object::ID,
    }

    struct NewPlayerListEv has copy, drop {
        id: 0x2::object::ID,
    }

    struct NewPRankListEv has copy, drop {
        id: 0x2::object::ID,
    }

    public fun add_queue(arg0: &mut Room, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Cast{
            id   : 0x2::object::new(arg3),
            user : 0x2::tx_context::sender(arg3),
            at   : arg1,
            ate  : 0,
            df   : arg2,
            dfe  : 0,
            flag : 0,
        };
        let v1 = 0x1::vector::length<u64>(&arg0.usrQueue);
        0x1::vector::push_back<u64>(&mut arg0.usrQueue, v1);
        0x2::table::add<u64, Cast>(&mut arg0.castList, v1, v0);
    }

    public fun create_room(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg3);
        let v1 = Room{
            id         : v0,
            roomname   : arg0,
            castList   : 0x2::table::new<u64, Cast>(arg3),
            usrQueue   : 0x1::vector::empty<u64>(),
            usrBattle  : 0x1::vector::empty<u64>(),
            fightPlan  : 0x1::vector::empty<FightQ>(),
            flag       : 0,
            starttime  : 0,
            roundtime  : 0,
            limited    : 3,
            roundusers : 0,
        };
        let v2 = &mut v1;
        add_queue(v2, arg1, arg2, arg3);
        0x2::transfer::public_share_object<Room>(v1);
        let v3 = NewRoomCapEv{id: 0x2::object::uid_to_inner(&v0)};
        0x2::event::emit<NewRoomCapEv>(v3);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg0);
        let v1 = PlayerList{
            id      : v0,
            usrno   : 0x2::table::new<address, u64>(arg0),
            usrlist : 0x2::table::new<u64, Player>(arg0),
        };
        0x2::transfer::public_share_object<PlayerList>(v1);
        let v2 = NewPlayerListEv{id: 0x2::object::uid_to_inner(&v0)};
        0x2::event::emit<NewPlayerListEv>(v2);
        let v3 = 0x2::object::new(arg0);
        let v4 = RankList{
            id       : v3,
            usrScore : 0x2::table::new<u64, Player>(arg0),
        };
        let v5 = 0;
        while (v5 < 10) {
            let v6 = Player{
                player : @0xaabb,
                score  : 10 - v5,
            };
            0x2::table::add<u64, Player>(&mut v4.usrScore, v5, v6);
            v5 = v5 + 1;
        };
        0x2::transfer::public_share_object<RankList>(v4);
        let v7 = NewPRankListEv{id: 0x2::object::uid_to_inner(&v3)};
        0x2::event::emit<NewPRankListEv>(v7);
    }

    fun init_queue(arg0: &mut vector<u64>, arg1: u64) {
        0x1::vector::push_back<u64>(arg0, arg1);
    }

    public fun join_room(arg0: &mut RankList, arg1: &mut Room, arg2: &mut PlayerList, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.flag != 0, 1001);
        add_queue(arg1, arg3, arg4, arg5);
        if (arg1.roundusers >= 3) {
            startgame(arg0, arg2, arg1, arg5);
        };
    }

    public fun new_logic(arg0: 0x1::string::String, arg1: 0x1::string::String) : u64 {
        let v0 = 0;
        let v1 = *0x1::string::bytes(&arg0);
        let v2 = *0x1::string::bytes(&arg1);
        if (v1 == v2) {
            v0 = 1;
        };
        if (b"Rock" == v1 && b"Scissors" == v2) {
            v0 = 3;
        };
        if (b"Rock" == v1 && b"Paper" == v2) {
            v0 = 0;
        };
        if (b"Scissors" == v1 && b"Paper" == v2) {
            v0 = 3;
        };
        if (b"Scissors" == v1 && b"Rock" == v2) {
            v0 = 0;
        };
        if (b"Paper" == v1 && b"Rock" == v2) {
            v0 = 3;
        };
        if (b"Paper" == v1 && b"Scissors" == v2) {
            v0 = 0;
        };
        v0
    }

    public fun randint(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::object::new(arg1);
        let v1 = 0x1::hash::sha2_256(0x2::object::uid_to_bytes(&v0));
        assert!(0x1::vector::length<u8>(&v1) >= 16, 1001);
        let v2 = 0;
        let v3 = 0;
        while (v3 < 16) {
            let v4 = v2 << 8;
            v2 = v4 + (*0x1::vector::borrow<u8>(&v1, v3) as u128);
            v3 = v3 + 1;
        };
        0x2::object::delete(v0);
        ((v2 % (arg0 as u128)) as u64)
    }

    fun startgame(arg0: &mut RankList, arg1: &mut PlayerList, arg2: &mut Room, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<u64>(&arg2.usrQueue);
        while (v0 > 0) {
            let v1 = randint(v0, arg3);
            0x1::vector::remove<u64>(&mut arg2.usrQueue, v1);
            let v2 = &mut arg2.usrBattle;
            init_queue(v2, *0x1::vector::borrow<u64>(&arg2.usrQueue, v1));
            v0 = 0x1::vector::length<u64>(&arg2.usrQueue);
        };
        let v3 = 0x1::vector::length<u64>(&arg2.usrBattle);
        let v4 = 0;
        while (v4 < v3) {
            let v5 = if (v4 + 1 == v3) {
                *0x1::vector::borrow<u64>(&arg2.usrBattle, 0)
            } else {
                *0x1::vector::borrow<u64>(&arg2.usrBattle, v4 + 1)
            };
            let v6 = FightQ{
                att : *0x1::vector::borrow<u64>(&arg2.usrBattle, v4),
                def : v5,
            };
            0x1::vector::push_back<FightQ>(&mut arg2.fightPlan, v6);
            v4 = v4 + 1;
        };
        0x1::debug::print<vector<FightQ>>(&arg2.fightPlan);
        v4 = 0;
        while (v4 < 0x1::vector::length<FightQ>(&arg2.fightPlan)) {
            let v7 = 0x1::vector::borrow<FightQ>(&arg2.fightPlan, 0);
            let v8 = 0x2::table::borrow<u64, Cast>(&arg2.castList, v7.att);
            let v9 = 0x2::table::borrow<u64, Cast>(&arg2.castList, v7.def);
            let v10 = new_logic(v8.at, v9.df);
            if (v10 == 3) {
                updateplayer(arg1, v8, 3);
            };
            if (v10 == 1) {
                updateplayer(arg1, v8, 1);
                updateplayer(arg1, v9, 1);
            };
            v4 = v4 + 1;
        };
        updaterank(arg0, arg1, arg2);
    }

    fun updateplayer(arg0: &mut PlayerList, arg1: &Cast, arg2: u64) {
        let v0 = arg1.user;
        if (0x2::table::contains<address, u64>(&arg0.usrno, v0)) {
            let v1 = 0x2::table::borrow_mut<u64, Player>(&mut arg0.usrlist, *0x2::table::borrow<address, u64>(&arg0.usrno, v0));
            if (v0 == v1.player) {
                v1.score = v1.score + arg2;
            };
        } else {
            let v2 = Player{
                player : v0,
                score  : arg2,
            };
            let v3 = 0x2::table::length<address, u64>(&arg0.usrno);
            0x2::table::add<address, u64>(&mut arg0.usrno, v0, v3);
            0x2::table::add<u64, Player>(&mut arg0.usrlist, v3, v2);
        };
    }

    fun updaterank(arg0: &mut RankList, arg1: &mut PlayerList, arg2: &mut Room) {
        let v0 = 10;
        let v1 = 0;
        while (v1 < 0x2::table::length<u64, Cast>(&arg2.castList)) {
            let v2 = 0x2::table::borrow_mut<u64, Player>(&mut arg1.usrlist, *0x2::table::borrow<address, u64>(&arg1.usrno, 0x2::table::borrow<u64, Cast>(&arg2.castList, v1).user)).score;
            0x2::table::length<u64, Player>(&arg0.usrScore);
            let v3 = 0;
            let v4 = 0;
            let v5 = 0;
            while (v3 < v0) {
                let v6 = 0x2::table::borrow<u64, Player>(&arg0.usrScore, v3);
                if (v6.score < v2) {
                    v4 = 1;
                    v5 = v3;
                    break
                };
                if (v6.score == v2) {
                    v4 = 2;
                    v5 = v3;
                };
                v3 = v3 + 1;
            };
            if (v4 == 2) {
            };
        };
    }

    // decompiled from Move bytecode v6
}

