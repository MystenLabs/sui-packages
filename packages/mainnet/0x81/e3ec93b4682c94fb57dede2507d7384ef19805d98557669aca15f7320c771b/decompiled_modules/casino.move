module 0x81e3ec93b4682c94fb57dede2507d7384ef19805d98557669aca15f7320c771b::casino {
    struct House has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        owner: address,
        total_bets: u64,
        total_wins: u64,
        total_volume: u64,
        total_profits_withdrawn: u64,
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
        owner: address,
        initial_balance: u64,
    }

    struct ProfitWithdrawn has copy, drop {
        house_id: 0x2::object::ID,
        owner: address,
        amount: u64,
        remaining_balance: u64,
    }

    struct HouseFunded has copy, drop {
        house_id: 0x2::object::ID,
        amount: u64,
        new_balance: u64,
    }

    public entry fun fund_house(arg0: &mut House, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v0 = HouseFunded{
            house_id    : 0x2::object::id<House>(arg0),
            amount      : 0x2::coin::value<0x2::sui::SUI>(&arg1),
            new_balance : 0x2::balance::value<0x2::sui::SUI>(&arg0.balance),
        };
        0x2::event::emit<HouseFunded>(v0);
    }

    public fun get_house_balance(arg0: &House) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public fun get_house_edge_bps() : u64 {
        600
    }

    public fun get_house_owner(arg0: &House) : address {
        arg0.owner
    }

    public fun get_min_bet() : u64 {
        1000000
    }

    public fun get_payout_multiplier() : u64 {
        200
    }

    public fun get_total_bets(arg0: &House) : u64 {
        arg0.total_bets
    }

    public fun get_total_profits_withdrawn(arg0: &House) : u64 {
        arg0.total_profits_withdrawn
    }

    public fun get_total_volume(arg0: &House) : u64 {
        arg0.total_volume
    }

    public fun get_total_wins(arg0: &House) : u64 {
        arg0.total_wins
    }

    public fun get_win_rate() : u64 {
        47
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = House{
            id                      : 0x2::object::new(arg0),
            balance                 : 0x2::balance::zero<0x2::sui::SUI>(),
            owner                   : v0,
            total_bets              : 0,
            total_wins              : 0,
            total_volume            : 0,
            total_profits_withdrawn : 0,
        };
        let v2 = HouseCreated{
            house_id        : 0x2::object::id<House>(&v1),
            owner           : v0,
            initial_balance : 0,
        };
        0x2::event::emit<HouseCreated>(v2);
        0x2::transfer::share_object<House>(v1);
    }

    public fun is_house_owner(arg0: &House, arg1: address) : bool {
        arg0.owner == arg1
    }

    public entry fun place_bet(arg0: &mut House, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v1 >= 1000000, 2);
        let v2 = v1 * 200 / 100;
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.balance) >= v2, 3);
        let v3 = 0x2::random::new_generator(arg2, arg3);
        let v4 = 0x2::random::generate_u64_in_range(&mut v3, 1, 100);
        let v5 = v4 <= 47;
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

    public entry fun withdraw_profits(arg0: &mut House, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.owner, 4);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.balance) >= arg1, 1);
        assert!(arg1 > 0, 5);
        arg0.total_profits_withdrawn = arg0.total_profits_withdrawn + arg1;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, arg1), arg2), v0);
        let v1 = ProfitWithdrawn{
            house_id          : 0x2::object::id<House>(arg0),
            owner             : v0,
            amount            : arg1,
            remaining_balance : 0x2::balance::value<0x2::sui::SUI>(&arg0.balance),
        };
        0x2::event::emit<ProfitWithdrawn>(v1);
    }

    // decompiled from Move bytecode v6
}

