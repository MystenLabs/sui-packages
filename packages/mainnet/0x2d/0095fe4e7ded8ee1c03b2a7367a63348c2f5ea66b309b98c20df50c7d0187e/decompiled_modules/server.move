module 0x2d0095fe4e7ded8ee1c03b2a7367a63348c2f5ea66b309b98c20df50c7d0187e::server {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct CharacterLockReceipt has key {
        id: 0x2::object::UID,
        character_id: 0x2::object::ID,
    }

    struct ServerStorage has store, key {
        id: 0x2::object::UID,
        characters: 0x2::object_bag::ObjectBag,
    }

    struct Update has copy, drop {
        for: address,
    }

    public fun borrow_character(arg0: &ServerStorage, arg1: 0x2::object::ID) : &0x2d0095fe4e7ded8ee1c03b2a7367a63348c2f5ea66b309b98c20df50c7d0187e::character::Character {
        0x2::object_bag::borrow<0x2::object::ID, 0x2d0095fe4e7ded8ee1c03b2a7367a63348c2f5ea66b309b98c20df50c7d0187e::character::Character>(&arg0.characters, arg1)
    }

    public fun character_add_experience(arg0: &AdminCap, arg1: &mut ServerStorage, arg2: 0x2::object::ID, arg3: u64) {
        0x2d0095fe4e7ded8ee1c03b2a7367a63348c2f5ea66b309b98c20df50c7d0187e::character::add_experience(0x2::object_bag::borrow_mut<0x2::object::ID, 0x2d0095fe4e7ded8ee1c03b2a7367a63348c2f5ea66b309b98c20df50c7d0187e::character::Character>(&mut arg1.characters, arg2), arg3);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = ServerStorage{
            id         : 0x2::object::new(arg0),
            characters : 0x2::object_bag::new(arg0),
        };
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<ServerStorage>(v1);
    }

    public fun lock_character(arg0: &mut ServerStorage, arg1: 0x2d0095fe4e7ded8ee1c03b2a7367a63348c2f5ea66b309b98c20df50c7d0187e::character::Character, arg2: &mut 0x2::tx_context::TxContext) : CharacterLockReceipt {
        let v0 = Update{for: 0x2::tx_context::sender(arg2)};
        0x2::event::emit<Update>(v0);
        let v1 = 0x2::object::id<0x2d0095fe4e7ded8ee1c03b2a7367a63348c2f5ea66b309b98c20df50c7d0187e::character::Character>(&arg1);
        0x2::object_bag::add<0x2::object::ID, 0x2d0095fe4e7ded8ee1c03b2a7367a63348c2f5ea66b309b98c20df50c7d0187e::character::Character>(&mut arg0.characters, v1, arg1);
        CharacterLockReceipt{
            id           : 0x2::object::new(arg2),
            character_id : v1,
        }
    }

    public fun unlock_character(arg0: &mut ServerStorage, arg1: CharacterLockReceipt, arg2: &mut 0x2::tx_context::TxContext) : 0x2d0095fe4e7ded8ee1c03b2a7367a63348c2f5ea66b309b98c20df50c7d0187e::character::Character {
        let v0 = Update{for: 0x2::tx_context::sender(arg2)};
        0x2::event::emit<Update>(v0);
        let CharacterLockReceipt {
            id           : v1,
            character_id : v2,
        } = arg1;
        0x2::object::delete(v1);
        0x2::object_bag::remove<0x2::object::ID, 0x2d0095fe4e7ded8ee1c03b2a7367a63348c2f5ea66b309b98c20df50c7d0187e::character::Character>(&mut arg0.characters, v2)
    }

    // decompiled from Move bytecode v6
}

