module 0x8fd57ed906845a7f3796aa0378b0da74c246a48c6f45a5e4f23d23b9eb3735b7::world_cup_pool {
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
        players: vector<address>,
        champion_payout: u64,
        runnerup_payout: u64,
        valid_teams: vector<0x1::string::String>,
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
        let v1 = v0.team == *0x1::option::borrow<0x1::string::String>(&arg0.champion);
        assert!(v1 || v0.team == *0x1::option::borrow<0x1::string::String>(&arg0.runner_up), 6);
        let v2 = if (v1) {
            arg0.champion_payout
        } else {
            arg0.runnerup_payout
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.prize_pool, v2), arg1), 0x2::tx_context::sender(arg1));
        0x2::table::add<address, bool>(&mut arg0.claimed, 0x2::tx_context::sender(arg1), true);
        let v3 = ClaimMade{
            player : 0x2::tx_context::sender(arg1),
            amount : v2,
        };
        0x2::event::emit<ClaimMade>(v3);
    }

    public entry fun close_entries(arg0: &mut Tournament, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 2);
        arg0.is_open = false;
    }

    public entry fun distribute_champion_payouts(arg0: &mut Tournament, arg1: vector<address>, arg2: &AdminCap, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg3), 2);
        assert!(!arg0.is_open, 3);
        assert!(0x1::option::is_some<0x1::string::String>(&arg0.champion), 4);
        let v0 = 0x1::option::borrow<0x1::string::String>(&arg0.champion);
        let v1 = arg0.champion_payout;
        if (v1 == 0) {
            return
        };
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&arg1)) {
            let v3 = *0x1::vector::borrow<address>(&arg1, v2);
            if (0x2::table::contains<address, Entry>(&arg0.entries, v3) && !0x2::table::contains<address, bool>(&arg0.claimed, v3)) {
                if (0x2::table::borrow<address, Entry>(&arg0.entries, v3).team == *v0) {
                    0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.prize_pool, v1), arg3), v3);
                    0x2::table::add<address, bool>(&mut arg0.claimed, v3, true);
                    let v4 = ClaimMade{
                        player : v3,
                        amount : v1,
                    };
                    0x2::event::emit<ClaimMade>(v4);
                };
            };
            v2 = v2 + 1;
        };
    }

    public entry fun distribute_runnerup_payouts(arg0: &mut Tournament, arg1: vector<address>, arg2: &AdminCap, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg3), 2);
        assert!(!arg0.is_open, 3);
        assert!(0x1::option::is_some<0x1::string::String>(&arg0.runner_up), 4);
        let v0 = 0x1::option::borrow<0x1::string::String>(&arg0.runner_up);
        let v1 = arg0.runnerup_payout;
        if (v1 == 0) {
            return
        };
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&arg1)) {
            let v3 = *0x1::vector::borrow<address>(&arg1, v2);
            if (0x2::table::contains<address, Entry>(&arg0.entries, v3) && !0x2::table::contains<address, bool>(&arg0.claimed, v3)) {
                if (0x2::table::borrow<address, Entry>(&arg0.entries, v3).team == *v0) {
                    0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.prize_pool, v1), arg3), v3);
                    0x2::table::add<address, bool>(&mut arg0.claimed, v3, true);
                    let v4 = ClaimMade{
                        player : v3,
                        amount : v1,
                    };
                    0x2::event::emit<ClaimMade>(v4);
                };
            };
            v2 = v2 + 1;
        };
    }

    public entry fun enter(arg0: &mut Tournament, arg1: 0x1::string::String, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_open, 3);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) == 6000000000, 0);
        assert!(!0x2::table::contains<address, Entry>(&arg0.entries, 0x2::tx_context::sender(arg4)), 1);
        assert!(is_valid_team(arg0, &arg1), 7);
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(arg2);
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.prize_pool, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v0, 5000000000), arg4));
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.treasury, 0x2::coin::from_balance<0x2::sui::SUI>(v0, arg4));
        let v1 = Entry{
            team      : arg1,
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::table::add<address, Entry>(&mut arg0.entries, 0x2::tx_context::sender(arg4), v1);
        0x1::vector::push_back<address>(&mut arg0.players, 0x2::tx_context::sender(arg4));
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

    public fun get_champion_payout(arg0: &Tournament) : u64 {
        arg0.champion_payout
    }

    public fun get_entry(arg0: &Tournament, arg1: address) : 0x1::option::Option<Entry> {
        if (0x2::table::contains<address, Entry>(&arg0.entries, arg1)) {
            0x1::option::some<Entry>(*0x2::table::borrow<address, Entry>(&arg0.entries, arg1))
        } else {
            0x1::option::none<Entry>()
        }
    }

    public fun get_players(arg0: &Tournament) : vector<address> {
        arg0.players
    }

    public fun get_prize_pool(arg0: &Tournament) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.prize_pool)
    }

    public fun get_runnerup_payout(arg0: &Tournament) : u64 {
        arg0.runnerup_payout
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
            id              : 0x2::object::new(arg0),
            admin           : 0x2::tx_context::sender(arg0),
            entries         : 0x2::table::new<address, Entry>(arg0),
            team_counts     : 0x1::vector::empty<TeamCount>(),
            prize_pool      : 0x2::balance::zero<0x2::sui::SUI>(),
            treasury        : 0x2::balance::zero<0x2::sui::SUI>(),
            champion        : 0x1::option::none<0x1::string::String>(),
            runner_up       : 0x1::option::none<0x1::string::String>(),
            is_open         : true,
            total_entries   : 0,
            claimed         : 0x2::table::new<address, bool>(arg0),
            players         : 0x1::vector::empty<address>(),
            champion_payout : 0,
            runnerup_payout : 0,
            valid_teams     : 0x1::vector::empty<0x1::string::String>(),
        };
        0x2::transfer::share_object<Tournament>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_open(arg0: &Tournament) : bool {
        arg0.is_open
    }

    fun is_valid_team(arg0: &Tournament, arg1: &0x1::string::String) : bool {
        let v0 = 0x1::vector::length<0x1::string::String>(&arg0.valid_teams);
        if (v0 == 0) {
            return false
        };
        let v1 = 0;
        while (v1 < v0) {
            if (0x1::vector::borrow<0x1::string::String>(&arg0.valid_teams, v1) == arg1) {
                return true
            };
            v1 = v1 + 1;
        };
        false
    }

    public entry fun set_valid_teams(arg0: &mut Tournament, arg1: vector<0x1::string::String>, arg2: &AdminCap, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg3), 2);
        arg0.valid_teams = arg1;
    }

    public entry fun set_winner(arg0: &mut Tournament, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &AdminCap, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg4), 2);
        arg0.champion = 0x1::option::some<0x1::string::String>(arg1);
        arg0.runner_up = 0x1::option::some<0x1::string::String>(arg2);
        arg0.is_open = false;
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.prize_pool);
        let v1 = get_team_count(arg0, arg1);
        let v2 = get_team_count(arg0, arg2);
        if (v1 > 0) {
            arg0.champion_payout = v0 * 80 / 100 / v1;
        } else {
            arg0.champion_payout = 0;
        };
        if (v2 > 0) {
            arg0.runnerup_payout = v0 * 20 / 100 / v2;
        } else {
            arg0.runnerup_payout = 0;
        };
        let v3 = WinnerSet{
            champion  : arg1,
            runner_up : arg2,
        };
        0x2::event::emit<WinnerSet>(v3);
    }

    public entry fun sweep_dust(arg0: &mut Tournament, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 2);
        assert!(!arg0.is_open, 3);
        assert!(0x1::option::is_some<0x1::string::String>(&arg0.champion), 4);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.prize_pool);
        assert!(v0 > 0, 8);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.prize_pool, v0), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun withdraw_treasury(arg0: &mut Tournament, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.treasury, 0x2::balance::value<0x2::sui::SUI>(&arg0.treasury)), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

