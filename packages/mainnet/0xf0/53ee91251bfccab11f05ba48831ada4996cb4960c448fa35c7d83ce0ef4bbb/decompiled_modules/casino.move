module 0xf053ee91251bfccab11f05ba48831ada4996cb4960c448fa35c7d83ce0ef4bbb::casino {
    struct House has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        total_bets: u64,
        total_wins: u64,
        total_volume: u64,
    }

    struct BetPlaced has copy, drop {
        player: address,
        amount: u64,
        is_winner: bool,
        payout: u64,
        random_value: u64,
    }

    struct HouseCreated has copy, drop {
        house_id: 0x2::object::ID,
        initial_balance: u64,
    }

    public entry fun fund_house(arg0: &mut House, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::value<0x2::sui::SUI>(&arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public fun get_house_balance(arg0: &House) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public fun get_min_bet() : u64 {
        1000000
    }

    public fun get_payout_multiplier() : u64 {
        196
    }

    public fun get_total_bets(arg0: &House) : u64 {
        arg0.total_bets
    }

    public fun get_total_volume(arg0: &House) : u64 {
        arg0.total_volume
    }

    public fun get_total_wins(arg0: &House) : u64 {
        arg0.total_wins
    }

    public fun get_win_rate() : u64 {
        49
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = House{
            id           : 0x2::object::new(arg0),
            balance      : 0x2::balance::zero<0x2::sui::SUI>(),
            total_bets   : 0,
            total_wins   : 0,
            total_volume : 0,
        };
        let v1 = HouseCreated{
            house_id        : 0x2::object::id<House>(&v0),
            initial_balance : 0,
        };
        0x2::event::emit<HouseCreated>(v1);
        0x2::transfer::share_object<House>(v0);
    }

    public entry fun place_bet(arg0: &mut House, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v1 >= 1000000, 2);
        let v2 = v1 * 196 / 100;
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.balance) >= v2, 3);
        let v3 = 0x2::random::new_generator(arg2, arg3);
        let v4 = 0x2::random::generate_u64_in_range(&mut v3, 1, 100);
        let v5 = v4 <= 49;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v6 = if (v5) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, v2), arg3), v0);
            arg0.total_wins = arg0.total_wins + 1;
            v2
        } else {
            0
        };
        arg0.total_bets = arg0.total_bets + 1;
        arg0.total_volume = arg0.total_volume + v1;
        let v7 = BetPlaced{
            player       : v0,
            amount       : v1,
            is_winner    : v5,
            payout       : v6,
            random_value : v4,
        };
        0x2::event::emit<BetPlaced>(v7);
    }

    // decompiled from Move bytecode v6
}

