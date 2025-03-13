module 0x997a2db9d4e6352f3776011dc010c5858e28f2741cf1c8fe11e301482d6106f9::app {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct GilderAdmins has store, key {
        id: 0x2::object::UID,
    }

    struct GilderApp has key {
        id: 0x2::object::UID,
    }

    struct ObjectKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct AppKey<phantom T0: drop> has copy, drop, store {
        dummy_field: bool,
    }

    public fun object<T0: store>(arg0: &GilderApp) : &T0 {
        let v0 = ObjectKey<T0>{dummy_field: false};
        0x2::dynamic_field::borrow<ObjectKey<T0>, T0>(&arg0.id, v0)
    }

    public fun add_admin(arg0: &AdminCap, arg1: &mut GilderApp, arg2: address) {
        0x2::dynamic_field::add<address, bool>(&mut key_object_mut<GilderAdmins>(arg1).id, arg2, true);
    }

    public fun add_key_object<T0: store + key>(arg0: &AdminCap, arg1: &mut GilderApp, arg2: T0) {
        let v0 = ObjectKey<T0>{dummy_field: false};
        0x2::dynamic_object_field::add<ObjectKey<T0>, T0>(&mut arg1.id, v0, arg2);
    }

    public fun add_object<T0: store>(arg0: &AdminCap, arg1: &mut GilderApp, arg2: T0) {
        let v0 = ObjectKey<T0>{dummy_field: false};
        0x2::dynamic_field::add<ObjectKey<T0>, T0>(&mut arg1.id, v0, arg2);
    }

    public(friend) fun app_key_object_mut<T0: drop, T1: store + key>(arg0: &mut GilderApp) : &mut T1 {
        assert_app_is_authorized<T0>(arg0);
        let v0 = ObjectKey<T1>{dummy_field: false};
        0x2::dynamic_object_field::borrow_mut<ObjectKey<T1>, T1>(&mut arg0.id, v0)
    }

    public(friend) fun app_object_mut<T0: drop, T1: store>(arg0: &mut GilderApp) : &mut T1 {
        assert_app_is_authorized<T0>(arg0);
        let v0 = ObjectKey<T1>{dummy_field: false};
        0x2::dynamic_field::borrow_mut<ObjectKey<T1>, T1>(&mut arg0.id, v0)
    }

    public fun assert_app_is_authorized<T0: drop>(arg0: &GilderApp) {
        assert!(is_app_authorized<T0>(arg0), 0);
    }

    public fun assert_is_gilder_admin(arg0: &GilderApp, arg1: address) {
        assert!(is_gilder_admin(arg0, arg1), 1);
    }

    public fun authorize_app<T0: drop>(arg0: &AdminCap, arg1: &mut GilderApp) {
        let v0 = AppKey<T0>{dummy_field: false};
        0x2::dynamic_field::add<AppKey<T0>, bool>(&mut arg1.id, v0, true);
    }

    public fun deauthorize_app<T0: drop>(arg0: &AdminCap, arg1: &mut GilderApp) : bool {
        let v0 = AppKey<T0>{dummy_field: false};
        0x2::dynamic_field::remove<AppKey<T0>, bool>(&mut arg1.id, v0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = GilderApp{id: 0x2::object::new(arg0)};
        let v2 = GilderAdmins{id: 0x2::object::new(arg0)};
        let v3 = &mut v1;
        add_key_object<GilderAdmins>(&v0, v3, v2);
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<GilderApp>(v1);
    }

    public fun is_app_authorized<T0: drop>(arg0: &GilderApp) : bool {
        let v0 = AppKey<T0>{dummy_field: false};
        0x2::dynamic_field::exists_<AppKey<T0>>(&arg0.id, v0)
    }

    public fun is_gilder_admin(arg0: &GilderApp, arg1: address) : bool {
        0x2::dynamic_field::exists_<address>(&key_object<GilderAdmins>(arg0).id, arg1)
    }

    public fun key_object<T0: store + key>(arg0: &GilderApp) : &T0 {
        let v0 = ObjectKey<T0>{dummy_field: false};
        0x2::dynamic_object_field::borrow<ObjectKey<T0>, T0>(&arg0.id, v0)
    }

    fun key_object_mut<T0: store + key>(arg0: &mut GilderApp) : &mut T0 {
        let v0 = ObjectKey<T0>{dummy_field: false};
        0x2::dynamic_object_field::borrow_mut<ObjectKey<T0>, T0>(&mut arg0.id, v0)
    }

    public fun remove_admin(arg0: &AdminCap, arg1: &mut GilderApp, arg2: address) {
        0x2::dynamic_field::remove<address, bool>(&mut key_object_mut<GilderAdmins>(arg1).id, arg2);
    }

    // decompiled from Move bytecode v6
}

