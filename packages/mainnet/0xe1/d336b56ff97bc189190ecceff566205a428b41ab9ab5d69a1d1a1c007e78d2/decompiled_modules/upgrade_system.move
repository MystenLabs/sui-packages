module 0xe1d336b56ff97bc189190ecceff566205a428b41ab9ab5d69a1d1a1c007e78d2::upgrade_system {
    struct FarmUpgrade has store, key {
        id: 0x2::object::UID,
        farm_id: 0x2::object::ID,
        upgrade_type: u8,
        applied_at: u64,
        duration: u64,
        boost_percentage: u64,
    }

    struct UpgradeManager has key {
        id: 0x2::object::UID,
        total_upgrades_sold: u64,
        revenue_generated: u64,
    }

    struct UpgradePurchased has copy, drop {
        farm_id: 0x2::object::ID,
        owner: address,
        upgrade_type: u8,
        cost: u64,
        timestamp: u64,
    }

    struct UpgradeExpired has copy, drop {
        farm_id: 0x2::object::ID,
        upgrade_type: u8,
        timestamp: u64,
    }

    public fun calculate_boosted_growth_time(arg0: u64, arg1: &vector<FarmUpgrade>, arg2: &0x2::clock::Clock) : u64 {
        let v0 = arg0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<FarmUpgrade>(arg1)) {
            let v2 = 0x1::vector::borrow<FarmUpgrade>(arg1, v1);
            if (is_upgrade_active(v2, arg2) && (v2.upgrade_type == 1 || v2.upgrade_type == 4)) {
                let v3 = v0 * v2.boost_percentage / 100;
                v0 = v0 - v3;
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun calculate_boosted_harvest(arg0: u64, arg1: &vector<FarmUpgrade>, arg2: &0x2::clock::Clock) : u64 {
        let v0 = arg0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<FarmUpgrade>(arg1)) {
            let v2 = 0x1::vector::borrow<FarmUpgrade>(arg1, v1);
            if (is_upgrade_active(v2, arg2) && (v2.upgrade_type == 2 || v2.upgrade_type == 4)) {
                let v3 = v0 * v2.boost_percentage / 100;
                v0 = v0 + v3;
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun calculate_discounted_upgrade_cost(arg0: u64, arg1: &vector<FarmUpgrade>, arg2: &0x2::clock::Clock) : u64 {
        let v0 = arg0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<FarmUpgrade>(arg1)) {
            let v2 = 0x1::vector::borrow<FarmUpgrade>(arg1, v1);
            if (is_upgrade_active(v2, arg2) && (v2.upgrade_type == 3 || v2.upgrade_type == 4)) {
                let v3 = v0 * v2.boost_percentage / 100;
                v0 = v0 - v3;
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun get_upgrade_costs() : (u64, u64, u64, u64) {
        (2000000000, 3000000000, 4000000000, 10000000000)
    }

    public fun get_upgrade_stats(arg0: &UpgradeManager) : (u64, u64) {
        (arg0.total_upgrades_sold, arg0.revenue_generated)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = UpgradeManager{
            id                  : 0x2::object::new(arg0),
            total_upgrades_sold : 0,
            revenue_generated   : 0,
        };
        0x2::transfer::share_object<UpgradeManager>(v0);
    }

    public fun is_upgrade_active(arg0: &FarmUpgrade, arg1: &0x2::clock::Clock) : bool {
        arg0.duration == 0 || 0x2::clock::timestamp_ms(arg1) < arg0.applied_at + arg0.duration
    }

    public fun purchase_efficiency_pack(arg0: &mut UpgradeManager, arg1: &0xe1d336b56ff97bc189190ecceff566205a428b41ab9ab5d69a1d1a1c007e78d2::farm_manager::Farm, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : FarmUpgrade {
        purchase_upgrade_pack(arg0, arg1, arg2, 3, 4000000000, 0, 20, arg3, arg4)
    }

    public fun purchase_premium_pack(arg0: &mut UpgradeManager, arg1: &0xe1d336b56ff97bc189190ecceff566205a428b41ab9ab5d69a1d1a1c007e78d2::farm_manager::Farm, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : FarmUpgrade {
        purchase_upgrade_pack(arg0, arg1, arg2, 4, 10000000000, 86400000, 100, arg3, arg4)
    }

    public fun purchase_speed_boost(arg0: &mut UpgradeManager, arg1: &0xe1d336b56ff97bc189190ecceff566205a428b41ab9ab5d69a1d1a1c007e78d2::farm_manager::Farm, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : FarmUpgrade {
        purchase_upgrade_pack(arg0, arg1, arg2, 1, 2000000000, 7200000, 25, arg3, arg4)
    }

    fun purchase_upgrade_pack(arg0: &mut UpgradeManager, arg1: &0xe1d336b56ff97bc189190ecceff566205a428b41ab9ab5d69a1d1a1c007e78d2::farm_manager::Farm, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u8, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : FarmUpgrade {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= arg4, 0);
        assert!(arg3 >= 1 && arg3 <= 4, 1);
        let (v0, _, _, _, _) = 0xe1d336b56ff97bc189190ecceff566205a428b41ab9ab5d69a1d1a1c007e78d2::farm_manager::get_farm_info(arg1);
        assert!(v0 == 0x2::tx_context::sender(arg8), 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, @0x2c478b5f158e037cb21b3443a5a3512f6fee0b9a16d7a261baa00ddca69d6fc5);
        let v5 = 0xe1d336b56ff97bc189190ecceff566205a428b41ab9ab5d69a1d1a1c007e78d2::farm_manager::get_farm_id(arg1);
        let v6 = FarmUpgrade{
            id               : 0x2::object::new(arg8),
            farm_id          : v5,
            upgrade_type     : arg3,
            applied_at       : 0x2::clock::timestamp_ms(arg7),
            duration         : arg5,
            boost_percentage : arg6,
        };
        arg0.total_upgrades_sold = arg0.total_upgrades_sold + 1;
        arg0.revenue_generated = arg0.revenue_generated + arg4;
        let v7 = UpgradePurchased{
            farm_id      : v5,
            owner        : 0x2::tx_context::sender(arg8),
            upgrade_type : arg3,
            cost         : arg4,
            timestamp    : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::event::emit<UpgradePurchased>(v7);
        v6
    }

    public fun purchase_yield_boost(arg0: &mut UpgradeManager, arg1: &0xe1d336b56ff97bc189190ecceff566205a428b41ab9ab5d69a1d1a1c007e78d2::farm_manager::Farm, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : FarmUpgrade {
        purchase_upgrade_pack(arg0, arg1, arg2, 2, 3000000000, 10800000, 50, arg3, arg4)
    }

    // decompiled from Move bytecode v6
}

