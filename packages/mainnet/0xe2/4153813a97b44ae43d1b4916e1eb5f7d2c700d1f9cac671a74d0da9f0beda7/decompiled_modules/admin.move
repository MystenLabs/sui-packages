module 0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::admin {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct AuthKey has copy, drop, store {
        dummy_field: bool,
    }

    struct AuthCap has drop, store {
        dummy_field: bool,
    }

    public fun assert_app_is_authorized(arg0: &0x2::object::UID) {
        assert!(has_authorized(arg0), 9223372552250982403);
    }

    fun assert_app_is_deauthorized(arg0: &0x2::object::UID) {
        assert!(!has_authorized(arg0), 9223372573725949957);
    }

    public fun authorize(arg0: &AdminCap, arg1: &mut 0x2::object::UID) {
        assert_app_is_deauthorized(arg1);
        let v0 = AuthKey{dummy_field: false};
        let v1 = AuthCap{dummy_field: false};
        0x2::dynamic_field::add<AuthKey, AuthCap>(arg1, v0, v1);
        0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::events::emit_authorized_app_event(arg1);
    }

    public(friend) fun create_admin_cap<T0: drop>(arg0: &T0, arg1: &mut 0x2::tx_context::TxContext) : AdminCap {
        assert!(0x2::types::is_one_time_witness<T0>(arg0), 9223372251603140609);
        AdminCap{id: 0x2::object::new(arg1)}
    }

    public fun deauthorize(arg0: &AdminCap, arg1: &mut 0x2::object::UID) {
        assert_app_is_authorized(arg1);
        let v0 = AuthKey{dummy_field: false};
        let AuthCap {  } = 0x2::dynamic_field::remove<AuthKey, AuthCap>(arg1, v0);
        0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::events::emit_deauthorized_app_event(arg1);
    }

    public fun has_authorized(arg0: &0x2::object::UID) : bool {
        let v0 = AuthKey{dummy_field: false};
        0x2::dynamic_field::exists_<AuthKey>(arg0, v0)
    }

    // decompiled from Move bytecode v6
}

