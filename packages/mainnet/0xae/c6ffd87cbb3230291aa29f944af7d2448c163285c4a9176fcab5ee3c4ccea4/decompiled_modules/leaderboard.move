module 0xaec6ffd87cbb3230291aa29f944af7d2448c163285c4a9176fcab5ee3c4ccea4::leaderboard {
    struct Leaderboard has key {
        id: 0x2::object::UID,
        wins: 0x2::vec_map::VecMap<0x1::string::String, u64>,
        losses: 0x2::vec_map::VecMap<0x1::string::String, u64>,
        draws: 0x2::vec_map::VecMap<0x1::string::String, u64>,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Leaderboard{
            id     : 0x2::object::new(arg0),
            wins   : 0x2::vec_map::empty<0x1::string::String, u64>(),
            losses : 0x2::vec_map::empty<0x1::string::String, u64>(),
            draws  : 0x2::vec_map::empty<0x1::string::String, u64>(),
        };
        0x2::transfer::share_object<Leaderboard>(v0);
    }

    public entry fun record_result(arg0: &mut Leaderboard, arg1: vector<u8>, arg2: vector<u8>, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(arg1);
        let v1 = 0x1::string::utf8(arg2);
        if (arg3) {
            if (0x2::vec_map::contains<0x1::string::String, u64>(&arg0.draws, &v0)) {
                let v2 = 0x2::vec_map::get_mut<0x1::string::String, u64>(&mut arg0.draws, &v0);
                *v2 = *v2 + 1;
            } else {
                0x2::vec_map::insert<0x1::string::String, u64>(&mut arg0.draws, v0, 1);
            };
            if (0x2::vec_map::contains<0x1::string::String, u64>(&arg0.draws, &v1)) {
                let v3 = 0x2::vec_map::get_mut<0x1::string::String, u64>(&mut arg0.draws, &v1);
                *v3 = *v3 + 1;
            } else {
                0x2::vec_map::insert<0x1::string::String, u64>(&mut arg0.draws, v1, 1);
            };
        } else {
            if (0x2::vec_map::contains<0x1::string::String, u64>(&arg0.wins, &v0)) {
                let v4 = 0x2::vec_map::get_mut<0x1::string::String, u64>(&mut arg0.wins, &v0);
                *v4 = *v4 + 1;
            } else {
                0x2::vec_map::insert<0x1::string::String, u64>(&mut arg0.wins, v0, 1);
            };
            if (0x2::vec_map::contains<0x1::string::String, u64>(&arg0.losses, &v1)) {
                let v5 = 0x2::vec_map::get_mut<0x1::string::String, u64>(&mut arg0.losses, &v1);
                *v5 = *v5 + 1;
            } else {
                0x2::vec_map::insert<0x1::string::String, u64>(&mut arg0.losses, v1, 1);
            };
        };
    }

    // decompiled from Move bytecode v7
}

