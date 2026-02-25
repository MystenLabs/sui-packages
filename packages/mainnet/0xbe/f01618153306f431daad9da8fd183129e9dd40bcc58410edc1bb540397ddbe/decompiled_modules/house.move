module 0xbef01618153306f431daad9da8fd183129e9dd40bcc58410edc1bb540397ddbe::house {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Treasury has key {
        id: 0x2::object::UID,
        balance: 0x2::coin::Coin<0x2::sui::SUI>,
        total_rake_collected: u64,
        total_tournaments_funded: u64,
        total_airdrops: u64,
        leaderboard: 0x2::table::Table<address, PlayerStats>,
    }

    struct PlayerStats has drop, store {
        wins: u64,
        losses: u64,
        total_wagered: u64,
        total_won: u64,
    }

    struct RakeDeposited has copy, drop {
        amount: u64,
        from_battle: address,
        treasury_total: u64,
    }

    struct TournamentFunded has copy, drop {
        amount: u64,
        tournament_id: address,
    }

    struct AirdropClaimed has copy, drop {
        recipient: address,
        amount: u64,
    }

    public entry fun airdrop_daily_pot(arg0: &AdminCap, arg1: &mut Treasury, arg2: vector<address>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg2);
        let v1 = arg3 * v0;
        assert!(v1 > 0, 2);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1.balance) >= v1, 1);
        let v2 = 0;
        while (v2 < v0) {
            let v3 = *0x1::vector::borrow<address>(&arg2, v2);
            arg1.total_airdrops = arg1.total_airdrops + arg3;
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1.balance, arg3, arg4), v3);
            let v4 = AirdropClaimed{
                recipient : v3,
                amount    : arg3,
            };
            0x2::event::emit<AirdropClaimed>(v4);
            v2 = v2 + 1;
        };
    }

    public entry fun deposit_rake(arg0: &mut Treasury, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: address) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 > 0, 2);
        arg0.total_rake_collected = arg0.total_rake_collected + v0;
        0x2::coin::join<0x2::sui::SUI>(&mut arg0.balance, arg1);
        let v1 = RakeDeposited{
            amount         : v0,
            from_battle    : arg2,
            treasury_total : 0x2::coin::value<0x2::sui::SUI>(&arg0.balance),
        };
        0x2::event::emit<RakeDeposited>(v1);
    }

    public entry fun fund_tournament(arg0: &AdminCap, arg1: &mut Treasury, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 2);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1.balance) >= arg2, 1);
        arg1.total_tournaments_funded = arg1.total_tournaments_funded + arg2;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1.balance, arg2, arg4), arg3);
        let v0 = TournamentFunded{
            amount        : arg2,
            tournament_id : arg3,
        };
        0x2::event::emit<TournamentFunded>(v0);
    }

    public fun get_balance(arg0: &Treasury) : u64 {
        0x2::coin::value<0x2::sui::SUI>(&arg0.balance)
    }

    public fun get_player_wins(arg0: &Treasury, arg1: address) : u64 {
        if (0x2::table::contains<address, PlayerStats>(&arg0.leaderboard, arg1)) {
            0x2::table::borrow<address, PlayerStats>(&arg0.leaderboard, arg1).wins
        } else {
            0
        }
    }

    public fun get_total_rake(arg0: &Treasury) : u64 {
        arg0.total_rake_collected
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Treasury{
            id                       : 0x2::object::new(arg0),
            balance                  : 0x2::coin::zero<0x2::sui::SUI>(arg0),
            total_rake_collected     : 0,
            total_tournaments_funded : 0,
            total_airdrops           : 0,
            leaderboard              : 0x2::table::new<address, PlayerStats>(arg0),
        };
        0x2::transfer::share_object<Treasury>(v1);
    }

    public(friend) fun update_leaderboard(arg0: &mut Treasury, arg1: address, arg2: bool, arg3: u64, arg4: u64) {
        if (!0x2::table::contains<address, PlayerStats>(&arg0.leaderboard, arg1)) {
            let v0 = PlayerStats{
                wins          : 0,
                losses        : 0,
                total_wagered : 0,
                total_won     : 0,
            };
            0x2::table::add<address, PlayerStats>(&mut arg0.leaderboard, arg1, v0);
        };
        let v1 = 0x2::table::borrow_mut<address, PlayerStats>(&mut arg0.leaderboard, arg1);
        if (arg2) {
            v1.wins = v1.wins + 1;
            v1.total_won = v1.total_won + arg4;
        } else {
            v1.losses = v1.losses + 1;
        };
        v1.total_wagered = v1.total_wagered + arg3;
    }

    // decompiled from Move bytecode v6
}

