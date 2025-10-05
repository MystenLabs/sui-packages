module 0xce7ba0f6412514a10b8dda147963306e18d54268847dc975c385d6fa3c48c7fe::wheel_of_fortune {
    struct Game has key {
        id: 0x2::object::UID,
        house_vault: 0x2::balance::Balance<0x2::sui::SUI>,
        buyback_wallet: address,
        burn_wallet: address,
        total_spins: u64,
        total_wagered: u64,
        total_paid_out: u64,
        active: bool,
        admin: address,
    }

    struct Outcome has copy, drop, store {
        multiplier_bp: u64,
        weight: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct SpinResult has copy, drop {
        player: address,
        bet_amount: u64,
        multiplier_bp: u64,
        payout: u64,
        is_win: bool,
        timestamp_ms: u64,
    }

    struct HouseFunded has copy, drop {
        amount: u64,
        new_balance: u64,
    }

    struct HouseWithdrawal has copy, drop {
        amount: u64,
        remaining_balance: u64,
    }

    struct GamePausedEvent has copy, drop {
        paused: bool,
    }

    fun calculate_total_weight(arg0: &vector<Outcome>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<Outcome>(arg0)) {
            v0 = v0 + 0x1::vector::borrow<Outcome>(arg0, v1).weight;
            v1 = v1 + 1;
        };
        v0
    }

    entry fun fund_house(arg0: &mut Game, arg1: &AdminCap, arg2: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.house_vault, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        let v0 = HouseFunded{
            amount      : 0x2::coin::value<0x2::sui::SUI>(&arg2),
            new_balance : 0x2::balance::value<0x2::sui::SUI>(&arg0.house_vault),
        };
        0x2::event::emit<HouseFunded>(v0);
    }

    public fun get_game_stats(arg0: &Game) : (u64, u64, u64, bool) {
        (arg0.total_spins, arg0.total_wagered, arg0.total_paid_out, arg0.active)
    }

    public fun get_house_balance(arg0: &Game) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.house_vault)
    }

    public fun get_max_payout() : u64 {
        1000000000 * 50000 / 10000
    }

    fun get_outcomes() : vector<Outcome> {
        let v0 = 0x1::vector::empty<Outcome>();
        let v1 = Outcome{
            multiplier_bp : 0,
            weight        : 60,
        };
        0x1::vector::push_back<Outcome>(&mut v0, v1);
        let v2 = Outcome{
            multiplier_bp : 15000,
            weight        : 16,
        };
        0x1::vector::push_back<Outcome>(&mut v0, v2);
        let v3 = Outcome{
            multiplier_bp : 20000,
            weight        : 12,
        };
        0x1::vector::push_back<Outcome>(&mut v0, v3);
        let v4 = Outcome{
            multiplier_bp : 30000,
            weight        : 8,
        };
        0x1::vector::push_back<Outcome>(&mut v0, v4);
        let v5 = Outcome{
            multiplier_bp : 50000,
            weight        : 4,
        };
        0x1::vector::push_back<Outcome>(&mut v0, v5);
        v0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Game{
            id             : 0x2::object::new(arg0),
            house_vault    : 0x2::balance::zero<0x2::sui::SUI>(),
            buyback_wallet : @0x666b2eabb0917a2bfb067cc17dcc87ff8e17e7e54acd4ce48a08767ecedd0150,
            burn_wallet    : @0x0,
            total_spins    : 0,
            total_wagered  : 0,
            total_paid_out : 0,
            active         : true,
            admin          : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<Game>(v1);
    }

    fun route_loss_funds(arg0: &Game, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        let v1 = v0 * 9000 / 10000;
        let v2 = v0 - v1;
        let v3 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v3, v1), arg2), arg0.buyback_wallet);
        };
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v3, v2), arg2), arg0.burn_wallet);
        };
        0x2::balance::destroy_zero<0x2::sui::SUI>(v3);
    }

    fun select_outcome(arg0: &vector<Outcome>, arg1: u64, arg2: u64) : Outcome {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<Outcome>(arg0)) {
            let v2 = 0x1::vector::borrow<Outcome>(arg0, v1);
            v0 = v0 + v2.weight;
            if (arg1 % arg2 < v0) {
                return *v2
            };
            v1 = v1 + 1;
        };
        *0x1::vector::borrow<Outcome>(arg0, 0)
    }

    entry fun set_game_active(arg0: &mut Game, arg1: &AdminCap, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 4);
        arg0.active = arg2;
        let v0 = GamePausedEvent{paused: !arg2};
        0x2::event::emit<GamePausedEvent>(v0);
    }

    public entry fun spin(arg0: &mut Game, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.active, 3);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 == 1000000000, 1);
        let v1 = get_outcomes();
        let v2 = 0x2::random::new_generator(arg2, arg3);
        let v3 = select_outcome(&v1, 0x2::random::generate_u64(&mut v2), calculate_total_weight(&v1));
        let v4 = if (v3.multiplier_bp == 0) {
            route_loss_funds(arg0, arg1, arg3);
            0
        } else {
            let v5 = v0 * v3.multiplier_bp / 10000;
            assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.house_vault) >= v5, 2);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.house_vault, v5), arg3), 0x2::tx_context::sender(arg3));
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.house_vault, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
            arg0.total_paid_out = arg0.total_paid_out + v5;
            v5
        };
        arg0.total_spins = arg0.total_spins + 1;
        arg0.total_wagered = arg0.total_wagered + v0;
        let v6 = SpinResult{
            player        : 0x2::tx_context::sender(arg3),
            bet_amount    : v0,
            multiplier_bp : v3.multiplier_bp,
            payout        : v4,
            is_win        : v3.multiplier_bp > 0,
            timestamp_ms  : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<SpinResult>(v6);
    }

    entry fun update_burn_wallet(arg0: &mut Game, arg1: &AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 4);
        arg0.burn_wallet = arg2;
    }

    entry fun update_buyback_wallet(arg0: &mut Game, arg1: &AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 4);
        arg0.buyback_wallet = arg2;
    }

    entry fun withdraw_house_funds(arg0: &mut Game, arg1: &AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.house_vault, arg2), arg3), arg0.admin);
        let v0 = HouseWithdrawal{
            amount            : arg2,
            remaining_balance : 0x2::balance::value<0x2::sui::SUI>(&arg0.house_vault),
        };
        0x2::event::emit<HouseWithdrawal>(v0);
    }

    // decompiled from Move bytecode v6
}

