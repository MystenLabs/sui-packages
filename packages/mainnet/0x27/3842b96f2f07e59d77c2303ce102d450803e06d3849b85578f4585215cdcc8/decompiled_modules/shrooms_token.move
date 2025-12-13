module 0x273842b96f2f07e59d77c2303ce102d450803e06d3849b85578f4585215cdcc8::shrooms_token {
    struct SHROOMS_TOKEN has drop {
        dummy_field: bool,
    }

    struct GameState has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<SHROOMS_TOKEN>,
        farms: vector<Farm>,
        total_farms: u64,
        total_shrooms_minted: u64,
        fee_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        dev_wallet: address,
    }

    struct Farm has store {
        id: u64,
        owner: address,
        mushrooms: u64,
        level: u64,
        last_harvest_timestamp: u64,
        created_at_epoch: u64,
    }

    fun calculate_yield(arg0: u64, arg1: u64, arg2: u64) : u64 {
        arg0 * arg1 / 3600000 * 1000000 * arg2
    }

    public entry fun create_farm(arg0: &mut GameState, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= 10000000000, 0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.fee_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v0 = Farm{
            id                     : arg0.total_farms,
            owner                  : 0x2::tx_context::sender(arg3),
            mushrooms              : 10,
            level                  : 1,
            last_harvest_timestamp : 0x2::clock::timestamp_ms(arg2),
            created_at_epoch       : 0x2::tx_context::epoch(arg3),
        };
        0x1::vector::push_back<Farm>(&mut arg0.farms, v0);
        arg0.total_farms = arg0.total_farms + 1;
    }

    public fun get_farm_info(arg0: &GameState, arg1: u64) : (address, u64, u64, u64, u64) {
        let v0 = 0x1::vector::borrow<Farm>(&arg0.farms, arg1);
        (v0.owner, v0.mushrooms, v0.level, v0.last_harvest_timestamp, v0.created_at_epoch)
    }

    public fun get_game_stats(arg0: &GameState) : (u64, u64, u64) {
        (arg0.total_farms, arg0.total_shrooms_minted, 0x2::balance::value<0x2::sui::SUI>(&arg0.fee_balance))
    }

    public entry fun harvest(arg0: &mut GameState, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = 0x1::vector::borrow_mut<Farm>(&mut arg0.farms, arg1);
        assert!(v2.owner == v0, 1);
        let v3 = v1 - v2.last_harvest_timestamp;
        assert!(v3 >= 300000, 3);
        let v4 = calculate_yield(v2.mushrooms, v3, v2.level);
        0x2::transfer::public_transfer<0x2::coin::Coin<SHROOMS_TOKEN>>(0x2::coin::mint<SHROOMS_TOKEN>(&mut arg0.treasury_cap, v4, arg3), v0);
        v2.last_harvest_timestamp = v1;
        arg0.total_shrooms_minted = arg0.total_shrooms_minted + v4;
    }

    fun init(arg0: SHROOMS_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHROOMS_TOKEN>(arg0, 6, b"SHROOMS", b"Shrooms Token", b"Farm mushrooms, harvest $SHROOMS tokens on Sui blockchain", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHROOMS_TOKEN>>(v1);
        let v2 = GameState{
            id                   : 0x2::object::new(arg1),
            treasury_cap         : v0,
            farms                : 0x1::vector::empty<Farm>(),
            total_farms          : 0,
            total_shrooms_minted : 0,
            fee_balance          : 0x2::balance::zero<0x2::sui::SUI>(),
            dev_wallet           : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::share_object<GameState>(v2);
    }

    public entry fun mint_for_liquidity(arg0: &mut GameState, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.dev_wallet, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SHROOMS_TOKEN>>(0x2::coin::mint<SHROOMS_TOKEN>(&mut arg0.treasury_cap, arg1, arg3), arg2);
        arg0.total_shrooms_minted = arg0.total_shrooms_minted + arg1;
    }

    public entry fun plant_mushrooms(arg0: &mut GameState, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::borrow_mut<Farm>(&mut arg0.farms, arg1);
        assert!(v0.owner == 0x2::tx_context::sender(arg3), 1);
        v0.mushrooms = v0.mushrooms + arg2;
    }

    public entry fun upgrade_farm(arg0: &mut GameState, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= 5000000000, 0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.fee_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v0 = 0x1::vector::borrow_mut<Farm>(&mut arg0.farms, arg2);
        assert!(v0.owner == 0x2::tx_context::sender(arg3), 1);
        v0.level = v0.level + 1;
    }

    public entry fun withdraw_fees(arg0: &mut GameState, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.dev_wallet, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.fee_balance, 0x2::balance::value<0x2::sui::SUI>(&arg0.fee_balance), arg1), arg0.dev_wallet);
    }

    // decompiled from Move bytecode v6
}

