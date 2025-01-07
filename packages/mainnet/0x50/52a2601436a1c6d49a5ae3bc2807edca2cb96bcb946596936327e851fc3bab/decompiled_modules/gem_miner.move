module 0x5052a2601436a1c6d49a5ae3bc2807edca2cb96bcb946596936327e851fc3bab::gem_miner {
    struct GameState has key {
        id: 0x2::object::UID,
        initialized: bool,
        ceo_address: address,
        market_eggs: u64,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        admin_fees: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct MinerInfo has store {
        hatchery_miners: u64,
        claimed_eggs: u64,
        last_hatch: u64,
        withdrawed: u64,
        current_deposit: u64,
        current_withdrawn: u64,
    }

    public entry fun buy_gems(arg0: &mut GameState, arg1: &mut 0x5052a2601436a1c6d49a5ae3bc2807edca2cb96bcb946596936327e851fc3bab::player_registry::Registry, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        0x5052a2601436a1c6d49a5ae3bc2807edca2cb96bcb946596936327e851fc3bab::player_registry::register_player(arg1, v0, arg3, arg4);
        0x5052a2601436a1c6d49a5ae3bc2807edca2cb96bcb946596936327e851fc3bab::player_registry::update_deposit(arg1, v0, v1);
        let v2 = if (0x5052a2601436a1c6d49a5ae3bc2807edca2cb96bcb946596936327e851fc3bab::player_registry::is_valid_referrer(arg1, arg3)) {
            let v3 = 0x5052a2601436a1c6d49a5ae3bc2807edca2cb96bcb946596936327e851fc3bab::player_registry::get_player_address(arg1, arg3);
            if (v3 == v0) {
                arg0.ceo_address
            } else {
                v3
            }
        } else {
            arg0.ceo_address
        };
        let v4 = v1 * 8 / 100;
        let v5 = v1 - v4 - v1 * 15 / 100;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.admin_fees, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v4, arg5)));
        if (v2 == arg0.ceo_address) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.admin_fees, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        } else {
            0x5052a2601436a1c6d49a5ae3bc2807edca2cb96bcb946596936327e851fc3bab::player_registry::add_referral_reward(arg1, v2, arg2, arg4);
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v5, arg5)));
        let v6 = calculate_egg_buy(v5, 0x2::balance::value<0x2::sui::SUI>(&arg0.balance), arg0.market_eggs);
        if (!0x2::dynamic_field::exists_<address>(&arg0.id, v0)) {
            let v7 = MinerInfo{
                hatchery_miners   : 0,
                claimed_eggs      : 0,
                last_hatch        : 0x2::clock::timestamp_ms(arg4),
                withdrawed        : 0,
                current_deposit   : v5,
                current_withdrawn : 0,
            };
            0x2::dynamic_field::add<address, MinerInfo>(&mut arg0.id, v0, v7);
        } else {
            let v8 = 0x2::dynamic_field::borrow_mut<address, MinerInfo>(&mut arg0.id, v0);
            if (v8.current_withdrawn >= v8.current_deposit * 300 / 100) {
                v8.current_deposit = v5;
                v8.current_withdrawn = 0;
                v8.hatchery_miners = 0;
                v8.claimed_eggs = 0;
                v8.last_hatch = 0x2::clock::timestamp_ms(arg4);
            } else {
                v8.current_deposit = v8.current_deposit + v5;
            };
        };
        let v9 = 0x2::dynamic_field::borrow_mut<address, MinerInfo>(&mut arg0.id, v0);
        v9.hatchery_miners = v9.hatchery_miners + v6 / 1080000;
        v9.claimed_eggs = 0;
        v9.last_hatch = 0x2::clock::timestamp_ms(arg4);
        arg0.market_eggs = arg0.market_eggs + v6 / 5;
    }

    fun calculate_egg_buy(arg0: u64, arg1: u64, arg2: u64) : u64 {
        calculate_trade(arg0, arg1, arg2)
    }

    fun calculate_egg_sell(arg0: u64, arg1: u64, arg2: u64) : u64 {
        calculate_trade(arg0, arg2, arg1)
    }

    fun calculate_trade(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg0 == 0) {
            return 0
        };
        10000 * arg2 / (5000 + (10000 * arg1 + 5000 * arg0) / arg0)
    }

    fun get_eggs_since_last_hatch(arg0: &MinerInfo, arg1: &0x2::clock::Clock) : u64 {
        let v0 = if ((0x2::clock::timestamp_ms(arg1) - arg0.last_hatch) / 1000 > 1080000) {
            1080000
        } else {
            (0x2::clock::timestamp_ms(arg1) - arg0.last_hatch) / 1000
        };
        if (arg0.current_deposit > 0 && arg0.current_withdrawn >= arg0.current_deposit * 300 / 100) {
            0
        } else {
            v0 * arg0.hatchery_miners
        }
    }

    public fun get_game_state(arg0: &GameState) : (bool, u64, u64, u64) {
        (arg0.initialized, arg0.market_eggs, 0x2::balance::value<0x2::sui::SUI>(&arg0.balance), 0x2::balance::value<0x2::sui::SUI>(&arg0.admin_fees))
    }

    public fun get_miner_info(arg0: &GameState, arg1: address) : (u64, u64, u64, u64, u64) {
        assert!(0x2::dynamic_field::exists_<address>(&arg0.id, arg1), 2);
        let v0 = 0x2::dynamic_field::borrow<address, MinerInfo>(&arg0.id, arg1);
        (v0.current_deposit, v0.withdrawed, v0.hatchery_miners, v0.claimed_eggs, v0.current_withdrawn)
    }

    fun get_my_eggs(arg0: &MinerInfo, arg1: &0x2::clock::Clock) : u64 {
        arg0.claimed_eggs + get_eggs_since_last_hatch(arg0, arg1)
    }

    public entry fun hire_miners(arg0: &mut GameState, arg1: &mut 0x5052a2601436a1c6d49a5ae3bc2807edca2cb96bcb946596936327e851fc3bab::player_registry::Registry, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::dynamic_field::exists_<address>(&arg0.id, v0), 2);
        let v1 = get_my_eggs(0x2::dynamic_field::borrow<address, MinerInfo>(&arg0.id, v0), arg2);
        let v2 = if (v1 == 0) {
            0
        } else {
            v1 / 1080000
        };
        let v3 = 0x5052a2601436a1c6d49a5ae3bc2807edca2cb96bcb946596936327e851fc3bab::player_registry::get_player_id(arg1, v0);
        let v4 = if (v3 != 0) {
            0x5052a2601436a1c6d49a5ae3bc2807edca2cb96bcb946596936327e851fc3bab::player_registry::get_player_address(arg1, v3)
        } else {
            arg0.ceo_address
        };
        let v5 = calculate_egg_sell(v1, 0x2::balance::value<0x2::sui::SUI>(&arg0.balance), arg0.market_eggs) * 1 / 100;
        if (v5 > 0) {
            0x5052a2601436a1c6d49a5ae3bc2807edca2cb96bcb946596936327e851fc3bab::player_registry::add_referral_reward(arg1, v4, 0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, v5, arg3), arg2);
        };
        let v6 = 0x2::dynamic_field::borrow_mut<address, MinerInfo>(&mut arg0.id, v0);
        v6.hatchery_miners = v6.hatchery_miners + v2;
        v6.claimed_eggs = 0;
        v6.last_hatch = 0x2::clock::timestamp_ms(arg2);
        arg0.market_eggs = arg0.market_eggs + v1 / 5;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GameState{
            id          : 0x2::object::new(arg0),
            initialized : true,
            ceo_address : 0x2::tx_context::sender(arg0),
            market_eggs : 108000000000,
            balance     : 0x2::balance::zero<0x2::sui::SUI>(),
            admin_fees  : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<GameState>(v0);
    }

    public entry fun sell_gems(arg0: &mut GameState, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::dynamic_field::exists_<address>(&arg0.id, v0), 2);
        let v1 = get_my_eggs(0x2::dynamic_field::borrow<address, MinerInfo>(&arg0.id, v0), arg1);
        let v2 = calculate_egg_sell(v1, 0x2::balance::value<0x2::sui::SUI>(&arg0.balance), arg0.market_eggs);
        let v3 = v2 * 8 / 100;
        let v4 = v2 - v3;
        assert!(v4 > 0, 3);
        let v5 = 0x2::dynamic_field::borrow_mut<address, MinerInfo>(&mut arg0.id, v0);
        v5.claimed_eggs = 0;
        v5.last_hatch = 0x2::clock::timestamp_ms(arg1);
        v5.withdrawed = v5.withdrawed + v4;
        v5.current_withdrawn = v5.current_withdrawn + v4;
        arg0.market_eggs = arg0.market_eggs + v1;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.admin_fees, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, v3, arg2)));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, v4, arg2), v0);
    }

    public entry fun withdraw_admin_fees(arg0: &mut GameState, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.ceo_address, 1);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.admin_fees);
        assert!(v0 > 0, 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.admin_fees, v0), arg1), arg0.ceo_address);
    }

    // decompiled from Move bytecode v6
}

