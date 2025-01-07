module 0xaddc2335cf9b67c69def6bc8cfb71192cc864e34ca71bf9eddb4a76c252800bc::server {
    struct AdminCap has key {
        id: 0x2::object::UID,
        known_storages: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    struct CharacterLockReceipt has key {
        id: 0x2::object::UID,
        storage_id: 0x2::object::ID,
        character_id: 0x2::object::ID,
    }

    struct ServerStorage has store, key {
        id: 0x2::object::UID,
        characters: 0x2::object_bag::ObjectBag,
    }

    struct Update has copy, drop {
        for: address,
    }

    public fun borrow_character(arg0: &ServerStorage, arg1: 0x2::object::ID) : &0xaddc2335cf9b67c69def6bc8cfb71192cc864e34ca71bf9eddb4a76c252800bc::character::Character {
        0x2::object_bag::borrow<0x2::object::ID, 0xaddc2335cf9b67c69def6bc8cfb71192cc864e34ca71bf9eddb4a76c252800bc::character::Character>(&arg0.characters, arg1)
    }

    public fun character_add_experience(arg0: &AdminCap, arg1: &mut ServerStorage, arg2: 0x2::object::ID, arg3: u64) {
        0xaddc2335cf9b67c69def6bc8cfb71192cc864e34ca71bf9eddb4a76c252800bc::character::add_experience(0x2::object_bag::borrow_mut<0x2::object::ID, 0xaddc2335cf9b67c69def6bc8cfb71192cc864e34ca71bf9eddb4a76c252800bc::character::Character>(&mut arg1.characters, arg2), arg3);
    }

    public fun create_storage(arg0: &mut AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg1);
        let v1 = ServerStorage{
            id         : v0,
            characters : 0x2::object_bag::new(arg1),
        };
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.known_storages, 0x2::object::uid_to_inner(&v0));
        0x2::transfer::share_object<ServerStorage>(v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg0);
        let v1 = AdminCap{
            id             : 0x2::object::new(arg0),
            known_storages : 0x2::vec_set::singleton<0x2::object::ID>(0x2::object::uid_to_inner(&v0)),
        };
        let v2 = ServerStorage{
            id         : v0,
            characters : 0x2::object_bag::new(arg0),
        };
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<ServerStorage>(v2);
    }

    public fun lock_character(arg0: &mut ServerStorage, arg1: 0xaddc2335cf9b67c69def6bc8cfb71192cc864e34ca71bf9eddb4a76c252800bc::character::Character, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Update{for: 0x2::tx_context::sender(arg2)};
        0x2::event::emit<Update>(v0);
        let v1 = 0x2::object::id<0xaddc2335cf9b67c69def6bc8cfb71192cc864e34ca71bf9eddb4a76c252800bc::character::Character>(&arg1);
        0x2::object_bag::add<0x2::object::ID, 0xaddc2335cf9b67c69def6bc8cfb71192cc864e34ca71bf9eddb4a76c252800bc::character::Character>(&mut arg0.characters, v1, arg1);
        let v2 = CharacterLockReceipt{
            id           : 0x2::object::new(arg2),
            storage_id   : 0x2::object::uid_to_inner(&arg0.id),
            character_id : v1,
        };
        0x2::transfer::transfer<CharacterLockReceipt>(v2, 0x2::tx_context::sender(arg2));
    }

    public fun unlock_character(arg0: &mut ServerStorage, arg1: CharacterLockReceipt, arg2: &mut 0x2::tx_context::TxContext) : 0xaddc2335cf9b67c69def6bc8cfb71192cc864e34ca71bf9eddb4a76c252800bc::character::Character {
        let v0 = Update{for: 0x2::tx_context::sender(arg2)};
        0x2::event::emit<Update>(v0);
        let CharacterLockReceipt {
            id           : v1,
            storage_id   : _,
            character_id : v3,
        } = arg1;
        0x2::object::delete(v1);
        0x2::object_bag::remove<0x2::object::ID, 0xaddc2335cf9b67c69def6bc8cfb71192cc864e34ca71bf9eddb4a76c252800bc::character::Character>(&mut arg0.characters, v3)
    }

    // decompiled from Move bytecode v6
}

