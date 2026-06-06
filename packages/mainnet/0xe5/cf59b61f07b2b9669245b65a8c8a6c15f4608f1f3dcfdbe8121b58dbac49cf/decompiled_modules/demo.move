module 0xe5cf59b61f07b2b9669245b65a8c8a6c15f4608f1f3dcfdbe8121b58dbac49cf::demo {
    struct People has store, key {
        id: 0x2::object::UID,
        age: u64,
    }

    struct BadgeKey has copy, drop, store {
        dummy_field: bool,
    }

    struct Badge has store, key {
        id: 0x2::object::UID,
        level: u64,
    }

    public entry fun add_badge(arg0: &mut People, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Badge{
            id    : 0x2::object::new(arg2),
            level : arg1,
        };
        let v1 = BadgeKey{dummy_field: false};
        0x2::dynamic_object_field::add<BadgeKey, Badge>(&mut arg0.id, v1, v0);
    }

    public entry fun create_people(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = People{
            id  : 0x2::object::new(arg0),
            age : 0,
        };
        0x2::transfer::public_transfer<People>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun get_level(arg0: &People) : u64 {
        let v0 = BadgeKey{dummy_field: false};
        0x2::dynamic_object_field::borrow<BadgeKey, Badge>(&arg0.id, v0).level
    }

    public fun has_badge(arg0: &mut People) : bool {
        let v0 = BadgeKey{dummy_field: false};
        0x2::dynamic_object_field::exists_with_type<BadgeKey, Badge>(&arg0.id, v0)
    }

    public fun set_level(arg0: &mut People, arg1: u64) {
        let v0 = BadgeKey{dummy_field: false};
        0x2::dynamic_object_field::borrow_mut<BadgeKey, Badge>(&mut arg0.id, v0).level = arg1;
    }

    public fun transfer_badge(arg0: &mut People, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = BadgeKey{dummy_field: false};
        0x2::transfer::public_transfer<Badge>(0x2::dynamic_object_field::remove<BadgeKey, Badge>(&mut arg0.id, v0), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

