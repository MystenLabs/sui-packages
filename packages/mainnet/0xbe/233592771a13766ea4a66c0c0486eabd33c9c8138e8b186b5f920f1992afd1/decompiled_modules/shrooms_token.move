module 0xbe233592771a13766ea4a66c0c0486eabd33c9c8138e8b186b5f920f1992afd1::shrooms_token {
    struct SHROOMS_TOKEN has drop {
        dummy_field: bool,
    }

    struct GameState has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<SHROOMS_TOKEN>,
        dev_wallet: address,
        total_farms: u64,
        total_harvested: u64,
        fee_pool: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct Farm has store, key {
        id: 0x2::object::UID,
        owner: address,
        mushroom_count: u64,
        last_harvest: u64,
        total_harvested: u64,
        upgrade_level: u8,
    }

    public entry fun create_farm(arg0: &mut GameState, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= 10000000000, 0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.fee_pool, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v0 = Farm{
            id              : 0x2::object::new(arg2),
            owner           : 0x2::tx_context::sender(arg2),
            mushroom_count  : 10,
            last_harvest    : 0x2::tx_context::epoch(arg2),
            total_harvested : 0,
            upgrade_level   : 1,
        };
        arg0.total_farms = arg0.total_farms + 1;
        0x2::transfer::transfer<Farm>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun get_farm_info(arg0: &Farm) : (u64, u64, u64, u8) {
        (arg0.mushroom_count, arg0.last_harvest, arg0.total_harvested, arg0.upgrade_level)
    }

    public fun get_game_stats(arg0: &GameState) : (u64, u64) {
        (arg0.total_farms, arg0.total_harvested)
    }

    public entry fun harvest(arg0: &mut GameState, arg1: &mut Farm, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.owner == 0x2::tx_context::sender(arg2), 2);
        let v0 = 0x2::tx_context::epoch(arg2);
        let v1 = arg1.mushroom_count * (v0 - arg1.last_harvest) * (arg1.upgrade_level as u64) * 50000000;
        0x2::transfer::public_transfer<0x2::coin::Coin<SHROOMS_TOKEN>>(0x2::coin::mint<SHROOMS_TOKEN>(&mut arg0.treasury_cap, v1, arg2), 0x2::tx_context::sender(arg2));
        arg1.last_harvest = v0;
        arg1.total_harvested = arg1.total_harvested + v1;
        arg0.total_harvested = arg0.total_harvested + v1;
    }

    fun init(arg0: SHROOMS_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHROOMS_TOKEN>(arg0, 9, b"SHROOMS", b"Magic Shrooms", b"The magic mushroom farming token on Sui", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHROOMS_TOKEN>>(v1);
        let v2 = GameState{
            id              : 0x2::object::new(arg1),
            treasury_cap    : v0,
            dev_wallet      : @0x2c478b5f158e037cb21b3443a5a3512f6fee0b9a16d7a261baa00ddca69d6fc5,
            total_farms     : 0,
            total_harvested : 0,
            fee_pool        : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<GameState>(v2);
    }

    public entry fun plant_mushrooms(arg0: &mut Farm, arg1: 0x2::coin::Coin<SHROOMS_TOKEN>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg3), 2);
        assert!(arg2 > 0, 1);
        assert!(0x2::coin::value<SHROOMS_TOKEN>(&arg1) >= arg2 * 100000000, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<SHROOMS_TOKEN>>(arg1, @0x0);
        arg0.mushroom_count = arg0.mushroom_count + arg2;
    }

    public entry fun upgrade_farm(arg0: &mut GameState, arg1: &mut Farm, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: 0x2::coin::Coin<SHROOMS_TOKEN>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.owner == 0x2::tx_context::sender(arg4), 2);
        let v0 = (arg1.upgrade_level as u64);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= 2000000000 * v0, 0);
        assert!(0x2::coin::value<SHROOMS_TOKEN>(&arg3) >= 5000000000 * v0, 0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.fee_pool, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<SHROOMS_TOKEN>>(arg3, @0x0);
        arg1.upgrade_level = arg1.upgrade_level + 1;
    }

    public entry fun withdraw_fees(arg0: &mut GameState, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.dev_wallet, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.fee_pool, arg1, arg2), arg0.dev_wallet);
    }

    // decompiled from Move bytecode v6
}

