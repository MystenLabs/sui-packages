module 0xb40c31c9227c35f5d9010f94404a46d44233e8249402b06b0779f8cc8b1aec1b::tycoon {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct GameData has store, key {
        id: 0x2::object::UID,
        map_registry: 0xb40c31c9227c35f5d9010f94404a46d44233e8249402b06b0779f8cc8b1aec1b::map::MapRegistry,
        card_registry: 0xb40c31c9227c35f5d9010f94404a46d44233e8249402b06b0779f8cc8b1aec1b::cards::CardRegistry,
        drop_config: 0xb40c31c9227c35f5d9010f94404a46d44233e8249402b06b0779f8cc8b1aec1b::cards::DropConfig,
        starting_cash: u64,
        rent_multipliers: vector<u64>,
        temple_multipliers: vector<u64>,
        building_upgrade_costs: vector<u64>,
        large_building_costs: vector<u64>,
        npc_spawn_weights: vector<u8>,
        map_schema_version: u8,
    }

    entry fun publish_map_from_bcs(arg0: &mut GameData, arg1: u8, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 == get_map_schema_version(arg0), 3021);
        let (v0, v1, v2) = 0xb40c31c9227c35f5d9010f94404a46d44233e8249402b06b0779f8cc8b1aec1b::map::publish_map_from_bcs(arg1, arg2, arg3, arg5);
        0xb40c31c9227c35f5d9010f94404a46d44233e8249402b06b0779f8cc8b1aec1b::events::emit_map_template_published_event(v0, 0x2::tx_context::sender(arg5), v1, v2);
    }

    entry fun admin_register_card(arg0: &mut GameData, arg1: u8, arg2: vector<u8>, arg3: vector<u8>, arg4: u8, arg5: u64, arg6: u8, arg7: &AdminCap, arg8: &mut 0x2::tx_context::TxContext) {
        0xb40c31c9227c35f5d9010f94404a46d44233e8249402b06b0779f8cc8b1aec1b::cards::register_card_for_admin(&mut arg0.card_registry, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    fun create_admin_cap(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public(friend) fun get_building_upgrade_costs(arg0: &GameData) : &vector<u64> {
        &arg0.building_upgrade_costs
    }

    public(friend) fun get_default_price_rise_days() : u8 {
        15
    }

    public(friend) fun get_default_starting_cash() : u64 {
        100000
    }

    public(friend) fun get_large_building_costs(arg0: &GameData) : &vector<u64> {
        &arg0.large_building_costs
    }

    public(friend) fun get_map_schema_version(arg0: &GameData) : u8 {
        arg0.map_schema_version
    }

    public(friend) fun get_npc_spawn_weights(arg0: &GameData) : &vector<u8> {
        &arg0.npc_spawn_weights
    }

    public(friend) fun get_rent_multipliers(arg0: &GameData) : &vector<u64> {
        &arg0.rent_multipliers
    }

    public(friend) fun get_starting_cash(arg0: &GameData) : u64 {
        arg0.starting_cash
    }

    public(friend) fun get_temple_multipliers(arg0: &GameData) : &vector<u64> {
        &arg0.temple_multipliers
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        create_admin_cap(arg0);
        let v0 = 0x1::vector::empty<u8>();
        let v1 = &mut v0;
        0x1::vector::push_back<u8>(v1, 0xb40c31c9227c35f5d9010f94404a46d44233e8249402b06b0779f8cc8b1aec1b::types::NPC_BOMB());
        0x1::vector::push_back<u8>(v1, 1);
        0x1::vector::push_back<u8>(v1, 0xb40c31c9227c35f5d9010f94404a46d44233e8249402b06b0779f8cc8b1aec1b::types::NPC_DOG());
        0x1::vector::push_back<u8>(v1, 2);
        0x1::vector::push_back<u8>(v1, 0xb40c31c9227c35f5d9010f94404a46d44233e8249402b06b0779f8cc8b1aec1b::types::NPC_LAND_GOD());
        0x1::vector::push_back<u8>(v1, 1);
        0x1::vector::push_back<u8>(v1, 0xb40c31c9227c35f5d9010f94404a46d44233e8249402b06b0779f8cc8b1aec1b::types::NPC_WEALTH_GOD());
        0x1::vector::push_back<u8>(v1, 1);
        0x1::vector::push_back<u8>(v1, 0xb40c31c9227c35f5d9010f94404a46d44233e8249402b06b0779f8cc8b1aec1b::types::NPC_FORTUNE_GOD());
        0x1::vector::push_back<u8>(v1, 2);
        0x1::vector::push_back<u8>(v1, 0xb40c31c9227c35f5d9010f94404a46d44233e8249402b06b0779f8cc8b1aec1b::types::NPC_POOR_GOD());
        0x1::vector::push_back<u8>(v1, 1);
        let v2 = GameData{
            id                     : 0x2::object::new(arg0),
            map_registry           : 0xb40c31c9227c35f5d9010f94404a46d44233e8249402b06b0779f8cc8b1aec1b::map::create_registry_internal(arg0),
            card_registry          : 0xb40c31c9227c35f5d9010f94404a46d44233e8249402b06b0779f8cc8b1aec1b::cards::create_card_registry_internal(arg0),
            drop_config            : 0xb40c31c9227c35f5d9010f94404a46d44233e8249402b06b0779f8cc8b1aec1b::cards::create_drop_config_internal(arg0),
            starting_cash          : 12000,
            rent_multipliers       : vector[50, 100, 250, 500, 1000, 1500],
            temple_multipliers     : vector[130, 140, 150, 170, 200],
            building_upgrade_costs : vector[0, 1000, 1500, 6000, 15000, 35000],
            large_building_costs   : vector[2000, 3000, 7000, 18000, 40000],
            npc_spawn_weights      : v0,
            map_schema_version     : 1,
        };
        0x2::transfer::share_object<GameData>(v2);
        0xb40c31c9227c35f5d9010f94404a46d44233e8249402b06b0779f8cc8b1aec1b::events::emit_game_data_created_event(0x2::object::id<GameData>(&v2));
    }

    entry fun update_starting_cash(arg0: &mut GameData, arg1: u64, arg2: &AdminCap) {
        arg0.starting_cash = arg1;
    }

    public(friend) fun validate_max_rounds(arg0: u8) : u8 {
        if (arg0 == 0) {
            0
        } else if (arg0 < 10) {
            10
        } else if (arg0 > 200) {
            200
        } else {
            arg0
        }
    }

    public(friend) fun validate_price_rise_days(arg0: u8) : u8 {
        if (arg0 == 0) {
            15
        } else if (arg0 < 1) {
            1
        } else if (arg0 > 100) {
            100
        } else {
            arg0
        }
    }

    public(friend) fun validate_starting_cash(arg0: u64) : u64 {
        if (arg0 == 0) {
            100000
        } else if (arg0 < 10000) {
            10000
        } else if (arg0 > 500000) {
            500000
        } else {
            arg0
        }
    }

    // decompiled from Move bytecode v6
}

