module 0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::world_content {
    struct WorldContentKey has copy, drop, store {
        pos0: 0x1::string::String,
    }

    struct WorldContent has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        data: 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::WorldContent,
    }

    struct EntryLevelKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ArchiRowsKey has copy, drop, store {
        dummy_field: bool,
    }

    public fun clear_biome_map(arg0: &0x42b5165ab47d760c38e0158328aba7c960d3f12d129cd2e960bea60e09d9d19b::admin::AdminCap, arg1: &mut 0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::registry::Registry, arg2: &mut WorldContent, arg3: &0x2::tx_context::TxContext) {
        0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::clear_biome_map(&mut arg2.data);
        0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::registry::bump(arg0, arg1, 0x1::string::utf8(b"world_content"), arg2.name, arg3);
    }

    public fun set_cities(arg0: &0x42b5165ab47d760c38e0158328aba7c960d3f12d129cd2e960bea60e09d9d19b::admin::AdminCap, arg1: &mut 0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::registry::Registry, arg2: &mut WorldContent, arg3: vector<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::city_map::City>, arg4: &0x2::tx_context::TxContext) {
        0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::set_cities(&mut arg2.data, arg3);
        0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::registry::bump(arg0, arg1, 0x1::string::utf8(b"world_content"), arg2.name, arg4);
    }

    public fun set_mobs(arg0: &0x42b5165ab47d760c38e0158328aba7c960d3f12d129cd2e960bea60e09d9d19b::admin::AdminCap, arg1: &mut 0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::registry::Registry, arg2: &mut WorldContent, arg3: vector<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::MobRow>, arg4: &0x2::tx_context::TxContext) {
        0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::set_mobs(&mut arg2.data, arg3);
        0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::registry::bump(arg0, arg1, 0x1::string::utf8(b"world_content"), arg2.name, arg4);
    }

    public fun set_resources(arg0: &0x42b5165ab47d760c38e0158328aba7c960d3f12d129cd2e960bea60e09d9d19b::admin::AdminCap, arg1: &mut 0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::registry::Registry, arg2: &mut WorldContent, arg3: vector<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::ResourceRow>, arg4: &0x2::tx_context::TxContext) {
        0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::set_resources(&mut arg2.data, arg3);
        0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::registry::bump(arg0, arg1, 0x1::string::utf8(b"world_content"), arg2.name, arg4);
    }

    public fun append_biome_cells(arg0: &0x42b5165ab47d760c38e0158328aba7c960d3f12d129cd2e960bea60e09d9d19b::admin::AdminCap, arg1: &mut 0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::registry::Registry, arg2: &mut WorldContent, arg3: vector<u8>, arg4: &0x2::tx_context::TxContext) {
        0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::append_biome_map_cells(&mut arg2.data, arg3);
        0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::registry::bump(arg0, arg1, 0x1::string::utf8(b"world_content"), arg2.name, arg4);
    }

    public fun archi_rows(arg0: &WorldContent) : vector<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::ArchiRow> {
        let v0 = ArchiRowsKey{dummy_field: false};
        if (0x2::dynamic_field::exists<ArchiRowsKey>(&arg0.id, v0)) {
            let v2 = ArchiRowsKey{dummy_field: false};
            *0x2::dynamic_field::borrow<ArchiRowsKey, vector<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::ArchiRow>>(&arg0.id, v2)
        } else {
            0x1::vector::empty<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::ArchiRow>()
        }
    }

    public fun create(arg0: &0x42b5165ab47d760c38e0158328aba7c960d3f12d129cd2e960bea60e09d9d19b::admin::AdminCap, arg1: &mut 0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::registry::Registry, arg2: 0x1::string::String, arg3: u16, arg4: &0x2::tx_context::TxContext) : WorldContent {
        assert!(arg3 >= 1, 4401);
        let v0 = WorldContentKey{pos0: arg2};
        let v1 = WorldContent{
            id   : 0x2::derived_object::claim<WorldContentKey>(0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::registry::uid_mut(arg0, arg1, arg4), v0),
            name : arg2,
            data : 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::empty_world_content(),
        };
        let v2 = EntryLevelKey{dummy_field: false};
        0x2::dynamic_field::add<EntryLevelKey, u16>(&mut v1.id, v2, arg3);
        0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::registry::bump(arg0, arg1, 0x1::string::utf8(b"world_content"), arg2, arg4);
        v1
    }

    public fun data(arg0: &WorldContent) : &0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::WorldContent {
        &arg0.data
    }

    public fun entry_level(arg0: &WorldContent) : u16 {
        let v0 = EntryLevelKey{dummy_field: false};
        if (0x2::dynamic_field::exists<EntryLevelKey>(&arg0.id, v0)) {
            let v2 = EntryLevelKey{dummy_field: false};
            *0x2::dynamic_field::borrow<EntryLevelKey, u16>(&arg0.id, v2)
        } else {
            1
        }
    }

    public fun name(arg0: &WorldContent) : 0x1::string::String {
        arg0.name
    }

    public fun set_archi_rows(arg0: &0x42b5165ab47d760c38e0158328aba7c960d3f12d129cd2e960bea60e09d9d19b::admin::AdminCap, arg1: &mut 0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::registry::Registry, arg2: &mut WorldContent, arg3: vector<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::ArchiRow>, arg4: &0x2::tx_context::TxContext) {
        let v0 = ArchiRowsKey{dummy_field: false};
        if (0x2::dynamic_field::exists<ArchiRowsKey>(&arg2.id, v0)) {
            let v1 = ArchiRowsKey{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<ArchiRowsKey, vector<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::ArchiRow>>(&mut arg2.id, v1) = arg3;
        } else {
            let v2 = ArchiRowsKey{dummy_field: false};
            0x2::dynamic_field::add<ArchiRowsKey, vector<0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::ArchiRow>>(&mut arg2.id, v2, arg3);
        };
        0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::registry::bump(arg0, arg1, 0x1::string::utf8(b"world_content"), arg2.name, arg4);
    }

    public fun set_biome_window(arg0: &0x42b5165ab47d760c38e0158328aba7c960d3f12d129cd2e960bea60e09d9d19b::admin::AdminCap, arg1: &mut 0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::registry::Registry, arg2: &mut WorldContent, arg3: u32, arg4: u32, arg5: u16, arg6: &0x2::tx_context::TxContext) {
        0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::world_map::set_biome_map_window(&mut arg2.data, arg3, arg4, arg5);
        0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::registry::bump(arg0, arg1, 0x1::string::utf8(b"world_content"), arg2.name, arg6);
    }

    public fun set_entry_level(arg0: &0x42b5165ab47d760c38e0158328aba7c960d3f12d129cd2e960bea60e09d9d19b::admin::AdminCap, arg1: &mut 0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::registry::Registry, arg2: &mut WorldContent, arg3: u16, arg4: &0x2::tx_context::TxContext) {
        assert!(arg3 >= 1, 4401);
        let v0 = EntryLevelKey{dummy_field: false};
        if (0x2::dynamic_field::exists<EntryLevelKey>(&arg2.id, v0)) {
            let v1 = EntryLevelKey{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<EntryLevelKey, u16>(&mut arg2.id, v1) = arg3;
        } else {
            let v2 = EntryLevelKey{dummy_field: false};
            0x2::dynamic_field::add<EntryLevelKey, u16>(&mut arg2.id, v2, arg3);
        };
        0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::registry::bump(arg0, arg1, 0x1::string::utf8(b"world_content"), arg2.name, arg4);
    }

    public fun share(arg0: WorldContent) {
        0x2::transfer::share_object<WorldContent>(arg0);
    }

    // decompiled from Move bytecode v7
}

