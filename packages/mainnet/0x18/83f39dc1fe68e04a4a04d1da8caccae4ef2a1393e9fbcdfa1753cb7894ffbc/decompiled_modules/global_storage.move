module 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage {
    struct GlobalStorage has key {
        id: 0x2::object::UID,
        emergency_status: 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::emergency::EmergencyStatus,
        account_resources: 0x2::table::Table<address, 0x2::bag::Bag>,
        shared_resources: 0x2::bag::Bag,
        package_version: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun borrow<T0: store>(arg0: &GlobalStorage, arg1: address) : &T0 {
        checked_package_version(arg0);
        assert!(0x2::table::contains<address, 0x2::bag::Bag>(&arg0.account_resources, arg1), 3);
        let v0 = 0x2::table::borrow<address, 0x2::bag::Bag>(&arg0.account_resources, arg1);
        let v1 = get_resource_name<T0>();
        assert!(0x2::bag::contains<0x1::string::String>(v0, v1), 2);
        0x2::bag::borrow<0x1::string::String, T0>(v0, v1)
    }

    public fun borrow_mut<T0: store>(arg0: &mut GlobalStorage, arg1: address) : &mut T0 {
        checked_package_version(arg0);
        assert!(0x2::table::contains<address, 0x2::bag::Bag>(&arg0.account_resources, arg1), 3);
        let v0 = 0x2::table::borrow_mut<address, 0x2::bag::Bag>(&mut arg0.account_resources, arg1);
        let v1 = get_resource_name<T0>();
        assert!(0x2::bag::contains<0x1::string::String>(v0, v1), 2);
        0x2::bag::borrow_mut<0x1::string::String, T0>(v0, v1)
    }

    public fun add<T0: store>(arg0: &mut GlobalStorage, arg1: T0, arg2: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        let v0 = 0x2::tx_context::sender(arg2);
        if (!0x2::table::contains<address, 0x2::bag::Bag>(&arg0.account_resources, v0)) {
            0x2::table::add<address, 0x2::bag::Bag>(&mut arg0.account_resources, v0, 0x2::bag::new(arg2));
        };
        let v1 = 0x2::table::borrow_mut<address, 0x2::bag::Bag>(&mut arg0.account_resources, v0);
        let v2 = get_resource_name<T0>();
        assert!(!0x2::bag::contains<0x1::string::String>(v1, v2), 1);
        0x2::bag::add<0x1::string::String, T0>(v1, v2, arg1);
    }

    public fun contains<T0: store>(arg0: &GlobalStorage, arg1: address) : bool {
        checked_package_version(arg0);
        if (!0x2::table::contains<address, 0x2::bag::Bag>(&arg0.account_resources, arg1)) {
            return false
        };
        0x2::bag::contains<0x1::string::String>(0x2::table::borrow<address, 0x2::bag::Bag>(&arg0.account_resources, arg1), get_resource_name<T0>())
    }

    public fun add_share<T0: store>(arg0: &mut GlobalStorage, arg1: T0) {
        checked_package_version(arg0);
        let v0 = &mut arg0.shared_resources;
        let v1 = get_resource_name<T0>();
        assert!(!0x2::bag::contains<0x1::string::String>(v0, v1), 1);
        0x2::bag::add<0x1::string::String, T0>(v0, v1, arg1);
    }

    public fun add_to_uid<T0: store>(arg0: &mut GlobalStorage, arg1: T0, arg2: &0x2::object::UID, arg3: &mut 0x2::tx_context::TxContext) {
        checked_package_version(arg0);
        let v0 = 0x2::object::uid_to_address(arg2);
        if (!0x2::table::contains<address, 0x2::bag::Bag>(&arg0.account_resources, v0)) {
            0x2::table::add<address, 0x2::bag::Bag>(&mut arg0.account_resources, v0, 0x2::bag::new(arg3));
        };
        let v1 = 0x2::table::borrow_mut<address, 0x2::bag::Bag>(&mut arg0.account_resources, v0);
        let v2 = get_resource_name<T0>();
        assert!(!0x2::bag::contains<0x1::string::String>(v1, v2), 1);
        0x2::bag::add<0x1::string::String, T0>(v1, v2, arg1);
    }

    public fun borrow_emergency_status(arg0: &GlobalStorage) : &0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::emergency::EmergencyStatus {
        checked_package_version(arg0);
        &arg0.emergency_status
    }

    public fun borrow_mut_emergency_status(arg0: &mut GlobalStorage) : &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::emergency::EmergencyStatus {
        checked_package_version(arg0);
        &mut arg0.emergency_status
    }

    public fun borrow_mut_shared<T0: store>(arg0: &mut GlobalStorage) : &mut T0 {
        checked_package_version(arg0);
        let v0 = &mut arg0.shared_resources;
        let v1 = get_resource_name<T0>();
        assert!(0x2::bag::contains<0x1::string::String>(v0, v1), 2);
        0x2::bag::borrow_mut<0x1::string::String, T0>(v0, v1)
    }

    public fun borrow_shared<T0: store>(arg0: &GlobalStorage) : &T0 {
        checked_package_version(arg0);
        let v0 = &arg0.shared_resources;
        let v1 = get_resource_name<T0>();
        assert!(0x2::bag::contains<0x1::string::String>(v0, v1), 2);
        0x2::bag::borrow<0x1::string::String, T0>(v0, v1)
    }

    public fun checked_package_version(arg0: &GlobalStorage) {
        assert!(arg0.package_version == 1, 4);
    }

    public fun contains_shared<T0: store>(arg0: &GlobalStorage) : bool {
        checked_package_version(arg0);
        0x2::bag::contains<0x1::string::String>(&arg0.shared_resources, get_resource_name<T0>())
    }

    public fun get_resource_name<T0>() : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"r-");
        0x1::string::append_utf8(&mut v0, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())));
        v0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GlobalStorage{
            id                : 0x2::object::new(arg0),
            emergency_status  : 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::emergency::initialize(arg0),
            account_resources : 0x2::table::new<address, 0x2::bag::Bag>(arg0),
            shared_resources  : 0x2::bag::new(arg0),
            package_version   : 1,
        };
        0x2::transfer::share_object<GlobalStorage>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    entry fun upgrade_package_version(arg0: &AdminCap, arg1: &mut GlobalStorage, arg2: u64) {
        arg1.package_version = arg2;
    }

    // decompiled from Move bytecode v6
}

