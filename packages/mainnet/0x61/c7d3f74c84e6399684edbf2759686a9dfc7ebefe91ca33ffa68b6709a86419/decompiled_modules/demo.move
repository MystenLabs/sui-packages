module 0x61c7d3f74c84e6399684edbf2759686a9dfc7ebefe91ca33ffa68b6709a86419::demo {
    struct People has store, key {
        id: 0x2::object::UID,
        age: u64,
        owner: address,
    }

    struct BadgeKey has copy, drop, store {
        dummy_field: bool,
    }

    struct Badge has store, key {
        id: 0x2::object::UID,
        level: u64,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public entry fun add_badge(arg0: &mut People, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Badge{
            id    : 0x2::object::new(arg2),
            level : arg1,
        };
        let v1 = BadgeKey{dummy_field: false};
        0x2::dynamic_object_field::add<BadgeKey, Badge>(&mut arg0.id, v1, v0);
    }

    public entry fun admin_set_age(arg0: &AdminCap, arg1: &mut People, arg2: u64) {
        arg1.age = arg2;
    }

    public entry fun create_people(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = People{
            id    : 0x2::object::new(arg0),
            age   : 0,
            owner : 0x2::tx_context::sender(arg0),
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

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun set_age(arg0: &mut People, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        arg0.age = arg1;
    }

    public entry fun set_level(arg0: &mut People, arg1: u64) {
        let v0 = BadgeKey{dummy_field: false};
        0x2::dynamic_object_field::borrow_mut<BadgeKey, Badge>(&mut arg0.id, v0).level = arg1;
    }

    public entry fun transfer_badge(arg0: &mut People, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = BadgeKey{dummy_field: false};
        0x2::transfer::public_transfer<Badge>(0x2::dynamic_object_field::remove<BadgeKey, Badge>(&mut arg0.id, v0), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

