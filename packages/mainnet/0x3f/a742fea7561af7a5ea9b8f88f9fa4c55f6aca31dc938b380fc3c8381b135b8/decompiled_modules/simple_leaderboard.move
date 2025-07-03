module 0x3fa742fea7561af7a5ea9b8f88f9fa4c55f6aca31dc938b380fc3c8381b135b8::simple_leaderboard {
    struct Entry has copy, drop, store {
        player: address,
        score: u64,
    }

    struct Leaderboard has store, key {
        id: 0x2::object::UID,
        entries: vector<Entry>,
    }

    public entry fun create(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Leaderboard{
            id      : 0x2::object::new(arg0),
            entries : 0x1::vector::empty<Entry>(),
        };
        0x2::transfer::share_object<Leaderboard>(v0);
    }

    public entry fun submit_score(arg0: &mut Leaderboard, arg1: address, arg2: u64) {
        let v0 = false;
        let v1 = &mut v0;
        let v2 = 0;
        let v3 = &mut v2;
        while (*v3 < 0x1::vector::length<Entry>(&arg0.entries)) {
            let v4 = 0x1::vector::borrow_mut<Entry>(&mut arg0.entries, *v3);
            if (v4.player == arg1) {
                if (arg2 > v4.score) {
                    v4.score = arg2;
                };
                *v1 = true;
            };
            *v3 = *v3 + 1;
        };
        if (!*v1) {
            let v5 = Entry{
                player : arg1,
                score  : arg2,
            };
            0x1::vector::push_back<Entry>(&mut arg0.entries, v5);
        };
    }

    // decompiled from Move bytecode v6
}

