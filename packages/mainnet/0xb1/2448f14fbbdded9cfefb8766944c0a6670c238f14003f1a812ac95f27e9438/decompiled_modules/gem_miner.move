module 0xb12448f14fbbdded9cfefb8766944c0a6670c238f14003f1a812ac95f27e9438::gem_miner {
    struct GemsBought has copy, drop {
        player: address,
        amount: u64,
        miners: u64,
        referrer: address,
        timestamp: u64,
    }

    struct GemsSold has copy, drop {
        player: address,
        eggs: u64,
        amount: u64,
        timestamp: u64,
    }

    struct MinersHired has copy, drop {
        player: address,
        new_miners: u64,
        eggs_used: u64,
        timestamp: u64,
    }

    struct GameState has key {
        id: 0x2::object::UID,
        initialized: bool,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        market_eggs: u64,
    }

    public entry fun buy_gems(arg0: &mut GameState, arg1: &mut 0xb12448f14fbbdded9cfefb8766944c0a6670c238f14003f1a812ac95f27e9438::player_registry::Registry, arg2: &mut 0xb12448f14fbbdded9cfefb8766944c0a6670c238f14003f1a812ac95f27e9438::player_registry::AdminInfo, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        let v2 = v1 * 8 / 100;
        let v3 = if (arg4 != 0) {
            v1 * 15 / 100
        } else {
            0
        };
        let v4 = v1 - v2 - v3;
        0xb12448f14fbbdded9cfefb8766944c0a6670c238f14003f1a812ac95f27e9438::player_registry::add_admin_balance(arg2, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg3, v2, arg6)));
        0xb12448f14fbbdded9cfefb8766944c0a6670c238f14003f1a812ac95f27e9438::player_registry::register_player(arg1, v0, arg4, arg5);
        0xb12448f14fbbdded9cfefb8766944c0a6670c238f14003f1a812ac95f27e9438::player_registry::update_deposit(arg1, v0, v1);
        let v5 = calculate_egg_buy(v4, 0x2::balance::value<0x2::sui::SUI>(&arg0.balance), arg0.market_eggs);
        let v6 = v5 / 1180000;
        if (v3 > 0 && 0xb12448f14fbbdded9cfefb8766944c0a6670c238f14003f1a812ac95f27e9438::player_registry::is_valid_referrer(arg1, arg4)) {
            let v7 = 0xb12448f14fbbdded9cfefb8766944c0a6670c238f14003f1a812ac95f27e9438::player_registry::get_player_address(arg1, arg4);
            if (v7 != v0) {
                0xb12448f14fbbdded9cfefb8766944c0a6670c238f14003f1a812ac95f27e9438::player_registry::add_referral_reward(arg1, v7, 0x2::coin::split<0x2::sui::SUI>(&mut arg3, v3, arg6), arg5);
            } else {
                0xb12448f14fbbdded9cfefb8766944c0a6670c238f14003f1a812ac95f27e9438::player_registry::add_admin_balance(arg2, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg3, v3, arg6)));
            };
        } else {
            0xb12448f14fbbdded9cfefb8766944c0a6670c238f14003f1a812ac95f27e9438::player_registry::add_admin_balance(arg2, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg3, v3, arg6)));
        };
        0x2::transfer::public_transfer<0xb12448f14fbbdded9cfefb8766944c0a6670c238f14003f1a812ac95f27e9438::nft::MinerNFT>(0xb12448f14fbbdded9cfefb8766944c0a6670c238f14003f1a812ac95f27e9438::nft::mint_nft(v4, v6, arg6), v0);
        arg0.market_eggs = arg0.market_eggs + v5 / 5;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg3));
        let v8 = if (arg4 != 0) {
            0xb12448f14fbbdded9cfefb8766944c0a6670c238f14003f1a812ac95f27e9438::player_registry::get_player_address(arg1, arg4)
        } else {
            @0x0
        };
        let v9 = GemsBought{
            player    : v0,
            amount    : v4,
            miners    : v6,
            referrer  : v8,
            timestamp : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<GemsBought>(v9);
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

    fun get_eggs_since_last_hatch(arg0: &0xb12448f14fbbdded9cfefb8766944c0a6670c238f14003f1a812ac95f27e9438::nft::MinerNFT, arg1: &0x2::clock::Clock) : u64 {
        let v0 = if ((0x2::clock::timestamp_ms(arg1) - 0xb12448f14fbbdded9cfefb8766944c0a6670c238f14003f1a812ac95f27e9438::nft::get_last_hatch(arg0)) / 1000 > 1180000) {
            1180000
        } else {
            (0x2::clock::timestamp_ms(arg1) - 0xb12448f14fbbdded9cfefb8766944c0a6670c238f14003f1a812ac95f27e9438::nft::get_last_hatch(arg0)) / 1000
        };
        if (0xb12448f14fbbdded9cfefb8766944c0a6670c238f14003f1a812ac95f27e9438::nft::get_current_deposit(arg0) > 0 && 0xb12448f14fbbdded9cfefb8766944c0a6670c238f14003f1a812ac95f27e9438::nft::get_current_withdrawn(arg0) >= 0xb12448f14fbbdded9cfefb8766944c0a6670c238f14003f1a812ac95f27e9438::nft::get_current_deposit(arg0) * 300 / 100) {
            0
        } else {
            v0 * 0xb12448f14fbbdded9cfefb8766944c0a6670c238f14003f1a812ac95f27e9438::nft::get_hatchery_miners(arg0)
        }
    }

    fun get_my_eggs(arg0: &0xb12448f14fbbdded9cfefb8766944c0a6670c238f14003f1a812ac95f27e9438::nft::MinerNFT, arg1: &0x2::clock::Clock) : u64 {
        0xb12448f14fbbdded9cfefb8766944c0a6670c238f14003f1a812ac95f27e9438::nft::get_claimed_eggs(arg0) + get_eggs_since_last_hatch(arg0, arg1)
    }

    public entry fun hire_miners(arg0: &mut GameState, arg1: &mut 0xb12448f14fbbdded9cfefb8766944c0a6670c238f14003f1a812ac95f27e9438::player_registry::Registry, arg2: &mut 0xb12448f14fbbdded9cfefb8766944c0a6670c238f14003f1a812ac95f27e9438::nft::MinerNFT, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0xb12448f14fbbdded9cfefb8766944c0a6670c238f14003f1a812ac95f27e9438::nft::get_creator(arg2) == v0, 5);
        let v1 = get_my_eggs(arg2, arg3);
        let v2 = if (v1 == 0) {
            0
        } else {
            v1 / 1180000
        };
        let v3 = calculate_egg_sell(v1, 0x2::balance::value<0x2::sui::SUI>(&arg0.balance), arg0.market_eggs) * 1 / 100;
        if (v3 > 0) {
            if (0xb12448f14fbbdded9cfefb8766944c0a6670c238f14003f1a812ac95f27e9438::player_registry::get_player_id(arg1, v0) != 0) {
                0xb12448f14fbbdded9cfefb8766944c0a6670c238f14003f1a812ac95f27e9438::player_registry::add_referral_reward(arg1, v0, 0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, v3, arg4), arg3);
            };
        };
        0xb12448f14fbbdded9cfefb8766944c0a6670c238f14003f1a812ac95f27e9438::nft::add_miners(arg2, v2);
        0xb12448f14fbbdded9cfefb8766944c0a6670c238f14003f1a812ac95f27e9438::nft::reset_claimed_eggs(arg2);
        0xb12448f14fbbdded9cfefb8766944c0a6670c238f14003f1a812ac95f27e9438::nft::set_last_hatch(arg2, 0x2::clock::timestamp_ms(arg3));
        0xb12448f14fbbdded9cfefb8766944c0a6670c238f14003f1a812ac95f27e9438::nft::increment_reinvest_count(arg2);
        arg0.market_eggs = arg0.market_eggs + v1 / 5;
        let v4 = MinersHired{
            player     : v0,
            new_miners : v2,
            eggs_used  : v1,
            timestamp  : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<MinersHired>(v4);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GameState{
            id          : 0x2::object::new(arg0),
            initialized : true,
            balance     : 0x2::balance::zero<0x2::sui::SUI>(),
            market_eggs : 118000000000,
        };
        0x2::transfer::share_object<GameState>(v0);
    }

    public entry fun sell_gems(arg0: &mut GameState, arg1: &mut 0xb12448f14fbbdded9cfefb8766944c0a6670c238f14003f1a812ac95f27e9438::player_registry::AdminInfo, arg2: &mut 0xb12448f14fbbdded9cfefb8766944c0a6670c238f14003f1a812ac95f27e9438::nft::MinerNFT, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0xb12448f14fbbdded9cfefb8766944c0a6670c238f14003f1a812ac95f27e9438::nft::get_creator(arg2) == v0, 5);
        let v1 = get_my_eggs(arg2, arg3);
        let v2 = calculate_egg_sell(v1, 0x2::balance::value<0x2::sui::SUI>(&arg0.balance), arg0.market_eggs);
        let v3 = v2 * 8 / 100;
        let v4 = v2 - v3;
        assert!(v4 > 0, 3);
        0xb12448f14fbbdded9cfefb8766944c0a6670c238f14003f1a812ac95f27e9438::nft::reset_claimed_eggs(arg2);
        0xb12448f14fbbdded9cfefb8766944c0a6670c238f14003f1a812ac95f27e9438::nft::set_last_hatch(arg2, 0x2::clock::timestamp_ms(arg3));
        0xb12448f14fbbdded9cfefb8766944c0a6670c238f14003f1a812ac95f27e9438::nft::add_withdrawn(arg2, v4);
        arg0.market_eggs = arg0.market_eggs + v1;
        0xb12448f14fbbdded9cfefb8766944c0a6670c238f14003f1a812ac95f27e9438::player_registry::add_admin_balance(arg1, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, v3, arg4)));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, v4, arg4), v0);
        let v5 = GemsSold{
            player    : v0,
            eggs      : v1,
            amount    : v4,
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<GemsSold>(v5);
    }

    // decompiled from Move bytecode v6
}

