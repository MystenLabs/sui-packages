module 0x5ecb75df6755448841eacd52012f5841f05565c5019f607f2abd1f16219877cc::admin {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct AuthKey has copy, drop, store {
        dummy_field: bool,
    }

    struct AuthCap has drop, store {
        dummy_field: bool,
    }

    public fun assert_app_is_authorized(arg0: &0x2::object::UID) {
        assert!(has_authorized(arg0), 13906834698329522179);
    }

    fun assert_app_is_deauthorized(arg0: &0x2::object::UID) {
        assert!(!has_authorized(arg0), 13906834719804489733);
    }

    public fun authorize(arg0: &AdminCap, arg1: &mut 0x2::object::UID) {
        assert_app_is_deauthorized(arg1);
        let v0 = AuthKey{dummy_field: false};
        let v1 = AuthCap{dummy_field: false};
        0x2::dynamic_field::add<AuthKey, AuthCap>(arg1, v0, v1);
        0x5ecb75df6755448841eacd52012f5841f05565c5019f607f2abd1f16219877cc::events::emit_authorized_app_event(arg1);
    }

    public(friend) fun create_and_transfer_admin_cap<T0: drop>(arg0: &T0, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::types::is_one_time_witness<T0>(arg0), 13906834393386713089);
        let v0 = AdminCap{id: 0x2::object::new(arg2)};
        0x2::transfer::transfer<AdminCap>(v0, arg1);
    }

    public fun deauthorize(arg0: &AdminCap, arg1: &mut 0x2::object::UID) {
        assert_app_is_authorized(arg1);
        let v0 = AuthKey{dummy_field: false};
        let AuthCap {  } = 0x2::dynamic_field::remove<AuthKey, AuthCap>(arg1, v0);
        0x5ecb75df6755448841eacd52012f5841f05565c5019f607f2abd1f16219877cc::events::emit_deauthorized_app_event(arg1);
    }

    public fun has_authorized(arg0: &0x2::object::UID) : bool {
        let v0 = AuthKey{dummy_field: false};
        0x2::dynamic_field::exists_<AuthKey>(arg0, v0)
    }

    // decompiled from Move bytecode v7
}

