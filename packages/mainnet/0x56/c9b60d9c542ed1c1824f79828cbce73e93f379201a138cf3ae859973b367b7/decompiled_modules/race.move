module 0x56c9b60d9c542ed1c1824f79828cbce73e93f379201a138cf3ae859973b367b7::race {
    struct RaceRoom has store, key {
        id: 0x2::object::UID,
        creator: address,
        entry_fee: u64,
        max_players: u64,
        state: u8,
        players: vector<address>,
        escrow: 0x2::balance::Balance<0x2::sui::SUI>,
        winner: 0x1::option::Option<address>,
        nft_slot: 0x1::option::Option<0x2::object::ID>,
    }

    struct RaceCreated has copy, drop {
        race_id: 0x2::object::ID,
        creator: address,
        entry_fee: u64,
        max_players: u64,
    }

    struct PlayerJoined has copy, drop {
        race_id: 0x2::object::ID,
        player: address,
        player_count: u64,
        pot_amount: u64,
    }

    struct RaceStarted has copy, drop {
        race_id: 0x2::object::ID,
        player_count: u64,
        pot_amount: u64,
    }

    struct RaceFinished has copy, drop {
        race_id: 0x2::object::ID,
        winner: address,
        pot_amount: u64,
        platform_fee: u64,
        winner_payout: u64,
    }

    struct PayoutClaimed has copy, drop {
        race_id: 0x2::object::ID,
        winner: address,
        amount: u64,
    }

    public fun create_race(arg0: &0x56c9b60d9c542ed1c1824f79828cbce73e93f379201a138cf3ae859973b367b7::config::PlatformConfig, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 9);
        assert!(arg2 >= 2 && arg2 <= 4, 8);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = RaceRoom{
            id          : 0x2::object::new(arg3),
            creator     : v0,
            entry_fee   : arg1,
            max_players : arg2,
            state       : 0,
            players     : vector[],
            escrow      : 0x2::balance::zero<0x2::sui::SUI>(),
            winner      : 0x1::option::none<address>(),
            nft_slot    : 0x1::option::none<0x2::object::ID>(),
        };
        let v2 = RaceCreated{
            race_id     : 0x2::object::id<RaceRoom>(&v1),
            creator     : v0,
            entry_fee   : arg1,
            max_players : arg2,
        };
        0x2::event::emit<RaceCreated>(v2);
        0x2::transfer::share_object<RaceRoom>(v1);
        0x56c9b60d9c542ed1c1824f79828cbce73e93f379201a138cf3ae859973b367b7::config::operator(arg0);
    }

    public fun creator(arg0: &RaceRoom) : address {
        arg0.creator
    }

    public fun entry_fee(arg0: &RaceRoom) : u64 {
        arg0.entry_fee
    }

    public fun finish_race(arg0: &0x56c9b60d9c542ed1c1824f79828cbce73e93f379201a138cf3ae859973b367b7::config::PlatformConfig, arg1: &mut RaceRoom, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.state == 1, 3);
        assert!(0x1::vector::contains<address>(&arg1.players, &arg2), 7);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg1.creator || v0 == 0x56c9b60d9c542ed1c1824f79828cbce73e93f379201a138cf3ae859973b367b7::config::operator(arg0), 2);
        arg1.state = 2;
        arg1.winner = 0x1::option::some<address>(arg2);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&arg1.escrow);
        let v2 = v1 * 0x56c9b60d9c542ed1c1824f79828cbce73e93f379201a138cf3ae859973b367b7::config::platform_fee_bps(arg0) / 0x56c9b60d9c542ed1c1824f79828cbce73e93f379201a138cf3ae859973b367b7::config::bps_denominator();
        let v3 = v1 - v2;
        let v4 = RaceFinished{
            race_id       : 0x2::object::id<RaceRoom>(arg1),
            winner        : arg2,
            pot_amount    : v1,
            platform_fee  : v2,
            winner_payout : v3,
        };
        0x2::event::emit<RaceFinished>(v4);
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.escrow, v2, arg3), 0x56c9b60d9c542ed1c1824f79828cbce73e93f379201a138cf3ae859973b367b7::config::treasury(arg0));
        };
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.escrow, v3), arg3), arg2);
            let v5 = PayoutClaimed{
                race_id : 0x2::object::id<RaceRoom>(arg1),
                winner  : arg2,
                amount  : v3,
            };
            0x2::event::emit<PayoutClaimed>(v5);
        };
    }

    public fun join_race(arg0: &mut RaceRoom, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.state == 0, 3);
        assert!(0x1::vector::length<address>(&arg0.players) < arg0.max_players, 4);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(!0x1::vector::contains<address>(&arg0.players, &v0), 5);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v1 >= arg0.entry_fee, 10);
        if (v1 > arg0.entry_fee) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.escrow, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, arg0.entry_fee, arg2)));
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, v0);
        } else {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.escrow, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        };
        0x1::vector::push_back<address>(&mut arg0.players, v0);
        let v2 = PlayerJoined{
            race_id      : 0x2::object::id<RaceRoom>(arg0),
            player       : v0,
            player_count : 0x1::vector::length<address>(&arg0.players),
            pot_amount   : 0x2::balance::value<0x2::sui::SUI>(&arg0.escrow),
        };
        0x2::event::emit<PlayerJoined>(v2);
    }

    public fun max_players(arg0: &RaceRoom) : u64 {
        arg0.max_players
    }

    public fun players(arg0: &RaceRoom) : vector<address> {
        arg0.players
    }

    public fun pot_amount(arg0: &RaceRoom) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.escrow)
    }

    public fun set_nft_slot(arg0: &mut RaceRoom, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 1);
        arg0.nft_slot = 0x1::option::some<0x2::object::ID>(arg1);
    }

    public fun start_race(arg0: &0x56c9b60d9c542ed1c1824f79828cbce73e93f379201a138cf3ae859973b367b7::config::PlatformConfig, arg1: &mut RaceRoom, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.state == 0, 3);
        assert!(0x1::vector::length<address>(&arg1.players) >= 2, 6);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg1.creator || v0 == 0x56c9b60d9c542ed1c1824f79828cbce73e93f379201a138cf3ae859973b367b7::config::operator(arg0), 2);
        arg1.state = 1;
        let v1 = RaceStarted{
            race_id      : 0x2::object::id<RaceRoom>(arg1),
            player_count : 0x1::vector::length<address>(&arg1.players),
            pot_amount   : 0x2::balance::value<0x2::sui::SUI>(&arg1.escrow),
        };
        0x2::event::emit<RaceStarted>(v1);
    }

    public fun state(arg0: &RaceRoom) : u8 {
        arg0.state
    }

    public fun state_finished() : u8 {
        2
    }

    public fun state_in_progress() : u8 {
        1
    }

    public fun state_waiting() : u8 {
        0
    }

    public fun winner(arg0: &RaceRoom) : 0x1::option::Option<address> {
        arg0.winner
    }

    // decompiled from Move bytecode v7
}

