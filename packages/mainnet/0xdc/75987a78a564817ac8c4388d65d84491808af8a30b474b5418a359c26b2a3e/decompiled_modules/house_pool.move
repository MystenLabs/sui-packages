module 0xdc75987a78a564817ac8c4388d65d84491808af8a30b474b5418a359c26b2a3e::house_pool {
    struct HousePool has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        owner: address,
        paused: bool,
        total_wagered: u64,
        total_paid_out: u64,
        total_games: u64,
        max_bet_percentage: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct HousePoolCreated has copy, drop {
        pool_id: 0x2::object::ID,
        initial_balance: u64,
        owner: address,
    }

    struct BetProcessed has copy, drop {
        pool_id: 0x2::object::ID,
        player: address,
        bet_amount: u64,
        payout: u64,
        won: bool,
        game_type: vector<u8>,
    }

    public entry fun add_funds(arg0: &mut HousePool, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &AdminCap) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public entry fun create_house_pool(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = HousePool{
            id                 : 0x2::object::new(arg2),
            balance            : 0x2::coin::into_balance<0x2::sui::SUI>(arg0),
            owner              : v0,
            paused             : false,
            total_wagered      : 0,
            total_paid_out     : 0,
            total_games        : 0,
            max_bet_percentage : 100,
        };
        let v2 = HousePoolCreated{
            pool_id         : 0x2::object::id<HousePool>(&v1),
            initial_balance : 0x2::coin::value<0x2::sui::SUI>(&arg0),
            owner           : v0,
        };
        0x2::event::emit<HousePoolCreated>(v2);
        0x2::transfer::share_object<HousePool>(v1);
    }

    public fun get_balance(arg0: &HousePool) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public fun get_max_bet(arg0: &HousePool) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance) * arg0.max_bet_percentage / 10000
    }

    public fun get_stats(arg0: &HousePool) : (u64, u64, u64) {
        (arg0.total_wagered, arg0.total_paid_out, arg0.total_games)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun process_bet(arg0: &mut HousePool, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: bool, arg3: u64, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(!arg0.paused, 3);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 <= get_max_bet(arg0), 1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        arg0.total_wagered = arg0.total_wagered + v0;
        arg0.total_games = arg0.total_games + 1;
        let v1 = if (arg2) {
            assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.balance) >= arg3, 0);
            arg0.total_paid_out = arg0.total_paid_out + arg3;
            0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, arg3), arg5)
        } else {
            0x2::coin::zero<0x2::sui::SUI>(arg5)
        };
        let v2 = BetProcessed{
            pool_id    : 0x2::object::id<HousePool>(arg0),
            player     : 0x2::tx_context::sender(arg5),
            bet_amount : v0,
            payout     : arg3,
            won        : arg2,
            game_type  : arg4,
        };
        0x2::event::emit<BetProcessed>(v2);
        v1
    }

    public entry fun set_max_bet_percentage(arg0: &mut HousePool, arg1: &AdminCap, arg2: u64) {
        arg0.max_bet_percentage = arg2;
    }

    public entry fun set_paused(arg0: &mut HousePool, arg1: &AdminCap, arg2: bool) {
        arg0.paused = arg2;
    }

    public entry fun withdraw_funds(arg0: &mut HousePool, arg1: &AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

