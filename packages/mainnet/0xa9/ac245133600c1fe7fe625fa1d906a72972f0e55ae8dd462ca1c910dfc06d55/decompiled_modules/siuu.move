module 0xa9ac245133600c1fe7fe625fa1d906a72972f0e55ae8dd462ca1c910dfc06d55::siuu {
    struct Config has key {
        id: 0x2::object::UID,
        version: u8,
        bus_count: u64,
        treasury: 0xa9ac245133600c1fe7fe625fa1d906a72972f0e55ae8dd462ca1c910dfc06d55::locker::Locker<SIUU>,
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
        rewards: 0x2::balance::Balance<SIUU>,
        epoch_hashes: u64,
    }

    struct SIUU has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    fun calculate_difficulty(arg0: u64) : u8 {
        let v0 = 0;
        let v1 = 0;
        loop {
            v1 = v1 + 1000000000 * 0x2::math::pow(2, v0);
            if (v1 >= 2100000000000000000) {
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
        0x2::math::min(0x2::math::max(0x2::math::max(arg0 / v0, 0x2::math::min(arg0 * v0, 97222000000000 / arg1 * arg0)), 1), arg2)
    }

    public fun difficulty(arg0: &Bus) : u8 {
        arg0.difficulty
    }

    public fun epoch_reset(arg0: &mut Config, arg1: vector<Bus>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<Bus>(&arg1) == arg0.bus_count, 4005);
        assert!(0x1::vector::borrow<Bus>(&arg1, 0).live, 4007);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 >= 0xa9ac245133600c1fe7fe625fa1d906a72972f0e55ae8dd462ca1c910dfc06d55::locker::unlock_start_ts_sec<SIUU>(&arg0.treasury) * 1000, 4008);
        assert!(v0 > 0x1::vector::borrow<Bus>(&arg1, 0).last_reset + 60000, 4003);
        let v1 = 0;
        let v2 = 0;
        while (v2 < arg0.bus_count) {
            v1 = v1 + 0x1::vector::borrow<Bus>(&arg1, v2).epoch_hashes;
            v2 = v2 + 1;
        };
        let v3 = 194444000000000 / arg0.bus_count;
        let v4 = 0;
        let v5 = 0;
        let v6 = 0x2::balance::zero<SIUU>();
        while (v5 < arg0.bus_count) {
            let v7 = 0x2::balance::withdraw_all<SIUU>(&mut 0x1::vector::borrow_mut<Bus>(&mut arg1, v5).rewards);
            v4 = v4 + v3 - 0x2::balance::value<SIUU>(&v7);
            0x2::balance::join<SIUU>(&mut v6, v7);
            v5 = v5 + 1;
        };
        0x2::balance::join<SIUU>(&mut v6, 0xa9ac245133600c1fe7fe625fa1d906a72972f0e55ae8dd462ca1c910dfc06d55::locker::withdraw_all<SIUU>(&mut arg0.treasury, arg2));
        arg0.total_hashes = arg0.total_hashes + v1;
        arg0.total_rewards = arg0.total_rewards + v4;
        if (0x2::balance::value<SIUU>(&v6) >= 194444000000000) {
            let v8 = calculate_difficulty(arg0.total_hashes);
            let v9 = difficulty(0x1::vector::borrow<Bus>(&arg1, 0)) != v8;
            if (v9) {
                arg0.last_difficulty_adjustment = v0;
            };
            while (!0x1::vector::is_empty<Bus>(&arg1)) {
                let v10 = 0x1::vector::pop_back<Bus>(&mut arg1);
                0x2::balance::join<SIUU>(&mut v10.rewards, 0x2::balance::split<SIUU>(&mut v6, v3));
                v10.last_reset = v0;
                v10.reward_rate = calculate_new_reward_rate(reward_rate(0x1::vector::borrow<Bus>(&arg1, 0)), v4, v3);
                v10.epoch_hashes = 0;
                if (v9) {
                    v10.difficulty = v8;
                };
                0x2::transfer::share_object<Bus>(v10);
            };
            0xa9ac245133600c1fe7fe625fa1d906a72972f0e55ae8dd462ca1c910dfc06d55::locker::top_up<SIUU>(&mut arg0.treasury, 0x2::balance::withdraw_all<SIUU>(&mut v6), arg2);
        } else {
            assert!(0xa9ac245133600c1fe7fe625fa1d906a72972f0e55ae8dd462ca1c910dfc06d55::locker::remaining_unlock<SIUU>(&arg0.treasury, arg2) == 0, 4006);
            0x2::balance::join<SIUU>(&mut v6, 0xa9ac245133600c1fe7fe625fa1d906a72972f0e55ae8dd462ca1c910dfc06d55::locker::skim_extraneous_balance<SIUU>(&mut arg0.treasury));
            arg0.total_rewards = arg0.total_rewards + 0x2::balance::value<SIUU>(&v6);
            0x2::balance::join<SIUU>(&mut 0x1::vector::borrow_mut<Bus>(&mut arg1, 0).rewards, 0x2::balance::withdraw_all<SIUU>(&mut v6));
            while (!0x1::vector::is_empty<Bus>(&arg1)) {
                let v11 = 0x1::vector::pop_back<Bus>(&mut arg1);
                v11.live = false;
                0x2::transfer::share_object<Bus>(v11);
            };
        };
        0x2::balance::destroy_zero<SIUU>(v6);
        0x1::vector::destroy_empty<Bus>(arg1);
    }

    fun generate_proof(arg0: vector<u8>, arg1: address, arg2: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, arg0);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg2));
        0x2::hash::keccak256(&v0)
    }

    fun init(arg0: SIUU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIUU>(arg0, 2, b"SIUU", b"SIUU", b"Algorithmic Proof-of-Work MEME.", 0x1::option::some<0x2::url::Url>(0xa9ac245133600c1fe7fe625fa1d906a72972f0e55ae8dd462ca1c910dfc06d55::icon::get_icon_url()), arg1);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0x2::coin::into_balance<SIUU>(0x2::coin::mint<SIUU>(&mut v3, 2100000000000000000, arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIUU>>(v3, 0x2::object::id_address<0x2::coin::CoinMetadata<SIUU>>(&v2));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SIUU>>(v2);
        let v5 = 0x2::balance::split<SIUU>(&mut v4, 194444000000000);
        let v6 = 0;
        while (v6 < 8) {
            let v7 = Bus{
                id           : 0x2::object::new(arg1),
                version      : 0,
                live         : true,
                difficulty   : 3,
                reward_rate  : 97222000000000 / 1000000,
                last_reset   : 0,
                rewards      : 0x2::balance::split<SIUU>(&mut v5, 194444000000000 / 8),
                epoch_hashes : 0,
            };
            0x2::transfer::share_object<Bus>(v7);
            v6 = v6 + 1;
        };
        0x2::balance::destroy_zero<SIUU>(v5);
        let v8 = Config{
            id                         : 0x2::object::new(arg1),
            version                    : 0,
            bus_count                  : 8,
            treasury                   : 0xa9ac245133600c1fe7fe625fa1d906a72972f0e55ae8dd462ca1c910dfc06d55::locker::create<SIUU>(v4, 1728244251, (194444000000000 + 60 - 194444000000000 % 60) / 60),
            last_difficulty_adjustment : 0x2::tx_context::epoch_timestamp_ms(arg1),
            total_rewards              : 0,
            total_hashes               : 0,
        };
        0x2::transfer::share_object<Config>(v8);
        let v9 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v9, 0x2::tx_context::sender(arg1));
    }

    public fun live(arg0: &Bus) : bool {
        arg0.live
    }

    public fun mine(arg0: u64, arg1: &mut Bus, arg2: &mut 0xa9ac245133600c1fe7fe625fa1d906a72972f0e55ae8dd462ca1c910dfc06d55::miner::Miner, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<SIUU> {
        if (!arg1.live) {
            let v0 = 0x2::balance::withdraw_all<SIUU>(&mut arg1.rewards);
            let v1 = 0x2::balance::value<SIUU>(&v0);
            if (v1 == 0) {
                abort 4007
            };
            0xa9ac245133600c1fe7fe625fa1d906a72972f0e55ae8dd462ca1c910dfc06d55::miner::record_rewards(arg2, v1);
            return 0x2::coin::from_balance<SIUU>(v0, arg4)
        };
        let v2 = 0x2::clock::timestamp_ms(arg3);
        assert!(0x2::balance::value<SIUU>(&arg1.rewards) >= arg1.reward_rate, 4001);
        let v3 = generate_proof(0xa9ac245133600c1fe7fe625fa1d906a72972f0e55ae8dd462ca1c910dfc06d55::miner::current_hash(arg2), 0x2::tx_context::sender(arg4), arg0);
        validate_proof(v3, arg1.difficulty);
        let v4 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v4, v3);
        0x1::vector::append<u8>(&mut v4, 0x2::bcs::to_bytes<u64>(&v2));
        let v5 = 0x2::tx_context::fresh_object_address(arg4);
        0x1::vector::append<u8>(&mut v4, 0x2::bcs::to_bytes<address>(&v5));
        *0xa9ac245133600c1fe7fe625fa1d906a72972f0e55ae8dd462ca1c910dfc06d55::miner::current_hash_mut(arg2) = 0x2::hash::keccak256(&v4);
        0xa9ac245133600c1fe7fe625fa1d906a72972f0e55ae8dd462ca1c910dfc06d55::miner::record_hash(arg2);
        0xa9ac245133600c1fe7fe625fa1d906a72972f0e55ae8dd462ca1c910dfc06d55::miner::record_rewards(arg2, arg1.reward_rate);
        arg1.epoch_hashes = arg1.epoch_hashes + 1;
        0x2::coin::from_balance<SIUU>(0x2::balance::split<SIUU>(&mut arg1.rewards, arg1.reward_rate), arg4)
    }

    public fun reward_rate(arg0: &Bus) : u64 {
        arg0.reward_rate
    }

    public fun rewards(arg0: &Bus) : &0x2::balance::Balance<SIUU> {
        &arg0.rewards
    }

    public fun total_hashes(arg0: &Config) : u64 {
        arg0.total_hashes
    }

    public fun total_rewards(arg0: &Config) : u64 {
        arg0.total_rewards
    }

    public fun treasury(arg0: &Config) : &0xa9ac245133600c1fe7fe625fa1d906a72972f0e55ae8dd462ca1c910dfc06d55::locker::Locker<SIUU> {
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

