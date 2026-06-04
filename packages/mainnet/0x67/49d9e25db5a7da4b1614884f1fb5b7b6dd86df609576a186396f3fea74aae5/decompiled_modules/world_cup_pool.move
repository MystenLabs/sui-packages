module 0x6749d9e25db5a7da4b1614884f1fb5b7b6dd86df609576a186396f3fea74aae5::world_cup_pool {
    struct EntryRecorded has copy, drop {
        player: address,
        team: 0x1::string::String,
    }

    struct WinnerSet has copy, drop {
        champion: 0x1::string::String,
        runner_up: 0x1::string::String,
    }

    struct ClaimMade has copy, drop {
        player: address,
        amount: u64,
    }

    struct Tournament has key {
        id: 0x2::object::UID,
        admin: address,
        entries: 0x2::table::Table<address, Entry>,
        team_counts: vector<TeamCount>,
        prize_pool: 0x2::balance::Balance<0x2::sui::SUI>,
        treasury: 0x2::balance::Balance<0x2::sui::SUI>,
        champion: 0x1::option::Option<0x1::string::String>,
        runner_up: 0x1::option::Option<0x1::string::String>,
        is_open: bool,
        total_entries: u64,
        claimed: 0x2::table::Table<address, bool>,
    }

    struct Entry has copy, drop, store {
        team: 0x1::string::String,
        timestamp: u64,
    }

    struct TeamCount has copy, drop, store {
        name: 0x1::string::String,
        count: u64,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public entry fun claim(arg0: &mut Tournament, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_open, 3);
        assert!(0x1::option::is_some<0x1::string::String>(&arg0.champion), 4);
        assert!(0x2::table::contains<address, Entry>(&arg0.entries, 0x2::tx_context::sender(arg1)), 6);
        assert!(!0x2::table::contains<address, bool>(&arg0.claimed, 0x2::tx_context::sender(arg1)) || !*0x2::table::borrow<address, bool>(&arg0.claimed, 0x2::tx_context::sender(arg1)), 5);
        let v0 = 0x2::table::borrow<address, Entry>(&arg0.entries, 0x2::tx_context::sender(arg1));
        let v1 = 0x1::option::borrow<0x1::string::String>(&arg0.champion);
        let v2 = 0x1::option::borrow<0x1::string::String>(&arg0.runner_up);
        let v3 = v0.team == *v1;
        assert!(v3 || v0.team == *v2, 6);
        let v4 = if (v3) {
            *v1
        } else {
            *v2
        };
        let v5 = 0;
        let v6 = 0;
        while (v6 < 0x1::vector::length<TeamCount>(&arg0.team_counts)) {
            let v7 = 0x1::vector::borrow<TeamCount>(&arg0.team_counts, v6);
            if (v7.name == v4) {
                v5 = v7.count;
                break
            };
            v6 = v6 + 1;
        };
        let v8 = if (v3) {
            0x2::balance::value<0x2::sui::SUI>(&arg0.prize_pool) * 80 / 100 / v5
        } else {
            0x2::balance::value<0x2::sui::SUI>(&arg0.prize_pool) * 20 / 100 / v5
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.prize_pool, v8), arg1), 0x2::tx_context::sender(arg1));
        0x2::table::add<address, bool>(&mut arg0.claimed, 0x2::tx_context::sender(arg1), true);
        let v9 = ClaimMade{
            player : 0x2::tx_context::sender(arg1),
            amount : v8,
        };
        0x2::event::emit<ClaimMade>(v9);
    }

    public entry fun close_entries(arg0: &mut Tournament, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 2);
        arg0.is_open = false;
    }

    public entry fun enter(arg0: &mut Tournament, arg1: 0x1::string::String, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_open, 3);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) == 6000000000, 0);
        assert!(!0x2::table::contains<address, Entry>(&arg0.entries, 0x2::tx_context::sender(arg4)), 1);
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(arg2);
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.prize_pool, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v0, 5000000000), arg4));
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.treasury, 0x2::coin::from_balance<0x2::sui::SUI>(v0, arg4));
        let v1 = Entry{
            team      : arg1,
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::table::add<address, Entry>(&mut arg0.entries, 0x2::tx_context::sender(arg4), v1);
        let v2 = false;
        let v3 = 0;
        while (v3 < 0x1::vector::length<TeamCount>(&arg0.team_counts)) {
            let v4 = 0x1::vector::borrow_mut<TeamCount>(&mut arg0.team_counts, v3);
            if (v4.name == arg1) {
                v4.count = v4.count + 1;
                v2 = true;
                break
            };
            v3 = v3 + 1;
        };
        if (!v2) {
            let v5 = TeamCount{
                name  : arg1,
                count : 1,
            };
            0x1::vector::push_back<TeamCount>(&mut arg0.team_counts, v5);
        };
        arg0.total_entries = arg0.total_entries + 1;
        let v6 = EntryRecorded{
            player : 0x2::tx_context::sender(arg4),
            team   : arg1,
        };
        0x2::event::emit<EntryRecorded>(v6);
    }

    public fun get_entry(arg0: &Tournament, arg1: address) : 0x1::option::Option<Entry> {
        if (0x2::table::contains<address, Entry>(&arg0.entries, arg1)) {
            0x1::option::some<Entry>(*0x2::table::borrow<address, Entry>(&arg0.entries, arg1))
        } else {
            0x1::option::none<Entry>()
        }
    }

    public fun get_prize_pool(arg0: &Tournament) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.prize_pool)
    }

    public fun get_team_count(arg0: &Tournament, arg1: 0x1::string::String) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<TeamCount>(&arg0.team_counts)) {
            let v1 = 0x1::vector::borrow<TeamCount>(&arg0.team_counts, v0);
            if (v1.name == arg1) {
                return v1.count
            };
            v0 = v0 + 1;
        };
        0
    }

    public fun get_total_entries(arg0: &Tournament) : u64 {
        arg0.total_entries
    }

    public fun get_treasury(arg0: &Tournament) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.treasury)
    }

    public fun get_winner(arg0: &Tournament) : (0x1::option::Option<0x1::string::String>, 0x1::option::Option<0x1::string::String>) {
        (arg0.champion, arg0.runner_up)
    }

    public fun has_claimed(arg0: &Tournament, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.claimed, arg1) && *0x2::table::borrow<address, bool>(&arg0.claimed, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Tournament{
            id            : 0x2::object::new(arg0),
            admin         : 0x2::tx_context::sender(arg0),
            entries       : 0x2::table::new<address, Entry>(arg0),
            team_counts   : 0x1::vector::empty<TeamCount>(),
            prize_pool    : 0x2::balance::zero<0x2::sui::SUI>(),
            treasury      : 0x2::balance::zero<0x2::sui::SUI>(),
            champion      : 0x1::option::none<0x1::string::String>(),
            runner_up     : 0x1::option::none<0x1::string::String>(),
            is_open       : true,
            total_entries : 0,
            claimed       : 0x2::table::new<address, bool>(arg0),
        };
        0x2::transfer::share_object<Tournament>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_open(arg0: &Tournament) : bool {
        arg0.is_open
    }

    public entry fun set_winner(arg0: &mut Tournament, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &AdminCap, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg4), 2);
        arg0.champion = 0x1::option::some<0x1::string::String>(arg1);
        arg0.runner_up = 0x1::option::some<0x1::string::String>(arg2);
        arg0.is_open = false;
        let v0 = WinnerSet{
            champion  : arg1,
            runner_up : arg2,
        };
        0x2::event::emit<WinnerSet>(v0);
    }

    public entry fun withdraw_treasury(arg0: &mut Tournament, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.treasury, 0x2::balance::value<0x2::sui::SUI>(&arg0.treasury)), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v7
}

