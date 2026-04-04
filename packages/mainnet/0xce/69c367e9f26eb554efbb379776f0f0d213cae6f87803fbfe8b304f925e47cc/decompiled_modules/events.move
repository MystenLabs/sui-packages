module 0xce69c367e9f26eb554efbb379776f0f0d213cae6f87803fbfe8b304f925e47cc::events {
    struct PlantCreated has copy, drop {
        plant_id: 0x2::object::ID,
        owner: address,
        born_at_ms: u64,
    }

    struct PlantWatered has copy, drop {
        plant_id: 0x2::object::ID,
        owner: address,
        new_health: u64,
        growth_stage: u8,
    }

    struct PlantDied has copy, drop {
        plant_id: 0x2::object::ID,
        owner: address,
        lived_ms: u64,
    }

    struct PlantGrew has copy, drop {
        plant_id: 0x2::object::ID,
        owner: address,
        new_stage: u8,
    }

    struct WaterPurchased has copy, drop {
        buyer: address,
        dwl_spent: u64,
        water_amount: u64,
    }

    struct DWLPurchased has copy, drop {
        buyer: address,
        sui_spent: u64,
        dwl_received: u64,
    }

    public(friend) fun emit_dwl_purchased(arg0: address, arg1: u64, arg2: u64) {
        let v0 = DWLPurchased{
            buyer        : arg0,
            sui_spent    : arg1,
            dwl_received : arg2,
        };
        0x2::event::emit<DWLPurchased>(v0);
    }

    public(friend) fun emit_plant_created(arg0: 0x2::object::ID, arg1: address, arg2: u64) {
        let v0 = PlantCreated{
            plant_id   : arg0,
            owner      : arg1,
            born_at_ms : arg2,
        };
        0x2::event::emit<PlantCreated>(v0);
    }

    public(friend) fun emit_plant_died(arg0: 0x2::object::ID, arg1: address, arg2: u64) {
        let v0 = PlantDied{
            plant_id : arg0,
            owner    : arg1,
            lived_ms : arg2,
        };
        0x2::event::emit<PlantDied>(v0);
    }

    public(friend) fun emit_plant_grew(arg0: 0x2::object::ID, arg1: address, arg2: u8) {
        let v0 = PlantGrew{
            plant_id  : arg0,
            owner     : arg1,
            new_stage : arg2,
        };
        0x2::event::emit<PlantGrew>(v0);
    }

    public(friend) fun emit_plant_watered(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u8) {
        let v0 = PlantWatered{
            plant_id     : arg0,
            owner        : arg1,
            new_health   : arg2,
            growth_stage : arg3,
        };
        0x2::event::emit<PlantWatered>(v0);
    }

    public(friend) fun emit_water_purchased(arg0: address, arg1: u64, arg2: u64) {
        let v0 = WaterPurchased{
            buyer        : arg0,
            dwl_spent    : arg1,
            water_amount : arg2,
        };
        0x2::event::emit<WaterPurchased>(v0);
    }

    // decompiled from Move bytecode v6
}

