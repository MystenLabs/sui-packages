module 0x9b554acfb4caae071b6ca77f76db0e3f995e142af7f05eb95ef26495d2bd2f79::demo {
    struct People has store, key {
        id: 0x2::object::UID,
        age: u64,
        owner: address,
    }

    struct School has key {
        id: 0x2::object::UID,
        students: 0x2::table::Table<address, 0x2::object::ID>,
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

    public entry fun create_school(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = School{
            id       : 0x2::object::new(arg0),
            students : 0x2::table::new<address, 0x2::object::ID>(arg0),
        };
        0x2::transfer::share_object<School>(v0);
    }

    public fun get_level(arg0: &People) : u64 {
        let v0 = BadgeKey{dummy_field: false};
        0x2::dynamic_object_field::borrow<BadgeKey, Badge>(&arg0.id, v0).level
    }

    public fun has_badge(arg0: &mut People) : bool {
        let v0 = BadgeKey{dummy_field: false};
        0x2::dynamic_object_field::exists_with_type<BadgeKey, Badge>(&arg0.id, v0)
    }

    public fun has_student(arg0: &School, arg1: address) : bool {
        0x2::table::contains<address, 0x2::object::ID>(&arg0.students, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun pay_to_add_badge(arg0: &mut People, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= 100000000, 100);
        let v0 = BadgeKey{dummy_field: false};
        assert!(!0x2::dynamic_object_field::exists_with_type<BadgeKey, Badge>(&arg0.id, v0), 101);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, 100000000, arg3), arg0.owner);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, 0x2::tx_context::sender(arg3));
        let v1 = Badge{
            id    : 0x2::object::new(arg3),
            level : arg2,
        };
        let v2 = BadgeKey{dummy_field: false};
        0x2::dynamic_object_field::add<BadgeKey, Badge>(&mut arg0.id, v2, v1);
    }

    public entry fun register_people(arg0: &mut School, arg1: &People) {
        assert!(!0x2::table::contains<address, 0x2::object::ID>(&arg0.students, arg1.owner), 102);
        0x2::table::add<address, 0x2::object::ID>(&mut arg0.students, arg1.owner, 0x2::object::id<People>(arg1));
    }

    public entry fun set_age(arg0: &mut People, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        arg0.age = arg1;
    }

    public entry fun set_level(arg0: &mut People, arg1: u64) {
        let v0 = BadgeKey{dummy_field: false};
        0x2::dynamic_object_field::borrow_mut<BadgeKey, Badge>(&mut arg0.id, v0).level = arg1;
    }

    public fun student_id(arg0: &School, arg1: address) : 0x2::object::ID {
        *0x2::table::borrow<address, 0x2::object::ID>(&arg0.students, arg1)
    }

    public entry fun transfer_badge(arg0: &mut People, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = BadgeKey{dummy_field: false};
        0x2::transfer::public_transfer<Badge>(0x2::dynamic_object_field::remove<BadgeKey, Badge>(&mut arg0.id, v0), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

