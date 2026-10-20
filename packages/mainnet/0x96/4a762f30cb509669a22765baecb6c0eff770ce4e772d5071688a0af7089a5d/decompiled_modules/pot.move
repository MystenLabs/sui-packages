module 0x964a762f30cb509669a22765baecb6c0eff770ce4e772d5071688a0af7089a5d::pot {
    struct PotPool<phantom T0> has key {
        id: 0x2::object::UID,
        config_id: 0x2::object::ID,
        balance: 0x2::balance::Balance<T0>,
        day: u64,
        day_start_balance: u64,
        budget_games: u64,
        games_today: u64,
        total_funded: u64,
        total_reserved: u64,
        total_paid_out: u64,
        total_house: u64,
        total_burned: u64,
        total_returned: u64,
        total_games: u64,
        total_wins: u64,
        total_draws: u64,
        total_losses: u64,
        total_expired: u64,
        tickets_sold: u64,
        ticket_revenue: u64,
    }

    struct TicketRegistry has key {
        id: 0x2::object::UID,
        config_id: 0x2::object::ID,
    }

    struct BookKey has copy, drop, store {
        pos0: address,
    }

    struct TicketBook has key {
        id: 0x2::object::UID,
        config_id: 0x2::object::ID,
        owner: address,
        units: u64,
        accounted: 0x2::table::Table<u64, u64>,
        remainder: u128,
        day: u64,
        games: u64,
        wins: u64,
        open_games: u64,
        total_accrued: u64,
        total_bought: u64,
        total_dropped: u64,
    }

    struct PotGame<phantom T0> has key {
        id: 0x2::object::UID,
        config_id: 0x2::object::ID,
        book_id: 0x2::object::ID,
        player: address,
        lead_account_id: 0x2::object::ID,
        strategy_hash: vector<u8>,
        pot: 0x2::balance::Balance<T0>,
        pot_amount: u64,
        win_bps: u64,
        difficulty: u8,
        seed: vector<u8>,
        status: u8,
        created_at_ms: u64,
        play_by_ms: u64,
        settle_by_ms: u64,
        started_at_ms: u64,
        ended_at_ms: u64,
        player_fuel: u8,
        guardian_fuel: u8,
        replay_digest: vector<u8>,
        payout: u64,
        house_amount: u64,
        burned: u64,
    }

    struct PotCreated has copy, drop {
        config_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        registry_id: 0x2::object::ID,
        house: address,
        pot_amount: u64,
        coin_decimals: u8,
        ticket_coin_days: u64,
    }

    struct BookOpened has copy, drop {
        book_id: 0x2::object::ID,
        config_id: 0x2::object::ID,
        owner: address,
    }

    struct TicketsAccrued has copy, drop {
        book_id: 0x2::object::ID,
        owner: address,
        escrow_id: 0x2::object::ID,
        locks: u64,
        added: u64,
        credited: u64,
        dropped: u64,
        units: u64,
        accrued_at_ms: u64,
    }

    struct TicketsBought has copy, drop {
        book_id: 0x2::object::ID,
        owner: address,
        count: u64,
        price: u64,
        paid: u64,
        to_pool: u64,
        burned: u64,
        to_studio: u64,
        studio: address,
        units: u64,
    }

    struct PotFunded has copy, drop {
        pool_id: 0x2::object::ID,
        amount: u64,
        balance: u64,
    }

    struct PoolDayStarted has copy, drop {
        pool_id: 0x2::object::ID,
        day: u64,
        day_start_balance: u64,
        pot: u64,
        budget_games: u64,
    }

    struct GameEntered has copy, drop {
        game_id: 0x2::object::ID,
        config_id: 0x2::object::ID,
        book_id: 0x2::object::ID,
        player: address,
        lead_account_id: 0x2::object::ID,
        strategy_hash: vector<u8>,
        pot: u64,
        win_bps: u64,
        difficulty: u8,
        created_at_ms: u64,
        play_by_ms: u64,
        settle_by_ms: u64,
        units_left: u64,
        player_games_today: u64,
        pool_games_today: u64,
        budget_games: u64,
    }

    struct GameSeedDrawn has copy, drop {
        game_id: 0x2::object::ID,
        player: address,
        seed: vector<u8>,
        difficulty: u8,
        drawn_at_ms: u64,
    }

    struct GameSettled has copy, drop {
        game_id: 0x2::object::ID,
        player: address,
        outcome: u8,
        pot: u64,
        payout: u64,
        house: address,
        house_amount: u64,
        burned: u64,
        returned: u64,
        player_fuel: u8,
        guardian_fuel: u8,
        replay_digest: vector<u8>,
        verifier_cap_id: 0x2::object::ID,
        settled_at_ms: u64,
    }

    struct GameExpired has copy, drop {
        game_id: 0x2::object::ID,
        player: address,
        pot: u64,
        started: bool,
        expired_at_ms: u64,
    }

    public fun pot_amount<T0>(arg0: &PotGame<T0>) : u64 {
        arg0.pot_amount
    }

    public fun accrue<T0>(arg0: &mut TicketBook, arg1: &0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::escrow::EscrowVault<T0>, arg2: &0x964a762f30cb509669a22765baecb6c0eff770ce4e772d5071688a0af7089a5d::config::PotConfig<T0>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : u64 {
        0x964a762f30cb509669a22765baecb6c0eff770ce4e772d5071688a0af7089a5d::config::assert_version<T0>(arg2);
        assert_book_config<T0>(arg0, arg2);
        assert!(0x2::tx_context::sender(arg4) == arg0.owner, 13906836274583437329);
        accrue_locks<T0>(arg0, arg1, arg2, arg3)
    }

    fun accrue_locks<T0>(arg0: &mut TicketBook, arg1: &0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::escrow::EscrowVault<T0>, arg2: &0x964a762f30cb509669a22765baecb6c0eff770ce4e772d5071688a0af7089a5d::config::PotConfig<T0>, arg3: &0x2::clock::Clock) : u64 {
        assert!(0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::escrow::owner<T0>(arg1) == arg0.owner, 13906838984707670031);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let (v1, v2, v3) = uncredited<T0>(arg0, arg1, arg2, v0);
        let v4 = v1;
        if (0x1::vector::is_empty<u64>(&v4)) {
            return 0
        };
        let (v5, v6) = units_earned<T0>(arg0, v3, arg2);
        let (v7, v8) = capped<T0>(arg0, v5, arg2);
        let v9 = v2;
        0x1::vector::reverse<u64>(&mut v9);
        assert!(0x1::vector::length<u64>(&v4) == 0x1::vector::length<u64>(&v9), 13906839027656425471);
        0x1::vector::reverse<u64>(&mut v4);
        let v10 = 0;
        while (v10 < 0x1::vector::length<u64>(&v4)) {
            let v11 = 0x1::vector::pop_back<u64>(&mut v4);
            if (0x2::table::contains<u64, u64>(&arg0.accounted, v11)) {
                *0x2::table::borrow_mut<u64, u64>(&mut arg0.accounted, v11) = 0x1::vector::pop_back<u64>(&mut v9);
            } else {
                0x2::table::add<u64, u64>(&mut arg0.accounted, v11, 0x1::vector::pop_back<u64>(&mut v9));
            };
            v10 = v10 + 1;
        };
        0x1::vector::destroy_empty<u64>(v4);
        0x1::vector::destroy_empty<u64>(v9);
        arg0.remainder = v6;
        arg0.units = arg0.units + v7;
        arg0.total_accrued = saturating_add(arg0.total_accrued, v7);
        arg0.total_dropped = saturating_add(arg0.total_dropped, v8);
        let v12 = TicketsAccrued{
            book_id       : 0x2::object::id<TicketBook>(arg0),
            owner         : arg0.owner,
            escrow_id     : 0x2::object::id<0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::escrow::EscrowVault<T0>>(arg1),
            locks         : 0x1::vector::length<u64>(&v4),
            added         : v5,
            credited      : v7,
            dropped       : v8,
            units         : arg0.units,
            accrued_at_ms : v0,
        };
        0x2::event::emit<TicketsAccrued>(v12);
        v7
    }

    fun assert_book_config<T0>(arg0: &TicketBook, arg1: &0x964a762f30cb509669a22765baecb6c0eff770ce4e772d5071688a0af7089a5d::config::PotConfig<T0>) {
        assert!(arg0.config_id == 0x2::object::id<0x964a762f30cb509669a22765baecb6c0eff770ce4e772d5071688a0af7089a5d::config::PotConfig<T0>>(arg1), 13906838606750285835);
    }

    fun assert_config<T0>(arg0: &PotPool<T0>, arg1: &0x964a762f30cb509669a22765baecb6c0eff770ce4e772d5071688a0af7089a5d::config::PotConfig<T0>) {
        assert!(arg0.config_id == 0x2::object::id<0x964a762f30cb509669a22765baecb6c0eff770ce4e772d5071688a0af7089a5d::config::PotConfig<T0>>(arg1), 13906838589570416651);
    }

    fun assert_game_config<T0>(arg0: &PotGame<T0>, arg1: &0x964a762f30cb509669a22765baecb6c0eff770ce4e772d5071688a0af7089a5d::config::PotConfig<T0>) {
        0x964a762f30cb509669a22765baecb6c0eff770ce4e772d5071688a0af7089a5d::config::assert_version<T0>(arg1);
        assert!(arg0.config_id == 0x2::object::id<0x964a762f30cb509669a22765baecb6c0eff770ce4e772d5071688a0af7089a5d::config::PotConfig<T0>>(arg1), 13906838636815056907);
    }

    fun assert_seed_drawable<T0>(arg0: &PotGame<T0>, arg1: &0x2::clock::Clock) {
        assert!(arg0.status == 0, 13906838671176761385);
        assert!(0x1::vector::is_empty<u8>(&arg0.seed), 13906838675472384051);
        assert!(0x2::clock::timestamp_ms(arg1) <= arg0.settle_by_ms, 13906838679767089199);
    }

    public fun book_address(arg0: 0x2::object::ID, arg1: address) : address {
        let v0 = BookKey{pos0: arg1};
        0x2::derived_object::derive_address<BookKey>(arg0, v0)
    }

    public fun book_config_id(arg0: &TicketBook) : 0x2::object::ID {
        arg0.config_id
    }

    public fun book_exists(arg0: &TicketRegistry, arg1: address) : bool {
        let v0 = BookKey{pos0: arg1};
        0x2::derived_object::exists<BookKey>(&arg0.id, v0)
    }

    public fun book_owner(arg0: &TicketBook) : address {
        arg0.owner
    }

    fun budget_for<T0>(arg0: u64, arg1: &0x964a762f30cb509669a22765baecb6c0eff770ce4e772d5071688a0af7089a5d::config::PotConfig<T0>) : u64 {
        let v0 = pot_for<T0>(arg0, arg1);
        if (v0 == 0) {
            0
        } else {
            0x1::u64::mul_div(arg0, 0x964a762f30cb509669a22765baecb6c0eff770ce4e772d5071688a0af7089a5d::config::daily_spend_bps<T0>(arg1), 10000) / v0
        }
    }

    public fun burned<T0>(arg0: &PotGame<T0>) : u64 {
        arg0.burned
    }

    public fun buy_tickets<T0>(arg0: &mut TicketBook, arg1: &0x964a762f30cb509669a22765baecb6c0eff770ce4e772d5071688a0af7089a5d::config::PotConfig<T0>, arg2: &mut PotPool<T0>, arg3: &mut 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::burn::BurnVault<T0>, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        0x964a762f30cb509669a22765baecb6c0eff770ce4e772d5071688a0af7089a5d::config::assert_accepting<T0>(arg1);
        assert_book_config<T0>(arg0, arg1);
        assert_config<T0>(arg2, arg1);
        assert!(0x2::tx_context::sender(arg6) == arg0.owner, 13906836450677096465);
        assert!(arg5 > 0, 13906836454972325909);
        assert!(arg5 <= 0x964a762f30cb509669a22765baecb6c0eff770ce4e772d5071688a0af7089a5d::config::max_tickets<T0>(arg1) && arg0.units + arg5 * 1000000 <= 0x964a762f30cb509669a22765baecb6c0eff770ce4e772d5071688a0af7089a5d::config::max_ticket_units<T0>(arg1), 13906836472152326167);
        let v0 = 0x964a762f30cb509669a22765baecb6c0eff770ce4e772d5071688a0af7089a5d::config::ticket_price<T0>(arg1);
        let v1 = v0 * arg5;
        assert!(0x2::coin::value<T0>(&arg4) == v1, 13906836489332326425);
        let (_, v3, v4) = 0x964a762f30cb509669a22765baecb6c0eff770ce4e772d5071688a0af7089a5d::config::ticket_split<T0>(arg1);
        let v5 = 0x1::u64::mul_div(v1, v3, 10000);
        let v6 = 0x1::u64::mul_div(v1, v4, 10000);
        let v7 = v1 - v5 - v6;
        let v8 = 0x964a762f30cb509669a22765baecb6c0eff770ce4e772d5071688a0af7089a5d::config::house<T0>(arg1);
        let v9 = 0x2::coin::into_balance<T0>(arg4);
        0x2::balance::join<T0>(&mut arg2.balance, 0x2::balance::split<T0>(&mut v9, v7));
        arg2.total_funded = saturating_add(arg2.total_funded, v7);
        arg2.tickets_sold = saturating_add(arg2.tickets_sold, arg5);
        arg2.ticket_revenue = saturating_add(arg2.ticket_revenue, v1);
        if (v5 > 0) {
            0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::burn::burn<T0>(arg3, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v9, v5), arg6));
        };
        if (v6 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v9, arg6), v8);
        } else {
            0x2::balance::destroy_zero<T0>(v9);
        };
        let v10 = arg5 * 1000000;
        arg0.units = arg0.units + v10;
        arg0.total_bought = saturating_add(arg0.total_bought, v10);
        let v11 = TicketsBought{
            book_id   : 0x2::object::id<TicketBook>(arg0),
            owner     : arg0.owner,
            count     : arg5,
            price     : v0,
            paid      : v1,
            to_pool   : v7,
            burned    : v5,
            to_studio : v6,
            studio    : v8,
            units     : arg0.units,
        };
        0x2::event::emit<TicketsBought>(v11);
    }

    fun capped<T0>(arg0: &TicketBook, arg1: u64, arg2: &0x964a762f30cb509669a22765baecb6c0eff770ce4e772d5071688a0af7089a5d::config::PotConfig<T0>) : (u64, u64) {
        let v0 = 0x964a762f30cb509669a22765baecb6c0eff770ce4e772d5071688a0af7089a5d::config::max_ticket_units<T0>(arg2);
        let v1 = if (arg0.units >= v0) {
            0
        } else {
            v0 - arg0.units
        };
        let v2 = 0x1::u64::min(arg1, v1);
        (v2, arg1 - v2)
    }

    public fun create_pot<T0>(arg0: &0x964a762f30cb509669a22765baecb6c0eff770ce4e772d5071688a0af7089a5d::config::PotAdminCap, arg1: address, arg2: u64, arg3: u8, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::object::new(arg5);
        let v1 = 0x2::object::new(arg5);
        let v2 = 0x2::object::uid_to_inner(&v0);
        let v3 = 0x2::object::uid_to_inner(&v1);
        let v4 = 0x964a762f30cb509669a22765baecb6c0eff770ce4e772d5071688a0af7089a5d::config::new<T0>(v2, v3, arg1, arg2, arg3, arg4, arg5);
        let v5 = 0x2::object::id<0x964a762f30cb509669a22765baecb6c0eff770ce4e772d5071688a0af7089a5d::config::PotConfig<T0>>(&v4);
        let v6 = PotPool<T0>{
            id                : v0,
            config_id         : v5,
            balance           : 0x2::balance::zero<T0>(),
            day               : 0,
            day_start_balance : 0,
            budget_games      : 0,
            games_today       : 0,
            total_funded      : 0,
            total_reserved    : 0,
            total_paid_out    : 0,
            total_house       : 0,
            total_burned      : 0,
            total_returned    : 0,
            total_games       : 0,
            total_wins        : 0,
            total_draws       : 0,
            total_losses      : 0,
            total_expired     : 0,
            tickets_sold      : 0,
            ticket_revenue    : 0,
        };
        let v7 = TicketRegistry{
            id        : v1,
            config_id : v5,
        };
        let v8 = PotCreated{
            config_id        : v5,
            pool_id          : v2,
            registry_id      : v3,
            house            : arg1,
            pot_amount       : arg2,
            coin_decimals    : arg3,
            ticket_coin_days : arg4,
        };
        0x2::event::emit<PotCreated>(v8);
        0x964a762f30cb509669a22765baecb6c0eff770ce4e772d5071688a0af7089a5d::config::share<T0>(v4);
        0x2::transfer::share_object<PotPool<T0>>(v6);
        0x2::transfer::share_object<TicketRegistry>(v7);
        v5
    }

    public fun created_at_ms<T0>(arg0: &PotGame<T0>) : u64 {
        arg0.created_at_ms
    }

    public fun credited_until(arg0: &TicketBook, arg1: u64) : 0x1::option::Option<u64> {
        if (0x2::table::contains<u64, u64>(&arg0.accounted, arg1)) {
            0x1::option::some<u64>(*0x2::table::borrow<u64, u64>(&arg0.accounted, arg1))
        } else {
            0x1::option::none<u64>()
        }
    }

    entry fun draw_game_seed<T0>(arg0: &mut PotGame<T0>, arg1: &0x964a762f30cb509669a22765baecb6c0eff770ce4e772d5071688a0af7089a5d::config::PotConfig<T0>, arg2: &0x964a762f30cb509669a22765baecb6c0eff770ce4e772d5071688a0af7089a5d::config::PotVerifierCap, arg3: &0x2::random::Random, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_game_config<T0>(arg0, arg1);
        0x964a762f30cb509669a22765baecb6c0eff770ce4e772d5071688a0af7089a5d::config::assert_verifier<T0>(arg1, arg2);
        assert_seed_drawable<T0>(arg0, arg4);
        let v0 = 0x2::random::new_generator(arg3, arg5);
        store_seed<T0>(arg0, 0x2::random::generate_bytes(&mut v0, 32), arg4);
    }

    public fun ended_at_ms<T0>(arg0: &PotGame<T0>) : u64 {
        arg0.ended_at_ms
    }

    public fun enter<T0>(arg0: &0x964a762f30cb509669a22765baecb6c0eff770ce4e772d5071688a0af7089a5d::config::PotConfig<T0>, arg1: &mut PotPool<T0>, arg2: &mut TicketBook, arg3: 0x2::object::ID, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x964a762f30cb509669a22765baecb6c0eff770ce4e772d5071688a0af7089a5d::config::assert_accepting<T0>(arg0);
        assert_config<T0>(arg1, arg0);
        assert_book_config<T0>(arg2, arg0);
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(v0 == arg2.owner, 13906836785684545553);
        assert!(0x1::vector::length<u8>(&arg4) == 32, 13906836789980168219);
        assert!(arg2.units >= 1000000, 13906836794275266589);
        let v1 = 0x2::clock::timestamp_ms(arg5);
        let v2 = v1 / 86400000;
        roll_day(arg2, v2);
        assert!(arg2.games < 0x964a762f30cb509669a22765baecb6c0eff770ce4e772d5071688a0af7089a5d::config::daily_games<T0>(arg0), 13906836811455266847);
        assert!(arg2.wins + arg2.open_games < 0x964a762f30cb509669a22765baecb6c0eff770ce4e772d5071688a0af7089a5d::config::daily_wins<T0>(arg0), 13906836815750365217);
        roll_pool_day<T0>(arg1, arg0, v2);
        assert!(arg1.games_today < arg1.budget_games, 13906836824340430883);
        let v3 = next_pot<T0>(arg1, arg0);
        assert!(v3 > 0, 13906836832930496549);
        arg2.units = arg2.units - 1000000;
        arg2.games = arg2.games + 1;
        arg2.open_games = arg2.open_games + 1;
        arg1.games_today = arg1.games_today + 1;
        arg1.total_games = saturating_add(arg1.total_games, 1);
        arg1.total_reserved = saturating_add(arg1.total_reserved, v3);
        let v4 = v1 + 0x964a762f30cb509669a22765baecb6c0eff770ce4e772d5071688a0af7089a5d::config::game_window_ms<T0>(arg0);
        let v5 = PotGame<T0>{
            id              : 0x2::object::new(arg6),
            config_id       : 0x2::object::id<0x964a762f30cb509669a22765baecb6c0eff770ce4e772d5071688a0af7089a5d::config::PotConfig<T0>>(arg0),
            book_id         : 0x2::object::id<TicketBook>(arg2),
            player          : v0,
            lead_account_id : arg3,
            strategy_hash   : arg4,
            pot             : 0x2::balance::split<T0>(&mut arg1.balance, v3),
            pot_amount      : v3,
            win_bps         : 0x964a762f30cb509669a22765baecb6c0eff770ce4e772d5071688a0af7089a5d::config::win_bps<T0>(arg0),
            difficulty      : 0x964a762f30cb509669a22765baecb6c0eff770ce4e772d5071688a0af7089a5d::config::difficulty<T0>(arg0),
            seed            : b"",
            status          : 0,
            created_at_ms   : v1,
            play_by_ms      : v4,
            settle_by_ms    : v4 + 0x964a762f30cb509669a22765baecb6c0eff770ce4e772d5071688a0af7089a5d::config::settle_grace_ms<T0>(arg0),
            started_at_ms   : 0,
            ended_at_ms     : 0,
            player_fuel     : 0,
            guardian_fuel   : 0,
            replay_digest   : b"",
            payout          : 0,
            house_amount    : 0,
            burned          : 0,
        };
        let v6 = 0x2::object::id<PotGame<T0>>(&v5);
        let v7 = GameEntered{
            game_id            : v6,
            config_id          : v5.config_id,
            book_id            : v5.book_id,
            player             : v0,
            lead_account_id    : arg3,
            strategy_hash      : v5.strategy_hash,
            pot                : v3,
            win_bps            : v5.win_bps,
            difficulty         : v5.difficulty,
            created_at_ms      : v1,
            play_by_ms         : v4,
            settle_by_ms       : v5.settle_by_ms,
            units_left         : arg2.units,
            player_games_today : arg2.games,
            pool_games_today   : arg1.games_today,
            budget_games       : arg1.budget_games,
        };
        0x2::event::emit<GameEntered>(v7);
        0x2::transfer::share_object<PotGame<T0>>(v5);
        v6
    }

    public fun expire_game<T0>(arg0: &mut PotGame<T0>, arg1: &0x964a762f30cb509669a22765baecb6c0eff770ce4e772d5071688a0af7089a5d::config::PotConfig<T0>, arg2: &mut PotPool<T0>, arg3: &mut TicketBook, arg4: &0x2::clock::Clock) {
        assert_game_config<T0>(arg0, arg1);
        assert_config<T0>(arg2, arg1);
        assert!(0x2::object::id<TicketBook>(arg3) == arg0.book_id, 13906837683332448269);
        assert!(arg0.status == 0, 13906837687629250601);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(v0 > arg0.settle_by_ms, 13906837696219709489);
        let v1 = 0x2::balance::withdraw_all<T0>(&mut arg0.pot);
        let v2 = 0x2::balance::value<T0>(&v1);
        0x2::balance::join<T0>(&mut arg2.balance, v1);
        arg2.total_returned = saturating_add(arg2.total_returned, v2);
        arg2.total_expired = saturating_add(arg2.total_expired, 1);
        arg3.open_games = arg3.open_games - 1;
        arg0.status = 4;
        arg0.ended_at_ms = v0;
        let v3 = GameExpired{
            game_id       : 0x2::object::id<PotGame<T0>>(arg0),
            player        : arg0.player,
            pot           : v2,
            started       : !0x1::vector::is_empty<u8>(&arg0.seed),
            expired_at_ms : v0,
        };
        0x2::event::emit<GameExpired>(v3);
    }

    public fun fund<T0>(arg0: &mut PotPool<T0>, arg1: 0x2::coin::Coin<T0>) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 13906836652540690451);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
        arg0.total_funded = saturating_add(arg0.total_funded, v0);
        let v1 = PotFunded{
            pool_id : 0x2::object::id<PotPool<T0>>(arg0),
            amount  : v0,
            balance : 0x2::balance::value<T0>(&arg0.balance),
        };
        0x2::event::emit<PotFunded>(v1);
    }

    public fun game_book_id<T0>(arg0: &PotGame<T0>) : 0x2::object::ID {
        arg0.book_id
    }

    public fun game_config_id<T0>(arg0: &PotGame<T0>) : 0x2::object::ID {
        arg0.config_id
    }

    public fun game_difficulty<T0>(arg0: &PotGame<T0>) : u8 {
        arg0.difficulty
    }

    public fun game_win_bps<T0>(arg0: &PotGame<T0>) : u64 {
        arg0.win_bps
    }

    public fun games_left_today<T0>(arg0: &PotPool<T0>, arg1: &0x964a762f30cb509669a22765baecb6c0eff770ce4e772d5071688a0af7089a5d::config::PotConfig<T0>, arg2: &0x2::clock::Clock) : u64 {
        if (arg0.day == 0x2::clock::timestamp_ms(arg2) / 86400000) {
            arg0.budget_games - arg0.games_today
        } else {
            budget_for<T0>(0x2::balance::value<T0>(&arg0.balance), arg1)
        }
    }

    public fun games_today(arg0: &TicketBook, arg1: &0x2::clock::Clock) : u64 {
        if (arg0.day == 0x2::clock::timestamp_ms(arg1) / 86400000) {
            arg0.games
        } else {
            0
        }
    }

    public fun guardian_fuel<T0>(arg0: &PotGame<T0>) : u8 {
        arg0.guardian_fuel
    }

    public fun house_amount<T0>(arg0: &PotGame<T0>) : u64 {
        arg0.house_amount
    }

    public fun is_started<T0>(arg0: &PotGame<T0>) : bool {
        !0x1::vector::is_empty<u8>(&arg0.seed)
    }

    public fun keeper_accrue<T0>(arg0: &mut TicketBook, arg1: &0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::escrow::EscrowVault<T0>, arg2: &0x964a762f30cb509669a22765baecb6c0eff770ce4e772d5071688a0af7089a5d::config::PotConfig<T0>, arg3: &0x964a762f30cb509669a22765baecb6c0eff770ce4e772d5071688a0af7089a5d::config::PotKeeperCap, arg4: &0x2::clock::Clock) : u64 {
        0x964a762f30cb509669a22765baecb6c0eff770ce4e772d5071688a0af7089a5d::config::assert_version<T0>(arg2);
        assert_book_config<T0>(arg0, arg2);
        0x964a762f30cb509669a22765baecb6c0eff770ce4e772d5071688a0af7089a5d::config::assert_keeper<T0>(arg2, arg3);
        accrue_locks<T0>(arg0, arg1, arg2, arg4)
    }

    public fun lead_account_id<T0>(arg0: &PotGame<T0>) : 0x2::object::ID {
        arg0.lead_account_id
    }

    public fun new_book(arg0: &mut TicketRegistry, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : TicketBook {
        let v0 = BookKey{pos0: arg1};
        let v1 = TicketBook{
            id            : 0x2::derived_object::claim<BookKey>(&mut arg0.id, v0),
            config_id     : arg0.config_id,
            owner         : arg1,
            units         : 0,
            accounted     : 0x2::table::new<u64, u64>(arg2),
            remainder     : 0,
            day           : 0,
            games         : 0,
            wins          : 0,
            open_games    : 0,
            total_accrued : 0,
            total_bought  : 0,
            total_dropped : 0,
        };
        let v2 = BookOpened{
            book_id   : 0x2::object::id<TicketBook>(&v1),
            config_id : v1.config_id,
            owner     : arg1,
        };
        0x2::event::emit<BookOpened>(v2);
        v1
    }

    public fun next_pot<T0>(arg0: &PotPool<T0>, arg1: &0x964a762f30cb509669a22765baecb6c0eff770ce4e772d5071688a0af7089a5d::config::PotConfig<T0>) : u64 {
        pot_for<T0>(0x2::balance::value<T0>(&arg0.balance), arg1)
    }

    public fun open_book(arg0: &mut TicketRegistry, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = new_book(arg0, arg1, arg2);
        share_book(v0);
        0x2::object::id<TicketBook>(&v0)
    }

    public fun open_games(arg0: &TicketBook) : u64 {
        arg0.open_games
    }

    fun pay<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) == 0) {
            0x2::balance::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg2), arg1);
        };
    }

    public fun payout<T0>(arg0: &PotGame<T0>) : u64 {
        arg0.payout
    }

    public fun pending_units<T0>(arg0: &TicketBook, arg1: &0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::escrow::EscrowVault<T0>, arg2: &0x964a762f30cb509669a22765baecb6c0eff770ce4e772d5071688a0af7089a5d::config::PotConfig<T0>, arg3: &0x2::clock::Clock) : u64 {
        let (_, _, v2) = uncredited<T0>(arg0, arg1, arg2, 0x2::clock::timestamp_ms(arg3));
        let (v3, _) = units_earned<T0>(arg0, v2, arg2);
        let (v5, _) = capped<T0>(arg0, v3, arg2);
        v5
    }

    public fun play_by_ms<T0>(arg0: &PotGame<T0>) : u64 {
        arg0.play_by_ms
    }

    public fun player<T0>(arg0: &PotGame<T0>) : address {
        arg0.player
    }

    public fun player_fuel<T0>(arg0: &PotGame<T0>) : u8 {
        arg0.player_fuel
    }

    public fun pool_balance<T0>(arg0: &PotPool<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun pool_budget_games<T0>(arg0: &PotPool<T0>) : u64 {
        arg0.budget_games
    }

    public fun pool_config_id<T0>(arg0: &PotPool<T0>) : 0x2::object::ID {
        arg0.config_id
    }

    public fun pool_day<T0>(arg0: &PotPool<T0>) : u64 {
        arg0.day
    }

    public fun pool_day_start_balance<T0>(arg0: &PotPool<T0>) : u64 {
        arg0.day_start_balance
    }

    public fun pool_games_today<T0>(arg0: &PotPool<T0>) : u64 {
        arg0.games_today
    }

    fun pot_for<T0>(arg0: u64, arg1: &0x964a762f30cb509669a22765baecb6c0eff770ce4e772d5071688a0af7089a5d::config::PotConfig<T0>) : u64 {
        0x1::u64::min(0x964a762f30cb509669a22765baecb6c0eff770ce4e772d5071688a0af7089a5d::config::pot_amount<T0>(arg1), 0x1::u64::mul_div(arg0, 0x964a762f30cb509669a22765baecb6c0eff770ce4e772d5071688a0af7089a5d::config::max_pot_bps<T0>(arg1), 10000))
    }

    public fun pot_value<T0>(arg0: &PotGame<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.pot)
    }

    public fun registry_config_id(arg0: &TicketRegistry) : 0x2::object::ID {
        arg0.config_id
    }

    public fun remainder(arg0: &TicketBook) : u128 {
        arg0.remainder
    }

    public fun replay_digest<T0>(arg0: &PotGame<T0>) : vector<u8> {
        arg0.replay_digest
    }

    fun roll_day(arg0: &mut TicketBook, arg1: u64) {
        if (arg0.day == arg1) {
            return
        };
        arg0.day = arg1;
        arg0.games = 0;
        arg0.wins = 0;
    }

    fun roll_pool_day<T0>(arg0: &mut PotPool<T0>, arg1: &0x964a762f30cb509669a22765baecb6c0eff770ce4e772d5071688a0af7089a5d::config::PotConfig<T0>, arg2: u64) {
        if (arg0.day == arg2) {
            return
        };
        let v0 = 0x2::balance::value<T0>(&arg0.balance);
        arg0.day = arg2;
        arg0.day_start_balance = v0;
        arg0.budget_games = budget_for<T0>(v0, arg1);
        arg0.games_today = 0;
        let v1 = PoolDayStarted{
            pool_id           : 0x2::object::id<PotPool<T0>>(arg0),
            day               : arg2,
            day_start_balance : v0,
            pot               : pot_for<T0>(v0, arg1),
            budget_games      : arg0.budget_games,
        };
        0x2::event::emit<PoolDayStarted>(v1);
    }

    fun saturating_add(arg0: u64, arg1: u64) : u64 {
        let v0 = 18446744073709551615;
        if (arg1 > v0 - arg0) {
            v0
        } else {
            arg0 + arg1
        }
    }

    public fun seed<T0>(arg0: &PotGame<T0>) : vector<u8> {
        arg0.seed
    }

    public fun settle_by_ms<T0>(arg0: &PotGame<T0>) : u64 {
        arg0.settle_by_ms
    }

    public fun settle_game<T0>(arg0: &mut PotGame<T0>, arg1: &0x964a762f30cb509669a22765baecb6c0eff770ce4e772d5071688a0af7089a5d::config::PotConfig<T0>, arg2: &mut PotPool<T0>, arg3: &mut TicketBook, arg4: &mut 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::burn::BurnVault<T0>, arg5: &0x964a762f30cb509669a22765baecb6c0eff770ce4e772d5071688a0af7089a5d::config::PotVerifierCap, arg6: u8, arg7: u8, arg8: vector<u8>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert_game_config<T0>(arg0, arg1);
        0x964a762f30cb509669a22765baecb6c0eff770ce4e772d5071688a0af7089a5d::config::assert_verifier<T0>(arg1, arg5);
        assert_config<T0>(arg2, arg1);
        assert!(0x2::object::id<TicketBook>(arg3) == arg0.book_id, 13906837326850162701);
        assert!(0x1::vector::length<u8>(&arg8) == 32, 13906837331146833959);
        let v0 = if (arg0.status == 1) {
            true
        } else if (arg0.status == 2) {
            true
        } else {
            arg0.status == 3
        };
        if (v0) {
            let v1 = if (arg0.player_fuel == arg6) {
                if (arg0.guardian_fuel == arg7) {
                    arg0.replay_digest == arg8
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v1, 13906837352622063661);
            return
        };
        assert!(arg0.status == 0, 13906837369801801771);
        let v2 = 0x2::clock::timestamp_ms(arg9);
        assert!(v2 <= arg0.settle_by_ms, 13906837378391998511);
        assert!(!0x1::vector::is_empty<u8>(&arg0.seed), 13906837382687359029);
        let v3 = if (arg6 > arg7) {
            1
        } else if (arg6 == arg7) {
            2
        } else {
            3
        };
        let v4 = 0x2::balance::withdraw_all<T0>(&mut arg0.pot);
        let v5 = 0x2::balance::value<T0>(&v4);
        let v6 = 0x964a762f30cb509669a22765baecb6c0eff770ce4e772d5071688a0af7089a5d::config::house<T0>(arg1);
        let (v7, v8, v9, v10) = split_pot(v5, arg0.win_bps, v3);
        roll_day(arg3, v2 / 86400000);
        arg3.open_games = arg3.open_games - 1;
        arg0.status = v3;
        arg0.ended_at_ms = v2;
        arg0.player_fuel = arg6;
        arg0.guardian_fuel = arg7;
        arg0.replay_digest = arg8;
        arg0.payout = v7;
        arg0.house_amount = v8;
        arg0.burned = v9;
        if (v3 == 1) {
            pay<T0>(0x2::balance::split<T0>(&mut v4, v7), arg0.player, arg10);
            pay<T0>(v4, v6, arg10);
            arg3.wins = arg3.wins + 1;
            arg2.total_wins = saturating_add(arg2.total_wins, 1);
            arg2.total_paid_out = saturating_add(arg2.total_paid_out, v7);
            arg2.total_house = saturating_add(arg2.total_house, v8);
        } else if (v3 == 2) {
            0x2::balance::join<T0>(&mut arg2.balance, v4);
            arg2.total_draws = saturating_add(arg2.total_draws, 1);
            arg2.total_returned = saturating_add(arg2.total_returned, v10);
        } else {
            0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::burn::burn<T0>(arg4, 0x2::coin::from_balance<T0>(v4, arg10));
            arg2.total_losses = saturating_add(arg2.total_losses, 1);
            arg2.total_burned = saturating_add(arg2.total_burned, v9);
        };
        let v11 = GameSettled{
            game_id         : 0x2::object::id<PotGame<T0>>(arg0),
            player          : arg0.player,
            outcome         : v3,
            pot             : v5,
            payout          : v7,
            house           : v6,
            house_amount    : v8,
            burned          : v9,
            returned        : v10,
            player_fuel     : arg6,
            guardian_fuel   : arg7,
            replay_digest   : arg8,
            verifier_cap_id : 0x2::object::id<0x964a762f30cb509669a22765baecb6c0eff770ce4e772d5071688a0af7089a5d::config::PotVerifierCap>(arg5),
            settled_at_ms   : v2,
        };
        0x2::event::emit<GameSettled>(v11);
    }

    public fun share_book(arg0: TicketBook) {
        0x2::transfer::share_object<TicketBook>(arg0);
    }

    fun split_pot(arg0: u64, arg1: u64, arg2: u8) : (u64, u64, u64, u64) {
        if (arg2 == 1) {
            let v4 = 0x1::u64::mul_div(arg0, arg1, 10000);
            (v4, arg0 - v4, 0, 0)
        } else if (arg2 == 2) {
            (0, 0, 0, arg0)
        } else {
            (0, 0, arg0, 0)
        }
    }

    public fun started_at_ms<T0>(arg0: &PotGame<T0>) : u64 {
        arg0.started_at_ms
    }

    public fun status<T0>(arg0: &PotGame<T0>) : u8 {
        arg0.status
    }

    public fun status_draw() : u8 {
        2
    }

    public fun status_entered() : u8 {
        0
    }

    public fun status_expired() : u8 {
        4
    }

    public fun status_lost() : u8 {
        3
    }

    public fun status_won() : u8 {
        1
    }

    fun store_seed<T0>(arg0: &mut PotGame<T0>, arg1: vector<u8>, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        arg0.seed = arg1;
        arg0.started_at_ms = v0;
        let v1 = GameSeedDrawn{
            game_id     : 0x2::object::id<PotGame<T0>>(arg0),
            player      : arg0.player,
            seed        : arg1,
            difficulty  : arg0.difficulty,
            drawn_at_ms : v0,
        };
        0x2::event::emit<GameSeedDrawn>(v1);
    }

    public fun strategy_hash<T0>(arg0: &PotGame<T0>) : vector<u8> {
        arg0.strategy_hash
    }

    fun ticket_divisor<T0>(arg0: &0x964a762f30cb509669a22765baecb6c0eff770ce4e772d5071688a0af7089a5d::config::PotConfig<T0>) : u128 {
        (0x964a762f30cb509669a22765baecb6c0eff770ce4e772d5071688a0af7089a5d::config::ticket_coin_days<T0>(arg0) as u128) * (0x964a762f30cb509669a22765baecb6c0eff770ce4e772d5071688a0af7089a5d::config::coin_unit<T0>(arg0) as u128) * (86400000 as u128)
    }

    public fun ticket_revenue<T0>(arg0: &PotPool<T0>) : u64 {
        arg0.ticket_revenue
    }

    public fun tickets_sold<T0>(arg0: &PotPool<T0>) : u64 {
        arg0.tickets_sold
    }

    public fun total_accrued(arg0: &TicketBook) : u64 {
        arg0.total_accrued
    }

    public fun total_bought(arg0: &TicketBook) : u64 {
        arg0.total_bought
    }

    public fun total_burned<T0>(arg0: &PotPool<T0>) : u64 {
        arg0.total_burned
    }

    public fun total_draws<T0>(arg0: &PotPool<T0>) : u64 {
        arg0.total_draws
    }

    public fun total_dropped(arg0: &TicketBook) : u64 {
        arg0.total_dropped
    }

    public fun total_expired<T0>(arg0: &PotPool<T0>) : u64 {
        arg0.total_expired
    }

    public fun total_funded<T0>(arg0: &PotPool<T0>) : u64 {
        arg0.total_funded
    }

    public fun total_games<T0>(arg0: &PotPool<T0>) : u64 {
        arg0.total_games
    }

    public fun total_house<T0>(arg0: &PotPool<T0>) : u64 {
        arg0.total_house
    }

    public fun total_losses<T0>(arg0: &PotPool<T0>) : u64 {
        arg0.total_losses
    }

    public fun total_paid_out<T0>(arg0: &PotPool<T0>) : u64 {
        arg0.total_paid_out
    }

    public fun total_reserved<T0>(arg0: &PotPool<T0>) : u64 {
        arg0.total_reserved
    }

    public fun total_returned<T0>(arg0: &PotPool<T0>) : u64 {
        arg0.total_returned
    }

    public fun total_wins<T0>(arg0: &PotPool<T0>) : u64 {
        arg0.total_wins
    }

    fun uncredited<T0>(arg0: &TicketBook, arg1: &0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::escrow::EscrowVault<T0>, arg2: &0x964a762f30cb509669a22765baecb6c0eff770ce4e772d5071688a0af7089a5d::config::PotConfig<T0>, arg3: u64) : (vector<u64>, vector<u64>, u128) {
        let v0 = if (arg3 > 0x964a762f30cb509669a22765baecb6c0eff770ce4e772d5071688a0af7089a5d::config::retro_window_ms<T0>(arg2)) {
            arg3 - 0x964a762f30cb509669a22765baecb6c0eff770ce4e772d5071688a0af7089a5d::config::retro_window_ms<T0>(arg2)
        } else {
            0
        };
        let v1 = vector[];
        let v2 = vector[];
        let v3 = 0;
        let v4 = 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::escrow::locks<T0>(arg1);
        let v5 = &v4;
        let v6 = 0;
        while (v6 < 0x1::vector::length<0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::escrow::LockPosition>(v5)) {
            let v7 = 0x1::vector::borrow<0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::escrow::LockPosition>(v5, v6);
            let v8 = 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::escrow::lock_id(v7);
            let v9 = 0x2::table::contains<u64, u64>(&arg0.accounted, v8);
            let v10 = if (v9) {
                0x1::u64::max(*0x2::table::borrow<u64, u64>(&arg0.accounted, v8), 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::escrow::lock_start_ms(v7))
            } else {
                0x1::u64::max(0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::escrow::lock_start_ms(v7), v0)
            };
            let v11 = 0x1::u64::min(arg3, 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::escrow::lock_end_ms(v7));
            if (v11 > v10) {
                v3 = v3 + (0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::escrow::lock_amount(v7) as u128) * ((v11 - v10) as u128);
                0x1::vector::push_back<u64>(&mut v1, v8);
                0x1::vector::push_back<u64>(&mut v2, v11);
            } else if (!v9) {
                0x1::vector::push_back<u64>(&mut v1, v8);
                0x1::vector::push_back<u64>(&mut v2, v10);
            };
            v6 = v6 + 1;
        };
        (v1, v2, v3)
    }

    public fun units(arg0: &TicketBook) : u64 {
        arg0.units
    }

    fun units_earned<T0>(arg0: &TicketBook, arg1: u128, arg2: &0x964a762f30cb509669a22765baecb6c0eff770ce4e772d5071688a0af7089a5d::config::PotConfig<T0>) : (u64, u128) {
        let v0 = ticket_divisor<T0>(arg2);
        let v1 = arg1 * (1000000 as u128) + arg0.remainder;
        (((v1 / v0) as u64), v1 % v0)
    }

    public fun units_per_day<T0>(arg0: &0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::escrow::EscrowVault<T0>, arg1: &0x964a762f30cb509669a22765baecb6c0eff770ce4e772d5071688a0af7089a5d::config::PotConfig<T0>, arg2: &0x2::clock::Clock) : u64 {
        (0x1::u128::mul_div((0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::escrow::active_locked_value<T0>(arg0, arg2) as u128) * (86400000 as u128), (1000000 as u128), ticket_divisor<T0>(arg1)) as u64)
    }

    public fun wins_today(arg0: &TicketBook, arg1: &0x2::clock::Clock) : u64 {
        if (arg0.day == 0x2::clock::timestamp_ms(arg1) / 86400000) {
            arg0.wins
        } else {
            0
        }
    }

    // decompiled from Move bytecode v7
}

