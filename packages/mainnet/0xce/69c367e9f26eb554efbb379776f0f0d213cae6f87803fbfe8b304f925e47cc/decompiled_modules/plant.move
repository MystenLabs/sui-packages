module 0xce69c367e9f26eb554efbb379776f0f0d213cae6f87803fbfe8b304f925e47cc::plant {
    struct Plant has store, key {
        id: 0x2::object::UID,
        is_alive: bool,
        born_at: u64,
        version: u64,
    }

    struct HealthKey has copy, drop, store {
        dummy_field: bool,
    }

    struct WaterLevelKey has copy, drop, store {
        dummy_field: bool,
    }

    struct GrowthStageKey has copy, drop, store {
        dummy_field: bool,
    }

    struct LastWateredKey has copy, drop, store {
        dummy_field: bool,
    }

    struct GracePeriodKey has copy, drop, store {
        dummy_field: bool,
    }

    struct DrainRateKey has copy, drop, store {
        dummy_field: bool,
    }

    public fun born_at(arg0: &Plant) : u64 {
        arg0.born_at
    }

    fun calculate_health(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        if (arg3 <= arg1) {
            return arg0
        };
        let v0 = ((arg3 - arg1) as u128) * 1000 / (3600000 as u128) * (arg2 as u128) / 1000000;
        if (v0 >= (arg0 as u128)) {
            0
        } else {
            arg0 - (v0 as u64)
        }
    }

    fun check_grace_period(arg0: &mut Plant, arg1: &0xce69c367e9f26eb554efbb379776f0f0d213cae6f87803fbfe8b304f925e47cc::config::GameConfig, arg2: u64) {
        let v0 = GracePeriodKey{dummy_field: false};
        if (*0x2::dynamic_field::borrow<GracePeriodKey, bool>(&arg0.id, v0) && arg2 - arg0.born_at >= 0xce69c367e9f26eb554efbb379776f0f0d213cae6f87803fbfe8b304f925e47cc::config::grace_period_ms(arg1)) {
            let v1 = GracePeriodKey{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<GracePeriodKey, bool>(&mut arg0.id, v1) = false;
            let v2 = DrainRateKey{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<DrainRateKey, u64>(&mut arg0.id, v2) = 0xce69c367e9f26eb554efbb379776f0f0d213cae6f87803fbfe8b304f925e47cc::config::drain_rate_normal(arg1);
        };
    }

    fun check_growth_advance(arg0: &mut Plant, arg1: address, arg2: u64) {
        let v0 = HealthKey{dummy_field: false};
        if (*0x2::dynamic_field::borrow<HealthKey, u64>(&arg0.id, v0) < 50) {
            return
        };
        let v1 = arg2 - arg0.born_at;
        let v2 = GrowthStageKey{dummy_field: false};
        let v3 = 0x2::dynamic_field::borrow_mut<GrowthStageKey, u8>(&mut arg0.id, v2);
        let v4 = if (v1 >= 6 * 86400000) {
            4
        } else if (v1 >= 4 * 86400000) {
            3
        } else if (v1 >= 2 * 86400000) {
            2
        } else if (v1 >= 1 * 86400000) {
            1
        } else {
            0
        };
        if (v4 > *v3) {
            *v3 = v4;
            0xce69c367e9f26eb554efbb379776f0f0d213cae6f87803fbfe8b304f925e47cc::events::emit_plant_grew(0x2::object::id<Plant>(arg0), arg1, v4);
        };
    }

    public fun check_plant(arg0: &mut Plant, arg1: &0xce69c367e9f26eb554efbb379776f0f0d213cae6f87803fbfe8b304f925e47cc::config::GameConfig, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        0xce69c367e9f26eb554efbb379776f0f0d213cae6f87803fbfe8b304f925e47cc::config::assert_version(arg1);
        if (!arg0.is_alive) {
            return
        };
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = HealthKey{dummy_field: false};
        let v2 = LastWateredKey{dummy_field: false};
        let v3 = DrainRateKey{dummy_field: false};
        let v4 = calculate_health(*0x2::dynamic_field::borrow<HealthKey, u64>(&arg0.id, v1), *0x2::dynamic_field::borrow<LastWateredKey, u64>(&arg0.id, v2), *0x2::dynamic_field::borrow<DrainRateKey, u64>(&arg0.id, v3), v0);
        let v5 = HealthKey{dummy_field: false};
        *0x2::dynamic_field::borrow_mut<HealthKey, u64>(&mut arg0.id, v5) = v4;
        if (v4 == 0) {
            arg0.is_alive = false;
            0xce69c367e9f26eb554efbb379776f0f0d213cae6f87803fbfe8b304f925e47cc::events::emit_plant_died(0x2::object::id<Plant>(arg0), 0x2::tx_context::sender(arg3), v0 - arg0.born_at);
            return
        };
        check_grace_period(arg0, arg1, v0);
        check_growth_advance(arg0, 0x2::tx_context::sender(arg3), v0);
    }

    public fun drain_rate(arg0: &Plant) : u64 {
        let v0 = DrainRateKey{dummy_field: false};
        *0x2::dynamic_field::borrow<DrainRateKey, u64>(&arg0.id, v0)
    }

    public fun growth_stage(arg0: &Plant) : u8 {
        let v0 = GrowthStageKey{dummy_field: false};
        *0x2::dynamic_field::borrow<GrowthStageKey, u8>(&arg0.id, v0)
    }

    public fun health(arg0: &Plant) : u64 {
        let v0 = HealthKey{dummy_field: false};
        *0x2::dynamic_field::borrow<HealthKey, u64>(&arg0.id, v0)
    }

    public fun is_alive(arg0: &Plant) : bool {
        arg0.is_alive
    }

    public fun is_grace_period(arg0: &Plant) : bool {
        let v0 = GracePeriodKey{dummy_field: false};
        *0x2::dynamic_field::borrow<GracePeriodKey, bool>(&arg0.id, v0)
    }

    public fun last_watered(arg0: &Plant) : u64 {
        let v0 = LastWateredKey{dummy_field: false};
        *0x2::dynamic_field::borrow<LastWateredKey, u64>(&arg0.id, v0)
    }

    public fun mint_plant(arg0: &0xce69c367e9f26eb554efbb379776f0f0d213cae6f87803fbfe8b304f925e47cc::config::GameConfig, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        0xce69c367e9f26eb554efbb379776f0f0d213cae6f87803fbfe8b304f925e47cc::config::assert_version(arg0);
        0xce69c367e9f26eb554efbb379776f0f0d213cae6f87803fbfe8b304f925e47cc::config::assert_not_paused(arg0);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = Plant{
            id       : 0x2::object::new(arg2),
            is_alive : true,
            born_at  : v0,
            version  : 1,
        };
        let v2 = HealthKey{dummy_field: false};
        0x2::dynamic_field::add<HealthKey, u64>(&mut v1.id, v2, 100);
        let v3 = WaterLevelKey{dummy_field: false};
        0x2::dynamic_field::add<WaterLevelKey, u64>(&mut v1.id, v3, 100);
        let v4 = GrowthStageKey{dummy_field: false};
        0x2::dynamic_field::add<GrowthStageKey, u8>(&mut v1.id, v4, 0);
        let v5 = LastWateredKey{dummy_field: false};
        0x2::dynamic_field::add<LastWateredKey, u64>(&mut v1.id, v5, v0);
        let v6 = GracePeriodKey{dummy_field: false};
        0x2::dynamic_field::add<GracePeriodKey, bool>(&mut v1.id, v6, true);
        let v7 = DrainRateKey{dummy_field: false};
        0x2::dynamic_field::add<DrainRateKey, u64>(&mut v1.id, v7, 0xce69c367e9f26eb554efbb379776f0f0d213cae6f87803fbfe8b304f925e47cc::config::drain_rate_grace(arg0));
        let v8 = 0x2::tx_context::sender(arg2);
        0x2::transfer::transfer<Plant>(v1, v8);
        0xce69c367e9f26eb554efbb379776f0f0d213cae6f87803fbfe8b304f925e47cc::events::emit_plant_created(0x2::object::id<Plant>(&v1), v8, v0);
    }

    public fun water_level(arg0: &Plant) : u64 {
        let v0 = WaterLevelKey{dummy_field: false};
        *0x2::dynamic_field::borrow<WaterLevelKey, u64>(&arg0.id, v0)
    }

    public fun water_plant(arg0: &mut Plant, arg1: &mut 0xce69c367e9f26eb554efbb379776f0f0d213cae6f87803fbfe8b304f925e47cc::water::WaterJug, arg2: &mut 0x2::coin::TreasuryCap<0xce69c367e9f26eb554efbb379776f0f0d213cae6f87803fbfe8b304f925e47cc::water::WATER>, arg3: &0xce69c367e9f26eb554efbb379776f0f0d213cae6f87803fbfe8b304f925e47cc::config::GameConfig, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0xce69c367e9f26eb554efbb379776f0f0d213cae6f87803fbfe8b304f925e47cc::config::assert_version(arg3);
        0xce69c367e9f26eb554efbb379776f0f0d213cae6f87803fbfe8b304f925e47cc::config::assert_not_paused(arg3);
        assert!(arg0.is_alive, 200);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = HealthKey{dummy_field: false};
        let v2 = LastWateredKey{dummy_field: false};
        let v3 = *0x2::dynamic_field::borrow<LastWateredKey, u64>(&arg0.id, v2);
        let v4 = DrainRateKey{dummy_field: false};
        let v5 = calculate_health(*0x2::dynamic_field::borrow<HealthKey, u64>(&arg0.id, v1), v3, *0x2::dynamic_field::borrow<DrainRateKey, u64>(&arg0.id, v4), v0);
        if (v5 == 0) {
            arg0.is_alive = false;
            let v6 = HealthKey{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<HealthKey, u64>(&mut arg0.id, v6) = 0;
            0xce69c367e9f26eb554efbb379776f0f0d213cae6f87803fbfe8b304f925e47cc::events::emit_plant_died(0x2::object::id<Plant>(arg0), 0x2::tx_context::sender(arg5), v0 - arg0.born_at);
            return
        };
        assert!(v0 - v3 >= 0xce69c367e9f26eb554efbb379776f0f0d213cae6f87803fbfe8b304f925e47cc::config::watering_cooldown_ms(arg3), 201);
        0xce69c367e9f26eb554efbb379776f0f0d213cae6f87803fbfe8b304f925e47cc::water::burn(arg2, 0xce69c367e9f26eb554efbb379776f0f0d213cae6f87803fbfe8b304f925e47cc::water::consume(arg1, 0xce69c367e9f26eb554efbb379776f0f0d213cae6f87803fbfe8b304f925e47cc::config::water_per_watering(arg3)));
        let v7 = v5 + 0xce69c367e9f26eb554efbb379776f0f0d213cae6f87803fbfe8b304f925e47cc::config::health_restore(arg3);
        let v8 = if (v7 > 0xce69c367e9f26eb554efbb379776f0f0d213cae6f87803fbfe8b304f925e47cc::config::max_health(arg3)) {
            0xce69c367e9f26eb554efbb379776f0f0d213cae6f87803fbfe8b304f925e47cc::config::max_health(arg3)
        } else {
            v7
        };
        let v9 = HealthKey{dummy_field: false};
        *0x2::dynamic_field::borrow_mut<HealthKey, u64>(&mut arg0.id, v9) = v8;
        let v10 = LastWateredKey{dummy_field: false};
        *0x2::dynamic_field::borrow_mut<LastWateredKey, u64>(&mut arg0.id, v10) = v0;
        check_grace_period(arg0, arg3, v0);
        check_growth_advance(arg0, 0x2::tx_context::sender(arg5), v0);
        let v11 = GrowthStageKey{dummy_field: false};
        0xce69c367e9f26eb554efbb379776f0f0d213cae6f87803fbfe8b304f925e47cc::events::emit_plant_watered(0x2::object::id<Plant>(arg0), 0x2::tx_context::sender(arg5), v8, *0x2::dynamic_field::borrow<GrowthStageKey, u8>(&arg0.id, v11));
    }

    // decompiled from Move bytecode v6
}

