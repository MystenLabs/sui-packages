module 0x92fc450bc3691ad0e2ef44b8a990a267eac94b344e6c0bbf779f6736ef26f68b::big_mine {
    struct GameAdmin has key {
        id: 0x2::object::UID,
        treasury_sui: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct Factory has store, key {
        id: 0x2::object::UID,
        owner: address,
        tier: u8,
        miners_allowed: u64,
    }

    struct Miner has store, key {
        id: 0x2::object::UID,
        owner: address,
        tier: u8,
        last_claim_timestamp: u64,
        efficiency: u64,
    }

    struct FactoryPurchased has copy, drop {
        owner: address,
        factory_id: 0x2::object::ID,
        tier: u8,
    }

    struct MinerPurchased has copy, drop {
        owner: address,
        miner_id: 0x2::object::ID,
        tier: u8,
    }

    struct RewardsClaimed has copy, drop {
        owner: address,
        amount: u64,
    }

    public entry fun add_to_treasury(arg0: &mut GameAdmin, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(arg1) >= arg2, 0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.treasury_sui, 0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg1), arg2));
    }

    public entry fun claim_reward(arg0: &mut Miner, arg1: &0x2::clock::Clock, arg2: &mut GameAdmin, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg3), 3);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = (v0 - arg0.last_claim_timestamp) / 86400000;
        assert!(v1 > 0, 5);
        let v2 = if (arg0.tier == 1) {
            100000000
        } else if (arg0.tier == 2) {
            300000000
        } else {
            1000000000
        };
        let v3 = v2 * arg0.efficiency / 100 * v1;
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg2.treasury_sui) >= v3, 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg2.treasury_sui, v3), arg3), 0x2::tx_context::sender(arg3));
        arg0.last_claim_timestamp = v0;
        let v4 = RewardsClaimed{
            owner  : 0x2::tx_context::sender(arg3),
            amount : v3,
        };
        0x2::event::emit<RewardsClaimed>(v4);
    }

    public entry fun distribute_tokens(arg0: &mut GameAdmin, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.treasury_sui) >= arg1, 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.treasury_sui, arg1), arg3), arg2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GameAdmin{
            id           : 0x2::object::new(arg0),
            treasury_sui : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::transfer<GameAdmin>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun purchase_factory(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0 && arg1 <= 3, 4);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg0) >= 5000000000, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg0), 5000000000), arg2), 0x2::tx_context::sender(arg2));
        let v0 = Factory{
            id             : 0x2::object::new(arg2),
            owner          : 0x2::tx_context::sender(arg2),
            tier           : arg1,
            miners_allowed : (arg1 as u64) * 5,
        };
        let v1 = 0x2::tx_context::sender(arg2);
        let v2 = FactoryPurchased{
            owner      : v1,
            factory_id : 0x2::object::id<Factory>(&v0),
            tier       : arg1,
        };
        0x2::event::emit<FactoryPurchased>(v2);
        0x2::transfer::public_transfer<Factory>(v0, v1);
    }

    public entry fun purchase_miner(arg0: u8, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 > 0 && arg0 <= 3, 4);
        let v0 = 5000000000 / 2 * (arg0 as u64);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg1) >= v0, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg1), v0), arg3), 0x2::tx_context::sender(arg3));
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = Miner{
            id                   : 0x2::object::new(arg3),
            owner                : v1,
            tier                 : arg0,
            last_claim_timestamp : 0x2::clock::timestamp_ms(arg2),
            efficiency           : 100,
        };
        let v3 = MinerPurchased{
            owner    : v1,
            miner_id : 0x2::object::id<Miner>(&v2),
            tier     : arg0,
        };
        0x2::event::emit<MinerPurchased>(v3);
        0x2::transfer::public_transfer<Miner>(v2, v1);
    }

    public entry fun upgrade_factory(arg0: &mut Factory, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 3);
        assert!(arg0.tier < 3, 1);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg1) >= 5000000000, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg1), 5000000000), arg2), 0x2::tx_context::sender(arg2));
        arg0.tier = arg0.tier + 1;
        arg0.miners_allowed = (arg0.tier as u64) * 5;
    }

    public entry fun upgrade_miner(arg0: &mut Miner, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg3), 3);
        assert!(arg0.tier < 3, 1);
        let v0 = 5000000000 / 2 * (arg0.tier as u64);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg1) >= v0, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg1), v0), arg3), 0x2::tx_context::sender(arg3));
        arg0.last_claim_timestamp = 0x2::clock::timestamp_ms(arg2);
        arg0.tier = arg0.tier + 1;
        arg0.efficiency = arg0.efficiency + 10;
    }

    // decompiled from Move bytecode v6
}

