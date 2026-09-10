module 0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::dungeon_content {
    struct DungeonContentKey has copy, drop, store {
        pos0: 0x1::string::String,
    }

    struct DungeonContent has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        data: 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::dungeon_data::DungeonData,
    }

    struct DungeonContentCreated has copy, drop {
        dungeon: 0x2::object::ID,
        name: 0x1::string::String,
    }

    public fun add(arg0: &0x42b5165ab47d760c38e0158328aba7c960d3f12d129cd2e960bea60e09d9d19b::admin::AdminCap, arg1: &mut 0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::registry::Registry, arg2: 0x1::string::String, arg3: 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::dungeon_data::DungeonData, arg4: &0x2::tx_context::TxContext) {
        let v0 = DungeonContentKey{pos0: arg2};
        let v1 = DungeonContent{
            id   : 0x2::derived_object::claim<DungeonContentKey>(0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::registry::uid_mut(arg0, arg1, arg4), v0),
            name : arg2,
            data : arg3,
        };
        let v2 = DungeonContentCreated{
            dungeon : 0x2::object::id<DungeonContent>(&v1),
            name    : arg2,
        };
        0x2::event::emit<DungeonContentCreated>(v2);
        0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::registry::bump(arg0, arg1, 0x1::string::utf8(b"dungeon_content"), arg2, arg4);
        0x2::transfer::share_object<DungeonContent>(v1);
    }

    public fun data(arg0: &DungeonContent) : &0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::dungeon_data::DungeonData {
        &arg0.data
    }

    public fun name(arg0: &DungeonContent) : 0x1::string::String {
        arg0.name
    }

    public fun overwrite(arg0: &0x42b5165ab47d760c38e0158328aba7c960d3f12d129cd2e960bea60e09d9d19b::admin::AdminCap, arg1: &mut 0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::registry::Registry, arg2: &mut DungeonContent, arg3: 0x1::string::String, arg4: 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::dungeon_data::DungeonData, arg5: &0x2::tx_context::TxContext) {
        assert!(arg2.name == arg3, 4601);
        arg2.data = arg4;
        0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::registry::bump(arg0, arg1, 0x1::string::utf8(b"dungeon_content"), arg3, arg5);
    }

    // decompiled from Move bytecode v7
}

