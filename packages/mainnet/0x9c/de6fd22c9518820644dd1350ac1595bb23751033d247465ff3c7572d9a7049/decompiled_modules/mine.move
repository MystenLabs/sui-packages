module 0x9cde6fd22c9518820644dd1350ac1595bb23751033d247465ff3c7572d9a7049::mine {
    struct Config has key {
        id: 0x2::object::UID,
        version: u8,
        bus_count: u64,
        treasury: 0xbafd431cc9362367d02dc2752216782a265216af069d70a7679de5f38c0d62ca::locker::Locker<MINE>,
        last_difficulty_adjustment: u64,
        total_rewards: u64,
        total_hashes: u64,
    }

    struct Bus has key {
        id: 0x2::object::UID,
        version: u8,
        live: bool,
        difficulty: u8,
        reward_rate: u64,
        last_reset: u64,
        rewards: 0x2::balance::Balance<MINE>,
        epoch_hashes: u64,
    }

    struct MINE has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun mine(arg0: u64, arg1: &mut Bus, arg2: &mut 0x9cde6fd22c9518820644dd1350ac1595bb23751033d247465ff3c7572d9a7049::miner::Miner, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<MINE> {
        if (!arg1.live) {
            let v0 = 0x2::balance::withdraw_all<MINE>(&mut arg1.rewards);
            let v1 = 0x2::balance::value<MINE>(&v0);
            if (v1 == 0) {
                abort 4007
            };
            0x9cde6fd22c9518820644dd1350ac1595bb23751033d247465ff3c7572d9a7049::miner::record_rewards(arg2, v1);
            return 0x2::coin::from_balance<MINE>(v0, arg4)
        };
        let v2 = 0x2::clock::timestamp_ms(arg3);
        assert!(v2 < arg1.last_reset + 60000, 4002);
        assert!(0x2::balance::value<MINE>(&arg1.rewards) >= arg1.reward_rate, 4001);
        let v3 = generate_proof(0x9cde6fd22c9518820644dd1350ac1595bb23751033d247465ff3c7572d9a7049::miner::current_hash(arg2), 0x2::tx_context::sender(arg4), arg0);
        validate_proof(v3, arg1.difficulty);
        let v4 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v4, v3);
        0x1::vector::append<u8>(&mut v4, 0x2::bcs::to_bytes<u64>(&v2));
        let v5 = 0x2::tx_context::fresh_object_address(arg4);
        0x1::vector::append<u8>(&mut v4, 0x2::bcs::to_bytes<address>(&v5));
        *0x9cde6fd22c9518820644dd1350ac1595bb23751033d247465ff3c7572d9a7049::miner::current_hash_mut(arg2) = 0x2::hash::keccak256(&v4);
        0x9cde6fd22c9518820644dd1350ac1595bb23751033d247465ff3c7572d9a7049::miner::record_hash(arg2);
        0x9cde6fd22c9518820644dd1350ac1595bb23751033d247465ff3c7572d9a7049::miner::record_rewards(arg2, arg1.reward_rate);
        arg1.epoch_hashes = arg1.epoch_hashes + 1;
        0x2::coin::from_balance<MINE>(0x2::balance::split<MINE>(&mut arg1.rewards, arg1.reward_rate), arg4)
    }

    fun calculate_difficulty(arg0: u64) : u8 {
        let v0 = 0;
        let v1 = 0;
        loop {
            v1 = v1 + 1000000000 * 0x2::math::pow(2, v0);
            if (v1 >= 21000000000000000) {
                break
            };
            if (arg0 >= v1) {
                v0 = v0 + 1;
            } else {
                break
            };
        };
        3 + v0
    }

    fun calculate_new_reward_rate(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = 2;
        if (arg1 == 0) {
            return arg0
        };
        0x2::math::min(0x2::math::max(0x2::math::max(arg0 / v0, 0x2::math::min(arg0 * v0, arg0 * 1000000000 / arg1)), 1), arg2)
    }

    public fun difficulty(arg0: &Bus) : u8 {
        arg0.difficulty
    }

    public fun epoch_reset(arg0: &mut Config, arg1: vector<Bus>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<Bus>(&arg1) == arg0.bus_count, 4005);
        assert!(0x1::vector::borrow<Bus>(&arg1, 0).live, 4007);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 >= 0xbafd431cc9362367d02dc2752216782a265216af069d70a7679de5f38c0d62ca::locker::unlock_start_ts_sec<MINE>(&arg0.treasury) * 1000, 4008);
        assert!(v0 > 0x1::vector::borrow<Bus>(&arg1, 0).last_reset + 60000, 4003);
        let v1 = 0;
        let v2 = 0;
        while (v2 < arg0.bus_count) {
            v1 = v1 + 0x1::vector::borrow<Bus>(&arg1, v2).epoch_hashes;
            v2 = v2 + 1;
        };
        let v3 = 2000000000 / arg0.bus_count;
        let v4 = 0;
        let v5 = 0;
        let v6 = 0x2::balance::zero<MINE>();
        while (v5 < arg0.bus_count) {
            let v7 = 0x2::balance::withdraw_all<MINE>(&mut 0x1::vector::borrow_mut<Bus>(&mut arg1, v5).rewards);
            v4 = v4 + v3 - 0x2::balance::value<MINE>(&v7);
            0x2::balance::join<MINE>(&mut v6, v7);
            v5 = v5 + 1;
        };
        0x2::balance::join<MINE>(&mut v6, 0xbafd431cc9362367d02dc2752216782a265216af069d70a7679de5f38c0d62ca::locker::withdraw_all<MINE>(&mut arg0.treasury, arg2));
        arg0.total_hashes = arg0.total_hashes + v1;
        arg0.total_rewards = arg0.total_rewards + v4;
        if (0x2::balance::value<MINE>(&v6) >= 2000000000) {
            let v8 = calculate_difficulty(arg0.total_hashes);
            let v9 = difficulty(0x1::vector::borrow<Bus>(&arg1, 0)) != v8;
            if (v9) {
                arg0.last_difficulty_adjustment = v0;
            };
            while (!0x1::vector::is_empty<Bus>(&arg1)) {
                let v10 = 0x1::vector::pop_back<Bus>(&mut arg1);
                0x2::balance::join<MINE>(&mut v10.rewards, 0x2::balance::split<MINE>(&mut v6, v3));
                v10.last_reset = v0;
                v10.reward_rate = calculate_new_reward_rate(reward_rate(0x1::vector::borrow<Bus>(&arg1, 0)), v4, v3);
                v10.epoch_hashes = 0;
                if (v9) {
                    v10.difficulty = v8;
                };
                0x2::transfer::share_object<Bus>(v10);
            };
            0xbafd431cc9362367d02dc2752216782a265216af069d70a7679de5f38c0d62ca::locker::top_up<MINE>(&mut arg0.treasury, 0x2::balance::withdraw_all<MINE>(&mut v6), arg2);
        } else {
            assert!(0xbafd431cc9362367d02dc2752216782a265216af069d70a7679de5f38c0d62ca::locker::remaining_unlock<MINE>(&arg0.treasury, arg2) == 0, 4006);
            0x2::balance::join<MINE>(&mut v6, 0xbafd431cc9362367d02dc2752216782a265216af069d70a7679de5f38c0d62ca::locker::skim_extraneous_balance<MINE>(&mut arg0.treasury));
            arg0.total_rewards = arg0.total_rewards + 0x2::balance::value<MINE>(&v6);
            0x2::balance::join<MINE>(&mut 0x1::vector::borrow_mut<Bus>(&mut arg1, 0).rewards, 0x2::balance::withdraw_all<MINE>(&mut v6));
            while (!0x1::vector::is_empty<Bus>(&arg1)) {
                let v11 = 0x1::vector::pop_back<Bus>(&mut arg1);
                v11.live = false;
                0x2::transfer::share_object<Bus>(v11);
            };
        };
        0x2::balance::destroy_zero<MINE>(v6);
        0x1::vector::destroy_empty<Bus>(arg1);
    }

    fun generate_proof(arg0: vector<u8>, arg1: address, arg2: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, arg0);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg2));
        0x2::hash::keccak256(&v0)
    }

    fun init(arg0: MINE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MINE>(arg0, 9, b"MINE", b"Mineral", b"Algorithmic resource mining.", 0x1::option::some<0x2::url::Url>(0x9cde6fd22c9518820644dd1350ac1595bb23751033d247465ff3c7572d9a7049::icon::get_icon_url()), arg1);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0x2::coin::into_balance<MINE>(0x2::coin::mint<MINE>(&mut v3, 21000000000000000, arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MINE>>(v3, 0x2::object::id_address<0x2::coin::CoinMetadata<MINE>>(&v2));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MINE>>(v2);
        let v5 = 0x2::balance::split<MINE>(&mut v4, 2000000000);
        let v6 = 0;
        while (v6 < 8) {
            let v7 = Bus{
                id           : 0x2::object::new(arg1),
                version      : 0,
                live         : true,
                difficulty   : 3,
                reward_rate  : 1000000000 / 1000000,
                last_reset   : 0,
                rewards      : 0x2::balance::split<MINE>(&mut v5, 2000000000 / 8),
                epoch_hashes : 0,
            };
            0x2::transfer::share_object<Bus>(v7);
            v6 = v6 + 1;
        };
        0x2::balance::destroy_zero<MINE>(v5);
        let v8 = 0x2::tx_context::epoch_timestamp_ms(arg1);
        let v9 = Config{
            id                         : 0x2::object::new(arg1),
            version                    : 0,
            bus_count                  : 8,
            treasury                   : 0xbafd431cc9362367d02dc2752216782a265216af069d70a7679de5f38c0d62ca::locker::create<MINE>(v4, (v8 + 86400000) / 1000, (2000000000 + 60 - 2000000000 % 60) / 60),
            last_difficulty_adjustment : v8,
            total_rewards              : 0,
            total_hashes               : 0,
        };
        0x2::transfer::share_object<Config>(v9);
        let v10 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v10, 0x2::tx_context::sender(arg1));
    }

    public fun live(arg0: &Bus) : bool {
        arg0.live
    }

    public fun reward_rate(arg0: &Bus) : u64 {
        arg0.reward_rate
    }

    public fun rewards(arg0: &Bus) : &0x2::balance::Balance<MINE> {
        &arg0.rewards
    }

    public fun total_hashes(arg0: &Config) : u64 {
        arg0.total_hashes
    }

    public fun total_rewards(arg0: &Config) : u64 {
        arg0.total_rewards
    }

    public fun treasury(arg0: &Config) : &0xbafd431cc9362367d02dc2752216782a265216af069d70a7679de5f38c0d62ca::locker::Locker<MINE> {
        &arg0.treasury
    }

    fun validate_proof(arg0: vector<u8>, arg1: u8) {
        if (arg1 < 1) {
            abort 4004
        };
        let v0 = 0;
        while (v0 < arg1) {
            let v1 = 0;
            assert!(0x1::vector::borrow<u8>(&arg0, (v0 as u64)) == &v1, 4004);
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

