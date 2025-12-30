module 0x67c37d43caa3a50f275355f9ab3892c6a8461f38d1b7f3f3860c88dc8fc46f99::farm {
    struct FarmState has key {
        id: 0x2::object::UID,
        treasury: 0x2::balance::Balance<0x2::sui::SUI>,
        farms: 0x2::table::Table<address, Farm>,
        total_farms: u64,
        dev_wallet: address,
    }

    struct Farm has store {
        owner: address,
        level: u64,
        last_harvest: u64,
        total_harvested: u64,
        creation_time: u64,
    }

    struct LeaderboardEntry has copy, drop, store {
        farmer: address,
        pnl: u64,
        total_harvested: u64,
        farm_level: u64,
    }

    public fun calculate_harvest(arg0: &FarmState, arg1: address, arg2: &0x2::clock::Clock) : u64 {
        if (!0x2::table::contains<address, Farm>(&arg0.farms, arg1)) {
            return 0
        };
        let v0 = 0x2::table::borrow<address, Farm>(&arg0.farms, arg1);
        100 * v0.level * v0.level * v0.level / 2 * (0x2::clock::timestamp_ms(arg2) - v0.last_harvest) / 3600000
    }

    public entry fun create_farm(arg0: &mut FarmState, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(!0x2::table::contains<address, Farm>(&arg0.farms, v0), 0);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= 10000000000, 3);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.treasury, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v1 = Farm{
            owner           : v0,
            level           : 1,
            last_harvest    : 0x2::clock::timestamp_ms(arg2),
            total_harvested : 0,
            creation_time   : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::table::add<address, Farm>(&mut arg0.farms, v0, v1);
        arg0.total_farms = arg0.total_farms + 1;
    }

    public fun get_farm(arg0: &FarmState, arg1: address) : (u64, u64, u64, u64) {
        if (!0x2::table::contains<address, Farm>(&arg0.farms, arg1)) {
            return (0, 0, 0, 0)
        };
        let v0 = 0x2::table::borrow<address, Farm>(&arg0.farms, arg1);
        (v0.level, v0.last_harvest, v0.total_harvested, v0.creation_time)
    }

    public fun get_total_farms(arg0: &FarmState) : u64 {
        arg0.total_farms
    }

    public fun get_treasury_balance(arg0: &FarmState) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.treasury)
    }

    public entry fun harvest(arg0: &mut FarmState, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, Farm>(&arg0.farms, v0), 1);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        let v2 = 0x2::table::borrow<address, Farm>(&arg0.farms, v0);
        let v3 = 100 * v2.level * v2.level * v2.level / 2 * (v1 - v2.last_harvest) / 3600000;
        let v4 = 0x2::table::borrow_mut<address, Farm>(&mut arg0.farms, v0);
        v4.last_harvest = v1;
        v4.total_harvested = v4.total_harvested + v3;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = FarmState{
            id          : 0x2::object::new(arg0),
            treasury    : 0x2::balance::zero<0x2::sui::SUI>(),
            farms       : 0x2::table::new<address, Farm>(arg0),
            total_farms : 0,
            dev_wallet  : @0x2c478b5f158e037cb21b3443a5a3512f6fee0b9a16d7a261baa00ddca69d6fc5,
        };
        0x2::transfer::share_object<FarmState>(v0);
    }

    public entry fun upgrade_farm(arg0: &mut FarmState, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, Farm>(&arg0.farms, v0), 1);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= 5000000000, 3);
        let v1 = 0x2::table::borrow_mut<address, Farm>(&mut arg0.farms, v0);
        assert!(v1.level < 10, 2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.treasury, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        v1.level = v1.level + 1;
    }

    public fun withdraw_treasury(arg0: &mut FarmState, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.dev_wallet, 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.treasury, 0x2::balance::value<0x2::sui::SUI>(&arg0.treasury), arg1), v0);
    }

    // decompiled from Move bytecode v6
}

