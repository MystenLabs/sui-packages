module 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ibuildings {
    struct BuildingRegistry has key {
        id: 0x2::object::UID,
        building_max_level: u64,
        building_configs: 0x2::vec_map::VecMap<0x1::string::String, 0x2::vec_map::VecMap<u64, 0x2::vec_map::VecMap<0x1::string::String, u128>>>,
    }

    struct UpgradeCost has drop, store {
        building_name: 0x1::string::String,
        cash: u128,
        weapon: u128,
        turf: u128,
    }

    struct Resources has drop, store {
        produced_by: 0x1::string::String,
        amount: u128,
        claim_info: ResourceClaimInfo,
    }

    struct ResourceClaimInfo has drop, store {
        last_claimed_ts: u64,
        total_claimed: u128,
    }

    struct BuildingInfo has drop, store {
        produces: 0x1::string::String,
        current_level: u64,
        production_rate: u128,
        storage_capacity: u128,
        upgrade_wait_ms: u128,
        upgrade_cost: UpgradeCost,
    }

    public(friend) fun add_resource_amount(arg0: &mut Resources, arg1: u128) {
        arg0.amount = arg0.amount + arg1;
    }

    public fun borrow_building_info(arg0: &BuildingInfo) : vector<u128> {
        let v0 = 0x1::vector::empty<u128>();
        let v1 = &mut v0;
        0x1::vector::push_back<u128>(v1, arg0.production_rate);
        0x1::vector::push_back<u128>(v1, arg0.storage_capacity);
        0x1::vector::push_back<u128>(v1, arg0.upgrade_wait_ms);
        v0
    }

    public(friend) fun borrow_building_initial_config(arg0: &BuildingInfo) : &UpgradeCost {
        &arg0.upgrade_cost
    }

    public fun borrow_building_level(arg0: &BuildingInfo) : u64 {
        arg0.current_level
    }

    public fun borrow_building_max_level(arg0: &BuildingRegistry) : u64 {
        arg0.building_max_level
    }

    public fun borrow_building_production_type(arg0: &BuildingInfo) : 0x1::string::String {
        arg0.produces
    }

    public fun borrow_building_upgrade_cost(arg0: &BuildingInfo) : &UpgradeCost {
        &arg0.upgrade_cost
    }

    public fun borrow_building_upgrade_value(arg0: &BuildingRegistry, arg1: 0x1::string::String) : 0x2::vec_map::VecMap<u64, 0x2::vec_map::VecMap<0x1::string::String, u128>> {
        *0x2::vec_map::get<0x1::string::String, 0x2::vec_map::VecMap<u64, 0x2::vec_map::VecMap<0x1::string::String, u128>>>(&arg0.building_configs, &arg1)
    }

    public fun borrow_building_upgrade_wait_ts(arg0: &mut BuildingInfo) : u128 {
        arg0.upgrade_wait_ms
    }

    public(friend) fun borrow_last_claimed_ts(arg0: &Resources) : u64 {
        arg0.claim_info.last_claimed_ts
    }

    public(friend) fun borrow_resource_amount(arg0: &Resources) : u128 {
        arg0.amount
    }

    public fun borrow_upgrade_info(arg0: &UpgradeCost) : vector<u128> {
        let v0 = 0x1::vector::empty<u128>();
        let v1 = &mut v0;
        0x1::vector::push_back<u128>(v1, arg0.cash);
        0x1::vector::push_back<u128>(v1, arg0.turf);
        0x1::vector::push_back<u128>(v1, arg0.weapon);
        v0
    }

    public fun check_building_level(arg0: &BuildingRegistry, arg1: u64) : bool {
        arg1 <= arg0.building_max_level
    }

    public fun check_building_name(arg0: &BuildingRegistry, arg1: 0x1::string::String) : bool {
        0x2::vec_map::contains<0x1::string::String, 0x2::vec_map::VecMap<u64, 0x2::vec_map::VecMap<0x1::string::String, u128>>>(&arg0.building_configs, &arg1)
    }

    public(friend) fun decrease_building_level(arg0: &mut BuildingInfo) {
        arg0.current_level = arg0.current_level - 1;
    }

    public fun get_scaled_config_value(arg0: 0x1::string::String, arg1: u128) : u128 {
        if (arg0 == 0x1::string::utf8(b"upgrade_wait_ms")) {
            arg1
        } else if (arg0 == 0x1::string::utf8(b"production_rate")) {
            0x1::uq64_64::to_raw(0x1::uq64_64::from_quotient(arg1, 3600))
        } else if (arg0 == 0x1::string::utf8(b"upgrade_turf_cost")) {
            arg1
        } else {
            (arg1 as u128) * 0x1::u128::pow(2, 64)
        }
    }

    public(friend) fun increase_building_level(arg0: &mut BuildingInfo) {
        arg0.current_level = arg0.current_level + 1;
    }

    public(friend) fun new(arg0: u128, arg1: 0x1::string::String, arg2: &0x2::clock::Clock) : Resources {
        let v0 = ResourceClaimInfo{
            last_claimed_ts : 0x2::clock::timestamp_ms(arg2),
            total_claimed   : 0,
        };
        Resources{
            produced_by : arg1,
            amount      : arg0,
            claim_info  : v0,
        }
    }

    public(friend) fun new_building(arg0: 0x1::string::String, arg1: u128, arg2: u128, arg3: u128, arg4: 0x1::string::String, arg5: u128, arg6: u128, arg7: u128) : BuildingInfo {
        let v0 = UpgradeCost{
            building_name : arg4,
            cash          : arg5,
            weapon        : arg7,
            turf          : arg6,
        };
        BuildingInfo{
            produces         : arg0,
            current_level    : 1,
            production_rate  : arg1,
            storage_capacity : arg2,
            upgrade_wait_ms  : arg3,
            upgrade_cost     : v0,
        }
    }

    public(friend) fun reset_claim_timestamp(arg0: &mut Resources, arg1: u64) {
        arg0.claim_info.last_claimed_ts = arg1;
    }

    public(friend) fun set_building_configs(arg0: &mut BuildingRegistry, arg1: 0x1::string::String, arg2: u64, arg3: 0x1::string::String, arg4: u128) {
        if (check_building_name(arg0, arg1)) {
            let v0 = 0x2::vec_map::empty<0x1::string::String, u128>();
            0x2::vec_map::insert<0x1::string::String, u128>(&mut v0, arg3, arg4);
            if (0x2::vec_map::contains<u64, 0x2::vec_map::VecMap<0x1::string::String, u128>>(0x2::vec_map::get<0x1::string::String, 0x2::vec_map::VecMap<u64, 0x2::vec_map::VecMap<0x1::string::String, u128>>>(&arg0.building_configs, &arg1), &arg2)) {
                if (0x2::vec_map::contains<0x1::string::String, u128>(0x2::vec_map::get<u64, 0x2::vec_map::VecMap<0x1::string::String, u128>>(0x2::vec_map::get<0x1::string::String, 0x2::vec_map::VecMap<u64, 0x2::vec_map::VecMap<0x1::string::String, u128>>>(&arg0.building_configs, &arg1), &arg2), &arg3)) {
                    *0x2::vec_map::get_mut<0x1::string::String, u128>(0x2::vec_map::get_mut<u64, 0x2::vec_map::VecMap<0x1::string::String, u128>>(0x2::vec_map::get_mut<0x1::string::String, 0x2::vec_map::VecMap<u64, 0x2::vec_map::VecMap<0x1::string::String, u128>>>(&mut arg0.building_configs, &arg1), &arg2), &arg3) = arg4;
                } else {
                    0x2::vec_map::insert<0x1::string::String, u128>(0x2::vec_map::get_mut<u64, 0x2::vec_map::VecMap<0x1::string::String, u128>>(0x2::vec_map::get_mut<0x1::string::String, 0x2::vec_map::VecMap<u64, 0x2::vec_map::VecMap<0x1::string::String, u128>>>(&mut arg0.building_configs, &arg1), &arg2), arg3, arg4);
                };
            } else {
                let v1 = 0x2::vec_map::empty<0x1::string::String, u128>();
                0x2::vec_map::insert<0x1::string::String, u128>(&mut v1, arg3, arg4);
                0x2::vec_map::insert<u64, 0x2::vec_map::VecMap<0x1::string::String, u128>>(0x2::vec_map::get_mut<0x1::string::String, 0x2::vec_map::VecMap<u64, 0x2::vec_map::VecMap<0x1::string::String, u128>>>(&mut arg0.building_configs, &arg1), arg2, v1);
            };
        } else {
            let v2 = 0x2::vec_map::empty<0x1::string::String, u128>();
            0x2::vec_map::insert<0x1::string::String, u128>(&mut v2, arg3, arg4);
            let v3 = 0x2::vec_map::empty<u64, 0x2::vec_map::VecMap<0x1::string::String, u128>>();
            0x2::vec_map::insert<u64, 0x2::vec_map::VecMap<0x1::string::String, u128>>(&mut v3, arg2, v2);
            0x2::vec_map::insert<0x1::string::String, 0x2::vec_map::VecMap<u64, 0x2::vec_map::VecMap<0x1::string::String, u128>>>(&mut arg0.building_configs, arg1, v3);
        };
    }

    public(friend) fun set_building_max_level(arg0: &mut BuildingRegistry, arg1: u64) {
        arg0.building_max_level = arg1;
    }

    public(friend) fun set_building_production_rate(arg0: &mut BuildingInfo, arg1: u128) {
        arg0.production_rate = arg1;
    }

    public(friend) fun set_building_storage_capacity(arg0: &mut BuildingInfo, arg1: u128) {
        arg0.storage_capacity = arg1;
    }

    public(friend) fun set_building_upgrade_cash_cost(arg0: &mut BuildingInfo, arg1: u128) {
        arg0.upgrade_cost.cash = arg1;
    }

    public(friend) fun set_building_upgrade_turf_cost(arg0: &mut BuildingInfo, arg1: u128) {
        arg0.upgrade_cost.turf = arg1;
    }

    public(friend) fun set_building_upgrade_wait_ts(arg0: &mut BuildingInfo, arg1: u128) {
        arg0.upgrade_wait_ms = arg1;
    }

    public(friend) fun set_building_upgrade_weapon_cost(arg0: &mut BuildingInfo, arg1: u128) {
        arg0.upgrade_cost.weapon = arg1;
    }

    public(friend) fun subtract_resource_amount(arg0: &mut Resources, arg1: u128) {
        arg0.amount = arg0.amount - arg1;
    }

    // decompiled from Move bytecode v6
}

