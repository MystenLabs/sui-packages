module 0x3faafaadc061283a02ced067f8f93a929392e5e9eb328b6d56f54367f62defda::app {
    struct AdminCap has store, key {
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

    public fun add_object<T0: store>(arg0: &AdminCap, arg1: &mut GilderApp, arg2: T0) {
        let v0 = ObjectKey<T0>{dummy_field: false};
        0x2::dynamic_field::add<ObjectKey<T0>, T0>(&mut arg1.id, v0, arg2);
    }

    public(friend) fun app_object_mut<T0: drop, T1: store>(arg0: &mut GilderApp) : &mut T1 {
        assert_app_is_authorized<T0>(arg0);
        let v0 = ObjectKey<T1>{dummy_field: false};
        0x2::dynamic_field::borrow_mut<ObjectKey<T1>, T1>(&mut arg0.id, v0)
    }

    public fun assert_app_is_authorized<T0: drop>(arg0: &GilderApp) {
        assert!(is_app_authorized<T0>(arg0), 0);
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
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = GilderApp{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<GilderApp>(v1);
    }

    public fun is_app_authorized<T0: drop>(arg0: &GilderApp) : bool {
        let v0 = AppKey<T0>{dummy_field: false};
        0x2::dynamic_field::exists_<AppKey<T0>>(&arg0.id, v0)
    }

    // decompiled from Move bytecode v6
}

