module 0x1ac6f5b29768a209175a1cb907c631ca69eebfb686faeb16abaf37756df650dc::marktranet_game {
    struct GameResult has copy, drop {
        player_health: u64,
        monster_health: u64,
        result: 0x1::string::String,
        reward_gold: u64,
        reward_exp: u64,
    }

    struct Game<phantom T0> has key {
        id: 0x2::object::UID,
        pool: 0x2::balance::Balance<T0>,
        ticket: u64,
        reward: u64,
        player_health: u64,
        player_attack: u64,
        player_defense: u64,
        player_gold: u64,
        player_exp: u64,
    }

    struct Monster has copy, drop {
        health: u64,
        attack: u64,
        defense: u64,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public entry fun buy_potion<T0>(arg0: &mut Game<T0>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.player_gold >= arg1, 1);
        arg0.player_gold = arg0.player_gold - arg1;
        arg0.player_health = arg0.player_health + arg2;
    }

    fun calculate_damage(arg0: u64, arg1: u64) : u64 {
        if (arg0 > arg1) {
            arg0 - arg1
        } else {
            1
        }
    }

    entry fun create_game<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Game<T0>{
            id             : 0x2::object::new(arg0),
            pool           : 0x2::balance::zero<T0>(),
            ticket         : 1000,
            reward         : 2000,
            player_health  : 100,
            player_attack  : 10,
            player_defense : 5,
            player_gold    : 50,
            player_exp     : 0,
        };
        0x2::transfer::share_object<Game<T0>>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun deposit<T0>(arg0: &mut Game<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 >= arg2, 1);
        let v1 = 0x2::coin::into_balance<T0>(arg1);
        if (v0 > arg2) {
            0x2::balance::join<T0>(&mut arg0.pool, 0x2::balance::split<T0>(&mut v1, arg2));
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v1, arg3), 0x2::tx_context::sender(arg3));
        } else {
            0x2::balance::join<T0>(&mut arg0.pool, v1);
        };
    }

    public entry fun explore<T0>(arg0: &mut Game<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<T0>(&arg0.pool) >= arg0.reward - arg0.ticket, 1);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 >= arg0.ticket, 2);
        let v1 = 0x2::coin::into_balance<T0>(arg1);
        if (v0 > arg0.ticket) {
            0x2::balance::join<T0>(&mut arg0.pool, 0x2::balance::split<T0>(&mut v1, arg0.ticket));
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v1, arg3), 0x2::tx_context::sender(arg3));
        } else {
            0x2::balance::join<T0>(&mut arg0.pool, v1);
        };
        let v2 = get_random_monster(arg2);
        let v3 = arg0.player_health;
        let v4 = v2.health;
        while (v3 > 0 && v4 > 0) {
            let v5 = calculate_damage(arg0.player_attack, v2.defense);
            let v6 = calculate_damage(v2.attack, arg0.player_defense);
            if (v5 >= v4) {
                v4 = 0;
            } else {
                v4 = v4 - v5;
            };
            if (v6 >= v3) {
                v3 = 0;
                continue
            };
            v3 = v3 - v6;
        };
        let (v7, v8, v9) = if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.pool, arg0.reward), arg3), 0x2::tx_context::sender(arg3));
            arg0.player_gold = arg0.player_gold + 20;
            arg0.player_exp = arg0.player_exp + 10;
            (0x1::string::utf8(b"Victory"), 20, 10)
        } else {
            (0x1::string::utf8(b"Defeat"), 0, 0)
        };
        arg0.player_health = v3;
        let v10 = GameResult{
            player_health  : v3,
            monster_health : v4,
            result         : v7,
            reward_gold    : v8,
            reward_exp     : v9,
        };
        0x2::event::emit<GameResult>(v10);
    }

    fun get_random_monster(arg0: &0x2::clock::Clock) : Monster {
        let v0 = (0x2::clock::timestamp_ms(arg0) as u64);
        Monster{
            health  : v0 % 50 + 50,
            attack  : v0 % 10 + 5,
            defense : v0 % 5 + 2,
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun withdraw<T0>(arg0: &AdminCap, arg1: &mut Game<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.pool, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

