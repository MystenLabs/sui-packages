module 0xe1d336b56ff97bc189190ecceff566205a428b41ab9ab5d69a1d1a1c007e78d2::farm_manager {
    struct Farm has store, key {
        id: 0x2::object::UID,
        owner: address,
        level: u8,
        last_harvest: u64,
        total_yield: u64,
        created_at: u64,
    }

    struct FarmManager has key {
        id: 0x2::object::UID,
        total_farms: u64,
        reward_pool: 0x2::balance::Balance<0xe1d336b56ff97bc189190ecceff566205a428b41ab9ab5d69a1d1a1c007e78d2::shroomz_token::SHROOMZ_TOKEN>,
        total_rewards_distributed: u64,
    }

    struct FarmManagerCap has key {
        id: 0x2::object::UID,
    }

    struct FarmCreated has copy, drop {
        farm_id: 0x2::object::ID,
        owner: address,
        timestamp: u64,
    }

    struct FarmUpgraded has copy, drop {
        farm_id: 0x2::object::ID,
        owner: address,
        new_level: u8,
        timestamp: u64,
    }

    struct FarmHarvested has copy, drop {
        farm_id: 0x2::object::ID,
        owner: address,
        amount: u64,
        timestamp: u64,
    }

    public fun add_rewards_to_pool(arg0: &FarmManagerCap, arg1: &mut FarmManager, arg2: 0x2::coin::Coin<0xe1d336b56ff97bc189190ecceff566205a428b41ab9ab5d69a1d1a1c007e78d2::shroomz_token::SHROOMZ_TOKEN>) {
        0x2::balance::join<0xe1d336b56ff97bc189190ecceff566205a428b41ab9ab5d69a1d1a1c007e78d2::shroomz_token::SHROOMZ_TOKEN>(&mut arg1.reward_pool, 0x2::coin::into_balance<0xe1d336b56ff97bc189190ecceff566205a428b41ab9ab5d69a1d1a1c007e78d2::shroomz_token::SHROOMZ_TOKEN>(arg2));
    }

    public fun calculate_harvest(arg0: &Farm, arg1: &0x2::clock::Clock) : u64 {
        if (0x2::clock::timestamp_ms(arg1) - arg0.last_harvest < 3600000) {
            return 0
        };
        10000000000 * (arg0.level as u64) * calculate_level_multiplier(arg0.level) / 100
    }

    fun calculate_level_multiplier(arg0: u8) : u64 {
        let v0 = 100;
        let v1 = 1;
        while (v1 < arg0) {
            let v2 = v0 * 120;
            v0 = v2 / 100;
            v1 = v1 + 1;
        };
        v0
    }

    public fun create_farm(arg0: &mut FarmManager, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : Farm {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= 10000000000, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, @0x2c478b5f158e037cb21b3443a5a3512f6fee0b9a16d7a261baa00ddca69d6fc5);
        let v0 = 0x2::object::new(arg3);
        let v1 = Farm{
            id           : v0,
            owner        : 0x2::tx_context::sender(arg3),
            level        : 1,
            last_harvest : 0x2::clock::timestamp_ms(arg2),
            total_yield  : 0,
            created_at   : 0x2::clock::timestamp_ms(arg2),
        };
        arg0.total_farms = arg0.total_farms + 1;
        let v2 = FarmCreated{
            farm_id   : 0x2::object::uid_to_inner(&v0),
            owner     : 0x2::tx_context::sender(arg3),
            timestamp : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<FarmCreated>(v2);
        v1
    }

    public fun get_farm_constants() : (u64, u64, u8, u64) {
        (10000000000, 5000000000, 10, 3600000)
    }

    public fun get_farm_id(arg0: &Farm) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun get_farm_info(arg0: &Farm) : (address, u8, u64, u64, u64) {
        (arg0.owner, arg0.level, arg0.last_harvest, arg0.total_yield, arg0.created_at)
    }

    public fun get_growth_progress(arg0: &Farm, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg1) - arg0.last_harvest;
        if (v0 >= 3600000) {
            100
        } else {
            v0 * 100 / 3600000
        }
    }

    public fun get_manager_stats(arg0: &FarmManager) : (u64, u64, u64) {
        (arg0.total_farms, 0x2::balance::value<0xe1d336b56ff97bc189190ecceff566205a428b41ab9ab5d69a1d1a1c007e78d2::shroomz_token::SHROOMZ_TOKEN>(&arg0.reward_pool), arg0.total_rewards_distributed)
    }

    public fun harvest_farm(arg0: &mut Farm, arg1: &mut FarmManager, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg3), 1);
        let v0 = calculate_harvest(arg0, arg2);
        assert!(v0 > 0, 3);
        assert!(0x2::balance::value<0xe1d336b56ff97bc189190ecceff566205a428b41ab9ab5d69a1d1a1c007e78d2::shroomz_token::SHROOMZ_TOKEN>(&arg1.reward_pool) >= v0, 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xe1d336b56ff97bc189190ecceff566205a428b41ab9ab5d69a1d1a1c007e78d2::shroomz_token::SHROOMZ_TOKEN>>(0x2::coin::from_balance<0xe1d336b56ff97bc189190ecceff566205a428b41ab9ab5d69a1d1a1c007e78d2::shroomz_token::SHROOMZ_TOKEN>(0x2::balance::split<0xe1d336b56ff97bc189190ecceff566205a428b41ab9ab5d69a1d1a1c007e78d2::shroomz_token::SHROOMZ_TOKEN>(&mut arg1.reward_pool, v0), arg3), arg0.owner);
        arg0.last_harvest = 0x2::clock::timestamp_ms(arg2);
        arg0.total_yield = arg0.total_yield + v0;
        arg1.total_rewards_distributed = arg1.total_rewards_distributed + v0;
        let v1 = FarmHarvested{
            farm_id   : 0x2::object::uid_to_inner(&arg0.id),
            owner     : arg0.owner,
            amount    : v0,
            timestamp : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<FarmHarvested>(v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = FarmManager{
            id                        : 0x2::object::new(arg0),
            total_farms               : 0,
            reward_pool               : 0x2::balance::zero<0xe1d336b56ff97bc189190ecceff566205a428b41ab9ab5d69a1d1a1c007e78d2::shroomz_token::SHROOMZ_TOKEN>(),
            total_rewards_distributed : 0,
        };
        let v1 = FarmManagerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<FarmManager>(v0);
        0x2::transfer::transfer<FarmManagerCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_ready_to_harvest(arg0: &Farm, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) - arg0.last_harvest >= 3600000
    }

    public fun upgrade_farm(arg0: &mut Farm, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg3), 1);
        assert!(arg0.level < 10, 2);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= 5000000000, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, @0x2c478b5f158e037cb21b3443a5a3512f6fee0b9a16d7a261baa00ddca69d6fc5);
        arg0.level = arg0.level + 1;
        let v0 = FarmUpgraded{
            farm_id   : 0x2::object::uid_to_inner(&arg0.id),
            owner     : arg0.owner,
            new_level : arg0.level,
            timestamp : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<FarmUpgraded>(v0);
    }

    public fun withdraw_fees(arg0: &FarmManagerCap, arg1: &mut 0x2::tx_context::TxContext) {
    }

    // decompiled from Move bytecode v6
}

