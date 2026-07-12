module 0x674db3e3726a0153e717be26e3227a6f67e9af24fc8a2943c86c0a6b0a6e318b::registry {
    struct Registry has key {
        id: 0x2::object::UID,
        items: 0x2::table::Table<u16, ItemDef>,
        equipment: 0x2::table::Table<u16, EquipmentDef>,
        activities: 0x2::table::Table<u16, ActivityDef>,
        recipes: 0x2::table::Table<u16, RecipeDef>,
        enemies: 0x2::table::Table<u16, EnemyDef>,
        locations: 0x2::table::Table<u16, LocationDef>,
        max_offline_ms: u64,
        start_location: u16,
        start_coins: u64,
        hp_per_level: u64,
        hunt_finds_per_hour_base: u64,
        version: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ItemDef has copy, drop, store {
        name: 0x1::string::String,
        vendor_buy: u64,
        vendor_sell: u64,
        heal: u64,
    }

    struct EquipmentDef has copy, drop, store {
        name: 0x1::string::String,
        slot: u8,
        tier: u8,
        level_req: u8,
        attack: u64,
        defence: u64,
        dexterity: u64,
        speed: u64,
        vendor_sell: u64,
    }

    struct ActivityDef has copy, drop, store {
        skill: u8,
        location: u16,
        level_req: u8,
        duration_ms: u64,
        xp: u64,
        output_kind: u16,
        output_qty: u64,
        input_kind: u16,
        input_qty: u64,
    }

    struct RecipeDef has copy, drop, store {
        skill: u8,
        level_req: u8,
        duration_ms: u64,
        xp: u64,
        input_kinds: vector<u16>,
        input_qtys: vector<u64>,
        output_kind: u16,
        output_qty: u64,
        output_equipment: u16,
        fuel_kind: u16,
        fuel_burn_ms: u64,
    }

    struct EnemyDef has copy, drop, store {
        level: u8,
        hp: u64,
        attack: u64,
        defence: u64,
        speed: u64,
        xp_per_kill: u64,
        coin_min: u64,
        coin_max: u64,
        loot_kinds: vector<u16>,
        loot_qtys: vector<u64>,
        loot_chances_bp: vector<u64>,
    }

    struct LocationDef has copy, drop, store {
        level_req: u16,
        x: u16,
        y: u16,
        teleport_cost: u64,
        enemy_ids: vector<u16>,
        enemy_weights: vector<u64>,
    }

    public fun activity(arg0: &Registry, arg1: u16) : ActivityDef {
        assert!(0x2::table::contains<u16, ActivityDef>(&arg0.activities, arg1), 13906835711941672961);
        *0x2::table::borrow<u16, ActivityDef>(&arg0.activities, arg1)
    }

    public fun activity_duration_ms(arg0: &ActivityDef) : u64 {
        arg0.duration_ms
    }

    public fun activity_input_kind(arg0: &ActivityDef) : u16 {
        arg0.input_kind
    }

    public fun activity_input_qty(arg0: &ActivityDef) : u64 {
        arg0.input_qty
    }

    public fun activity_level_req(arg0: &ActivityDef) : u8 {
        arg0.level_req
    }

    public fun activity_location(arg0: &ActivityDef) : u16 {
        arg0.location
    }

    public fun activity_output_kind(arg0: &ActivityDef) : u16 {
        arg0.output_kind
    }

    public fun activity_output_qty(arg0: &ActivityDef) : u64 {
        arg0.output_qty
    }

    public fun activity_skill(arg0: &ActivityDef) : u8 {
        arg0.skill
    }

    public fun activity_xp(arg0: &ActivityDef) : u64 {
        arg0.xp
    }

    public fun add_activity(arg0: &AdminCap, arg1: &mut Registry, arg2: u16, arg3: u8, arg4: u16, arg5: u8, arg6: u64, arg7: u64, arg8: u16, arg9: u64, arg10: u16, arg11: u64) {
        let v0 = ActivityDef{
            skill       : arg3,
            location    : arg4,
            level_req   : arg5,
            duration_ms : arg6,
            xp          : arg7,
            output_kind : arg8,
            output_qty  : arg9,
            input_kind  : arg10,
            input_qty   : arg11,
        };
        if (0x2::table::contains<u16, ActivityDef>(&arg1.activities, arg2)) {
            0x2::table::remove<u16, ActivityDef>(&mut arg1.activities, arg2);
        };
        0x2::table::add<u16, ActivityDef>(&mut arg1.activities, arg2, v0);
    }

    public fun add_enemy(arg0: &AdminCap, arg1: &mut Registry, arg2: u16, arg3: u8, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: vector<u16>, arg12: vector<u64>, arg13: vector<u64>) {
        assert!(0x1::vector::length<u16>(&arg11) == 0x1::vector::length<u64>(&arg12) && 0x1::vector::length<u16>(&arg11) == 0x1::vector::length<u64>(&arg13), 13906835501488406531);
        let v0 = EnemyDef{
            level           : arg3,
            hp              : arg4,
            attack          : arg5,
            defence         : arg6,
            speed           : arg7,
            xp_per_kill     : arg8,
            coin_min        : arg9,
            coin_max        : arg10,
            loot_kinds      : arg11,
            loot_qtys       : arg12,
            loot_chances_bp : arg13,
        };
        if (0x2::table::contains<u16, EnemyDef>(&arg1.enemies, arg2)) {
            0x2::table::remove<u16, EnemyDef>(&mut arg1.enemies, arg2);
        };
        0x2::table::add<u16, EnemyDef>(&mut arg1.enemies, arg2, v0);
    }

    public fun add_equipment(arg0: &AdminCap, arg1: &mut Registry, arg2: u16, arg3: 0x1::string::String, arg4: u8, arg5: u8, arg6: u8, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64) {
        let v0 = EquipmentDef{
            name        : arg3,
            slot        : arg4,
            tier        : arg5,
            level_req   : arg6,
            attack      : arg7,
            defence     : arg8,
            dexterity   : arg9,
            speed       : arg10,
            vendor_sell : arg11,
        };
        if (0x2::table::contains<u16, EquipmentDef>(&arg1.equipment, arg2)) {
            0x2::table::remove<u16, EquipmentDef>(&mut arg1.equipment, arg2);
        };
        0x2::table::add<u16, EquipmentDef>(&mut arg1.equipment, arg2, v0);
    }

    public fun add_item(arg0: &AdminCap, arg1: &mut Registry, arg2: u16, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: u64) {
        let v0 = ItemDef{
            name        : arg3,
            vendor_buy  : arg4,
            vendor_sell : arg5,
            heal        : arg6,
        };
        if (0x2::table::contains<u16, ItemDef>(&arg1.items, arg2)) {
            0x2::table::remove<u16, ItemDef>(&mut arg1.items, arg2);
        };
        0x2::table::add<u16, ItemDef>(&mut arg1.items, arg2, v0);
    }

    public fun add_location(arg0: &AdminCap, arg1: &mut Registry, arg2: u16, arg3: u16, arg4: u16, arg5: u16, arg6: u64, arg7: vector<u16>, arg8: vector<u64>) {
        assert!(0x1::vector::length<u16>(&arg7) == 0x1::vector::length<u64>(&arg8), 13906835630337425411);
        let v0 = LocationDef{
            level_req     : arg3,
            x             : arg4,
            y             : arg5,
            teleport_cost : arg6,
            enemy_ids     : arg7,
            enemy_weights : arg8,
        };
        if (0x2::table::contains<u16, LocationDef>(&arg1.locations, arg2)) {
            0x2::table::remove<u16, LocationDef>(&mut arg1.locations, arg2);
        };
        0x2::table::add<u16, LocationDef>(&mut arg1.locations, arg2, v0);
    }

    public fun add_recipe(arg0: &AdminCap, arg1: &mut Registry, arg2: u16, arg3: u8, arg4: u8, arg5: u64, arg6: u64, arg7: vector<u16>, arg8: vector<u64>, arg9: u16, arg10: u64, arg11: u16, arg12: u16, arg13: u64) {
        assert!(0x1::vector::length<u16>(&arg7) == 0x1::vector::length<u64>(&arg8), 13906835342574616579);
        let v0 = RecipeDef{
            skill            : arg3,
            level_req        : arg4,
            duration_ms      : arg5,
            xp               : arg6,
            input_kinds      : arg7,
            input_qtys       : arg8,
            output_kind      : arg9,
            output_qty       : arg10,
            output_equipment : arg11,
            fuel_kind        : arg12,
            fuel_burn_ms     : arg13,
        };
        if (0x2::table::contains<u16, RecipeDef>(&arg1.recipes, arg2)) {
            0x2::table::remove<u16, RecipeDef>(&mut arg1.recipes, arg2);
        };
        0x2::table::add<u16, RecipeDef>(&mut arg1.recipes, arg2, v0);
    }

    public(friend) fun assert_version(arg0: &Registry) {
        assert!(arg0.version == 2, 13906834857243443205);
    }

    public fun enemy(arg0: &Registry, arg1: u16) : EnemyDef {
        assert!(0x2::table::contains<u16, EnemyDef>(&arg0.enemies, arg1), 13906835754891345921);
        *0x2::table::borrow<u16, EnemyDef>(&arg0.enemies, arg1)
    }

    public fun enemy_attack(arg0: &EnemyDef) : u64 {
        arg0.attack
    }

    public fun enemy_coin_max(arg0: &EnemyDef) : u64 {
        arg0.coin_max
    }

    public fun enemy_coin_min(arg0: &EnemyDef) : u64 {
        arg0.coin_min
    }

    public fun enemy_defence(arg0: &EnemyDef) : u64 {
        arg0.defence
    }

    public fun enemy_hp(arg0: &EnemyDef) : u64 {
        arg0.hp
    }

    public fun enemy_level(arg0: &EnemyDef) : u8 {
        arg0.level
    }

    public fun enemy_loot_chances_bp(arg0: &EnemyDef) : vector<u64> {
        arg0.loot_chances_bp
    }

    public fun enemy_loot_kinds(arg0: &EnemyDef) : vector<u16> {
        arg0.loot_kinds
    }

    public fun enemy_loot_qtys(arg0: &EnemyDef) : vector<u64> {
        arg0.loot_qtys
    }

    public fun enemy_speed(arg0: &EnemyDef) : u64 {
        arg0.speed
    }

    public fun enemy_xp_per_kill(arg0: &EnemyDef) : u64 {
        arg0.xp_per_kill
    }

    public fun equipment(arg0: &Registry, arg1: u16) : EquipmentDef {
        assert!(0x2::table::contains<u16, EquipmentDef>(&arg0.equipment, arg1), 13906835690466836481);
        *0x2::table::borrow<u16, EquipmentDef>(&arg0.equipment, arg1)
    }

    public fun equipment_attack(arg0: &EquipmentDef) : u64 {
        arg0.attack
    }

    public fun equipment_defence(arg0: &EquipmentDef) : u64 {
        arg0.defence
    }

    public fun equipment_dexterity(arg0: &EquipmentDef) : u64 {
        arg0.dexterity
    }

    public fun equipment_level_req(arg0: &EquipmentDef) : u8 {
        arg0.level_req
    }

    public fun equipment_name(arg0: &EquipmentDef) : 0x1::string::String {
        arg0.name
    }

    public fun equipment_slot(arg0: &EquipmentDef) : u8 {
        arg0.slot
    }

    public fun equipment_speed(arg0: &EquipmentDef) : u64 {
        arg0.speed
    }

    public fun equipment_tier(arg0: &EquipmentDef) : u8 {
        arg0.tier
    }

    public fun equipment_vendor_sell(arg0: &EquipmentDef) : u64 {
        arg0.vendor_sell
    }

    public fun has_location(arg0: &Registry, arg1: u16) : bool {
        0x2::table::contains<u16, LocationDef>(&arg0.locations, arg1)
    }

    public fun hp_per_level(arg0: &Registry) : u64 {
        arg0.hp_per_level
    }

    public fun hunt_finds_per_hour_base(arg0: &Registry) : u64 {
        arg0.hunt_finds_per_hour_base
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id                       : 0x2::object::new(arg0),
            items                    : 0x2::table::new<u16, ItemDef>(arg0),
            equipment                : 0x2::table::new<u16, EquipmentDef>(arg0),
            activities               : 0x2::table::new<u16, ActivityDef>(arg0),
            recipes                  : 0x2::table::new<u16, RecipeDef>(arg0),
            enemies                  : 0x2::table::new<u16, EnemyDef>(arg0),
            locations                : 0x2::table::new<u16, LocationDef>(arg0),
            max_offline_ms           : 43200000,
            start_location           : 1,
            start_coins              : 25,
            hp_per_level             : 10,
            hunt_finds_per_hour_base : 40,
            version                  : 2,
        };
        0x2::transfer::share_object<Registry>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun item(arg0: &Registry, arg1: u16) : ItemDef {
        assert!(0x2::table::contains<u16, ItemDef>(&arg0.items, arg1), 13906835668992000001);
        *0x2::table::borrow<u16, ItemDef>(&arg0.items, arg1)
    }

    public fun item_heal(arg0: &ItemDef) : u64 {
        arg0.heal
    }

    public fun item_name(arg0: &ItemDef) : 0x1::string::String {
        arg0.name
    }

    public fun item_vendor_buy(arg0: &ItemDef) : u64 {
        arg0.vendor_buy
    }

    public fun item_vendor_sell(arg0: &ItemDef) : u64 {
        arg0.vendor_sell
    }

    public fun location(arg0: &Registry, arg1: u16) : LocationDef {
        assert!(0x2::table::contains<u16, LocationDef>(&arg0.locations, arg1), 13906835776366182401);
        *0x2::table::borrow<u16, LocationDef>(&arg0.locations, arg1)
    }

    public fun location_enemy_ids(arg0: &LocationDef) : vector<u16> {
        arg0.enemy_ids
    }

    public fun location_enemy_weights(arg0: &LocationDef) : vector<u64> {
        arg0.enemy_weights
    }

    public fun location_level_req(arg0: &LocationDef) : u16 {
        arg0.level_req
    }

    public fun location_teleport_cost(arg0: &LocationDef) : u64 {
        arg0.teleport_cost
    }

    public fun location_x(arg0: &LocationDef) : u16 {
        arg0.x
    }

    public fun location_y(arg0: &LocationDef) : u16 {
        arg0.y
    }

    public fun max_offline_ms(arg0: &Registry) : u64 {
        arg0.max_offline_ms
    }

    public fun recipe(arg0: &Registry, arg1: u16) : RecipeDef {
        assert!(0x2::table::contains<u16, RecipeDef>(&arg0.recipes, arg1), 13906835733416509441);
        *0x2::table::borrow<u16, RecipeDef>(&arg0.recipes, arg1)
    }

    public fun recipe_duration_ms(arg0: &RecipeDef) : u64 {
        arg0.duration_ms
    }

    public fun recipe_fuel_burn_ms(arg0: &RecipeDef) : u64 {
        arg0.fuel_burn_ms
    }

    public fun recipe_fuel_kind(arg0: &RecipeDef) : u16 {
        arg0.fuel_kind
    }

    public fun recipe_input_kinds(arg0: &RecipeDef) : vector<u16> {
        arg0.input_kinds
    }

    public fun recipe_input_qtys(arg0: &RecipeDef) : vector<u64> {
        arg0.input_qtys
    }

    public fun recipe_level_req(arg0: &RecipeDef) : u8 {
        arg0.level_req
    }

    public fun recipe_output_equipment(arg0: &RecipeDef) : u16 {
        arg0.output_equipment
    }

    public fun recipe_output_kind(arg0: &RecipeDef) : u16 {
        arg0.output_kind
    }

    public fun recipe_output_qty(arg0: &RecipeDef) : u64 {
        arg0.output_qty
    }

    public fun recipe_skill(arg0: &RecipeDef) : u8 {
        arg0.skill
    }

    public fun recipe_xp(arg0: &RecipeDef) : u64 {
        arg0.xp
    }

    public fun set_globals(arg0: &AdminCap, arg1: &mut Registry, arg2: u64, arg3: u16, arg4: u64, arg5: u64, arg6: u64) {
        arg1.max_offline_ms = arg2;
        arg1.start_location = arg3;
        arg1.start_coins = arg4;
        arg1.hp_per_level = arg5;
        arg1.hunt_finds_per_hour_base = arg6;
    }

    public fun set_version(arg0: &AdminCap, arg1: &mut Registry, arg2: u64) {
        arg1.version = arg2;
    }

    public fun start_coins(arg0: &Registry) : u64 {
        arg0.start_coins
    }

    public fun start_location(arg0: &Registry) : u16 {
        arg0.start_location
    }

    // decompiled from Move bytecode v7
}

