module 0xb3a802e8758326b951c5e6319bc2288c8b57227ae7483b05b86734c73b80f6c7::wheel_of_fortune {
    struct Game<phantom T0> has key {
        id: 0x2::object::UID,
        house_vault: 0x2::balance::Balance<T0>,
        player_winnings: 0x2::table::Table<address, u64>,
        player_tickets: 0x2::table::Table<address, u64>,
        buyback_wallet: address,
        airdrop_wallet: address,
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

    struct WinningsWithdrawn has copy, drop {
        player: address,
        amount: u64,
    }

    struct TicketsEarned has copy, drop {
        player: address,
        tickets: u64,
        total_tickets: u64,
    }

    struct TicketsTransferred has copy, drop {
        from: address,
        to: address,
        amount: u64,
        from_new_balance: u64,
        to_new_balance: u64,
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

    public entry fun create_game<T0>(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Game<T0>{
            id              : 0x2::object::new(arg1),
            house_vault     : 0x2::balance::zero<T0>(),
            player_winnings : 0x2::table::new<address, u64>(arg1),
            player_tickets  : 0x2::table::new<address, u64>(arg1),
            buyback_wallet  : @0x666b2eabb0917a2bfb067cc17dcc87ff8e17e7e54acd4ce48a08767ecedd0150,
            airdrop_wallet  : @0x99f57192bdb30bad7e763153e05ad50ef5872e84c15b35fb6f5fbd63f4e4dda2,
            total_spins     : 0,
            total_wagered   : 0,
            total_paid_out  : 0,
            active          : true,
            admin           : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::share_object<Game<T0>>(v0);
    }

    entry fun fund_house<T0>(arg0: &mut Game<T0>, arg1: &AdminCap, arg2: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.house_vault, 0x2::coin::into_balance<T0>(arg2));
        let v0 = HouseFunded{
            amount      : 0x2::coin::value<T0>(&arg2),
            new_balance : 0x2::balance::value<T0>(&arg0.house_vault),
        };
        0x2::event::emit<HouseFunded>(v0);
    }

    public fun get_game_stats<T0>(arg0: &Game<T0>) : (u64, u64, u64, bool) {
        (arg0.total_spins, arg0.total_wagered, arg0.total_paid_out, arg0.active)
    }

    public fun get_house_balance<T0>(arg0: &Game<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.house_vault)
    }

    public fun get_max_payout_per_mnm() : u64 {
        1000000000 * 200000 / 10000
    }

    public fun get_min_bet() : u64 {
        1000000000
    }

    fun get_outcomes() : vector<Outcome> {
        let v0 = 0x1::vector::empty<Outcome>();
        let v1 = Outcome{
            multiplier_bp : 0,
            weight        : 580,
        };
        0x1::vector::push_back<Outcome>(&mut v0, v1);
        let v2 = Outcome{
            multiplier_bp : 12000,
            weight        : 180,
        };
        0x1::vector::push_back<Outcome>(&mut v0, v2);
        let v3 = Outcome{
            multiplier_bp : 15000,
            weight        : 110,
        };
        0x1::vector::push_back<Outcome>(&mut v0, v3);
        let v4 = Outcome{
            multiplier_bp : 20000,
            weight        : 70,
        };
        0x1::vector::push_back<Outcome>(&mut v0, v4);
        let v5 = Outcome{
            multiplier_bp : 40000,
            weight        : 40,
        };
        0x1::vector::push_back<Outcome>(&mut v0, v5);
        let v6 = Outcome{
            multiplier_bp : 80000,
            weight        : 15,
        };
        0x1::vector::push_back<Outcome>(&mut v0, v6);
        let v7 = Outcome{
            multiplier_bp : 200000,
            weight        : 5,
        };
        0x1::vector::push_back<Outcome>(&mut v0, v7);
        v0
    }

    public fun get_player_tickets<T0>(arg0: &Game<T0>, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.player_tickets, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.player_tickets, arg1)
        } else {
            0
        }
    }

    public fun get_player_winnings<T0>(arg0: &Game<T0>, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.player_winnings, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.player_winnings, arg1)
        } else {
            0
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    fun route_loss_funds<T0>(arg0: &mut Game<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = v0 * 9000 / 10000;
        let v2 = v0 - v1;
        let v3 = 0x2::coin::into_balance<T0>(arg1);
        if (v1 > 0) {
            0x2::balance::join<T0>(&mut arg0.house_vault, 0x2::balance::split<T0>(&mut v3, v1));
        };
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v3, v2), arg2), arg0.airdrop_wallet);
        };
        0x2::balance::destroy_zero<T0>(v3);
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

    entry fun set_game_active<T0>(arg0: &mut Game<T0>, arg1: &AdminCap, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 4);
        arg0.active = arg2;
        let v0 = GamePausedEvent{paused: !arg2};
        0x2::event::emit<GamePausedEvent>(v0);
    }

    public entry fun spin<T0>(arg0: &mut Game<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.active, 3);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 >= 1000000000, 1);
        assert!(v0 % 1000000000 == 0, 1);
        let v1 = get_outcomes();
        let v2 = 0x2::random::new_generator(arg2, arg3);
        let v3 = select_outcome(&v1, 0x2::random::generate_u64(&mut v2), calculate_total_weight(&v1));
        let v4 = 0x2::tx_context::sender(arg3);
        let v5 = if (v3.multiplier_bp == 0) {
            route_loss_funds<T0>(arg0, arg1, arg3);
            0
        } else {
            let v6 = v0 * v3.multiplier_bp / 10000;
            assert!(0x2::balance::value<T0>(&arg0.house_vault) >= v6, 2);
            0x2::balance::join<T0>(&mut arg0.house_vault, 0x2::coin::into_balance<T0>(arg1));
            if (0x2::table::contains<address, u64>(&arg0.player_winnings, v4)) {
                0x2::table::add<address, u64>(&mut arg0.player_winnings, v4, 0x2::table::remove<address, u64>(&mut arg0.player_winnings, v4) + v6);
            } else {
                0x2::table::add<address, u64>(&mut arg0.player_winnings, v4, v6);
            };
            let v7 = v6 / 50;
            if (v7 > 0) {
                let v8 = if (0x2::table::contains<address, u64>(&arg0.player_tickets, v4)) {
                    0x2::table::remove<address, u64>(&mut arg0.player_tickets, v4) + v7
                } else {
                    v7
                };
                0x2::table::add<address, u64>(&mut arg0.player_tickets, v4, v8);
                let v9 = TicketsEarned{
                    player        : v4,
                    tickets       : v7,
                    total_tickets : v8,
                };
                0x2::event::emit<TicketsEarned>(v9);
            };
            arg0.total_paid_out = arg0.total_paid_out + v6;
            v6
        };
        arg0.total_spins = arg0.total_spins + 1;
        arg0.total_wagered = arg0.total_wagered + v0;
        let v10 = SpinResult{
            player        : 0x2::tx_context::sender(arg3),
            bet_amount    : v0,
            multiplier_bp : v3.multiplier_bp,
            payout        : v5,
            is_win        : v3.multiplier_bp > 0,
            timestamp_ms  : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<SpinResult>(v10);
    }

    public entry fun transfer_tickets<T0>(arg0: &mut Game<T0>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg2 > 0, 7);
        assert!(0x2::table::contains<address, u64>(&arg0.player_tickets, v0), 6);
        let v1 = 0x2::table::remove<address, u64>(&mut arg0.player_tickets, v0);
        assert!(v1 >= arg2, 6);
        let v2 = v1 - arg2;
        if (v2 > 0) {
            0x2::table::add<address, u64>(&mut arg0.player_tickets, v0, v2);
        };
        let v3 = if (0x2::table::contains<address, u64>(&arg0.player_tickets, arg1)) {
            0x2::table::remove<address, u64>(&mut arg0.player_tickets, arg1) + arg2
        } else {
            arg2
        };
        0x2::table::add<address, u64>(&mut arg0.player_tickets, arg1, v3);
        let v4 = TicketsTransferred{
            from             : v0,
            to               : arg1,
            amount           : arg2,
            from_new_balance : v2,
            to_new_balance   : v3,
        };
        0x2::event::emit<TicketsTransferred>(v4);
    }

    entry fun update_airdrop_wallet<T0>(arg0: &mut Game<T0>, arg1: &AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 4);
        arg0.airdrop_wallet = arg2;
    }

    entry fun update_buyback_wallet<T0>(arg0: &mut Game<T0>, arg1: &AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 4);
        arg0.buyback_wallet = arg2;
    }

    entry fun withdraw_house_funds<T0>(arg0: &mut Game<T0>, arg1: &AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.house_vault, arg2), arg3), arg0.admin);
        let v0 = HouseWithdrawal{
            amount            : arg2,
            remaining_balance : 0x2::balance::value<T0>(&arg0.house_vault),
        };
        0x2::event::emit<HouseWithdrawal>(v0);
    }

    public entry fun withdraw_winnings<T0>(arg0: &mut Game<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::table::contains<address, u64>(&arg0.player_winnings, v0), 5);
        let v1 = 0x2::table::remove<address, u64>(&mut arg0.player_winnings, v0);
        assert!(v1 > 0, 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.house_vault, v1), arg1), v0);
        let v2 = WinningsWithdrawn{
            player : v0,
            amount : v1,
        };
        0x2::event::emit<WinningsWithdrawn>(v2);
    }

    // decompiled from Move bytecode v6
}

