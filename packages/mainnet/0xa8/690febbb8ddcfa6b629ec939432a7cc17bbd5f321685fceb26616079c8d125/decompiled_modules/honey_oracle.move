module 0xa8690febbb8ddcfa6b629ec939432a7cc17bbd5f321685fceb26616079c8d125::honey_oracle {
    struct HONEY_ORACLE has drop {
        dummy_field: bool,
    }

    struct HoneyOracle has store, key {
        id: 0x2::object::UID,
        nectar_cap: 0x44427466f8bd3e4a9e3476139027401775c1fbc4639db3aa1b129e79f0c3d259::honey_yield::NectarCap,
        sui_honey_pool_addr: 0x1::option::Option<address>,
        snapshots: 0x2::linked_table::LinkedTable<u64, HoneyTwapSnapshot>,
        window_size: u64,
        tolerance: u64,
        honey_sui_twap: u256,
        emission_config: EmissionConfig,
        emission_state: EmissionState,
        module_version: u64,
    }

    struct HoneyTwapSnapshot has copy, drop, store {
        timestamp: u64,
        honey_sui_cum_price: u256,
        snapshot_timestamp: u64,
    }

    struct EmissionConfig has store {
        epoch_duration: u64,
        neutral_band_bps: u64,
        cut_step_bps: u64,
        cut_cap_bps: u64,
        raise_step_bps: u64,
        max_weekly_raise_bps: u64,
        raise_confirm_epochs: u64,
    }

    struct EmissionState has store {
        current_emission_rate: u64,
        last_epoch_update: u64,
        anchor_price: u256,
        anchor_time: u64,
        in_neutral: bool,
        direction: u8,
        last_price: u256,
        consec_down_epochs: u64,
        consec_up_epochs: u64,
        weekly_raises_sum: u64,
        last_weekly_reset: u64,
    }

    struct HoneyOracleUpdated has copy, drop {
        sui_honey_pool_addr: 0x1::option::Option<address>,
        window_size: u64,
        tolerance: u64,
    }

    struct HoneyOracleSnapshotRecorded has copy, drop {
        timestamp: u64,
        honey_sui_cum_price: u256,
        snapshot_timestamp: u64,
    }

    struct EmissionRateUpdated has copy, drop {
        old_emission_rate: u64,
        new_emission_rate: u64,
        current_price: u256,
        anchor_price: u256,
        change_percent_bps: u64,
        direction: u8,
        reason: u8,
    }

    struct NeutralZoneStateChanged has copy, drop {
        in_neutral: bool,
        anchor_price: u256,
        current_price: u256,
        direction: u8,
    }

    struct EmissionConfigUpdated has copy, drop {
        epoch_duration: u64,
        neutral_band_bps: u64,
        cut_step_bps: u64,
        cut_cap_bps: u64,
        raise_step_bps: u64,
        max_weekly_raise_bps: u64,
        raise_confirm_epochs: u64,
    }

    struct HoneyOracleTwapUpdated has copy, drop {
        honey_sui_twap: u256,
        timestamp: u64,
    }

    struct HoneyOracleSnapshotInfo has drop, store {
        timestamp: vector<u64>,
        honey_sui_cum_price: vector<u256>,
        snapshot_timestamp: vector<u64>,
        count: u64,
    }

    struct EmissionDistributionState {
        current_emission_rate: u64,
        anchor_price: u256,
        anchor_time: u64,
        in_neutral: bool,
        direction: u8,
        last_price: u256,
        consec_down_epochs: u64,
        consec_up_epochs: u64,
        last_epoch_update: u64,
        weekly_raises_sum: u64,
    }

    public fun admin_update_emission_rate(arg0: &0x44427466f8bd3e4a9e3476139027401775c1fbc4639db3aa1b129e79f0c3d259::honey_yield::HoneyYieldAdminCap, arg1: &mut HoneyOracle, arg2: &mut 0xaabd4014517e7b6f1c30b53815ba2b39296b5ca76e578f86af091432579a9d2c::honey_manager::HoneyManager, arg3: &0x2::clock::Clock, arg4: u64) {
        assert!(arg1.module_version == 0, 1975);
        assert!(arg4 > 0, 1980);
        arg1.emission_state.current_emission_rate = arg4;
        0xaabd4014517e7b6f1c30b53815ba2b39296b5ca76e578f86af091432579a9d2c::honey_manager::update_distribution_rate_via_nectar(&arg1.nectar_cap, arg2, arg3, arg1.emission_state.current_emission_rate);
        arg1.emission_state.consec_down_epochs = 0;
        arg1.emission_state.consec_up_epochs = 0;
        let v0 = EmissionRateUpdated{
            old_emission_rate  : arg1.emission_state.current_emission_rate,
            new_emission_rate  : arg4,
            current_price      : arg1.emission_state.last_price,
            anchor_price       : arg1.emission_state.anchor_price,
            change_percent_bps : 0,
            direction          : arg1.emission_state.direction,
            reason             : 0,
        };
        0x2::event::emit<EmissionRateUpdated>(v0);
    }

    fun calculate_twap(arg0: u256, arg1: u256, arg2: u64) : u256 {
        let v0 = if (arg0 >= arg1) {
            arg0 - arg1
        } else {
            0x1ba840a419648fedd184ada1f61fe907daa4aedfffd0d1423ddd8aaa90e4d623::math::overflow_add_u256(arg0, 0x1ba840a419648fedd184ada1f61fe907daa4aedfffd0d1423ddd8aaa90e4d623::math::sub_from_max_u256(arg1))
        };
        if (v0 == 0) {
            return 0
        };
        0x1ba840a419648fedd184ada1f61fe907daa4aedfffd0d1423ddd8aaa90e4d623::math::mul_div_u256(v0 / (arg2 as u256), (0x1ba840a419648fedd184ada1f61fe907daa4aedfffd0d1423ddd8aaa90e4d623::math::pow_10(6) as u256), (0x1ba840a419648fedd184ada1f61fe907daa4aedfffd0d1423ddd8aaa90e4d623::math::pow_10(9) as u256))
    }

    public fun get_current_emission_rate(arg0: &HoneyOracle) : u64 {
        arg0.emission_state.current_emission_rate
    }

    public fun get_emission_distribution_state(arg0: &HoneyOracle) : (u64, u256, bool, u64, u256, u8, u64, u64, u64, u64) {
        (arg0.emission_state.current_emission_rate, arg0.emission_state.anchor_price, arg0.emission_state.in_neutral, arg0.emission_state.anchor_time, arg0.emission_state.last_price, arg0.emission_state.direction, arg0.emission_state.consec_down_epochs, arg0.emission_state.consec_up_epochs, arg0.emission_state.last_epoch_update, arg0.emission_state.weekly_raises_sum)
    }

    public fun get_emission_distribution_state_info(arg0: &HoneyOracle) : EmissionDistributionState {
        EmissionDistributionState{
            current_emission_rate : arg0.emission_state.current_emission_rate,
            anchor_price          : arg0.emission_state.anchor_price,
            anchor_time           : arg0.emission_state.anchor_time,
            in_neutral            : arg0.emission_state.in_neutral,
            direction             : arg0.emission_state.direction,
            last_price            : arg0.emission_state.last_price,
            consec_down_epochs    : arg0.emission_state.consec_down_epochs,
            consec_up_epochs      : arg0.emission_state.consec_up_epochs,
            last_epoch_update     : arg0.emission_state.last_epoch_update,
            weekly_raises_sum     : arg0.emission_state.weekly_raises_sum,
        }
    }

    public fun get_honey_sui_twap_price(arg0: &HoneyOracle) : u256 {
        assert!(arg0.module_version == 0, 1975);
        if (0x2::linked_table::length<u64, HoneyTwapSnapshot>(&arg0.snapshots) < 2) {
            return 0
        };
        let v0 = *0x2::linked_table::front<u64, HoneyTwapSnapshot>(&arg0.snapshots);
        if (0x1::option::is_none<u64>(&v0)) {
            return 0
        };
        let v1 = *0x2::linked_table::borrow<u64, HoneyTwapSnapshot>(&arg0.snapshots, *0x1::option::borrow<u64>(&v0));
        let v2 = 0x1::option::none<HoneyTwapSnapshot>();
        let v3 = *0x2::linked_table::back<u64, HoneyTwapSnapshot>(&arg0.snapshots);
        while (0x1::option::is_some<u64>(&v3) && 0x2::linked_table::length<u64, HoneyTwapSnapshot>(&arg0.snapshots) > 0) {
            let v4 = 0x1::option::borrow<u64>(&v3);
            let v5 = *0x2::linked_table::borrow<u64, HoneyTwapSnapshot>(&arg0.snapshots, *v4);
            let v6 = v1.timestamp - v5.timestamp;
            if (arg0.window_size > v6 && arg0.window_size - v6 <= arg0.tolerance) {
                v2 = 0x1::option::some<HoneyTwapSnapshot>(v5);
                break
            };
            if (v6 > arg0.window_size && v6 - arg0.window_size <= arg0.tolerance) {
                v2 = 0x1::option::some<HoneyTwapSnapshot>(v5);
                break
            };
            v3 = *0x2::linked_table::prev<u64, HoneyTwapSnapshot>(&arg0.snapshots, *v4);
        };
        if (0x1::option::is_some<HoneyTwapSnapshot>(&v2)) {
            let v8 = *0x1::option::borrow<HoneyTwapSnapshot>(&v2);
            calculate_twap(v1.honey_sui_cum_price, v8.honey_sui_cum_price, v1.snapshot_timestamp - v8.snapshot_timestamp)
        } else {
            0
        }
    }

    public fun get_honey_twap_price(arg0: &HoneyOracle) : u256 {
        arg0.honey_sui_twap
    }

    public fun increment_oracle(arg0: &mut HoneyOracle) {
        assert!(arg0.module_version < 0, 1976);
        arg0.module_version = 0;
    }

    fun init(arg0: HONEY_ORACLE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<HONEY_ORACLE>(arg0, arg1);
        let v1 = 0x2::display::new<HoneyOracle>(&v0, arg1);
        0x2::display::add<HoneyOracle>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Honey Oracle"));
        0x2::display::add<HoneyOracle>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"TWAP-based emission governor. Cuts fast on drawdowns, raises cautiously on strength; updates HoneyManager via NectarCap."));
        0x2::display::add<HoneyOracle>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://assets.honeyplay.ai/global_objects/honey_oracle.png"));
        0x2::display::add<HoneyOracle>(&mut v1, 0x1::string::utf8(b"project"), 0x1::string::utf8(b"https://honeyplay.fun"));
        0x2::display::add<HoneyOracle>(&mut v1, 0x1::string::utf8(b"SUI-HONEY pool"), 0x1::string::utf8(b"{sui_honey_pool_addr}"));
        0x2::display::add<HoneyOracle>(&mut v1, 0x1::string::utf8(b"TWAP window size"), 0x1::string::utf8(b"{window_size}"));
        0x2::display::add<HoneyOracle>(&mut v1, 0x1::string::utf8(b"TWAP tolerance"), 0x1::string::utf8(b"{tolerance}"));
        0x2::display::add<HoneyOracle>(&mut v1, 0x1::string::utf8(b"HONEY-SUI TWAP"), 0x1::string::utf8(b"{honey_sui_twap}"));
        0x2::display::update_version<HoneyOracle>(&mut v1);
        0x2::transfer::public_transfer<0x2::display::Display<HoneyOracle>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun is_epoch_update_due(arg0: &HoneyOracle, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) - arg0.emission_state.last_epoch_update >= arg0.emission_config.epoch_duration
    }

    public fun query_across_all_snapshots(arg0: &HoneyOracle, arg1: 0x1::option::Option<u64>, arg2: u64) : HoneyOracleSnapshotInfo {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0x1::vector::empty<u256>();
        let v2 = 0x1::vector::empty<u64>();
        let v3 = if (0x1::option::is_some<u64>(&arg1)) {
            arg1
        } else {
            *0x2::linked_table::front<u64, HoneyTwapSnapshot>(&arg0.snapshots)
        };
        let v4 = v3;
        let v5 = 0;
        while (0x1::option::is_some<u64>(&v4) && v5 < arg2) {
            let v6 = *0x1::option::borrow<u64>(&v4);
            let v7 = 0x2::linked_table::borrow<u64, HoneyTwapSnapshot>(&arg0.snapshots, v6);
            0x1::vector::push_back<u64>(&mut v0, v7.timestamp);
            0x1::vector::push_back<u256>(&mut v1, v7.honey_sui_cum_price);
            0x1::vector::push_back<u64>(&mut v2, v7.snapshot_timestamp);
            v4 = *0x2::linked_table::next<u64, HoneyTwapSnapshot>(&arg0.snapshots, v6);
            v5 = v5 + 1;
        };
        HoneyOracleSnapshotInfo{
            timestamp           : v0,
            honey_sui_cum_price : v1,
            snapshot_timestamp  : v2,
            count               : 0x2::linked_table::length<u64, HoneyTwapSnapshot>(&arg0.snapshots),
        }
    }

    public fun setup_honey_oracle(arg0: &0x44427466f8bd3e4a9e3476139027401775c1fbc4639db3aa1b129e79f0c3d259::honey_yield::HoneyYieldAdminCap, arg1: 0x44427466f8bd3e4a9e3476139027401775c1fbc4639db3aa1b129e79f0c3d259::honey_yield::NectarCap, arg2: &mut 0xaabd4014517e7b6f1c30b53815ba2b39296b5ca76e578f86af091432579a9d2c::honey_manager::HoneyManager, arg3: &0x2::clock::Clock, arg4: address, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg5 > 0, 1980);
        let v0 = 0x2::tx_context::epoch_timestamp_ms(arg6);
        let v1 = EmissionConfig{
            epoch_duration       : 10800000,
            neutral_band_bps     : 300,
            cut_step_bps         : 300,
            cut_cap_bps          : 3000,
            raise_step_bps       : 100,
            max_weekly_raise_bps : 5000,
            raise_confirm_epochs : 3,
        };
        let v2 = EmissionState{
            current_emission_rate : arg5,
            last_epoch_update     : v0,
            anchor_price          : 0,
            anchor_time           : v0,
            in_neutral            : true,
            direction             : 0,
            last_price            : 0,
            consec_down_epochs    : 0,
            consec_up_epochs      : 0,
            weekly_raises_sum     : 0,
            last_weekly_reset     : v0,
        };
        let v3 = HoneyOracle{
            id                  : 0x2::object::new(arg6),
            nectar_cap          : arg1,
            sui_honey_pool_addr : 0x1::option::some<address>(arg4),
            snapshots           : 0x2::linked_table::new<u64, HoneyTwapSnapshot>(arg6),
            window_size         : 900000,
            tolerance           : 180000,
            honey_sui_twap      : 0,
            emission_config     : v1,
            emission_state      : v2,
            module_version      : 0,
        };
        0xaabd4014517e7b6f1c30b53815ba2b39296b5ca76e578f86af091432579a9d2c::honey_manager::update_distribution_rate_via_nectar(&v3.nectar_cap, arg2, arg3, v3.emission_state.current_emission_rate);
        0x2::transfer::share_object<HoneyOracle>(v3);
        let v4 = EmissionConfigUpdated{
            epoch_duration       : 10800000,
            neutral_band_bps     : 300,
            cut_step_bps         : 300,
            cut_cap_bps          : 3000,
            raise_step_bps       : 100,
            max_weekly_raise_bps : 5000,
            raise_confirm_epochs : 3,
        };
        0x2::event::emit<EmissionConfigUpdated>(v4);
    }

    public fun time_until_next_epoch(arg0: &HoneyOracle, arg1: &0x2::clock::Clock) : u64 {
        let v0 = arg0.emission_config.epoch_duration;
        let v1 = 0x2::clock::timestamp_ms(arg1) - arg0.emission_state.last_epoch_update;
        if (v1 >= v0) {
            0
        } else {
            v0 - v1
        }
    }

    public fun trigger_epoch_update_if_due(arg0: &mut HoneyOracle, arg1: &mut 0xaabd4014517e7b6f1c30b53815ba2b39296b5ca76e578f86af091432579a9d2c::honey_manager::HoneyManager, arg2: &0x2::clock::Clock) {
        assert!(arg0.module_version == 0, 1975);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 - arg0.emission_state.last_epoch_update >= arg0.emission_config.epoch_duration, 1981);
        let v1 = get_honey_sui_twap_price(arg0);
        if (v1 > 0) {
            update_emission_distribution(arg0, arg1, arg2, v1, v0);
        };
    }

    fun update_emission_distribution(arg0: &mut HoneyOracle, arg1: &mut 0xaabd4014517e7b6f1c30b53815ba2b39296b5ca76e578f86af091432579a9d2c::honey_manager::HoneyManager, arg2: &0x2::clock::Clock, arg3: u256, arg4: u64) {
        if (arg4 - arg0.emission_state.last_weekly_reset >= 604800000) {
            arg0.emission_state.weekly_raises_sum = 0;
            arg0.emission_state.last_weekly_reset = arg4;
        };
        let v0 = arg0.emission_config.neutral_band_bps;
        let v1 = arg0.emission_config.cut_cap_bps;
        let v2 = arg0.emission_config.raise_step_bps;
        if (arg0.emission_state.anchor_price == 0) {
            arg0.emission_state.anchor_price = arg3;
            arg0.emission_state.anchor_time = arg4;
            arg0.emission_state.last_price = arg3;
            arg0.emission_state.last_epoch_update = arg4;
            let v3 = EmissionRateUpdated{
                old_emission_rate  : arg0.emission_state.current_emission_rate,
                new_emission_rate  : arg0.emission_state.current_emission_rate,
                current_price      : arg3,
                anchor_price       : arg0.emission_state.anchor_price,
                change_percent_bps : 0,
                direction          : 0,
                reason             : 0,
            };
            0x2::event::emit<EmissionRateUpdated>(v3);
            return
        };
        let v4 = if (arg3 >= arg0.emission_state.anchor_price) {
            (0x1ba840a419648fedd184ada1f61fe907daa4aedfffd0d1423ddd8aaa90e4d623::math::mul_div_u128(((arg3 - arg0.emission_state.anchor_price) as u128), (10000 as u128), (arg0.emission_state.anchor_price as u128)) as u64)
        } else {
            (0x1ba840a419648fedd184ada1f61fe907daa4aedfffd0d1423ddd8aaa90e4d623::math::mul_div_u128(((arg0.emission_state.anchor_price - arg3) as u128), (10000 as u128), (arg0.emission_state.anchor_price as u128)) as u64)
        };
        let v5 = if (arg3 > arg0.emission_state.anchor_price) {
            1
        } else if (arg3 < arg0.emission_state.anchor_price) {
            2
        } else {
            0
        };
        if (arg0.emission_state.in_neutral && v4 <= v0) {
            arg0.emission_state.direction = v5;
            arg0.emission_state.last_price = arg3;
            arg0.emission_state.last_epoch_update = arg4;
            return
        };
        let v6 = if (arg0.emission_state.in_neutral) {
            if (arg0.emission_state.direction == 1 && arg3 > arg0.emission_state.anchor_price || arg0.emission_state.direction == 2 && arg3 < arg0.emission_state.anchor_price) {
                arg0.emission_state.anchor_price
            } else {
                arg0.emission_state.last_price
            }
        } else {
            arg0.emission_state.anchor_price
        };
        let v7 = if (arg3 >= v6) {
            (0x1ba840a419648fedd184ada1f61fe907daa4aedfffd0d1423ddd8aaa90e4d623::math::mul_div_u128(((arg3 - v6) as u128), (10000 as u128), (v6 as u128)) as u64)
        } else {
            (0x1ba840a419648fedd184ada1f61fe907daa4aedfffd0d1423ddd8aaa90e4d623::math::mul_div_u128(((v6 - arg3) as u128), (10000 as u128), (v6 as u128)) as u64)
        };
        let v8 = 3;
        if (arg3 < v6 && v7 >= v0) {
            arg0.emission_state.consec_down_epochs = arg0.emission_state.consec_down_epochs + 1;
            arg0.emission_state.consec_up_epochs = 0;
            let v9 = arg0.emission_config.cut_step_bps * arg0.emission_state.consec_down_epochs;
            let v10 = if (v9 > v1) {
                v1
            } else {
                v9
            };
            arg0.emission_state.current_emission_rate = (0x1ba840a419648fedd184ada1f61fe907daa4aedfffd0d1423ddd8aaa90e4d623::math::mul_div_u128((arg0.emission_state.current_emission_rate as u128), ((10000 - v10) as u128), (10000 as u128)) as u64);
            arg0.emission_state.in_neutral = true;
            arg0.emission_state.anchor_price = arg3;
            arg0.emission_state.anchor_time = arg4;
            arg0.emission_state.direction = 0;
            v8 = 1;
        } else if (arg3 > v6 && v7 >= v0) {
            arg0.emission_state.consec_up_epochs = arg0.emission_state.consec_up_epochs + 1;
            arg0.emission_state.consec_down_epochs = 0;
            if (arg0.emission_state.consec_up_epochs >= arg0.emission_config.raise_confirm_epochs) {
                if (arg0.emission_state.weekly_raises_sum + v2 <= arg0.emission_config.max_weekly_raise_bps) {
                    arg0.emission_state.current_emission_rate = (0x1ba840a419648fedd184ada1f61fe907daa4aedfffd0d1423ddd8aaa90e4d623::math::mul_div_u128((arg0.emission_state.current_emission_rate as u128), ((10000 + v2) as u128), (10000 as u128)) as u64);
                    arg0.emission_state.weekly_raises_sum = arg0.emission_state.weekly_raises_sum + v2;
                    v8 = 2;
                };
            };
            arg0.emission_state.in_neutral = true;
            arg0.emission_state.anchor_price = arg3;
            arg0.emission_state.anchor_time = arg4;
            arg0.emission_state.direction = 0;
        } else {
            arg0.emission_state.in_neutral = true;
            arg0.emission_state.direction = v5;
        };
        arg0.emission_state.last_price = arg3;
        arg0.emission_state.last_epoch_update = arg4;
        0xaabd4014517e7b6f1c30b53815ba2b39296b5ca76e578f86af091432579a9d2c::honey_manager::update_distribution_rate_via_nectar(&arg0.nectar_cap, arg1, arg2, arg0.emission_state.current_emission_rate);
        let v11 = EmissionRateUpdated{
            old_emission_rate  : arg0.emission_state.current_emission_rate,
            new_emission_rate  : arg0.emission_state.current_emission_rate,
            current_price      : arg3,
            anchor_price       : arg0.emission_state.anchor_price,
            change_percent_bps : v7,
            direction          : arg0.emission_state.direction,
            reason             : v8,
        };
        0x2::event::emit<EmissionRateUpdated>(v11);
        let v12 = NeutralZoneStateChanged{
            in_neutral    : arg0.emission_state.in_neutral,
            anchor_price  : arg0.emission_state.anchor_price,
            current_price : arg3,
            direction     : arg0.emission_state.direction,
        };
        0x2::event::emit<NeutralZoneStateChanged>(v12);
    }

    public fun update_honey_oracle(arg0: &0x44427466f8bd3e4a9e3476139027401775c1fbc4639db3aa1b129e79f0c3d259::honey_yield::HoneyYieldAdminCap, arg1: &mut HoneyOracle, arg2: 0x1::option::Option<address>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.module_version == 0, 1975);
        if (0x1::option::is_some<address>(&arg2)) {
            arg1.sui_honey_pool_addr = arg2;
        };
        if (arg3 > 0) {
            assert!(arg3 <= 18000000, 1977);
            arg1.window_size = arg3;
        };
        if (arg4 > 0) {
            assert!(arg4 <= 600000, 1978);
            arg1.tolerance = arg4;
        };
        let v0 = HoneyOracleUpdated{
            sui_honey_pool_addr : arg1.sui_honey_pool_addr,
            window_size         : arg1.window_size,
            tolerance           : arg1.tolerance,
        };
        0x2::event::emit<HoneyOracleUpdated>(v0);
    }

    public fun update_honey_oracle_emission_config(arg0: &0x44427466f8bd3e4a9e3476139027401775c1fbc4639db3aa1b129e79f0c3d259::honey_yield::HoneyYieldAdminCap, arg1: &mut HoneyOracle, arg2: 0x1::option::Option<u64>, arg3: 0x1::option::Option<u64>, arg4: 0x1::option::Option<u64>, arg5: 0x1::option::Option<u64>, arg6: 0x1::option::Option<u64>, arg7: 0x1::option::Option<u64>, arg8: 0x1::option::Option<u64>) {
        assert!(arg1.module_version == 0, 1975);
        if (0x1::option::is_some<u64>(&arg2)) {
            let v0 = *0x1::option::borrow<u64>(&arg2);
            assert!(v0 > 60000 && v0 <= 86400000, 1982);
            arg1.emission_config.epoch_duration = v0;
        };
        if (0x1::option::is_some<u64>(&arg3)) {
            arg1.emission_config.neutral_band_bps = *0x1::option::borrow<u64>(&arg3);
        };
        if (0x1::option::is_some<u64>(&arg4)) {
            arg1.emission_config.cut_step_bps = *0x1::option::borrow<u64>(&arg4);
        };
        if (0x1::option::is_some<u64>(&arg5)) {
            arg1.emission_config.cut_cap_bps = *0x1::option::borrow<u64>(&arg5);
        };
        if (0x1::option::is_some<u64>(&arg6)) {
            arg1.emission_config.raise_step_bps = *0x1::option::borrow<u64>(&arg6);
        };
        if (0x1::option::is_some<u64>(&arg7)) {
            arg1.emission_config.max_weekly_raise_bps = *0x1::option::borrow<u64>(&arg7);
        };
        if (0x1::option::is_some<u64>(&arg8)) {
            arg1.emission_config.raise_confirm_epochs = *0x1::option::borrow<u64>(&arg8);
        };
        let v1 = EmissionConfigUpdated{
            epoch_duration       : arg1.emission_config.epoch_duration,
            neutral_band_bps     : arg1.emission_config.neutral_band_bps,
            cut_step_bps         : arg1.emission_config.cut_step_bps,
            cut_cap_bps          : arg1.emission_config.cut_cap_bps,
            raise_step_bps       : arg1.emission_config.raise_step_bps,
            max_weekly_raise_bps : arg1.emission_config.max_weekly_raise_bps,
            raise_confirm_epochs : arg1.emission_config.raise_confirm_epochs,
        };
        0x2::event::emit<EmissionConfigUpdated>(v1);
    }

    public fun update_honey_oracle_price<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut HoneyOracle, arg2: &mut 0xaabd4014517e7b6f1c30b53815ba2b39296b5ca76e578f86af091432579a9d2c::honey_manager::HoneyManager, arg3: &0xaabd4014517e7b6f1c30b53815ba2b39296b5ca76e578f86af091432579a9d2c::amm::LiquidityPool<T0, T1, T2>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg0);
        assert!(arg1.module_version == 0, 1975);
        let v1 = *0x2::linked_table::back<u64, HoneyTwapSnapshot>(&arg1.snapshots);
        if (0x1::option::is_some<u64>(&v1)) {
            if (v0 - 0x2::linked_table::borrow<u64, HoneyTwapSnapshot>(&arg1.snapshots, *0x1::option::borrow<u64>(&v1)).timestamp < arg1.tolerance) {
                return
            };
        };
        let v2 = 0xaabd4014517e7b6f1c30b53815ba2b39296b5ca76e578f86af091432579a9d2c::amm::get_liquidity_pool_id<T0, T1, T2>(arg3);
        assert!(0x2::object::id_to_address(&v2) == *0x1::option::borrow<address>(&arg1.sui_honey_pool_addr), 1974);
        let (_, v4, v5) = 0xaabd4014517e7b6f1c30b53815ba2b39296b5ca76e578f86af091432579a9d2c::amm::get_pool_cumulative_prices<T0, T1, T2>(arg3);
        while (0x2::linked_table::length<u64, HoneyTwapSnapshot>(&arg1.snapshots) > 0) {
            let (v6, v7) = 0x2::linked_table::pop_back<u64, HoneyTwapSnapshot>(&mut arg1.snapshots);
            let v8 = v7;
            if (v0 - arg1.window_size + arg1.tolerance < v8.timestamp) {
                0x2::linked_table::push_back<u64, HoneyTwapSnapshot>(&mut arg1.snapshots, v6, v8);
                break
            };
        };
        let v9 = HoneyTwapSnapshot{
            timestamp           : v0,
            honey_sui_cum_price : v4,
            snapshot_timestamp  : v5,
        };
        let v10 = HoneyOracleSnapshotRecorded{
            timestamp           : v0,
            honey_sui_cum_price : v4,
            snapshot_timestamp  : v5,
        };
        0x2::event::emit<HoneyOracleSnapshotRecorded>(v10);
        let v11 = 0x1::option::none<HoneyTwapSnapshot>();
        let v12 = *0x2::linked_table::back<u64, HoneyTwapSnapshot>(&arg1.snapshots);
        while (0x1::option::is_some<u64>(&v12) && 0x2::linked_table::length<u64, HoneyTwapSnapshot>(&arg1.snapshots) > 0) {
            let v13 = 0x1::option::borrow<u64>(&v12);
            let v14 = *0x2::linked_table::borrow<u64, HoneyTwapSnapshot>(&arg1.snapshots, *v13);
            let v15 = v9.timestamp - v14.timestamp;
            if (arg1.window_size > v15 && arg1.window_size - v15 <= arg1.tolerance) {
                v11 = 0x1::option::some<HoneyTwapSnapshot>(v14);
                break
            };
            if (v15 > arg1.window_size && v15 - arg1.window_size <= arg1.tolerance) {
                v11 = 0x1::option::some<HoneyTwapSnapshot>(v14);
                break
            };
            v12 = *0x2::linked_table::prev<u64, HoneyTwapSnapshot>(&arg1.snapshots, *v13);
        };
        if (0x1::option::is_some<HoneyTwapSnapshot>(&v11)) {
            let v16 = *0x1::option::borrow<HoneyTwapSnapshot>(&v11);
            let v17 = calculate_twap(v9.honey_sui_cum_price, v16.honey_sui_cum_price, v9.snapshot_timestamp - v16.snapshot_timestamp);
            if (v17 > 0) {
                arg1.honey_sui_twap = v17;
                let v18 = HoneyOracleTwapUpdated{
                    honey_sui_twap : v17,
                    timestamp      : 0x2::clock::timestamp_ms(arg0),
                };
                0x2::event::emit<HoneyOracleTwapUpdated>(v18);
            };
        };
        0x2::linked_table::push_back<u64, HoneyTwapSnapshot>(&mut arg1.snapshots, 0x2::linked_table::length<u64, HoneyTwapSnapshot>(&arg1.snapshots), v9);
        let v19 = arg1.honey_sui_twap;
        if (v0 - arg1.emission_state.last_epoch_update >= arg1.emission_config.epoch_duration && v19 > 0) {
            update_emission_distribution(arg1, arg2, arg0, v19, v0);
        };
    }

    // decompiled from Move bytecode v6
}

