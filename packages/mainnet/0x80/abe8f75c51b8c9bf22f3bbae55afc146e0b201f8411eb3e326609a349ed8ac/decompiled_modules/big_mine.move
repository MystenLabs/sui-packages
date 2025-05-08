module 0x80abe8f75c51b8c9bf22f3bbae55afc146e0b201f8411eb3e326609a349ed8ac::big_mine {
    struct BIG has copy, drop, store {
        dummy_field: bool,
    }

    struct BIGToken has store, key {
        id: 0x2::object::UID,
        value: u64,
        owner: address,
    }

    struct GameAdmin has key {
        id: 0x2::object::UID,
        treasury: 0x2::balance::Balance<0x2::sui::SUI>,
        token_supply: 0x2::balance::Supply<BIG>,
        token_balance: 0x2::balance::Balance<BIG>,
        total_miners: u64,
        total_factories: u64,
    }

    struct Factory has store, key {
        id: 0x2::object::UID,
        owner: address,
        tier: u8,
        miners_allowed: u64,
        miners_count: u64,
    }

    struct Miner has store, key {
        id: 0x2::object::UID,
        owner: address,
        factory_id: 0x2::object::ID,
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
        factory_id: 0x2::object::ID,
        tier: u8,
    }

    struct RewardsClaimed has copy, drop {
        owner: address,
        amount: u64,
    }

    public entry fun add_sui_to_treasury(arg0: &mut GameAdmin, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(arg1) >= arg2, 0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.treasury, 0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg1), arg2));
    }

    public fun admin_treasuries(arg0: &GameAdmin) : (u64, u64, u64, u64) {
        (0x2::balance::value<0x2::sui::SUI>(&arg0.treasury), 0x2::balance::value<BIG>(&arg0.token_balance), arg0.total_miners, arg0.total_factories)
    }

    public fun calculate_pending_rewards(arg0: &Miner, arg1: &0x2::clock::Clock) : (u64, u64) {
        let v0 = (0x2::clock::timestamp_ms(arg1) - arg0.last_claim_timestamp) / 86400000;
        if (v0 == 0) {
            return (0, 0)
        };
        let v1 = if (arg0.tier == 1) {
            100000000
        } else if (arg0.tier == 2) {
            300000000
        } else {
            1000000000
        };
        (v1 * arg0.efficiency / 100 * v0, v0)
    }

    public entry fun claim_reward(arg0: &mut Miner, arg1: &Factory, arg2: &0x2::clock::Clock, arg3: &mut GameAdmin, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg4), 3);
        assert!(arg0.factory_id == 0x2::object::id<Factory>(arg1), 7);
        let v0 = 0x2::clock::timestamp_ms(arg2);
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
        assert!(0x2::balance::value<BIG>(&arg3.token_balance) >= v3, 5);
        let v4 = BIGToken{
            id    : 0x2::object::new(arg4),
            value : v3,
            owner : 0x2::tx_context::sender(arg4),
        };
        0x2::transfer::transfer<BIGToken>(v4, 0x2::tx_context::sender(arg4));
        arg0.last_claim_timestamp = v0;
        let v5 = RewardsClaimed{
            owner  : 0x2::tx_context::sender(arg4),
            amount : v3,
        };
        0x2::event::emit<RewardsClaimed>(v5);
    }

    public entry fun deposit_tokens(arg0: &mut GameAdmin, arg1: BIGToken, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.owner == 0x2::tx_context::sender(arg2), 3);
        let BIGToken {
            id    : v0,
            value : _,
            owner : _,
        } = arg1;
        0x2::object::delete(v0);
    }

    public entry fun distribute_tokens(arg0: &mut GameAdmin, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<BIG>(&arg0.token_balance) >= arg1, 5);
        let v0 = BIGToken{
            id    : 0x2::object::new(arg3),
            value : arg1,
            owner : arg2,
        };
        0x2::transfer::transfer<BIGToken>(v0, arg2);
    }

    public fun factory_details(arg0: &Factory) : (address, u8, u64, u64) {
        (arg0.owner, arg0.tier, arg0.miners_allowed, arg0.miners_count)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = BIG{dummy_field: false};
        let v1 = 0x2::balance::create_supply<BIG>(v0);
        let v2 = GameAdmin{
            id              : 0x2::object::new(arg0),
            treasury        : 0x2::balance::zero<0x2::sui::SUI>(),
            token_supply    : v1,
            token_balance   : 0x2::balance::increase_supply<BIG>(&mut v1, 100000000000000000),
            total_miners    : 0,
            total_factories : 0,
        };
        0x2::transfer::transfer<GameAdmin>(v2, 0x2::tx_context::sender(arg0));
        let v3 = BIGToken{
            id    : 0x2::object::new(arg0),
            value : 1000000000,
            owner : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::transfer<BIGToken>(v3, 0x2::tx_context::sender(arg0));
    }

    public fun is_miner_from_factory(arg0: &Miner, arg1: &Factory) : bool {
        arg0.factory_id == 0x2::object::id<Factory>(arg1)
    }

    public entry fun merge_tokens(arg0: BIGToken, arg1: &mut BIGToken, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 3);
        assert!(arg1.owner == 0x2::tx_context::sender(arg2), 3);
        let BIGToken {
            id    : v0,
            value : v1,
            owner : _,
        } = arg0;
        0x2::object::delete(v0);
        arg1.value = arg1.value + v1;
    }

    public fun miner_details(arg0: &Miner) : (address, 0x2::object::ID, u8, u64, u64) {
        (arg0.owner, arg0.factory_id, arg0.tier, arg0.last_claim_timestamp, arg0.efficiency)
    }

    public entry fun mint_tokens(arg0: &mut GameAdmin, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = BIGToken{
            id    : 0x2::object::new(arg3),
            value : arg1,
            owner : arg2,
        };
        0x2::balance::join<BIG>(&mut arg0.token_balance, 0x2::balance::increase_supply<BIG>(&mut arg0.token_supply, arg1));
        0x2::transfer::transfer<BIGToken>(v0, arg2);
    }

    public entry fun purchase_factory(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: u8, arg2: &mut GameAdmin, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0 && arg1 <= 3, 4);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg0) >= 5000000000, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg0), 5000000000), arg3), 0x2::tx_context::sender(arg3));
        let v0 = Factory{
            id             : 0x2::object::new(arg3),
            owner          : 0x2::tx_context::sender(arg3),
            tier           : arg1,
            miners_allowed : (arg1 as u64) * 5,
            miners_count   : 0,
        };
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = FactoryPurchased{
            owner      : v1,
            factory_id : 0x2::object::id<Factory>(&v0),
            tier       : arg1,
        };
        0x2::event::emit<FactoryPurchased>(v2);
        arg2.total_factories = arg2.total_factories + 1;
        0x2::transfer::public_transfer<Factory>(v0, v1);
    }

    public entry fun purchase_miner(arg0: u8, arg1: &mut Factory, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut GameAdmin, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 > 0 && arg0 <= 3, 4);
        assert!(arg1.owner == 0x2::tx_context::sender(arg5), 3);
        assert!(arg1.miners_count < arg1.miners_allowed, 6);
        let v0 = 5000000000 / 2 * (arg0 as u64);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg2) >= v0, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg2), v0), arg5), 0x2::tx_context::sender(arg5));
        let v1 = 0x2::tx_context::sender(arg5);
        let v2 = 0x2::object::id<Factory>(arg1);
        let v3 = Miner{
            id                   : 0x2::object::new(arg5),
            owner                : v1,
            factory_id           : v2,
            tier                 : arg0,
            last_claim_timestamp : 0x2::clock::timestamp_ms(arg3),
            efficiency           : 100,
        };
        arg1.miners_count = arg1.miners_count + 1;
        arg4.total_miners = arg4.total_miners + 1;
        let v4 = MinerPurchased{
            owner      : v1,
            miner_id   : 0x2::object::id<Miner>(&v3),
            factory_id : v2,
            tier       : arg0,
        };
        0x2::event::emit<MinerPurchased>(v4);
        0x2::transfer::public_transfer<Miner>(v3, v1);
    }

    public entry fun split_token(arg0: &mut BIGToken, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg3), 3);
        assert!(arg0.value >= arg1, 5);
        arg0.value = arg0.value - arg1;
        let v0 = BIGToken{
            id    : 0x2::object::new(arg3),
            value : arg1,
            owner : arg2,
        };
        0x2::transfer::transfer<BIGToken>(v0, arg2);
    }

    public fun token_owner(arg0: &BIGToken) : address {
        arg0.owner
    }

    public fun token_value(arg0: &BIGToken) : u64 {
        arg0.value
    }

    public entry fun upgrade_factory(arg0: &mut Factory, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 3);
        assert!(arg0.tier < 3, 1);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg1) >= 5000000000, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg1), 5000000000), arg2), 0x2::tx_context::sender(arg2));
        arg0.tier = arg0.tier + 1;
        arg0.miners_allowed = (arg0.tier as u64) * 5;
    }

    public entry fun upgrade_miner(arg0: &mut Miner, arg1: &Factory, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg4), 3);
        assert!(arg0.factory_id == 0x2::object::id<Factory>(arg1), 7);
        assert!(arg0.tier < 3, 1);
        let v0 = 5000000000 / 2 * (arg0.tier as u64);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg2) >= v0, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg2), v0), arg4), 0x2::tx_context::sender(arg4));
        arg0.last_claim_timestamp = 0x2::clock::timestamp_ms(arg3);
        arg0.tier = arg0.tier + 1;
        arg0.efficiency = arg0.efficiency + 10;
    }

    // decompiled from Move bytecode v6
}

