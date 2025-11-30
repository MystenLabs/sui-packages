module 0x947995f52bc76f69e261f39db42e9197d1793c919c21a0731ea1785f5d19cb99::critical_mass {
    struct Game has key {
        id: 0x2::object::UID,
        pot: 0x2::balance::Balance<0x2::sui::SUI>,
        dividend_pool: 0x2::balance::Balance<0x2::sui::SUI>,
        admin_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        end_time_ms: u64,
        current_key_price: u64,
        price_increment: u64,
        total_keys_sold: u64,
        last_buyer: 0x1::option::Option<address>,
        acc_sui_per_share: u128,
        players: 0x2::table::Table<address, Player>,
        game_active: bool,
        admins: 0x2::vec_set::VecSet<address>,
    }

    struct Player has store {
        keys_held: u64,
        reward_debt: u128,
    }

    struct KeyBought has copy, drop {
        buyer: address,
        keys_bought: u64,
        price_paid: u64,
        time_added: u64,
        new_end_time: u64,
        total_pot: u64,
    }

    struct Winner has copy, drop {
        winner: address,
        jackpot: u64,
    }

    struct DividendsClaimed has copy, drop {
        player: address,
        amount: u64,
    }

    public entry fun add_admin(arg0: &mut Game, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::vec_set::contains<address>(&arg0.admins, &v0), 3);
        0x2::vec_set::insert<address>(&mut arg0.admins, arg1);
    }

    public entry fun admin_set_state(arg0: &mut Game, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(0x2::vec_set::contains<address>(&arg0.admins, &v0), 3);
        arg0.total_keys_sold = arg1;
        arg0.current_key_price = arg2;
        if (arg3 > 0) {
            arg0.price_increment = arg3;
        };
        if (arg4 > 0) {
            arg0.end_time_ms = arg4;
        };
    }

    public entry fun admin_withdraw_fees(arg0: &mut Game, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::vec_set::contains<address>(&arg0.admins, &v0), 3);
        0x2::balance::value<0x2::sui::SUI>(&arg0.admin_balance);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.admin_balance), arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun buy_key(arg0: &mut Game, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        if (arg0.total_keys_sold > 0 && v0 >= arg0.end_time_ms) {
            abort 0
        };
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v1 >= arg0.current_key_price, 2);
        let v2 = 0x2::tx_context::sender(arg3);
        let v3 = 0;
        if (0x2::table::contains<address, Player>(&arg0.players, v2)) {
            let v4 = 0x2::table::borrow_mut<address, Player>(&mut arg0.players, v2);
            let v5 = (v4.keys_held as u128) * arg0.acc_sui_per_share / 1000000000000 - v4.reward_debt;
            if (v5 > 0) {
                v3 = (v5 as u64);
            };
        } else {
            let v6 = Player{
                keys_held   : 0,
                reward_debt : 0,
            };
            0x2::table::add<address, Player>(&mut arg0.players, v2, v6);
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.pot, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.dividend_pool, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v1 * 30 / 100, arg3)));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.admin_balance, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v1 * 20 / 100, arg3)));
        if (arg0.total_keys_sold > 0) {
            arg0.acc_sui_per_share = arg0.acc_sui_per_share + ((v1 * 30 / 100) as u128) * 1000000000000 / (arg0.total_keys_sold as u128);
        };
        let v7 = arg0.total_keys_sold / 100 * 1000;
        let v8 = if (v7 < 30000) {
            30000 - v7
        } else {
            2000
        };
        if (v8 < 2000) {
            v8 = 2000;
        };
        if (arg0.end_time_ms == 0) {
            arg0.end_time_ms = v0 + 86400000;
        } else {
            let v9 = arg0.end_time_ms + v8;
            let v10 = v0 + 86400000;
            if (v9 > v10) {
                arg0.end_time_ms = v10;
            } else {
                arg0.end_time_ms = v9;
            };
        };
        arg0.total_keys_sold = arg0.total_keys_sold + 1;
        arg0.current_key_price = arg0.current_key_price + arg0.price_increment;
        arg0.last_buyer = 0x1::option::some<address>(v2);
        let v11 = 0x2::table::borrow_mut<address, Player>(&mut arg0.players, v2);
        v11.keys_held = v11.keys_held + 1;
        v11.reward_debt = (v11.keys_held as u128) * arg0.acc_sui_per_share / 1000000000000;
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.dividend_pool, (v3 as u64)), arg3), v2);
            let v12 = DividendsClaimed{
                player : v2,
                amount : (v3 as u64),
            };
            0x2::event::emit<DividendsClaimed>(v12);
        };
        let v13 = KeyBought{
            buyer        : v2,
            keys_bought  : 1,
            price_paid   : v1,
            time_added   : v8,
            new_end_time : arg0.end_time_ms,
            total_pot    : 0x2::balance::value<0x2::sui::SUI>(&arg0.pot),
        };
        0x2::event::emit<KeyBought>(v13);
    }

    public entry fun claim_dividends(arg0: &mut Game, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::table::contains<address, Player>(&arg0.players, v0), 0);
        let v1 = 0x2::table::borrow_mut<address, Player>(&mut arg0.players, v0);
        let v2 = (v1.keys_held as u128) * arg0.acc_sui_per_share / 1000000000000 - v1.reward_debt;
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.dividend_pool, (v2 as u64)), arg1), v0);
            v1.reward_debt = (v1.keys_held as u128) * arg0.acc_sui_per_share / 1000000000000;
            let v3 = DividendsClaimed{
                player : v0,
                amount : (v2 as u64),
            };
            0x2::event::emit<DividendsClaimed>(v3);
        };
    }

    public entry fun claim_jackpot(arg0: &mut Game, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.end_time_ms, 1);
        assert!(arg0.game_active, 0);
        assert!(0x1::option::is_some<address>(&arg0.last_buyer), 0);
        let v0 = *0x1::option::borrow<address>(&arg0.last_buyer);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.pot), arg2), v0);
        arg0.game_active = false;
        let v1 = Winner{
            winner  : v0,
            jackpot : 0x2::balance::value<0x2::sui::SUI>(&arg0.pot),
        };
        0x2::event::emit<Winner>(v1);
    }

    public fun get_end_time(arg0: &Game) : u64 {
        arg0.end_time_ms
    }

    public fun get_pot(arg0: &Game) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.pot)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::vec_set::singleton<address>(0x2::tx_context::sender(arg0));
        0x2::vec_set::insert<address>(&mut v0, @0xb9791ede298875ba43fc1eb8703da6a5bd5ad8f5647d0e2ca36aa86f45935e0b);
        let v1 = Game{
            id                : 0x2::object::new(arg0),
            pot               : 0x2::balance::zero<0x2::sui::SUI>(),
            dividend_pool     : 0x2::balance::zero<0x2::sui::SUI>(),
            admin_balance     : 0x2::balance::zero<0x2::sui::SUI>(),
            end_time_ms       : 0,
            current_key_price : 1000000000,
            price_increment   : 50000000,
            total_keys_sold   : 0,
            last_buyer        : 0x1::option::none<address>(),
            acc_sui_per_share : 0,
            players           : 0x2::table::new<address, Player>(arg0),
            game_active       : true,
            admins            : v0,
        };
        0x2::transfer::share_object<Game>(v1);
    }

    // decompiled from Move bytecode v6
}

