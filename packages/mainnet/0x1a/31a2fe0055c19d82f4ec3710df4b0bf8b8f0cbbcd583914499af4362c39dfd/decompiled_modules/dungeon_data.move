module 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::dungeon_data {
    struct DungeonData has copy, drop, store {
        key: 0x1::string::String,
        rooms: vector<DungeonRoomData>,
    }

    struct DungeonRoomData has copy, drop, store {
        mobs: vector<DungeonMob>,
    }

    struct DungeonMob has copy, drop, store {
        mob_type: 0x1::string::String,
    }

    public fun key(arg0: &DungeonData) : 0x1::string::String {
        arg0.key
    }

    public fun level_scalar(arg0: u64, arg1: u64) : u8 {
        ((0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::prng::mix(arg0, arg1) % 101) as u8)
    }

    public fun mob_type(arg0: &DungeonMob) : 0x1::string::String {
        arg0.mob_type
    }

    public fun new_dungeon(arg0: 0x1::string::String, arg1: vector<DungeonRoomData>) : DungeonData {
        assert!(!0x1::string::is_empty(&arg0) && !0x1::vector::is_empty<DungeonRoomData>(&arg1), 3301);
        DungeonData{
            key   : arg0,
            rooms : arg1,
        }
    }

    public fun new_room(arg0: vector<DungeonMob>) : DungeonRoomData {
        assert!(!0x1::vector::is_empty<DungeonMob>(&arg0), 3302);
        DungeonRoomData{mobs: arg0}
    }

    public fun new_room_mob(arg0: 0x1::string::String) : DungeonMob {
        DungeonMob{mob_type: arg0}
    }

    public fun room_at(arg0: &DungeonData, arg1: u64) : vector<DungeonMob> {
        0x1::vector::borrow<DungeonRoomData>(&arg0.rooms, arg1 - 1).mobs
    }

    public fun room_count(arg0: &DungeonData) : u64 {
        0x1::vector::length<DungeonRoomData>(&arg0.rooms)
    }

    // decompiled from Move bytecode v7
}

