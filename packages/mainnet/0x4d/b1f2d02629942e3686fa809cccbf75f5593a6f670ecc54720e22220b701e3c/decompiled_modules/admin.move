module 0x4db1f2d02629942e3686fa809cccbf75f5593a6f670ecc54720e22220b701e3c::admin {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct AuthKey has copy, drop, store {
        dummy_field: bool,
    }

    struct AuthCap has drop, store {
        dummy_field: bool,
    }

    fun assert_app_is_authorized(arg0: &0x2::object::UID) {
        assert!(has_authorized(arg0), 0);
    }

    fun assert_app_is_deauthorized(arg0: &0x2::object::UID) {
        assert!(!has_authorized(arg0), 1);
    }

    public fun authorize(arg0: &AdminCap, arg1: &mut 0x2::object::UID) {
        assert_app_is_deauthorized(arg1);
        let v0 = AuthKey{dummy_field: false};
        let v1 = AuthCap{dummy_field: false};
        0x2::dynamic_field::add<AuthKey, AuthCap>(arg1, v0, v1);
        0x4db1f2d02629942e3686fa809cccbf75f5593a6f670ecc54720e22220b701e3c::events::emit_authorized_app_event(arg1);
    }

    public(friend) fun create_admin_cap(arg0: &mut 0x2::tx_context::TxContext) : AdminCap {
        AdminCap{id: 0x2::object::new(arg0)}
    }

    public fun deauthorize(arg0: &AdminCap, arg1: &mut 0x2::object::UID) {
        assert_app_is_authorized(arg1);
        let v0 = AuthKey{dummy_field: false};
        let AuthCap {  } = 0x2::dynamic_field::remove<AuthKey, AuthCap>(arg1, v0);
        0x4db1f2d02629942e3686fa809cccbf75f5593a6f670ecc54720e22220b701e3c::events::emit_deauthorized_app_event(arg1);
    }

    public fun has_authorized(arg0: &0x2::object::UID) : bool {
        let v0 = AuthKey{dummy_field: false};
        0x2::dynamic_field::exists_<AuthKey>(arg0, v0)
    }

    // decompiled from Move bytecode v6
}

