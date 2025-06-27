module 0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca_subscriber {
    struct VeScaSubscriberWhitelist has key {
        id: 0x2::object::UID,
        whitelist: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    struct VeScaSubscriberTable has key {
        id: 0x2::object::UID,
        table: 0x2::table::Table<0x2::object::ID, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>,
    }

    public(friend) fun add_subscriber_to_whitelist<T0: drop>(arg0: &mut VeScaSubscriberWhitelist) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.whitelist, &v0), 0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::error_code::add_existing_subscriber_to_whitelist());
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.whitelist, v0);
    }

    public fun assert_subscriber_whitelisted<T0: drop>(arg0: &VeScaSubscriberWhitelist) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.whitelist, &v0), 0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::error_code::subscriber_not_whitelisted());
    }

    public fun has_subscribers(arg0: &VeScaSubscriberTable, arg1: 0x2::object::ID) : bool {
        if (!0x2::table::contains<0x2::object::ID, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg0.table, arg1)) {
            return false
        };
        !0x2::vec_set::is_empty<0x1::type_name::TypeName>(0x2::table::borrow<0x2::object::ID, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg0.table, arg1))
    }

    public(friend) fun initialize(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = VeScaSubscriberWhitelist{
            id        : 0x2::object::new(arg0),
            whitelist : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        };
        let v1 = VeScaSubscriberTable{
            id    : 0x2::object::new(arg0),
            table : 0x2::table::new<0x2::object::ID, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(arg0),
        };
        0x2::transfer::share_object<VeScaSubscriberWhitelist>(v0);
        0x2::transfer::share_object<VeScaSubscriberTable>(v1);
    }

    public fun is_subscriber_whitelisted<T0: drop>(arg0: &VeScaSubscriberWhitelist) : bool {
        let v0 = 0x1::type_name::get<T0>();
        0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.whitelist, &v0)
    }

    public(friend) fun remove_subscriber<T0: drop>(arg0: &mut VeScaSubscriberWhitelist) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.whitelist, &v0), 0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::error_code::remove_non_existing_subscriber_from_whitelist());
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.whitelist, &v0);
    }

    public fun subscribe<T0: drop>(arg0: T0, arg1: &mut VeScaSubscriberTable, arg2: &VeScaSubscriberWhitelist, arg3: 0x2::object::ID) {
        assert_subscriber_whitelisted<T0>(arg2);
        if (!0x2::table::contains<0x2::object::ID, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg1.table, arg3)) {
            0x2::table::add<0x2::object::ID, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&mut arg1.table, arg3, 0x2::vec_set::empty<0x1::type_name::TypeName>());
        };
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&mut arg1.table, arg3);
        let v1 = 0x1::type_name::get<T0>();
        if (0x2::vec_set::contains<0x1::type_name::TypeName>(v0, &v1) == false) {
            0x2::vec_set::insert<0x1::type_name::TypeName>(v0, v1);
        };
    }

    public fun unsubscribe<T0: drop>(arg0: T0, arg1: &mut VeScaSubscriberTable, arg2: &VeScaSubscriberWhitelist, arg3: 0x2::object::ID) {
        assert_subscriber_whitelisted<T0>(arg2);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&mut arg1.table, arg3);
        let v1 = 0x1::type_name::get<T0>();
        if (0x2::vec_set::contains<0x1::type_name::TypeName>(v0, &v1)) {
            0x2::vec_set::remove<0x1::type_name::TypeName>(v0, &v1);
        };
    }

    // decompiled from Move bytecode v6
}

