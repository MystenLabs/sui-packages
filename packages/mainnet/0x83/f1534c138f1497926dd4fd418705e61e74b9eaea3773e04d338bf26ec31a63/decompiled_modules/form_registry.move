module 0x83f1534c138f1497926dd4fd418705e61e74b9eaea3773e04d338bf26ec31a63::form_registry {
    struct Form has store, key {
        id: 0x2::object::UID,
        slug: 0x1::string::String,
        owner: address,
        schema_blob_id: 0x1::string::String,
        schema_version: u64,
        admin_allowlist_id: 0x2::object::ID,
        created_at_epoch: u64,
        retired: bool,
    }

    struct FormRegistry has key {
        id: 0x2::object::UID,
        by_slug: 0x2::table::Table<0x1::string::String, 0x2::object::ID>,
        forms: 0x2::object_table::ObjectTable<0x2::object::ID, Form>,
    }

    struct RegistryOwnerCap has store, key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
    }

    public fun admin_allowlist_id(arg0: &Form) : 0x2::object::ID {
        arg0.admin_allowlist_id
    }

    public(friend) fun assert_form_active(arg0: &FormRegistry, arg1: 0x2::object::ID) {
        assert!(!0x2::object_table::borrow<0x2::object::ID, Form>(&arg0.forms, arg1).retired, 103);
    }

    public(friend) fun assert_owner_cap(arg0: &0x83f1534c138f1497926dd4fd418705e61e74b9eaea3773e04d338bf26ec31a63::admin::OwnerCap, arg1: 0x2::object::ID) {
        assert!(0x83f1534c138f1497926dd4fd418705e61e74b9eaea3773e04d338bf26ec31a63::admin::owner_cap_form_id(arg0) == arg1, 102);
    }

    public fun borrow_form(arg0: &FormRegistry, arg1: 0x2::object::ID) : &Form {
        0x2::object_table::borrow<0x2::object::ID, Form>(&arg0.forms, arg1)
    }

    public fun create_form(arg0: &mut FormRegistry, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (0x83f1534c138f1497926dd4fd418705e61e74b9eaea3773e04d338bf26ec31a63::admin::AdminCap, 0x83f1534c138f1497926dd4fd418705e61e74b9eaea3773e04d338bf26ec31a63::admin::OwnerCap) {
        assert!(!0x2::table::contains<0x1::string::String, 0x2::object::ID>(&arg0.by_slug, arg1), 100);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::object::new(arg4);
        let v2 = 0x2::object::uid_to_inner(&v1);
        let (v3, v4, v5) = 0x83f1534c138f1497926dd4fd418705e61e74b9eaea3773e04d338bf26ec31a63::admin::new_allowlist(v2, v0, arg4);
        let v6 = v4;
        let v7 = 0x83f1534c138f1497926dd4fd418705e61e74b9eaea3773e04d338bf26ec31a63::admin::allowlist_id_of_cap(&v6);
        let v8 = Form{
            id                 : v1,
            slug               : arg1,
            owner              : v0,
            schema_blob_id     : arg2,
            schema_version     : arg3,
            admin_allowlist_id : v7,
            created_at_epoch   : 0x2::tx_context::epoch(arg4),
            retired            : false,
        };
        0x2::table::add<0x1::string::String, 0x2::object::ID>(&mut arg0.by_slug, arg1, v2);
        0x2::object_table::add<0x2::object::ID, Form>(&mut arg0.forms, v2, v8);
        0x83f1534c138f1497926dd4fd418705e61e74b9eaea3773e04d338bf26ec31a63::admin::share_allowlist(v3);
        0x83f1534c138f1497926dd4fd418705e61e74b9eaea3773e04d338bf26ec31a63::events::emit_form_created(v2, arg1, v0, arg2, arg3, v7, 0x2::tx_context::epoch(arg4));
        (v6, v5)
    }

    public fun form_id_for_slug(arg0: &FormRegistry, arg1: 0x1::string::String) : 0x2::object::ID {
        assert!(0x2::table::contains<0x1::string::String, 0x2::object::ID>(&arg0.by_slug, arg1), 101);
        *0x2::table::borrow<0x1::string::String, 0x2::object::ID>(&arg0.by_slug, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = FormRegistry{
            id      : 0x2::object::new(arg0),
            by_slug : 0x2::table::new<0x1::string::String, 0x2::object::ID>(arg0),
            forms   : 0x2::object_table::new<0x2::object::ID, Form>(arg0),
        };
        let v1 = RegistryOwnerCap{
            id          : 0x2::object::new(arg0),
            registry_id : 0x2::object::id<FormRegistry>(&v0),
        };
        0x2::transfer::share_object<FormRegistry>(v0);
        0x2::transfer::transfer<RegistryOwnerCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_retired(arg0: &Form) : bool {
        arg0.retired
    }

    public fun owner(arg0: &Form) : address {
        arg0.owner
    }

    public fun retire(arg0: &mut FormRegistry, arg1: &0x83f1534c138f1497926dd4fd418705e61e74b9eaea3773e04d338bf26ec31a63::admin::OwnerCap, arg2: 0x2::object::ID, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::object_table::borrow_mut<0x2::object::ID, Form>(&mut arg0.forms, arg2);
        assert!(0x83f1534c138f1497926dd4fd418705e61e74b9eaea3773e04d338bf26ec31a63::admin::owner_cap_form_id(arg1) == arg2, 102);
        assert!(!v0.retired, 103);
        v0.retired = true;
        0x83f1534c138f1497926dd4fd418705e61e74b9eaea3773e04d338bf26ec31a63::events::emit_form_retired(arg2, 0x2::tx_context::epoch(arg3));
    }

    public fun schema_blob_id(arg0: &Form) : 0x1::string::String {
        arg0.schema_blob_id
    }

    public fun schema_version(arg0: &Form) : u64 {
        arg0.schema_version
    }

    public fun slug(arg0: &Form) : 0x1::string::String {
        arg0.slug
    }

    public(friend) fun touch_allowlist(arg0: &Form, arg1: &0x83f1534c138f1497926dd4fd418705e61e74b9eaea3773e04d338bf26ec31a63::admin::AdminAllowlist) {
    }

    public fun update_schema(arg0: &mut FormRegistry, arg1: &0x83f1534c138f1497926dd4fd418705e61e74b9eaea3773e04d338bf26ec31a63::admin::OwnerCap, arg2: 0x2::object::ID, arg3: 0x1::string::String, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        let v0 = 0x2::object_table::borrow_mut<0x2::object::ID, Form>(&mut arg0.forms, arg2);
        assert!(0x83f1534c138f1497926dd4fd418705e61e74b9eaea3773e04d338bf26ec31a63::admin::owner_cap_form_id(arg1) == arg2, 102);
        assert!(!v0.retired, 103);
        v0.schema_blob_id = arg3;
        v0.schema_version = arg4;
        0x83f1534c138f1497926dd4fd418705e61e74b9eaea3773e04d338bf26ec31a63::events::emit_form_updated(arg2, arg3, arg4, 0x2::tx_context::epoch(arg5));
    }

    // decompiled from Move bytecode v7
}

