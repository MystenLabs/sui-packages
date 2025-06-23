module 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_schema {
    struct Schema has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun balance(arg0: &mut Schema) : &mut 0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_double_map::StorageDoubleMap<address, u256, u256> {
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage::borrow_mut_field<0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_double_map::StorageDoubleMap<address, u256, u256>>(&mut arg0.id, b"balance")
    }

    public fun borrow_balance(arg0: &Schema) : &0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_double_map::StorageDoubleMap<address, u256, u256> {
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage::borrow_field<0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_double_map::StorageDoubleMap<address, u256, u256>>(&arg0.id, b"balance")
    }

    public fun borrow_chest_item_drop_config(arg0: &Schema) : &0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::StorageValue<0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_item_drop::ItemDrop> {
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage::borrow_field<0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::StorageValue<0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_item_drop::ItemDrop>>(&arg0.id, b"chest_item_drop_config")
    }

    public fun borrow_encounter(arg0: &Schema) : &0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::StorageMap<address, 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_encounter_info::EncounterInfo> {
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage::borrow_field<0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::StorageMap<address, 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_encounter_info::EncounterInfo>>(&arg0.id, b"encounter")
    }

    public fun borrow_encounter_item_drop_config(arg0: &Schema) : &0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::StorageValue<0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_item_drop::ItemDrop> {
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage::borrow_field<0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::StorageValue<0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_item_drop::ItemDrop>>(&arg0.id, b"encounter_item_drop_config")
    }

    public fun borrow_encounter_trigger(arg0: &Schema) : &0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::StorageMap<0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_position::Position, bool> {
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage::borrow_field<0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::StorageMap<0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_position::Position, bool>>(&arg0.id, b"encounter_trigger")
    }

    public(friend) fun borrow_id(arg0: &Schema) : &0x2::object::UID {
        &arg0.id
    }

    public fun borrow_item_craft_path(arg0: &Schema) : &0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::StorageMap<u256, 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_craft_path::CraftPath> {
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage::borrow_field<0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::StorageMap<u256, 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_craft_path::CraftPath>>(&arg0.id, b"item_craft_path")
    }

    public fun borrow_item_metadata(arg0: &Schema) : &0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::StorageMap<u256, 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_item_metadata::ItemMetadata> {
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage::borrow_field<0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::StorageMap<u256, 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_item_metadata::ItemMetadata>>(&arg0.id, b"item_metadata")
    }

    public fun borrow_map_config(arg0: &Schema) : &0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::StorageMap<u64, 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_map_config::MapConfig> {
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage::borrow_field<0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::StorageMap<u64, 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_map_config::MapConfig>>(&arg0.id, b"map_config")
    }

    public fun borrow_map_layer(arg0: &Schema) : &0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_double_map::StorageDoubleMap<u64, 0x1::ascii::String, vector<u8>> {
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage::borrow_field<0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_double_map::StorageDoubleMap<u64, 0x1::ascii::String, vector<u8>>>(&arg0.id, b"map_layer")
    }

    public fun borrow_monster(arg0: &Schema) : &0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::StorageMap<u256, 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_monster_info::MonsterInfo> {
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage::borrow_field<0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::StorageMap<u256, 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_monster_info::MonsterInfo>>(&arg0.id, b"monster")
    }

    public fun borrow_monster_owned_by(arg0: &Schema) : &0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::StorageMap<u256, address> {
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage::borrow_field<0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::StorageMap<u256, address>>(&arg0.id, b"monster_owned_by")
    }

    public fun borrow_move_item_drop_config(arg0: &Schema) : &0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::StorageValue<0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_item_drop::ItemDrop> {
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage::borrow_field<0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::StorageValue<0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_item_drop::ItemDrop>>(&arg0.id, b"move_item_drop_config")
    }

    public fun borrow_next_item_id(arg0: &Schema) : &0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::StorageValue<u256> {
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage::borrow_field<0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::StorageValue<u256>>(&arg0.id, b"next_item_id")
    }

    public fun borrow_next_monster_id(arg0: &Schema) : &0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::StorageValue<u256> {
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage::borrow_field<0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::StorageValue<u256>>(&arg0.id, b"next_monster_id")
    }

    public fun borrow_obstruction(arg0: &Schema) : &0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::StorageMap<0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_position::Position, bool> {
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage::borrow_field<0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::StorageMap<0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_position::Position, bool>>(&arg0.id, b"obstruction")
    }

    public fun borrow_player(arg0: &Schema) : &0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::StorageMap<address, bool> {
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage::borrow_field<0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::StorageMap<address, bool>>(&arg0.id, b"player")
    }

    public fun borrow_position(arg0: &Schema) : &0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::StorageMap<address, 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_position::Position> {
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage::borrow_field<0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::StorageMap<address, 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_position::Position>>(&arg0.id, b"position")
    }

    public fun borrow_teleport_point(arg0: &Schema) : &0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::StorageMap<0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_position::Position, 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_position::Position> {
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage::borrow_field<0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::StorageMap<0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_position::Position, 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_position::Position>>(&arg0.id, b"teleport_point")
    }

    public(friend) fun chest_item_drop_config(arg0: &mut Schema) : &mut 0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::StorageValue<0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_item_drop::ItemDrop> {
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage::borrow_mut_field<0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::StorageValue<0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_item_drop::ItemDrop>>(&mut arg0.id, b"chest_item_drop_config")
    }

    public(friend) fun create(arg0: &mut 0x2::tx_context::TxContext) : Schema {
        let v0 = 0x2::object::new(arg0);
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage::add_field<0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::StorageMap<address, 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_encounter_info::EncounterInfo>>(&mut v0, b"encounter", 0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::new<address, 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_encounter_info::EncounterInfo>(b"encounter", arg0));
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage::add_field<0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::StorageMap<address, bool>>(&mut v0, b"player", 0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::new<address, bool>(b"player", arg0));
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage::add_field<0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::StorageMap<0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_position::Position, bool>>(&mut v0, b"obstruction", 0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::new<0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_position::Position, bool>(b"obstruction", arg0));
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage::add_field<0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::StorageMap<0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_position::Position, bool>>(&mut v0, b"encounter_trigger", 0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::new<0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_position::Position, bool>(b"encounter_trigger", arg0));
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage::add_field<0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_double_map::StorageDoubleMap<u64, 0x1::ascii::String, vector<u8>>>(&mut v0, b"map_layer", 0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_double_map::new<u64, 0x1::ascii::String, vector<u8>>(b"map_layer", arg0));
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage::add_field<0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::StorageMap<u64, 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_map_config::MapConfig>>(&mut v0, b"map_config", 0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::new<u64, 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_map_config::MapConfig>(b"map_config", arg0));
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage::add_field<0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::StorageMap<address, 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_position::Position>>(&mut v0, b"position", 0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::new<address, 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_position::Position>(b"position", arg0));
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage::add_field<0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::StorageMap<u256, 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_monster_info::MonsterInfo>>(&mut v0, b"monster", 0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::new<u256, 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_monster_info::MonsterInfo>(b"monster", arg0));
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage::add_field<0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::StorageValue<u256>>(&mut v0, b"next_monster_id", 0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::new<u256>(b"next_monster_id", arg0));
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage::add_field<0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::StorageValue<u256>>(&mut v0, b"next_item_id", 0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::new<u256>(b"next_item_id", arg0));
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage::add_field<0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::StorageMap<u256, address>>(&mut v0, b"monster_owned_by", 0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::new<u256, address>(b"monster_owned_by", arg0));
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage::add_field<0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_double_map::StorageDoubleMap<address, u256, u256>>(&mut v0, b"balance", 0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_double_map::new<address, u256, u256>(b"balance", arg0));
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage::add_field<0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::StorageMap<u256, 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_item_metadata::ItemMetadata>>(&mut v0, b"item_metadata", 0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::new<u256, 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_item_metadata::ItemMetadata>(b"item_metadata", arg0));
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage::add_field<0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::StorageValue<0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_item_drop::ItemDrop>>(&mut v0, b"move_item_drop_config", 0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::new<0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_item_drop::ItemDrop>(b"move_item_drop_config", arg0));
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage::add_field<0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::StorageValue<0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_item_drop::ItemDrop>>(&mut v0, b"chest_item_drop_config", 0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::new<0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_item_drop::ItemDrop>(b"chest_item_drop_config", arg0));
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage::add_field<0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::StorageValue<0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_item_drop::ItemDrop>>(&mut v0, b"encounter_item_drop_config", 0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::new<0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_item_drop::ItemDrop>(b"encounter_item_drop_config", arg0));
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage::add_field<0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::StorageMap<u256, 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_craft_path::CraftPath>>(&mut v0, b"item_craft_path", 0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::new<u256, 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_craft_path::CraftPath>(b"item_craft_path", arg0));
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage::add_field<0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::StorageMap<0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_position::Position, 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_position::Position>>(&mut v0, b"teleport_point", 0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::new<0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_position::Position, 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_position::Position>(b"teleport_point", arg0));
        Schema{id: v0}
    }

    public(friend) fun encounter(arg0: &mut Schema) : &mut 0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::StorageMap<address, 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_encounter_info::EncounterInfo> {
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage::borrow_mut_field<0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::StorageMap<address, 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_encounter_info::EncounterInfo>>(&mut arg0.id, b"encounter")
    }

    public(friend) fun encounter_item_drop_config(arg0: &mut Schema) : &mut 0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::StorageValue<0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_item_drop::ItemDrop> {
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage::borrow_mut_field<0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::StorageValue<0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_item_drop::ItemDrop>>(&mut arg0.id, b"encounter_item_drop_config")
    }

    public(friend) fun encounter_trigger(arg0: &mut Schema) : &mut 0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::StorageMap<0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_position::Position, bool> {
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage::borrow_mut_field<0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::StorageMap<0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_position::Position, bool>>(&mut arg0.id, b"encounter_trigger")
    }

    public fun get_balance(arg0: &Schema, arg1: address, arg2: u256) : &u256 {
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_double_map::get<address, u256, u256>(borrow_balance(arg0), arg1, arg2)
    }

    public fun get_chest_item_drop_config(arg0: &Schema) : &0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_item_drop::ItemDrop {
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::get<0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_item_drop::ItemDrop>(borrow_chest_item_drop_config(arg0))
    }

    public fun get_encounter(arg0: &Schema, arg1: address) : &0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_encounter_info::EncounterInfo {
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::get<address, 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_encounter_info::EncounterInfo>(borrow_encounter(arg0), arg1)
    }

    public fun get_encounter_item_drop_config(arg0: &Schema) : &0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_item_drop::ItemDrop {
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::get<0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_item_drop::ItemDrop>(borrow_encounter_item_drop_config(arg0))
    }

    public fun get_encounter_trigger(arg0: &Schema, arg1: 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_position::Position) : &bool {
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::get<0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_position::Position, bool>(borrow_encounter_trigger(arg0), arg1)
    }

    public fun get_item_craft_path(arg0: &Schema, arg1: u256) : &0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_craft_path::CraftPath {
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::get<u256, 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_craft_path::CraftPath>(borrow_item_craft_path(arg0), arg1)
    }

    public fun get_item_metadata(arg0: &Schema, arg1: u256) : &0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_item_metadata::ItemMetadata {
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::get<u256, 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_item_metadata::ItemMetadata>(borrow_item_metadata(arg0), arg1)
    }

    public fun get_map_config(arg0: &Schema, arg1: u64) : &0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_map_config::MapConfig {
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::get<u64, 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_map_config::MapConfig>(borrow_map_config(arg0), arg1)
    }

    public fun get_map_layer(arg0: &Schema, arg1: u64, arg2: 0x1::ascii::String) : &vector<u8> {
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_double_map::get<u64, 0x1::ascii::String, vector<u8>>(borrow_map_layer(arg0), arg1, arg2)
    }

    public fun get_monster(arg0: &Schema, arg1: u256) : &0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_monster_info::MonsterInfo {
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::get<u256, 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_monster_info::MonsterInfo>(borrow_monster(arg0), arg1)
    }

    public fun get_monster_owned_by(arg0: &Schema, arg1: u256) : &address {
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::get<u256, address>(borrow_monster_owned_by(arg0), arg1)
    }

    public fun get_move_item_drop_config(arg0: &Schema) : &0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_item_drop::ItemDrop {
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::get<0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_item_drop::ItemDrop>(borrow_move_item_drop_config(arg0))
    }

    public fun get_next_item_id(arg0: &Schema) : &u256 {
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::get<u256>(borrow_next_item_id(arg0))
    }

    public fun get_next_monster_id(arg0: &Schema) : &u256 {
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::get<u256>(borrow_next_monster_id(arg0))
    }

    public fun get_obstruction(arg0: &Schema, arg1: 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_position::Position) : &bool {
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::get<0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_position::Position, bool>(borrow_obstruction(arg0), arg1)
    }

    public fun get_player(arg0: &Schema, arg1: address) : &bool {
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::get<address, bool>(borrow_player(arg0), arg1)
    }

    public fun get_position(arg0: &Schema, arg1: address) : &0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_position::Position {
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::get<address, 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_position::Position>(borrow_position(arg0), arg1)
    }

    public fun get_teleport_point(arg0: &Schema, arg1: 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_position::Position) : &0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_position::Position {
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::get<0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_position::Position, 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_position::Position>(borrow_teleport_point(arg0), arg1)
    }

    public(friend) fun id(arg0: &mut Schema) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public(friend) fun item_craft_path(arg0: &mut Schema) : &mut 0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::StorageMap<u256, 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_craft_path::CraftPath> {
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage::borrow_mut_field<0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::StorageMap<u256, 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_craft_path::CraftPath>>(&mut arg0.id, b"item_craft_path")
    }

    public(friend) fun item_metadata(arg0: &mut Schema) : &mut 0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::StorageMap<u256, 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_item_metadata::ItemMetadata> {
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage::borrow_mut_field<0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::StorageMap<u256, 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_item_metadata::ItemMetadata>>(&mut arg0.id, b"item_metadata")
    }

    public(friend) fun map_config(arg0: &mut Schema) : &mut 0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::StorageMap<u64, 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_map_config::MapConfig> {
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage::borrow_mut_field<0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::StorageMap<u64, 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_map_config::MapConfig>>(&mut arg0.id, b"map_config")
    }

    public(friend) fun map_layer(arg0: &mut Schema) : &mut 0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_double_map::StorageDoubleMap<u64, 0x1::ascii::String, vector<u8>> {
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage::borrow_mut_field<0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_double_map::StorageDoubleMap<u64, 0x1::ascii::String, vector<u8>>>(&mut arg0.id, b"map_layer")
    }

    public fun migrate(arg0: &mut Schema, arg1: &0x2::package::UpgradeCap, arg2: &mut 0x2::tx_context::TxContext) {
    }

    public(friend) fun monster(arg0: &mut Schema) : &mut 0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::StorageMap<u256, 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_monster_info::MonsterInfo> {
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage::borrow_mut_field<0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::StorageMap<u256, 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_monster_info::MonsterInfo>>(&mut arg0.id, b"monster")
    }

    public(friend) fun monster_owned_by(arg0: &mut Schema) : &mut 0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::StorageMap<u256, address> {
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage::borrow_mut_field<0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::StorageMap<u256, address>>(&mut arg0.id, b"monster_owned_by")
    }

    public(friend) fun move_item_drop_config(arg0: &mut Schema) : &mut 0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::StorageValue<0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_item_drop::ItemDrop> {
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage::borrow_mut_field<0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::StorageValue<0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_item_drop::ItemDrop>>(&mut arg0.id, b"move_item_drop_config")
    }

    public(friend) fun next_item_id(arg0: &mut Schema) : &mut 0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::StorageValue<u256> {
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage::borrow_mut_field<0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::StorageValue<u256>>(&mut arg0.id, b"next_item_id")
    }

    public(friend) fun next_monster_id(arg0: &mut Schema) : &mut 0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::StorageValue<u256> {
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage::borrow_mut_field<0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::StorageValue<u256>>(&mut arg0.id, b"next_monster_id")
    }

    public(friend) fun obstruction(arg0: &mut Schema) : &mut 0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::StorageMap<0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_position::Position, bool> {
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage::borrow_mut_field<0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::StorageMap<0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_position::Position, bool>>(&mut arg0.id, b"obstruction")
    }

    public(friend) fun player(arg0: &mut Schema) : &mut 0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::StorageMap<address, bool> {
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage::borrow_mut_field<0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::StorageMap<address, bool>>(&mut arg0.id, b"player")
    }

    public(friend) fun position(arg0: &mut Schema) : &mut 0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::StorageMap<address, 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_position::Position> {
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage::borrow_mut_field<0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::StorageMap<address, 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_position::Position>>(&mut arg0.id, b"position")
    }

    public(friend) fun teleport_point(arg0: &mut Schema) : &mut 0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::StorageMap<0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_position::Position, 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_position::Position> {
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage::borrow_mut_field<0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::StorageMap<0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_position::Position, 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_position::Position>>(&mut arg0.id, b"teleport_point")
    }

    // decompiled from Move bytecode v6
}

