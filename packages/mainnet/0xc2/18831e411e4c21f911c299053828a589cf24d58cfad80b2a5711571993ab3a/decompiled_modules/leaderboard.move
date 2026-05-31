module 0xc218831e411e4c21f911c299053828a589cf24d58cfad80b2a5711571993ab3a::leaderboard {
    struct GameWitness has drop {
        dummy_field: bool,
    }

    struct ScoreEntry has copy, drop, store {
        wallet: address,
        points: u64,
        nft_count: u64,
        last_mint: u64,
    }

    struct MonthlyBoard has store {
        year_month: u64,
        entries: vector<ScoreEntry>,
    }

    struct Leaderboard has key {
        id: 0x2::object::UID,
        monthly: vector<MonthlyBoard>,
        all_time: vector<ScoreEntry>,
    }

    struct ScoreAdded has copy, drop {
        wallet: address,
        points: u64,
        year_month: u64,
    }

    public fun add_score(arg0: &mut Leaderboard, arg1: GameWitness, arg2: address, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = timestamp_to_year_month(v0);
        let v2 = &mut arg0.monthly;
        let v3 = &mut 0x1::vector::borrow_mut<MonthlyBoard>(&mut arg0.monthly, find_or_create_month(v2, v1)).entries;
        upsert_entry(v3, arg2, arg3, v0);
        let v4 = &mut arg0.all_time;
        upsert_entry(v4, arg2, arg3, v0);
        let v5 = ScoreAdded{
            wallet     : arg2,
            points     : arg3,
            year_month : v1,
        };
        0x2::event::emit<ScoreAdded>(v5);
    }

    public entry fun create_and_share(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Leaderboard{
            id       : 0x2::object::new(arg0),
            monthly  : 0x1::vector::empty<MonthlyBoard>(),
            all_time : 0x1::vector::empty<ScoreEntry>(),
        };
        0x2::transfer::share_object<Leaderboard>(v0);
    }

    public fun entry_last_mint(arg0: &ScoreEntry) : u64 {
        arg0.last_mint
    }

    public fun entry_nft_count(arg0: &ScoreEntry) : u64 {
        arg0.nft_count
    }

    public fun entry_points(arg0: &ScoreEntry) : u64 {
        arg0.points
    }

    public fun entry_wallet(arg0: &ScoreEntry) : address {
        arg0.wallet
    }

    fun find_or_create_month(arg0: &mut vector<MonthlyBoard>, arg1: u64) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<MonthlyBoard>(arg0)) {
            if (0x1::vector::borrow<MonthlyBoard>(arg0, v0).year_month == arg1) {
                return v0
            };
            v0 = v0 + 1;
        };
        let v1 = MonthlyBoard{
            year_month : arg1,
            entries    : 0x1::vector::empty<ScoreEntry>(),
        };
        0x1::vector::push_back<MonthlyBoard>(arg0, v1);
        0x1::vector::length<MonthlyBoard>(arg0) - 1
    }

    public fun get_all_time_scores(arg0: &Leaderboard) : vector<ScoreEntry> {
        sorted_copy(&arg0.all_time)
    }

    public fun get_monthly_rank(arg0: &Leaderboard, arg1: address, arg2: u64) : u64 {
        let v0 = get_monthly_scores(arg0, arg2);
        let v1 = 0;
        while (v1 < 0x1::vector::length<ScoreEntry>(&v0)) {
            if (0x1::vector::borrow<ScoreEntry>(&v0, v1).wallet == arg1) {
                return v1 + 1
            };
            v1 = v1 + 1;
        };
        0
    }

    public fun get_monthly_scores(arg0: &Leaderboard, arg1: u64) : vector<ScoreEntry> {
        let v0 = 0;
        while (v0 < 0x1::vector::length<MonthlyBoard>(&arg0.monthly)) {
            let v1 = 0x1::vector::borrow<MonthlyBoard>(&arg0.monthly, v0);
            if (v1.year_month == arg1) {
                return sorted_copy(&v1.entries)
            };
            v0 = v0 + 1;
        };
        0x1::vector::empty<ScoreEntry>()
    }

    public(friend) fun new_game_witness() : GameWitness {
        GameWitness{dummy_field: false}
    }

    fun should_swap(arg0: &ScoreEntry, arg1: &ScoreEntry) : bool {
        if (arg0.points != arg1.points) {
            return arg0.points < arg1.points
        };
        if (arg0.nft_count != arg1.nft_count) {
            return arg0.nft_count < arg1.nft_count
        };
        arg0.last_mint > arg1.last_mint
    }

    fun sorted_copy(arg0: &vector<ScoreEntry>) : vector<ScoreEntry> {
        let v0 = *arg0;
        let v1 = 0x1::vector::length<ScoreEntry>(&v0);
        if (v1 <= 1) {
            return v0
        };
        let v2 = 1;
        while (v2 < v1) {
            while (v2 > 0) {
                let v3 = *0x1::vector::borrow<ScoreEntry>(&v0, v2 - 1);
                let v4 = *0x1::vector::borrow<ScoreEntry>(&v0, v2);
                if (should_swap(&v3, &v4)) {
                    0x1::vector::swap<ScoreEntry>(&mut v0, v2 - 1, v2);
                    v2 = v2 - 1;
                } else {
                    break
                };
            };
            v2 = v2 + 1;
        };
        v0
    }

    fun timestamp_to_year_month(arg0: u64) : u64 {
        let v0 = arg0 / 86400000;
        let v1 = v0 % 365 * 12 / 365 + 1;
        let v2 = v1;
        if (v1 > 12) {
            v2 = 12;
        };
        (1970 + v0 / 365) * 100 + v2
    }

    fun upsert_entry(arg0: &mut vector<ScoreEntry>, arg1: address, arg2: u64, arg3: u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<ScoreEntry>(arg0)) {
            let v1 = 0x1::vector::borrow_mut<ScoreEntry>(arg0, v0);
            if (v1.wallet == arg1) {
                v1.points = v1.points + arg2;
                v1.nft_count = v1.nft_count + 1;
                v1.last_mint = arg3;
                return
            };
            v0 = v0 + 1;
        };
        let v2 = ScoreEntry{
            wallet    : arg1,
            points    : arg2,
            nft_count : 1,
            last_mint : arg3,
        };
        0x1::vector::push_back<ScoreEntry>(arg0, v2);
    }

    // decompiled from Move bytecode v7
}

