module 0x8b21de851df662695b44ca468aa53bf1333305d7faf3bf28a5e440b67733d1c7::obligation_naming {
    struct UserNaming has key {
        id: 0x2::object::UID,
        owner: address,
        keys: vector<0x2::object::ID>,
    }

    struct NamingRegistry has key {
        id: 0x2::object::UID,
        by_owner: vector<address>,
    }

    struct NameEntry has drop, store {
        name: 0x1::string::String,
    }

    fun assert_owner(arg0: &UserNaming, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 0);
    }

    public fun create(arg0: &mut 0x2::tx_context::TxContext) : UserNaming {
        UserNaming{
            id    : 0x2::object::new(arg0),
            owner : 0x2::tx_context::sender(arg0),
            keys  : 0x1::vector::empty<0x2::object::ID>(),
        }
    }

    public fun create_user_naming(arg0: &mut NamingRegistry, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(!0x1::vector::contains<address>(&arg0.by_owner, &v0), 3);
        0x1::vector::push_back<address>(&mut arg0.by_owner, v0);
        let v1 = UserNaming{
            id    : 0x2::object::new(arg1),
            owner : v0,
            keys  : 0x1::vector::empty<0x2::object::ID>(),
        };
        0x2::transfer::transfer<UserNaming>(v1, v0);
    }

    public fun create_user_naming_and_set_name(arg0: &mut NamingRegistry, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(!0x1::vector::contains<address>(&arg0.by_owner, &v0), 3);
        assert!(0x1::string::length(&arg2) <= 64, 1);
        0x1::vector::push_back<address>(&mut arg0.by_owner, v0);
        let v1 = UserNaming{
            id    : 0x2::object::new(arg3),
            owner : v0,
            keys  : 0x1::vector::empty<0x2::object::ID>(),
        };
        0x1::vector::push_back<0x2::object::ID>(&mut v1.keys, arg1);
        let v2 = NameEntry{name: arg2};
        0x2::dynamic_field::add<0x2::object::ID, NameEntry>(&mut v1.id, arg1, v2);
        0x2::transfer::transfer<UserNaming>(v1, v0);
    }

    public fun get_name(arg0: &UserNaming, arg1: 0x2::object::ID) : 0x1::option::Option<0x1::string::String> {
        if (0x2::dynamic_field::exists_with_type<0x2::object::ID, NameEntry>(&arg0.id, arg1)) {
            0x1::option::some<0x1::string::String>(0x2::dynamic_field::borrow<0x2::object::ID, NameEntry>(&arg0.id, arg1).name)
        } else {
            0x1::option::none<0x1::string::String>()
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = NamingRegistry{
            id       : 0x2::object::new(arg0),
            by_owner : 0x1::vector::empty<address>(),
        };
        0x2::transfer::share_object<NamingRegistry>(v0);
    }

    public fun keys(arg0: &UserNaming) : &vector<0x2::object::ID> {
        &arg0.keys
    }

    public fun owner(arg0: &UserNaming) : address {
        arg0.owner
    }

    public fun remove_name(arg0: &mut UserNaming, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg0, arg2);
        assert!(0x2::dynamic_field::exists_with_type<0x2::object::ID, NameEntry>(&arg0.id, arg1), 2);
        let NameEntry {  } = 0x2::dynamic_field::remove<0x2::object::ID, NameEntry>(&mut arg0.id, arg1);
        let (v0, v1) = 0x1::vector::index_of<0x2::object::ID>(&arg0.keys, &arg1);
        if (v0) {
            0x1::vector::remove<0x2::object::ID>(&mut arg0.keys, v1);
        };
    }

    public fun set_name(arg0: &mut UserNaming, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg0, arg3);
        assert!(0x1::string::length(&arg2) <= 64, 1);
        if (0x2::dynamic_field::exists_with_type<0x2::object::ID, NameEntry>(&arg0.id, arg1)) {
            let NameEntry {  } = 0x2::dynamic_field::remove<0x2::object::ID, NameEntry>(&mut arg0.id, arg1);
        } else {
            0x1::vector::push_back<0x2::object::ID>(&mut arg0.keys, arg1);
        };
        let v0 = NameEntry{name: arg2};
        0x2::dynamic_field::add<0x2::object::ID, NameEntry>(&mut arg0.id, arg1, v0);
    }

    public fun size(arg0: &UserNaming) : u64 {
        0x1::vector::length<0x2::object::ID>(&arg0.keys)
    }

    // decompiled from Move bytecode v6
}

